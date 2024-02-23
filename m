Return-Path: <netdev+bounces-74419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943C86137D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EE81F267C9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CC80BE3;
	Fri, 23 Feb 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dXDiTYY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED18003E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697036; cv=none; b=A8i/iBOEtB5rue/OPb4phNajwwEkiE+feU8Gt7YbPiRmLwezyDpouJg+rfsswLYRodagU5cEUi12f+L0+gLNxw6STOMIKWYwoU0zQa7EkK5mGsr5OjmhowzxWvTP2WGA9k4JmkNxrF4MdD3K+FnPC7mLPhO1uQXqp4Lj0DNZ3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697036; c=relaxed/simple;
	bh=iqMA8kvC0lCUCEKWT1xseTukMAezflglev+PNyq7xhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDAzlpAW78rEqCVvIxKaZOuAMDfVY2KjDOQRde4D9BvHK8GNkuYDSfUIIQ54xonQX1jdLhFc4z9eu+gvbP8vg6FfHF7RKd3YhkH9gA2yV9Pty/ORPSqrIMwBMqfBac/otWaMwSbkHBFHFEkF7rd6HsNSnuZSr+do2tDTNovGGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dXDiTYY1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512dfa097b1so1196113e87.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708697032; x=1709301832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TLnQKg8gJR7dqlpvi+USSQ1zAtxcoRoMJZUnMCBosTM=;
        b=dXDiTYY1TBkan6G4XWkwHF4FQTEt2sTSkZBGJN7IEsgl63urcH/ulOHriWEWStVN0S
         VdwoaPgM9WvvJkAq07Uh0A6YaBTOuplRpLBNVOH41zqRwe96ymY0bwLzk/Hdjdflk1m7
         Oimoh0A+bptsmwUuMkBg93dknjh6Cq+goQul9wffGyVt8j3Rdcat3XYIjUHBXvTadg3b
         phw5nC0qprQIVtkEHqbneA5xJNrI9feR5av+Zu6kHslnVwve8mHD4SI/BMZ9DXPYsSa7
         5rgQEiX391fgNddEFjBUfyYYtrun7CJ8UmPVuL/QkxysRtlucL/WyAc5K/Mm5NlmaymA
         fQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697032; x=1709301832;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLnQKg8gJR7dqlpvi+USSQ1zAtxcoRoMJZUnMCBosTM=;
        b=DEjpT5j5cw6Sm+EU0aIi0D4A2LTxhahnbm24gJQbilP80/9Da3n8IWm07KVjIbnbKb
         avexoN7a6xT8OzVUxS6bKcVTeiha+fAUD8XqDGBwvGR/sq/0kOVdP44sllGNT8XmAEEl
         QX1W5qM8KRCh1YliOSRmi/bxm+ahD2p3NILqOJKRys2pwq4b05hsdhXtACoN+hhCx9oG
         VWBsYSOwRG37Xu2xMjS8dg7jQ5ZpoQusXtIpc9jV/VPiiHAGDeyS0NhhUmeDE0uEXo4s
         +fJhVlvCmHNhLEIQ8KXtshRq6n/0OGbndF/BvD9x06ycoMzqVDqAHKyJXfPiSMKH/T/S
         0tlQ==
X-Gm-Message-State: AOJu0Ywox0USip6awLNAdhzPT5Nf7uOUlT9x9qmoPIgU7111+piriypF
	pQ4AvC6CPzQmYVc8/EdBtBRrB69NB9ywd5n4LlPpY1qlWcpS6xKyTkIqtS5H7AYe2RyKqpZ2SIy
	2
X-Google-Smtp-Source: AGHT+IEhrwctohFapcRkBlKO3aNj1ja3aczBgWUs4vjfvERa6JDZl2PGkr7Sch7zHoEn/0+NLOzJbA==
X-Received: by 2002:a05:6512:b94:b0:512:b84e:e7a1 with SMTP id b20-20020a0565120b9400b00512b84ee7a1mr2038549lfv.5.1708697031867;
        Fri, 23 Feb 2024 06:03:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id y2-20020a199142000000b0051179fe683bsm2540243lfj.155.2024.02.23.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:03:51 -0800 (PST)
Message-ID: <1b2fec9f-881d-48fc-bb11-b6269c4ad2f5@6wind.com>
Date: Fri, 23 Feb 2024 15:03:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 02/15] tools: ynl: create local attribute helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Don't use mnl attr helpers, we're trying to remove the libmnl
> dependency. Create both signed and unsigned helpers, libmnl
> had unsigned helpers, so code generator no longer needs
> the mnl_type() hack.
> 
> The new helpers are written from first principles, but are
> hopefully not too buggy.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl-priv.h | 215 ++++++++++++++++++++++++++++++++---
>  tools/net/ynl/lib/ynl.c      |  44 +++----
>  tools/net/ynl/ynl-gen-c.py   |  59 ++++------
>  3 files changed, 245 insertions(+), 73 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index eaa0d432366c..b5f99521fd8d 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -127,45 +127,232 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
>  
>  /* Attribute helpers */
>  
> -static inline __u64 mnl_attr_get_uint(const struct nlattr *attr)
> +static inline void *ynl_nlmsg_end_addr(const struct nlmsghdr *nlh)
>  {
> -	switch (mnl_attr_get_payload_len(attr)) {
> +	return (char *)nlh + nlh->nlmsg_len;
> +}
> +
> +static inline unsigned int ynl_attr_type(const struct nlattr *attr)
> +{
> +	return attr->nla_type & NLA_TYPE_MASK;
> +}
> +
> +static inline unsigned int ynl_attr_data_len(const struct nlattr *attr)
> +{
> +	return attr->nla_len - NLA_ALIGN(sizeof(struct nlattr));
nit: NLA_HDRLEN ?

> +}
> +
> +static inline void *ynl_attr_data(const struct nlattr *attr)
> +{
> +	return (unsigned char *)attr + NLA_ALIGN(sizeof(struct nlattr));
Same.

> +}
> +
> +static inline struct nlattr *
> +ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
> +{
> +	struct nlattr *attr;
> +
> +	attr = ynl_nlmsg_end_addr(nlh);
> +	attr->nla_type = attr_type | NLA_F_NESTED;
> +	nlh->nlmsg_len += NLMSG_ALIGN(sizeof(struct nlattr));
Same.

> +
> +	return attr;
> +}
> +
> +static inline void
> +ynl_attr_nest_end(struct nlmsghdr *nlh, struct nlattr *attr)
> +{
> +	attr->nla_len = (char *)ynl_nlmsg_end_addr(nlh) - (char *)attr;
> +}
> +
> +static inline void
> +ynl_attr_put(struct nlmsghdr *nlh, unsigned int attr_type,
> +	     const void *value, size_t size)
> +{
> +	struct nlattr *attr;
> +
> +	attr = ynl_nlmsg_end_addr(nlh);
> +	attr->nla_type = attr_type;
> +	attr->nla_len = NLA_ALIGN(sizeof(struct nlattr)) + size;
Same.

> +
> +	memcpy(ynl_attr_data(attr), value, size);
> +
> +	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
> +}
> +
> +static inline void
> +ynl_attr_put_strz(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
ynl_attr_put_str() ?

> +{
> +	struct nlattr *attr;
> +	const char *end;
> +
> +	attr = ynl_nlmsg_end_addr(nlh);
> +	attr->nla_type = attr_type;
> +
> +	end = stpcpy(ynl_attr_data(attr), str);
> +	attr->nla_len =
> +		NLA_ALIGN(sizeof(struct nlattr)) +
NLA_HDRLEN

> +		NLA_ALIGN(end - (char *)ynl_attr_data(attr));
> +
> +	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
> +}
> +
> +static inline const char *ynl_attr_get_str(const struct nlattr *attr)
> +{
> +	return (const char *)(attr + 1);
It's the same, but I tend to prefer:
return (const char *)ynl_attr_data(attr);
Same below.

> +}
> +
> +static inline __s8 ynl_attr_get_s8(const struct nlattr *attr)
> +{
> +	__s8 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
Why a memcpy instead of a cast?
return *(__s8 *)ynl_attr_data(attr); ?

> +	return tmp;
> +}
> +
> +static inline __s16 ynl_attr_get_s16(const struct nlattr *attr)
> +{
> +	__s16 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __s32 ynl_attr_get_s32(const struct nlattr *attr)
> +{
> +	__s32 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __s64 ynl_attr_get_s64(const struct nlattr *attr)
> +{
> +	__s64 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __u8 ynl_attr_get_u8(const struct nlattr *attr)
> +{
> +	__u8 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __u16 ynl_attr_get_u16(const struct nlattr *attr)
> +{
> +	__u16 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __u32 ynl_attr_get_u32(const struct nlattr *attr)
> +{
> +	__u32 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline __u64 ynl_attr_get_u64(const struct nlattr *attr)
> +{
> +	__u64 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
> +	return tmp;
> +}
> +
> +static inline void
> +ynl_attr_put_s8(struct nlmsghdr *nlh, unsigned int attr_type, __s8 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_s16(struct nlmsghdr *nlh, unsigned int attr_type, __s16 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_s32(struct nlmsghdr *nlh, unsigned int attr_type, __s32 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_s64(struct nlmsghdr *nlh, unsigned int attr_type, __s64 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_u8(struct nlmsghdr *nlh, unsigned int attr_type, __u8 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_u16(struct nlmsghdr *nlh, unsigned int attr_type, __u16 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_u32(struct nlmsghdr *nlh, unsigned int attr_type, __u32 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline void
> +ynl_attr_put_u64(struct nlmsghdr *nlh, unsigned int attr_type, __u64 value)
> +{
> +	ynl_attr_put(nlh, attr_type, &value, sizeof(value));
> +}
> +
> +static inline __u64 ynl_attr_get_uint(const struct nlattr *attr)
> +{
> +	switch (ynl_attr_data_len(attr)) {
>  	case 4:
> -		return mnl_attr_get_u32(attr);
> +		return ynl_attr_get_u32(attr);
>  	case 8:
> -		return mnl_attr_get_u64(attr);
> +		return ynl_attr_get_u64(attr);
>  	default:
>  		return 0;
>  	}
>  }
>  
> -static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
> +static inline __s64 ynl_attr_get_sint(const struct nlattr *attr)
>  {
> -	switch (mnl_attr_get_payload_len(attr)) {
> +	switch (ynl_attr_data_len(attr)) {
>  	case 4:
> -		return mnl_attr_get_u32(attr);
> +		return ynl_attr_get_u32(attr);
ynl_attr_get_s32() ?

>  	case 8:
> -		return mnl_attr_get_u64(attr);
> +		return ynl_attr_get_u64(attr);
>  	default:
>  		return 0;
>  	}
>  }
>  
>  static inline void
> -mnl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data)
> +ynl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data)
>  {
>  	if ((__u32)data == (__u64)data)
> -		mnl_attr_put_u32(nlh, type, data);
> +		ynl_attr_put_u32(nlh, type, data);
>  	else
> -		mnl_attr_put_u64(nlh, type, data);
> +		ynl_attr_put_u64(nlh, type, data);
>  }
>  
>  static inline void
> -mnl_attr_put_sint(struct nlmsghdr *nlh, __u16 type, __s64 data)
> +ynl_attr_put_sint(struct nlmsghdr *nlh, __u16 type, __s64 data)
>  {
>  	if ((__s32)data == (__s64)data)
> -		mnl_attr_put_u32(nlh, type, data);
> +		ynl_attr_put_u32(nlh, type, data);
ynl_attr_put_s32() ?

>  	else
> -		mnl_attr_put_u64(nlh, type, data);
> +		ynl_attr_put_u64(nlh, type, data);
>  }
>  #endif
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index 6e6d474c8366..f16297713c0e 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -94,7 +94,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
>  
>  	mnl_attr_for_each_payload(start, data_len) {
>  		astart_off = (char *)attr - (char *)start;
> -		aend_off = astart_off + mnl_attr_get_payload_len(attr);
> +		aend_off = astart_off + ynl_attr_data_len(attr);
>  		if (aend_off <= off)
>  			continue;
>  
> @@ -106,7 +106,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
>  
>  	off -= astart_off;
>  
> -	type = mnl_attr_get_type(attr);
> +	type = ynl_attr_type(attr);
>  
>  	if (ynl_err_walk_report_one(policy, type, str, str_sz, &n))
>  		return n;
> @@ -124,8 +124,8 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
>  	}
>  
>  	off -= sizeof(struct nlattr);
> -	start =  mnl_attr_get_payload(attr);
> -	end = start + mnl_attr_get_payload_len(attr);
> +	start =  ynl_attr_data(attr);
> +	end = start + ynl_attr_data_len(attr);
>  
>  	return n + ynl_err_walk(ys, start, end, off, policy->table[type].nest,
>  				&str[n], str_sz - n, nest_pol);
> @@ -153,8 +153,8 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  	mnl_attr_for_each(attr, nlh, hlen) {
>  		unsigned int len, type;
>  
> -		len = mnl_attr_get_payload_len(attr);
> -		type = mnl_attr_get_type(attr);
> +		len = ynl_attr_data_len(attr);
> +		type = ynl_attr_type(attr);
>  
>  		if (type > NLMSGERR_ATTR_MAX)
>  			continue;
> @@ -169,7 +169,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  				return MNL_CB_ERROR;
>  			break;
>  		case NLMSGERR_ATTR_MSG:
> -			str = mnl_attr_get_payload(attr);
> +			str = ynl_attr_data(attr);
ynl_attr_get_str() ?

>  			if (str[len - 1])
>  				return MNL_CB_ERROR;
>  			break;
> @@ -185,7 +185,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  		unsigned int n, off;
>  		void *start, *end;
>  
> -		ys->err.attr_offs = mnl_attr_get_u32(tb[NLMSGERR_ATTR_OFFS]);
> +		ys->err.attr_offs = ynl_attr_get_u32(tb[NLMSGERR_ATTR_OFFS]);
>  
>  		n = snprintf(bad_attr, sizeof(bad_attr), "%sbad attribute: ",
>  			     str ? " (" : "");
> @@ -211,7 +211,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  		void *start, *end;
>  		int n2;
>  
> -		type = mnl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_TYPE]);
> +		type = ynl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_TYPE]);
>  
>  		n = snprintf(miss_attr, sizeof(miss_attr), "%smissing attribute: ",
>  			     bad_attr[0] ? ", " : (str ? " (" : ""));
> @@ -222,7 +222,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
>  
>  		nest_pol = ys->req_policy;
>  		if (tb[NLMSGERR_ATTR_MISS_NEST]) {
> -			off = mnl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_NEST]);
> +			off = ynl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_NEST]);
>  			off -= sizeof(struct nlmsghdr);
>  			off -= ys->family->hdr_len;
>  
> @@ -314,9 +314,9 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
>  	unsigned int type, len;
>  	unsigned char *data;
>  
> -	data = mnl_attr_get_payload(attr);
> -	len = mnl_attr_get_payload_len(attr);
> -	type = mnl_attr_get_type(attr);
> +	data = ynl_attr_data(attr);
> +	len = ynl_attr_data_len(attr);
> +	type = ynl_attr_type(attr);
>  	if (type > yarg->rsp_policy->max_attr) {
>  		yerr(yarg->ys, YNL_ERROR_INTERNAL,
>  		     "Internal error, validating unknown attribute");
> @@ -514,11 +514,11 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
>  	i = 0;
>  	mnl_attr_for_each_nested(entry, mcasts) {
>  		mnl_attr_for_each_nested(attr, entry) {
> -			if (mnl_attr_get_type(attr) == CTRL_ATTR_MCAST_GRP_ID)
> -				ys->mcast_groups[i].id = mnl_attr_get_u32(attr);
> -			if (mnl_attr_get_type(attr) == CTRL_ATTR_MCAST_GRP_NAME) {
> +			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_ID)
> +				ys->mcast_groups[i].id = ynl_attr_get_u32(attr);
> +			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_NAME) {
>  				strncpy(ys->mcast_groups[i].name,
> -					mnl_attr_get_str(attr),
> +					ynl_attr_get_str(attr),
>  					GENL_NAMSIZ - 1);
>  				ys->mcast_groups[i].name[GENL_NAMSIZ - 1] = 0;
>  			}
> @@ -536,19 +536,19 @@ static int ynl_get_family_info_cb(const struct nlmsghdr *nlh, void *data)
>  	bool found_id = true;
>  
>  	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		if (mnl_attr_get_type(attr) == CTRL_ATTR_MCAST_GROUPS)
> +		if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GROUPS)
>  			if (ynl_get_family_info_mcast(ys, attr))
>  				return MNL_CB_ERROR;
>  
> -		if (mnl_attr_get_type(attr) != CTRL_ATTR_FAMILY_ID)
> +		if (ynl_attr_type(attr) != CTRL_ATTR_FAMILY_ID)
>  			continue;
>  
> -		if (mnl_attr_get_payload_len(attr) != sizeof(__u16)) {
> +		if (ynl_attr_data_len(attr) != sizeof(__u16)) {
>  			yerr(ys, YNL_ERROR_ATTR_INVALID, "Invalid family ID");
>  			return MNL_CB_ERROR;
>  		}
>  
> -		ys->family_id = mnl_attr_get_u16(attr);
> +		ys->family_id = ynl_attr_get_u16(attr);
>  		found_id = true;
>  	}
>  
> @@ -566,7 +566,7 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
>  	int err;
>  
>  	nlh = ynl_gemsg_start_req(ys, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 1);
> -	mnl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
> +	ynl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
>  
>  	err = mnl_socket_sendto(ys->sock, nlh, nlh->nlmsg_len);
>  	if (err < 0) {
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 7fc1aa788f6f..4f19c959ee7e 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -168,15 +168,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          spec = self._attr_policy(policy)
>          cw.p(f"\t[{self.enum_name}] = {spec},")
>  
> -    def _mnl_type(self):
> -        # mnl does not have helpers for signed integer types
> -        # turn signed type into unsigned
> -        # this only makes sense for scalar types
> -        t = self.type
> -        if t[0] == 's':
> -            t = 'u' + t[1:]
> -        return t
> -
>      def _attr_typol(self):
>          raise Exception(f"Type policy not implemented for class type {self.type}")
>  
> @@ -192,7 +183,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          ri.cw.p(f"{line};")
>  
>      def _attr_put_simple(self, ri, var, put_type):
> -        line = f"mnl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name})"
> +        line = f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name})"
>          self._attr_put_line(ri, var, line)
>  
>      def attr_put(self, ri, var):
> @@ -357,9 +348,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          else:
>              self.type_name = '__' + self.type
>  
> -    def mnl_type(self):
> -        return self._mnl_type()
> -
>      def _attr_policy(self, policy):
>          if 'flags-mask' in self.checks or self.is_bitfield:
>              if self.is_bitfield:
> @@ -387,10 +375,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          return [f'{self.type_name} {self.c_name}{self.byte_order_comment}']
>  
>      def attr_put(self, ri, var):
> -        self._attr_put_simple(ri, var, self.mnl_type())
> +        self._attr_put_simple(ri, var, self.type)
>  
>      def _attr_get(self, ri, var):
> -        return f"{var}->{self.c_name} = mnl_attr_get_{self.mnl_type()}(attr);", None, None
> +        return f"{var}->{self.c_name} = ynl_attr_get_{self.type}(attr);", None, None
>  
>      def _setter_lines(self, ri, member, presence):
>          return [f"{member} = {self.c_name};"]
> @@ -404,7 +392,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          return '.type = YNL_PT_FLAG, '
>  
>      def attr_put(self, ri, var):
> -        self._attr_put_line(ri, var, f"mnl_attr_put(nlh, {self.enum_name}, 0, NULL)")
> +        self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, NULL, 0)")
>  
>      def _attr_get(self, ri, var):
>          return [], None, None
> @@ -452,9 +440,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          len_mem = var + '->_present.' + self.c_name + '_len'
>          return [f"{len_mem} = len;",
>                  f"{var}->{self.c_name} = malloc(len + 1);",
> -                f"memcpy({var}->{self.c_name}, mnl_attr_get_str(attr), len);",
> +                f"memcpy({var}->{self.c_name}, ynl_attr_get_str(attr), len);",
>                  f"{var}->{self.c_name}[len] = 0;"], \
> -               ['len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));'], \
> +               ['len = strnlen(ynl_attr_get_str(attr), ynl_attr_data_len(attr));'], \
>                 ['unsigned int len;']
>  
>      def _setter_lines(self, ri, member, presence):
> @@ -493,15 +481,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          return mem
>  
>      def attr_put(self, ri, var):
> -        self._attr_put_line(ri, var, f"mnl_attr_put(nlh, {self.enum_name}, " +
> -                            f"{var}->_present.{self.c_name}_len, {var}->{self.c_name})")
> +        self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, " +
> +                            f"{var}->{self.c_name}, {var}->_present.{self.c_name}_len)")
>  
>      def _attr_get(self, ri, var):
>          len_mem = var + '->_present.' + self.c_name + '_len'
>          return [f"{len_mem} = len;",
>                  f"{var}->{self.c_name} = malloc(len);",
> -                f"memcpy({var}->{self.c_name}, mnl_attr_get_payload(attr), len);"], \
> -               ['len = mnl_attr_get_payload_len(attr);'], \
> +                f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
> +               ['len = ynl_attr_data_len(attr);'], \
>                 ['unsigned int len;']
>  
>      def _setter_lines(self, ri, member, presence):
> @@ -526,11 +514,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          return f"NLA_POLICY_BITFIELD32({mask})"
>  
>      def attr_put(self, ri, var):
> -        line = f"mnl_attr_put(nlh, {self.enum_name}, sizeof(struct nla_bitfield32), &{var}->{self.c_name})"
> +        line = f"ynl_attr_put(nlh, {self.enum_name}, &{var}->{self.c_name}, sizeof(struct nla_bitfield32))"
>          self._attr_put_line(ri, var, line)
>  
>      def _attr_get(self, ri, var):
> -        return f"memcpy(&{var}->{self.c_name}, mnl_attr_get_payload(attr), sizeof(struct nla_bitfield32));", None, None
> +        return f"memcpy(&{var}->{self.c_name}, ynl_attr_data(attr), sizeof(struct nla_bitfield32));", None, None
>  
>      def _setter_lines(self, ri, member, presence):
>          return [f"memcpy(&{member}, {self.c_name}, sizeof(struct nla_bitfield32));"]
> @@ -589,9 +577,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>      def presence_type(self):
>          return 'count'
>  
> -    def mnl_type(self):
> -        return self._mnl_type()
> -
>      def _complex_member_type(self, ri):
>          if 'type' not in self.attr or self.attr['type'] == 'nest':
>              return self.nested_struct_type
> @@ -625,9 +610,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>      def attr_put(self, ri, var):
>          if self.attr['type'] in scalars:
> -            put_type = self.mnl_type()
> +            put_type = self.type
>              ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
> -            ri.cw.p(f"mnl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
> +            ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
>          elif 'type' not in self.attr or self.attr['type'] == 'nest':
>              ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
>              self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
> @@ -690,8 +675,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>              local_vars += [f'__u32 {", ".join(tv_names)};']
>              for level in self.attr["type-value"]:
>                  level = c_lower(level)
> -                get_lines += [f'attr_{level} = mnl_attr_get_payload({prev});']
> -                get_lines += [f'{level} = mnl_attr_get_type(attr_{level});']
> +                get_lines += [f'attr_{level} = ynl_attr_data({prev});']
> +                get_lines += [f'{level} = ynl_attr_type(attr_{level});']
>                  prev = 'attr_' + level
>  
>              tv_args = f", {', '.join(tv_names)}"
> @@ -1612,12 +1597,12 @@ _C_KW = {
>      ri.cw.block_start()
>      ri.cw.write_func_lvar('struct nlattr *nest;')
>  
> -    ri.cw.p("nest = mnl_attr_nest_start(nlh, attr_type);")
> +    ri.cw.p("nest = ynl_attr_nest_start(nlh, attr_type);")
>  
>      for _, arg in struct.member_list():
>          arg.attr_put(ri, "obj")
>  
> -    ri.cw.p("mnl_attr_nest_end(nlh, nest);")
> +    ri.cw.p("ynl_attr_nest_end(nlh, nest);")
>  
>      ri.cw.nl()
>      ri.cw.p('return 0;')
> @@ -1674,7 +1659,7 @@ _C_KW = {
>  
>      ri.cw.nl()
>      ri.cw.block_start(line=iter_line)
> -    ri.cw.p('unsigned int type = mnl_attr_get_type(attr);')
> +    ri.cw.p('unsigned int type = ynl_attr_type(attr);')
>      ri.cw.nl()
>  
>      first = True
> @@ -1696,7 +1681,7 @@ _C_KW = {
>          ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
>          ri.cw.block_start(line=f"mnl_attr_for_each_nested(attr, attr_{aspec.c_name})")
>          ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
> -        ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, mnl_attr_get_type(attr)))")
> +        ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
>          ri.cw.p('return MNL_CB_ERROR;')
>          ri.cw.p('i++;')
>          ri.cw.block_end()
> @@ -1712,13 +1697,13 @@ _C_KW = {
>          if 'nested-attributes' in aspec:
>              ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
>          ri.cw.block_start(line=iter_line)
> -        ri.cw.block_start(line=f"if (mnl_attr_get_type(attr) == {aspec.enum_name})")
> +        ri.cw.block_start(line=f"if (ynl_attr_type(attr) == {aspec.enum_name})")
>          if 'nested-attributes' in aspec:
>              ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
>              ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr))")
>              ri.cw.p('return MNL_CB_ERROR;')
>          elif aspec.type in scalars:
> -            ri.cw.p(f"dst->{aspec.c_name}[i] = mnl_attr_get_{aspec.mnl_type()}(attr);")
> +            ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.type}(attr);")
>          else:
>              raise Exception('Nest parsing type not supported yet')
>          ri.cw.p('i++;')

