Return-Path: <netdev+bounces-86175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4789DD40
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0763F289DF8
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6F132471;
	Tue,  9 Apr 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay4VanE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94153131196
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674057; cv=none; b=Wxrbq5tX3+ZDtmhN3htnDCUzAkwZ3dDAly51TAUb+4NmiAGrLsL5+IWT6cAikBDLxg5MjO+Xc+t2mU17tbiAJtn4C0/hyN70Qy/iUjVUcc739pilebVVSNcwR/z970YXWLDFLqOwrqYPjuJB8Ke7udhE9ECIM1s6Fty06YHVNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674057; c=relaxed/simple;
	bh=ofPunjjFjnR0PRWbq8WvIg9PGrzB96G/bM4mjNxQOnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQlzlzkQgvRdqvsrvxneoTnuOhtlV7FEkueXgXkKXIqF2+9piHSpO3nmn/bvbWo5dx+FWmTyqy9p3DnmqXZxm8xssgaVmIt9BFiOny/JJOSHAqvOiB1qI82bq8zXyxdQpIBwrbrZWM96nZApbq2fFAGBGq1CzzzD6xQP4Ve0z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay4VanE0; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8ae457b27so159101839f.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674055; x=1713278855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofPunjjFjnR0PRWbq8WvIg9PGrzB96G/bM4mjNxQOnY=;
        b=ay4VanE0TUv0zx5Fslx6QUml6tR+WQxicOzjw1raC/J5Jvg4yLTTlyJBdKNTQAyCNc
         5+Hf0EUWKZXgBUpsxGgjHRX20rkPj2dBfj8FaPTyAPN8WJpgH317UUi1uwWqToL3cgY/
         HsYoqsKbQaqfxyQS1PQN1RhOWl+Tcf27+TbCBfOt2uoiTG8QfCqfAW5+QLETudlum/bV
         7w/F9GWcGTmZShsvC13PDt+ehIhJk4gsY8cQlbeGhEM0km5an3G+7j4xigHB9hiUBtxn
         aA/EbME1WSuRUwU3y86qIONjTAdjIM1nUkpIO+NEgAgMjODduT8u6t++v6T9qd3ITEtN
         JF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674055; x=1713278855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofPunjjFjnR0PRWbq8WvIg9PGrzB96G/bM4mjNxQOnY=;
        b=aJtu+z9PiVvujMICjXznHAKkLcs7gMfRL7hqY+Q38YOBkL2iaYggss4O9an7/6o0b/
         Du6ubSgxrqpQNpuat0eFAtYQVI5XMbCuhnC8J4yQTNc0KgcfcFE8MuF/otFhKC84IirC
         I9w6fyFUmS/vp/2wdx6bQhkvjHB59rhv5WQaQrqa+RXUCUQRussrwhh8Fu6dC5fIYG2r
         VSxD6VSEHGou8E1UQoAdhWbGqJMpSmzHJ1iBurLpwZkdOIY3gs4P5qZjip/rO4B6YBrb
         WLLRnx6vfklIJYFf8BX6+YP+e7vct8F/jNyz8rI/DSWbul+sHL7oetGi4Vn3WOHpuf8h
         xTCw==
X-Forwarded-Encrypted: i=1; AJvYcCWjZog83mcejiSydNRSjal/jlHBmbitt9ldz2m518jsULsmvewRRIyAr8lL22KCyeRvFbTWWUJmqp1hcYP73C4Y1G3N5YC0
X-Gm-Message-State: AOJu0YzyIyvnCu0aK/xCo9sTLYQqjbpI87p31qJiYfKrpW3rAXWh2DCS
	0T7Kv/nPt0ke87dtVkjYoP5pEeWp8iFw2VOXWHiS5gsoCTS/qxRV
X-Google-Smtp-Source: AGHT+IGCMeMRtP+qxFjPBWrKK4G8EsHrrnrb3F41uc2tLE9+GcsIOiDJfOG/qbONc+ZarjuXu/fafg==
X-Received: by 2002:a05:6602:3e83:b0:7d5:e9ed:efb4 with SMTP id el3-20020a0566023e8300b007d5e9edefb4mr8422012iob.10.1712674054645;
        Tue, 09 Apr 2024 07:47:34 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:6dd8:136a:4594:269? ([2601:282:1e82:2350:6dd8:136a:4594:269])
        by smtp.googlemail.com with ESMTPSA id b16-20020a056638151000b00482a0c1bfddsm749452jat.29.2024.04.09.07.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 07:47:34 -0700 (PDT)
Message-ID: <0858cc27-8d5f-4de5-897c-33cb44aaa6f1@gmail.com>
Date: Tue, 9 Apr 2024 08:47:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iplink: add an option to set IFLA_EXT_MASK attribute
Content-Language: en-US
To: renmingshuai <renmingshuai@huawei.com>, stephen@networkplumber.org
Cc: liaichun@huawei.com, netdev@vger.kernel.org, yanan@huawei.com
References: <20240408172955.13511188@hermes.local>
 <20240409015350.52377-1-renmingshuai@huawei.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240409015350.52377-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/24 7:53 PM, renmingshuai wrote:
> By the way, do I need to submit a new patch?

yes, please send a formal patch.

