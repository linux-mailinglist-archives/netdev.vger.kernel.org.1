Return-Path: <netdev+bounces-242774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F4C94C4D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456093A485D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAB239E8B;
	Sun, 30 Nov 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1r8MlOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27D1391
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764490945; cv=none; b=LZDqKvmngXGCOwMlNWSl+0kTOmKcllG+Sip3L7jgpZaHM8j/13AaIw+yT8RfDBUTHXc1BtntRlDQ4wznoqqdLpVy2Enmn0bhXETlgv8uQutJmADJ4ZpK83v1qOB9oYw7GsA9HMJ4oZCe49x+rFjB0s0Lvxbv2LqkG4x1V5tmcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764490945; c=relaxed/simple;
	bh=FMjxTGWZnc7ZEhZJMTa/55xtVT734ANCN6WX3PTPVUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9LL3Enf0U4xIa+u4PEC0W7GdBQxlJbjJSGK7QbDWrahlHfFIdVhbhrUuW7xem/MQD9NKuQuFLVtYZSUhSAT3CewHYE8AYEyA+DJYEv07f2iN+HtR63q/Gkqs5Berx5H7dqnoZYRdRXGPr1VSixJkHxc/1fmCHi79L81yDm+cD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1r8MlOD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47798f4059fso3752675e9.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764490942; x=1765095742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMyv7xHpzBEGqAA6Ujonxbq3JvKho8WXoic6wC5QnCg=;
        b=a1r8MlODyRMePL6XzSaVDGyyJg/GfZUHfz0FLEjHdzwuE4lmldCYRgYG65/jaTTW4H
         aUEZsgolYvVS4aimOjiUM8VmT7UtblwgM065lUsGa0RmkTr3Ui7QRLY0qmdmt2kvqwXN
         7bkDru20lNwEwJJgj7ez3kmjlyNYIp7OWFP0vBrxcQlpqD/MH6Kjc6NBWp3XsZfdJd1v
         Q6F+xY0aYYB/0qwLzp5wuzlmoRZdZmC51bYR3NE+agY6FW6wrJdUd0q8tpkt7gmUkx26
         52Oh+sYgDtLoXXgxqoIete4omxsgIrClYbz/UnylvCMbmwZvqG0As9VvGhpjDFrnosks
         TmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764490942; x=1765095742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMyv7xHpzBEGqAA6Ujonxbq3JvKho8WXoic6wC5QnCg=;
        b=A3Iz3mqcA4V+QZfnHuFCrPN2o05IghZPCS2JLQ9igBIRK3NtWKEBCnEFYA4RBARul/
         txlclAP20s3lofDc0e/3CBQxJaILAV+GuxTnm4aNfQzQFQanzT6GP+nRX4s2Kr9H5Rzf
         ogeliXyIVCY1laEYJiaYgcx0V8cuvYpEUzJfh3gYOAV+7jh45X83FEP92CH0Zn4I6N7R
         Qp2iuTarMiq/F92xfDEQ7lWeuU2ZfAaUYA64YKuklYkxBocko3b5k6KvSlKChcOzEDqH
         DMHKgxaMCzUmom2aOcoka7ucmZqhU+9w6bQQ8m2+9kW1p79L7ETOfBk4F/6m6SC/qXe1
         p86A==
X-Forwarded-Encrypted: i=1; AJvYcCXu/JcR4+btb4NrtD7YwyScSMPm9RVagEmWe4ObthTE/MLHvRcY1WSHzgwemohfzGW8ZI8TJec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNSY1cn2M9gIuPP9xnEnN2+qp7ZxT1W0M6h9flK/hcxpUVe/Y
	kw6/0vlnHyJPPW8EykmYdN1ASLB1OEr3etS59ibhOIqP0JKpJOBgu3Xw
X-Gm-Gg: ASbGncvMEV3Z7Fp+jUCZI0QgHWhyq/5i83+DqbmOghG8K0o/bRQhBK0jM0GeSZjgLWE
	+GKdUCfJbsTAISsFHE4tFvCks7llS6Fexl3+6o8vjKTjD2ucXCev3V6EQhpQqbqm7/KQ5iZ+S4M
	KYZrkeuZzGJxyRtQULS66RJ4eU41tSY1naEtD+6v/G0wU/Yrc+yvrw2fTHRZTXCPYRERYlOH2kB
	p8ohGpFqkLYIHrjELQI/Bh3XCzKWi0j3n6mUjvrBKLpg2ZiM0LsNpHZ3gGTd0dNigYOb6cvvaE+
	xsT9/oRMG25IxD1wQXU5mTcsspC5FhixP/9L2FTogbT4TknNhbVluk1qXLi80a60wqAhfT80Ei5
	j3gYqYXdv8H1gh9OpKvmRegc7vueMzJThtYlSzDl3hvDMBB1l6hb12+6OsN64bQxqKF/vxHo6Py
	D7oQ==
X-Google-Smtp-Source: AGHT+IFxf5DCmAQb4WegUpiiTFHp05rmbMw9OobLeUqiCuq6pkZ68STqGne2876uNBNRHt3VzIgFBA==
X-Received: by 2002:a05:600c:4443:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477c01ddc08mr202058375e9.6.1764490941614;
        Sun, 30 Nov 2025 00:22:21 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:36d7:677f:b37:8ba9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791115caa7sm172799055e9.6.2025.11.30.00.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 00:22:20 -0800 (PST)
Date: Sun, 30 Nov 2025 10:22:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251130082218.mvxlk3p2pxdny2ij@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129234603.2544-2-ptpt52@gmail.com>

On Sun, Nov 30, 2025 at 07:46:03AM +0800, Chen Minqiang wrote:
> This change makes the driver fully backward-compatible with older,
> incorrect DTS files that marked the reset line as GPIO_ACTIVE_HIGH

The driver _is_ already backward-compatible with incorrect device trees.
This patch makes it compatible with "correct" device trees.

We need care taken in one more area: when you make updates to the device
tree, *old* versions of the kernel are not compatible with the latest
device tree, which is not OK.

So ideally:
- patch 2/2 should be considered a bug fix and backported to stable kernels
- you wait for some time to pass between when patch 2/2 is merged, and
  when patch 1/2 is merged, so that users who get an updated device tree
  have gotten the kernel compatibility patch through stable channels

Then you need to consider that you break "git bisect" if you keep the
device tree the same (i.e. the latest) and just change kernels. That is
a trade-off that needs to be well justified (cost/benefit).

