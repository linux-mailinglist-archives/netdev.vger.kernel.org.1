Return-Path: <netdev+bounces-187116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D6AA5001
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0151B98093D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B41C5F09;
	Wed, 30 Apr 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B7rbG7wz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F62609E9
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026350; cv=none; b=b3sRdBwcjHQJaS6GjOOx3QW35fjUQhLz02+jFAKsl8PaKjejc+0cz1h8KeF6K6WmGBokr62SCJp7GgoDfzyHIxvkqZpqM63MkLAY9frG0YQ6WqrYr3mcGVAqe9bmhVE9LQzZpMhDS3yWfQP32WIHAx8hIpDBxbXEOQo5MhmJqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026350; c=relaxed/simple;
	bh=k0FOJLh/nrH5atHCLTum0f+gEit7p1b+V6IEj8adq2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJcvOu0MqYswkfFrD8Fh1Nl8j8qHh0lMtDVehs/Ydlg8ny3CDbRmTvFpnASmJJCVeRl2u9FxxyKIOgVRvLKsTYeGhfzYZ4HGuGZyZ5lyMDt91ualrFU2tNfp3/w8rtS+Z8KrA4mMuIloSjYRSNvMFrnfu/4V0yeNZGV7k1HwNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=B7rbG7wz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227cf12df27so117075ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1746026347; x=1746631147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdUWR5k2M5czEHSSqbFFrj3vpW9VIK+bhKoz8pO6nFY=;
        b=B7rbG7wztrA92mO/8AHaDHII6hdY+8j6X4w2QQvz4y+jNAXtVB1HhZwjqxnbiPlmMD
         c//Wx9esiezuUb2PXwfJzahD4fp1tTgw/VTbDn7ukEVGQSJqbta8cJfWg8XeKMqkLl0j
         zkXtoTQWYX+fsfMdqtcqRZdGSpaNik5up/v/X8P2uFOqnzRbkNxGGZNzgw/tOn/+Dq5d
         g7zQ7oQiNznFoxRky9k75gW2LJlaNEopG2vzjeQu2NAqMjEyuOQ+LDMt8qPWG8ilDsdd
         rCnHL11bTOou365Ew+WugYRc8rqQ6zwONoVkXNg7ln1K6uiZcbOK59CYtkambsSTq2hk
         0F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746026347; x=1746631147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdUWR5k2M5czEHSSqbFFrj3vpW9VIK+bhKoz8pO6nFY=;
        b=UelyCbScbOCgihOtO+o1mLRqN78QzYw5hvVX9W9UJgqv4x/U5mlssR/G+EZ0e3lJzG
         /HwNHqiMcydT0aQHzeaQzQatP/3Zp8G2KhF1AjHnH6UXdNY5Dxn1WMOa8UK7AvLoluVC
         bMfMyV7cqFB4x71fFG3Eept1+pb/YJN59T3qR1Mla57AiMGIaD7aYIwBGFk57pWxrjrG
         KusUwvtGV0mQucZ61rf+rpTaMXP1EQguMphPC7HfzKTMSxOmFXObUNkB6Hb8TEgUoNtR
         R6NrY59Qv1qtOwlG2lzc0zpUaCsiKO1T1qVd6m+LsZFnVYJ6ACZt+StAKNL6LFK6W9cJ
         KsKg==
X-Forwarded-Encrypted: i=1; AJvYcCUyUcLrykSfnm3hsPICBvZsE/5xJyHGimyPTn7oll2fiobLYH2D3GqZ5QUL9TV6X2Hr0mS0sSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABfWSG3arbLTvSWVei85SVnfV/XePd4HGRztHqnW72N3E54MD
	ZCwHvikDG/+h7MNN+lMDt/2mLQvGcaqJaduGcVDFOTZ0GaScN5j1cMOZVPrsSQ==
X-Gm-Gg: ASbGncs5HBWKwYO5pd6EdtQxJ3Cf7Ny+6OHJWh37rmdwNo3TOXgboVwThjxMGrVcVv6
	GtMUY8iA4BCQ4q/N5lJBJatWC1i5ZzTY3h7TTst73bBd7ByOa64jt0h88sSMfRu7Uh3ekunfoRK
	QRhkh0CYFju85A3biTgdgQPbKgbxpsKAiOIVXLvBODHS2k6kk3jh5KUzOc9cM9dDrrGCkDGhdX7
	xsE01+xHrjMyDEiy16GOdGciOsYNxV7npXCmwpGc5LNNueXyabYXsr8JVggFyxDzaWLlN4HMWb8
	I7wRC7UMRovB/K/PE1l6DOJ2UMdhI2UMo5YM7JsPafapPBcVD8kkdntAHQ1cIYXNDzF0H8TyOff
	NUqp3Ri9aiAE=
X-Google-Smtp-Source: AGHT+IE7/XS6Y6OX84+IPYbBAixOrFvMqopCI+5yqm1fZqocjNURnwxmE71XeoS1GvDmb1jzk5OozA==
X-Received: by 2002:a17:903:1a44:b0:223:5187:a886 with SMTP id d9443c01a7336-22df4815a10mr47742635ad.22.1746026347315;
        Wed, 30 Apr 2025 08:19:07 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c0:32dc:1373:7adc:1124:6935? ([2804:7f1:e2c0:32dc:1373:7adc:1124:6935])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e772bsm123821265ad.132.2025.04.30.08.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:19:06 -0700 (PDT)
Message-ID: <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>
Date: Wed, 30 Apr 2025 12:19:03 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 1/2] sch_htb: make htb_deactivate() idempotent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, alan@wylie.me.uk
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
 <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/25 20:29, Cong Wang wrote:
> Alan reported a NULL pointer dereference in htb_next_rb_node()
> after we made htb_qlen_notify() idempotent.
> 
> It turns out in the following case it introduced some regression:
> 
> htb_dequeue_tree():
>    |-> fq_codel_dequeue()
>      |-> qdisc_tree_reduce_backlog()
>        |-> htb_qlen_notify()
>          |-> htb_deactivate()
>    |-> htb_next_rb_node()
>    |-> htb_deactivate()
> 
> For htb_next_rb_node(), after calling the 1st htb_deactivate(), the
> clprio[prio]->ptr could be already set to  NULL, which means
> htb_next_rb_node() is vulnerable here.

If I'm not missing something, the issue seems to be that
fq_codel_dequeue or codel_qdisc_dequeue may call qdisc_tree_reduce_backlog
with sch->q.qlen == 0 after commit 342debc12183. This will cause
htb_qlen_notify to be called which will deactivate before we
call htb_next_rb_node further down in htb_dequeue_tree (as you
said above).

If that's so, couldn't we instead of doing:

> @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
>    */
>   static inline void htb_next_rb_node(struct rb_node **n)
>   {
> -	*n = rb_next(*n);
> +	if (*n)
> +		*n = rb_next(*n);
>   }

do something like:

@@ -921,7 +921,9 @@ static struct sk_buff *htb_dequeue_tree(struct 
htb_sched *q, const int prio,
                 cl->leaf.deficit[level] -= qdisc_pkt_len(skb);
                 if (cl->leaf.deficit[level] < 0) {
                         cl->leaf.deficit[level] += cl->quantum;
-                       htb_next_rb_node(level ? 
&cl->parent->inner.clprio[prio].ptr :
+                       /* Account for (fq_)codel child deactivating 
after dequeue */
+                       if (likely(cl->prio_activity))
+                               htb_next_rb_node(level ? 
&cl->parent->inner.clprio[prio].ptr :
  
&q->hlevel[0].hprio[prio].ptr);
                 }
                 /* this used to be after charge_class but this constelation

That way it's clear that the issue is a corner case where the
child qdisc deactivates the parent. Otherwise it seems like
we need to check for (*n) being NULL for every call to
htb_next_rb_node.

cheers,
Victor

