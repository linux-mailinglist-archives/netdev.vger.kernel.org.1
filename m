Return-Path: <netdev+bounces-230479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13323BE8987
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721865E8239
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D592E5B2A;
	Fri, 17 Oct 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUnwyVqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B92332EC3
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704346; cv=none; b=uaQtq7PAyotLOZOxLJYWLvLyj0P3Rlfotn2lbLAlrtUgRbg/wz6R1Rd+5N5+VlacaOS3Hb27TuaGeWShuxwEbrWWpC62kQHMkrMwTtpgA9w6w7FbGO1sFkVnG5nDWTiAa8IxMJG9n9Dj6gndF1PUQnGGIRHOORM/Hsr/aHV2ueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704346; c=relaxed/simple;
	bh=MuzctqLB4ussUEoSxRDdq5u4z3jbIFXqqjT7Pzx57TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkXs6fXKJvIL4wy3HtsLFLsm2QsussmWNAKCQVelG04qScU7aEe4WYEzJN36rJKu9SjgvthCjZgWoTvrTrrCGQCW/KuMHnS9Z3TwLeoDtTVQhEhlpjVwvr+8vwWGveQBPUcrSvnBS8GmUMd1ls4YSW8Rum+7dp42jXapzSSARIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUnwyVqp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so935924f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760704342; x=1761309142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqU9csQsucjcl0I01knrUCDVWcsBEKstqIxuhCVvTsY=;
        b=TUnwyVqpCi9dlqFCYjLUqMYsIeDTWcQf3wZ14IckvRtkGRZK9TLavTL8geBU/9nzGD
         IXdGyqqcGtG2/IyE/Iu2IK70jyOv8nOZo3zYYxv/22WFDnp9Vsacg8Uvrgj9/dHXihBu
         fj9n7eanxQo/6Hfwhm/7tPnVgBujflTTRfbQ8qMq7hDatdkQyQUCwnV+6iYvZAFRYYEz
         wanzKb+oy2oRknkXPkyqRBrS/rAoNQRIIXnOwYmCisbhNktCNdURuheMXxzarR32jE4q
         W6ztoVcoWppq9Sh+VaMVGJ/npBeqnxRo79DbjxI4nf1oic8mCTZECyNTO/DaqDVChZvP
         B61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760704342; x=1761309142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqU9csQsucjcl0I01knrUCDVWcsBEKstqIxuhCVvTsY=;
        b=rnxAkQFJD7Zz5A0G6gbv4OlfaD7bAZ3z2rx9sqALDSFMNhyXcdH8tMvvV3R6o+2pG6
         TjKQy4WjtlrWKSianVWPJ4voUEWSDNnj4WZXVYjL8Jmlh1HbYQmg7zHrf4IaUyihEL38
         zToT3kVF9SbvTc6FgKkf/UsgRbyyKn+SaIEiryf0/i9X6Cx7Fl5z6mYLki3J+2V6lrbQ
         82zKM7bwv6YBWF+La0pri4q429+iNcePlS6l73l0TsaQeRLrvqlkNu+Cj9ud0JAJ+/OY
         QxBvk48I6fvofm34iHtXi8MTipAIA0/V/Z3xUvE0CiCAneJvLWptnojr3py7B672Aezn
         lxRw==
X-Forwarded-Encrypted: i=1; AJvYcCWSeY7mA/OeRq5m64JgfeBE45TIEMLrXsYqqvKY0gLlZvYavUuajTRdP2uemYoBF256ZcwxrwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3A/PjAUIBJ6xVVGC6Vfd9Pu4bhC5VW9aor/PlFtZyTetY8g4L
	UGWCjreXxTkvIGhPrnINa8ILnMqPpY4Ui9aCnjVpniSbk7lTJptBCLhT
X-Gm-Gg: ASbGnctzKCz3Xm/NdeExcP9dWEAjWyRJw//12QiNnMHVsfgM5zzHa0utcUSJktZdR2e
	OqTgOJU/rlwh9v3QVWoos1nSFTKwZgJOP38vaEc79K2QVh8ycoEeAyEG9tveIsKQCFRrLG6y4+Q
	8tEmZqHAAPPSiYal9aCkpshYIKHklgbleZmJZKCg6ISTNCsLvyBYEd2Rq12TRFUct63XuxfxGJZ
	4kK3s11yAe4/WwSh+jRPUvFqYvfMdpoU5qguoyNTm7beT39PWuUtN+ruLOIJKDvg34FKh8M5fZ+
	9IxRqHi/YjC3WVSPH/OLpd2XTUVfs91QqGvS3SRh38BrYXvS22+Cs1R6WIg/HY9PWp8zh/vJSKp
	DJK3NwmYPNyVirZykn2yCZbrFijNM21/dbYxwm1un69I/tD+sU70FuVMf/W8/Zj1wdv1GAJDLk4
	sH1YQoRK4ezHVrpE+DTabGcjwavIurahQym7njCobqTz4=
X-Google-Smtp-Source: AGHT+IFvBoV+j+/2ZLgfgQrNR3bEA+fM+cjkWWRqcph6qCN2EXtdRDP7AmiiPcjQg94cN2mUkbMh+A==
X-Received: by 2002:a05:6000:4285:b0:426:d57a:da9d with SMTP id ffacd0b85a97d-42704e0ef3emr2238205f8f.59.1760704341764;
        Fri, 17 Oct 2025 05:32:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:e18a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm40163955f8f.42.2025.10.17.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 05:32:20 -0700 (PDT)
Message-ID: <8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com>
Date: Fri, 17 Oct 2025 13:33:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Byungchul Park <byungchul@sk.com>, axboe@kernel.dk, kuba@kernel.org,
 pabeni@redhat.com, almasrymina@google.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, sdf@fomichev.me,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, toke@redhat.com,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel_team@skhynix.com, max.byungchul.park@gmail.com
References: <20251016063657.81064-1-byungchul@sk.com>
 <20251016072132.GA19434@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251016072132.GA19434@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 08:21, Byungchul Park wrote:
> On Thu, Oct 16, 2025 at 03:36:57PM +0900, Byungchul Park wrote:
>> ->pp_magic field in struct page is current used to identify if a page
>> belongs to a page pool.  However, ->pp_magic will be removed and page
>> type bit in struct page e.g. PGTY_netpp should be used for that purpose.
>>
>> As a preparation, the check for net_iov, that is not page-backed, should
>> avoid using ->pp_magic since net_iov doens't have to do with page type.
>> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
>> page pool, by making sure nmdesc->pp is NULL otherwise.
>>
>> For page-backed netmem, just leave unchanged as is, while for net_iov,
>> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
>> check.
> 
> IIRC,
> 
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>

Pointing out a problem in a patch with a fix doesn't qualify to
me as "suggested-by", you don't need to worry about that.

Did you get the PGTY bits merged? There is some uneasiness about
this patch as it does nothing good by itself, it'd be much better
to have it in a series finalising the page_pool conversion. And
I don't think it simplify merging anyhow, hmm?

...>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 723e4266b91f..cf78227c0ca6 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -450,6 +450,10 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
>>   		area->freelist[i] = i;
>>   		atomic_set(&area->user_refs[i], 0);
>>   		niov->type = NET_IOV_IOURING;
>> +
>> +		/* niov->desc.pp is already initialized to NULL by
>> +		 * kvmalloc_array(__GFP_ZERO).
>> +		 */

Please drop this hunk if you'll be resubmitting, it's not
needed.

-- 
Pavel Begunkov


