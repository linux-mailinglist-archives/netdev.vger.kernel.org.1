Return-Path: <netdev+bounces-146265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F39D28B8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432EDB29D97
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5F1CF5DA;
	Tue, 19 Nov 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM8S3Dcl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542C1CEAA2;
	Tue, 19 Nov 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028181; cv=none; b=ZGjlOYwdhGUBa0FOCir8yE8T7seDrbqoKR819OGaNr47mIyd1AZOkQMLXLexHA6tVCzKYGlu4AjMimlDFVV2GnNWIsywsQiqIlrDEYLMes7jQiPnOAH97abqio/YGPcyx+N8aATdNF4BWqhP5DQO1gdjxv384Y+60Qroe7wQPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028181; c=relaxed/simple;
	bh=ppUWTmFX24mYYKF9QRClgtlq6a/mWwX82JjPsCdrs6c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=srmNEo5dRRjDE136eqpzQ+I27Byp2H1vDe5r1s73RW4OOLebvzQrCLqKKc9bbUcesBzPQrtq6SQSTgEF4o/Db88vsMwXMfqXxuiL8DeMBJza6ZS0T87yWclWWCiwX3vMSeOMY4TI+IyqCqq75ZJS2CH5pEPUvbFzQUz7Z9pvaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM8S3Dcl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e387fdd1ec4so2130230276.0;
        Tue, 19 Nov 2024 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028177; x=1732632977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mKc83Z9HOLY249Nin7rQjs6BHlM/yh/iEiCfe28AgI=;
        b=cM8S3DclSzEaX9vBItpn3NSvwhjZw4KxCIcTh+Yx6CUzUs6CtOxbEg5EBbV0ViSIYU
         06CkV1WTYG5sJXZFUjUSYvetCyV9ZZ5s8gvNT4VLoRxhfI0BQpbTjLfil6le87OUf57p
         j4mcYgRydYbK7FzGcisNYlkZpNuoiHUlfIZA5qYoB7qz0zRQgDypABH91malBZF/FdUI
         EDvicIx1ztp3ipejOJjSIBxlpNiKabevLQJ5XkMfitO+mi0/gNAA6mlYxJPpjk+pxDB6
         11qXAhlTDy0uXtjRAp1zvRvFK99ZUCnv8FVQfkJ1JWFK1H7VPgNIUV2v8aO1NP+KaOPS
         effg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028177; x=1732632977;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mKc83Z9HOLY249Nin7rQjs6BHlM/yh/iEiCfe28AgI=;
        b=TNGd5JKNL24Jntqz9oDZQI2lMtfWA+bEr47DGF1cVD5PYcEbsU7n7tsovMu8F4sjzJ
         XAYNjoGRrEUzLCA7AiefwBFScgYba0qme6avHMy8AV4WLuqYrh05BUti7JK+ubmmH82Q
         +13zWFO/qZ5AyVwt3BVnZJOMm7In9pYF66jC7vm5z5yClYSO2U4WPNkZdG/Pdvpq9HEE
         YRvmuanvKk74KPpkM5TQ33EaIytBVf1voeYfOxna+ja74AOgMFL+1pac6LxWjn7/tTFT
         bNz11Ld7cSV2HHTzLlP5aAh3OyYOq1bT5Oe4eHb1tpY1tyQ7Ts66ev/hdweyzPFMEqw4
         hTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAAlT0Q1aCQcQ7uMt92QEsERunatRRC9KRpdibq5Esq5V+wMTPLYqa1rEEFf73TMXqfu0k++Y2a5ut7tc=@vger.kernel.org, AJvYcCUG0tqzHRAjNd/EXPId5mP274hoTRTUO/Q4yayjuV/vv7hWmBMWJh7NQsJ0MRknTYv+BkI1VcJU@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6ymnFlxij+tCqShCH2nVUEQ/ooKnDy7Kl0M/mvaKSUj15BlC
	coS0XMGpdJU05pYlFLH6fQD9IdhcB/tOoyULmF1VaQlbjoU3cmG1
X-Google-Smtp-Source: AGHT+IGsmqH5sooiWWCQd3ivA8DTUDK4u8jFRlL3c45aXghHuCORBnM2NfkGYVPXYfr7Z02EvlM3yw==
X-Received: by 2002:a05:6902:124b:b0:e30:c261:4d57 with SMTP id 3f1490d57ef6-e382614635emr14593861276.27.1732028177178;
        Tue, 19 Nov 2024 06:56:17 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392bbbf3esm11805901cf.41.2024.11.19.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:56:16 -0800 (PST)
Date: Tue, 19 Nov 2024 09:56:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 agx@sigxcpu.org, 
 jdike@linux.intel.com, 
 Guido Guenther <agx@sigxcpu.org>
Message-ID: <673ca7102dba5_2a097e2948f@willemb.c.googlers.com.notmuch>
In-Reply-To: <610a9e2a-aa6b-4a2a-ac5d-3ea597b16430@yandex.ru>
References: <20241117090514.9386-1-stsp2@yandex.ru>
 <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
 <610a9e2a-aa6b-4a2a-ac5d-3ea597b16430@yandex.ru>
Subject: Re: [PATCH net-next] tun: fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

stsp wrote:
> 17.11.2024 18:04, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Stas Sergeev wrote:
> >> Currently tun checks the group permission even if the user have matc=
hed.
> >> Besides going against the usual permission semantic, this has a
> >> very interesting implication: if the tun group is not among the
> >> supplementary groups of the tun user, then effectively no one can
> >> access the tun device. CAP_SYS_ADMIN still can, but its the same as
> >> not setting the tun ownership.
> >>
> >> This patch relaxes the group checking so that either the user match
> >> or the group match is enough. This avoids the situation when no one
> >> can access the device even though the ownership is properly set.
> >>
> >> Also I simplified the logic by removing the redundant inversions:
> >> tun_not_capable() --> !tun_capable()
> >>
> >> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> > This behavior goes back through many patches to commit 8c644623fe7e:
> >
> >      [NET]: Allow group ownership of TUN/TAP devices.
> >
> >      Introduce a new syscall TUNSETGROUP for group ownership setting =
of tap
> >      devices. The user now is allowed to send packages if either his =
euid or
> >      his egid matches the one specified via tunctl (via -u or -g
> >      respecitvely). If both, gid and uid, are set via tunctl, both ha=
ve to
> >      match.
> >
> > The choice evidently was on purpose. Even if indeed non-standard.
> =

> So what would you suggest?
> Added Guido Guenther <agx@sigxcpu.org> to CC
> for an opinion.
> The main problem here is that by
> setting user and group properly, you
> end up with device inaccessible by
> anyone, unless the user belongs to
> the tun group. I don't think someone
> wants to set up inaccessible devices,
> so this property doesn't seem useful.
> OTOH if the user does have that group
> in his list, then, AFAICT, adding such
> group to tun changes nothing: neither
> limits nor extends the scope.
> If you had group already set and you
> set also user, then you limit the scope,
> but its the same as just setting user alone.
> So I really can't think of any valid usage
> scenario of setting both tun user and tun
> group.

Understood. If no one comments before the window reopens, I think it's
fine to just resubmit.


