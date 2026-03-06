Return-Path: <netdev+bounces-264635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI5kF4JEqmlxOQEAu9opvQ
	(envelope-from <netdev+bounces-264635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:05:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7821ADAA
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C59302F415
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F8367F2B;
	Fri,  6 Mar 2026 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJGVKdT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B71D5141;
	Fri,  6 Mar 2026 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766320; cv=none; b=iQwq1VuWN90iPgWXylko+eUuUYe1JlazK4QjGw5R61R8aMLfBI8vc+kgZmoxfLqGkAydCAk7nz/yBF0AdCFjYylHhN35C77wUxaojDq+vjYK2Lg4hAPAHETglqLaVoQrzM7ATurXmm5cMrvLYj1f8iJgcFPcKryQC63aGt3xm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766320; c=relaxed/simple;
	bh=H8L6ZEad7WGRIzCLFVbmdG3T2DyNrEqX3CcywGBEtQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlkDM16gyPnVLCVn5X2zyPPM+CMNwrral7tvSiDrSwpswr5+KJnes17snApsqeYdEu7JOj11Q8mS2PN6bHwXCFNOg+B5ZwiVM++piYzDisOs0kAREi144As1oQ+AfMWRyj8S7UMaM/ZEw7CThUoYTq1BmY/7Y8+cYDnZIAC4MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJGVKdT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5287CC116C6;
	Fri,  6 Mar 2026 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772766319;
	bh=H8L6ZEad7WGRIzCLFVbmdG3T2DyNrEqX3CcywGBEtQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJGVKdT5SUiYMQjCSLQJYulsHii1yGmoLfvNG0Syd652KtvtL/dckAUu4l6MQZu15
	 YHP1H4cvZSxoc7vvYRmj5kcm8TdpSY8xmtIaBEE2MN+Dj51EjTRi+u0N1JqzVZYYjo
	 doVLFie+iaiKeej+q2vgmaawFJMuh0b8ScaB6MmpRyM066Hk7Qy4ebGljgCJLupFLy
	 fQExyfAA5tR+On/tyQRHUk3YX0g7LV86/XgJ6dmDaT3qv4HvdxGNcWspyQ7tp29dH9
	 5M0gyhi2ODo7D4no+9kRYHbq8H//Dlh3Izneiik6RDBeDuwGUeoqvaRN7j+WDfMvoD
	 nzgRL2myjnvRQ==
Date: Thu, 5 Mar 2026 19:05:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 2/3] bnxt_en: Resize RSS contexts on channel
 count change
Message-ID: <20260305190518.4dce9ccc@kernel.org>
In-Reply-To: <20260304131855.3225539-3-bjorn@kernel.org>
References: <20260304131855.3225539-1-bjorn@kernel.org>
	<20260304131855.3225539-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 17A7821ADAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264635-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 14:18:52 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +		if (netif_is_rxfh_configured(dev) &&
> +		    ethtool_rxfh_can_resize(bp->rss_indir_tbl,
> +					    old_tbl_size, new_tbl_size)) {

Doesn't this read a little odd? Shouldn't ethtool_rxfh_can_resize()
return true when ... we can resize? You end up ignoring the real rc
here, and it can only ever be -EINVAL.

> +			netdev_warn(dev, "RSS table resize not possible\n");
> +			return -EINVAL;
> +		}

