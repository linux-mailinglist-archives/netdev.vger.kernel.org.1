Return-Path: <netdev+bounces-70575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756DD84F9BF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E981C215B4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EDB768FA;
	Fri,  9 Feb 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="MVE0tdhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB941D6A6
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496668; cv=none; b=ee+zz9FYvTQrtLSOfD09CpjRfVUYnVtomHqbOPpuS8148VH1JWdxsib4NANHle06LWwJ9Uu8emj1npGsBi3g3VMPcPmVB+o4LD/vgEIrlazS1Unr+bC68tYsgPSc8d8dAXAnRAfIYYVytNzRk/Mrh5yw19bSvcjEOsVA/NYVec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496668; c=relaxed/simple;
	bh=/wHXxHZjolMVuoUQE0d22mdOD3Zj4ZWC7TvhRsgL2ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsL3vEFVNjWbRjnv3u7ZmYhJT5Hh+vSZ3LqVjWestHMGVCqr8fNwLi0hP0IRoRnfy4cocmCFbGMqDSnkrelU4IM3OV9CDsU8Cl0vQT6T8aTVzMKJ/OwQs0XjUsFxEyodD392VI43fxUuv3LF5Hmvx4J1IRnFcuT0mSlAVCNE2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=MVE0tdhr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7354ba334so9926765ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 08:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707496666; x=1708101466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHd8D7azHFg09o6rb4/4p/sFPvRBFsa4Ncj8yQPVTko=;
        b=MVE0tdhrv5zzMFT8RKoHoTBg7GC8KaxW63JqYCwczMDI8m9a83o9h9csrtYjz8WUQB
         2yO0O6sV0c3NG/YkYasOK1b90aWQmsar/AqGLeJdFYaXedpOzYjUJrfJ3ZT/8GNHwqR3
         JgiET2MNKoDbrGBjefGWfokWO13N2FqPhWUMGqJjFxwmmRxShcyl6BTpYGHl1PAc81dq
         l3zVE+B0HlMiszTJikjwVOy0JnOZuXsd1rY1/O7R5sz7lHr2cuvNc+PHyxqCgWUMgsex
         FwzLBwAdrWsgK2TFCiBTbEfv2EJDN6DcmI8ByYbqPiH6hWlv3oQwX83nOjUvOQ+uBDkb
         MAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496666; x=1708101466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHd8D7azHFg09o6rb4/4p/sFPvRBFsa4Ncj8yQPVTko=;
        b=T4ucI00UVPiyKHMwHMJ0br0J8mtsh5UYCTmk5iAUPOyibricZsP9127NWZn3oB7BYx
         /F0RNZ/CjbgwgZSMZIpWjx80rzrCNiWQ2Uv3dIylZ4KASP5nQ5DpRspWe/swSIGscqVs
         DsuZozg5WZemlAxTSBXk38QGnreWIm37F8WwRwt6zwb58p798eIDn7iA+WbGUfXFd2hB
         P5E0sc0VUpIPYaeK1z0RXfDfNALGbU8tX+xQWfMaeiM2uHrJQQ9bFY33Vmlr9BvnuK3z
         ciIc4jznyxw2cWUs1Q0nBr+8X9r6nVHw/+WSTUlZVSt2HreHtmD7TfeFKQfNm2+8cFxc
         vLfA==
X-Gm-Message-State: AOJu0YyVKyGhreG9wGVlGlZs14JfDV7ikE0T16Sx4m0wR7eI25g2HEUr
	4pAc0z5fFx+UgibueWHMzVga9FJ7CBrhXxF+sN979oml5GakqGQcMSuuJqgQSaia5UyeaGVmtU5
	dh6c=
X-Google-Smtp-Source: AGHT+IFC7SWKJham163ODwOlSpkTwxng5YHOCwVQ92HZQnroEn3ODMQ4tFTft1fOLtx/ZkjUkK18lQ==
X-Received: by 2002:a17:902:e983:b0:1d9:bf28:8bda with SMTP id f3-20020a170902e98300b001d9bf288bdamr2137244plb.68.1707496665815;
        Fri, 09 Feb 2024 08:37:45 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id lh5-20020a170903290500b001d8d56a8b9fsm1711902plb.105.2024.02.09.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:37:45 -0800 (PST)
Date: Fri, 9 Feb 2024 08:37:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] tc: Support json option in tc-fw.
Message-ID: <20240209083743.2bd1a90d@hermes.local>
In-Reply-To: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
References: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 14:22:50 +0000
Takanori Hirano <me@hrntknr.net> wrote:

> Fix json corruption when using the "-json" option in cases where tc-fw is set.
> 
> Signed-off-by: Takanori Hirano <me@hrntknr.net>

This looks correct, but there area a number of other places in the filter (f_XXX.c)
files that still are broken with JSON.



