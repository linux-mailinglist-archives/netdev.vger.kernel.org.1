Return-Path: <netdev+bounces-301642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hbMKDm/UO2p1dwgAu9opvQ
	(envelope-from <netdev+bounces-301642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 879CE6BE547
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:58:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l+ZHxSxQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301642-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755353007362
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B53B0AC7;
	Wed, 24 Jun 2026 12:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346E199EAD
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:56:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305795; cv=pass; b=rSugbKVBiH7WELh6wHVnR0rGZi0k0s63eWuVWoSCDUnjwYslfiSj4ED+lT71pzP+F/v8DwFoMVv2PerJIgI1t6ke0GcgN44ckIYcUkQuAVPNiboKL0pTWCVXwWilD8J420s7SndWaWMkqExKZTkrw75mEliId8c413/XoMnEkAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305795; c=relaxed/simple;
	bh=rE72onZAaewUaYsLPB/EuFRGj8uanPU6OeZhfBSRDss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYFOlaoQHYX/IyqRS9HINxuiBrry4zKXRYuQlJ3yG2ugnFkKALdZ57zZjfBQ2kwcOHWQPyb/mNsCnU05WR2f9Rlh1GnlnW7HZuj//m9xhnnV3V1p1jwXIVR0Wjxv0XFSELqeJHcHM+NJC7npgF4vd5QAnGYk3PdSul0jC/kHlG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+ZHxSxQ; arc=pass smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so6520375e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305793; cv=none;
        d=google.com; s=arc-20240605;
        b=hpiHC+5CUhvid0DEgNicig/Ist5IguUtrjOvSD2l24shYbnSXc/DLm7JoGty9OFjA4
         oHjQ2l1wu+5CoAZ7LO1oHmFJduKvcEEvBHwmIQQBsArxGf6jGSEmwhk0luoE0w5aSisB
         kP07o9qewPluVMo1ekJ0pxHayCkLmKIWdpb2jS6woYfDLWNPJAfkv3oOhIop764X6mHS
         1SD/TaNmuXLTMCGyxo7o6Sdk83EvzdVTl1NH0WS1eqIV/bqNLCKC4fp+yBBKo+yejpnt
         G/WUsVhnznIYQxhGSt7tQHBHsadzMEJjAHINbMUph1EOjeqzjHYKVW6Oxihvkap5NQlc
         rC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rE72onZAaewUaYsLPB/EuFRGj8uanPU6OeZhfBSRDss=;
        fh=YN0dys9NVEVRwT3PKjYtK7yv6VcsVk9AjzMqBnI7NbY=;
        b=YXkStCMZTpZV5BOqhY7DY0wS9ckTE8+4QqncxMq82LGhOfdH+e8GCAiZ/B5b2bHZLi
         aUKv0BYW33NzN0V5ZENipEQSsnz14o8ZJwprrvQMskdkjqy2ErY68XrKkHyB2hXjtSva
         2sIefN+Bn1sYnU08f4lqIjmhPiiLHn7RgXpN5hlRAiwrXtWCLKcSctaT7P9WKdyiedWE
         EBNcz7fyoI717dmGe9zWGJKJ+IJYbi8ABSjHkoIc+zs4tqeQ3mmBwCaqhBQ3dRRo8IJA
         vzy/HR4PrHFPqVUSuyg49bteX3yn3/Sk/lSHXGkeQXjmeunzcZbjrP1RTUdpBNXvwjpU
         Xv8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782305793; x=1782910593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rE72onZAaewUaYsLPB/EuFRGj8uanPU6OeZhfBSRDss=;
        b=l+ZHxSxQu2I94JZluAgjgln6+dtWYaXE42gxQwPlbdhJ/W1Us0YxibzUq1ehB8YoxI
         UuTjPAsMwXIA5VqVxEpuQUSuZsNrHVaXr247h7qG2T1x7hVpI7GxYc+VRt6oTeF5/GWN
         qYMoq5WH87TsX5FIxPQi2rWaoemxpO6IA95IAozC7LoBZcIpNNy5VMW+keX5zfPjZy4J
         X7iCCSwiupe17peIEMHSKGfZ7VJ/MQIJQEWJnvgtoI74yHtTG5gAES1KIQpxZ9ZLEH3b
         Ck0arfl79ztaKCuKq+3r30ffpNggz3K8oQkz36h0colL2AjJgEMfwnYb0AXkLs7lUyJT
         w4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305793; x=1782910593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE72onZAaewUaYsLPB/EuFRGj8uanPU6OeZhfBSRDss=;
        b=ZtxVmArge7w5cOHcFHdad744hlU/7Bre+fB5n5mUFYlnyvFu/rw7BPYUhEKuJCNWvS
         ebzrtp+SjjSb/3LbS/bWfLzNbEpEiZgrmrH46Mt9WHmO5rGttATa/f8H1yvrcsb4zUKT
         RMQMaeCt/tG1BpKsG6IpeBrhV0thE1/UvO0KCWdkeNt6Leoae/ALU6lJhigb6lClTKVL
         6gVVVPeGWJSBQyNtfzbHPrKqz/UQJzEiOBMDGRo5TKKcjIgsZzW68u3rdxsdZKj3GZnS
         VPurNRX30mWCkdq5yfMxtb7zVf7ZF7zBUU/pYrBLgpQNDb3jtcHe8wTsTy0JQ8tv8laT
         T85Q==
X-Forwarded-Encrypted: i=1; AFNElJ88JoloBNC2jWwVCTKqep1PzWTvMbKAFVtBciA/foPH0cCrnJFTkGQnS/wM5treMlbAx30rgoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyReYwi8Khq4HPmYIhsjwCiP7ft8dItgdXsfcdG6JYYVgyLaU
	tNB1nshAn9x3/ETo5zaCmsFMzpXU4fYk+ZY0yBxx/AFv87Vmhbm16P1ZTmCRm7KE7nEBniDg3mQ
	DvsKiJbAiICPNrLf7obg9RZyBkgvix2f/kMPqqm8=
X-Gm-Gg: AfdE7cmJ5ki+OXrjjDh/ZxooMCx0/21066QdsirNx60Df1+1nM4DTKtuFL3GNsi8AZi
	73vxiJGVVABA//D7SMncJhaS86nXziOnpbe9dmJ0KZFsEjQF6fzWE+O7BKRRjRR8VAXtzIWpqap
	LU00BnUyFQsNGFQy0Cks1Y1oECa+GGYl2bjinKwCqCLspvNx35MTgteV4LVoVOO+oRv36nnzaBY
	7/P4wPo2NRRjMtzVPfB9UxkihHxu0ZSobMITWgZwJvxiVa5BDwdjhxrcgZ9V297PelxJFNCItYI
	JjWyQcxdB9CkDeBp3iSfKXhTTdeo/tk0l6JiWQ==
X-Received: by 2002:a05:600c:8b66:b0:492:4c5d:4db3 with SMTP id
 5b1f17b1804b1-4926084a9afmr44666165e9.5.1782305792607; Wed, 24 Jun 2026
 05:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614054137.32181-1-atharvapotdar07@gmail.com>
 <20260614220934.GA3575431@electric-eye.fr.zoreil.com> <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
 <20260617222522.GA3712043@electric-eye.fr.zoreil.com>
In-Reply-To: <20260617222522.GA3712043@electric-eye.fr.zoreil.com>
From: Atharva Potdar <atharvapotdar07@gmail.com>
Date: Wed, 24 Jun 2026 18:26:20 +0530
X-Gm-Features: AVVi8CeiCiUD3JlzQQfBpKCKT0K2ht2-vitCZjFER1vekJT3oHocz7R0DzByvDk
Message-ID: <CAF9AHvYWY0Byhf9zVH05tOJGJG0LDddsM6bC+J43A1Kbb==EBg@mail.gmail.com>
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301642-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:romieu@fr.zoreil.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 879CE6BE547

Hi Francois, Heiner,

Francois:
> Old chipsets did not correctly implement receive buffer size limit.

I understand how lowering the buffer size will reintroduce this bug.
Thank you for showing me this patch.

Heiner:
> Is XDP in general not supported with bigger jumbo packets?
> You should find a way to avoid the regression. Intentionally introducing
> a regression I don't think is acceptable.

In v2, I'll revert R8169_RX_BUF_SIZE to (SZ_16K - 1). I'll set up
page_pool to allocate higher-order pages with get_order(SZ_16K)
instead of limiting it to order-0 pages. This will match the old
behaviour and avoid the MTU regression while still ensuring our
migration to page_pool.

> It's not only about ARM, I'm aware of at least loongarch systems with
> such Realtek NICs.

To make sure that this is safe across architectures, v2 will rely
entirely on PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV so the page_pool
core handles the DMA mapping properly.

I will test v2 locally and send it out soon.

Thanks,
Atharva

