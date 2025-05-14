Return-Path: <netdev+bounces-190492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98231AB7091
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F15F3B1364
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41D220F25;
	Wed, 14 May 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk1YqMLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EA1DF254;
	Wed, 14 May 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238288; cv=none; b=YJR/P9dcRRJlO5YkE8Vn8Tq39v4tcTm1uCsP1802opY30DlxxkaLL1y9DM3mv2JNOTJ5Ev+g2MC/riC4/JmGIFi6iJl279bRomVvnejiPFwn8jEZ0jf1YnBdAsMG1AvNrUPU87wC32KnNpNPTcyB9B9KOBn+U4Xs5QpQM3GHiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238288; c=relaxed/simple;
	bh=fpKmBmEzp50TR8APNwZcmeWT4nycvxyHG74DrWJq0sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV8Y79m8dSreCezYbqFqo0OePf9uwG4+WkMzj7A2wuMTzjjLPAAz7UfDyK8O0uzG6MjPl9Fh5J/1pQUwXY9O3QWN35+uw6iSKgeVE8sWKoueJFSfht1T8HyZn5XfxnfLhgO5qF5ssWsD1t7LJeIZSeUxOYYBbkEs7aEnS4CoRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk1YqMLh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so984352b3a.0;
        Wed, 14 May 2025 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747238286; x=1747843086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpKmBmEzp50TR8APNwZcmeWT4nycvxyHG74DrWJq0sw=;
        b=Gk1YqMLhpGHSO45TJBhS7Xv31qb4tEP0+egi4EwGD8Z0P39jGyRquxyqnt4Z2u/R91
         +Uti/hZJBEe3wj+et/SPY7ZKkmiTLmC34yZgL/Mup56Ns6gCXwSL2ocz7Iw9gCAPctEm
         GDpKgxz0z0bWlvcWA17nqtQXDRJVJTvNwXIZyjwfRm7MW+OgqJEdw3w/vyk7GUA8lscZ
         bPfLy5i7erq3e4bZuKJm0BVyM/zdZBbibCmg4DX+RZU9lPcVp38Hbd5au8DAnpO99tVp
         jktYKVeviyS97Vlky2fNzaIlKld3cpiJyYiprlvMJ+A0wfaB6rg93dDjXpMSNIqZRzp+
         EMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747238286; x=1747843086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpKmBmEzp50TR8APNwZcmeWT4nycvxyHG74DrWJq0sw=;
        b=tEXT8Kvq3XQA6p2CXwwFJcDxBZzFMTAFZfTeqpiI7PVeYvDQIsn4L7TbUeRM66gsvc
         8LU/wJXq9bRITazzPDnHqXF6PV78kY+H1v0B88iQNpgphjGDzLTkRFIMDmarQUQo7DaE
         YRRoh1F4RAgBMK0h2qjvvI4s6J7X3yLEBXXDwm2kTnXfen+v33J+HF1kUt4P6j2eMMms
         PbOj2npcrMDZuqT/D3MrvL/V8+RFSa5SqYmamLMZ4GuZvrLYI3oJFWEMuBLd9Vf8mqDq
         Ur/SMEuhiE3mDTwddhXqQoG8MbWJPySQUYiM+vAxdWAdi1B+wvxdyy7wOfiCeFdqiESA
         AIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2KIDiGfUrwCTdUevefZGkMm1bhpnuql2oq5Idx/IYMPd/icDG82LJYVwtK3j5NNE18B3OfhoO@vger.kernel.org, AJvYcCXowj3Ux3B0mSj36nW/by4OHiDfHCv9odZ6VZbUwZbx499/22MTHDk8GT3T+2Fes+FqZZhI1VfQTvEv4MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDKVUaJTnQzgQNzDOb7oiQblFfB5F6QrGlaiSOjKxiM5NSpjp
	ImaXQ/C4SfL3a7ngTadHEnEbeHNl8Q5K9GujDPZUnQvsVQl/b13s
X-Gm-Gg: ASbGncsGgxPRN9Yudjzy8CpdsvWiYbd5LSR+sDNZD4Cg5wTYTkmwapwXT4sd5zum1N+
	uPOPgH2cLjK3H9Zi4//fkR/r2E8eko6T+iIqxy4+6sq8BBMKcypJ4ZOwtZisjfvO37jq4D8P94S
	ccVUbblou6YIA/f0KIuIujNfBsS07O8wDn1eRJAsG1avQ8Q1AZQbp8Vx1KJlEX+HJxrXFezAldn
	F8FZk7abt9BWSi50Ljazn/gdV+yzzPuvwxiWFMBuvY7W6fJdccYACqVxMoS6kBUIfyWcz0w639B
	ChMvXMtT7pbHVz02h/GHop8yc5aEjOfC6pLuci4jGUtaKRdHNZMsmtuVKLwPJQ6ymzvw7yY=
X-Google-Smtp-Source: AGHT+IEGtOwegxBLaY+Q6tQVIrHN3fYemJ8QgU8MQUPTrc4QFAGE7i3gBDzE7oFdfo9l2d909PY1ng==
X-Received: by 2002:a17:902:ec88:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-231b3985156mr930205ad.7.1747238286420;
        Wed, 14 May 2025 08:58:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271f77sm100631825ad.126.2025.05.14.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:58:05 -0700 (PDT)
Date: Wed, 14 May 2025 08:58:03 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Christopher Hall <christopher.s.hall@intel.com>,
	David Zage <david.zage@intel.com>, John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	Alex Gieringer <gieri@linutronix.de>
Subject: Re: [patch 00/26] timekeeping: Provide support for independent PTP
 timekeepers
Message-ID: <aCS9ixXXLmva5-BT@hoboy.vegasvil.org>
References: <20250513144615.252881431@linutronix.de>
 <aCRCe8STiX03WcxU@localhost>
 <871psrk1x2.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871psrk1x2.ffs@tglx>

On Wed, May 14, 2025 at 10:54:33AM +0200, Thomas Gleixner wrote:

> CLOCK_AUX0-7 sounds really good to me and makes sense. I picked PTP
> because that's where I was coming from. I'll rework that accordingly and
> make the config enablement independent of PTP as well:

+1 for using AUX naming instead of PTP.

Thanks,
Richard

