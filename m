Return-Path: <netdev+bounces-289244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNuUHti+C2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:37:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D433D5761FA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DD730151FA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402032EAD1C;
	Tue, 19 May 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ5HZpFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E72283FC8;
	Tue, 19 May 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154614; cv=none; b=oJV6m3j4LO51F1YEDkHBWiRiGcRkJifbfD+lpqAQhg7mOJJrrGCdX74fW5Xr9OQCcWdpVBM9DC/4KFSHGW08mnXbA4VoPcLxXfPeZszC7jjcFZ2rA/jw6zOlU5CTMOgf+XJjsBN3H6OkCgGLQTQWVZmIOeXs+1krrfEvPT4FDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154614; c=relaxed/simple;
	bh=/YR7q8Izn2ZXYdJF2wo7gAHJlC3sxOoAsxQutxSdf6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFmcEHlTupS75NypcET/cl5YZMFq8ZITb1rMPONfXhNyqJvBPZwn1E4plnve88t3JCbaRjNeQos6cL17YYQeRc/2mE5QI1ORc/3Asy1s97WCcSj2ZhcWAOMURR2wVl2xsA7Cf07YI0ELKpLi1/ZX0ZUjGnu+HOQ7dBGIuqMl2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ5HZpFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB0BC2BCB7;
	Tue, 19 May 2026 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779154613;
	bh=/YR7q8Izn2ZXYdJF2wo7gAHJlC3sxOoAsxQutxSdf6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PQ5HZpFOlrGYJuy+cDB9PyfeVfxDxakACDR8lx2tJZmelrg5q8sL0ZjokhcLca+sT
	 ZMSq7MeQOs/u/9WlLJR8lhHAMXshiNn6tS3NlQiwvLQAt051T3O3j+JKrczDGDDBIF
	 TGRa2jSU3AM2bM8QrXCOtajJwH+kZglCTy2YZdr56MFDI5oPFv3EUGY6UITFPItZSz
	 GeanV0vybDIuPXwt8bqX9KdcfQiLlUX8V7h2ClIZ4PuXyEf4e9lRTc7hHov3JdEXwV
	 eX5qqD/Vv86nG35ap8zNQIJCUfgHTFNPPvIhcTyujVISDE3Uc9j9PZDwdz8WLNqj0f
	 t8NJCtanetPfg==
Date: Mon, 18 May 2026 18:36:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v7 04/10] enic: add admin CQ service with MSI-X
 interrupt and NAPI polling
Message-ID: <20260518183652.388a60b1@kernel.org>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-4-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
	<20260513-enic-sriov-v2-admin-channel-v2-v7-4-68b9f4141f4c@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289244-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D433D5761FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026 08:15:41 -0700 Satish Kharat wrote:
> @@ -296,6 +296,14 @@ struct enic {
>  	struct vnic_rq admin_rq;
>  	struct vnic_cq admin_cq[2];
>  	struct vnic_intr admin_intr;
> +	struct napi_struct admin_napi;

please do not use NAPI for FW communication channels
NAPI is for packet processing, you can use a work/tasklet
for what you're doing

> +	unsigned int admin_intr_index;
> +	struct work_struct admin_msg_work;
> +	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
> +	struct list_head admin_msg_list;
> +	u64 admin_msg_drop_cnt;
> +	void (*admin_rq_handler)(struct enic *enic, void *buf,
> +				 unsigned int len);
>  };

> +unsigned int enic_admin_wq_cq_service(struct enic *enic)
> +{
> +	struct vnic_cq *cq = &enic->admin_cq[0];
> +	unsigned int work = 0;
> +	void *desc;
> +
> +	desc = vnic_cq_to_clean(cq);
> +	while (enic_admin_cq_color(desc, cq->ring.desc_size) !=
> +	       cq->last_color) {
> +		/* Ensure color bit is read before descriptor fields */
> +		rmb();

AI review points out that this barrier is pointless or the comment
is wrong - nothing reads desc in the loop after this point.

> +		vnic_cq_inc_to_clean(cq);
> +		work++;
> +		desc = vnic_cq_to_clean(cq);
> +	}
> +
> +	return work;
-- 
pw-bot: cr

