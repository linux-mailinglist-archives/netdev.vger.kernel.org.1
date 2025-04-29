Return-Path: <netdev+bounces-186795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D12AA119D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D406692634B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BC23E340;
	Tue, 29 Apr 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JHgIfWkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4222FB2
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944393; cv=none; b=t0h/fJMYPUijU8Ir06mLB6ajtiNKXj3O835xZR1K+9+IAN9Ni7+hzoU66d9SW+9RdCuNinap0We2wNKGoen9d2XSduPmYMR0J5Ku1uUyEWqjw497sf5DP2AeoToXfc3k4/tev/DwkbB/PdGuo1YpMwD9o4mtIYqps/DOYYFBKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944393; c=relaxed/simple;
	bh=3l/J50LAxjzZIN0nBXmfVN0pXHb+Hs8oBaEtreimozs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah6grz+fQ0Tb0c7Z8ypX6JkRhbYi1FipnKgahuPlXKsQ4EE9tPssciHWIbpHqAsvy4ToNUTuyPphmNexB7hKfpLgYY+Q4q8Snv4vnSUn9jcmxxNTTzM08V7p+VGPhrUxFYmncR8QQ71TeQqDFpEv8gULOWUMFNcH8XGEfyxudOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JHgIfWkQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c30d9085aso4591357f8f.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745944388; x=1746549188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHwms0OLmRTXUiM+zOk6HXSX355HVOm9GG1Sq1Zbn2I=;
        b=JHgIfWkQ0sFqfhvtsTz/+ELX8+mNnuhkqVnUrQQp00iqXtIrOw7zW6dIWKRe0CBtTY
         R0QLVrSqr3ejdJYlfrjNfHO8q0pwZA3k9bT7gOc9oQSBnoEO9uqhx1uTahwM5simRw+t
         ipC3jLxOSEEqlX64D77Nrke2yu7/1iWfq0WKCI436WhBvn0YPATEjqgS9jlpseXUzxUd
         qs3BI+jFgK7rDnilzV+EQejZQ002l9MC8CpxSc1/APyRPobkYblPr3ho0JtJNzVChkLw
         rVlqqBQv5bmssMlTSqeY2CNaKAAzFaZRlwwQS3TVj0vpdIz0qDe4Yb5C+rsz0rIKHXMG
         4dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944388; x=1746549188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHwms0OLmRTXUiM+zOk6HXSX355HVOm9GG1Sq1Zbn2I=;
        b=qEPVfJ22gSLIRAS+orhFdSGDERO3IMeNDzjmyOTwe09sHYokfc05L3OBURu56uGREw
         dSItaxoiFwRk4klVURpryRWBp5Qnc5oBHFqxPx3D2imGWgj6r+T8ve/bHKD7R9RdCQkF
         h78szXgidcpML7fiWhVsEpzquRvsvn3ZxljSl8RoMkYeMAfw5j7+Jz7by9bCz0i4e980
         pRJOxzzbXPuHhLX85Rrj+st9uWaXFpvzybqm0CnJMQmzP/ArcqzwlIKYHME3dgNnIot1
         af1A59uTmHT/fAUOUvdzSZfpvfiX724FKVwv9uBXfBl5IR4JIAigIhzcx/XEvD8YZdEC
         mM2g==
X-Forwarded-Encrypted: i=1; AJvYcCVUmDNfwj7t68Fi5jy529v9OiVMO0p/+eLioIsk2Gl2sywg5rfvgfoiCXO6N00NyA1FI08P05U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXPUC8kfLjfqw5+YbqTiPCBvXWBiAFQK3MeBS6eAgzfR1qD9P
	5i1cRA2BMTuUNGnmTrIsKmlb1Oec+KkElnKWzeDyHC+r44fCH8Y00VE5YBXClx0=
X-Gm-Gg: ASbGncvEaG4MU12MG5x/pglaWG1hSXZAB9f+w0WTg/wcieobFXj+CBspM+b3yqyFa8/
	OQRRmZvDivXLCbjXJOvTYpEipiGrHLgxI25pJ31wlNtM+4341B8i4tMnsJSu9E0XdXW7P2vxjAu
	vUwJuJPshN3ZSm+M7m5mvqA4QZq4tCJHVQhx2hS1z/3ur8DpXsNZ4rBMza/smLwGspyhhBiXm+v
	2y/dy7YaKUnC/K123MQmHbbIxgxpBqZjdr2xuB9Qo07Imtt65ik8mf3eshhkfDxGOLXmwonzVKD
	vJDecbtZRSiiJ/IrTbz1BrszZvcCNQNRBtTzuJR4yQizL35x7WLeMM1E6gP9r1ndSyqK
X-Google-Smtp-Source: AGHT+IGbSS46/RQN8/ySUrEXm3UXESFHhkFDgqJLMCUVnarUc4CfPSaleX1KNdCKtSFPtQ+BpDHFtA==
X-Received: by 2002:a5d:584f:0:b0:391:4559:8761 with SMTP id ffacd0b85a97d-3a08f7a3021mr21683f8f.36.1745944388229;
        Tue, 29 Apr 2025 09:33:08 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8c95dsm14134636f8f.3.2025.04.29.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:33:07 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:33:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <pdk3mppsxfyuot7cfej2xy5xfszcyqyme2i6l2uqr3pnmgp22d@6zf74g2qwhol>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-15-saeed@kernel.org>
 <20250428161732.43472b2a@kernel.org>
 <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
 <b7a4d9cf-2606-4d0f-8164-ae3e05069388@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a4d9cf-2606-4d0f-8164-ae3e05069388@intel.com>

Tue, Apr 29, 2025 at 03:54:53PM +0200, przemyslaw.kitszel@intel.com wrote:
>On 4/29/25 13:34, Jiri Pirko wrote:
>> Tue, Apr 29, 2025 at 01:17:32AM +0200, kuba@kernel.org wrote:
>> > On Fri, 25 Apr 2025 14:48:07 -0700 Saeed Mahameed wrote:
>> > > +	case DEVLINK_PARAM_TYPE_ARR_U32:
>> > > +		len = 0;
>> > > +		nla_for_each_attr_type(param_data,
>> > > +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
>> > > +				       genlmsg_data(info->genlhdr),
>> > > +				       genlmsg_len(info->genlhdr), rem) {
>> > > +			if (nla_len(param_data) != sizeof(u32)) {
>> > > +				NL_SET_ERR_MSG_MOD(extack,
>> > > +						   "Array element size must be 4 bytes");
>> > > +				return -EINVAL;
>> > > +			}
>> > > +			if (++len > __DEVLINK_PARAM_MAX_ARRAY_SIZE) {
>> > > +				NL_SET_ERR_MSG_MOD(extack,
>> > > +						   "Array size exceeds maximum");
>> > > +				return -EINVAL;
>> > > +			}
>> > > +		}
>> > > +		if (len)
>> > > +			return 0;
>> > > +		NL_SET_ERR_MSG_MOD(extack,
>> > > +				   "Value array must have at least one entry");
>> > > +		break;
>> > 
>> > I'd really rather not build any more complexity into this funny
>> > indirect attribute construct. Do you have many more arrays to expose?
>> 
>> How else do you imagine to expose arrays in params?
>> Btw, why is it "funny"? I mean, if you would be designing it from
>> scratch, how would you do that (params with multiple types) differently?
>>  From netlink perspective there's nothing wrong with it, is it?
>> 
>
>I would put name, type (array of u32's), array len, then the content.

Isn't that exactly what we do here in devlink params? Am I missing
something?

