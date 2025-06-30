Return-Path: <netdev+bounces-202397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B4AEDB8E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EDA7A8ED0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05B28313A;
	Mon, 30 Jun 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf4/n3FY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC732820DC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284106; cv=none; b=nhqxwe93VlKT+IGPIZtnzaCqAQCclFMi1klJ7Tdyw18VDMiswNJZ7D2wb7Vuu4Bfo4XZU548OUX4A7mvsJgacaHcjVpODdRtYChEqOHkgONFhVYGeQoleOPF6yDo9450zw8ln+pWanYl1qP+iRn1TCzZTM1/4Z9bhVUUhm9EITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284106; c=relaxed/simple;
	bh=wIxuyruDNunNN+Di27Op4+CjkW3QATJgzaz8Y0r/VZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW9C8EzkcYss0wOqxSFZsA5sMQBfV832if+u2B/hvmjZVMkChe5jgtB7KcvFkdWrHPHHltRIaK+tJbxsMy86d09yBA0CHNd1+LTPtKKoXhBdd9xhvGj9rpzy/8sFEiWanlDSI9mVRhJ4JPCY45p/IyYWuVVJuiEJ68Aq+BkqJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf4/n3FY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2f97258eso19339905ab.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751284104; x=1751888904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2F/VjvMCbtPHkvFuespeESfeLZ0Y5j5DMaoIM4rMDs=;
        b=Hf4/n3FYs5DVrPu4Zw+958zX94DP/wwvtgaCN5AIXEdmTQeVj+fyYZMUAVOzO/5mCw
         NQRt8V74NubI7l0NnWXpCLujDUMJwoDRs+nYdnytAsH70CG0CqfDdkDcK5j3CMjJ5eVl
         o/4CqtPRcj83HCuSEUcaeNO+ZlwxrYRjcwW/k07iv77q5fVayfofbos+95ZU01NZXyD8
         hZp2AmMKA6ECATOG1iIwcOWS7i0gakhFQ70oYOReRCrWeZPl1W0m/1n+v64qdwLqSiun
         KofX6OfBgVAPwpwjQeDZa/pKbqk4KSXXxD/N3ziwCfrZivnEnsE0ZxeKo/nIN6OCSlN2
         Trwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284104; x=1751888904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2F/VjvMCbtPHkvFuespeESfeLZ0Y5j5DMaoIM4rMDs=;
        b=gUKpM4vf3bYwHE8hO3K40/KK7lFkt13KOm+rPlw5fcbuXGAZIOYN9ULL0xUK570Umf
         yU6nPR4rlPuK0EUfBzXOQMuvAgQvl4SdSPaGtedA8/sd8VXw0I8go9N9jInOu2ctaAaw
         hLGlrtenr8LeieV5JZOhmE5EORKlz8+r0wOLx3iwRU2iu68bzsU51C0z4adydSroejnR
         H4V6Rp8PqVIEjcvsNbNME4IvsujQhg8vdpxBx0lEzx6yyuuDHjlZAJXJpqQoqrzRIyH5
         5zFVLfpIpo1acNzS6CsXMjRk68x3bBweIs0HDM0slOl/3rjwgOyqS6484kWyZIUojVrl
         Ms3A==
X-Forwarded-Encrypted: i=1; AJvYcCWWyrPvX+KlrRk9YVAXciRtorIngs+q73MpDS0Mw51y7ZLVwyyHoobzAsEVviIKM1mc+LQcpy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSWn/SBJUekwAaCFumExwRzBXZvIwBPXUURd1cP7R8QTysd0s
	I/EHrFqKjl7rFkCjHo1f8YX6ZQg/HnElNdHur8QIECoWsw2JsGMryBfkm82A7IPQJQVhoJcs8Mf
	/yZk67Pm2+XzuQFOCu35up9IBWYGZqrA=
X-Gm-Gg: ASbGncuq0JzJSPk36dPlsIQ/Klx488w47ynvIiL1Rm30jWinUBGGHbzX/zcRSz8hrOb
	f6YyuHZBNfu8l6mvJ4/BmNCYwh3df+uj48F2K9/2sn6TYThj9+ySYgZyhHVNaR1T454dKQFYH+R
	Pi3RLwfh4r95SaQFInGW4Tjd3GUnrjO1tBUaMGX8vuBU4=
X-Google-Smtp-Source: AGHT+IHmaGQMF8VcseAZYUe4O8cbb831Cv7/F289Ji3sLNF9YvniIil8tyaMmMFMjoDmG1UehO/8dT0WkVRyffGaVlI=
X-Received: by 2002:a05:6e02:3087:b0:3df:3bb2:b8f8 with SMTP id
 e9e14a558f8ab-3df4abb6541mr117980365ab.11.1751284103720; Mon, 30 Jun 2025
 04:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629003616.23688-1-kerneljasonxing@gmail.com> <20250630110953.GD41770@horms.kernel.org>
In-Reply-To: <20250630110953.GD41770@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Jun 2025 19:47:47 +0800
X-Gm-Features: Ac12FXzpwGOWZGQpt1tIAnDrmoOronpX9qxZwRYWRDVFUyUN-26O1oQw8-MnGh4
Message-ID: <CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:09=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sun, Jun 29, 2025 at 08:36:16AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > I received a kernel-test-bot report[1] that shows the
> > [-Wunused-but-set-variable] warning. Since the previous commit[2] I mad=
e
> > gives users an option to turn on and off the CONFIG_RFS_ACCEL, the issu=
e
> > then can be discovered and reproduced. Move the @i into the protection
> > of CONFIG_RFS_ACCEL.
> >
> > [1]
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request=
_irq':
> > >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10703:9: warning: variable=
 'j' set but not used [-Wunused-but-set-variable]
> >    10703 |  int i, j, rc =3D 0;
> >          |         ^
> >
> > [2]
> > commit 9b6a30febddf ("net: allow rps/rfs related configs to be switched=
")
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506282102.x1tXt0qz-lkp=
@intel.com/
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks.

>
> Not for net, but it would be nice to factor the #ifdefs out of this
> function entirely.  E.g. by using a helper to perform that part of the
> initialisation.

Got it. I will cook a patch after this patch is landed on the net-next bran=
ch.

Thanks,
Jason

