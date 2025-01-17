Return-Path: <netdev+bounces-159349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B5A1532E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F527A103D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F731199939;
	Fri, 17 Jan 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJDD7DYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EED530
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129068; cv=none; b=RTBlaSB/8oeig52PRlmdDWbSX/9imHyLaBg3vkbJRN6Qat/CWiutKCuVVGXX9mSFK2MrA8RTZKlIgPe5mhclcfT7/QuJkGOL4VtNLFsvP4lfxmZ0pAXbQ0LIJvyo3pbwQFUICJ7g+4LzHt9SdI6gL2jh7hrvWK0vt3iq7NmxtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129068; c=relaxed/simple;
	bh=NLOKe1cn4s1nhdC+c6FVNXIoe8otKZmXdhkGLadnNXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1UOokxjjdqaVehyHQfEmEyfMJ4DL0LU6BnwibgfxDVTl8E97P+a1ielDR5gJq9NbDmvPHv8hL4gJEziz/Te01iETaOkxOKkCbwcw4tejkteO7laVmQNb6sjQydyJaeGMGV60G7C69ElRdMVlVnMpEcYlIpsYqL5vaz+Z55sjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJDD7DYZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso3257847a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737129066; x=1737733866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2K8irbhpzuleKwuIRA6iSNUh1BWOFDfxjXCiHmU0Y=;
        b=bJDD7DYZ8JyvZSMp7Vj/fmXK170k+ZpG796f9vUEJiTfLwZROGGV0JTVvyAL1zZfQT
         8nI5HJ9ZGl039FmmLd0XaRhv/3/gbJZduWcuNg4i8MHRbAltUh0rXcDH+Cu0w0PXPgAd
         K7VeaqYkXSymivCZvfIStaOyMZwM3vAXEZe64mD9+FbccAnw9Xfjg+iqLOGtVTyQEKIn
         MGr2XI/acS54P3VPPC00jhYVX+mExG93wNuOP00w7vc0Vh3d7ldPALCEasen1NZCG0JC
         gbcRUwk5ZBzjMVP1GuuQu7Km/wqLXQEpd2Zjb+n0Zr2jH2EBo15DMV1IcSNT2GaZLQA+
         aJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129066; x=1737733866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x2K8irbhpzuleKwuIRA6iSNUh1BWOFDfxjXCiHmU0Y=;
        b=eoYmHJQXeBtp/6YQFAXHle13/8sa/VyJoMkpeX3e4DfmNUCqYG2rjmAXtw1EJwyZSR
         sFvpu6s3XtsULJjwAJFRuq9Gvc7BIujLuJraA0x+U8XR6csydfBLNuXfULN0ortJgZAc
         5y0cAJHWisiIOiX43zO/+XNycPHDgxUpgomSHgA3Dyg+bufZdNYC8qwVLLK8W5jM/hfA
         n2sOwUbKlcHKknEEEq3YYMID5HytRFh/ik5QG74Un3l9u53TcwrLKikGlnnP0p1vwaML
         Ixb470NNUHwhcA/Z5PIleux/v+5HmfwT9oRa2E6efdNK1fxnkS+sh/Kx8lGtKpc4w1TD
         2/JA==
X-Forwarded-Encrypted: i=1; AJvYcCWTv+yCqxBxLfDLYUc+86CdkMJLsq8NjsLY3h8sEcn9H83SFBH/qpbwq8o11VFwWLf8btgMy6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcaDLeuuD+M5IMD3r0yqXmdbqL9xz53oWIi5HeO1Ids/wdIK7
	fsgHWcDcBnhmq1NJsqtUpwUJSsts29S6xEvALAOZD/UCiGoqawgw
X-Gm-Gg: ASbGncsI8Sf6bbrICfPeM37Cj489fGGbrIJjRSvPX6oCAH/xvVNZSgvZshqTRcKpSwJ
	mtNBcaT0W+VUHc31u6ku9dYnzA9YNCeZqoFQJNvsUGQ9CkpNvRuCdd+4JcGnC7XxHvddeMioRt+
	FGyHBFeKirrYZw0UetabrSLTimCT2m5teK/0inm/+NfhS9dyEyhMQlV33YHagxBI0NGh7H4kYnY
	Z7o0PqyxCD7WEH3/Kt0/i/vLPBgT7kNKFnZPrU8kcAupDtl7geqWeKpFgRPVU8i766axlpm+TlK
X-Google-Smtp-Source: AGHT+IEcq+IczZIbXYhGrBDhw2EPZszsH4NUM/TXJmfRT+nkDUlBD9nBo7gNtq8CpCo9w9EBGQiQAQ==
X-Received: by 2002:a17:90b:1f81:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2f782d9a170mr3876868a91.32.1737129065866;
        Fri, 17 Jan 2025 07:51:05 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cc2a2sm5900901a91.27.2025.01.17.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:51:05 -0800 (PST)
Date: Fri, 17 Jan 2025 07:51:02 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
Message-ID: <Z4p8ZuQaUe86Em9_@hoboy.vegasvil.org>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
 <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>

On Fri, Jan 17, 2025 at 02:15:01PM +0000, Vadim Fedorenko wrote:

> there is no way ptp_clock_register() will return NULL,

Really?

include/linux/ptp_clock_kernel.h:

 400 static inline struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 401                                                    struct device *parent)
 402 { return NULL; }

Also, sometimes the kernelDoc comments are correct, like in this case:

 304 /**
 305  * ptp_clock_register() - register a PTP hardware clock driver
 306  *
 307  * @info:   Structure describing the new clock.
 308  * @parent: Pointer to the parent device of the new clock.
 309  *
 310  * Returns a valid pointer on success or PTR_ERR on failure.  If PHC
 311  * support is missing at the configuration level, this function
 312  * returns NULL, and drivers are expected to gracefully handle that
 313  * case separately.
 314  */


Thanks,
Richard

