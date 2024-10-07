Return-Path: <netdev+bounces-132895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D981993A88
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF422B22DDD
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737518FDBB;
	Mon,  7 Oct 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ39d/I4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A918C333;
	Mon,  7 Oct 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341009; cv=none; b=VYiU/P6HGJ2QPiAB5wOkKEFcDv8GPfEm1QTnmx9iQ8a3GnupiFyiN1+NSyjoxnOpz1D0SjPujTPVPkfxbHv58KXz784fr2oka0RZaWK9hVKtqpRQwMUVQLZ6MscCMNUKZIxWjCoPc5eopl51Fu9WsVZ9ts8zshePRylfXZtWbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341009; c=relaxed/simple;
	bh=lMYr2w8i5EOn1Iyc14B2K72ENicpFWQ5cRvac1pVhik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtkEJFdEOuv5kPE04WGwNafjIvVyn/b9wfKtdutr3Y/dWY76Dv984ESa2ZZejaJjmCDjyy/IhtZKeuxz+eHGV+e4P86AHlZz8+0675frPYsX7aIeqqepVF0aTFWd2wHkXka/IR5wOzLaaLWeDKopMdsbQ4GfIqirbtu8DTH8nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ39d/I4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71de776bc69so2320061b3a.1;
        Mon, 07 Oct 2024 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728341008; x=1728945808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zRoCM50PjP2pcT5bjxQTZPPZeLxrPi8dWpj13KWPYc=;
        b=TZ39d/I4iysUUzvZDR/8UMLjXmKJzgzurCybJ06HMAEVfeKKA+S2l4pLnKuyfu6MPL
         CL/7qN8Vr5gMKRKXn/lzwc+TkE6f8xDpDsAeNm3buoLZf/1y1Y4V4zMESzJrVuHQJnoT
         DbyOaqQLKT0wufedu1MOrtLwVA/+iCKR4zhS4JvxS/BAP3wuoLsY6Hh4frqsWjRerw8/
         qTFnBtQoa3nlhOs0Fh7SHIAQu6FDUCVMFeU0sJZXkBzQkLw/gRHklaPxGFez/OP5l25p
         ygKZvp48mZg3MpRyi4I5rJzs2372hCu7GakR+i0xoPLpgj957LTz/ZuUg2jz5xaWCd6b
         J2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728341008; x=1728945808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zRoCM50PjP2pcT5bjxQTZPPZeLxrPi8dWpj13KWPYc=;
        b=R2O493Fzwq0CTmgwDfzrqqRmhkpAMC4hiDzMLj2N+Nwmi2hrfr66uWBdv4HeKMhwsE
         nPPrIoP6LCis5TIH0c5TrSKcrBeFMLjk/GmQwOaQ701nMAejIsx+kXkVS11eKSsO5L3L
         c2l1nlqAP4F04oNSG3wKopy3K5Tg5MTh3A0Cd1Apn3F2ksW87HusoKhzZdcFZf3ssPi4
         YxEW3zh4IIZqYHkZMpWtSJ744t307Om6dMCPfmX/Qro6BqRE6w0VhSTX69o9hKyDeOtB
         Y5PeatwDSUOjfy9wJ/p8Bt3Mth01OSf5QHADH3UDCN06nQgwVyo7lCZ7Ab3LAIliyM7R
         3vpw==
X-Forwarded-Encrypted: i=1; AJvYcCU/eUUEFg6u3i0FkrSfaJQ4UAjND30AJwk/c1ovFOV/UQiuj8PjQVh5e2w9fn65wUxZPbWjtxxPjJcESWg=@vger.kernel.org, AJvYcCVO9gsYUIWbsKo3bKOaXcz3I2Oc0OksoIFV5JdzP8+bUm2SsHPqgseNiD+vEDjfEpO3pHgm4+wV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2LBYN5bIcWoVtId+BWWCtX56/ZHfY4ANg/77W+NNS0/Wp/s3
	GjK4ERL4aLY0hey3mqW+ffp4HomVSwDpEEd4ZuqNYQZ8aqyIUHbVxM6ChCX4
X-Google-Smtp-Source: AGHT+IFxh30knrR1pZ3LGf4mcUqQSvDXDXfeA5GtXLVadVkxIy0dW8y7bbTesM8g4tf/aqQpDzctHQ==
X-Received: by 2002:a05:6a21:3416:b0:1d6:d5c1:e504 with SMTP id adf61e73a8af0-1d6dfa46c48mr18472259637.26.1728341007615;
        Mon, 07 Oct 2024 15:43:27 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d7d1c2sm4899137b3a.209.2024.10.07.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:43:26 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: olteanv@gmail.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Tue,  8 Oct 2024 04:13:08 +0530
Message-ID: <20241007224310.4261-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007222234.ekpqibldugchuvk7@skbuf>
References: <20241007222234.ekpqibldugchuvk7@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vladimir,

Thank you for your thoughtful feedback; I really appreciate it. I want 
to be honest, I’m quite new to this process and have been exploring the 
the code to learn as much as I can, which was when i noticed this. I was 
excited to contribute and took a more theoretical approach without fully
grasping the importance of testing to see if this is ever possible.

I completely understand your points now and apologize for not testing 
this. I haven’t had the chance to experiment with it on any platform yet, 
but I plan to do so to see if I encounter any issues. If I do run into 
problems, I’ll definitely continue with this patch and work on resolving them.

Thanks once more for your guidance and for clarifying the intricacies 
of MAC WoL and PHY WoL interaction.

