Return-Path: <netdev+bounces-275352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKZYFDvk0GmIBgcAu9opvQ
	(envelope-from <netdev+bounces-275352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C639ABAB
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B64E53012C85
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A613A874B;
	Sat,  4 Apr 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM9WKw2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7292F6904
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297591; cv=none; b=a/AfoHuan/ZuDHK1kTQrg4cVWtS6wEo87tecU5mzqgjOAiC4EWlFR1cd/GXR3PAW/IXOkX9uXC9lE4cfa8XQxmIgID13l44mm3paaNxiIqg2ZOVBbzHGJwoHcZ6dCvC9jiOu2cGgFi4i2wRUzLkREVZHJc/zg//ZseoXvzdQIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297591; c=relaxed/simple;
	bh=bOb+FvEx0sfD5ymbFzBGsbSl1H8nEf+bPhmougX2odY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lS2glLjv/+H73+WtLQeP6SD3SLztdRjnwIGA2Nie1itoqWgz0bbrwCs2RMpPMn7svT6uXjSR3GAB+ak2UcHCgoyQEuejYBpVxRoULytXzDQ6esOlyKLINuLJor5PoxcqHMh3NPHvyKwCfRGfiGYKN+bwyr8SF7G4aUUX/abBqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM9WKw2Q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66e56756044so1935474a12.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775297588; x=1775902388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kytOiio7o2G0aZ0/Jz5hfAKv+SJ1sqldAVESs2tTwlM=;
        b=ZM9WKw2QTjQAH9pwaILXSMPxGYFJAWWhfdc7gIuqgbRJPrTyyT56aqwLMTrAkOxnf5
         75tBFZqmRpjYsn7Tq+Aslp0yFCHm1EadvU2qYwLiK5YK2wviabaLvY/QlsvzVMjmk3rj
         JOerkbeYrMnJmPn+UxUZzGcBCJqQNUZyxURbsrlcTMQSJuejaJj7BWiyuZwHt9u7bA1F
         KMHK1rpExdpzT57FPl+sQkh/ywm9Ums9gRAy7+sp7E5tV7lTpxnPpXLrmKRi3wQ0d+FX
         uEzGHIF6oFULayG7Fj7wsWbhuCat0WJa99n5gOR/5OlyVes5evKdY/WqtdUjpUVvktNp
         sn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775297588; x=1775902388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kytOiio7o2G0aZ0/Jz5hfAKv+SJ1sqldAVESs2tTwlM=;
        b=YGlKSTJf+E9+tho4KSywrt+k7L0pVQadYNE8iMU8ix3QXUrA13H2Qe1KOWJwhQq07K
         /SRGlTrrG1QhlP2xDm3Ln882ICUj/cLmH/NVR1jPzUYM2i5FtpRcpOEzJzvTk38yH/0F
         zhiJRney7oaPBOdnvD7NIiwSRJCS95198PnSIOlpF0BSbTsfRwou+esrJlPI4vR1wr3P
         ThrD7RYDfZeaF3GVe+3HqmrnDM0v5vaAq/RyHJZML+rjEOsCDxrDeEjNoaSulzyOvyY7
         9ty5EM4nT3d9BS96euqch4s+wT/euTUCR+I4GPvOs8p0ibPnkJ0EJi1YCC1ctGnekzJ6
         Zt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTST7Zz/Ztlt6dUz1dY9P08cVyHukCurnX6UR7rz2xnwaFTFt4/ZGsQir3EFaRy0LJnVc1Z8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcw2VQmaacwSgBntp12Uu50LfvUG5KIYC99GSkvy3XWCtg+tFZ
	dCUZ5HfvR+HtWLpvs0zfX1g5HOwsVMXax94Wy6QZV/ENVJkMsEViUecn
X-Gm-Gg: AeBDieu/6v/G+eMKHnr9SLqQcCy6rpB9BQoLrXSQaV7MxJ+eAsau7yDGqH02joNJcnj
	fFHfk7OKDLcaFpIOdMTmgSgTkvM5t96z5PFFCaAjmf0RDxbHY4hOepH6UzCQbysqgoNy/vhiNB1
	9SFXVzH/ig0+w2R3XXWc57uNaswmMyB4JUGSkqgxaW/MqbEdPEaQF0aT8o6hBJaBHL+vrmZl730
	Dzmz21uwfOik8f9HuadJSD+Rbz55RlyNGxFAwI8VQw+lrIaL4Zjnxwzz+heC2BsF4nKJmBmk3MC
	m6+rYOZu7KoeEVzIwmLhzebkXSfD4Gy9bqdmFJi4Kghlv8+/mtOqp7bJj0qTN7AvN/ON/9wDvIo
	TggWyZuWzacHg0Y3mN9sX1QRwzEf+IdJRrnvbx5Ny1ON/qWA7u5oDmdGsnPlCCHzYNq4YUXilJe
	a3/MJxYKXHBIebHCZGfyrZpBnA/dwE9EeHIX7DYDx/pDMoE6PBDse1+JTSjnnc0VqPvROsRUJhZ
	nY=
X-Received: by 2002:a05:6402:34c3:b0:66e:44e:3103 with SMTP id 4fb4d7f45d1cf-66e3f3dc018mr3014741a12.9.1775297588208;
        Sat, 04 Apr 2026 03:13:08 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:eb80:1fe:7625:6ba9? ([2a02:a03f:a75e:9a00:eb80:1fe:7625:6ba9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e034c6750sm2221712a12.27.2026.04.04.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 03:13:07 -0700 (PDT)
Message-ID: <2de5a3d1-cc8f-48c2-a590-09bef92e9adb@gmail.com>
Date: Sat, 4 Apr 2026 12:13:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in
 __ioam6_fill_trace_data()
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 yimingqian591@gmail.com
References: <20260402101732.1188059-1-edumazet@google.com>
 <20260403214418.2233266-2-kuba@kernel.org>
 <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
 <20260403145010.4b4e5865@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260403145010.4b4e5865@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275352-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C19C639ABAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 23:50, Jakub Kicinski wrote:
> On Fri, 3 Apr 2026 14:47:32 -0700 Eric Dumazet wrote:
>>> If the ingress device has more RX queues than the egress device (dev) has
>>> TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
>>>
>>> Since skb_get_tx_queue() does not clamp the index, will it return an
>>> out-of-bounds pointer into the egress device's dev->_tx array, causing
>>> dereferencing queue->qdisc to read invalid memory?
>>
>> This seems a different bug ?
>>
>> I mean, do we need to fix all bug in a single patch ?
> 
> no no, sorry, i'm just sending this out for Justin or you as a separate
> thing.

Thanks Jakub, I don't know how I missed that. It's not just about a 
possible OOB: it's actually incorrect for IOAM to do that because we're 
relying on a lucky assumption at best (i.e., if queue_mapping on RX == 
queue_mapping on TX). This unfortunately rules out the possibility to 
have an accurate per queue visibility (which I originally provided for 
flexibility). I've had a local patch for a long time to aggregate the 
queue depth (i.e., sum of all TX queues). It is more expensive(***), but 
it would kill two birds with one stone and solve both problems 
simultaneously.

Jakub, Eric, please let me know if the following plan works for both of you:
- (net) fix the OOB reported by Jakub (and, while at it, add missing 
locks around qdisc_qstats_qlen_backlog() -> also included in my local patch)
- (net-next) after the merge window, add the new feature

After that, the per queue visibility would be considered 
legacy/deprecated and not the default behavior. Documentation would be 
updated accordingly to explain why per queue visibility cannot be trusted.

  (***) the advise to operators in such a case is (obviously) to reduce 
the IOAM insertion (with the frequency parameter), especially at line rate.

