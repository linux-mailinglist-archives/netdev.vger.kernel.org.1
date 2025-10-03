Return-Path: <netdev+bounces-227783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B173CBB7105
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16A04EA1C2
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E118FC97;
	Fri,  3 Oct 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSH9A58r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBEB1D5CEA
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499135; cv=none; b=FJuB1BPFUmpxRLKQ8Sp57XMzGGNPDSpd1E1LbfWuKX7+kUtB2D495Qw0M7v7xxnkspyqek3+0l2Agv/Bh9kPKjPDxD7JBDC24tMndb8Y8TG5B1FqsF0gNHtK2Xhvm1g+koQF3AAWHuYM5LLs4Vp9ZYj10WoN9arhBVyH5HGR2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499135; c=relaxed/simple;
	bh=PkmJKqkQkGOb3jQUSVUD7zxkaqJkiT/jxK84E6KIlF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXBdSG73aXQ5TlNB0fDyCDxc2uDCJQvoASkT1GDyphgAZXSph2a33dDnPNFqGmQlnMe3jcrQ1M/J20ocZdT/1VhUqHy7DT36shh6jDLcKBPeMnpepZa8hXOTaPjff/j/XOb2hyx/m/jOKbGhQN6rZaU6J/1G76QQp2Bc9RaV/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSH9A58r; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso1476974a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759499133; x=1760103933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiOYjFxFKpa8IlRViT6SZkeq4v71XXTA2E/7Ti28NDY=;
        b=fSH9A58rWNe8YE3Hg2FUOuGuFWVBlM66WexTx7vIWI1/lK3NXhqs4yLGJWEbsNk/HW
         Qkx0ZvVGe3eujC7zTdKVf5pHb2EtZ8uYDKtqAhCbW9Pa842LtWi77cfia4+jqzusU/Nf
         z/C/auNLJ2chAi9But3GKu4e8ObNPfnq0o2plsTuHQi7BE0IFtO7gkY8GTLZImu3rdJ1
         BTX+lK/eMOyuctdX0wEDYZYFuSOP8OYEFPET9moZ5hJtkThXMqkKATFZlPYh1OnuxbMk
         a/7vfqf/vr1rAUtKzpI8DUVB/ODv0dWOqJwOHNHsQrvR46nwZsd7HDSIW2BiILsMjcoK
         UlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759499133; x=1760103933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiOYjFxFKpa8IlRViT6SZkeq4v71XXTA2E/7Ti28NDY=;
        b=q8BSJybkwrMr5M7IBZj8UiskOKPhFrYJc40EcGi5WuhmDw6xmtC3Xo+fjmSbs8rDn8
         GbCWPpBNHbeTeZ4MS+l5EUpUoqWtjMABIugxRNIhyagpoOihaHW6WQE7XhGDBx4phQkp
         6sfQ9YS14bxCHJeV9M3TSLGwvFAleGRmdeMSUOYR6N9CK8AeL3y5Ojg7CeVWA4qo7+bD
         O1sz9u2LiBkNd0BMcTLWaE/cT8mi5sjCH0GRQqtTqE9RHSJRXGUntqnj3TnWKfGWOECA
         QoG3IPrs+SRRuRiBMZ3GICU+8B8m5zaXa3oPwPdX7FlrjPbORqzwdTedL/Tll3fHvina
         ZTfg==
X-Forwarded-Encrypted: i=1; AJvYcCXSpd/qVN5x8jh0zGPFhIrBtpAwKgZYKEDBfdlc6K8iL1FqYtUR/F4PwSANuOLQqgchky+XQss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfWacCWEgZ0C9rS233iLurdT2Pn5R0CCdb+hVSUZH+ngPcU3L
	RcqE+Mnfj8udO4MFybQYleMNg50ntH/Um354GsEubma8EF8FHextAwHc4s+hWZewY5BBo5na+bv
	h0XUvRlM1UdHCyLCFDg7Y0JxUBOX9084=
X-Gm-Gg: ASbGncvxVkRVf3kSkNdH1VgLXmg74rtLt04IVbhxzQDvpVwL9TaZp5Hc2TMqKNInJgW
	VfYgd3cC7fOEWgzyXemSbqibhmQMBvD5NHDi7PpELuAalfFZg7EdmqhncJgcZVhv+j7e+vS33oP
	AZjTMpNQWu69LxCNo7kEHJ81zPQM+Z+Pqed0gd8SJkmxL3y8ltgUrMuDiYoX7zz9s7kkY7FiVAY
	HM8JeOhx5x0g9kpXpwsU449MntstIif0FuZSvRRGZqFr9aoa4grfuj3dKKK1c3CbpVhE7rBTpGp
	uPfG5eWEYjASuNxS
X-Google-Smtp-Source: AGHT+IHETMYTZGwaOT5HkOBz6H5CjSMvk8GuC4m+jz+fcW2yGghbz6Irh3mN7bj0/pYYjdO3LxBjLjRVEb0ewO9NQXs=
X-Received: by 2002:a17:902:cf4a:b0:279:a5bb:54e2 with SMTP id
 d9443c01a7336-28e9a544147mr30506615ad.20.1759499133237; Fri, 03 Oct 2025
 06:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003092918.1428164-1-kriish.sharma2006@gmail.com> <m3frc0tb9u.fsf@t19.piap.pl>
In-Reply-To: <m3frc0tb9u.fsf@t19.piap.pl>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 19:15:22 +0530
X-Gm-Features: AS18NWCfNBtNowVp2KUDOPdKLjAaw-tCzZcGsn4VlfgQBrJ4BvkILLgpz8o-n2k
Message-ID: <CAL4kbRPS0g4yOz69h3ctOYOBwSU--od-RbfdAfcrRs=ighst_Q@mail.gmail.com>
Subject: Re: [PATCH net v2] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks for the suggestion. That makes sense I=E2=80=99ll drop the PID_LCP c=
ase
as well in v3 to simplify the code.
I=E2=80=99ll resend the patch targeting net-next once the merge window reop=
ens.

Best regards,
Kriish

On Fri, Oct 3, 2025 at 6:03=E2=80=AFPM Krzysztof Ha=C5=82asa <khalasa@piap.=
pl> wrote:
>
> Hi Kriish,
>
> Kriish Sharma <kriish.sharma2006@gmail.com> writes:
>
> > --- a/drivers/net/wan/hdlc_ppp.c
> > +++ b/drivers/net/wan/hdlc_ppp.c
> > @@ -133,7 +133,7 @@ static inline const char *proto_name(u16 pid)
> >         case PID_IPV6CP:
> >                 return "IPV6CP";
> >         default:
> > -               return NULL;
> > +               return "LCP";
> >         }
> >  }
>
> I'd also remove the "PID_LCP" case as well (just those 2 lines
> above IPCP case), the code will probably be simpler to understand
> (the compiler won't care I guess).
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa

