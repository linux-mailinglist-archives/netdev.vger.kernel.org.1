Return-Path: <netdev+bounces-118704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96575952859
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E121F22495
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A322032A;
	Thu, 15 Aug 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fix7icQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908517C64
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693382; cv=none; b=SwUEUNklbQS9TQX8lFGVkkuaxeGNFp7XQJHAGESrXYyBNNWQlXbPbm8c92DZBLWOOiFDQC2XZ0jJD/F6Knfi+pwv2PxXQdu8Q8Ff7E+fe/0PRfw381GGUN4mwYlbcJnk+xCfAg8FHtBXXdA2PY2W01ysNX/lZ2Q7QZFwRJE1TBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693382; c=relaxed/simple;
	bh=nklxoBBQ1ey4YrZCJ/yU4COC1V5mtasdPKlS/16zEWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD9rDXEW7+d1qY+Vl/hK25QVxIxaYnrlGfpIu6L6BZyHGuI3VHomGBbvxbs8CVPYqyIi5iBPQKlAC+jxjO4k97m+s/zKPY3hJWocWHyLF0pMUKRbQrVuWAS5pRmrW7vGc+UWRj807LNqAiPPHFm8g7ytdIy6ap8LqBL+UlOCAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fix7icQu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093890e133so38112a34.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723693380; x=1724298180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nklxoBBQ1ey4YrZCJ/yU4COC1V5mtasdPKlS/16zEWg=;
        b=fix7icQu7GjS55FXkovC3JqmfpHYZcyywuN3V7QtBl9DyL+OoCzUllj3WJ4zFtUl7N
         stAmjc5sYjscMLDtngj1YS2uU9K+jJ7KbsDvrJvrcRL01ToiiGTjH6zrOqS5oXDkKYSc
         uTxfDPjObEb4iDPe5BXZioklmMjV9NjrZzUOIXW7Zde1lxf26GAowBcSYmQBTf8h5JaE
         EaJwUb6PsrOIF1T5CWhcTfK+bewYK782KsDFLVPsczaoGYSD7kcOwcPm+Y4GlOkP5D20
         a9oqcaAUaZ0UOlOcXgQ48/q7yT6nXU3Cp6rJ9pjbTlsPiGWyp+M/c2Es0nbxbjzzRQSz
         uopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723693380; x=1724298180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nklxoBBQ1ey4YrZCJ/yU4COC1V5mtasdPKlS/16zEWg=;
        b=xPRS2/2/0/msNdC3OhKeEpjmGp2pmaGOCge9WQH44w16u+hJWLvXro/q8kvjoPDhOX
         H5PeeVbhhI+ApDI7aRV7cRUuyuaQOkseMpwNpkdeFB9Ks+kf7Lx4A+jvWQPKcN3qaSGM
         Jz4cCZuR8k0PyTL3y7PE//T0s0+fLyMKJwxziLQ1cCwCz4Szh6NL6KH3fTmXjIXyNPZk
         1CX5wOIdOqH3Hnfg35CiuawDnE3cLCFdDK6yCtuh+czOpWiVg8h//YCK97f1H+5HE3jo
         CkBr5kxGKWxHliP7cp06jizxZOn4VWXT5mn7R86iDrccpRe4CqdyeVoi4Ts149KQ0TVz
         YpPw==
X-Forwarded-Encrypted: i=1; AJvYcCVVWIHDS6oZw8wkhm+1C/cdBh4dvSFNGlgb5qrguNmEpVUTYe43IKOTF51nyI1JfFpdfCxmocGSCwaNkjIVA+foXedzVFse
X-Gm-Message-State: AOJu0Yx1VE3e2qqX6i/0r5P07VkcBYg48ELtAZmM0Ar0ARRD11CaToFh
	TyePXA4giUyfLMuL128bQAbu0Eb1LJTZZzyM+yJ2IWeVJVRvHYDn
X-Google-Smtp-Source: AGHT+IECQhr1zp6SMgnwuA2WuUpBU6NlvKj3JZnCmTctfrQUnESWbg3XAjHqvDxA3ZXJFuf0cg4tAw==
X-Received: by 2002:a05:6830:718a:b0:704:45ed:fa3 with SMTP id 46e09a7af769-70ca575a3e4mr951015a34.1.1723693380308;
        Wed, 14 Aug 2024 20:43:00 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca637e1ebsm162275a34.4.2024.08.14.20.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:42:59 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:42:57 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr15QcwE9rboS9Zf@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240814174147.761e1ea7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814174147.761e1ea7@kernel.org>

On Wed, Aug 14, 2024 at 05:41:47PM -0700, Jakub Kicinski wrote:

> Please do CC people who are working on the VM / PTP / vdso thing,
> and time people like tglx.

and CC John Stultz please

Thanks,
Richard

