Return-Path: <netdev+bounces-224344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EADB83E8B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736AB482CC7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEA220F29;
	Thu, 18 Sep 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KM21fzvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B81F09BF
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189025; cv=none; b=otCkXLlGxk0jSHPSoBvP10WPXKP1gLFoxKQ+PRk2ka/KhzGf6BRIaVWEdqPJOTb5pn0hCXVSGizpIWEnsz+N72S1/bW+YB/bQJWOyn+FkYOBMVGKWkClrVTgYQQnnHX2zYbcTAmbmHHfUPDu9EyF5CjuDsRZGHqhZBNtWf/yFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189025; c=relaxed/simple;
	bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKBJGHGxvw9GVddfIG1mD0voT8whEJKoX/pDuVpvgzMmQBsxfvZA9AY58yBnrwBg/LlbLMt/quERVYkqBxaazNF+I8bf8g/mLMAHp8EvrIaQ4nCm9C/TDnFYaIjeLxqnkVkEmRC6zP7f20BT+OuXIqyWJugTAywXjglSpKSHQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KM21fzvV; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-261682fdfceso20439095ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189023; x=1758793823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
        b=JSALsx1kRz3dSHoUWgNQw82RPjzDmhxOy8qMlpujp9GavDqSpV1sU5m7IsVY/eC4ql
         nBLegJwOQzEVCh3LqVc7K3URqClI+D4mPYx3uzwSHw7r7SWDAxf5JYH6wyONzK+sc+WV
         GjIGBuaChSJXsFZtIdzw6L0BUwhl5NNU7zPfHVPVTAPFyvgqz+EHq7E9pkN1kl0bWk4P
         3L/uYPe+D2zxatNuRBtb1xyugzJouem7fqUlUn/A8U4jy5oVuJSGm9SpbFZQj9LpCmlM
         JImuB7fLbPVVCDHylIvtstsDym/QJANAeDfAaqfftv0paazA5JxyNcb7ODh0q2cz1lvx
         C92g==
X-Forwarded-Encrypted: i=1; AJvYcCUUT3h+FrHu1j++5dgTZ6ko7+ygtPf59UkGdovI1HTdLuom0s8joVBzxh19RhlvI/HI9f4U6ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzqr3IOWCwdLk5nekitQ/IHEptACcBZhSLb0NCUHcSIe4SgNWi
	2n/rsot3U6EzUcft3MYqu3FWhKohY2CuAULJ4xJ+rKprBv3+FasnX+pA7jWdTgrr0SIxemhcR90
	bR6XhRK+ZRC1olcC2k6XFzk1kMZdBHce1iIOlFSTd40WmgE/4vpd8CNhQB/RoI5WTMPrniPvQ8u
	ZLwX1kQt/WK28gDfEnLCDt9hP/bfF5GEcqtvOzSp+KB2b/EnmDZXuAZOmwbqK00dB68+OGFXQg5
	cBcUE2fY60uUJdeag==
X-Gm-Gg: ASbGncv+oaDOfbBTm81hPO+wmUeHpa7MLdC3AEDcm+Fu5X7WVdthmPEq3ZJmqHGiM3j
	COyNo45NxApxEyEYDIblqOHnRpC+S32LUR+wtrpD/Tpfh8felTGqjiKtTUhok8wLXBUfv6nSclK
	YvgcIkyxP7fX6OBaSgxcqQoC6h1l79mU59i0LHhDoygSTR1VBtzg20FRwGGNC4jVZq6XoSc8Xkb
	K5J9rfqYOvgeMLwEvCt0md1FIII4r/xHLyV3MWoYr6wuciNqPXRG/9LxQT5yKBycOSZt/NXU2KO
	5A15nrf1zC5WPjmocWmLS7+XWdEEy8COjF+GRd3QtlLhJatotjnhPdvuqwC51+rYy5zfzKkX+bg
	lebUKnu3pd6U3mm/VTNTmd6lkr+r7IltVjmRdMG9uBvKUGq2853Xks/X8e1RlP2IpUuu2wZhAiW
	4Ll/qerfhs
X-Google-Smtp-Source: AGHT+IExv/hLBnDJ9oCtdXNKnmkgsKhMq7rdQMd6U2jozWxQb3qqejwfG3Igd6lt9rGn0hnUPB8wsO3xJULx
X-Received: by 2002:a17:902:eed6:b0:269:4752:e21f with SMTP id d9443c01a7336-2697d1bb308mr23548205ad.22.1758189023164;
        Thu, 18 Sep 2025 02:50:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bd7e9sm1706435ad.68.2025.09.18.02.50.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:50:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so9912855ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758189022; x=1758793822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
        b=KM21fzvVVwHg2duGzac7XDvOFaAxLbGjNPwMu6V+M4hFrrK6T9FgdHrJ1k1hymYQnx
         q7W3KCGRvqv9xN4R7FIZpweJIJPbnNNiCl4QtfKKq7JLvoQOm/vp7zkcxoF5jASdf2qp
         4ebLoHs7xfWoeCi2ipK22+3FI32+sZuefb/Xk=
X-Forwarded-Encrypted: i=1; AJvYcCXEPiYEz2QbP8ET0WBDDiMZ52TGggZ/ac2xg6ZWy34VTkB3jcSmSrf0jCD34foJLeP0hHPAtsQ=@vger.kernel.org
X-Received: by 2002:a17:903:1211:b0:267:8049:7c87 with SMTP id d9443c01a7336-2697c854cafmr35711815ad.14.1758189021687;
        Thu, 18 Sep 2025 02:50:21 -0700 (PDT)
X-Received: by 2002:a17:903:1211:b0:267:8049:7c87 with SMTP id
 d9443c01a7336-2697c854cafmr35711605ad.14.1758189021293; Thu, 18 Sep 2025
 02:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-2-bhargava.marreddy@broadcom.com> <20250916151257.GI224143@horms.kernel.org>
In-Reply-To: <20250916151257.GI224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 15:20:09 +0530
X-Gm-Features: AS18NWAGZjI9AOoElZ1PqbtOBjTR_Wkcn8OAuWFBln13azhgXSnyquR6Rl4ZLWk
Message-ID: <CANXQDtbXG2XjBa2ja1LY7gdALg-PnEyvQBWPAiXQqD0hvtwp=g@mail.gmail.com>
Subject: Re: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind
 on failure
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 8:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:04:56AM +0530, Bhargava Marreddy wrote:
> > Ensure bnge_alloc_ring() frees any intermediate allocations
> > when it fails. This enables later patches to rely on this
> > self-unwinding behavior.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
>
> Without this patch(set), does the code correctly release resources on err=
or?
>
> If not, I think this should be considered a fix for net with appropriate
> Fixes tag(s).

Thanks for your feedback, Simon. This patch doesn't introduce a fix;
the code already frees resources correctly.
Instead, it modifies error handling by changing from caller-unwind to
self-unwind within this function

>
> ...

