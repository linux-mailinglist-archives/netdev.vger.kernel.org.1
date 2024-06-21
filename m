Return-Path: <netdev+bounces-105630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517D9121DB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58B41C23406
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C6175540;
	Fri, 21 Jun 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUJf3q/r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EB173357
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964708; cv=none; b=pbddBF7ynrXQWn9q7btm1i5sfTw2KUYMmQ3oO2Tw209qyI0FdaWSFKQ/O7vZjVB4wgiAqRgVTJc8jYLLPdnAyZ4F6EXi7pxZSB59x6eyCkiGLgeF0pVPLaXt6aIQQUs8/HjiP4NksTC8BKPlbkkZtnGPz1iaFTZlcL73dB75x4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964708; c=relaxed/simple;
	bh=ds+n2Z/vTLu6ylFJUoh8rET4QMBEzAe0PVAxicLEPKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+OlOrRDGToS72/YxS+U0kMQzx9RjGGhN0AChbsady/FiTtKXORjdR+0qyT18BWtCc9jZL1ZwumFuT8uKZTbc+6I+8mProfPc5sa7yZw+qocF45+92iDPc65uaBIe6fP1WpPBDbykaLyS3guR4p8BhtRb9A4DEgBtfQhp8c/lgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUJf3q/r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJBYOdOKQ4Gn1xLmpzv4Yqfj+G7XSh7zQ28K1xrcg3U=;
	b=YUJf3q/r6NtVIVNMiAgIQpQFaVnfPU0c7AvtR7yP5Cn6iuHnCxAa0wpUBmpmezFlQ2k0g6
	eeLj+WgMSxvC66QW2u7MbWO1/w0kIDr70NsVBscqpsTh4sMSwAgxjcN0/+kday2Lp1KlNN
	UuWE7KAR/HdkyPO98AbsqBWv9QhP8/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-1XLcxpblMICB_8ES4tjcnA-1; Fri, 21 Jun 2024 06:11:44 -0400
X-MC-Unique: 1XLcxpblMICB_8ES4tjcnA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3580f213373so1112281f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 03:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964703; x=1719569503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJBYOdOKQ4Gn1xLmpzv4Yqfj+G7XSh7zQ28K1xrcg3U=;
        b=W2SIgGYG2Xqtj996UOZqy6BfUYUymWHRBmJqlL4aHbnHXjswAgZxXwOkdGhHWQPPls
         n/4k+X+Xv4sCLBj5l/+N9upbWyvYG6q5khyqjYWAFvlNIXFCIRLx7wKrYAuljPgEaobZ
         5O/09nYFxSw1En2gBXHgU0RLT6+Qf4sRZJcpJKmX5/v137l0IXJbo8cvyxV35S7iEvE6
         k4SbNlPkyd1OE0GAWUn9XR0F3L7JHwAx+xgUhovJpnSEusZOJyeQNPIUISnGPm6+sHgb
         z7wL2M7xeEQThpPy9BOcfoN00tcrLcDrkSQ1aNnP1IrX5ZA9sZX2zKuQm0YKomRbQPG4
         hjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuhNpsaBxEZaEhf9+EM0Vy5TJDnYWRx0aNsraqU4dhlm430tWeCYJLQs379J879akPwTE3G/B7GMdiPCwLWSi25PlRAZ35
X-Gm-Message-State: AOJu0Yzx5vn3/eG3K+H3h823Wjg9n0sWMI0X8aH0kEMWJ+yrA01EZ5/q
	7q9Q5PVLMk1RwcR6njfcF6EQvDInPflAlcyvxcPY3UYtTUxGNobWFampZXdzjzzkrFYoi3SLBib
	oUhmNYWMn9oZ8mTH6WKK2fZgytJgRDPf0Lj4fphuqSJolwcNq2/Frog==
X-Received: by 2002:adf:9789:0:b0:361:d3ec:1031 with SMTP id ffacd0b85a97d-36317b7d4e1mr5447622f8f.31.1718964702930;
        Fri, 21 Jun 2024 03:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWCjAxrrMaIGHIIhSa52v8fFT1APP2qrYVpvKzDzGgYOJQWUZ0ImF+bd9M5CAG4wk9RK8Yw==
X-Received: by 2002:adf:9789:0:b0:361:d3ec:1031 with SMTP id ffacd0b85a97d-36317b7d4e1mr5447579f8f.31.1718964701948;
        Fri, 21 Jun 2024 03:11:41 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm1291316f8f.24.2024.06.21.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:11:41 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:11:40 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
Message-ID: <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-3-ast@fiberby.net>

hello Asbjørn,

some update on this work: I tested your patch after adapting iproute2
bits (e.g. using TCA_FLOWER_KEY_FLAGS_TUNNEL_<CSUM|DONT_FRAGMENT|OAM|CRIT>

from

https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/

Now: functional tests on TCA_FLOWER_KEY_ENC_FLAGS systematically fail. I must
admit that I didn't complete 100% of the analysis, but IMO there is at least an
endianness problem here. See below:

On Tue, Jun 11, 2024 at 11:53:35PM +0000, Asbjørn Sloth Tønnesen wrote:
> Prepare fl_set_key_flags/fl_dump_key_flags() for use with
> TCA_FLOWER_KEY_ENC_FLAGS{,_MASK}.
> 
> This patch adds an encap argument, similar to fl_set_key_ip/
> fl_dump_key_ip(), and determine the flower keys based on the
> encap argument, and use them in the rest of the two functions.
> 
> Since these functions are so far, only called with encap set false,
> then there is no functional change.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  net/sched/cls_flower.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index eef570c577ac7..6a5cecfd95619 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1166,19 +1166,28 @@ static void fl_set_key_flag(u32 flower_key, u32 flower_mask,
>  	}
>  }
>  
> -static int fl_set_key_flags(struct nlattr **tb, u32 *flags_key,
> +static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
>  			    u32 *flags_mask, struct netlink_ext_ack *extack)
>  {
> +	int fl_key, fl_mask;
>  	u32 key, mask;
>  
> +	if (encap) {
> +		fl_key = TCA_FLOWER_KEY_ENC_FLAGS;
> +		fl_mask = TCA_FLOWER_KEY_ENC_FLAGS_MASK;
> +	} else {
> +		fl_key = TCA_FLOWER_KEY_FLAGS;
> +		fl_mask = TCA_FLOWER_KEY_FLAGS_MASK;
> +	}
> +
>  	/* mask is mandatory for flags */
> -	if (!tb[TCA_FLOWER_KEY_FLAGS_MASK]) {
> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
>  		NL_SET_ERR_MSG(extack, "Missing flags mask");
>  		return -EINVAL;
>  	}
>  
> -	key = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS]));
> -	mask = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS_MASK]));
> +	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
> +	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));


I think that (at least) the above hunk is wrong - or at least, it is a
functional discontinuity that causes failure in my test. While the
previous bitmask storing tunnel control flags was in host byte ordering,
the information on IP fragmentation are stored in network byte ordering.

So, if we want to use this enum

--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
 };
 
consistently, we should keep using network byte ordering for
TCA_FLOWER_KEY_FLAGS_TUNNEL_* flags (for a reason that I don't understand,
because metadata are not transmitted on wire. But maybe I'm missing something).

Shall I convert iproute2 to flip those bits like it happens for
TCA_FLOWER_KEY_FLAGS ? thanks!

-- 
davide


