Return-Path: <netdev+bounces-111900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E82934050
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C371F21501
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9504224FA;
	Wed, 17 Jul 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwc+EHGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259851D52B
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233186; cv=none; b=ea913Y48Oa1F6b8hnUyyH8yQVHwiWT6vxJiSObohVyXkYzRJxjNLGBuVo4DFnrYP2G1jUOgPjJrrRFASHs0qnJZ70SQryzWJAmyg+DUq8sS4C9PMitytoN4peMCoUT0a08W9XnDWKcERpVEPWEXJYgWlXqrdSiMwPOAVzPdvmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233186; c=relaxed/simple;
	bh=ueN0+4rh+Rpr5K0r1hHmUzFbjEU/AwbHKp8zgwHhZmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul510vVjxaI+sMCRftFw/6U3shtdjfDYlRZaDEmsyquACfyoyDx2c8+LiqFMSFWSrkm6IcISMVdr7RRbXtYzwKj3zOQoheA8pbEIPTa88Y0wQzEmGoaA3Wb5RGybljNOCHE0JFdwEMLK76kFB+AK+SlXtBGopOOiOxSvD9yJlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwc+EHGV; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48fefaf11f9so340025137.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233184; x=1721837984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueN0+4rh+Rpr5K0r1hHmUzFbjEU/AwbHKp8zgwHhZmw=;
        b=Cwc+EHGVDiYo4/saNCEOs7nd/29vKQqgCRdvPe2JBK7t81zRIfzSjZxDxb17dpAlZo
         OpAAbW8V2M0WCzEHqYlJHH7BJyUmE8k3prKojiPPfKt8NA1kzbOyYZ/PNl4uYZtpLiz+
         AOZhLr2u2cJgelltYvUig47H2hLlInlDWAPREqZRQyXExmzoj3WKbdLMkIIWi0q/Ke++
         fC5GTo8zJIqJnGCV8TSfLwhmEZO4oyKZlR3VimJFVchLfYBmhCysMY+17hhKw0fF+cr5
         ah47Scr5+7vYxWWanoJADcOiql61/Tw4wZsubzIMqFkziSuWP1d+G8yIPKbw2QZ5uYSI
         3g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233184; x=1721837984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueN0+4rh+Rpr5K0r1hHmUzFbjEU/AwbHKp8zgwHhZmw=;
        b=j+H9KIz6row64RrW5roxhB2m05biHov+hRr8mJlSYPfS25t91D3Cex6fTTvTWk91qA
         SlJ3+GmcRdNGqvQLqGHAJBWCIq/xheZaElomr5SdQu5ftr16yxFr21p2a2+fh2Z71D3L
         O/CtoJte0pLeiQXxDcnprlhrtAVqAk19gUxHq26uTrH4I01CxCk67mhfweDroOL0uMvR
         bySUjiBMuHY5fIfYX4x1rtq0tBexCJPlJiXXob7cSfpQwpYZANk+HobNv+kk51RfWe1G
         3BEYJ9UD8ckGZpadCWssNSF4s2GVX5q/XLPm2je6+QoQfJYPFpXr2hmMXDb2HM3deU8G
         zJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqGB1TIpKvUFonRzsMKUKxcirgNoun5G7yXnPvyUJWmbqllTCTQWpXkrC3V01GLRRERECdYkWlRW6O2MsA+myoeVVQULsL
X-Gm-Message-State: AOJu0YxEgIXUoWptjmlyYtJBzxvq/2fDkfuE8Wvej4ziZL7ZtEjp0M15
	KiCEBB0uGangrlmdmV4IK5BOJ4LsIs9vE+sTL+h6z5EDZ3knKIWKsq1RIdjbPCL3azpjcXm+6yS
	zBMPUTSRrH8mZPhivCAfL9I1O04U=
X-Google-Smtp-Source: AGHT+IHtpDpieGuIpRABDcUy4ssui+Udfk7gX033uJdQAIBuWBqPe8+wwbMP3Gf39COzz3x7ILoFJ7xA4vftdSRUTpM=
X-Received: by 2002:a05:6102:4a8b:b0:48f:9751:198b with SMTP id
 ada2fe7eead31-491598bf814mr3099743137.23.1721233183855; Wed, 17 Jul 2024
 09:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627130843.21042-1-antonio@openvpn.net> <20240627130843.21042-18-antonio@openvpn.net>
 <ZpU15_ZNAV5ysnCC@hog> <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
In-Reply-To: <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 17 Jul 2024 09:19:32 -0700
Message-ID: <CAHsH6Gu56r75v9JuSKYWWNhPTc0bjN9CoGQ+kN-G5oJwaqYWmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, kuba@kernel.org, 
	ryazanov.s.a@gmail.com, pabeni@redhat.com, edumazet@google.com, 
	andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2024 at 8:29=E2=80=AFAM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> On 15/07/2024 16:44, Sabrina Dubroca wrote:

> > This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
> > each packet. I wonder how well the timer subsystem deals with one
> > timer getting updated possibly thousands of time per second.
> >
>
> May it even introduce some performance penalty?
>
> Maybe we should get rid of the timer object and introduce a periodic
> (1s) worker which checks some last_recv timestamp on every known peer?
> What do you think?

FWIW In NATT keepalive for IPsec the first RFC was using timers and
the workqueue
approach was suggested [1], and later implemented [2].
The code is currently in net-next.

Eyal.

[1] https://linux-ipsec.org/pipermail/devel/2023/000283.html
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20240528032914.255=
1267-1-eyal.birger@gmail.com/

