Return-Path: <netdev+bounces-281779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DewMHeN8Gl4UwEAu9opvQ
	(envelope-from <netdev+bounces-281779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D357482B98
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E573019BBB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA46351C24;
	Tue, 28 Apr 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcVLNNOd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgXCVI7p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B413E8C49
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371399; cv=none; b=Fvr+N7Ulgq/zt5A8Y8VkCpVYcCFrEzRn5RhjZK8i8wSLG5+sp+3IR7EilqSWUcp2RfTFkoc6kq7uZWnjuscJXe+3Vv4rKmH3aB31tW+40d5180ZNiOvGodVWmWXzp0aLhNdgCCI/pgiAZzmvQbaPNRQx0+B6tvgvVFaknDAAvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371399; c=relaxed/simple;
	bh=w5EF2+5sDbNoVmXz1350odK3A+Cj3nfIkBuJ77BY8V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdV/suUBjKsNrqDdW91OTSGZheozsfXvY4nqkNEyl+1unSPKysSglVTtdKQfc/psZ5/z/MjxWxiFUhkOYy6d9NKca3Mq/++Xxxk0hZwTWqxnqX4t+2HhzJkdiorCQIoKaYk08kuONgoAFskWC01DGqfGc4vk3VoHLQx6Sk8S1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcVLNNOd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgXCVI7p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777371393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie+2X2OWlxSKL1QIER68ueVAs9yigwXAaQFI0sJ7NTk=;
	b=LcVLNNOdpI3Wcs3nFKC0QPFdfcTrrpgEWGYjCjA1cXDAMCDkhUxl7A3sGWhCBvF1NJ+In6
	f+A2elf5CmkvwkIuGjsPvQanRjjgelsMoQYH69E6WR0jaJugn9ScNhjvcrld9oSH1NuRPK
	4JH+UnUVVib8vlkBzjTMm3j2/rVlqf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Fi_4pCVtPVKPFFXP7hC-Ng-1; Tue, 28 Apr 2026 06:16:31 -0400
X-MC-Unique: Fi_4pCVtPVKPFFXP7hC-Ng-1
X-Mimecast-MFC-AGG-ID: Fi_4pCVtPVKPFFXP7hC-Ng_1777371390
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a2c034fso6903436f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777371390; x=1777976190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ie+2X2OWlxSKL1QIER68ueVAs9yigwXAaQFI0sJ7NTk=;
        b=DgXCVI7pjayd0bSZaiQV1ckJewPIxVmHpFt6maxfPNMV8OlpKCvN86WcYNxiRCqJJe
         yWHN+l4MI5tX39SRs7HvGdvt1BWR/eLOqt6GE3MqUXc54+VWb8RnY35gNFoUpb8EHZ22
         Y5dmB8E6I7FjRJB0Nt8ivdckQKNjWvj32wbSo/OrN94cV8ig4nfq2zdf57iWybJKv9oA
         skXKQalfJXxPGapC4oES9/YPWkaHUl308wMiddL02gZPAeWNZM/XAecdrewsCMYfv6t1
         3mYzXdvaHzwGicx3VspkmkbrnEEqVEOmWLy/xLYfGjHXXmsFaTlnXriOx4PtzhQHJMAf
         uQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371390; x=1777976190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie+2X2OWlxSKL1QIER68ueVAs9yigwXAaQFI0sJ7NTk=;
        b=mM3OGjbLvJ0rM91yQriLuegjEI2cZeD9EsDqDAQAPcsgRHRnhrD7hGOvNStOGCkyLw
         Nquseu0vTqN0+adE8kBtIgM5NQxGOQUmGXm8q8AGtTaLdPzBdjgHL3j0A/Yq3CeMYIQ/
         zEQaq5Z/jvnl4/Ur1MECy1DI9yPimZ4cZhiMki0dm3rTtpEcAgsUnONhNO/DwDzUxhmM
         Ok/z5aM+d6fU2XZQJAz8113IBMjgHMZ9Lh8sEd1ywzQnmjWoP7NYxdxtgZAI8zxnM5bg
         OcOa0ihzft8A/qd/4Rz78o7OSJ7OiKCQeQVibL1t/ZiYIlpRRVpjoRf+leA63mzniWie
         CFsg==
X-Forwarded-Encrypted: i=1; AFNElJ8Y0jkaTDEv1VRHyr8yjRz0taUVe0DvP7Iz+Z141LGiqJWGg9DssHSM8COJfo0ZEnXmT2Ip68Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7zqULElC2dyyqAs71fNkxfMdfBbZF32EDQPCkHq5dcEVpmmy
	s/ui/fs9P2a88GxH20qWMS1QOjd+7Eoo3JZwuw4TN4inMtGiEY/87zCjH+sG71lnJzq6LSM5jGA
	Ol22QS6HQLt/H0XZbDYx6QZzYmSzWRi2OLxRn8UvUP0lC6WY13JStF9ZTNg==
X-Gm-Gg: AeBDieuqcOaefNbHk9wdg5TJ78AYyFIn9ITUlbQ83kEVtH6aergKWZhU7d6oe5dEGeY
	IjRluyQK+L3lgNYmaMS3/cpuKK3SgniFTl00oyAPqbHQgtwfPcdQgaKzwXL4aUuY7IpKgYjKI6+
	5tOPma4AlRQ53Cz97R8MsEnlI9ggaUa7GC2+/LHfrVxyVjtDj51CoOQMHbfBvjuvMLKeXkTSbOC
	PwOuArYnbxv89qSY74Yf0qAeQB2YP7h4sj0VSGNiqctdp7/vPGL1hBpzB2QCJ2U7XRHjcxUOcjw
	LSKjujV0EdwcOsIAfkv4hbwHZTEWoFq2OujEiNtnoDcfHElslYDbgxA1ZmFFQOfLE75shVwxbnJ
	zP7+JgEw+t4dd5/K1Vp74vxUKhuQ1fBSEwJTZuR6SIQTh5sa58qaA/T6Lp3uV7SIBFg==
X-Received: by 2002:a5d:64c3:0:b0:43d:77f4:7145 with SMTP id ffacd0b85a97d-44647be5981mr4105816f8f.19.1777371389852;
        Tue, 28 Apr 2026 03:16:29 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:43d:77f4:7145 with SMTP id ffacd0b85a97d-44647be5981mr4105771f8f.19.1777371389377;
        Tue, 28 Apr 2026 03:16:29 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59e5asm5555354f8f.5.2026.04.28.03.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:16:28 -0700 (PDT)
Message-ID: <850472d9-2dbb-446d-a070-0c2ee6b53cdf@redhat.com>
Date: Tue, 28 Apr 2026 12:16:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 9/9] selftests/tc-testing: Add netem test case
 exercising loops
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, jiri@resnulli.us, stephen@networkplumber.org,
 victor@mojatatu.com, savy@syst3mfailure.io, will@willsroot.io,
 xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, toke@toke.dk,
 willemdebruijnkernel@gmail.com, hxzene@gmail.com
References: <20260426190916.128489-1-jhs@mojatatu.com>
 <20260426190916.128489-10-jhs@mojatatu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260426190916.128489-10-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1D357482B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,networkplumber.org:email]

On 4/26/26 9:09 PM, Jamal Hadi Salim wrote:
> From: Victor Nogueira <victor@mojatatu.com>
> 
> Add a netem nested duplicate test case to validate that it won't
> cause an infinite loop
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/qdiscs/netem.json     | 33 ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> index 3c4444961488..7c954989069d 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> @@ -336,5 +336,36 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> -    }
> +    },
> +    {
> +        "id": "8c17",
> +        "name": "Test netem's recursive duplicate",

This test is apparently consistently failing on our CI:

# not ok 365 8c17 - Test netem's recursive duplicate
# Value doesn't match: bytes: 294 != 196
# Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
'correlation': 0}, 'seed': 17230427318941832146, 'ecn': False, 'gap':
0}, 'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues':
0, 'backlog': 0, 'qlen': 0}

sample full info avail:

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/622604/1-tdc-sh/

/P


