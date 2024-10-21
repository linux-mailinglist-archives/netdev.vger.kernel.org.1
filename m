Return-Path: <netdev+bounces-137619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD139A72B6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169461C217DB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7A1FB3D4;
	Mon, 21 Oct 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEzT7DIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342C1FB3E7;
	Mon, 21 Oct 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537024; cv=none; b=NHYAL85y9ZkWMRy3t73EB/8pDI7bmI9ouyoYvGevbTugK4+XjnyJO3ipqrzwL3/oNKh55t06chZG2YQiC61tjpkLJSY1eGrppCN5chjVbjItcUdLAnt1q8X0mgXIMiCXH+ccXv8IS+yAHC3SZ/k8dX5M0wpS8g12CqMinC6Yd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537024; c=relaxed/simple;
	bh=THJwr5sx8e739yZL2Rlpxvug2E6+/wO+QEtS/NLOe7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb29h2YcjsECm4fUuzpndm/JKJK4OyqcXzBAsrCLH9yPAaX6FFEzhIr30PmXFJ3oYM9Q3K8Rm3U4R35voQ9OhNwpSHCDji4osEgIy3asF8IGLypogm9KpU9h0bOYGPvgGz+1jyXv5804tgp1lwOEENy3VY8PWMupK2HQNb9Ju8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEzT7DIO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e35f08e23eso44260007b3.2;
        Mon, 21 Oct 2024 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729537018; x=1730141818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of83tGxq8wRCfjGC40ujhPw8LktJT4+EXoa6bRqngi4=;
        b=dEzT7DIO7MRX50NZo01DbXnSYhyDLTh8JOBSBGe8zfT3uj1Ey97xSt976psAeI9DRU
         PNcF5nKQ3qFg07JisBuvxM1MVYkTmmKvhQz+Mde6eX63rtUFTRAdexAAQ+IbupkUqlWh
         y43gNVUBfCCanmDOKINDm+xX4vG+Qs0hI3DKXjsa3qg7nV2yhE+dxuqqX0Wctl9ujoaf
         jODM+JwRAZfguoVf2xxbkVB1cgHAu/nAsKRHbvZVP4ekOTWlytlU++7oot69O+7UfCaa
         wZbraCSMndocWQaZCrznREgj6733Igg8ZfPdNERx4IRhoFUupCg/6iKFlhbT0ZVgrA9F
         HRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537018; x=1730141818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of83tGxq8wRCfjGC40ujhPw8LktJT4+EXoa6bRqngi4=;
        b=sBB1LMsbSaVg4gEbm8CvwBoIwGYQzNvWDFbMojNGkaxLJ/M+IjwRSp2p6UE2iOQbzn
         cL3SVszvEHpLq1uvRb53WNNnb4fp0ugyh0jnih4+q04Ne9CasauDQbDbVCHkpC3IJ8/z
         gw/RaGbVzH1iuo+RB8kE4C86fpvEsm84HJsciiWfeMn7OjQMSK5UqFyi8Tw+DhGAmNoc
         xJdmwegDW3NU85/Xbk1u0gI7PiAnG03R97Ygjg9nC262nTU63OCE6k2BFkPZjAU5il4O
         LoV5Ytrh0ylvxEV4DJkJmab4Nj3+bbhyAl5awiuk8aaEhLg4F9igiGW2ZXMkYPsF4MPU
         P7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc3Swgzy41w9L44mD+QfN/i0SelG2XLvrLorcNzva+yLuouk0X7DXLnrmyEIy4YezrbQnoYb84IaBtzbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26JEwt+d9DU85KeLH3RzBuhRQaH9Ya2c4kiNQ1xbn40j3Syoa
	/J5DF68FpQ5GPOCQAy73UCGuPswBrasau59VCyHzNyY0wGsIZpK9lfuYkid2D+YNZGvYPiYcUhg
	Ww2mVSOEDeSF+zEYCpeYRqrUMODs=
X-Google-Smtp-Source: AGHT+IEL+tOG+slMvBGBsTtbnqFqwHmEYxC7PGmgfa0W/ZmcZvBpyCvHP+2uE6BeH76l3CMgN7pXlxzFDgh5f7Pedx4=
X-Received: by 2002:a05:690c:4907:b0:6e5:de2d:39e0 with SMTP id
 00721157ae682-6e5de2d5659mr89905677b3.42.1729537017987; Mon, 21 Oct 2024
 11:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021010652.4944-1-rosenp@gmail.com> <CAH-L+nN0W_BffMR6s6Je9LufSs5ZtSHm13_O1aGhDnTjPNqouw@mail.gmail.com>
In-Reply-To: <CAH-L+nN0W_BffMR6s6Je9LufSs5ZtSHm13_O1aGhDnTjPNqouw@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 21 Oct 2024 11:56:47 -0700
Message-ID: <CAKxU2N9JGwfg37Qoj=gLj0_f+cd1dN_ek+GT402xOe-Y2M0xtg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mv88e6xxx: use ethtool_puts
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:27=E2=80=AFAM Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> On Mon, Oct 21, 2024 at 6:37=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Allows simplifying get_strings and avoids manual pointer manipulation.
Looking more at these files, I see further pointer manipulation later
on. Specifically I have this change locally:

 static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
                                  u32 stringset, uint8_t *data)
 {
        struct mv88e6xxx_chip *chip =3D ds->priv;
-       int count =3D 0;

        if (stringset !=3D ETH_SS_STATS)
                return;

        mv88e6xxx_reg_lock(chip);

-       if (chip->info->ops->stats_get_strings)
-               count =3D chip->info->ops->stats_get_strings(chip, data);
-
-       if (chip->info->ops->serdes_get_strings) {
-               data +=3D count * ETH_GSTRING_LEN;
-               count =3D chip->info->ops->serdes_get_strings(chip, port, d=
ata);
-       }
-
-       data +=3D count * ETH_GSTRING_LEN;
        mv88e6xxx_atu_vtu_get_strings(data);

        mv88e6xxx_reg_unlock(chip);
Do you guys think a v2 is in order?
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> LGTM
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>
>
> --
> Regards,
> Kalesh A P

