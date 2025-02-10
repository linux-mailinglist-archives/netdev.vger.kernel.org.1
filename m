Return-Path: <netdev+bounces-164870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F636A2F803
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D973A6C15
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7225E44F;
	Mon, 10 Feb 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="o3NFL+TP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAB25E444
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213891; cv=none; b=W85gzuleJiwMjlOCLvYTqPXY7iT+lwG9DBmEodC1wC9xRhJLHxTPChY02io5smzyP2Vj2DyDeYjKyoWBwVFkKEeWITcIXNDo/wCpg+qoTmERNnrvBMC081HYDacaMc6tGXGdr+uWX6FbPRq6b2clxRtd1U73HTwnhAlF4V8s/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213891; c=relaxed/simple;
	bh=WcZOt/8UdGnkrERNLzpoyMng3AhbZ9RlL54mVWmrcK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPUsBOClsJpFKwvqgK583o7aW/vn1QGb1PUChI42XoyQhusy8ugS9YCr0sjcObU9QSVqwxXMYOG7O0qymb7pCCFEphyo+SwJugQoiJjVMiu4h2g3wQmJoMJiq4DA+6suxJkz4RWP8YnneMN6vJaPvtHRgMFG/YutYL9Yc9zCI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=o3NFL+TP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa1d9fb990so7314358a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739213889; x=1739818689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zHnrC6n0TeOwlGCGatrhmAfbiOBH4dMEPod+mMdLNo=;
        b=o3NFL+TPN9qF3ulq1oC8uk8sRILWMeuIGLcdSesKMlInfuLPtx3FiY9Kv//swRiKvH
         RpLw5fgXwCU1oPgF3LWHs80Ap70zYqy2BkfmQojjJKat4vpdcrqLwVgchPPL5muGJKWE
         vwknEuP+DDzCeHKoK+3TDzj3QqsZVoUSOIdVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739213889; x=1739818689;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zHnrC6n0TeOwlGCGatrhmAfbiOBH4dMEPod+mMdLNo=;
        b=uhT0/zZ9ChDv79C6at2pAdDMUM0JKb58vyiS2zhKDqaCQodx0ZyXI2tllH9HOq228x
         gb/tp6HfOfbyIU/H4hie30+r57kPLWy9UoMf5Nm0cVHtt5Tk+kFztUyfdFtpCGLgjOSb
         rp5Z+nkZ5mK3PnhDC4hLPqdi61WnDO5eVX/IwDKLmxoMW1feybLXYPen73FwMvHsmWnZ
         TKxQLTMj7kfZ+6ld1Xo6en6rhbod91bXkrhd9WLo2AKqsKHuLVufplEGNHmoN29r0Oam
         Ql5SFr3S4ZCB4423us1vVt8ymYROlXAlMEvlNWIV7/7nQrjtBM6nh2HS+T07YPq3CbJf
         u1vA==
X-Forwarded-Encrypted: i=1; AJvYcCXQdY8mX1tAj5V60JAkeeHOCpUqz0rdbFZwPAQpJWgTZ4coYiuKz8EU62s0MAyhWrAVrXHOvJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7g0VYHIUNKHUo05/ispja8Y+419DFmFk4xWgmPtd4sOZy3nA1
	8w/cxsfV4BYiSlCdtMUZVuazfSCVVVTuVjLQo1I0QmGfKJeoYD9KiEbdHL+zTmg=
X-Gm-Gg: ASbGncvkvHYF6Ap5M47dWG3vtRySY+H1f7KD+iQBErrci2vBfycAFZXdinXXsKESAWg
	NMnaSUyyXWT1sR3CtTzJNdfvLkuyuie2IRJdv8Gdeo25jLMPbJ3w/nwZ9XEgsgeFl45y7gEPjo2
	AigpMdX4NrDdhbd5mvOEk4NBvc6qrRsTYgXUiFkbw1rtf+nd0Lk5QJwWTe7dVaL2M8UnJBDehhV
	VWAUpZRYpSES4AHrw29EH/xdy7LwApAZoULeZSqB/HcCR7FEwK8cBXXSerD1iv4Dkmo190fqbdZ
	0Vpm78wAg4NvBo2rqd6Z6sikQpVViniJ/iPf/+mEiHZT436BdEcGdNbSOg==
X-Google-Smtp-Source: AGHT+IGHgnYSQErZE8yGUy94KoNx/ROxyl34aGTRRYBqnCBnaQxsLlVhC2jGO9rivDS3sBpC5Yd2kQ==
X-Received: by 2002:a17:90b:4b8c:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2fa23f5ad20mr21288354a91.1.1739213889121;
        Mon, 10 Feb 2025 10:58:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0b9c5872sm4021465a91.0.2025.02.10.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:58:08 -0800 (PST)
Date: Mon, 10 Feb 2025 10:58:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] igb: Get rid of spurious interrupts
Message-ID: <Z6pMPhn5Igl212kd@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-3-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-igb_irq-v1-3-bde078cdb9df@linutronix.de>

On Mon, Feb 10, 2025 at 10:19:37AM +0100, Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
> 
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
> 
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
> 
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
> 
> Follow the same logic as in commit 8dcf2c212078 ("igc: Get rid of spurious
> interrupts").
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  3 ++-
>  drivers/net/ethernet/intel/igb/igb_main.c | 29 +++++++++++++++++++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  1 +
>  3 files changed, 28 insertions(+), 5 deletions(-)

I am not an igb expert (nor do I have such a device), but after
reading the source a bit this seems reasonable.

I suppose perhaps a better direction in the future would be to
convert the driver to the page pool, but in the meantime the
proposed change seems reasonable.

Reviewed-by: Joe Damato <jdamato@fastly.com>

