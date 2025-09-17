Return-Path: <netdev+bounces-223870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA5B7EB4F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586061B27A68
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947332882DB;
	Wed, 17 Sep 2025 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwbhWdS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636A242D6E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092203; cv=none; b=q3Rbh4GtEUpRUYhq+2CI3/UaP8RSLkUtzu8+k3j0fp2bgLYHj/OWWhU6gY8FrWQDQbK+VtfNtabAN3gl/c+G4kieNfu651m7Ie/LBCxUMn1hnTaDcSm8pra7cxHhQeCHyq0iWE+XYyZ8TmwZNUvzwvqGjgX+0I7E+22oEsS9QLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092203; c=relaxed/simple;
	bh=IWEZTYZGXONi6EIIcFSYU6uLFWPTPY24F27QBiRkKgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT4xLkLBq1xqAzgMzQJlEhDQMSbMvg+amyL41Ox8s0K1cDoF2kga9HUCkRz80l6J6lI1Lr2nRnjZam6pPfCZLu6K2FYAVglew9IBYpq81qSh+FhTli/56z3jjeRpUtP8PvQ+XXBS2gTh1ep9Dtw6+dbyRZShSrbTxG1vC07np+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwbhWdS+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so514653a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758092201; x=1758697001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObyY81eq059DEG56VzmsGxF6jMlRuUGCb3ki33tmARM=;
        b=qwbhWdS+PZqbGsb2Tf59L9fG2/cuyiLFtAJY8gszP648wq9PDMbbn9LKhqg/sh48ER
         eGdSOAV7F4V82YlTEvOLyMO00isFEACwHN0JawQQ4LLlplOk3HC9swI8smK1lXKyBHFe
         4mgBKpT4sVTjDnU3dPQVOVuio0vQVr/SWDWRVH3sdn2HksVYnSf/Se8lFYJQtfK/h2ZX
         1CvKu2oMAX9CSUI196VD9YUNVjLpVPGE3ubveDcMP5DTm6qLCuDDna4R6R9fD5oqSgLW
         n5vdzq/pbxWlfXYLBKCyvCxOPC1meKar+F0AF+BriJJHbbqZblIXjlQByDqvwmAMGtiJ
         teKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092201; x=1758697001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObyY81eq059DEG56VzmsGxF6jMlRuUGCb3ki33tmARM=;
        b=ZFVGNJsyPN5biJ2SBpyF9Gwcv+wxT2DNQRH/5YAJAKQ91CZ6BjYMS5JK9JJK2nhvWL
         XXW1us+DzeOqH9lTSnh/fnV0tjyQzfgMxhReC3L+c+P4YId5mCM9UVICF40iBhC9ecp+
         yWXzWnz+gPz1uXBxaAZWOiEQVd8PBw5NmvdIZI8RGGGsK1NYEDadGFAwQ1AcGG80JvDu
         2BiMzO5r1rP5lhi+bc2YF5UReTJvEsSM8wZIUJeg+roAwinZ6sYMlwUgu03UzqjMWolw
         qkqVU9Nn5Oren3d49AT8aDD8rI1E1T/derBoJMNr+s9WWqk86kShVS/Fkrbh6oAB4wWr
         jmdg==
X-Forwarded-Encrypted: i=1; AJvYcCVvQbSol8nmWLTHU+C0xYYMcE7Cq+leYtlWXowM3IQVzyMoylmlCZz8YgeOS558A9bJIFEBu0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywty0WZS/zwT8uE7Eo1+okbmtj29l5I3z/j6DDPiGmT0w1R45K3
	XPW1qx2S49cQssb1CYuDE9Opnh7dgbzV5tQ/eJn1kaFdRG++eQ2vAeNVbPN4B4OYuCnTd/adui7
	750OnC6/29UzCVaRNSybphVQLOFbs/HvJRhTDz0Sq
X-Gm-Gg: ASbGncuBa9pf0GVcK5UVx0eq2wBB8aoWxCZCoHhr8KhzW2tlPX/Xf5sgO5geIIZ3jd1
	xK6Xvp72/hXN2X+0DJXrvS3TWj2aCONBGZPJ43ntPCKMOQY4ZnE7zjANF2Ns1eXv2Egv0FQoMtu
	3kR2E2WowPpDT6R0IbAcz6uDxz67pib6MxveUD/GIJuoRHC+coTFC1g4fH5koA5Bh3xTPH6YcCW
	ob5W1YWVuUnyDAboPOLc9oJYtr378etuDCv9S3rlos6Z621C5i6qsu4
X-Google-Smtp-Source: AGHT+IEKMTZjYgtuGLaWL8YGpgf7gTWkCij14D8fcDHgJt2sq1/XZbXh6kXqRHJ2QYP3v6SlcwtiIjgvH7sdOUK02HA=
X-Received: by 2002:a17:90b:5448:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-32ee3f2e92emr1505066a91.7.1758092201151; Tue, 16 Sep 2025
 23:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-2-kuniyu@google.com>
 <980e87b7-64f8-4980-83b0-e386d48af310@linux.ibm.com>
In-Reply-To: <980e87b7-64f8-4980-83b0-e386d48af310@linux.ibm.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 23:56:29 -0700
X-Gm-Features: AS18NWAwvTGLS1bLpZyvzyHodj2avMssydBtdJOH2BcHi7oqwIuzz5ocMz4IWa0
Message-ID: <CAAVpQUCQK6b7AEJE_U6Q9oCewFPpR=0smghi+swGw2s9uHsbPw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/7] smc: Fix use-after-free in __pnet_find_base_ndev().
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Ursula Braun <ubraun@linux.ibm.com>, Hans Wippel <hwippel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:52=E2=80=AFPM Mahanta Jambigi <mjambigi@linux.ib=
m.com> wrote:
>
> On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
> > +     dst =3D __sk_dst_get(sk);
> > +     dev =3D dst ? dst_dev_rcu(dst) : NULL;
> > +     dev_hold(dev);
>
> We should hold the reference to dev only if it's non-NULL(although
> netdev_hold() has this sanity check), as we are doing the same while
> releasing the reference to dev in below code:

dev_hold() must be done under RCU.


>
> if(dev) {
>     smc_pnet_find_roce_by_pnetid(dev, ini);
>     dev_put(dev);
> }
>
> Same applies to changes in smc_pnet_find_ism_resource().

