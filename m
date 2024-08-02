Return-Path: <netdev+bounces-115424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C6946590
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D9C1F2387B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922C13B599;
	Fri,  2 Aug 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMAXPefh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726976405
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635367; cv=none; b=oJ7+TZW0mmEL2ZgSnd1XMKZTwINsCK3VvIoREtwWC0AEkUK5K63TY/io4U8Zo7Pid0zZrKIEbVQ8pmnPBNN1OEnLDed+XsFbb+vHbjyWVpqW92VVEmBGwE+mDJtNw9MHntUh7kRaXvpEHT33pDXSWBMWoT42KQuYg5zWOY6mOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635367; c=relaxed/simple;
	bh=R6Zb/F6ag2O9vZ0Pie9haG8wBF096YdqUXtCoy88kzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIKGGqtNoVADgU8gpyIn8GYnpVBNlP4a8DKk/mj7lYySE9Edp6OtV5/tpAjc0DNgAhnlSqDSESdXCDZmmQW9ci802BMNowflxlVM0T7td2AjHU2/NY++uIcj4WPGAGOe1fTFE1MBtsZztWqPPUwo7AW0GkHRuMeMPJT6or9ulbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMAXPefh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d399da0b5so7399923b3a.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722635366; x=1723240166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3xun6ZAo9oUFbxVpXf94TJW8gwMbVmF/wsipE1ixAQ=;
        b=MMAXPefhQ7IMOrgPPXIVv0/B1WUHN//X1UtOiGwxOhvBG9+uFUX2tngB3UNjAoRJyr
         J17snpyYCr6QpDL7/j+gkxnXGkXOztFU+j1L9+YdFNV0mBdwpIMYAJ7oJLunFnbY8SmZ
         6YpCSr7S1ObOQKEe2eAlLke1X2MedZDkqVfh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635366; x=1723240166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3xun6ZAo9oUFbxVpXf94TJW8gwMbVmF/wsipE1ixAQ=;
        b=YhSv/jrUS9xuuiP/Kmit0ZXL0xEZJSuoHzulMC//mbqRpuXMtSEb/Fvh2ejloo92tq
         QPKNklRCH/R9OHanRKtaALVxeCbv6awyadkCbbP/q0734DOvyxS9WACWY7dcZJ7DVDdj
         YWS065O2VJrkteY4yNN4aU2Cn/vgDr2SdgrqNaQfeC1b8BedsUCEKWCqR2zVJvIHXKV3
         ZBqq4yH25SviHdTXA6cbWkW5DHoyfb00sSVENsLlqD7Bv2/VTMFlt/TdxeCzU1TMnzfQ
         SrCL+jmOLtTajsololPScjTQf2lCe0FFwqPUDxOk6HB2duscSTQhGIV6rPOmp/dfLMNU
         FFTQ==
X-Gm-Message-State: AOJu0YwtE6auAb4PWSnvCTluf6g3UU1ouywyMN8EwsR/158NSFNVzK88
	kg01nr5vKA7i7S+80ftkY1rnqfTaTOTkRj0Ev33esmWkrL1+3zEB1hti0/kdXqgSblNYLAOnQif
	qE9icXP93CF4rWo2cF1aCgxnXo1rDAoRFSU6u
X-Google-Smtp-Source: AGHT+IHEdcupwcgV7ddSI8MH7LC3yQiJWlc6iHg4NY7jwa0Xdj7aQ/eTSphT4Nip4j1IqjjX/NtSYYnTEN8JBwS7BjQ=
X-Received: by 2002:a05:6a00:9187:b0:70e:9383:e166 with SMTP id
 d2e1a72fcca58-7106d047460mr5185025b3a.29.1722635365498; Fri, 02 Aug 2024
 14:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <ZqyXfonFv1GNlbvK@shell.armlinux.org.uk>
In-Reply-To: <ZqyXfonFv1GNlbvK@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:49:14 -0700
Message-ID: <CAMdnO-+51MVQjdJAs5XXqcOzjK7=JZJ5KhELKcws8h3JgM7FOw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:23=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:21PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > +static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_re=
g)
> > +{
> > +     u32 reg =3D readl(priv->ioaddr + id_reg);
> > +
> > +     if (!reg) {
> > +             dev_info(priv->device, "User Version not available\n");
> > +             return 0x0;
> > +     }
> > +
> > +     return (reg & GENMASK(23, 16)) >> 16;
>
>         return FIELD_GET(GENMASK(23, 16), reg);
>
> For even more bonus points, use a #define for the field mask.
Thanks, I will make the change.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

