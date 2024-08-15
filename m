Return-Path: <netdev+bounces-118702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F309595284B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B745F2830AE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903A179BD;
	Thu, 15 Aug 2024 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SITWaFlr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313ABAD5A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692811; cv=none; b=bWYEemk+ZY5WVW8lzYurgi+/rm9GQUHigkl4rAln9cTT7zFlfPnP/6pr/iU9dH87EgnhHcj2lrk6y4EHrwEUmBgT/KqkrPnhK/pxoLnD1hU2qs1ZqyQCn3egaYzkQWpJJaSXtHPsOHXewsN3NfSAf0mUTitURYxetF4QXlGX1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692811; c=relaxed/simple;
	bh=ERhNLA/iM5v1ARLOrtA/An1a4AW8+5QtZLhMpO8Tb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlyxwlXKgXIGAl/rAnjBPgEv30mTRyR4JQvWY38CferoTTAP8DBn88vLU5jCBJq3j/8gVfJqj50M9CeMcaCr+WzsME7LKC9d+C28Gf6hhdLbxFDXksOS2i3V1ZR6FwKdK9lT8gRcvkgNDlpR5nIHuK/FK/XQTQzuvX9+ZzvMeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SITWaFlr; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25075f3f472so152197fac.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723692809; x=1724297609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERhNLA/iM5v1ARLOrtA/An1a4AW8+5QtZLhMpO8Tb0Q=;
        b=SITWaFlrnzymDRxer13Um3Kyu0TRRf23/6t54yegSmCT/IUcSBp7NO+WwYx+invzj6
         6MHdk8RSUgOQv6ttQKSQMAwHttBw0Xoqub9W40tIdoRgEWNWTDFCfj3JLkU7gnmbaEjc
         79rwDwh+jRN0sX8Vrcdf/nGWtrFYqVKwre+1lRaAVSah6hoc05Ea5Lytu4Ku/t+Hmb/t
         WlArjJKPJnuw+arOCIY+R04XLa3m7+FWmnreqddEq4NVjkgZIyQE08rl6J0g1IQ60Fjl
         3ASCGAUuRd8NZAplLIjZtSG4PJpzHOT/fjQZvpgFV6/P621lyOtQaHZOW5prcQHvv4En
         BXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692809; x=1724297609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERhNLA/iM5v1ARLOrtA/An1a4AW8+5QtZLhMpO8Tb0Q=;
        b=DZDtV0QiQuqQban3SmIKfb7WnOi4CmNxzCpkLqtZMQruCnbIPLsRDuORiS5mXs+hWC
         AovblXOz8nAu4v4g0viAknSXKaK0Gjwh+EYXacF1qW3oGmTrPjnM2CgJwWRUgZpyMj48
         dGkPxnBTUN3uWBKHFvONGxRhj2k3Dnqe8PsalwpE/5AnSHFwPnaSke7uZSFJ11NxjT3C
         jcQM/2xN2bJVisoT2z5m2SapFtmGcFynvQMAZP+3ljUSzqjmQI+Jta1b5XS+4kg7ftHT
         ezJ26IAO+HZ4klhd1FYbpKPCPtjQHUstTv25zVPTv5gHYwGXQSGwarQ3TUgsnXKTF/gv
         qxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrr7Hsxh5mKA+fhyoIjvlUUTAQe3J+s4H6rsVzWFogYlVIEEWd7trhsiWcU1a9uxL+mzIiB94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAvW39BbGGoSLZZCtqxdkLng76zMkElA76WB17jrP1FEd5Ljv
	UJf1sk1joqliqG6zDgAMyI37iGUOakwmFBcRhqh1DD2/WQYUmyY/
X-Google-Smtp-Source: AGHT+IFWq8LtR4q9qOsmfF3V1Bbd1ccx/O/TebsQb/GNXgRXtSLAFgqXKPT9gc9UM0/u1RQ2LY92Tg==
X-Received: by 2002:a05:6870:56a3:b0:260:ccfd:b26f with SMTP id 586e51a60fabf-26fe5bf8677mr2870357fac.6.1723692809225;
        Wed, 14 Aug 2024 20:33:29 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1e773sm299210b3a.174.2024.08.14.20.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:33:28 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:33:26 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maciek Machnikowski <maciek@machnikowski.net>,
	netdev@vger.kernel.org, jacob.e.keller@intel.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr13BpeT1on0k7TN@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>

On Wed, Aug 14, 2024 at 03:08:07PM +0200, Andrew Lunn wrote:

> So the driver itself does not know its own error? It has to be told
> it, so it can report it back to user space. Then why bother, just put
> it directly into the ptp4l configuration file?

This way my first reaction as well.

Thanks,
Richard

