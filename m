Return-Path: <netdev+bounces-176828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CBA6C4D8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B7316B4ED
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95A22FE1F;
	Fri, 21 Mar 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUHmqk6N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50D22D781
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591306; cv=none; b=DGKJJtRmeJiPM6dvlkpcu7faVwDxrRuCrlhVrOj0FrC/4v+H8NwWKp4rJetgY1X4o33FKqFvLywv5cPRJXgMpmLSKGZwvM0gZMmldJag4Mg0WK18VqPaJhdVW1dVhEvbGz/tXFpbNoC6WLOeB7biq2R0lanlyrbiuvKu6Cd9Su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591306; c=relaxed/simple;
	bh=OByW12Ve0fpZVXNs6aQ0h4RP1YKFcy4WV8juU5zXTxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQjnXx+9uIAZ822VvL8Fij2C6ZXpZM/2TOg1vVMTns1+P1YXdr3haTJL+TngBclzV0JlPYtorjD0WT3Gx7x84o0o0WDcn2tw0BnPJm4Rpo+ORfIPLhDAVoDXCfpfXHPg5k2sKYm/uLrv3V4SyDANl/+VUJIeLd1kor0O4J23+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUHmqk6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742591303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgltGrzJqg2st6HJvgrt1xVAH1sJSHek/6ESfVQKA7M=;
	b=dUHmqk6NCp2IcQSN6/uXK/w60dLxcEtcnjIeoeTdPmoFZ9nLXQLxRbSu+e4pY34YzGWzJ1
	GAG5wkbn4Yb5bHOoSvSsVc29IcMmroQX6zxZNsWbkRz1DcC8/LmbGJCfDpGFb61tOr8dqO
	TOALKce4ZSftOd7Z46h3S03GDvopjPY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-M24iibt7MMGykXRjYLlMTg-1; Fri, 21 Mar 2025 17:08:19 -0400
X-MC-Unique: M24iibt7MMGykXRjYLlMTg-1
X-Mimecast-MFC-AGG-ID: M24iibt7MMGykXRjYLlMTg_1742591297
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so1072286f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591297; x=1743196097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgltGrzJqg2st6HJvgrt1xVAH1sJSHek/6ESfVQKA7M=;
        b=dONBbYXCmhD76Jf9KNnFzFfvVhgLSbGCT2oVndtP52/r76HWRR/LmComQtUKrj3fbG
         UTf7dtiqaCCf8thUhSaOL+lJBGMRdyeOZr8V9VdPQzt5TMlEdHmrkialOGZnwtz5HGfa
         Hd9j/RXYqd3j2n7f4w3jmMA/evQFRvAXXV/sn7lkbmEvvPpnfc1R0BX3j5KGSN8egi5f
         WClS6G5mguLqLtLFmmNrFN+oJQlNuCMSxTnnZtjpJGJB6nfsYHvMZCBPH0B7IbbHfxQm
         rXf4WTaltLzNXKoAsN2YtZnPWInjSXhURwpmBNsVTnOf3aMUMzwpr/TpiUzzzDArJpsH
         erdw==
X-Forwarded-Encrypted: i=1; AJvYcCWLoiwWoo+np1gxkK7oUNctV85nBcNzkmXREJElXpM3Z4935km/jjICF7KxinHy4shYQVTsJes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTJP2ITT4tSGVhey6/vlYqqg4iGbei0ZkEfjOokiS1+Cirr2R
	jtlXzOn1H6J8GdycxnpcGmb0Sc6MFcTm4M5jUU7t9h4/UVNqxwnHdl54H/CFw3ElNM03HeID5Id
	/Chn1yE0IwFjZKz8prh7SGFX0n090cUe2lB4izzDq4j72nEvQrCBHdw==
X-Gm-Gg: ASbGncuA9B0PwO7KrxK5FfReR8rqANbBQh4FBBg1Q5Ll8elI7u1eI0tJGOcJ5C9G1rA
	bJDqjnHJlu5xZqUUkfQeFI+KL1WfNKm4Cjl5+IFb4f7gvpr9cqoE8vlLqV4kyvJZTaC1feLBcni
	5PzHgN3PdotHaIOq+18Ro6vOkVH8T7HgvY0z0otqpqLPb0imVZee9VVx284+8hdQX6pEACRxU9U
	LiXDO89Di2KoiSIaTx7JPHh2lMxnshpmuWedZ/CO+T13ACUw+PKHK5F+Fa/A7imyw6kZimFhMJY
	zGQjeF8Nt2V7lEXVmvudBlADPMDAnvkdMl7bq5XI2UQN/w==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr4908532f8f.25.1742591297066;
        Fri, 21 Mar 2025 14:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERkSaLPvjOg3of5q9RHcYoHxuYgujb3iqhlb7BNZGhZ8idpUjjKHfSk0mQf0ZrvJlxGHEdlA==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr4908486f8f.25.1742591296572;
        Fri, 21 Mar 2025 14:08:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a31a7sm3335236f8f.23.2025.03.21.14.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 14:08:16 -0700 (PDT)
Message-ID: <26f2f366-aa14-4879-978a-58d46f9d83a4@redhat.com>
Date: Fri, 21 Mar 2025 22:08:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 3/3] sched: Add dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
 <20250316152717.20848-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316152717.20848-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 4:27 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0dbfe069a6e3..987686e91919 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -30,6 +30,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/local.h>
>  
> +#include <linux/netdev_features.h>
>  #include <linux/percpu.h>
>  #include <linux/rculist.h>
>  #include <linux/workqueue.h>

I guess this chunck is a left-over... in any case it should be dropped.

[...]
> +struct dualpi2_sched_data {
> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
> +
> +	/* Registered tc filters */
> +	struct {
> +		struct tcf_proto __rcu *filters;
> +		struct tcf_block *block;
> +	} tcf;

This usage of anonimous struct is quite unconventional, the preferred
way of scoping fields is to add apprepriate prefix to the field name.

[...]
> +static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
> +		      struct sk_buff *skb)
> +{
> +	u64 local_l_prob;
> +	u32 prob;
> +	bool overload;

Please respect the reverse christmas tree order in variable declaration
(many other occurrences below).

[...]
> +static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
> +			   struct Qdisc *sch)
> +{
> +	++q->deferred_drops.cnt;
> +	q->deferred_drops.len += qdisc_pkt_len(skb);
> +	consume_skb(skb);

Possibly you want to use kfree_skb_reason() here.

I think this patch is still too huge to get a reasonable review. You
should try to split it further, e.g.  struct definition and parsing in
pX, dump in pX+1, enqueue related ops in p+2, ...

Thanks,

Paolo


