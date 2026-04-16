Return-Path: <netdev+bounces-279016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHhiGqDK4GmFmAAAu9opvQ
	(envelope-from <netdev+bounces-279016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D761E40D86B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DBF1305D14D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADD3815F8;
	Thu, 16 Apr 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1/22gGF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx/g9tNB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27C39A05C
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339378; cv=none; b=OMLbDks8EY/alyIGQl+gD6RqY18tkrupYdOuDhweP010ofJUfc7cqqfTJPcvxrIDa/FGbGpM5KgZWdoTlW/5d9Ld2SWpdEI7tE+G92xq4pcJQcOP+tOvhLf2LkGZvK1tQLd+7NoFoAujKswBlPf0wFk+LDkxYJque2Ea+fmVHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339378; c=relaxed/simple;
	bh=ATPXPRSUwMhlt8ECwRArkbXzpHSbMy5MlkubYNi7w9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IreRV75HcYthUNTBnsnWYUB/D50drqc0RWFyCZvJpppdx//1GtGAeZAfUVaW94ajjz+tt2ZKn0cq4RIdszqoT2PBm3dFyujt4Mo/DlL4lULNdKyfQ0UKSwzEBoxcnuie2XuRzSZSVNsHBCQeOwogKXy9ElNdXcbyMiRKTP/1rEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1/22gGF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx/g9tNB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776339376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwhKAmoYjds9QSiVSsV9iNgED3v7mL/c4iVZV29Op3E=;
	b=L1/22gGF6nPVw1e/mCWysQeTHGeqV++uZ0EALF2ysOnkVKi/1AMUMVYKO3eFcbFpaK1ZHb
	RLiBLcG5TuvHIisTnqUntAnxpgGkZcXqEd8+hndxj2fTW0lNxn8n5pRIGhY2e2WpfqU4uZ
	Muk7WLzD1iMFPcgWNGtc9bmTqweHsCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-KQo-Tn5oNXabYMRSmX5YBQ-1; Thu, 16 Apr 2026 07:36:14 -0400
X-MC-Unique: KQo-Tn5oNXabYMRSmX5YBQ-1
X-Mimecast-MFC-AGG-ID: KQo-Tn5oNXabYMRSmX5YBQ_1776339373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so51188225e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776339373; x=1776944173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwhKAmoYjds9QSiVSsV9iNgED3v7mL/c4iVZV29Op3E=;
        b=Jx/g9tNBMqQi/0CCFeq0Cu0mvKaxMyk6pS9vZlHJEoSG0PDbMimi3OuNdFpwiq+4C0
         lrAqsndP3gbbpCkhKRAeFk+BPtTt5dSZAK28niw6t5g/DVW6bDUIq7mSPkJ7OlZkMeur
         sN8yQzjBzVpFBebIMUMHA0iGBRbHf4YvT66VaECDkWBrqOvq23V6obS5miZLbQjwcRzV
         MNHwjEIcwvQBjCnSpJ6p2LBOuMm1tvD52vdpVRcl4bP4q+s82ZpNNR8lzcVPCOGcTNGm
         Bp9n6C/rnaZ7qhQcnk5VPH+qwArUZxE8yIM+a1dPp6sctLNFzvUiMF6Xhs2uA1mDPIel
         bAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339373; x=1776944173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwhKAmoYjds9QSiVSsV9iNgED3v7mL/c4iVZV29Op3E=;
        b=c4Y/jeDEM/Nk/z6xp+47suOURQPrjbvJHNCT4HS57UV3tKLiuYgF11Q6hpcd+OQt/9
         9+5bh8Xev/YjQhidgWyZRgzDosZKktQxjlOc5/BKzYCGFeUTnU/2N2dqPqzRGkLhp4EJ
         Cvh56eaIPWjDc5EH05lrsxVW/HwPQe+KGerNrFp99XFY+up1TZAkGMx3uQJAnpzyk+vB
         Y2WnqzGEdqk8vQNFHKkkukRtyA7Un6fEJAYXFkBtUdPQM1BJo6Wt3MzriKy8u52OxDnI
         K+ZCuDk7A3+fFOUn3LOn+XUvTP0BKfHadE2J5CSdhEH4NS/qw/jiOJ4YnDvoDVAnPhWt
         CjgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7d25fFvI5L2wcV7jjv57EEdzAc79iGEn2UUlAgDrOGr4ydfCzhVgfYQlJRn6Ebxw6B2O6qmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZSDMNYeNJ7eQU9oRvbXBYZw/j8mtpuS/O6vx+ns+KMvl3pcD
	zOu9518fDrVZmkQFaK0K2gVxBejgMKr33VRKzK63IbkNPf5vyggfxSZZ89QLANF864KpUVzmZXt
	T+M10uqhlTWW0z1EBnWunBRDtzUb6hqGAmlbk+KI3ywMPN5fWhetclnEAvQ==
X-Gm-Gg: AeBDiesK9yO8dffmMvauYPyZiHhKgsS5k5dtpC8NqclFNRBG4jpTJ/bnemtGtWWRXHS
	XgpoajaGlKTg0biVI1xUORWe1h+T2EvtGUW5HC5Jy2Fz9dx1TwUu4aaI9xX9viT/CH1TewmYiY0
	JTkjC0aeAa7nmoNxd6+yimg0r16x+2/PkRgsldYO8S3XZXi9ubCtT7KZXysoeIoDlyv+Jg4dIRQ
	xjZPzfgVai+g0TQKaoL0UvIr9QoPN/UIwuwWmfvoKbdbmeJFmT1rTRF3AT8vtZHJ0bviwpKORca
	CFPNYG9nRF7mZm+aCMs/dX/NRk1F2uZ4oOM+q1GNeNPs548tf/rg4tP2nOEzceB0dCf5uszFPAJ
	c9ADx+zVOLXqDhmwxqrtjZIIyJ2vgvKF3YyIoZ7O/OBQN96qi5b03eEAxREkkcjsiMZ4=
X-Received: by 2002:a05:600c:5249:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-488d67fcf67mr326261735e9.12.1776339373369;
        Thu, 16 Apr 2026 04:36:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-488d67fcf67mr326261255e9.12.1776339372865;
        Thu, 16 Apr 2026 04:36:12 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f582368dsm56423145e9.11.2026.04.16.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:36:12 -0700 (PDT)
Message-ID: <46239684-3c91-42d9-b7e1-5d90c3169053@redhat.com>
Date: Thu, 16 Apr 2026 13:36:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 14/14] netfilter: nf_tables: add hook transactions for
 device deletions
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
References: <20260416013101.221555-1-pablo@netfilter.org>
 <20260416013101.221555-15-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416013101.221555-15-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279016-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D761E40D86B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 3:31 AM, Pablo Neira Ayuso wrote:
> @@ -10920,9 +11007,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
>  				nf_tables_chain_notify(&ctx, NFT_MSG_DELCHAIN,
>  						       &nft_trans_chain_hooks(trans));

AI notes that nf_tables_chain_notify() can now receive struct
nft_trans_hook arguments and it ends up calling nft_dump_basechain_hook
which expects nft_hook, possibly causing out-of-bounds slab read when
accessing hook->ifname.

It looks real to me. Possibly worthy strip this patch from the PR?

/P


