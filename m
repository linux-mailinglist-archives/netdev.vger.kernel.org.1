Return-Path: <netdev+bounces-186727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4016AA09E0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309F71B65193
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDBE2C17AC;
	Tue, 29 Apr 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="txA6Yruw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEA29DB8D
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926504; cv=none; b=p8YETbp4KhbAyK9PLXXtoVFH2tgHh5m4wjrOIKJEOhPkitcHYklS/V8lzgjl6sRoI+nwFCXZePkWynYrfWgza/oHANRt7lFfGqNvMn/XAv6L1YvBubBD8c8ryCyY347Kn2xG07s+aaC23beGThtqRKLdKfmVU3jUdyyqdxs9M/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926504; c=relaxed/simple;
	bh=pVE+TS3UFmo22UMkEa2+Hs0xhwwQ9GwiJ5XYAhW6OW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoeS54YkpeU0YkkYED5LaH+0g+sqZBZ6pwfC6L2RlmOcfES7aGSpLXRgWP2lQxsKrxIcXJmwSl6HTn2qeBFDFxMSkmAcSmlmSX6WEfTVcyObyd7Ksbia0lSIhsEiQ/zNZXJs/LIOO/APSha74regBOyxBzmRVDLdPmsppDP8N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=txA6Yruw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so49255605e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745926500; x=1746531300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdeLMSXfLsPfIkuKL3CYMpFq7DN5R1rUsOpR1/VAQ2Y=;
        b=txA6YruwDVb5CqeZdAmdTGVvZW+rkquTBiHHhuRkKoMxEKGNLDpfXo3y9EiHr+3XOz
         BczsJUKeEfRS5WsTteznv79a59F8UtYByaGurxBNGMAAqkmRxo/Sx5NmE3aaos/3GasM
         1UuMbaeD4e5L3Ewg1C7PXBpAy3MJ0aAIMrqvhU6wyHoZ97kT1HE1Y2JU0tfzwRAsZJIh
         Cmky5jPzReHN57XpMuqPSwxIYJ6cKPnJAezbSG7pje7f395dezsdMzQadoFA6fvwXYdr
         JAhnUgnPTI0UQEU1pv9x3uk03fUmJAuhNdt6VvGigexPrq6/aqu83T6BGRWGjGhBMBSr
         jxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745926500; x=1746531300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdeLMSXfLsPfIkuKL3CYMpFq7DN5R1rUsOpR1/VAQ2Y=;
        b=IDrJpzeFdtQaZ1xKiwSr/1D0uakcdOUxCDfGkZOqXHvo3oCuSGq94INzTcnxZj3giR
         m3LJf57ZN5MoXLLWf3LL2BX/0HDNe1XRnRE8BOefZp4beBGoN3RQ25Pg87E/zs7F9wk3
         SMCF3iU/Vevemee4lsVC2HQAbD/xqZOqUS5hzhG5MZeL5mHS6ymwye3GaLvRuy5pa0OM
         Rso1MEPcR91/p2V5jYZpGFmsri+Blo1X1Dnb4NDjEhWpjQiDeEDchO0Ryd2J5eBMFfKr
         pt4E2nXIWovAAM2Q5hytU9UeY7JQA9pb1St4BOQXLWAErg/20t9l4+s70ObXV6KD0IB9
         4iNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR39Hu1H5BELXZuqSbUnuGpIANkd9+hfXs7HGK6zZCDcoob9gDmgpYEdtyPm09Nrb9E44IoE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iI+fl+O+0cYL1Exj1cuBO1M5+GDpphDsPvwlentQ+vHvyqLl
	CDDiLQy/yq86P2AGyoTsrAuvuao7ycieq2z2VXuC9CIYubhvGWLUaSHywQLBptA=
X-Gm-Gg: ASbGncud3FHKaWRxFDujuSjRCe3CBdmT1aU/dW/xN/7PGsFqPttF8LX7yCfbsK4h1wR
	Q43Bw9J/h/wvhgEGA++sBIv7yE6iRU9jmhs/Oq+mzxxyH+waVtfFHDZ4BKcaJ/8S1VUMM+dhDWM
	u0X0knY+6u2kU7seWlpNHZSMelX0idwUUOHD3Oz/Ejnyz3O+GXkKeNp5LIjm9n3JmUUw1TrzNy8
	OI1n/9Qun/zz6i0wQAtDzjILQYwlMHjXn87EcDpSvDuByt5HGLCES+QWWU5ZdmvngveVd0RD+Xv
	N48b2BAt4+w7U1eOmrSku+XL0IuQEjDNt6iq1/eiuijr6vt/WwiBg+BfWuypFwrrGLtB
X-Google-Smtp-Source: AGHT+IH0VbMXgmjJHZdWbrj5HO86BmznBkXT2FSqE+ixt8hbPQWyY3/WwY9MgR1MAhU41dlc3y61yA==
X-Received: by 2002:a05:600c:4711:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-441acb462c8mr20729015e9.10.1745926500515;
        Tue, 29 Apr 2025 04:35:00 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2abf73sm186503325e9.20.2025.04.29.04.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:35:00 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:34:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-15-saeed@kernel.org>
 <20250428161732.43472b2a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428161732.43472b2a@kernel.org>

Tue, Apr 29, 2025 at 01:17:32AM +0200, kuba@kernel.org wrote:
>On Fri, 25 Apr 2025 14:48:07 -0700 Saeed Mahameed wrote:
>> +	case DEVLINK_PARAM_TYPE_ARR_U32:
>> +		len = 0;
>> +		nla_for_each_attr_type(param_data,
>> +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
>> +				       genlmsg_data(info->genlhdr),
>> +				       genlmsg_len(info->genlhdr), rem) {
>> +			if (nla_len(param_data) != sizeof(u32)) {
>> +				NL_SET_ERR_MSG_MOD(extack,
>> +						   "Array element size must be 4 bytes");
>> +				return -EINVAL;
>> +			}
>> +			if (++len > __DEVLINK_PARAM_MAX_ARRAY_SIZE) {
>> +				NL_SET_ERR_MSG_MOD(extack,
>> +						   "Array size exceeds maximum");
>> +				return -EINVAL;
>> +			}
>> +		}
>> +		if (len)
>> +			return 0;
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Value array must have at least one entry");
>> +		break;
>
>I'd really rather not build any more complexity into this funny
>indirect attribute construct. Do you have many more arrays to expose?

How else do you imagine to expose arrays in params?
Btw, why is it "funny"? I mean, if you would be designing it from
scratch, how would you do that (params with multiple types) differently?
From netlink perspective there's nothing wrong with it, is it?

