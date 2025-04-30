Return-Path: <netdev+bounces-186989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A30AA4631
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C221C0062A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBEA21ABDF;
	Wed, 30 Apr 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nev+3pUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D77213E71;
	Wed, 30 Apr 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003648; cv=none; b=E30oiocP4NVWXS0sYxXKdPbn51eF0cOZfdIJ6EOU4UyguG5o2M8iUFBj1bSsWSflsUwthuOohnq7+tZFyCuX168zbcWBLfvRdXWsiIXgRHJ7srkt8hI3J1zobIOJpqtdqBnaV0OEPiDsZ/tAht4YqYjm1Xsg9lsAOrzfTHLrNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003648; c=relaxed/simple;
	bh=JmwdzasM5q2FtDZ5x6Y68JaQXr5A512sSMcq8EMY73s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnVG6aYi+yzIlPehfYAvIMf7dT+EiM58i//knkEgRLIGk3Vl/kiBnJFKV8VV5rQ0++KxM8qeuCYXGrA6LrTjPO8UvpYjGDKvYw3vFyPeOwF706VWEBYVnytpW3ltb0FHQPJhO8CsxlnKKSOI3x/vUMDrEXzI10GYHZVDiKdyNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nev+3pUb; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e63a159525bso5886969276.2;
        Wed, 30 Apr 2025 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746003646; x=1746608446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmwdzasM5q2FtDZ5x6Y68JaQXr5A512sSMcq8EMY73s=;
        b=Nev+3pUbtcTXI1jtTogK/beXBeFZDA+U/YB2QQKnYEruCvsol2rmQMGUl++As/J5iC
         2XH+WJFBOYDwL/qHUbC00ar9aFUKeTAw5lc2r4bB8UZKRH4PHUXc7RXXkR3lTqqXLmBH
         jZc+KMnrsAkL5NLVbUWc1AOpl/hxPCX5spzXU927EHkY0P8b7H5Gq2iJ7JXPokyS9qx4
         x1wWvRmGuoHhp1nZaoEW23ncmMdefRFH7s+ABfNDtfxGFOqpNonRDGO4ZrrNAZApyjyT
         DS7pE/FIKaY5QwLOR3qvUJCWEav5seEjSvlX1jhvFRxsTGHydD2AoSkE8xQ7KHK8yJjm
         lCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003646; x=1746608446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmwdzasM5q2FtDZ5x6Y68JaQXr5A512sSMcq8EMY73s=;
        b=JkW/CeBRtlhLGVW4XC0BLamov9OGw4QjFKYIkCrIqVwe8/aPV6LR56kLXC+xIQezbJ
         C/hhxaKhro9+lnl7SIapOs8BM8JNQ16FuIzOf72zsLzep8Ak5Kukz0dFD3XSzzNJEWrf
         75iJ5sqrfILQWlxMF9Pd1/eS/CmfOGcFKN1LYpKd+Hokua22utYUfCRFoIRRvWPHS0Md
         NARX2C6ljnmDVQ+2c6wEqSHQGsBbUfHBtekEWCQj0DRfFhEs1TBD+cSDMb5l0lhTcPpq
         ZvJYe5AY0WPbouzWZij8Km7/hleRpX2BfrthdYzJ7O1HUVgIfyfVGc9tyyF3koTpoRGU
         WqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Bm05+6uhv5xAL5qch2MciyGmGUhhd1uZqt7RFWP9Lmtje+1T6LDCCUc7DrrSkLqFuvUPc9uF@vger.kernel.org, AJvYcCVcbZ7Oc1pIZC437E4nzNArhLPo2JURWdelHVv0RQEDNpRIK8lcr+xW7TTRtojJbOb1isSBJoKvRKiq/Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPP3R/Fm9HC3AC+Ag4i49+AaAPxOElKMlONb6cCvjXMH25Iis
	GFK9nLLJIj+VAoh7Y9KUoHFLH2IMS+XMgRBZDI+HwfkffqQexh2YGH/z0W111y4NDh9dkIfvsOa
	CGflwySp5uPUDTGSD/HjfqvNwzc0=
X-Gm-Gg: ASbGncu+St7SJeNQlHlr/b7OQvaza2vPEGChw5Sy4vJrFPExhdfOdV+sZ7PiRBQl8dS
	5ljMJs33FBPw4J6H4WghkG3Sg1reut8LPObtmEjieIbm943r0RzdSZDQLD7nhvNG8dLP+KB+7C5
	PoifYR2aVTrOXph15dDNM=
X-Google-Smtp-Source: AGHT+IErBMYJjeuu55AXVDFfHHV5A1rdh7TsTrSkbVy2P+rXzwjI8uo30OCEeL0f3aMQrCfDBI7E0B916Kj2HlvsJho=
X-Received: by 2002:a05:6902:10c7:b0:e72:74a9:18d with SMTP id
 3f1490d57ef6-e73ec5ac393mr2976720276.42.1746003646041; Wed, 30 Apr 2025
 02:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <20250429201710.330937-5-jonas.gorski@gmail.com> <33e87dc1-17a4-4938-a099-f277f31898fc@broadcom.com>
In-Reply-To: <33e87dc1-17a4-4938-a099-f277f31898fc@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 30 Apr 2025 11:00:35 +0200
X-Gm-Features: ATxdqUFfsqqfwJK_ni8rYdsQK-v-ZBlBJqUCsBQxXJBYd2ExM5QhRZ5FIz80KqA
Message-ID: <CAOiHx=m-59GX2wyoLi9MQqMNzoWLaMsXXJjQJ8D_C-4OrOz7hA@mail.gmail.com>
Subject: Re: [PATCH net 04/11] net: dsa: b53: fix flushing old pvid VLAN on
 pvid change
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:03=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 4/29/2025 10:17 PM, Jonas Gorski wrote:
> > Presumably the intention here was to flush the VLAN of the old pvid, no=
t
> > the added VLAN again, which we already flushed before.
> >
> > Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>
> Does not this logically belong to patch #3?

Yes and no, IMHO these are two different issues, though closely related.

The flush was always there, and for a long time I wondered why we
flush vlan->vid again. Until I noticed that PVID clears aren't handled
(as a test broke because of that), and then I understood what the
intention of the second flush was.

But I should probably reorder them and first fix flushing of the old
pvid, and then add the handling of unsetting pvid.

Also at one point we might want to limit the flushing of the VID to
just that on that port, but that is a future optimization. I fought
very hard the temptation to include optimizations/refactorings that
don't actually fix things, and will send them at a later time.

Best regards,
Jonas

