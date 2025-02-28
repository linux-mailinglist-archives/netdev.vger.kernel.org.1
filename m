Return-Path: <netdev+bounces-170818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC47A4A0F6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6075B3AE72B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1691607AC;
	Fri, 28 Feb 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHxwVNnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D821925BF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765255; cv=none; b=a1S7RJElNZClB/LvgPnA0om0rv3DuchWaEWJ/GK4p0YLnjN14IRUCrMX2Ng7qYPoHPQV/Y0sHhzokcR4s6SRnhY5miBES7VTI71/Vc4lNBo9EMRcOnEPFhmD+bTOTyGYvunFGvoOpPXhteXZiJwohuYpheqj4srdW7K5QMNG4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765255; c=relaxed/simple;
	bh=u1+7MTEmNylFc5L9CoXkBtTmEDDPTyP3nTJh0lf/FAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwuwYaK5XGnp1lcmftjWKYyFOg5kFhKcoqarRkRksPe6m7iH1WWfNBdCqcKGCyv/A2YCL6/XruMqTPFFUypGK+UhYFklG45QZGJzrUz2nTtTmAwXgfD6U0EIfKggk6LKXwBIxdligVru/mJVtQBJOOJ20+mpk3axR5KyILD3hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHxwVNnj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212222d4cdso4915ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765253; x=1741370053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1+7MTEmNylFc5L9CoXkBtTmEDDPTyP3nTJh0lf/FAc=;
        b=pHxwVNnj+xwfWh3WduiIXpoKtq+o951G5UDtLKqGj61Ig2LwXwYdDdf7z6Y1CpcZVD
         7KW5c2C2z2PD3rGwmrXZaip/AXDNCNQdQ8Wm1efSazM/FABrVoGFByeulxtbjpFaSRPp
         KqhjTA0mR9v1DO1kpOOFch0s9fmlPNxcgVhfdZ7RbvSu3HT93usKO8wwCsdg7M8K/AsH
         Nn3qD3DWFUENhN7UiajD7HDJgLuau1dd4ylRVhPeDgD1fAR/e8mAjwgWlbdWoJ5ywJzK
         yxKfPgaKHO8IodswOWwvBJp2sFowCA0Ap9slOz8m8bojbs1iZEj4/58dS8RLsZCSp8yh
         3idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765253; x=1741370053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1+7MTEmNylFc5L9CoXkBtTmEDDPTyP3nTJh0lf/FAc=;
        b=D/2bsGaW1Y2rUgiwU/5HMgw2MnIWpEJ/d36DR5GI9u/vq6jg5s3qbGAzBhi6d8FqJ/
         CoonujsYCe0wwap3PeseQ9lXipC7adLB38+YvbEoRz8PZ8CC6G4kEl14olNplvbKV4HR
         YNHzW+VMmEyb61B4Ft2AwVPwbWSNnH652xhMtgNdbfl1dnDKSHtxsIrj3sFPOIkm2fNe
         Dk8KKNl+Au5JLM7+unP5sj6CoDN/dLvc4NYAHxDjr/Q4g+RLY4M+xJPIoWl411eQ++gP
         GOVjwv8Yml9Csvk+tICo8EOZUnzCHL+3ZUMSAB0/Yf69TmrvZWm9NjV5u5x12Pi8eq01
         rMNA==
X-Forwarded-Encrypted: i=1; AJvYcCVvxRVZI0d56+373sC5DpzYKSK04umQ7FwdOqV/t78YBLnqn2OpADTn7imt6Ql9Uzu6vLLYxLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWf2dmHti+OtnLHnR7mXeLxGD+YUwwHmVvA1KegDmUUY1E5XE
	A87/8xCrWAlOjYk3oLVAd1XffHrNy/+fHIzt+U2A/chv2TkuJJeBTtupKZArSw+ilWowDzm3l/F
	dTWpc+EXGsBW5277qkeaL5t+Z6hBv+mOsqIaV
X-Gm-Gg: ASbGncvV9HYoGie13zXqgBTMaJja1k5HMsYbcFVG+EBM+nV8+KZM4Qn+6r/k4mYpVVl
	b32l4Al1ABfaB+BBUOr38uyuDqGSqpsuwIhWd2KlhAvT2g/A+nBbnEbotW3vnBgkFuhNfZV6yIK
	KtRy99YJvfg15Vj1uPM9IdL4zczO8enKQDQYG9Pw==
X-Google-Smtp-Source: AGHT+IEvTaXlDasEqbeEQGkrtVNWGlGALAci/M96gPscJI/Q4KdgYr6oOPPlkSKal1HsW+odkXQc7CCR/1T+AEUYwRM=
X-Received: by 2002:a17:902:cec8:b0:223:5696:44f5 with SMTP id
 d9443c01a7336-223696de90cmr3320855ad.12.1740765253140; Fri, 28 Feb 2025
 09:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-3-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-3-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:53:58 -0800
X-Gm-Features: AQ5f1JrO0hjup0i30Abxv6Jk8dkcSZFXP0H5NDUSmK79wgbylwsq--nAdPO1I44
Message-ID: <CAHS8izMXC-ZigZG+R1jrd4i=ZDe_cgUjgBhZa6px2JUryGTN8g@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 02/10] virtchnl: add PTP virtchnl definitions
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:16=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> PTP capabilities are negotiated using virtchnl commands. There are two
> available modes of the PTP support: direct and mailbox. When the direct
> access to PTP resources is negotiated, virtchnl messages returns a set
> of registers that allow read/write directly. When the mailbox access to
> PTP resources is negotiated, virtchnl messages are used to access
> PTP clock and to read the timestamp values.
>
> Virtchnl API covers both modes and exposes a set of PTP capabilities.
>
> Using virtchnl API, the driver recognizes also HW abilities - maximum
> adjustment of the clock and the basic increment value.
>
> Additionally, API allows to configure the secondary mailbox, dedicated
> exclusively for PTP purposes.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

