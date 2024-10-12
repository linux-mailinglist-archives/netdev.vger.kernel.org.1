Return-Path: <netdev+bounces-134792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8899B31B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32BE1C21CA8
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5F154BE9;
	Sat, 12 Oct 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CJ1ch+Xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BB1547CE
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729759; cv=none; b=ePC8Iw+WpfSgqZA7S1IMIMLhgmRAHhyZo0KJYMngU3kzyK1xNOG2dPXKCaEG8kDlBkCX+nP3OzuAnC1kbPOyoP6+bO/CZftRGv2Lo3MHbZjYLdRna+7O9gSJeGjCnlC7HbzPjzuLu2/Hr86gpahG5+jGPzqu0Xc+krHRmkWkJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729759; c=relaxed/simple;
	bh=F2Sp1fzcw8Uf/QMINhGhDYWS9F5dWa9nb4/qh8r/ALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jdBIXyeUNThMvgVQbcye+kC4qjNxOH90yld9otaEfxtyn4MshA7tD51wx0DjnJ8pvp9pn0Fx+fKECv7XnGRHlHdzjMkPh8slzHT8a2BHzwnoTpPA4DX98gl8JxU9OgLcm8lfWmzoDBVWaJBSUqHI6oN1VoFwKvhHaYBrGXPTv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CJ1ch+Xs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b93887decso25742695ad.3
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728729757; x=1729334557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=CJ1ch+XsP3k9Bdzgi04+URwvUed22kf7IKlTv1B37FV6auETP4UlJefSeJXGYF9vSb
         BndSPWHOFR5xJEBQbpFAxbda8AOE0AO2cUs5dvj0yNA6O+i1JXchGPZMtEEcUBJ1jDpA
         9ae5pOZ4/yMrP9TjbkbPbVtkeUGQhjollE3J4wiGs9fK52X2x1+HrGucK/JOEL2JW79P
         6cInfHli9hUziadd/Wsbh4zll4iZ37mOZPwoSCDOt8srfmrJtBy+AFMV/iBVQfaWP60W
         LDAvyZwIkTLvul7Ko140liyADahfYrbPfITSn4SlImw3918FdMwtiQzT5teJi6CGysLl
         wU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728729757; x=1729334557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=bSfGrueWf5M2G0UmhQAc6jsqBG01yjLo/WA5otejXY5ohJDaN4iCDyUUvK+ViWryjN
         ax920bL/31gPe/i/wBzIQiO8Ml8pGOj7Y87iGltibR+U5XJB0hZ9VkBAyf8s7UuO5nQn
         mR7weaLiIuQ4Bv3nGmTZ96MCLhB7GyRUPZxRqQJ+npuB0r2FpxoQcXLgCfxJoPEchj3G
         ibhJ1heqtB9uOTcEh67d/xoK6B3gYthJHrBCwnE5V6zQKm8+TNHq6/9Rr1QV5C6Z6uRJ
         2k24y8KAMZNOpB2CzPHrK5so2x9tHl8G7b9TZewy2RFdVg6JbLrNufwZ4ulQ41TqhyIG
         y1JA==
X-Forwarded-Encrypted: i=1; AJvYcCUrX41pDP0pumw3l3YjYhVl9+gqX/i0qgnDcXI5Cj0h0jQoyjK2z+Li12AiysPhVQ6TvZm6IHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mSt2YD9UzqxkoPN5xkEvPJHk01JdLRcIzviWOpmwkLmh3U5+
	HGvgGyhmhvm5W3yHIZB5cB6lMtJiR/pGqHFki6QOPM1aOTnh4XUYQaWcZy1yBVI=
X-Google-Smtp-Source: AGHT+IHAAJSka16NZVOG9ERRGT0s8XZNSpBXGOA3FY01waa9+ItcfG5gf6PTH3meZ9nN0csYqZ692Q==
X-Received: by 2002:a17:902:e5d2:b0:20c:ce9c:bbb0 with SMTP id d9443c01a7336-20cce9cbddfmr6671465ad.0.1728729757238;
        Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ffadsm35367635ad.266.2024.10.12.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:42:36 -0700 (PDT)
Message-ID: <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
Date: Sat, 12 Oct 2024 19:42:31 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
 <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/09 22:51, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
> 
> No need for these to be in header files

I naively followed prior examples in this file. Do you have an 
alternative idea?

