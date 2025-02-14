Return-Path: <netdev+bounces-166524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7EA36518
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC10C171317
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA532690F9;
	Fri, 14 Feb 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwNpzBhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3B2690C7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555917; cv=none; b=TAhS0Hu/n3O15mvP1BV+vg8xbMMr7gJVnyhG3RD1b5Xv9bz+qj0dcJ+sTvFDWv4+/G1gWMYjyjcon/BV4w/LunkD3Id/X+T0QzCGLXc2ER1A/Od0N8HGUOKw81OJZJosyxYZT+3N3GKH1xBJ6P43t6bFGnDC49i7fn71UrNc3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555917; c=relaxed/simple;
	bh=mMSq8YtrfcA0l05ISf1S74/l9H732Kgn7/aU4PL0yEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa4IMnS2L4Iaknx26sMgyF/fuF32KsZSCtuqCY78wk29w5ueGbsMIoX01Rc9aIDS7NWREEErW5diuxEvO/RYYneTRfBdT1KXxYZql6nSVZU65YCqPcet9znJjnh9nuYKUj83qGIUT33KPgQUXByrDLgSDeNMjouTBS08CWqCA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwNpzBhR; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a6bso24402161fa.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555912; x=1740160712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMSq8YtrfcA0l05ISf1S74/l9H732Kgn7/aU4PL0yEg=;
        b=VwNpzBhRkd3oTXQyUcHlOgD8nkOAbByG7P7vhDethp0Xx3Mlk55LaJGPW6StmpFB4k
         b/J/Ms8QJTqKeBHka9Zt/HN8GcqOKY2QWMEKNjlYBW/RfTRHQPuvvXrZMLlARUHmIthd
         jMMVVLltK8qxkmR85xwhQWAWEBO8cmngK+Au8fKs7ZGZRlZBe8jU9kfr1+xllJJm+6RC
         qtxCAaM+C7uGw7p9q88oQwcoGZvUIfo4OlcwANydyPR6w9jeQ0ew1bf0D3MaThO64PVG
         uncASeKCiyXDz/QRgv3D/jjTsu17AXJs/8PV3kgED5Y12amkZdQ4aYFI3xgd2DLoOz2T
         AyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555912; x=1740160712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMSq8YtrfcA0l05ISf1S74/l9H732Kgn7/aU4PL0yEg=;
        b=CcxtLKBuZvnTPKzvac2nOoX0NIAwDHIe9Pf8m8zOrGzpQ0onIEq8IjG12LxI44dnUV
         o+YikYUpBPR9gfyFEPUjLCDuVLrJcWLZNIfb+N9VEI+WTt7B/fl8330UaKUE3L0Hzt4d
         PcEeNLQhJ/V5bu1faB8myJogJg4NreIkTAWKrHTBsHBdbI3TCQro5q92ztUj65Eqs0vt
         gcgmX0yYhVFkhYXGgOPdmKgIsLEWwve8YxREXDUxowOrKNbpJC8rhCUNqUhRxYJJ0AUX
         Xb4t6RN6yGzy7LZfj6n7rinYtH3owHH2/4+/SXHS3PL4kJ/vZMFDjvib0rPi2vzLEGoV
         m52g==
X-Gm-Message-State: AOJu0YwRby4d4ebLU1m7kWeFQqWxlQ6JuW2OokDwkCqJS2eeX8H3ej3f
	+HzJM+4x8vUJt8KIBX9wg/AbkYPMMTWRXM5jbSP6HeNcn4eXmBOd1iykZebXvkoJDTKUe97rlLt
	DRnqSPSjCQ/On9+iUPIcVi1bQ9hPF/w==
X-Gm-Gg: ASbGncuQIY5TUUiYzFvIm4OpkLZs44rHGnWIkOUnjBOHnXX/sldRnkblfmHrjlX7Uuh
	6RBPfymliHRZHoiMhKwC3OnkfLTnIwLG5E6OHhIMD+SVO5Umx9oF4BKLofQpK6MHp/o1gvpTDe7
	SP1ST4tFo1o0Mrck1Y5m60N9s4SL0eiYE=
X-Google-Smtp-Source: AGHT+IHtDca5hDcPLLhw3lZEufg5MDvRQbWLVgWhF64y26LUcGSF9f9BrWJqmJrBA4ZR0MrLU0IC5T3knHh90W9r260=
X-Received: by 2002:a2e:8093:0:b0:308:f39c:96b3 with SMTP id
 38308e7fff4ca-30927ad5236mr1479301fa.30.1739555912059; Fri, 14 Feb 2025
 09:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpvP8+0KftCR7WOFTf2DEOc1q_hszCHHb6pE2R-bhXMOub6Rw@mail.gmail.com>
 <20250214171219.GA8209@1wt.eu>
In-Reply-To: <20250214171219.GA8209@1wt.eu>
From: =?UTF-8?B?7KCc7J6E7Iqk?= <jaymaacton@gmail.com>
Date: Fri, 14 Feb 2025 12:58:21 -0500
X-Gm-Features: AWEUYZmXamKgTSQ1x7b94u-pV7J5yZtjYf0toO_hqnMQu1ncIMVIw3qxvxkMQT8
Message-ID: <CAPpvP8JZL0zUg13kbMnkz=he93p87SBj+8K3ubRA=JheKT1p0Q@mail.gmail.com>
Subject: Re: Question about TCP delayed-ack and PUSH flag behavior
To: Willy Tarreau <w@1wt.eu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:12, =
Willy Tarreau <w@1wt.eu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Feb 14, 2025 at 12:03:17PM -0500, ??? wrote:
> > Hi netdev,
> >
> > When tcp stack receives a segment with PUSH flag set, does the stack
> > immediately send out for the corresponding ACK with ignoring delay-ack
> > timer?
> > Or regardless of the PUSH flag, delay-ack is always enforced?
>
> It depends, it's possible for the application to force a delayed ack
> by setting TCP_QUICKACK to zero. This is convenient for web servers
> that know they respond quickly and can merge this ack with the
> response to save one packet.

Thanks but my question is about the kernel's default behavior.
It sounds like there is no interaction between PUSH and delayed-ack,
and it should be handled by application scope.
Can someone confirm my understanding?

JY

