Return-Path: <netdev+bounces-282268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MIhJyS08WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79004490804
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E76413003BF8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A33E3A5E78;
	Wed, 29 Apr 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="G6IOWp+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9093A4F5C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447956; cv=none; b=tYTtWUYXZ6hG3Vg8QP7pb8s0E7DnLwhrVF8xSA07FiAsO+2f9PXMYy55L6cq45zuCM1YvjGRdPWwHDtWC/0OIqakRpSl2dcZrNjdZ5hfV4vsucJqMVuj4IA8LMBtLvdH+KM7Hc+4PyynsEyOK3FGTVvtWAXrK2j1LTgQ4z+xkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447956; c=relaxed/simple;
	bh=VrchDQYw6XG3lkPmwkiWs711W5qHQO4BPO7IIURRRyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlPxR1bf0yN7zhqesWlAgzUeapjToJNuDZHq/iOzLf72+IZ102Bb+ITDe+ob7OnixfNKKxZSYSt5n/aNPnkBkNokFXiUIZjtpzRNTrZovH/QV9+mJrj7G7ab8vI/T8y8xv897lmW9UIutc8Xm9/y7pmu1wqTFtgTNIzJ6pfYWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=G6IOWp+e; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe608cb92so8218135f8f.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777447953; x=1778052753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbZ9qKVJAIwgjA5Ke+ShQG0pVzAO0Z/RB+NsoRfVfcY=;
        b=G6IOWp+eQVECC5Wzcm1bePpbbya+8OQP3geXF9qOMSlNidUinE1Q42ZeqYfBcGXDGp
         4fHHBuV8UemmL30iyo+KNQI/CI/UrKH1fNtZ7rqrTrux6Inax3RcaaEnejjCPtFrc3q1
         b9A4wQgv0aLhAR3q1M09oril5iYik47xSkMunn7O44zZPYZk8H3T3bgVR89OaAiEFAor
         SS989c/J4QT7JlJtUC1cEh4D/4+w4tFjVG7nAw5ChrLTANHA9N7XZQYydaxoDPFu0SRK
         cGCJbkq7N+bkuZlsCCZZwi+PNRUHLWaVJ8gwZ4bNPGqAqnZY4IJtrDLNQ9EGvoiQ6Hqv
         dVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447953; x=1778052753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbZ9qKVJAIwgjA5Ke+ShQG0pVzAO0Z/RB+NsoRfVfcY=;
        b=Nl4iPU7fMYE44Nllf0ytCpY9W3YAg7CeDAOLeVBEQ/VoZdWeBwfwC/kFrbxOXlqitZ
         zaQpUJ8M2/FsG1rk7SfPQ7WllKCTYelkREIa7fIYdBI4cn7CC6eonn0ewrhBahnmqv7t
         1qJyXqqLinEJqcSxz9rheJWVYhnX1cc9Qg+xViumUQaE9nyRxEkgSNvD0aWIEF0YVXF7
         0F7xpg6p94tl09Bv5d1QizotD2Kugsms1rQRzxmR1oi4YRqykdfbV4P5m2W2PFe/E6PY
         sstGmcjxttn9747hi75eDqLcNuHlTRDux1bJeYKqxygoClBmA8kdbVUasFNXWK4xqHz/
         5m6g==
X-Forwarded-Encrypted: i=1; AFNElJ98/HP93mA+LrMsgeTG/QBd/OCqbW2CB/qdvn0hcEU5XDq8TIPTfxfPWuD1CIR1ITLjrbO5MVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNfa2PHcCc3VlrdOPKu50rrwFgdrmUd3PJeJqHjHNoxMsJOKt
	xUvqZPiYhmfPBzZaQR5h45HisygHik5wl+MPOFM73YqmZy2sRFR3dMLqiOvv7m/p/MU=
X-Gm-Gg: AeBDievMi65ZtExFakqgBau3hK/6a1IYRvJn3yDEaAiEDOrd7vPOaBcT/9kZEqHs92L
	gQu7S3mH0OXDOhn3T+FVsdyMKy04PuDyiaz2bhLICHa4qs1vbNK0OgqCrfai/qZCtTrljY8GuBM
	Qzp6mJGWDfMDdSn4ELRDkCqfQaNZL4YipHAqc8EGX5z8sgr3xx1ZnXLRp/8jV3hCMUJE/q4sQ2z
	ShybtYQo7RQ+/oAeyUOtWM1CwNMY8JPCl50403vUS8KkwqhT/PYf2reXiQd4qHMl2x6DzkmLHwz
	aFPwaN9YhCz36oBnI+41R+psrwDqyPg9Bw+8vv5ZGtOVnQbL3Il4nS0BjV0L9DHafj+wXqTzdxj
	K/jzdbpsIGwN2Qq6O/DUwAESa6W+A80zJp8Eo0PwP1Z80qj0ptC52UZVjLlWgE9cgAXjQDaZUr7
	KDwqmhR/Foggj2ZEMLSBUjFQ26sRbamayvMrIL36zKhUFOXEYgtj1dcHDvxf8jH6Ok
X-Received: by 2002:a05:6000:26cd:b0:43d:1c39:593c with SMTP id ffacd0b85a97d-446496d7a54mr11658871f8f.30.1777447952979;
        Wed, 29 Apr 2026 00:32:32 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca664csm4177021f8f.35.2026.04.29.00.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:32:31 -0700 (PDT)
Message-ID: <c7ebbc59-1583-44fa-8702-49c11fcf9398@blackwall.org>
Date: Wed, 29 Apr 2026 10:32:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, herbert@gondor.apana.org.au, linus.luessing@c0d3.blue
References: <20260426133435.207006-1-idosch@nvidia.com>
 <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79004490804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-282268-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 28/04/2026 17:10, Paolo Abeni wrote:
> On 4/26/26 3:34 PM, Ido Schimmel wrote:
>> Connecting two bridges on the same system [1] can result in a lockdep
>> splat [2].
>>
>> The report is a false positive. Multicast queries are built and
>> transmitted under the bridge multicast lock. When the outgoing port of
>> one bridge is configured on top of another bridge, the transmit path
>> re-enters bridge code and acquires the other bridge's multicast lock in
>> order to snoop the query. Both lock instances share a single lockdep
>> class, so lockdep flags the nested acquisition as an AA deadlock.
>>
>> Giving each bridge its own lock class will not solve the problem: the
>> reverse topology would produce an ABBA splat with the same pair of
>> classes. It also consumes a lockdep key per bridge.
>>
>> Instead, fix the problem by deferring the transmission of the queries to
>> a workqueue. Build the skb and update querier state under the lock as
>> before, then enqueue the skb on a per multicast context queue and
>> schedule the work.
> 
> I must admit that introducing an additional WQ to fix a false positive
> feels a bit overkill to me - even if I can't think of a better solution
> on top of my head.
> 

I don't have a simpler way to fix it either, and we've had multiple reports
of this false positive in the past. It's just another job on the system wq
and if Ido limits the queue, IMO should be fine.

Cheers,
  Nik



