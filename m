Return-Path: <netdev+bounces-236256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F2C3A53A
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01D5E4EDE22
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C632DC784;
	Thu,  6 Nov 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7fSLwVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0A28640B
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425666; cv=none; b=FMzYh2ing+nIoZ9sglvnMuh31Gc4YdDeqD881HemYMufHggmCbI+9f55JUEkF53YUKWBDf/ZDy+3ssGv9YRngCcozRYSKLggAd0ZOLPskqC18+BX+4zXplkqYu9lEJpsDe3UPdmpL/VmUd1TaKJ60VtH5c68X3ZQUy3uoSi6NeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425666; c=relaxed/simple;
	bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2aQ0+vG6aqeb2foFBXsPy5DTJtNYpJDyMaqdGESiCElZl1oZS0mXvsafcBmUXoOJYlptpPWT6g57d37oYUXP3Pv9QmoogtabDI5gB6XFZUjDzTozNJ9tc7Pll+ZSH+o6yQI87tTb3QSiywBt3Od+0n8lWYF34/hzkoO1YqJgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7fSLwVg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed7024c8c5so6713281cf.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762425664; x=1763030464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
        b=J7fSLwVgcdgqNighfhszmyiy3U8XC0YvVbqf5ZWdr9JC8W9GpGuouG4G8Gv6S5T9M/
         lOlAIRVAV8ottwME7cHUU8dx/Cui9iUxJI/HxH92ZnACfxOLRCdBgA+CJpXUj8b1yOmZ
         WLWlK2RTbJsMf7Vc2oTmxiJoF8Q7DOjztlduWu+PqsxrUunEKRWnTZ3j777fjNtfaE2Z
         aJucj5MprMG+su/b7HPZX1DLB4ewhexVCaFC8pOSfrowwi+lqFN5EaoGk0BHnADyw+d8
         RLLiDW33SJ2tElW/LSzHeDYBDZlKClSqKYNkbldQvFD891XRWHMijGTvYKUb7z1wRkI1
         Df0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762425664; x=1763030464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
        b=XPsef3TXoZZVPw4bJr8uGrOtO6hhFdmCtzAW8EnQU8+TXctdVyKvGvn0ZCyBfCtkZn
         LUB+CrRWAy6P6BYbUkXSaKKeu5pkk1uBIdx3DosjkADFCZ7481gAmb9blEhhCGHggGSA
         N2HEYJlW299FLshOZgbzvt2yy7PD6zOjOziRO0AEBTlJ9Mz7yYw0HADocU+dOVhQH0aC
         5ULMoGycrbov2CbXjJtCXEVLGMW1s85iQ5/q0VP/sbKSoCR044VE20POmTKL8iJgH6uO
         Rk4EDcI9SX9MZg8YA6Yp4DBxWj6CYpKyVm5XBNtCGhEp+DMSxkE8vMiknUn2NxiglDD+
         v7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2JGyK0xzL+MDNAnkJ5AGUqpWChyf/m60tgZd+qN8TfnA0HqxmLnS2FrMezcs/zDfxmsdyTVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHI4Zbrn1PLJ9Tls3yVNcIR2SLV+RQEt9i+tRFIdW0SmfWCrFW
	mZ/9QrWA1enoXN8EWOjElIGUAmGW1v/x80FzfzXsc5ETgm3F5Bi5rDAMg8rPvZXK/KHFrwcnnP0
	E99hd6G/rdqG9gRXCCd33Qa6H4X+QNBXNS8RuuPhe
X-Gm-Gg: ASbGncvGtQ4nMczmiPoJgsbFqL6dFLcZkz7AD3KBv2eYcdNnpr8RjM2yaLx73ez2nIG
	mjIn4xZ46s/Id6YHblKV/seVOi5qIV170NEbjxchFDrlaR+AiY9G4UdoIGgPspNpygmNKhdWocd
	uJH3Bu1z+RyBzj46LMvhzl/QI/iJhwBh0dPS5PhoqkeS/7BSI9ICcXEwEHPaCA8P8f7SYURyIdY
	1eauI4vigT/cKwSx/JkWNG1mqRgPJK8BUIjEu19Dhi0hlVJu+C8GeY6VrEZGW5o9VcR35Q=
X-Google-Smtp-Source: AGHT+IGw4QTWrNAeDwKQA3mseTWaldl/aBYFiJzlYb7bl8eG84BmiMGOLAD768QMPwKw9sPjZXv4X2Sk2G4u9UmgwGU=
X-Received: by 2002:ac8:7d82:0:b0:4ec:f09a:4faa with SMTP id
 d75a77b69052e-4ed7234f780mr76123641cf.19.1762425663934; Thu, 06 Nov 2025
 02:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de> <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de> <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
 <9ebd72d0-5ae9-4844-b0be-5629c52e6df8@tu-dortmund.de> <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
In-Reply-To: <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 02:40:52 -0800
X-Gm-Features: AWmQ_blmcXmxEskv0hK08fp1Pm62Xthwvodkvx571QVJ7EF0DaCgwYh2halYhmA
Message-ID: <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I compiled it with CONFIG_PROVE_LOCKING and ran iperf3 TCP tests on my
> USB2 to Gbit Ethernet adapter I had at hand. dmesg shows no lockdep
> warnings. What else should I test?

That should be fine, please send a V2

