Return-Path: <netdev+bounces-69797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30E84C9E2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE561C22BED
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B91B597;
	Wed,  7 Feb 2024 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XEerHhtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7025602
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306405; cv=none; b=JIegv6iMa9jQVoTFIZBcG6Rea5F6GuR4Evt+F6E2mOQ/Oc/ROGyBsuyGNfyC3IUVIpxz7GQ62Nx8XsXuU68741NcAvx1AG5RsnvD5YGQb7D/7q0P8p0tOGScD38sWAOwR2Uyw7I0sStjEfG7+dDYU+lOAtZWXBK0YhoZkoOmIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306405; c=relaxed/simple;
	bh=oI72MAxTBz9LSh57luWCviW6KqGdSiQUJen3qT8aBQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhZqSNIv3WHudGJ/Zs5DKED5W2ClWQktMBV+9UEJJ4qHnvoozGhzD5WDFzRkK+6KimC9F5DJ2rz1VXcVG6pX099tCx9uyR3z7imHy7dyFNISciFzNhscB4wDfO9cJ9VylcJFL+26YC5SjOBXvevRM75LwoAjkSuzWIz2toJF06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XEerHhtJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5eab5so356888f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 03:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707306400; x=1707911200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JP8/YmXFsYJOx/o+W9GXxF8HxDLHiyDKyG/apOrZwZo=;
        b=XEerHhtJs2Mij9t0VWhDro8fFAjZOnb3/VjfSXaQlJQTNQLoFgaxzWqlBzqmGdS966
         OFD9kxx83Rao7DxbwBDVYu8QZHgeC5wEci8KGnUn4nilI6/pPf8JDicElVs9586eMsAr
         bKbO37ZTZtSBY4xpSuxz1Xab5mN7SNX3ZTDBcphLIcxqtHKUmC6tBovpQ8UGGn6hvHaX
         Y7rxicKPpRP3OfPrjTkF8riskLN2cOPmAclxVcKT/nXQlWNMWGrQWZCWkK9t3Vy1BfKo
         UxRxWZagRGOdMv7iuhumLJgKYGI7vR51OZa/ka0q+01V0rfkycC8/QbG5VWgzbV6OZoO
         QouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306400; x=1707911200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP8/YmXFsYJOx/o+W9GXxF8HxDLHiyDKyG/apOrZwZo=;
        b=cARKJN37WYk7melD3xSWGszhjv0o4tX55qL/vYu6yNkR2qe4FDjwO4n5EA7j9c4EYc
         02g26z6iyhzeV6w1Fru7xxzNi+mlkjH3TUjmvzLmg7VkfGg5Z72zM83zfBhBJfhCgOVB
         gR/o0W6iq3RrlYND99IEiHjh1u9a2CfFRQ9zpVTXGm6/Eq1+ndlyHpPXX4r6hDyAuDNK
         iXezxf0znDAN1M/TGPL7AOsS42qfbu89N/9Jv3u1CN34JcAcGQqs33z9Gyf/RjzjP4+c
         j3wVRqBKuU1Ouu8/SjVOwY14qD/YgyzYvtaZV8OXAVONOmwpAOBscrjejICC9cePSngw
         2V3g==
X-Gm-Message-State: AOJu0Ywba5U0EX+VkYYMlZ5wJ2OMv7IllwYjaa40XUaTjsQE/u97LCJE
	LJTVjYtbKBlnsQImFPnTuconZf+bOQai45l+k/cHFzwotSCAFygyvg2qWihPJJ8=
X-Google-Smtp-Source: AGHT+IH4wN8apMZVUuUoAtDvSS4bN+2GSFl6yPwlQsgO+wxDG1Ra7ffYA8JnAdIRQ3z+W7pHCd8Tgw==
X-Received: by 2002:a5d:4452:0:b0:33a:ff90:77ca with SMTP id x18-20020a5d4452000000b0033aff9077camr3024906wrr.29.1707306400129;
        Wed, 07 Feb 2024 03:46:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ0BRIzohOcEIcFMjm2Nfc9c+gWJmkxbDAHLNT3kMjELuL7SUe93mF5iL7PBPg3baiih1MSH2NSS25ojcqx8QsNkWT3Ts5RApf4/pZjEZAKxzTO5jR0q6LJQ9K+kNMEl2vEME/QPePv2aNwF5nV+T9or5Z0/umnf56ObE=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b0033b518f73e1sm382601wrt.71.2024.02.07.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:46:39 -0800 (PST)
Date: Wed, 7 Feb 2024 12:46:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: Re: [patch net] dpll: fix possible deadlock during netlink dump
 operation
Message-ID: <ZcNtnrwdEaQIiCMG@nanopsycho>
References: <20240206125145.354557-1-jiri@resnulli.us>
 <20240206190730.4b8e7692@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206190730.4b8e7692@kernel.org>

Wed, Feb 07, 2024 at 04:07:30AM CET, kuba@kernel.org wrote:
>On Tue,  6 Feb 2024 13:51:45 +0100 Jiri Pirko wrote:
>>  drivers/dpll/dpll_nl.c      |  4 ----
>
>// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) 
>/* Do not edit directly, auto-generated from: */
>/*      Documentation/netlink/specs/dpll.yaml */
>/* YNL-GEN kernel source */  

Doh!

>-- 
>pw-bot: cr

