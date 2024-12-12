Return-Path: <netdev+bounces-151371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F559EE702
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C262A282327
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7602135DC;
	Thu, 12 Dec 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMi/ThmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913813C9C4;
	Thu, 12 Dec 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007660; cv=none; b=TYsTv9Bc03msLIeLfiMgr/9MWREVYrkMa1pUaMK9DtMn9wLLfSEy2WryIItf6n52Y4f0e5x3MHHzS9qqqnPNzhQKFfJu8xcnV9vLbl5BHhRwumASP96MUs0iLLj7e+R471dBeZ/D2QLJTkaqmytcIHzeweAoiDOVjZtVwAXi++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007660; c=relaxed/simple;
	bh=JSutgKDevhOx/jrB2w9zQ66qHnx2Fow3qjiVuy+eA1s=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CKV2dkMe6rxllRJcRn7rOqguT1fPVOVBIynSnWRmAmrFdkVzRTohmIqfL0fCpB2cVji1N2hg+W7z4jqiw+jf51kUzCQN+mR+vJFgf6nRpAYjYIVvbPx4GL/lLabOnNnZEsTloso3GFygQy0bmiBukSts1l7lNNmx1KIJEOzhjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMi/ThmS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc93152edcso456568a12.0;
        Thu, 12 Dec 2024 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007658; x=1734612458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWgDzdaxoTdWQ4sFUsAU9c7vlE2yrj3xBkGX0/jVSvo=;
        b=TMi/ThmSjITpY2oB0PCZPfueDisdM1CaA5ymJqnY4lLt1pNs2mmKFC4WlY+cUXhmQu
         HwshLOCRNByVQTmU7sMK4kqpMrDEKi8xOnVldv9alg1tie/krM46lJ/nOm7BukhJcTH9
         FUQdzAxs/ALQlsUezko0rWi6nJDp8hj7FWPtwMbiTYo9gTrcBVVIa82Vt4Zu4+OyNW3t
         QeO/w115vNR+U4oh55+rXiHFs/aTnJ7lTRo22rGKvuCtvA95Ip3qR+fh2pjUB8tDA/ix
         Kc8fmPi2jOXTxUtky74/QJAj34ajF3U52nG4khPI+HpLErkTmDslo0nGPN2QUGXFVQc4
         FyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007658; x=1734612458;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWgDzdaxoTdWQ4sFUsAU9c7vlE2yrj3xBkGX0/jVSvo=;
        b=vxw0yqpCNEmTKKYNcXl4mwVXcP/vUK34qLvrYXxHm3I5L30gB7LNe9v50od0xUSoww
         jNS6HBf4UOgDn2rsBFrAW3teAdLGiBiHsdLtQFCbUJvJGJE+/YbWJ9eJo9BMMdsOnJwP
         uCFuds6KnBMzcX+zMLeMKuln/Bz6W7C7+ruVU2S4DkHZx+2rBOYkMGRua4QJNodnFzLx
         gofZTEqT0/m47V3bsqyzNj9MfxeYd1+y3F7hoGZc3od2nEB3pQA3MEg3xe7Qsc2b7p6O
         Vw8RQQBJ2fzzayXNnXuI0/WzUJOSZcdkmemgEtTCT/NScYi6JOKNRPE4E5e1zaGw1lPi
         1d/w==
X-Forwarded-Encrypted: i=1; AJvYcCXNveyqZJ18C0++S9cQfGfT6201lQuGzsH5T5sh87q6I55XClT2XrhPTmJm2OJAFm7KzZh9xe0=@vger.kernel.org, AJvYcCXcXF4oHDLVRiYAMYNblGhodgmtVkN8OnyGRgKEOjG3eegIYe9KdquGunqIuHSIfPba78FxiNZ5Sk4WukaXsdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFoFZk5u6P4TyB8DUm+KfBRK2vpG0mr6nbA3dheuWR6OtzQcf
	DcietqJ1juxHA6bUXKwN4QxiXlOiIWYW2PWktQ3s5IKB9oPpCOCv
X-Gm-Gg: ASbGncvwBvmTsscPODb9O/0gM+C8eTQAnfZQj+OyvlwnjbO0Fa9hZUV4ZnlL8ZDw4D6
	ahCVPT2tO5FSG1Nzg1DjUCb1gZyLT3grtHjo6dv/C5KDQyTPGokpQZ/7IKH/cPxPWRQYJXotBMc
	jV8zMpBVAzMx5VTdSxZXjdgCaNYSa4EasQr8UqbOmKrzTlklG0n0WebARrYOjL2Bc9LvwxwRBTg
	uAy6+K4wC87TeFsuiR3+gmmWJPZAKIVqhQnyIlq2OrZBQr98t63C3VSvHRph5+h+MRycYGjoFBX
	GhY3i2TsrimXgquZRwYehJ6oXuUx0sQsGro3
X-Google-Smtp-Source: AGHT+IER1J4V7epDu7gSZXSicIptcXm3ej05WO5m+UIcsDNnjod3WPN2kEYKCp9bSoiynVlRhjxTWA==
X-Received: by 2002:a05:6a21:b8d:b0:1e1:a48f:1212 with SMTP id adf61e73a8af0-1e1daee87e6mr70816637.4.1734007658426;
        Thu, 12 Dec 2024 04:47:38 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd46a80ea0sm7475204a12.56.2024.12.12.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:47:38 -0800 (PST)
Date: Thu, 12 Dec 2024 21:47:23 +0900 (JST)
Message-Id: <20241212.214723.846689767325390398.fujita.tomonori@gmail.com>
To: pabeni@redhat.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, aliceryhl@google.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com
Subject: Re: [PATCH net v1] rust: net::phy fix module autoloading
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8d00ebff-5f5e-4b00-865c-aa7e48395d08@redhat.com>
References: <20241211000616.232482-1-fujita.tomonori@gmail.com>
	<8d00ebff-5f5e-4b00-865c-aa7e48395d08@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 12:42:51 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/11/24 01:06, FUJITA Tomonori wrote:
>> The alias symbol name was renamed by the commit 054a9cd395a7("modpost:
>> rename alias symbol for MODULE_DEVICE_TABLE()").
>> 
>> Adjust module_phy_driver macro to create the proper symbol name.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Please resubmit including the fixes tag, thanks!

Sure, I'll send v2 shortly.

> Side note: the netdev CI is lamenting a linking issue on top of this
> patch, but I could not reproduce the issue locally.

Hmm, I don't think this causes a compile error because it just changes
the variable name. I confirmed that this works on hardware.

I don't know what the error message means but it might be an
environment issue?



