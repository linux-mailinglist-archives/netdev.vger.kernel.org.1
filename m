Return-Path: <netdev+bounces-184267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E47A9402E
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D271B60D19
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636524061F;
	Fri, 18 Apr 2025 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU911+c0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227991FFC62
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017609; cv=none; b=JLIvbWzqxb9Z8Ds6fK2n5tniLY1lXanAIK9AcAwI+VaB35BhWkyB0+HZjvGLkgXFB/f8fpvctwLhkH/drg7uj8O1y0WqwF0/x0ZrtXoU6oFiLcr+QHvQ5OoDmAMdoiExAe+vzTAzf3PYMwyVluXHhh9Ryh1WcC33FgcTuo009/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017609; c=relaxed/simple;
	bh=ObzaH/OUkQHPWVYZMpbEz/cp9QJRtntQcqmq4mmU8kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnEafarNDWXJfBl/qB3kJ/AzffYhtOyphxRDXe//dl1K6cPn8o7EUpUT7OvFKkuq6/R1MVCqRrKD+PSWRd1Ksu+V+Wx+Z8C6JRwM+ViJD32UIwXpeU6eWOmgalAhKKpk+v6q89EegwY+fR+NxhAGyJLEabB8cR6qSb067ioa0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU911+c0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2742410f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745017606; x=1745622406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=we1VCwvp+ME6JKyiG1rWZrby+S9dyNFYg/n6ab/For4=;
        b=BU911+c05q85oXmDda1qK65K3be5qTWm1FNl7id1gJVk6AcRoXt5dACXoZLRow5bQq
         YRwh/MhoV+BApqT3o0yXtH5XQ61lKA/JVeTtA6x0vZLSvCD2DtPFeDoELGWIE08xYBqM
         u8adU8dkOmPkw7NesLZ1wJKMUJ1e1t2+Ne755JZ5cfIK8majvhhjO/C6BRQfy67dbQDA
         u2742zWKFcz8wwZ8Y7aBJQymRMrQzx6N6UT3M3UcZhvOmGIzlUUhnfSWL4w78kc04SzB
         E8HtE8L1aR019Eiv6Atrjv/qaosainoMQxHiFqZgQaKrgUUdqCsZS7f2EW+KEVFTl0D1
         cVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017606; x=1745622406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we1VCwvp+ME6JKyiG1rWZrby+S9dyNFYg/n6ab/For4=;
        b=bfF2WOz1oWzGY7t2Tvm6uG6vuF9UGbrBsSWZU4T4NOQ02pBbGwT0sIFmghyLqt5qJr
         YCfE9i7JgKsNU7JnNLsMYGttiyv5p1t//AjlVPh2CqmqjjtAl2X+FSSJPOpsPd+kQV4j
         TDDofq1PQW1UkztrjKt0ldu5LZvB0UAmxldpNrX0bp8C+vivZAi94xOrRVqXNXx4T4Wu
         1fZne8t3769KRvWH/hvsEZD8RTzGy5S5tQ8WRj+ib/C4G6dzi2j0/OIdTuzXnaHJ1K+f
         ew88di19BluhX/b25M83+cpSFkyAVvQHrymUBWJPUjbI3I7FXdUzEu0FlXhiqLDEKszf
         gpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJWyxADvklZf46q1ga3t6Yv9+0zxdjPMQhoYT1SmlJZ0N0i6pBGK1TSaeZiCiRosU8hZz+Aw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ySG2oEB3YZ8kRTQ8zIiME7kVJSOP6yyrvf5ugl94FVPhBp/E
	q3XCqAXHejEXn2rqZs/ES+0RqiEQUjQvD0GQvO0oechN3atWGOw1
X-Gm-Gg: ASbGncsGDccwyLU6OlCyT3UElzOkq+1/r3QgakC3Spu7gN4sADCSamD+m0NfOhpbLvK
	NBfRpTQM2ghEofgrAOFK/Wiy6gnhaaZyIGzfgqftilyGrbsqHiifV/iXDPsYLdLyDNAyDxZkZKs
	B3fiMTOdbLteq8+zJd9RjYMGwOgZtxaef6r5xFt/MnFlSkGCFqmhYzEDbxlbrRVr4Yzc/opczu9
	QzCipT+I7qj+FV+viq4ZNFwFhdpAe+TrZC/H18smIbzPh5ZjPp99um4dbMwiXEVLZbzY22a43Oa
	lBE/L8lHhpvTE3SVMJKsomAA9KkqpDBXFoftO0pGvXU3
X-Google-Smtp-Source: AGHT+IEkAa88rrcL9IGwFin2knQePXnKNBg53g6xfbPcXX9JmK36sxCwiSmpIJ3lj/RIfN3Fi5FTtg==
X-Received: by 2002:a5d:598b:0:b0:39c:cc7:3c97 with SMTP id ffacd0b85a97d-39efbaf133dmr3267333f8f.50.1745017606259;
        Fri, 18 Apr 2025 16:06:46 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6e0183sm38695935e9.37.2025.04.18.16.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 16:06:45 -0700 (PDT)
Message-ID: <e663a309-fd43-42bd-8778-5c62803b01b6@gmail.com>
Date: Sat, 19 Apr 2025 02:07:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Slark Xiao <slark_xiao@163.com>, Muhammad Nuzaihan <zaihan@unrealasia.net>,
 Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-5-ryazanov.s.a@gmail.com>
 <CAFEp6-2cfVnpr9A6YOjLO-tpPTs-5jdifHOmHupc83KFZ=8UcQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-2cfVnpr9A6YOjLO-tpPTs-5jdifHOmHupc83KFZ=8UcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.04.2025 23:41, Loic Poulain wrote:
> On Wed, Apr 9, 2025 at 1:31 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
[...]
>> +static int wwan_port_register_gnss(struct wwan_port *port)
>> +{
>> +       /* NB: for now we support only NMEA WWAN port type, so hardcode
>> +        * the GNSS port type. If more GNSS WWAN port types will be added,
>> +        * then we should dynamically mapt WWAN port type to GNSS type.
> 
> typo: mapt

Nice catch. Will fix it.

--
Sergey

