Return-Path: <netdev+bounces-74462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5A861646
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F531F25E7B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F882C7E;
	Fri, 23 Feb 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VfFKVRyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AA1DFF9
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703409; cv=none; b=YVKusic3wKoujTDR6h3wZwFRNar4swpMCkoaTqmU7jPr4KjuWyzMZ7CxX7QaZ4cmlndtIpwsMkhwXBZUPzArA5JfKClTpb7y8OYRsP4h2jVTWKzTGbDKmM08Pg+671FLnuDvyc7/OtgRXDnFhp9HpX1r+E2tAqcil0Eg7jjwSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703409; c=relaxed/simple;
	bh=38tW8UXyDWIwmvdXWQ1crzl820snlycvIAfz/OGsOXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reP9MOJIEKmiwm+1NVjFO9VO/X9nL5sOycwaiswcOzLuftl4aC5QAcPNTfhjCOawaVF27rcCrPGYHoe+yHfItcl4Z8/AYIy/q6Wummz/wxrL6Guq8R5rTP7yeuHtZ/SKK1p6aPeGNJhg8DYdgIq42yLr0RPIc+79JPMQaPfHHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VfFKVRyz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so339586f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708703406; x=1709308206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YEgOwYZwEqQlSqkRzSCu7CMT9VRP8TU7gUitK8Fp1u0=;
        b=VfFKVRyzjKsm+e1OoUpzPPPAiKD/GkUiQdbzz+Bz9aR5CcqP3OJBniJ5UWXBRM3PA6
         0gRkKt+24YiQspZBjguTZ0+xy8ngwvdgF5XZE9qUi/x8BzRrBxhy78ldRBSR/mR7Ts2a
         6iJ3egq5JNDMSrSkC9IN3b1NVAQvKKUr2OuiAH9ZX7lIqHEZeODve0QzygpJXuMZq9Ws
         lQDARKO8foMLCtM6nkDgQ/K14TgRbgUOJAsajJq+uHvP1iztdWqxcLjMy9WohnKf5DXZ
         uGng4+ZEyCg58m2FNgHRUjFTqlYQhFotzWE5W3YbmCsTlo1w40GKn34oKu/w8OtBiDNK
         iQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703406; x=1709308206;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEgOwYZwEqQlSqkRzSCu7CMT9VRP8TU7gUitK8Fp1u0=;
        b=ayF+xJJgBjvOOuo2hG/rjbzqqYdO2sgvw5v11VEMJiO938FhOOHI8R//QDUZ/VprQr
         Xlv4Wx8kqMHuB4zhzMVRGwR9z+lmJjkZPXab5rw50jI+1pZoL5dF0C8XXIzbgoV1CP+Y
         TA5VvqY+9zZaRk0eEy2dAGcyMOkEQuV4zAD0TTSqYEwn1mQkQH1Ajbvqeb9n21Asco2x
         DZh76zY19f7WJfob94/8MN8Rgs/3XaHzlh8Psh59mHCu1D0Ma0/sBzTwvia34tlKdNo+
         PvwbNEs9M+d2G1rMzPHdq8R5gCW3X6TaJDDelpxLVxGfEnirCh0XPmj1E4UkbkIDk36V
         10Sg==
X-Gm-Message-State: AOJu0YyqWE0g+YlqSVBL4I8fuG3VFElC0MNM76OA9Lz7IgE/iCK7JGSl
	EJyGqVelNRl05smZBZ7jvszGsod1LAxm05H2Vk4GaC5UJ38V++2ADIvgHwju10Y=
X-Google-Smtp-Source: AGHT+IEXbsYsk9ud6o/c4bGXji6fwxKYjRM4vxB/jUh0OARcLWBrRjyNk+TRr6a3V8Efa93EmLqv2w==
X-Received: by 2002:adf:e543:0:b0:33d:6c9f:39d6 with SMTP id z3-20020adfe543000000b0033d6c9f39d6mr110561wrm.40.1708703405926;
        Fri, 23 Feb 2024 07:50:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6943000000b0033d96b4efbasm3187650wrw.21.2024.02.23.07.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:50:05 -0800 (PST)
Message-ID: <b2fd9413-afb2-4ed7-b660-2294241a8adc@6wind.com>
Date: Fri, 23 Feb 2024 16:50:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 10/15] tools: ynl: stop using mnl_cb_run2()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-11-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> There's only one set of callbacks in YNL, for netlink control
> messages, and most of them are trivial. So implement the message
> walking directly without depending on mnl_cb_run2().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.c | 66 +++++++++++++++++++++++++++++------------
>  tools/net/ynl/lib/ynl.h |  1 +
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index c01a971c251e..0f96ce948f75 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -255,10 +255,10 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  	return MNL_CB_OK;
>  }
>  
> -static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
> +static int
> +ynl_cb_error(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
>  {
>  	const struct nlmsgerr *err = ynl_nlmsg_data(nlh);
> -	struct ynl_parse_arg *yarg = data;
>  	unsigned int hlen;
>  	int code;
>  
> @@ -275,9 +275,8 @@ static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
>  	return code ? MNL_CB_ERROR : MNL_CB_STOP;
>  }
>  
> -static int ynl_cb_done(const struct nlmsghdr *nlh, void *data)
> +static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
>  {
> -	struct ynl_parse_arg *yarg = data;
>  	int err;
>  
>  	err = *(int *)NLMSG_DATA(nlh);
> @@ -292,18 +291,6 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, void *data)
>  	return MNL_CB_STOP;
>  }
>  
> -static int ynl_cb_noop(const struct nlmsghdr *nlh, void *data)
> -{
> -	return MNL_CB_OK;
> -}
> -
> -static mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
> -	[NLMSG_NOOP]	= ynl_cb_noop,
> -	[NLMSG_ERROR]	= ynl_cb_error,
> -	[NLMSG_DONE]	= ynl_cb_done,
> -	[NLMSG_OVERRUN]	= ynl_cb_noop,
> -};
> -
>  /* Attribute validation */
>  
>  int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
> @@ -475,14 +462,55 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
>  static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
>  {
>  	struct ynl_sock *ys = yarg->ys;
> -	ssize_t len;
> +	ssize_t len, rem;
> +	int ret;
>  
>  	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
>  	if (len < 0)
>  		return len;
>  
> -	return mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
> -			   cb, yarg, ynl_cb_array, NLMSG_MIN_TYPE);
> +	ret = MNL_CB_STOP;
> +	for (rem = len; rem > 0;) {
Maybe this (if the nlh declaration is put above)?
for (rem = len; rem > 0; NLMSG_NEXT(nlh, rem)) {

> +		const struct nlmsghdr *nlh;
> +
> +		nlh = (struct nlmsghdr *)&ys->rx_buf[len - rem];
> +		if (!NLMSG_OK(nlh, rem)) {
> +			yerr(yarg->ys, YNL_ERROR_INV_RESP,
> +			     "Invalid message or trailing data in the response.");
> +			return MNL_CB_ERROR;
> +		}
> +
> +		if (nlh->nlmsg_flags & NLM_F_DUMP_INTR) {
> +			/* TODO: handle this better */
> +			yerr(yarg->ys, YNL_ERROR_DUMP_INTER,
> +			     "Dump interrupted / inconsistent, please retry.");
> +			return MNL_CB_ERROR;
> +		}
> +
> +		switch (nlh->nlmsg_type) {
> +		case 0:
> +			yerr(yarg->ys, YNL_ERROR_INV_RESP,
> +			     "Invalid message type in the response.");
> +			return MNL_CB_ERROR;
> +		case NLMSG_NOOP:
> +		case NLMSG_OVERRUN ... NLMSG_MIN_TYPE - 1:
I didn't know this was possible in C :D


> +			ret = MNL_CB_OK;
> +			break;
> +		case NLMSG_ERROR:
> +			ret = ynl_cb_error(nlh, yarg);
> +			break;
> +		case NLMSG_DONE:
> +			ret = ynl_cb_done(nlh, yarg);
> +			break;
> +		default:
> +			ret = cb(nlh, yarg);
> +			break;
> +		}
> +
> +		NLMSG_NEXT(nlh, rem);
> +	}
> +
> +	return ret;
>  }
>  
>  static int ynl_recv_ack(struct ynl_sock *ys, int ret)
> diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
> index ce77a6d76ce0..4849c142fce0 100644
> --- a/tools/net/ynl/lib/ynl.h
> +++ b/tools/net/ynl/lib/ynl.h
> @@ -12,6 +12,7 @@ enum ynl_error_code {
>  	YNL_ERROR_NONE = 0,
>  	__YNL_ERRNO_END = 4096,
>  	YNL_ERROR_INTERNAL,
> +	YNL_ERROR_DUMP_INTER,
>  	YNL_ERROR_EXPECT_ACK,
>  	YNL_ERROR_EXPECT_MSG,
>  	YNL_ERROR_UNEXPECT_MSG,

