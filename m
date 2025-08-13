Return-Path: <netdev+bounces-213354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBAB24B62
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72657B8AAA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECF2EB5D3;
	Wed, 13 Aug 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtFnrVty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B162E5B0F;
	Wed, 13 Aug 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093532; cv=none; b=lDIw9DSQSASCSNaPu3JGpV3GpG739mP19Nusl1f+g6LA5zPfXLcTg2hLGr0j/Q8QgSMTk5PSen8VdIww1clKRCLeK1WsU4X8a6rxN9o9hNY/nwafS7WBYoynTyPE0/riTdoQthbANTlfanMvnXKzybB9V6SZ4CQTh/2Hr1lp058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093532; c=relaxed/simple;
	bh=6HwYduJ8jkvem48IK0jCYkDJgXCH1sFEnwdoeiblt8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GC9GBtPfQQCfkz9/+sBxM0zW+i+jSAu4YCFWBj0mPcBvUnbAp0rPuh2cPcedX8GoSsoBgxeSW2YyL5juija7wD2eYBjh6yog8+HFJ4tlxCW2JdXVtMqhDZOlnuzvAeXTsuQ1w0YBTIEL9orZeOltZQ5C4FfaUfE7f69PJEKpLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtFnrVty; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-709e1928984so3978596d6.0;
        Wed, 13 Aug 2025 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093530; x=1755698330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqcR6+EwpJ88rH6lLh9pAzX0q5RJ3i3M/OlyWm0ZwJ8=;
        b=ZtFnrVtyO5w3qzpTeaJhNjIizoV/NT00eopptxCB21s010MV3+DLP9+YfVYhgX2M5a
         ikbZAjw4/Wcng6y4vJvsOSskWUqcmaihJd+gwXmObGeCbut2TzF/3iuemcembZ1G2V16
         kq1n5F2+aK9ujwNFwwA3VhEWHsOpW56oRSWD/39x838O55Z/be4nYzAl9zCfnP6LhmGM
         P3MQw4G6v9zG+mzoI0Zov5YrODfBu8f7kuGYN0dEjaN3M2ZY94Av4B6/hlZxmChWv/ec
         WRC5rsMiiLS+xOCe9+DyVPuwKnbbAAjaaI///9L/lK8sEnA3DSf/Dyg/QPPCsL68sONh
         yFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093530; x=1755698330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqcR6+EwpJ88rH6lLh9pAzX0q5RJ3i3M/OlyWm0ZwJ8=;
        b=stZNLCBRrj04atDDSl+Qn6RVwoTY4wrtTt6XwtAddyEis1ip5FQhoovIRAhIMYHXaL
         fcZwzvQFnReYB8kP1KsEVh3g3y0H5iC5j2FOm0+7Iz2k1eVjlldWKUbBoXPrDqVG1rEx
         hWfRoZorBLTXlxvFTwDp+5aYKDPYwYmzYm7wSO3S43rOadwtEW4juBObRUJ4iH28NpwX
         lns8jBTmh0j35DTh4fM0a2N5ZlyKmFrpSCsOmRWmrvBITpDAA37MaV2sSj1L77PpORaz
         8sAo/GoQGTugYeYAwHwuj3SNCRnZBLPx+ArDLnjJw+G0fRC5uSJJtLF8o57xzFP69i4v
         PEng==
X-Forwarded-Encrypted: i=1; AJvYcCUJf+jP1h98QoAA+0wq7T1glWbP6j03ne2fBDF3QnjWLr7/s5X1TP/pA3SSh2I7IGAFEzSYpB9ooGCyX8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+6CXnj+cXqKI9cUpnv5ZJbwBXKSvagMPrP3E0mbmfyxxKG89
	Ve2vGf1PHZtB/Nx7REiEJg/Y13ZzjKzF+6wM7tgJLLVWUD7iYedE8uQxmOrDMNbqZrJAu/Vg0cF
	bEXdtVTnoujlpJAyNy/dZZCFdSHjMqnk=
X-Gm-Gg: ASbGncvODM2dzQHJcs15XTyyECMAC4ZSThQqqAy4Luo5ZP5u8Z7O4eeysw8pXl0lKQt
	/XRAB4q07e9AH+GmZ/3MS2BhZ3eXapCA9ATirlvmkgIxHZL62vuRmEYwf+HOJxaSHC/xLZ6ITlP
	APpnJ45yoLD60IS7kFUD58M+PzYGZ2uG0YuSkdMOsUdtA9SYkG1JerODg5Z3eISWsFZUic9QHPl
	z6l2g==
X-Google-Smtp-Source: AGHT+IHG5sDXQgMBj7dETvf6wkB+/V7vKTv9zqIB2Y4Plwsxg1ztdHBJ0vtGqi9B6FT+Cg4Ti7iuWLYCtM9FJwyuMLY=
X-Received: by 2002:a05:622a:304:b0:4b0:b11b:ae8b with SMTP id
 d75a77b69052e-4b0fc892e81mr17156011cf.12.1755093529933; Wed, 13 Aug 2025
 06:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082244.60240-1-miguelgarciaroman8@gmail.com> <689c8dbe91cf3_125e46294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <689c8dbe91cf3_125e46294ae@willemb.c.googlers.com.notmuch>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 13 Aug 2025 15:58:38 +0200
X-Gm-Features: Ac12FXxShR1-e_ZrrPYb5HQgreJRC5P7lo6y5R54QnH-y7CYFqm7-u87cQaRMkQ
Message-ID: <CABKbRoJFtNFic6REpme2MgS-c4SPOXZ-oJF-TAFKK3ihAiRQjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Willem. Should I resend with your Reviewed-by tag or will it be
picked up when applied?

El mi=C3=A9, 13 ago 2025 a las 15:06, Willem de Bruijn
(<willemdebruijn.kernel@gmail.com>) escribi=C3=B3:
>
> Miguel Garc=C3=ADa wrote:
> > Replace the strcpy() calls that copy the device name into ifr->ifr_name
> > with strscpy() to avoid potential overflows and guarantee NULL terminat=
ion.
> >
> > Destination is ifr->ifr_name (size IFNAMSIZ).
> >
> > Tested in QEMU (BusyBox rootfs):
> >  - Created TUN devices via TUNSETIFF helper
> >  - Set addresses and brought links up
> >  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> >
> > Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

