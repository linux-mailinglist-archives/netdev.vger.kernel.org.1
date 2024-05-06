Return-Path: <netdev+bounces-93775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65598BD2CB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE343B240E0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AF156885;
	Mon,  6 May 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fr4wiq8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284715625A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012940; cv=none; b=ZCCsx85ZWDzYf7/9Zw2EB4L4C9YdwmC+Jp0HEhol6tG+bEljREnOY5XLyAzvhI3JY7U0zBu29CrgFFW6ow6bvO9Qz0M5+mw/Ps1trtFkisnIhDsd2+DdH0zOqyekKi5Goq9PizXeyFQEBZWyGLEdUG412w6Xae9XQsnlMA6EPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012940; c=relaxed/simple;
	bh=1rXrFo5gtTjQzRA3HEWWpPMB29KhpNUS2nFXR6zZhEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEyXxMq30rp1L4pOTrMv42fRPnlYmekAMFJFSOBsKg9H9QrJWstIlP+zaHpxhM6rUTI53yTaJMimZNAk9Jsr58kBeFszQW5TUoXuXHhT0FXK78CcSkDprKwG3eeTIqeYgPOgW/+kGaFoDHUycFoXKssFFEc4DjhuSS6xR4bK/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fr4wiq8O; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso13864a12.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715012937; x=1715617737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rXrFo5gtTjQzRA3HEWWpPMB29KhpNUS2nFXR6zZhEE=;
        b=fr4wiq8OrLI6VAGzEd2PhI2vIg3d3gYzMsISNCb+H+TemNxbzKj5LFCiBDKcYwZ1Ii
         d1lgAAi75c+Cc82aSrTotYhiVi5GXy0jx4f/e32osi8Y8Cx4htFEWnxkv7sgPWwh1hu2
         17zgWvCLZjLo/t7TV35lsBJSTVSU9y282tYQm9uoDs2GWk049PtCFn/zyO6k3cmdbbde
         Hlt8FZgXX2U2gHZv5BQuqqxLCg77ZiXJGjF8cuwUTey/ya4D9zKFptJodTecHpok9cBz
         TrHRcWjJkelgv0lmnxZ/T7UMkPLKNexzQGjqp/p4Tp17QTZeS3m/2Cmv1oxVDHjsd0Yg
         T2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012937; x=1715617737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rXrFo5gtTjQzRA3HEWWpPMB29KhpNUS2nFXR6zZhEE=;
        b=hImYgEVqal6h4jkg8UhP9vPm6OcueZy17kPQMcbj0B1kY2r2fjeSnDZu+zQyC85E3S
         ZNBElj2pBVOihsCGJlUg+JsdK7v3Uxhm5HxxJNwBgwyMJAy23RTkD0QKfNrR0kwvkDfF
         5j85Zkejit4nDKo+IQbO+44LE0w0vcngho/MP4ktE/PLLS4A1xd1K2GXT5QDWASwhoPn
         ZBnw720331w5ZsUtAFxRd5pKQIL0PcUweWT+Klw/C/TbqC/d/3WC8zfy3veUVBEMfRiH
         Jrb01fpBeLrY+W8P5KgME/p0XZSMM7/U/XjA6zDlfGdg2pY+szeewT+/mDExWytvWc0j
         RzoA==
X-Forwarded-Encrypted: i=1; AJvYcCXIGdVI7HBuF4pH1EE5e5FqyF8bwcWl32dsMAQBK9tXsQ69FBcbkbS2oi9+J49zLgQUUcAJui2ObcXgbKnKYMSOham0pMtG
X-Gm-Message-State: AOJu0YxOt6n4S9Yisa1t9IWf3Fnk9vAilcVbBA/OuWQu4ySNG4bh5aUs
	ms3HUiylvWAw3Yg1WxEbs9yyK3wVnp6bX1Kn7c5GEDaePlBhbg0MrvRLEQtQCVCF2yXjszZeIuy
	SGRMV/MwOv52jDexst0yqVKsNheN9Ws0QBYn+
X-Google-Smtp-Source: AGHT+IFkrFRLvU7zUjpfG7oQdzCs7hiQazvOVqyMqy3vuyPOp10A2VtLrg0fmXInxDzsrokiVV1aAplVX9UJEdC+L+8=
X-Received: by 2002:a05:6402:354f:b0:572:a1b1:1f99 with SMTP id
 4fb4d7f45d1cf-572e2690aa5mr275809a12.1.1715012936985; Mon, 06 May 2024
 09:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502113748.1622637-1-edumazet@google.com> <20240502113748.1622637-2-edumazet@google.com>
 <d09f8831-293e-45ec-93fb-6feab25d47f2@kernel.org> <CANn89iKPSp9_bZAZpFM4biEg7vFXxMmY2nQfEmTfLsiHGdBTxg@mail.gmail.com>
 <f1da8bb5-4668-40de-93cd-3a150d000365@kernel.org>
In-Reply-To: <f1da8bb5-4668-40de-93cd-3a150d000365@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 May 2024 18:28:46 +0200
Message-ID: <CANn89iLcUJQnHfF+znqmtbaFQ+DW2wZJgo6rOWv_EnG0ND9y=w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: change rtnl_stats_dump() return value
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 6:23=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 5/2/24 10:03 AM, Eric Dumazet wrote:
> > On Thu, May 2, 2024 at 5:59=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> >>
> >> On 5/2/24 5:37 AM, Eric Dumazet wrote:
> >>> By returning 0 (or an error) instead of skb->len,
> >>> we allow NLMSG_DONE to be appended to the current
> >>> skb at the end of a dump, saving a couple of recvmsg()
> >>> system calls.
> >>
> >> any concern that a patch similar to:
> >> https://lore.kernel.org/netdev/20240411180202.399246-1-kuba@kernel.org=
/
> >> will be needed again here?
> >
> > This has been discussed, Jakub answer was :
> >
> > https://lore.kernel.org/netdev/20240411115748.05faa636@kernel.org/
> >
> > So the plan is to change functions until a regression is reported.
> >
>
> As I commented in the past, it is more user friendly to add such
> comments to a commit message so that when a regression occurs and a
> bisect is done, the user hitting the regression sees the problem with an
> obvious resolution.

This commit has a single line being changed.

Whoever does a bisection will report, and the resolution is trivial.

I do not think we want to copy/paste a full page of all links to all
relevant commits.

