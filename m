Return-Path: <netdev+bounces-228281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3ABC65D1
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1196A4E4DF0
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9542C08D1;
	Wed,  8 Oct 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHHaSAan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55012C0264
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949637; cv=none; b=lB4xwmWeRwLd6ou6p9QfcsJb/htg+e3XI0K4+y0Sau0tSbxCxsp/nFbObkus7+oEvFqYhN/r+5sjs4THfhoU/vanu94pE9XSP56VdUuBRLeDctVMoboJDvMv9mS9Fegbky8mx84FkDY0gVJDGwZiJd0pRgMljXd0QdJ1/zCQ9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949637; c=relaxed/simple;
	bh=WxAKfTixsn+BqAVr3MpIjhaqLr3uVQKt3BNwOE4a/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlrOxXlMCC1wwsWfQ7kVjFHz6ja5fwriH2YtJMh1RhEVRRyGcPPkI+QsmEibP61+/84TGlFmBmizH77isE3biP7fxhdeNY79ZlnniSczs72xtWd9tuN17MQSLFBMXA+J23f2tOC/XUa4Om+bKiS08v96QkqiI7Bfz6XDziMNwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHHaSAan; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-793021f348fso125061b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759949635; x=1760554435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=FHHaSAanN7jKymPuhj3A95reTXCxeHFYFoaF+EsVghXBjZS1rbVrtQblmfbFmNujII
         /OT1XRYqBvxZrnG4irp83wVJrB0E5blcOK+YY8y4ZbTENxjiNOS/rZC+Pc6muK5igrnE
         3ovByNQbVexIgJqer9/iNVfPKJpIlbOuCIijRFOjnGkl9/jQ1LbUzSrk1OUDudyYdHHJ
         siAM9Kwd5PAq1+VEsbOfznAGSrnnm8k16jAkoeeeF8QPZmml86zMRnQefUUZ9CWIu70c
         u66XRitQSZ2QtxTIGw9HXSTPytExVS4MXatmDVetUsiv1/WHcA1ST74n+3wy+f+XOozL
         /MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949635; x=1760554435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=GH4qq+Z0j+r/6m55vEmx+e5uIiVBMdgdJszElNVJwnStT29RBNIrZb1Y90QR0jRdFm
         3HqiwvFna/K0VEYVANBn97s5xHlSD3VFd7FrXGhyD0s9AIz7FIjllvX4S6uxemR9wGNt
         yAtO5VP27Uqzt/4JVRDy9ekOlO8fujJebFsXV5BXdk6zw0xJojWOFa7zvvnQB3jHq6OQ
         XXvM0m0m2miY7E7lZ+ljF7VEPdEvHp9sn9razkV+XvHpQcroGt7TByXOWCdNuFtXah5R
         cBcnkRk3YSFqEgiw+/+DDwygN7WaLbkkE4ozFirBbbJ+8KyUhfzhZz6vHeDvSKT+B5zt
         sLYA==
X-Forwarded-Encrypted: i=1; AJvYcCXmFLppl98TwIGEiKe9ZCBpxFhfRACZgVRhpaHxELETky/Dbk2iPepCIZhdqulqSx2bshLoxqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ocz7n4fDFT2UjLKk/WdFC+iiY1m7lI8EL7rocUSqsT39eln/
	hjuSjIV8TnFHbjPHipd6gicqev31Y1MGxGP6pqJhKT7LgNt3r4a+XNA=
X-Gm-Gg: ASbGnctsnSWJ4dtCsLgWTSg53nlhb2bBykrFQpt8sipkHmG2xv4bOewDQcghU83xDrH
	EIgvAoikbkZrfbeIzr/eOZMJy2N2G82Mk4fLvANeqr2mlhyiYPldgcZs3XSVDPNOtNDiv82g0o3
	5kGSiBajoZN6TBZPmutfLy7WTFQm4jffCzK/57RzEDz0dNrS+yzoiBmq9zOfsuFPxDuuIqVYZGf
	yk8JdeKJEYPdtwusR3zB5g7DWRgZuOwnwdOM2NvwqVtoBPdXYC25qjIxHzRX49vW6N/q0fp/iWc
	kIpMAfyyBsJl+7yUbykV841okoyqku5C6+3NFWQccsaz138PKaFUVYgYixlgWHO2oBskFQclmEo
	UyqeDKPSeFqurssveYebHbYtILJROxQd4Yg9WDJ4MYpeS1zUIApbcMH+UnV/TgaGDqN8NFSKk3Y
	MH3sHbF6fjn6nnbJVzIUiDby1ztqhilzhKHLuC9ejV99BsKLyeUGTg467YGJ4fPCVH+9hAqoTtR
	VNW9ZSXNfH+19KpE197wYuit02H/DfTHQ72xku8
X-Google-Smtp-Source: AGHT+IFsu3BRMvR5OSTmCabfJ1KT16oy9gz+NE3KsW+Be2SzvD8UD2NK+R2Uskc4xVQWQI8YNuuIvQ==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr58419015ad.57.1759949634609;
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034dea083sm4734965ad.24.2025.10.08.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:53:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	willemb@google.com, daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: drv-net: update remaining Python init
 files
Message-ID: <aOazQf0BBEJh5O8o@mini-arch>
References: <20251008162503.1403966-1-sdf@fomichev.me>
 <20251008183245.GS3060232@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008183245.GS3060232@horms.kernel.org>

On 10/08, Simon Horman wrote:
> On Wed, Oct 08, 2025 at 09:25:03AM -0700, Stanislav Fomichev wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > Convert remaining __init__ files similar to what we did in
> > commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi Stan,
> 
> Sorry to be the bearer of such news.
> But your SoB line needs to go here as you posted the patch.
> 
> -- 
> pw-bot: changes-requested

Oops :-( No worries, will repost tomorrow!

