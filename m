Return-Path: <netdev+bounces-175758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38DA6762F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78333B5106
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4FB20DD5C;
	Tue, 18 Mar 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HlnCkwqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FB20DD66
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307590; cv=none; b=dl1z1cjm6w32hg8mpVBDwSTPGB1atW5zyZw3ve9IfeIZ/FxxzrrOXGOVH1TLRr/kFVcxtGqDs979NjX3auvXZjKzyxXVf1Dfk2lPKSm/1s/b4OOGW0a6M5SpjZCqRDlRtUT+FNG1+vKL6iua6HGbq+ow67u0j8bwWj0pbF0V7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307590; c=relaxed/simple;
	bh=LwdK4cAio+c4XPzFxixsBakLjkguIsyrzMWSdvBkGT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok1Um0fJaXWzTjgPpf0o/fnm4s+oImAspEAWo4PVipou+oFHvRC3SGiPoZvHDPGWPH59DDDkOI0dK/evUEYLME5RQqr8TktlCYtWNEbqjD2pM2qZq3r3JvMbIwGHYOOtt6i2izkE7IU8XejG55WXPrCHdtn6TMN1ju5Zdctv7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HlnCkwqz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a823036so31887275e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742307586; x=1742912386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcW461fWIOrqR0EfPHEDbo73au6FLAKwJwqQlrgqtds=;
        b=HlnCkwqz1Ud7K69/DXOcZlF4MsixFM1Bm8XNvYIj+PWlds9eIdU72OD4JIEZYw18Bl
         Oa7k4McoCniz0DS2pxQ+1Bwl9RZDNn/4yoqs6cGMxYXoSFpANdMOjPJAXeQhBhq2RYf0
         DN5kwlCaFahn03uP2KRJZZf/1eWqnPzyXSAUGoUpqWPAwx2Sk+ZbwYIwaHTqcFZSrshm
         ZdC5r/lMVYNzdcaRLriN2mSGNIbMNYTLTJajtkNeYONzVX0AzMx0ek2QOSPs7diU4AfQ
         fKYhIYamttdweFBi2TUheKf5f5WKj3oZySniVhw3frteJnE2cMZxvr71BpUOKNZkD5Vd
         xp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307586; x=1742912386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcW461fWIOrqR0EfPHEDbo73au6FLAKwJwqQlrgqtds=;
        b=X3mq8fJmJQ1nOn9isN8Tm6ovUs/rDv7KWpiGScVs/ysNbxyOUKcqaBcaNxgx+s93qj
         /FgVf2Q+O5jjodkl/63D8i/a43/jkDxw427jBWVQL/2jn2N80z7p/DQByCVefWSXt9zN
         HgjYsmqcotSglAnFJrBmXXYTDSTDd2tIKyd47wF2arbOKs6UtwnQRhnp3Q3Hhklka1F+
         PbGD2As8bpMOZp5ObNwfU9h74JNesxENJOW9/ckrydUNZbT+J+xB4khXLC2yWbr+ADN7
         qsbgzeUbU2CAyJ/0rCsE2nGTIP3oX+ArrWFhsOzAdVlMiF7u1shB509gqNBWVQbhCZt4
         2YHA==
X-Gm-Message-State: AOJu0YyojZ65fLojwhEdw47iNmPQGEw4J/234SzzOsY5Y3G+Qnq415eF
	6FyUPSDT45xsQ9SZPIAkDxMD+yawNbBVKN4OmZZs0SeGpo8qIaN1QF7qZDxxDe0=
X-Gm-Gg: ASbGncsSxJH4edtXhSNWJPUg/LpVnhGFDpHYpr2ms2UqGxVvcKZhpGIW6USTI89umNP
	IwuKGV0VGfZdhMM2UqMWnLi0LfECDMUpq4SQJW7ERo1UwE02F1utu6hQA8l2/Qp/rp4xot6XxW9
	B5yOjhGTIhnIrzZPKqhNZGDqflc3N/lM/KqPZskh5Lkgi432TyWAkKRkZvrXViO1LCjO4xfOtW+
	eD8+2pa2bhHIxwxZx7qfwnWqHuUW7TYbxIUAXMpG97dWOecIcO64qiM2DDqVW8y3teb24ZnG2UR
	cXTTu7Am3Cp5Nd1477wy6ufGBRvudVRfjdRzkiZtu8kirLu817XcmrZzB4SfbaOBaWVMIgFTCiz
	0
X-Google-Smtp-Source: AGHT+IFCucj8Kk0A7KhbxVUEF7ig41IEyOfhW9+fMhWIhWn0LJ2WS5rgi/0ul7AIDysYo8aGjUygwQ==
X-Received: by 2002:a05:600c:35c3:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43d3b99edcdmr23937615e9.12.1742307585694;
        Tue, 18 Mar 2025 07:19:45 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62c1sm136437475e9.4.2025.03.18.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:19:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:19:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, dakr@kernel.org, rafael@kernel.org, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, cratiu@nvidia.com, 
	jacob.e.keller@intel.com, konrad.knitter@intel.com, cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <uegesbo7pz5hrzdpepaiecltryrxlf65d3wofi5e36ivxvded7@2qfjdh73qiby>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031826-scoff-retake-787a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031826-scoff-retake-787a@gregkh>

Tue, Mar 18, 2025 at 02:46:56PM +0100, gregkh@linuxfoundation.org wrote:
>On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -744,7 +744,7 @@ static inline void __module_get(struct module *module)
>>  /* This is a #define so the string doesn't get put in every .o file */
>>  #define module_name(mod)			\
>>  ({						\
>> -	struct module *__mod = (mod);		\
>> +	const struct module *__mod = (mod);	\
>>  	__mod ? __mod->name : "kernel";		\
>>  })
>
>This feels like it should be a separate change, right?  Doesn't have to
>do with this patch.

True. Will split.

>
>greg k-h

