Return-Path: <netdev+bounces-202096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00911AEC37C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F2B3A3BBE
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A255E69;
	Sat, 28 Jun 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2rooSrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A73B7A8
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069712; cv=none; b=oBDb6SpG6HbKOePWzaE39UEPk2/SHORqfZ5hY5ubl7DVE2xnuMit0JYfkrAihpkpNFZwRlpIszoVkJ5B0+o9bw+9urudUTtmb5cb7mtFNneyAbau2GC1cw8KdeYeXfAZgVGad7OlKGdBDitndTE2r93w0gAVg9laL5JbAkIpyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069712; c=relaxed/simple;
	bh=rnkHRLHprS9+bUHH9wYeR613D8bA7SsqKSDzu8+clSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWJNgtG/9WuA6FnevCUwuZUUJxZ5ei57yZfG1DoHAaZRSRFRUyN03/ev2jgsyzLV34ZV/MliT20mct3Al2zEn7FNc6qIaMA+5vJuu1kiAvqNr7/Q8zi3CEcmkTUxTXYGu+e03b3GUIhU/lEyG2Xi8Zxmhf32qSzoVBfHFpjXFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2rooSrf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234f17910d8so24911805ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751069710; x=1751674510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/cnX41RaEPSZcQQl/08oRTNXTR1N3nUSP/JWUigEyE=;
        b=N2rooSrfKbwWR7155MTp4mVJJQj0WzgddI/q9i0vxvsehZ4yJ2a99dxHrjazeCtvhb
         GI5JxE1Rr5AqloN2FE59CkJApHiBYuruTq7WmY9kUh16YYC1A8xNAgiFzT/hAeav/4tS
         Gh6EbQ0FG9WzrFtAwxqO4xZ2mpTtvoQoOD0FAiyqdFke8RZuip+yJ12kPZlwLJqr0wV3
         o/WtUGu4YUqli6w0AcsPKRfmuS9D4zA1aVMXrNRkwFiwRQZ4BMzkNxpskSOQRWzKcvLw
         o473ZmsRWT4RL6jNxiSMXP2J79CaDYBfKMK3qMdGd1kx8LbbA61Iu79bNJWOTi7wNhUu
         wuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069710; x=1751674510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/cnX41RaEPSZcQQl/08oRTNXTR1N3nUSP/JWUigEyE=;
        b=E/hwkSCN+JNu+61LttwN5MwY+ruGDhH3ZvPvdHeTKAh+uewSDpGR3jakt15NI6nZrc
         hUaJc+K6iKT3YssBpT1WN5T+TER+uFSlM6QUlxgVNsatN3gsBVVQv1wQTmEVy/g8U0jp
         bkPSGLGxowSkSGNT3jINfVm9dYtNG9M4ezDaDacuF8iRHsaQt0iPEEANmt3xk3nsBZpe
         54K4mwrpz3ZKGApE0RrFfkzfUvcUx48cQburg41c440EFlcPPbSQXJ7j7XytPeAYO+TH
         CP4UlyI38wiAKDT6xsIiKtDcnehHdQGEHZsz8t0j5PLHcGc523gnoxgu8GDsHUIVcMHB
         tieg==
X-Gm-Message-State: AOJu0YzpP5xDPGvGl1+Oko/9En6b4x8nCkkUuyb3SkXG472IuT6DpsOH
	4aY334l5QKoZu3Myzw0K88tpbKVVtudF8va5fHlppyyh7uTmmU4ZB1dyGDVMFQ==
X-Gm-Gg: ASbGnctLZvkcQ1f9A2S2tH5nCuqZrFWuyBDOVT6tykPEfT6ZWtsx4rO8Brgf4Frh7yt
	rr8UdsQRQd58ED4PrLdNGo6NBV/1wbrdiBXfhydoPq89r6T+GJaY19UJZlD+m7jjG0qHt4HDEdY
	R2IGozc5jZgyGZQ0yv2aukBvYcElNB8RUVOOv1Y39eOJhv3bxt7EqcW8hG8dMxll24k9xBw5ggX
	e+WrDnJaj0Qm9jt9qwsBTT2Z76khZr+S5vCdyZUEIYmXAGoE0cJvK3ug1B+b5oYzjIupka0JaXW
	IH3fO/lKQYXppus15edUGrZk0z2w5PI2dzSvzBRafEXMOkle1z3NQ8PdFddX6vsFMg==
X-Google-Smtp-Source: AGHT+IH78/R1nZBzBO5FyRxUU+qESkCb0JzQm6OYz75FGQAFXYWyOtkZsqqzNwUaK/4xz0lzfDBc3w==
X-Received: by 2002:a17:902:ce8b:b0:235:91a:31 with SMTP id d9443c01a7336-23ac45c0d1amr74723265ad.8.1751069709861;
        Fri, 27 Jun 2025 17:15:09 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b82c6sm25510565ad.174.2025.06.27.17.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 17:15:09 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:15:08 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org,
	stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <aF80DNslZSX7XT3l@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627061600.56522-1-will@willsroot.io>

On Fri, Jun 27, 2025 at 06:17:31AM +0000, William Liu wrote:
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.
>

Thanks for providing more details.

> Previous approaches suggested in discussions in chronological order:
> 
> 1) Track duplication status or ttl in the sk_buff struct. Considered
> too specific a use case to extend such a struct, though this would
> be a resilient fix and address other previous and potential future
> DOS bugs like the one described in loopy fun [2].
> 
> 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> per cpu variable. However, netem_dequeue can call enqueue on its
> child, and the depth restriction could be bypassed if the child is a
> netem.
> 
> 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> to handle the netem_dequeue case and track a packet's involvement
> in duplication. This is an overly complex approach, and Jamal
> notes that the skb cb can be overwritten to circumvent this
> safeguard.

This approach looks most elegant to me since it is per-skb and only
contained for netem. Since netem_skb_cb is shared among qdisc's, what
about just extending qdisc_skb_cb? Something like:

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..4c5505661986 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -436,6 +436,7 @@ struct qdisc_skb_cb {
                unsigned int            pkt_len;
                u16                     slave_dev_queue_mapping;
                u16                     tc_classid;
+               u32                     reserved;
        };
 #define QDISC_CB_PRIV_LEN 20
        unsigned char           data[QDISC_CB_PRIV_LEN];


Then we just set and check it for duplicated skbs:


diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..4290f8fca0e9 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -486,7 +486,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
         * If we need to duplicate packet, then clone it before
         * original is modified.
         */
-       if (count > 1)
+       if (count > 1 && !qdisc_skb_cb(skb)->reserved)
                skb2 = skb_clone(skb, GFP_ATOMIC);

        /*
@@ -540,9 +540,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                struct Qdisc *rootq = qdisc_root_bh(sch);
                u32 dupsave = q->duplicate; /* prevent duplicating a dup... */

-               q->duplicate = 0;
+               qdisc_skb_cb(skb2)->reserved = dupsave;
                rootq->enqueue(skb2, rootq, to_free);
-               q->duplicate = dupsave;
                skb2 = NULL;
        }


Could this work? It looks even shorter than your patch. :-)

Note, I don't even compile test it, I just show it to you for discussion.

Regards,
Cong Wang

