Return-Path: <netdev+bounces-136559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2119A2158
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08CE1C2185D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51F1DB34E;
	Thu, 17 Oct 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfjypMXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201B1922CF;
	Thu, 17 Oct 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165390; cv=none; b=jiVJ3kKMG6av7DV5Naapk8StJesfWAq7z+dE8eI/0yxAMabQRietR61xohKzw9WO1Mf3GtQgJ3uOFLuOLQHpgjI9R7RM/FyLNRh9mvOTVjBofVx59tWaiqrIehA6nRf5mAfDP9yNexMHTgKtQ2zupO6Nv7oY0BrwBjjEqlVMXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165390; c=relaxed/simple;
	bh=puN6p+bMjYJtsrg56y32J8yDB4IjMscvJ6LWf1rgN+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=np55jNy1gK1LkDcVeu1bSmvH3I6Rm8+eNqEucL8EEOV+lYLaKy5XKx3NOXua8hfkboedYp2mVE04TN1nHfRX3NMXF+7r882gvGEXCrVfjyPtE+a+7RMHRo8rUW9uA5ujdUg6/UdqJxwSi8azy6lOw+u4W0uSUhOF31HSXJSM1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfjypMXQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c6f492d2dso10378885ad.0;
        Thu, 17 Oct 2024 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729165388; x=1729770188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puN6p+bMjYJtsrg56y32J8yDB4IjMscvJ6LWf1rgN+k=;
        b=GfjypMXQUC66WwQ+T8cKp+b5Lu+EOsaXSMSmv7uXNPXbHlPvzUFSntdpTfSKSUVJoI
         FIqgETsfGQUoONt9KBzyFrFxTCOVWiBWWMPE3E1R29z1KsRiVFRDNwJwu4b7TB76ZEv4
         s7uvDTAb7PUD5dl9XUphHpYecIw4b3tIBWJ1HMVfm9PztD4JPA+ShpRSwjp/lOQbWWDY
         5n6F9fXcDTnAVTOH1dERLHutrmncFsPluxOT+4piVICkGKKgOSOIIERYfJi9LmcQIrla
         oJSvG58a219O2UWP3ETS6lBJhRTVh5/wtMyEUAOdAaAcyGldUDBnuBuff4INS9UQwRUi
         eG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165388; x=1729770188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puN6p+bMjYJtsrg56y32J8yDB4IjMscvJ6LWf1rgN+k=;
        b=ojEc0PGqzSOMl7WNEEGpuz95Vp4ZsagoLqlVz91xP/1T+f56grd2CFRTuXYQdFHVfJ
         E1Ry+Y2Uxl5y3kPG4tHQmDVfUkwBEqnUdsOCWI8MoFJSPnIjqwmIZQBUqw77MIFHLslQ
         qk1kQLT+9+n3bogBH0wORezaZARJkFdySnhf0QuhJTUX8niE8VzNbYj1ZXuehmJPvthe
         npi4LoGCV6OU3z96cvb7PiJBtqdu2LfV6fjpwyjoEQ+8zWv2GuKtz9nV59x4zQ+AJ1eR
         8D4R7tKkf8Fi723SB2ggGFumcd0clKudTkxvcsDLf3lVXz92Fr5jAXx4xKcCE3+jevyF
         je0w==
X-Forwarded-Encrypted: i=1; AJvYcCUalxaRD0GdmCPlucycL+QkDtvrNBgfCMJ643Q1Nz72gkZIK0jkVI5hg8jYKUklwdeupUKFtOGIsCtn1OM=@vger.kernel.org, AJvYcCXmDGBWmD+qoN2NA3uMavIfWjTMre9mkgtlKp/zLbmmKp251lFxBIicjo0PIYIGQTF9QjJ/9Vlt@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsYVQYb6X39VySQebpcHG22kNkhEuGi+S5o9UWI31Hl14I1IL
	CjeFD+aD23LPTGeJV55RNouHmSU2Ja9XnQdA7TQbl7KZCJWFTeEQ
X-Google-Smtp-Source: AGHT+IHJunnh0cmVmNuXc+ArxYGx076cO6tNN4BAqDDpgEMgZwnt3Rmb/lhQ7qL4SW+VAkF2w9+WzQ==
X-Received: by 2002:a17:903:22d1:b0:20c:a498:1e4d with SMTP id d9443c01a7336-20cbb2afd17mr267223905ad.60.1729165388225;
        Thu, 17 Oct 2024 04:43:08 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2d9sm42705255ad.184.2024.10.17.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:43:07 -0700 (PDT)
Date: Thu, 17 Oct 2024 19:42:58 +0800
From: Furong Xu <0x1207@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v3] net: stmmac: allocate separate page for buffer
Message-ID: <20241017194258.000044b3@gmail.com>
In-Reply-To: <20241015121009.3903121-1-quic_jsuraj@quicinc.com>
References: <20241015121009.3903121-1-quic_jsuraj@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Suraj,

Thanks for this fix.

I tested your patch on XGMAC 3.20a, all goes well, except a performance
drop of ~10%
Like Jakub Kicinski said in V2, this involves more dma_map() and does add
overhead :-/

I might have a better fix for this, I will send to review and CC it to you.

Thanks.

