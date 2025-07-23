Return-Path: <netdev+bounces-209408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C2B0F86D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798C5AA8407
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAE1F3D54;
	Wed, 23 Jul 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AMavFKEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A61F8F04
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289431; cv=none; b=WxNgcL/z6WeIwtb77T5JX56mMZuhZBDfL0LtrpA8TQUx9Qy9i6CHESlLPr3+2YfgdYuxXh20sINOEfn9fNRjwkljYiZVkgAP2xAiwpJIrtmdSlZ8vYYqDeSMzW2FUHut3PLg8aXrRQXEqEwwUtdAOJIEEb04BNTizXJvvWbVwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289431; c=relaxed/simple;
	bh=eSjS2M8K/cMNL4Q6KyIF7VjB3D6OsHxMRq8OD3HQSa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fl5qfkKPofl57jyHqgmhx6cwRjIQKDSD89h0CrkOMY2+Sdcld5IWp8De8CFHoyxpp1tDylL9AVlpmQzTAPlHxh3oA6abFy3IDJgN/44Wf9ympMExoMgfm9b2eaCxanw0k0jbH8fsSkIZPSXv5B4qOE1S7HGA4EK17h62ubGVtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AMavFKEi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae35f36da9dso8818666b.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753289428; x=1753894228; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHbF+bNV/NYjD82+flAz5WMy4UUfVPw0A5K2a39Cc7s=;
        b=AMavFKEis3xIhcCUI2MT+lbW9fu5z8+BfziF5flFhEiYbsADT0dp2wfNPwDSRFoHkK
         IfAbX1DnaL6hp6FxwUe1/i70E3sOZWJxcMWDhi1SWnTIjee72dOVFVOVtYYqyAdt2Zd/
         2wDB6IPKA5/YpOWgN3y7gHQ2mR406BrHo2GBbpAgIPmOC8dozay/roygdfzO7TvQeHtN
         4FvEBT1UYLc8zhbGe+ss1OWBCovBWYoqx9Tc3bVbyNkyvX0uINenqjL4Nh2lxh+diNqH
         LElh6g0tqvG923arCPpOrdrfd9shsCBN5gBRVl5GOLQ28x8SKSv8iPEN17gVTPyzrzbj
         iW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753289428; x=1753894228;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHbF+bNV/NYjD82+flAz5WMy4UUfVPw0A5K2a39Cc7s=;
        b=HAQQUCUf6D8qPj/hYeQUhGR0FqA36At/30ZeaaLK96rP6rBsQqoZAWoRFmSTDSYbVe
         0koXiqNhp30j9j5rLdl5y+CUD3fhqMp5CTj2ifHuM0oKEF1gV7DobGyR9gmLu5uV+JKe
         8B8lJpJXaUip4tLHHjWF03rWuBbcPp6k92yGacAjBoA86zcFH4QWNkF5GA/xdwS8I7tJ
         HvOqSQYGXlRHA/+EKopwXyttMUj+DAID4sPNb9Iqi6BdBUG+ZSu+95/5HcTvQ7FD3dE3
         SxaWdG4xOcMtkTfCR/uNMBGopUUUON8l7i6ptGeptAOqT81SHb1bhsPEezNfPPAYKOBx
         NQLg==
X-Forwarded-Encrypted: i=1; AJvYcCXxm09JHyYa6D7MOQMuzZD5df/+Pme0wxfIKuqw0Olpw+LIEnYBLDHj6o/yCxrUcrBDCTcdzqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2nUMTxSleIub68nX8VCUk5uVA5x6n0f4pYPZbqdKzezHX0jX
	A451vMeeCSkWxj9Wwt6wtLRyc44+qTAsLiyrMYgODu6/Q92KON13su3s+LMXke1uhfU=
X-Gm-Gg: ASbGnctIvCUFaHGHUd9wuE1yl+jd3nlo+O8zX2/xBLGBNNt4q3BpIDuumjzHSvYkIJN
	URY+cp48XVxB78DeYPTnzOxFrjA4bVuT9FbrChoUKpafaeLkJvyx1P5YXTutghxFed5gh9TnM1x
	k+HQtAZiNYj992IH9aiBDNGkcz0UleLjV6QG2ssGg/LtnF+XNXolg7Z8iio2rpgkeQmRF9PD5MS
	xekQGdLMZrYX+D5X8S3f+Wi+/EwuRaukkjVvm1FjgZzeZDtsKg2PfGdRjF6R6Fcu/yw3CllL1H/
	ijd8Ub9OMfYZhWQOgSyvtUKAHXTSMiwp0qX4VxXuRTY1ZtxszuSiqikaFNi+tPKmw7nM3yQEbQA
	qRlG3giMJ2pTBJ0U=
X-Google-Smtp-Source: AGHT+IH0A0hcFE7SQYZLHuh0RzpL/6WqrlWeycjIO+whrbB48ECsnKTmqoF2jTn8zJinY18Z1UbkEg==
X-Received: by 2002:a17:907:1c92:b0:ae3:60e5:ece3 with SMTP id a640c23a62f3a-af2f66c0966mr335743966b.6.1753289428364;
        Wed, 23 Jul 2025 09:50:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:bd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d475fsm1077655766b.43.2025.07.23.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:50:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v3 02/10] bpf: Enable read access to skb
 metadata with bpf_dynptr_read
In-Reply-To: <3d765f43d5b2d186f2de09c1dddeb32d8ff6e46a.camel@gmail.com>
	(Eduard Zingerman's message of "Tue, 22 Jul 2025 11:49:14 -0700")
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	<20250721-skb-metadata-thru-dynptr-v3-2-e92be5534174@cloudflare.com>
	<3d765f43d5b2d186f2de09c1dddeb32d8ff6e46a.camel@gmail.com>
Date: Wed, 23 Jul 2025 18:50:26 +0200
Message-ID: <8734amyhpp.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22, 2025 at 11:49 AM -07, Eduard Zingerman wrote:
> On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
>
> [...]
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index c17b628c08f5..4b787c56b220 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11978,6 +11978,18 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>  	return func;
>>  }
>>  
>> +int bpf_skb_meta_load_bytes(const struct sk_buff *skb, u32 offset,
>> +			    void *dst, u32 len)
>> +{
>> +	u32 meta_len = skb_metadata_len(skb);
>> +
>> +	if (len > meta_len || offset > meta_len - len)
>> +		return -E2BIG; /* out of bounds */
>> +
>> +	memmove(dst, skb_metadata_end(skb) - meta_len + offset, len);
>> +	return 0;
>> +}
>> +
>
> Nit: is it possible to use bpf_skb_meta_pointer() here to avoid
>      duplicating range check in both bpf_skb_meta_load_bytes()
>      and bpf_skb_meta_store_bytes()?

This will be a nice refactor. Thanks!

