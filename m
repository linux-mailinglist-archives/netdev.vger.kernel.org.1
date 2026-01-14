Return-Path: <netdev+bounces-249875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5ADD200FA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BB0830BDDE8
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC1F3A35C4;
	Wed, 14 Jan 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB7UP8Mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF43A1A44
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406298; cv=none; b=um/ARmg9qLFYe5M+/cUw7s64+rNtAEHSw2RDOWwodgy3sWRg0mfs7wnv8YRYCUDo+I03om2rQf62DhvuZbDR3MsN7CxSCsN2G8s9G040JsRoj1ZTQAsWSh72oOkNTunpQOjw5IyhQ20ReeoNzVECoHoYFiMnTchWl6usZVC6LbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406298; c=relaxed/simple;
	bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YoUn3/QJtxU0FJ3tKRxlqSKjlz6nfxGss2ADFpdbOxEqz774wsrAm5Vxw0vs0hw13ULyUlEjSDaOFQajYDZaPx0hXw+/CVp5XSolXYY2pmc6ryTw+u3ZPRu2oaZ+2mm97w6tS2puU8svaTXQjuvSAYVVLN1v1HhJegbvdGeKLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB7UP8Mz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50145cede6eso11345701cf.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406291; x=1769011091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=GB7UP8MzbH+zo3J+a15WxFGHqpJNmNxGFeeQnj2bW1ANbZoF3h2ufO1wHja9wlMHMb
         NiN90QIDCgPS8SbC0v+cd/BN2qRBb0E1NVDeErx5ofZdc0u/+FJ2Vzb3Fi9TGxzIqIJk
         6pULQnGtROKszzz2opai9vBB0pHqy1QW3Sou7AeOCPhity3t/32JolroB8JAG3toUtM7
         /LEYj8x/nWn2KWgq2al7e2XdKgw+F4LE3eGYjyWNGmpNrooOyRUHqYK4a9O43sDT/ce4
         o7cmb9Usn1YehbDuuBcjkTElDB2OuunRsEW8GSWiidXdE1ZcaS+3MqGO8tYtWlJtvHpT
         wNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406291; x=1769011091;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=ZhsByx2xJ4YCKOAJtI6t07/A0Y2dVIKCNnOoIMNo6ge5kmRKVXnmYkhy4dtYjuRoh6
         i2+oZbR6LXjbV08NZ9ecpfzY0+G6FIzZO/D5KGOI7o7wmpew0Gs27ks/btVZgt5+dp8w
         OxgClgioiIKhopAo2QIE0sI43cnmCIXXG2jA46kAoH57duDdvDJE/xVchMq36IrYo0F9
         hjckF5kRoG24Bi0P5Bq0zOPMybKUmxHW75W45Ctbo0G1rn2GVSiY3ot+97pkxa2wz3xj
         LclWB3DTcjsMZFqD+8Np/pEABekL4hiDYtgydmM3h13lkh9aG+NPEUrU+QBQQCQrgpg7
         01zg==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ9hJ+GU3R84HNUfFb7aV6INvJviC3mP3ToXCqstJQfwmI1CGDN5tdWpBvvoat0kkn7J0fjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdg+/KNdsO4+ck4mmKJqDLyqR2O1YLmrTrWtJgJfyHaFVunCjX
	2ZsuGC5NeATbj2nYFz2yP+k3wzuEDpPhOjvbJVlv2dwRu0PYt3yzcCbduOHaHQ==
X-Gm-Gg: AY/fxX4UOZRO2FUpgP29rGVokjOSkiazr+X/3U8bgzkwLCEhe+cTPVNSMiCzYi9vW48
	w5hj8rzDZLzQDEfvYLR3cDljW685I/WUg8nbVwxAolDYfJyC9njdtk/jReZQhiypxjBW4v1t73Z
	2MWb9BAggNUY2KB5/r6+6hSpDiyAvDvgfs5d1xCy/w2HXU5UdY1v3j/LOPf+ZA2+SrDP+kmq5MY
	XwBF8MjaupsWOkfGmeWPKsMRa/+TInhAlWAkq6ohetUESRUT1Ytl+H9Cct4YiRnZyUcuM+/6Hyn
	3/fzzw1teKawfwMkVIt5znQRa1Ej0MzSHFHA5dnjoWz2ZbNvsnFkJ59g8Rxt01LviR73usop+z+
	cUp1hTSezqcoYv2DdcGIkzt/uL4WLCxjCVJf1uAsgmSX/8aKH6AmNCVoJmScKubFOy4PC0qU16d
	yfFFC3tyAhLHquKh32SXKPuyq1A068KaxkYJzo3XFQVaglv805FZBvexAlJITlrUE2kOKsKw==
X-Received: by 2002:a05:690c:9c0a:b0:78c:25fa:1bb7 with SMTP id 00721157ae682-793a1d6fa34mr22055957b3.60.1768400306350;
        Wed, 14 Jan 2026 06:18:26 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670ec0sm91265417b3.36.2026.01.14.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:18:25 -0800 (PST)
Date: Wed, 14 Jan 2026 09:18:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
 Neal Cardwell <ncardwell@google.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "parav@nvidia.com" <parav@nvidia.com>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "corbet@lwn.net" <corbet@lwn.net>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "dave.taht@gmail.com" <dave.taht@gmail.com>, 
 "jhs@mojatatu.com" <jhs@mojatatu.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
 "ast@fiberby.net" <ast@fiberby.net>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "ij@kernel.org" <ij@kernel.org>, 
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
 "g.white@cablelabs.com" <g.white@cablelabs.com>, 
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
 cheshire <cheshire@apple.com>, 
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
 Vidhi Goel <vidhi_goel@apple.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.a2eb52bfa5d5@gmail.com>
In-Reply-To: <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Subject: RE: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com> =

> > Sent: Thursday, January 8, 2026 11:47 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-d=
oc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org;=
 kuniyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.tah=
t@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andre=
w+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org=
; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@erics=
son.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@c=
omcast.com; Vidhi Goel <vidhi_goel@apple.com>; Willem de Bruijn <willemb@=
google.com>
> > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill pack=
etdrill cases
> > =

> > =

> > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional i=
nformation.
> > =

> > =

> > =

> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options =
to =

> > > cover several scenarios: Connection teardown, different ACK =

> > > conditions, counter wrapping, SACK space grabbing, fallback schemes=
, =

> > > negotiation retransmission/reorder/loss, AccECN option drop/loss, =

> > > different handshake reflectors, data with marking, and different sy=
sctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---
> > =

> > Chia-Yu, thank you for posting the packetdrill tests.
> > =

> > A couple thoughts:
> > =

> > (1) These tests are using the experimental AccECN packetdrill support=
 that is not in mainline packetdrill yet. Can you please share the github=
 URL for the version of packetdrill you used? I will work on merging the =
appropriate experimental AccECN packetdrill support into the Google packe=
tdrill mainline branch.
> > =

> > (2) The last I heard, the tools/testing/selftests/net/packetdrill/
> > infrastructure does not run tests in subdirectories of that packetdri=
ll/ directory, and that is why all the tests in tools/testing/selftests/n=
et/packetdrill/ are in a single directory.
> > When you run these tests, do all the tests actually get run? Just wan=
ted to check this. :-)
> > =

> > Thanks!
> > neal
> =

> Hi Neal,
> =

> Regards (2), I will put all ACCECN cases in the tools/testing/selftests=
/net/packetdrill/
> But I would like to include another script to avoid running these AccEC=
N tests one-by-one manually, does it make sense to you?
> Thanks.

All scripts under tools/testing/selftests/net/packetdrill are already
picked up for automated testing in kselftests:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D8a405552fd3b

