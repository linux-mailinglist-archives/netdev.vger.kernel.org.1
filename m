Return-Path: <netdev+bounces-227721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDFBB5FDA
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 08:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB7C19C3F00
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADA211A28;
	Fri,  3 Oct 2025 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vea80jMh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FF46B5
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473848; cv=none; b=kLgAAUgGrpD4JLpskM5U/7yMFiZf1vtPTKUPJ3zpF3mz96LW5TvNpkUHS6WrkodX7c+th2Mhbj5yQAtGmp2z4sWgzk+kKuSDMF4OJh5XJFJ4GltvVXsodJD6KqJL5/rPjtrYAWjyZFrDcts8eYPVhP2hS2Wp2PlkK9/weq1I+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473848; c=relaxed/simple;
	bh=eguH9qH82jQam+LusgD1a2RBGg96J5X715GsFtIhrUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfjG9ge8gLc3H2mSR594ihqi/d4OGROiO37EkxwsThwobmp7YYY5b+wlpBRUdyGDQZdsTq7Wqpb24jaVu8fdP4toFrFGwVJ+M/BzXb3Kic3cbcluslTcX6FNnGraSfk95v36O4CFkUBX4sZxs6JdapYsoOv5sEZ1Bia1g8ezqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vea80jMh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27ee41e0798so27212375ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759473847; x=1760078647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lxoZhcm+45awcJ5tS0EZt/FOKikJk2GmhaWWoUmXFQ=;
        b=Vea80jMhV3lZj0WeyQxXiBMR6VGAj8ONzNqxs7lMeqipbeD4eduD2cYKpp3iJM6Qny
         PDASaDnwy3A+9MVkyqryjDgeVgxxj0fvpsQV2jnyEsJKLhu88GvPtz2mQ6/uXh8uZ3po
         JKy+hodpqT8Zc7olPTp/W2/d0NGBZ1BOfFQlSZdEZBIPUjmsbLVndIS7jN4fr6inutac
         +cCrfzKslsXPAWE2kFl6q8OFs/MT1MjBs5Uj2cbfZyGqdFVtQ8Vkxir01Jw5qS6ItR3d
         J5reoSzPBS+xbJS7VN0M2Dj6HW9OLE3O9+Tf1Ovsc5jeR5aj+9Ij345+QZ/xpYUmD6kt
         Me9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473847; x=1760078647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lxoZhcm+45awcJ5tS0EZt/FOKikJk2GmhaWWoUmXFQ=;
        b=YCuR5UUL6nCvSLIvvKcs3uz4FmwIa3EAkxjLw6Jq9sjPMcpTQawMdUuJbTvLFgCnpE
         Wy0LViydUfhwtGMitBs+pkfsT+Y903pqL+a+u1n07x9DrfuQ8pxaLTZNDz1W03w0aogm
         5hR+XOYO7Be+Rw4NrQq3Lh3azRoQ2LLNdv+m4I7J4IxSwrMBnWaGkbQzIBjoexjvna5X
         XTP6ANK6l4K+IRpcjsP70H1w0Z7r+9P5Lc996dVGc3EdyThM6VT6ApFmCoKF/o97EBgr
         o8bCenIpfPofltvkWSSybu0KqJL7mK7cK7i11LERYkzB96hI8optDFemoTjjs0AKrVq3
         SdIg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVjESUXyHwlbh8zCDO1pt6V8dCQIGt7i0j9GFb4pyNDax3LPPsxg34v18EuUraxUlfq+sFAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBO+UIU9lHILg77T/uMx5m+yOA4PoJxYU8jDyN0wOsnGPMGCO1
	dp+fH3PjILrdReaEK/Vzns2ZehuMAb9n58qKnnA4bgjChJeQtFXhugdL8njcONr6diiOSjDaa6Q
	h0grZ9yGRgvRmjMliQnei9qTOlE9WH1k=
X-Gm-Gg: ASbGncvmAtLlidTtr9ju0QEzJN2Z3OzmwiPMZAFGvhoHCiaFFmUm0USbYZQJFvkjrhh
	sO06MRqJC9/aaYw6wPtEjgifdpWfSSarxsQGbzIY/HahFHDWsaKrGzm2FK/gtAE3Cu7hVTR3DvX
	M52pGNwPqCBiXiXd5fdHZl3PRHY9pdqnj56Fe7OBJBV9MKA7wLkp6sGY8M4tWJqoDg4zA/GnWNn
	HJcNzKCz06xWAlW514KCgbFtQlpuTii9z5JyWoVTr+KKDqmFWW3hefu8x/VC49+0NbDUXcAakjr
	qfz0TgCL0K+ZWDTi
X-Google-Smtp-Source: AGHT+IH7EjoN/pYt2rJ3ou+7MhyHKCK0+9xq28i/uCdlwnAan+AYidcbSeE3JkgMW3BnaAZi4vYMBUXR9jk2WUk4WIg=
X-Received: by 2002:a17:903:38d0:b0:269:8f2e:e38 with SMTP id
 d9443c01a7336-28e9a565f18mr23717585ad.6.1759473846705; Thu, 02 Oct 2025
 23:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <m3o6qotrxi.fsf@t19.piap.pl>
In-Reply-To: <m3o6qotrxi.fsf@t19.piap.pl>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 12:13:55 +0530
X-Gm-Features: AS18NWALVmSDyc-JP5tcvAszj5MCQYRzNJOCS8DFUVpSMuiDdleIE5xAhDioBp8
Message-ID: <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the clarification.
I can update proto_name() to return "LCP" by default instead of NULL,
which should silence the compiler without changing behavior.
I can send another patch for this if you'd like.

Best regards,
Kriish

On Fri, Oct 3, 2025 at 12:04=E2=80=AFPM Krzysztof Ha=C5=82asa <khalasa@piap=
.pl> wrote:
>
> Hi Kriish,
>
> Kriish Sharma <kriish.sharma2006@gmail.com> writes:
>
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It appears proto_name(pid) never returns NULL there. Despite actually
> saying "return NULL", that's right :-)
>
> Perhaps you should change it to return "LCP" by default instead, and
> not only on PID_LCP? It should silence the compiler.
>
> This ppp_cp_event() is called in a few places:
> - ppp_cp_parse_cr()
> - ppp_rx()
> - ppp_timer() (with a known protocol, though)
> - and others, with PID_LCP.
>
> Now, before printing proto_name(pid), ppp_cp_event() does
> proto =3D get_proto(pid), and dereferences it :-)
>
> The pid seems to always come from ppp_rx(). Fortunately it's checked
> at start, and it case of an unknown proto it goes straight to rx_error.
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa

