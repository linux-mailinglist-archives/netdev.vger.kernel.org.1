Return-Path: <netdev+bounces-132994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80F9942B3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2A528357A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA91DFE22;
	Tue,  8 Oct 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flc0AFJV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810321DFE1A
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375819; cv=none; b=HStJo3wfZaI+re2c5ruaMeIXVD1zcp53qyzxuwpON9d5NItAUqtnwkk6d0d+yfO88ub4e/kgPNZ/qIU7nrMAY+DIOaxgP3Bkl5UUDCzaaVaUtQy7DlTV+2xue25Cm49Xn9caAmRZRUZmFuG9d//ZzkkQbBGkWASVe1rDKth4tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375819; c=relaxed/simple;
	bh=DD+OUTjfYBZlUvk2PpiAzsf+dkd0STHGn8uGzJSnG0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tQ7/99SBTt+Zd7x2Tx8QAJ0DAv0TeZVDpO88p4qzA6fFanLpAp9/MrZ8+wj7dl0E01eFZkV2/ga+xqlHORCfc8bMndXPBMqhWLCJ9uGksvIJz6hpXu31yZ4VwZY3qcQEMeXdgnkuHIbFdT0ZaTns66sNxlw3fE4npMDXjV1kcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Flc0AFJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728375816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/flVe9inmkt02Lj1IzNa4xuoPvxAPGS07tYClZZAv0=;
	b=Flc0AFJVjslEmGWMatL004D183FgjmQcmXkFWhTt+GNYPCpK8XD75bzMexvZnfjgnHqppl
	4LNroOLTxp0uMNRt60xEb7j+Gocc5GWGLZzhTwhXN2lXsG+lkLnW0FFGXaxsIjLMstASQX
	o0KBImJqpOjK5hQeyKuHDsClzD0xylM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ZV3jwYugPACzGv0sKBL_DQ-1; Tue, 08 Oct 2024 04:23:35 -0400
X-MC-Unique: ZV3jwYugPACzGv0sKBL_DQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso59105675e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 01:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375814; x=1728980614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/flVe9inmkt02Lj1IzNa4xuoPvxAPGS07tYClZZAv0=;
        b=fMcUrb9bMkqboXfmAlgOHRl5qPoKYwFvxmahTX5gQQvxxLPOPhsbPK+nrr30xyNwdy
         vRk8s84mX37y6+SiYuH9qGo0rTk40UIX7tRmqI1CLy4LaDWDwwLJGSEkvRjccptM0M1/
         CyRtfr/23tBeA2g3oiA8NDUjUSSHxK4MNO1YLllFby6W2uzHj6BpxrT9ebNVzdW6scBO
         B0pGFIq4Z8nSc0nF1WX9Q3xf0FEu1wCIFRhU3TYLCc2kRL3qfaXuO/m8dfRJRskzV9FG
         lMYzXZNNRHiEJAEthI+YH8D3NI1LHyo9fx9veS0SQag2OL+AufsYFLrFPZK3rIWCcDhZ
         ctwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgaTV8rxiOlMXfx+Q7Wc2+BIXwBi6cJVn6kYXilANKYn66BSOYzIHxTXHY1FrV4SthELXG68k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/M24fhKo46H5KTgQx8hsnoP0uG8KtRGCZCUhsEf0/t6uZYAD
	HEJqTZ1idd0kMTKz/Ct7/+Dc+c85wwCGbQ2ASRUqwxOt+S08NB39pFsb/kcJFudZ1RTojmHO6uQ
	20M9ayu6+rERgRTNm9bSBuFoRWOgo/EV1PEPINSeNDRG9pb5+u+r475tBSObjTQ1Q
X-Received: by 2002:a05:600c:3b84:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42f85a6e0cdmr150367385e9.2.1728375813757;
        Tue, 08 Oct 2024 01:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6wSNyWON0dCr8lhTuMlxq95pqgzR4QFBDe3J87zWPe6Qhd9GI/yw+MJa9JuQks45cxYbX1Q==
X-Received: by 2002:a05:600c:3b84:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42f85a6e0cdmr150367175e9.2.1728375813344;
        Tue, 08 Oct 2024 01:23:33 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8a58esm100710485e9.16.2024.10.08.01.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:23:32 -0700 (PDT)
Message-ID: <608e4396-69b2-4a04-9229-e6bff8de1fc3@redhat.com>
Date: Tue, 8 Oct 2024 10:23:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use-after-free from netem/hfsc interaction
To: Budimir Markovic <markovicbudimir@gmail.com>, netdev@vger.kernel.org
References: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 16:53, Budimir Markovic wrote:
> There is a bug leading to a use-after-free in an interaction between
> netem_dequeue() and hfsc_enqueue() (I originally sent this to
> security@kernel.org and was told to send it here for further discussion).
> 
> If an HFSC RSC class has a netem child qdisc, the peek() in hfsc_enqueue() will
> call netem_dequeue() which may drop the packet. When netem_dequeue() drops
> a packet, it uses qdisc_tree_reduce_backlog() to decrement its ancestor qdisc's
> q.qlens. The problem is that the ancestor qdiscs have not yet accounted for
> the packet at this point.
> 
> In this case hfsc_enqueue() still returns NET_XMIT_SUCCESS, so the q.qlens have
> the correct values at the end. However since they are decremented and
> incremented in the wrong order, the ancestor classes may be added to active
> lists after qlen_notify() has tried to remove them, leaving dangling pointers.
> 
> Commit 50612537e9ab ("netem: fix classful handling") added qdisc_enqueue() to
> netem_dequeue(), making it possible for it to drop a packet. Later, commit
> 12d0ad3be9c3 ("net/sched/sch_hfsc.c: handle corner cases where head may change
> invalidating calculated deadline") added a call to peek() to hfsc_enqueue().
> 
> The QFQ qdisc also calls peek() from qfq_enqueue(). It cannot be used to create
> a dangling pointer in the same way, but may still be exploitable.  I will look
> into it more if the patch for this bug does not address it.
> 
> A quick fix is to prevent netem_dequeue() from calling qdisc_enqueue() when it
> is called from an enqueue function.  I believe qdisc_is_running() can be used
> to determine this:

If I read correctly, that could happen only via netem peek, right? If 
so, what about constraining the fix into the netem peek callback?

> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 39382ee1e..6150a2605 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -698,6 +698,9 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
>          struct netem_sched_data *q = qdisc_priv(sch);
>          struct sk_buff *skb;
> 
> +       if (q->qdisc && !qdisc_is_running(qdisc_root_b
> h(sch)))

Note that your email client corrupted the patch here. Please fix that 
for a formal patch submission, thanks!

Paolo


