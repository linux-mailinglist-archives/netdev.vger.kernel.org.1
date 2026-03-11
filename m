Return-Path: <netdev+bounces-266394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LLSA8W1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E43259B61
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC3E3185863
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400632AADA;
	Wed, 11 Mar 2026 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyKWni0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F113325491;
	Wed, 11 Mar 2026 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188510; cv=none; b=t92KexQ0lEEx+FuOXO9wg2yS2v7G86P8LvbSEHCqLdQ1oYEGzPmmtI2fdH0lE2N6Sbc/3CojAV2bE8KvpLAp9RCEBOfit+hArOtkTkVzC1GyD6/5+80V5ix/Lx+liSQs+g8WbB2GWRYtzWySvgTdklLrlBTFkJlu2A51hXM4h3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188510; c=relaxed/simple;
	bh=JZ1MupmgP5MlyQ17bumvQ8kuB33cvaR/2S7m0iYGFq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6OR2h84Adh1SUuwTOtRqVnIWNAJJyMmAyCUSljTwXISABIpCqVu0Yw/98UKzY8O1wRvr5juM9A23NGbvZ006iv/NmU9wpdndIk3UiHZooOjX9ELSEkvdOgYzVeDeqsROEOyTH7zBg4FMxNs+pzKNs/aanmGv3HPQV+uDhE7mFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyKWni0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E35C2BC87;
	Wed, 11 Mar 2026 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188509;
	bh=JZ1MupmgP5MlyQ17bumvQ8kuB33cvaR/2S7m0iYGFq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VyKWni0xwhMlKVxWt6yF+H/Efit0Qo3drviI3YYg41MMGKNBmpnhGSIMF8vjPWMro
	 zw7mTvDI92vtI5N2PEIbK171+yhO/rS6qHun4F24huF5/M0LK2xIzI2fh1u40j+Au3
	 arhtMHW4n7BW2CopvdR8a6hXtrxxJsgMPtnzLOj2OjFtHLICFgWSHJCa4kDyO4l5VO
	 4fE0xkcVJbpdtwg2g9BwVCSK6NcaLX6cuPB89jg06HVKaQjMwf+70WoMqVOIrYTsLz
	 97A2BqSI2MY1ckn19zmflrz7Xip//GSL6KcBABp4Y2Nqag9E8fg2qDQOuAADoKCHdi
	 xsk2wKwEDqlVA==
Date: Tue, 10 Mar 2026 17:21:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 0/3] ethtool: Dynamic RSS context
 indirection table resizing
Message-ID: <20260310172148.2e22e3d7@kernel.org>
In-Reply-To: <20260308131218.3172332-1-bjorn@kernel.org>
References: <20260308131218.3172332-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A4E43259B61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  8 Mar 2026 14:12:14 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> the queue count, because the hardware table is a shared resource. The
> ethtool core locks ctx->indir_size at context creation, so drivers
> have to reject channel changes when RSS contexts exist.

This will conflict with Michael's fix so please rebase & repost
as soon as we merge net into net-next on Thrusday.
--=20
pw-bot: cr

