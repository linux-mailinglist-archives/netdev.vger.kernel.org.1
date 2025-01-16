Return-Path: <netdev+bounces-158693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A765BA13013
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF423A579A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD75BA34;
	Thu, 16 Jan 2025 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbCY/hK9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59726AE4;
	Thu, 16 Jan 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987910; cv=none; b=dTAM1Gghic7RCaQr2R4c1WNX+8+tzLGrY2JquJ302qEFcdpgDByYLMp4ogHJAsJmnFMRWZFTtitn/2uAX0fs3NlX2CHbARHXVBOEOUH50vsoLOHw1HTSWltY+4PafAOjpjqX416tfZ1Gc/WRYypEj5WEwprgcIJ2Ku4ftIT5I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987910; c=relaxed/simple;
	bh=ouPicFLZeKk4wGv/EJPSp0pBEcfXr8CuU2Y+G1o/DU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0iT3mgp4dh+IwOXdJ4nbkwQ8je1HJIx+NoqhTkNV79cy5Enpm23FRf2fomfnBSbYUFwfSEcpnR0TVE6ATiFu6j1PLqOKSFDNSvMx8h+meVG6VZmBWRc+Pxe6mHGIecaBpyMGE8eCKzUoUkVWm5AvhvRAVDdydIE7JUNMoJ0VHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbCY/hK9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso64366066b.3;
        Wed, 15 Jan 2025 16:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987907; x=1737592707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KrZJZ3OJ0cLB44BNHBSnPXb9TFsHpSRbAFHEpeeUrE=;
        b=EbCY/hK9IbAqlwhOgbEiXDQQKhiCr/wgEX0eu8lMyFgcwB0wDXdb1gatlgUd9Bzhas
         X+lPYOOqMyBX0LqcZU/OFYnUuDrvvjCOQRXQ20mPX/MqsNiqvtFlzEKrJgI//738NL1C
         HX2/Jx1C2hH06pRCNvxwo9zv2bCEaQeEq4K6qd4ZMepkDYFMQ7docuGKzbOWe6vUhyd/
         1p6SpOdPojCN1iv6p+XTBp6NI+tohzSjED4Jh+OUvlTLaUvcFMESa8whA/vRgs32LRCC
         AJWqHNFDHYzpqkUDFILyTEOi132jD15GqmZpvopFE1r+eMq8qvBZBz0sEf0feKILEwub
         v2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987907; x=1737592707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KrZJZ3OJ0cLB44BNHBSnPXb9TFsHpSRbAFHEpeeUrE=;
        b=dQavEzcA66kZTHWw/cdlE1Dmwb8FsXWMUw1CYk/PLJ67EMEv7YGaVtEn4aAzWKrSsg
         OKq2vj/8w/LacOn5bQL5I4eA1R2oakck/9qPxcTY6ySlXuako8zePtb4Bky1tdvcgFKj
         n6PUL6UCIzoRD4zv9g5oGJDb1EAq8fGwHgJlzcCtFIMKRwXr7eGJ6qLAK6kv1J6unRUp
         tpq+wPpmNuOknDgMLp1fchynSYabl/TAkbt1S2jRwDEueIwy7VAfILDi3zyaIVzohddT
         lNIfrqgPm7pGQGhF+k9yBxsrup7Qqao1SrBjWtKasczP64M24jYUrOY4TT35D6PhGPru
         E7sg==
X-Forwarded-Encrypted: i=1; AJvYcCWhnQlkiEJq53EFr16qlFMTOa8LH1cmiQ4wKqyT9zDz1uMqqheAok4Q11+QxBoN+upzfwiM6Pfg@vger.kernel.org, AJvYcCX9xdX0ZotzIUssGMmFDuk+Wi+nfrMwV4TV023wSgmE9Wluaaal+/4Tr1/VHXt3r6e+hx1IlipXbNhpRHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRLSJLH7qLqp+FIYCJI7Sf0OIy2gS54tV5MOGLN5nM49/OyT/
	HzhUMz6pQIEMHYUaOOAtp62nsjnoNOYCeYXx9VNbvxAFcfOWDUf2lYzrL3pFVd3LunXv3ijWjiE
	xFoek7xFmhMNGAt7pvQnB1zB/OQk=
X-Gm-Gg: ASbGncv6HJyijjQbOe2Y87t4WZLOyc4ImSMRBULITKH6O/Kf7pHMT4mEpZ0HLdAYxgf
	bTeNW8aahf7kVWalmA5iPfczhv4lg+jOF1mw84Ss=
X-Google-Smtp-Source: AGHT+IHWkBNrCfyDDqPSo6zPVEMJjpf4N7LBo6CVqGkv/2PLQEZIGJ1em4EqX/Jf9dNyutyUz4QASTPmymgvckQNkbA=
X-Received: by 2002:a17:907:7286:b0:aa6:b1b3:2b82 with SMTP id
 a640c23a62f3a-ab2ab6bfbc0mr2679771966b.3.1736987906771; Wed, 15 Jan 2025
 16:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
 <20250113-fix-ncsi-mac-v3-2-564c8277eb1d@gmail.com> <Z4ZewoBHkHyNuXT5@home.paul.comp>
In-Reply-To: <Z4ZewoBHkHyNuXT5@home.paul.comp>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 16 Jan 2025 08:38:15 +0800
X-Gm-Features: AbW1kvYfNkPdWglIIVQJWoe_QBKhu2xoNkzvk38bQ8BmPIqcBK7J6L6f3USpux0
Message-ID: <CAGfYmwVH1A+imBF5TLenLaSM0Zf0C5wgfgocYix9Ye_7siR_xQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/ncsi: fix state race during channel probe completion
To: Paul Fertser <fercerpav@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	Patrick Williams <patrick@stwcx.xyz>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Cosmo Chou <chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:55=E2=80=AFPM Paul Fertser <fercerpav@gmail.com> =
wrote:
>
> Hello,
>
> On Mon, Jan 13, 2025 at 10:34:48AM +0800, Potin Lai wrote:
> > During channel probing, the last NCSI_PKT_CMD_DP command can trigger
> > an unnecessary schedule_work() via ncsi_free_request(). We observed
> > that subsequent config states were triggered before the scheduled
> > work completed, causing potential state handling issues.
>
> Please let's not make this whole NC-SI story even less comprehensible
> than it already is. From this commit message I was unable to
> understand what exactly is racing with what and under which
> conditions. "Can trigger" would imply that it does not always trigger
> that wrong state transition but that would also mean there's a set of
> conditions that is necessary for bug to happen.
>
> > Fix this by clearing req_flags when processing the last package.
>
> After reading the code for a few hours I can probably see how lack of
> proper processing of the response to the last "Package Deselect" call
> can mix up the states.
>
> How about this diff instead (tested on Tioga Pass but there we didn't
> have any issues in the first place)?
>
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index bf276eaf9330..7891a537bddd 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1385,6 +1385,12 @@ static void ncsi_probe_channel(struct ncsi_dev_pri=
v *ndp)
>                 nd->state =3D ncsi_dev_state_probe_package;
>                 break;
>         case ncsi_dev_state_probe_package:
> +               if (ndp->package_probe_id >=3D 8) {
> +                       /* Last package probed, finishing */
> +                       ndp->flags |=3D NCSI_DEV_PROBED;
> +                       break;
> +               }
> +
>                 ndp->pending_req_num =3D 1;
>
>                 nca.type =3D NCSI_PKT_CMD_SP;
> @@ -1501,13 +1507,8 @@ static void ncsi_probe_channel(struct ncsi_dev_pri=
v *ndp)
>                 if (ret)
>                         goto error;
>
> -               /* Probe next package */
> +               /* Probe next package after receiving response */
>                 ndp->package_probe_id++;
> -               if (ndp->package_probe_id >=3D 8) {
> -                       /* Probe finished */
> -                       ndp->flags |=3D NCSI_DEV_PROBED;
> -                       break;
> -               }
>                 nd->state =3D ncsi_dev_state_probe_package;
>                 ndp->active_package =3D NULL;
>                 break;
>
> --
> Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
> mailto:fercerpav@gmail.com

Hi Paul,

Thank you for your suggestion! I tested the patch, and it works perfectly.
Could you please help to send it out? I appreciate your assistance.

Best regards,
Potin

