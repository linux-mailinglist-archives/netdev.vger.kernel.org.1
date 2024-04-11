Return-Path: <netdev+bounces-87171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D588A1F90
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41141F25B61
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595415E89;
	Thu, 11 Apr 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkXdMT0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95216419
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864245; cv=none; b=mU/3J5Boug6t2uqfha++x2Qc7mtVnnDoIrVo6vV3duu6TK+UgvfnPkcF8WWd/DeMPgdtfXJevvmZRqK5WVFTIPu/x8o3JzW0gD+9sp4iqE3cF5jG1eBj7oXEW2oFE7buwhRU5fOSRELdguzTt5E4/piaTq8cVh5l9cg78gWM60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864245; c=relaxed/simple;
	bh=Gl8eUkD08CMPCn17a5LUCFQwsdrr+BTJp82u/LJ464E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fogO81BAjIAlTmvh38v48c2KBaLu7ipx9achO2G/FHpR+N8RwCpx+MlFioh37DEvoDJVHRnCQ31ihH0gUnN6H2feKqf1XmJSxMiDofKsRolwtpZmqveOYa6QEnIjSoKgNgkJrMOrMnihHGZNL0Z6KhKQFquL7RpQysCKKW6YliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkXdMT0y; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-696609f5cf2so1187586d6.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712864243; x=1713469043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gaZ8PNPW8x1uU3bx7SgotAf3Gi9LIM4a4uzTn6Vt2w=;
        b=GkXdMT0yPgfIZdOMrvvyM2Yk42tja2P6tBgQigKhubso6S/gOlDFUZq8IdJz8GYdWZ
         KnvveHtPrhdKdwqB+DVDlAAXKaj5UvAS3dxzToB4L6HSoRcDscY2XxpPsc5+HSJutfxK
         LS3dbhoZogsApJAWOKfWKpsVWcyC2z0K8wxw1rk9ZVSLs9zsoRTkVlmGPZo8OjL+UNUh
         oFUTO7Lup1W05prPGRSDNI9bFE4m10M5t1w6/p2qXOnp8VyuBaBLAObSaIuRfUQxyN8T
         ksQqMWQBp897v5dy427z/YdubVW2yKg2gTf8It0perft6oQkOVNUyjuZX9AQ6GqIhCat
         0IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864243; x=1713469043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gaZ8PNPW8x1uU3bx7SgotAf3Gi9LIM4a4uzTn6Vt2w=;
        b=Es8x4MLAn1GDU4t9t9CWzWjkuSSYyWXhJbk5pIA5AEqgeaB5QoJjgRztEf9mSdijHK
         a2vYPH9Fl+iLXN+BSFCqolINPyvvaMjtKzbHiudaMyUD6bQuJXn25uBnY7gC3uCUpia8
         T1lzofelqcSG7Qp4WrRzvgOZ1yzfUOwgzBiqLdQkbunyTRu4WV4gL74OVxXzlPnPk4Hs
         2dso8XUHC16+Fu/QCO9bgVwWt8Bj7z6jeiProHpFMIjIFWaSmE9XXuXYjjtBcdIw6VBf
         cBnJC2oVbeg7sHTzcsTfUgNgMZiDI9j/KxNtLq0ZTKGaCm6ik67FipwMTcqnNDr3PTgQ
         LdXw==
X-Forwarded-Encrypted: i=1; AJvYcCV/gAxxMbAJQJDgqk9vCUUwve1nD24pO0z1Vuor/53Heg21uuOOdtj4Z7jzYHGGwyAeKh8oPVKwcsngBS60p85tO6vWxFA/
X-Gm-Message-State: AOJu0YxSoG9GTWtJrB3j4yE8u2YPf9CnqBkA95Hq5ETDEyhlo/C/xriY
	S+3nOmAEoogf22rT/PTsvYIn8DOTsmNCo/vgbWzq4pYQzjvqcRxsc/fSMYzZnLGtrM0XpeF38fG
	9/ARsNsMJoSeRqpdg9f72PfepPW9W+tIKfWbCgc9E4yY/8vCadg==
X-Google-Smtp-Source: AGHT+IHrTNsTajLfM6vlDskL/RW7t8LKDaCP9DtOscLyK8RqjJnIqxBEqvIo/4H4Zc/+wNBbw0jAa1TTD0veOmsdSPM=
X-Received: by 2002:a05:6214:1933:b0:69b:1e64:413d with SMTP id
 es19-20020a056214193300b0069b1e64413dmr734971qvb.52.1712864242836; Thu, 11
 Apr 2024 12:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408180918.2773238-1-jfraker@google.com> <20240409172602.3284f1c6@kernel.org>
 <66175758bab7c_2dcc3c294a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66175758bab7c_2dcc3c294a@willemb.c.googlers.com.notmuch>
From: John Fraker <jfraker@google.com>
Date: Thu, 11 Apr 2024 12:37:11 -0700
Message-ID: <CAGH0z2Hn-D1_wEZEN-Y9+hO1c+Ddn3dsO5_XCG6qQ8KioeGeGg@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping capabilities
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shailend Chand <shailend@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Junfeng Guo <junfeng.guo@intel.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:22=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Mon,  8 Apr 2024 11:09:01 -0700 John Fraker wrote:
> > > gve has supported software timestamp generation since its inception,
> > > but has not advertised that support via ethtool. This patch correctly
> > > advertises that support.
> > >
> > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > Signed-off-by: John Fraker <jfraker@google.com>
> >
> > I think it should be a single line diff:
> >
> > +     .get_ts_info =3D ethtool_op_get_ts_info,
> >
> > right?
>
> If inserted above .get_link_ksettings that works. The current
> ordering is not based on actual struct layout anyway.
>
> Probably all statements should just end in a comma, including a
> trailing comma. To avoid these two line changes on each subsequent
> change.

Thanks all!

I'll send the one-line v2.

> The rest of the discussion in this thread is actually quite
> unrelated to this patch. Didn't meant to sidetrack that.

