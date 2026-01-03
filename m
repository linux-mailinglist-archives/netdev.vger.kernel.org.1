Return-Path: <netdev+bounces-246647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FACEFD68
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D636430139A4
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3C26E6F4;
	Sat,  3 Jan 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa7gweeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F893FF1
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767432373; cv=none; b=ATA46VmE32ZFi99CDuxINhfq8B5DhJ1AsCQOlUXkLKhkMDWAuBU2VkIuHDdanPtcHa42j1Y7q9PDTb4FDn08YIR1VjLN5r1pT/8AUEmGv5s01PsmfjhNpwf6kFseKQOainnplYYDjQCcaDzZEyhu+B/MyzjMbCkFpBIvIETcOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767432373; c=relaxed/simple;
	bh=vle9Ag7qibu12+pOyrt/t56LIo2yum2fFZGs3HL+p14=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QYOMcO6NKzkY7Oa+KCFYklZAEA3hBMpTvyVn+yuD9DGRDdCmZjYiv6F1pB3JF66vLIc4wsFRaJK3BlWLux6XKX9gJ63FyoqozPJhUSbFXAJ8aYPU13y/Ph0Qv0XqOyvvReln1KLUZYKkCerGrTOurTmyYMMHch1AMlVISm73svM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa7gweeb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so7730919b3a.2
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767432371; x=1768037171; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw9/KIR+ZU50XPgCeIcMYWC/Y8rEfWLDvWIbH1mNUiQ=;
        b=Fa7gweebw4PtOUAo8iHF/bVRfEUoMt5Jqmd9vhRjzxWphyKpNkcoRzXXUkmM0kuc/T
         Ucz2McOD3cIBkQoi6dQxXDSNx8I0Q3SXABZnmguFsRlIQv5YAmQuXFFWy0UYXkhG9P2r
         DQY9eONKkCqdRmDiNSwppZOmCQo2SnrkrJuiX7SrSTVJEXLL61FUEqUpIb4VAiWqYL1I
         RPk9+xQeE0YpjinGC3jFJ5/LMvSAqCTxO8JrFJ6fRUTnoYER42/IL2F5mW2Rz5FZSrcK
         uBwrQVFokoy40OJvs1W/5glqJ/GnYRfFXGBVk3qzR8TG9UrfSBqw/w226q6v1BWrOoB3
         Yaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767432371; x=1768037171;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dw9/KIR+ZU50XPgCeIcMYWC/Y8rEfWLDvWIbH1mNUiQ=;
        b=K3OSu2poxRnjsG9Y1a4fLR7j1VfAzCP/ejB/g/kWFTJvklfPXP0NZlwmQwFl+dKghc
         9fovaCedP274JxINI0tj8G9FOhGeSCWvWBiWWFijfh4LP7FOa4RY0JWBT/6LbqBnIKl0
         /900MbEEp57t4xiKFxyBTZuW98Xh0zFMVtaz7FTSHAHBPeF266UCYoTfvW2CiXLX1Ooa
         dHChyFeHLIraCbFimVCpfs3pChsRCbwcXxbLL22UrsPebSt4w3bfp4d9iTLo9Fmfc+3M
         1Jpylw5tzmm/eBmcQAldnzn/biCLLzSCMfTSXkdAht+MkfsbbbJUb+Hgo4BBlhnINVPq
         Jcuw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMqEX2MQ3qv5zy6ZmLkaUCKd/vCHlv4bQ+FO/Agt6FY8cdzKY5pk32KMln62cHepwSOmi5Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aVXbuG8vXzMG0sNErIaiHxHxIVTT/pxuwmlNITlWIIP3Lc7a
	5fyQ2gEgWk9PhPMdjtu4CGHQkomOMyZZcis1vvHt8CUzmrsxQuv+d06i
X-Gm-Gg: AY/fxX5TBHP4BzGC7hbH6+Df4U4r54Qt4w+1QPHVpEcDvAQ4TBopiN0D2bpsHlMUHj1
	Frv11X9AvEuPKN8DseCmzvAxxAcYZUax8bBZtp2n5dw6voeUfV4MrVITGFAoWF3rm9VNrc7kYz1
	fSgO0qAHes8bTAfER4qOITO/1kslPP+9mES4dW+B84G4OlXia5Ghcf1iFGRW4b6aI69iZGV4AoX
	BOt05xTxPmaIEqul2j8ktyrTohso+00S8LDS77j7AWGZmsD8OZ7PnPdDtoB7zCcaJe0gIjm4aNY
	RAHqy+1BMq5KcCNYMZQt1CHGuCFV7C/Dzvd9Hwjw9l6geX+9Ogq+GwX1S43ByyIb1Ag5oIkybSl
	M2sZx2YqGhNA3n+XrTkqaL6YrvdMsNi7tNyvWp1ugFV4Q2MqfvNT/kT8BCP9voSzoNs6tYrVi5+
	KSzG2i
X-Google-Smtp-Source: AGHT+IG2jZDZEbShKoJpVv1TUdpfWfLrmFxohCD7Sq/sA17KMjrfWcbqTnIgpWHlgwxUfYNjpGk57g==
X-Received: by 2002:a05:6a20:5483:b0:32d:a91a:7713 with SMTP id adf61e73a8af0-376a96b9012mr43783710637.40.1767432371306;
        Sat, 03 Jan 2026 01:26:11 -0800 (PST)
Received: from localhost ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bd61b4csm36930157a12.18.2026.01.03.01.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 01:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Jan 2026 18:26:07 +0900
Message-Id: <DFEUHGEK3X1P.2AZ3M51UTBIH4@gmail.com>
Subject: Re: [PATCH net] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Yeounsu Moon" <yyyynoom@gmail.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251223001006.17285-1-yyyynoom@gmail.com>
 <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>
 <73f3d573-c093-469b-ac7e-36fdb7832933@redhat.com>
In-Reply-To: <73f3d573-c093-469b-ac7e-36fdb7832933@redhat.com>

On Tue Dec 30, 2025 at 7:57 PM KST, Paolo Abeni wrote:
> I'm not sure we can do such change: any eventual user with bad setting
> will get a broken setup after kernel update. I think we should avoid
> such regression, and use something similar to this patch.
>
> @Yeounsu: the type cast in the current patch is not needed, please drop
> it, thanks!
>
> Paolo
Thank you for the review. I'll send v2 patch as suggested.

Separately, I agree with Andrew that it would be useful to alert users
when an invalid value is provided. Would it be OK to send a net-next
follow-up that warns (via netdev_warn()) when rx_coalesce or rx_timeout
exceeds 16 bits, while keeping the current behavior (no -EINVAL)?

    Yeounsu Moon


