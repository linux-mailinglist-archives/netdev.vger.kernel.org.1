Return-Path: <netdev+bounces-143073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEA9C10B9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5451F2259D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931EB219CA1;
	Thu,  7 Nov 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPADJcml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F2219C9B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013760; cv=none; b=r943bI4z+pVQ12femuX6rS+e0xgzMDqgFBRz0+nP0dczcSvuLPD8Z4V1EFjolUq9V59UadmZPZw0x1w0yuE+Dl8Byi6YHLuoKD3vxSdx9p2U/53lb8353/r5+4IHZkjnaHaAXFOWsKUhrNZ6MW0lv0VXsK8QmaZ/7B9pEosqeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013760; c=relaxed/simple;
	bh=ogz6/8GfJao1oURK8zqF2sVc7GFNaZL0JBHTYilepMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6WK7JOfvlwnE6Np90440SnO43c6MUqjlsTE6r12sgM1JGL7Ai0nuQBOQi7nRj3a4PjbU1pBym2ujMiB2LDLXPMZPK22YuGkY6ud+05h3pYhViohFkNQUpyX4Wfs3CdoEtZeX5zAaZTqD210Lk4CBCXStU/CCmcfgvS0CkyLWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPADJcml; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83ac05206f6so52109439f.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013758; x=1731618558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5txm17108D/EDT6kscbRifzMW0jUfOCG1+IYV/Pt9A=;
        b=uPADJcml0Ju55eElFiXYwHUeB1dh1lEyF3RY7z2pChPp5qSFiDC0GcytskxUS3nrDf
         aszEFWpw3Qg8yYQyCYz8wGDoTpG61D/bTadIqPc6DkjE6+kKNeeEs55PV8EPg6+y5wq4
         vNGmr+2/42iI52pjy8faBWcy+2rTFHf+UgSEu3HNikkZb8pZ4ACzoA0HY24P4uDLRnmL
         bzmkEB3z1XlKIfggebC0Re1pAAP4S6y0lpAqiJysvW/nYqjZPoeFor25xxXi14mATicZ
         LtUeP+ZWusGfRpDru28DkAW2BmKR61osIHzqI7/PQumgtAUIZlE83g49fo2YCRz3ymSA
         dN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013758; x=1731618558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5txm17108D/EDT6kscbRifzMW0jUfOCG1+IYV/Pt9A=;
        b=ZC12jgzbIHlOcVmBer8s2BDBst8DAcjsGAkMaQ69Qg+58Fur7CoqJJeqZg5hHsB0XL
         yisBpwqeuaOPGWAb0ER4kexwSwxdLRx/FhtAGpTrsyS2qiQoR5G1wIkHKA+6ehhFXXSC
         EXSgHMmDu5cqnCSK2wPafI10/fL+eUglSeolfoQ2hyGWaF6BBeEf9hW7lvHrLdeohMCu
         jwl+zvMO2LSC5zYQiPh617QzjUbFLJG2ixP/B42HKb9ejG3QGb2DQktqMeiupOndCNL1
         xM77gq9eBwamsLw+lDzGDixbaqKx7IEPpOH09es9rs4LJ/9gCLo+fpxCJ7qN5nGoZfRc
         AQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE9Vv5ZdKfaMbQBUYHBwZvWo7OynHEbrcSEUhy8IIHCmrEoyvbSyZP8h4cHeWd6T23720ddBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXiW7P4OgeLlS/WMaH40AxZJxVpBaZMn23/yk+Tl3pMo5NnK+
	nz0Kj7mIHcRoxUgLl20kKzBrRZG/uY6eX6+Ur9dVO5dsjhrYXVmqyMjgKivQQVPiNJOx/QyPbCb
	HSuOf6x3GnOXMBdwnBoJpsgvs3uzFLhxk7Cg3
X-Google-Smtp-Source: AGHT+IG7m9e7Hy3JVNLPWX01/tVuSksMG95zEfg3kcWlbdqqWLOS9fpcgpMDnF27ajn+3ShMiBiNOHZPCSUgBImihXw=
X-Received: by 2002:a05:6602:489:b0:83a:b52b:5cbb with SMTP id
 ca18e2360f4ac-83e032ba434mr42543939f.5.1731013757810; Thu, 07 Nov 2024
 13:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234625.168468-1-pablo@netfilter.org> <20241106161939.1c628475@kernel.org>
 <20241107070834.GA8542@breakpoint.cc> <20241107124802.712e9746@kernel.org>
In-Reply-To: <20241107124802.712e9746@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 22:09:05 +0100
Message-ID: <CANn89iJft43XM_vR0Lg78oHPXUGweq0sTMMwG0=c2kBu6DQsdA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/11] Netfilter updates for net-next
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 7 Nov 2024 08:08:34 +0100 Florian Westphal wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Thu,  7 Nov 2024 00:46:14 +0100 Pablo Neira Ayuso wrote:
> > > > "Unfortunately there are many more errors, and not all are false po=
sitives.
> > >
> > > Thanks a lot for jumping on fixing the CONFIG_RCU_LIST=3Dy splats!
> > > To clarify should the selftests be splat-free now or there is more
> > > work required to get there?
> >
> > I tried to repro last week on net-next (not nf-next!) + v2 of these pat=
ches
> > and I did not see splats, but I'll re-run everything later today to mak=
e
> > sure they've been fixed up.
>
> Great! I was double checking if you know of any selftest-triggered
> problems before I re-enable that config in our CI.
>
> I flipped it back on few hours ago and looks like it's only hitting
> mcast routing and sctp bugs we already know about, so all good :)
>

sctp fix :

https://patchwork.kernel.org/project/netdevbpf/patch/20241107192021.2579789=
-1-edumazet@google.com/

