Return-Path: <netdev+bounces-295578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dubbLLEtImoVTgEAu9opvQ
	(envelope-from <netdev+bounces-295578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:00:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C453644908
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:00:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aCS1C+CJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2F2E301178A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083193B7B90;
	Fri,  5 Jun 2026 02:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FE3E5579
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624815; cv=none; b=eORqchownDnu1ep01AdtnZJDiK/JaMY5B+YMDmfHwc4CqD7f94GX9Q+PP/JlwxHldGiGlk39Hb6O/PQLFPMzoSBFXUov0twZvOaoD6ldIKT9x8/pbjZg/CaQz6HB8uNOqCZlJjSKrOWdU7Ax4hI/Um/sBoCichRPL0CGgh5croM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624815; c=relaxed/simple;
	bh=ss1ywXqjsmSAi7uD5PJBn41iMdY1aZ1nJ3qy5KiCXhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okPmu/+UtZOHX5Id3zAd37RGtnmJd0a5uw4a+hNmttdE2NMmR98YgfwYYqrcSU7WLBylTazilE6v1oMcgd8yc+t8A2Sa1KHE+lgt/e6iKnQ/8qm3m5tcdtMxCVOx3CF5x6hMwEGBOPoP9JGzc5WFEv9KdJ/46Oh81e1btX7I96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCS1C+CJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359311F00893;
	Fri,  5 Jun 2026 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624808;
	bh=NIyPxTzROnCNESKTQw/mwGt7BhjOTUOMrIEwbzGP/PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aCS1C+CJn9ze3DRN0VOPuu5kMClzyzdS8xmbj1B1vDFJpEtzogoQFXoUKiGCYBthL
	 wmPbV5h9FKSF/gvvLPDSu3bQn0xb0sSw3vV3bt/D9FidLN7dapCZJ6dwgoIeSLASBS
	 yJuUv/On8WreMjuLfviTAX74w16yEijrKqbDq4iGKropCV0VwcBPCJnRzlnUDicfJy
	 LiDDZo5oSqE7nL2m/yCgUsf3JLjdIoGJm+hv4L1s5Re4SkFGTG8pFzl9oYrwEh+vsY
	 RsXGV/9PhzikDouIksu//bUydMXnQoE6yMMxO9KuSsrty2jdsTJs8O7YooR4KcOSbC
	 hesk7o6mHzX7Q==
Date: Thu, 4 Jun 2026 19:00:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <20260604190007.77a01a0d@kernel.org>
In-Reply-To: <20260603223535.2504695-3-sdf@fomichev.me>
References: <20260603223535.2504695-1-sdf@fomichev.me>
	<20260603223535.2504695-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295578-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C453644908

On Wed,  3 Jun 2026 15:35:34 -0700 Stanislav Fomichev wrote:
> When ndo_set_rx_mode_async returns an error, schedule a retry with
> exponential backoff (1s, 2s, 4s, 8s -- 15s total). Give up after the
> 4th retry and log an error via netdev_err().

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

