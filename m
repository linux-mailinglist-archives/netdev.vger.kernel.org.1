Return-Path: <netdev+bounces-166768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C3A373F0
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC218894DF
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714018DB17;
	Sun, 16 Feb 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAfGUCki"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60015F3FF;
	Sun, 16 Feb 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739705075; cv=none; b=AEKWMp8MUggLtHv4ha+aem7Kcrh32ggcufSdMLKdhWDOUxI6A+F6brEksfmaU/8jKoF/x5d+zZXVLd47w9yIBXjrK8yibHQyaGkj1ki0fc1g8MY1VmVbSqfZhh+NQo0EAdVIFWoU7zuaxP3gAyXh0bE/EsM7RAVkcstGUTFTLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739705075; c=relaxed/simple;
	bh=enwafucR5NlWPBdACF9TuMGdAR8VNwvlFw1zTCogdRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+CTHdK5p/qAe0k0a7sSppuS8vnSNWyenRhVlENOI2TU4Jah59FXVbTyBjou1cuSn6oVpMRiCyNwpZ4zheZD0JPxIX3eTTH1W/e8Z5VS5yLGJ0wGFf7X3voSmXD0ESeSP4XWdmO7cxsTcOUywHnyZAE7PLVO5s7uu1byCDpE4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAfGUCki; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f31f7732dso921363f8f.1;
        Sun, 16 Feb 2025 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739705072; x=1740309872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6CW6cwzy3RXFFAj6UJ9mWJ4TcwTIqGU+hJNWCt4bOU=;
        b=VAfGUCkiNaz1wAtfPWmAAVbQAHnIFLypid2M1mFLYLesG6jP7kgt5zBaeJvp4+7Lf/
         nTHAouJRY/3fLWslTCi7zGT8cfBIW8jaDqztgVaSY5vlXBL34cTacoFqfYhms/owz07k
         zPit1IOAAQyMnDPLglNMhL0c/lmLzk4+XyzfFFutZELp890Q21jLnWocDhJ59T/CFwet
         Gy32Kjt0tFpzFBCz7f35JOS7mJMenRLBjt7AEIg+I0HxGX+oGu/42ItpFPEBmgKsDRgv
         2MJjcDaKsvl0as0uGMg9lbdHGT/nQ005V97UGoZBiBx6sjVfj23cbynsKML36W/FEoxG
         kIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739705072; x=1740309872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6CW6cwzy3RXFFAj6UJ9mWJ4TcwTIqGU+hJNWCt4bOU=;
        b=nl0FpfMD0otDqMSQVgfPqDMIb1iw5r14E23o7EuQUiH0K591Y8TxljCtU9BEBGA8Rb
         yaADwDpaM/HVsIkjkHpmTYfZY4tSzh2KX/lYbmquqVoYC5/jftuVzRaz5htHYa5FJjup
         bmUscqYhqHC14v4o9buYWig8n6dHnyNIF4VAdVs217wY1jPT/2x5z8NhIVWRpV0WX19V
         6vT47otCF4MeEDGTBC56QPOrsh/xL/LNLef1fK+LxfvG8DsiiRMRkUNXn1X1Gpv/gzpJ
         iBYhapWgevk8jxi2r3O2yfM0iNxiseNuUPWeTKeUyUMsm6rXv5Q2BO1M6O9j0r/Ne4ep
         t74g==
X-Forwarded-Encrypted: i=1; AJvYcCWfb7T7yX+vmk5GUp630tVgYbg9CZzziMKVf0LfC30KhEO4XjtEa7SJ/EEYJxit3/VuIjNi+/e1eCek8PE=@vger.kernel.org, AJvYcCWi1SCJIP/9MFMu+garr8BozaCWrZJWsIH8J2invpm0h9yU5qGpRPV5ZDr2brB3WbSHEVPrWbK8@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYdvmjy3JouOJJ1KoE3W0YoDrYH3XlDRkv4pps+IRhnIPX5aS
	kyZ75lUq2nnC88CTZxSt8Z4g7Cg28KgcdgSoaVKBapd1m/MvIEFo
X-Gm-Gg: ASbGncu7ZEaOPcENN0xyKyC+QD6+2bA4ZjNLqDxL2IQnmoQeXaMITZAKDXXr19tW1M8
	8AnODIm7S+0VhfPIJloxJJxnJILLO9jKTC+2WNWuzDsm7rQD09syys+pUbgmSp+OSQZkDAU+SSI
	SaFqezKgCxSZO5D9EPH9bZ6OKbT2QzYLE+gs+UY7swhSgnD57BC9cGx2wew2C/RXvt2YvI3FX8I
	TUkEo5NbrScM0Tt/lWJKUOB2taM8Z5pO81Ro1yxhuroREY3GY5aAFrBGON+ifURDLmdOJU9zVht
	bT+z9hyOtbaDIZmZtTqe7HGnDI5FcGcIM0XkpCcxckutm4U8HpjvDg==
X-Google-Smtp-Source: AGHT+IGVwtYfKNvFbUEXI11NHDgMu2PvMKflTrnjpL6Qjbpq/I/5bYeadzXPYdLkMR7a3RogSPSc2g==
X-Received: by 2002:a05:6000:1fae:b0:38f:3aae:830b with SMTP id ffacd0b85a97d-38f3aafb43bmr3288926f8f.26.1739705071708;
        Sun, 16 Feb 2025 03:24:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7e8sm124397715e9.26.2025.02.16.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 03:24:31 -0800 (PST)
Date: Sun, 16 Feb 2025 11:24:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com, jacob.e.keller@intel.com
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large
 buffers
Message-ID: <20250216112430.29c725c5@pumpkin>
In-Reply-To: <20250216093204.GZ1615191@kernel.org>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
	<20250214162436.241359-2-nnac123@linux.ibm.com>
	<20250215163612.GR1615191@kernel.org>
	<20250215174039.20fbbc42@pumpkin>
	<20250215174635.3640fb28@pumpkin>
	<20250216093204.GZ1615191@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 09:32:04 +0000
Simon Horman <horms@kernel.org> wrote:

>...
> > > Yep, that should fail for all versions of gcc.
> > > Both 'i' and 'rowsize' should be unsigned types.
> > > In fact all three can be 'unsigned int'.  
> 
> To give a bit more context, a complication changing the types is that the
> type of len and rowsise (but not i) is in the signature of the calling
> function, print_hex_dump(). And I believe that function is widely used
> throughout the tree.

Doesn't matter, nothing with assign the address of the function to a
variable so changing the types (to unsigned) doesn't affect any callers.
The values better be positive!

I just changed the prototypes (include/linux/printk.h) to make both
rowsize and groupsize 'unsigned int'.
The same change in lib/hexdump.c + changing the local 'i, linelen, remaining'
to unsigned int and it all compiled.

FWIW that hexdump code is pretty horrid (especially if groupsize != 1).

	David



