Return-Path: <netdev+bounces-211180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEF8B1707D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA835685D2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16F2BEC4A;
	Thu, 31 Jul 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUp5JMR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A192288F9
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962263; cv=none; b=UrQRTqEeiKxNsajNQPVTB1+Y3ftelIUBaJbxZASNYguZXEtcBNzuK/hR6x1qo2tUfbMiAabmpn/jTekwXapHWX8riGrsWInhldWbqwbE5BzRAQcnI6pzhrcGBweIQ6/JI/WNCJ6uknVMPRncdWk3ZMtxbdxqutZ9D11RG79BI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962263; c=relaxed/simple;
	bh=Czu5MVPjA2RBeqj5CrAYh3uZ0Ued/qRcMT30a57P1Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7SSJpyOoH5jPM9QY1RmJ1KHNW1um6hf643dcp6vywuVAF6aWAhaPkAd2SDMHu9LSS32D+Ex+6DA7zIJ73cOaBBxtszEGA7/cU060wekzSJRNnHXGoB0CAGWYZ/AbIysfIntvYM1SEAd3yuHXJB/kksKdcUXVVhoV3zqf02aEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUp5JMR6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455d297be1bso1003935e9.3
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753962258; x=1754567058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ8BkS8WtLt8OmcaE77eVXAnzRrTMqH1t9Yk7pttdDw=;
        b=WUp5JMR6etTyE/heNT+2TNFHPwK9XooWSVOR5/IPxmIZGdbG+eqXkemqQYTiLIDLRA
         WizGRakLVPuMSoRGRDSZ8onUuZTUa7do2YjkHLAdijMFre8CTyFNT1NOSCT/PMVDK82v
         08o5tPQOr0fdoLThRiGo9t9+Ko37SxR5ZbZFyz7Opd88tyX1Uoq22mpRa/hCBKiT2ujY
         swYd7z3RD9z5/7LnbzXGX6MrLZrxdy8zUuS7rcjRYTvqzy8/hVHXwdId/ekba0KlzR0F
         +/6ppq9ssGedAfEZzPaznpES8XeJEGnue1ipvxt07EzrRodAuxMO4eaUPZpgqPupIQpz
         0OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962258; x=1754567058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ8BkS8WtLt8OmcaE77eVXAnzRrTMqH1t9Yk7pttdDw=;
        b=pNhIlpYtI1J2ywvqKCbUdT9MGaHNa4ZiqNoXtSC50gkvX40PGe70MFTvo/DeYUzQIk
         JWNuGPZvSYJb2tHvKNo7opuicUU5Gzf1B2QtTHvUTAhRhPLs3VHRRN72eyX5FNBqkSfc
         l9c2y1xol3tIwVhYzjl0CjIMlWQbQwSd4Fs43KWfPwJxkPnj0WTrwnY+hv2IsfPE6ilQ
         wqsPWwr5Xz91H/cZWD2Y55vI1IaiXV8ZlexFFgen7Y6Y0/tXbiwzAXIngIVJ+PYF+O9O
         Ngd+CVeUXPg5+Bp6D7ksxUPy7/r6O+Y+LTP02i2V5hl6JTMtL8wsjgGqylr9uLerVppP
         1aVA==
X-Gm-Message-State: AOJu0YyI2nyWrOuJ2Nu3R+V014qKRIvMuS56utrXLkZY33ki6mO2fgBf
	V7KAma3Di/St0o93cFdyzdn3JrN6208kIZPj62ayzHl3Vim9cQwGM0bG
X-Gm-Gg: ASbGncuvmnx97VlalJX8jt57FerZ1iDqYruZUskH/47Nl5S1oxngUYNfZf+wKOSJcB6
	iKO+Z/SOaRoQLwLCA7NPbPc2PGuKQfogPli2MA0fygS5V89VDfeyEf83G032p6i6pLmaxY+D5BZ
	bkDt/cyVoc1Hi0ofrobi22oJSKSQoKE2DoH1PqNPDNqecUR2iC+eTaOTXY5Eh09/me8YfcQGEBi
	U34cytFxqjD35ixqhMuuPLA/PGI1J17ndN7Pkz0smD/O6O+FOFHKpjVzuM4Oz5yNPTWg4llnH/c
	KGPBXYNPOmPdakKdK8sjzJPBwJ+TCbQc5pZOngr+ZMzZF6BDRfu3YwL0CvmUbvN2k6PNvfrM7rp
	GpktnkT81e2nH1Q==
X-Google-Smtp-Source: AGHT+IE2uyL5WF97GpqEJRV4oF+s1RmzgVxbtLYr28hhuKKys+UhLlgj9bohgUJEYeRvsSr4IGAGLg==
X-Received: by 2002:a05:600c:3b16:b0:453:78fd:1769 with SMTP id 5b1f17b1804b1-45892d03a30mr25376135e9.4.1753962257425;
        Thu, 31 Jul 2025 04:44:17 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:97a:e6c7:bad3:aa51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfd983sm23822555e9.13.2025.07.31.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:44:16 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:44:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Subject: Re: [PATCH v2 net-next] net: dsa: validate source trunk against
 lags_len
Message-ID: <20250731114414.2ofpam6rt3krmjp4@skbuf>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <5E37B372-015B-4B19-92E9-7212C33D59C5@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E37B372-015B-4B19-92E9-7212C33D59C5@padl.com>

On Thu, Jul 31, 2025 at 07:56:37PM +1000, Luke Howard wrote:
> A DSA frame with an invalid source trunk ID could cause an out-of-bounds
> read access of dst->lags.
> 
> Add a check to dsa_lag_by_id() to validate the LAG ID is not zero, and is
> less than or equal to dst->lags_len. (The LAG ID is derived by adding one
> to the source trunk ID.)
> 
> Note: this is in the fast path for any frames within a trunk.
> 
> Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets from LAG devices")
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---

1. You need to carry over previous review tags (like from Dawid Osuchowski)
when you send new patch versions.

2. As mentioned in the comments to the previous change, you can submit
patches with a Fixes tag to 'net-next' only if the fixed commit is
exclusively present in net-next. Not the case here.

3. The discussion on v1 is still ongoing, you shouldn't have posted v2
within one minute of replying to the v1 comments. Further changes will
have to be made at least to the commit message of this patch, let's
discuss them back on v1 after we have more data.

pw-bot: changes-requested

