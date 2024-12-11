Return-Path: <netdev+bounces-150917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806649EC139
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36EC280EF1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15A3A8CB;
	Wed, 11 Dec 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrxZ2oL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6453BBD8
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879028; cv=none; b=HdVFUyq6xHzmNSR+WcbxFImn/L0Rk8BhK8Z2a/tsJQSngMHVM5gDA9+/5NQPVNhrGIZyFBb3mCZAVloQXFEa8lsWQz+JLRC8DAXAZY1Zp8mBjdNHNnnlWJie0/MiKfDFn33kpmgITT+ETASNG+fLNdaOkJxzYgpvXnXzCropUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879028; c=relaxed/simple;
	bh=dPTNXFwtdSTvAr1BJnXv7in7muIRevtTXLw2PGTowvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e+ipI+Jv72qMdAE+j6IT9+BIReanbhlIoaIygQu1/UGAPdcai2Z81LbKQNSXQBkYbhTZMCuVdcAMIq30ZvGqGic9bycB5zVq4+ngx+t+qwOEUeUvd5D6lSVg/O5aqK2WmXn3vb32zDAoLpKSR9Emx4+Di5rL0/Gcrc8t0QwijnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrxZ2oL3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6952e2257so476788885a.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733879025; x=1734483825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTRwOwH/ZTeBdtq8Pa0y6K66FrjovarkQDeKbalW6U4=;
        b=LrxZ2oL3UMBs3t8v2IOeMR9gFjQOfnGR0huuWlQoRFG2Bkt6Vl4b1vEQZkoFrvXWiI
         B5KKXKrRHov8TSYGNBBXsyfVX5JMPT0sAz6zBxFWwzQPECz96wqOjyiGwBpCSmIHZf8/
         B+Y9zPMgUYbWOiEKStU8fqnJN6RBevx7ggywNWnb5wzu3qB0JbZFOLPrtvBDQspfhU1L
         c9tXTa8EHsbASDgX1FSQLlPtl0XxMzf5jX7+FbL6HwIOpHnqye7va4DrGX1bJdUSNr4i
         TJEkAmSLOpQK1FtBemaqcSN1sxi4zA5btjqd/jKqniYyBCBKYv800qLrSGEkSV87odtY
         9v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879025; x=1734483825;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTRwOwH/ZTeBdtq8Pa0y6K66FrjovarkQDeKbalW6U4=;
        b=S6oH6VfWoIu4SyPjPf02ffeoc7Z33b0XEBA8evWJc1bDCyVCS9aKITXXltFZULIgS7
         ka3ZvumPgA8gM11W8LPftNxWQ29xd4y6Vc21OylTIw+t/o4eCdonvjbjGiaWFrLDnRgF
         RRWfx2oRNLh2mP6B5qn06qRpT9P24oyv9w4xu4/UPYINbW8SqfuTzFjqsR5JGOuyD2Bn
         LF3JTSkKpAY2NS706KS6oHSe17UV3bWX3gVTcWeShsxpt2U6gXOPtbqUhJ6Yv1uS2Zst
         wotf3WRgJSI/eYD7xQMs4vj7tVX4QjgRzR3Ot62BsKpbkyafOlMfRzy1yTbK/FyYBmIm
         dN1Q==
X-Gm-Message-State: AOJu0YyxkqGF93p5OEe6/heA6X0G8BkxWswlr5a10ghRWMeBNuu+ceW/
	4vhQ7tjAAFADSL3LdaUH0+Lp1eBUlHClnA1uyQqL6CGyEK1Jnh0ol4OwKg==
X-Gm-Gg: ASbGnctBvE2HFU0UVhoe/7OneX3UvvoPUrcm+6LXBVqAvyi2MHvBlI1dHrw3vF7j/Wu
	dCIyP+WrACjgSMvXZ7z5f8J7ratCDoLBgvXZHgFKW1RtnCJiPhphh5mL4f+tqaGGDHqJ55K0P2G
	OJXi/tUnDwQJFruHaw+XGWF6TLgdjl95Mm5ur6EHmmPLk+XcsFveXN40WKXfqGS87LT+gAZJzLF
	wrT9NmJFaXiqN4BqVwy7X2S25qMn4jyyVhkvixmOuSdqnqXgABYcbxC9YsNi7u9JJv++q6ZhprS
	4PqVGIid2Zx8nIOuUflP2qyJby6+74j5m1lUrPkgRvZxTFFYDz22fgoKtQ==
X-Google-Smtp-Source: AGHT+IGcBZE3zJI+cIRfc9/ZdUMfkCWgz5bNQIfBIMTMPVbcsMujcffyPQ3nliCiMyMULCIaD9Jt7A==
X-Received: by 2002:a05:620a:4594:b0:7b6:73f5:2867 with SMTP id af79cd13be357-7b6eb4d1468mr259490985a.44.1733879025175;
        Tue, 10 Dec 2024 17:03:45 -0800 (PST)
Received: from [192.168.128.127] (bras-base-toroon0335w-grc-37-142-114-175-98.dsl.bell.ca. [142.114.175.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4678986010esm2254261cf.66.2024.12.10.17.03.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 17:03:44 -0800 (PST)
Message-ID: <97f04bd9-8da9-4ad5-9715-c947c2ff3618@gmail.com>
Date: Tue, 10 Dec 2024 20:03:43 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] llc: reset transport_header offset as value is
 inaccurate when buffer is processed by DSA
From: Antonio Pastor <antonio.pastor@gmail.com>
To: netdev@vger.kernel.org
References: <ef68689e-7e0b-4702-a762-d214c7d76e3b@gmail.com>
Content-Language: en-US
In-Reply-To: <ef68689e-7e0b-4702-a762-d214c7d76e3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 46c5a1ad90905e054b4a459e86b9ef98eca26df9 Mon Sep 17 00:00:00 2001
From: Antonio Pastor <antonio.pastor@gmail.com>
Date: Tue, 10 Dec 2024 19:45:20 -0500
Subject: [RFC PATCH] llc: llc_input: explicitly set skb->transport_header

Reset transport_header offset and apply the LLC header size increment, 
instead
of applying the increment on current value.
With DSA is enabled skb->transport_header is 2 bytes off, causing
net/802/psnap/snap_rcv to fail OUI:PID match and drop skb.

Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
  net/llc/llc_input.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..6f33ae9095f8 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
      if (unlikely(!pskb_may_pull(skb, llc_len)))
          return 0;

-    skb->transport_header += llc_len;
+    skb_set_transport_header(skb, llc_len);
      skb_pull(skb, llc_len);
      if (skb->protocol == htons(ETH_P_802_2)) {
          __be16 pdulen;
-- 
2.43.0

On 2024-12-09 13:36, Antonio Pastor wrote:
> Hi,
>
> While testing 802.2+LLC+SNAP processing of inbound packets in OpenWrt, 
> it was found that network_header offset is 2 bytes short (before 
> sbk->data) when the packet was received through OpenWrt's DSA 
> (Distributed Switch Architecture). This causes SNAP OUI:PID mismatch 
> and packet is silently dropped by snap_rcv().
>
> Here a trace:
>
>           <idle>-0       [001] ..s..  8744.047176: find_snap_client 
> <-snap_rcv
>           <idle>-0       [001] ..s..  8744.047218: <stack trace>
>  => snap_rcv
>  => llc_rcv
>  => __netif_receive_skb_one_core
>  => netif_receive_skb
>  => br_handle_frame_finish
>  => br_handle_frame
>  => __netif_receive_skb_core.constprop.0
>  => __netif_receive_skb_list_core
>  => netif_receive_skb_list_internal
>  => napi_complete_done
>  => gro_cell_poll
>  => __napi_poll.constprop.0
>  => net_rx_action
>  => handle_softirqs
>  => irq_exit
>  => call_with_stack
>  => __irq_svc
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => secondary_start_kernel
>  => 0x42301294
>
> The offsets were detected as incorrect as early as 
> napi_complete_done() and I gave up on tracking where the problem comes 
> from. Running with GRO disabled makes no difference.
>
> Curiously enough, __netif_receive_skb_list_core() resets 
> network_header offset, but leaves transport_header offset alone if it 
> was set, assuming it is correct. On non-DSA OpenWrt images it is, but 
> since images were migrated to use DSA this issue appears. For locally 
> generated packets transport_header offset is not set (0xffff) so 
> __netif_receive_skb_list_core() resets it, which solves the issue. 
> That is why inbound packets received from an external system exhibit 
> the problem but locally generated traffic is processed OK.
>
> I can only assume this has been an issue for a while but since 
> presumably it only impacts 802.2+LLC+SNAP (which I'm aware is not much 
> used today) it has not been flagged before. I wouldn't be surprised if 
> any protocols using Ethernet II frames reset transport_header offset 
> before they have anything to do with it.
>
> The kernel code does not touch transport_header offset until llc_rcv() 
> where it is moved forward based on the length of the LLC header as it 
> is assumed correct, which is the issue.
>
> Patch below proposes modifying llc_rcv() to reset transport_header 
> offset and then push forward by the LLC header length. While a better 
> solution might lurk elsewhere by tackling the root cause of why 
> transport_header offset is off after DSA set it to begin with, that is 
> taking too much effort to identify and risks widespread impact. A 
> patch could be made to __netif_receive_skb_list_core() to always reset 
> transport_header offset, but that would also impact all frames. This 
> is a lower risk patch that will not impact any non 802.2+LLC frames, 
> and presumably only SNAP ones. It follows the approach of 
> __netif_receive_skb_list_core() of not trusting the offset as received 
> and resetting it before snap_rcv() has a need for it.
>
> Patch:
>
>  net/llc/llc_input.c | 2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)
>
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct s
>      if (unlikely(!pskb_may_pull(skb, llc_len)))
>          return 0;
>
> -    skb->transport_header += llc_len;
> +    skb_set_transport_header(skb, llc_len);
>      skb_pull(skb, llc_len);
>      if (skb->protocol == htons(ETH_P_802_2)) {
>          __be16 pdulen;
>
>
> Can you share your opinions on this patch and suggest next actions for 
> its adoption (or modification) please?
>
> Regards,
>
> AP
>

