Return-Path: <netdev+bounces-186665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B209FAA0441
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE7B17BF7C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61D27586F;
	Tue, 29 Apr 2025 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E7sDr1QX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC018F49
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911251; cv=none; b=q/uwotPnfp0e7axdVkh57thi0SgaYMocCS9d6hR1MpVRyNdtSw5Lsjn6hlrAq9VguN7APJaTP5HQ4O5ARkC1kQmi+vi2gOrNYaDpS/Jmoa0SeLXvzhCiz3ZTBbX3RFOFnFHKjNsEt2ykU5Pd7ioTKJFbCJIEv88FxuZ7fMsDYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911251; c=relaxed/simple;
	bh=B1ec+jcFzN1W7hUKdsPD3Er2KG379WUGF9+R0/FEYoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2XusAXsh3SHM2IGi6T79pAHKkNBKY9QhkLSOwXzBCFFI9Dq52TwWSixJ0uuTjTIByNxUwuItUBNNhy1iRbA6LYoNgC0hG0+maSl57NEOTwJxY+/9HVEFER3PYRbhD3KRf4jrANqdDbfUcHfjxDWpR04TeiBXB+rEWWfJgjqpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E7sDr1QX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6620051f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745911248; x=1746516048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqvKIYq1NuKmOdAGt8rN4h3bBU/UsxP9dRBv4A0Ap+k=;
        b=E7sDr1QXRl9+hea3GsZ7G0pCyssfhvBrbiq1uoWfvcmvrZwOUgIXkmhryVg75orx0v
         bdwdw/iGHxwtfQjaF15ImaH+KG/L7H1RReu2cgrh/GC0lXcZVl1ahpVlxQGl4MHSWqdE
         Tl/+3g2woZMo4IRtHR6LtlJlqsJEimEgWmLbM5Fcg9ui0eHpG6QMh0SinmMkCImO/biP
         Uyxh1VZN2kqOnv8MhmI9Ub6Xzo/6FIWl+y0mBMos8w40VoQmaOSI0dd1Ki1e/bwB78uA
         fnIHdgUHsIRfYECi2GkVT9Wb4/mcEGuLxMLX7aq3PuCqBo9C6UOTTd15IPgkydFp2hu+
         +xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745911248; x=1746516048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqvKIYq1NuKmOdAGt8rN4h3bBU/UsxP9dRBv4A0Ap+k=;
        b=ponpy9Q0H9GglYv5gEy+ELBy4W+sMweavwQ9JtP1CNpLizkAFLIRRwoq3D7Vj7MbWw
         HFV0bmR/IU8img/C+wQzouSuvvbmtVZIUYOzwgD/cnoZml3DURqP1VUkxUW1MnZi099v
         YQTtjV88QkFOXkvHZt2Yb8xjt47fynXMcznmM37W50gISj0dOTydzRguns0Z9HASE4h1
         MpRNhTAWTET0aQM7+ZpeQmJOW/LoeXhMMoGD6ZZKZHLZxXPjWEzt2bqEIvUTptgnqfXn
         qs8sgsQNESQO8FYZBFlQhPIoClAPfi9sobdQhIYRLrsye8gWuuiRjqyQG82sfUaGElr4
         qRSA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4JpCxiJVos0eCYkB1UhJc3nNKhK6ITG591ICeOlIr/CImOCbT0Ww0twXU3vCya/LzMwgSb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTyl4/tWjlexgxmT9gI4aINcoZH6pBZVrFuZyhzuJj6N9ioZY
	odu3ZaylJfps6Yq7TkkTADiCStcLwOgSdAmDdUiw2D5I07cqZwbv87pnzjra8Hs=
X-Gm-Gg: ASbGncuOYblBJDFf3vCcI0+NEs3l4pE6baMbqr+Qti3aGeiFe30yXQV1cbHvQBZHwPm
	qQyzoscx01x8X4dh77prXinRTi16tM+/XP1l8dCgUlfdmUT7KATy6t4xcH1OOFf5TV9BXujjXtY
	3ZnlLJ93FYX5PFsddHfetplLnYO+rv2OTfSAjwe9zN3ikynhnh1bctPRYTcvPSPeSSRB4gyhH+g
	tn8qEN2f/9he767VLQHsfm1AttPThkqDi4R6Dkkh3HZ62biE+GsXT0cS5C8inFyY21j1qglt2rg
	hARGcm5B75u5wjYzTm1l8JcCT/mek6zAXQmWlVMe4Snx47OW
X-Google-Smtp-Source: AGHT+IFNumkg59JobgDibSCskolZ2mqY9elL3H0Oe7LfiUOTWATMAmKEdJiXThRZhflP9sctHzWlqg==
X-Received: by 2002:adf:f686:0:b0:3a0:8c45:d41b with SMTP id ffacd0b85a97d-3a08c45d420mr429290f8f.20.1745911248013;
        Tue, 29 Apr 2025 00:20:48 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c7d1sm12985613f8f.83.2025.04.29.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 00:20:47 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:20:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 02/15] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <ospcqxhtsx62h4zktieruueip7uighwzaeagyohuhpd5m3s4gw@ec4oxjsu4isy>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-3-saeed@kernel.org>
 <20250428161031.2e64b41f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428161031.2e64b41f@kernel.org>

Tue, Apr 29, 2025 at 01:10:31AM +0200, kuba@kernel.org wrote:
>On Fri, 25 Apr 2025 14:47:55 -0700 Saeed Mahameed wrote:
>> +/**
>> + * enum devlink_var_attr_type - Dynamic attribute type type.
>
>we no longer have "dynamic" in the name
>
>> + */
>> +enum devlink_var_attr_type {
>> +	/* Following values relate to the internal NLA_* values */
>> +	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
>> +	DEVLINK_VAR_ATTR_TYPE_U16,
>> +	DEVLINK_VAR_ATTR_TYPE_U32,
>> +	DEVLINK_VAR_ATTR_TYPE_U64,
>> +	DEVLINK_VAR_ATTR_TYPE_STRING,
>> +	DEVLINK_VAR_ATTR_TYPE_FLAG,
>> +	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
>> +	DEVLINK_VAR_ATTR_TYPE_BINARY,
>> +	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>> +	/* Any possible custom types, unrelated to NLA_* values go below */
>> +};
>> +
>>  enum devlink_attr {
>>  	/* don't change the order or add anything between, this is ABI! */
>>  	DEVLINK_ATTR_UNSPEC,
>
>>  static int
>> -devlink_param_type_to_nla_type(enum devlink_param_type param_type)
>> +devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
>>  {
>>  	switch (param_type) {
>>  	case DEVLINK_PARAM_TYPE_U8:
>> -		return NLA_U8;
>> +		return DEVLINK_VAR_ATTR_TYPE_U8;
>>  	case DEVLINK_PARAM_TYPE_U16:
>> -		return NLA_U16;
>> +		return DEVLINK_VAR_ATTR_TYPE_U16;
>>  	case DEVLINK_PARAM_TYPE_U32:
>> -		return NLA_U32;
>> +		return DEVLINK_VAR_ATTR_TYPE_U32;
>>  	case DEVLINK_PARAM_TYPE_STRING:
>> -		return NLA_STRING;
>> +		return DEVLINK_VAR_ATTR_TYPE_STRING;
>>  	case DEVLINK_PARAM_TYPE_BOOL:
>> -		return NLA_FLAG;
>> +		return DEVLINK_VAR_ATTR_TYPE_FLAG;
>>  	default:
>>  		return -EINVAL;
>
>Why do you keep the DEVLINK_PARAM_TYPE_* defines around?
>IMO it'd be fine to just use them directly instead of adding 
>the new enum, fmsg notwithstanding. But failing that we can rename 
>in the existing in-tree users to DEVLINK_VAR_ATTR_TYPE_* right?
>What does this translating back and forth buy us?

Sure, I can do that in a separate patch. I think I will send these
patchset separatelly prior to Saeed's patchset.

>

