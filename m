Return-Path: <netdev+bounces-201040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D5AE7E8B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA083AA491
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D32BCF4A;
	Wed, 25 Jun 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVSDzDvB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0A29E0FB
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845978; cv=none; b=tOKwRPPakIjGDrUWWRRqCsfKfIC/b+v6S4VYlaTq7RFAeofftAOd3EyZNn3WTMjfdhpAnBzEhRCAc+KTtUe26PPoQjXYr+Z6WK5faqGjMKYPuSJd5ogr/jkoucezK/c16Nt5j9PM7YZAyRSmImv3caACuQYjyRgk88VWMiEfDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845978; c=relaxed/simple;
	bh=ZZJGTej7SdE7eeLFN2burwqtdhpTPB9JnWLRE/60b/A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=m9VgWY5pB+55Kk9TiJlIMgLU6omhWxwH02NwwToeFpgMrBOp/Y0QGE/ytWxKHDpchX6Y6hToiDdtLHaUl3lt3H4PWp5PmixBBBTmUYPfxVlHiTIQ00jbuGPgkDD41ynTkJkIp/iF1TVhIly5cF4LbuDlbwUrsMirwHRWu69GdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVSDzDvB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2993664f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845975; x=1751450775; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZJGTej7SdE7eeLFN2burwqtdhpTPB9JnWLRE/60b/A=;
        b=gVSDzDvBKXcFR/dxwRYOqTQ6+3oj3R+czRFrzfIh0bvLYKKX/MeE46NFt3u3jvUUMF
         MxCXTbGSYq2izXew+mL+HLx6E2cezePRJ/BIr18BbSXDYMjM/iMN1Yt7Gf3643IYSeHH
         /3j2Je9r1pTVw02qE4PpvkX2yndKxT+lF95Dp9CfTwixYlca3Q/iNy3E5ltduvJHtvvf
         4808bXehs0booBbnSFBX+Qvj+AUbDI5rcLEG00REh09xC4TQBPiCSqxhMDyT9yaMwxPn
         E6hVk+D7Wa3jMbbhEXFTc+wAeLY37is0L9HJVNQkEJeGVy2si9FBM5ZFluvaV7ijgzCt
         zLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845975; x=1751450775;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZJGTej7SdE7eeLFN2burwqtdhpTPB9JnWLRE/60b/A=;
        b=n15ccbTEc/QJ9+D85VFxdARSc75OihHQh+bVrmwHAgoZ1UuOWgJAkhdvqM2JJ61Rvl
         PFvWkpc+MBbqP3AYEp6lfi1MFyPOsfzqY3xsC7KbIZSHLg4l8cTN+qFyCMYlYc4oJYNm
         MEAs1iy2lYqgZfVilw2Kt7/9lssBEyrUY7MocuSWX/bgwS0qKtG4P0BFR186k+lEtCHR
         A2NyK2c9mLr9MXLkxLcocdrzZffNAFaTLBlZs5mkezqDXH9frSbtLZraD8mnjaQrThNN
         bKo83FOIedUh8GNY0UasvmSALRLe5+qe08+0TS8AzAQLgLb4oApvZU9H9vidw7JExoKZ
         0wPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNK/Ug8R2XwslLeiQtdyGGbpZCGU1ehMZ0kLjrZtDpl/heUmDJX/y/PjlX5LbMOM/o9apFhvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VPUU8Gi1qgQwMQq5vx5FB5kpFJHFdOb2tXJ4xj03uAjv7qCI
	W3T82qM7jfRj47NyeocuxgmttKerJEl9VSjNVNDfsIaqLr5PslcP3dgD
X-Gm-Gg: ASbGnctjQ2g/0AZ0XprSrnpy56A+TDltogZfeJl+deiDn1DkV5h8W0z4pdxUF3fqrk0
	kkIjNNA3QJfkSIkbtJRLrtijImfgtz0noMD6+mDCav5YRQRreTXPimFsxfYnOvKL7EJL76Z9Nmq
	reW2gr03PlKaSdhIzHsgkGDDyeE1Rji2ql+QOeC6eiOPRd/JhdWe+xfpjnbp+hbXaekH1lz+jBd
	0BUB22KL2rf43sseidYm2hq4UKLtfgAJsck/uIQRDtSKlDdefQTJg9QbpZkoOfI982memBsiO2G
	zHDvlU7WE8xperSdQQMrLKdSTpzKiPRET7LbRXtAJTZyEvT+dA+B7hKv0N3f73hymVT1b4YuvHe
	6wry65DAyxA==
X-Google-Smtp-Source: AGHT+IGA7UUkWUALJ2FhJxQhnIpMhG2gEYgl2o9Ss4HKxvqEjH1UnpmAVWIvH5RqYCfPq0+ckvJspg==
X-Received: by 2002:a05:6000:41f8:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a6ed6161camr1757612f8f.23.1750845975440;
        Wed, 25 Jun 2025 03:06:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80ff561sm4269228f8f.68.2025.06.25.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:14 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net 08/10] netlink: specs: rt-link: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-9-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:54:15 +0100
Message-ID: <m2tt44b0zc.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

