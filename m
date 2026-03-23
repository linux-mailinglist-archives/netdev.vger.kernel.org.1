Return-Path: <netdev+bounces-270566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB/BHp9RwWnqSAQAu9opvQ
	(envelope-from <netdev+bounces-270566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:43:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21852F5102
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43249303A213
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D33AE6F7;
	Mon, 23 Mar 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="l22AxLEr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855F2D9ECB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276643; cv=none; b=rLTFvx8UhVXznHq18aU1D0BUUB5QRr7Y5Rx3kN1Dfbw/IWoNwD9r+SrIKO665EYEQmtN168ywaDNcGOOg7KPSy691TrgVVAci5muYPtJ9Sw5r3xJH+kuxQi2hGPSkb3BZqytmTQll04iMsHWmPSYNe4bKT8btIv2jIWPBQlNd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276643; c=relaxed/simple;
	bh=DMbXMglMLqexRK4r59KM1pp/3lF7vZDIbIOMtAtTbgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAm9veBKezauJiPa33SPQ657j4nl2s1BdgBGYN/u11x2gEL4lfrH+S2NQNqER6XeCPOjTeymZlY8mfmnTqe0PYHXjyUlks7pknSP7vZ1by3oagcRwRj3A6ITtZswsPOClnO+B8q4aY7feS5tgRckGB3jRWglMjoNlTQ6uD5Xkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=l22AxLEr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D51853F99C
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774276637;
	bh=r6tGJUi7Q/sk2IlSUmmfPbgFRMDmCLVna/XK1xDxun4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=l22AxLErkOBlJXTzaCNohkYAAmjM3ri214Ld7Nx888alsBq8rgKspgmhIJ8mIAq6V
	 jevWFABxX42KOOxoI+A5uSs9fCxL0P6DpwQdeQilzg77n6qlfV9lqNcmfWi8GhFGkT
	 AWb0NFd2MKLf82/wudfYQbNdhU1PyrZkUlNzSuuVZiY0/RXxxcEyVFWsjqVD3fWsf7
	 lBMF3LfEJsiT1WdtwrVA/ld0gsKXX2ggIywbXcXfjr3e/0uA5mMn4Di+BFVP8M7prv
	 IHTLN7n1Ucf92S4Cm3egrM//rqtf7s/chAmiVex/MvhTN3+dq+SsmIQkEKqmMtZAEy
	 3X0LWkiexr2x15loq4dlkWMtOojfcWfcP8417UQNNMYt3h+9U7R78FWr4atV3Tbsyz
	 yofqHUW2/yA51V/2OX2YNR7l8zZeyPTqoAibIuiqsKp8GgaS1EylgvMPTzBCiMTM7E
	 xGLgApyTOZI3RaLBT3BabsMPEeDQYiU9J6d0cLswFVbx48LrPsffEuBP+9RQ7MyRkc
	 GwVtDGiSOXKPeQMkEt4CaoLxS48Hfw+mZGkv7hN0B6VXZAMQI/UJnm0EvovqES2RZg
	 Ar6vQdAiTaHyySpouFX+6qIts4uHWac2U/Ot66qjNNPzmiXvmRHYIFCa5ENn+xio5i
	 rb/pn0WNt67P2qT4WwtdgWuo=
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0d15416b3so1286826eec.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 07:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276636; x=1774881436;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6tGJUi7Q/sk2IlSUmmfPbgFRMDmCLVna/XK1xDxun4=;
        b=HoEwRLzbySLmwjcqnuIDsgE9jQiBGe9V4hq6t4ASDC3KW6+1Zfgvw0GjWB4XkA1XM6
         vH6wb7VwAU5Bn2gSAI7BgaGXZXV13Q3ffODPq0UT6684NzrEBtjqv6gBl3C06H48r4YL
         +PLjeglzygi1O9lu1gXaw6xeiyWJrQm/D20noLLtad17/CHHx3joSNT1Kkc26H09vVTP
         cDaIBPymtMeOXzZc41J07/kET6AXPreTVjEScPgq0MAz7WUXhwLYzPns++W55Y3W6vSy
         9a/Uy24aSv049S8P/ezr+BYrTGRR7CMeW2YviptzsZR50gXPk3QbGuHBZ1CqqP44ylmT
         CAug==
X-Forwarded-Encrypted: i=1; AJvYcCXALsM4EMfQCwOnXVCbLbyFZRE7lsdwFfa1GZExQ8q+QRMCfT/eqS60Yf1EfN8W9yZ+39aKQE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Dsk13gNZfGhA1caQzqGBttqCU80E3zpVnGZu8oC/2Q/haReH
	jEIb/xiMz5akK0/3pfiW8FT+8cyoaoCLSvwE2EJtdIFzdw/8y0/aZiC49z8M0ZyGF+/v52cvqdW
	u5h7gms7uFnzJTAY208byzj5aRa2I5XG8kHcDf5xO0SZKW6t3c5n/+iLphteM7mjEAjUI4Xmq6g
	==
X-Gm-Gg: ATEYQzwOmldOuZoXRX5tf3W/I8WWIWsrxWQMlVXSNozZNy0xjj044yqVNo806WefQ4V
	PfW2Mt/tmp+9QHTAOHzuItoU1szDlJSp9d5gsYW/JSD9YVzy9OgCJYfu6TnGskjreF5aIuc/zjJ
	/15vPz7NGuLuFzLim8yxE7qD3nxL6evz2ZmRrGpFHj0RO6yoXRBa26Yrs39YTJz9g/4fyXJMO2T
	/ICqcMem90ACvIMBEKdyC7QcdG2KRXqlWaotnAr14nFXOgF9ZbTXuMakZeqqbkPMeG5Md6IXZ+X
	+4mLGtqxJFQug7HytYFZF4/RN1uNX9DCIJkVP48yr/2qfMFWno2Y3El6tfTRIZsYRiP9XlTtqIB
	HB4vUWJcdGK+77hDs1J8ksoITNxf5Ytv4lrIb6j4qsTU71AWYD1NfjrkQW7XnYoIosfiN4w==
X-Received: by 2002:a05:7300:2382:b0:2c0:d04c:a6a7 with SMTP id 5a478bee46e88-2c1097c0a34mr6039348eec.28.1774276635955;
        Mon, 23 Mar 2026 07:37:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2382:b0:2c0:d04c:a6a7 with SMTP id 5a478bee46e88-2c1097c0a34mr6039319eec.28.1774276635388;
        Mon, 23 Mar 2026 07:37:15 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.108.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29d28csm15436900eec.19.2026.03.23.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:37:14 -0700 (PDT)
Message-ID: <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
From: Georgia Garcia <georgia.garcia@canonical.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, John Johansen
	 <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack
 <gnoack3000@gmail.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess
 <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, Samasth
 Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet
 <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour
 <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn
 <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,  Kuniyuki Iwashima
 <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Mar 2026 11:37:07 -0300
In-Reply-To: <20260318.In1aekohyivu@digikod.net>
References: <20260315222150.121952-2-gnoack3000@gmail.com>
	 <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
	 <20260318.In1aekohyivu@digikod.net>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	FREEMAIL_CC(0.00)[paul-moore.com,gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgia.garcia@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C21852F5102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Wed, 2026-03-18 at 09:48 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3000@=
gmail.com> wrote:
> > >=20
> > > Add a LSM hook security_unix_find.
> > >=20
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >=20
> > > Why existing hooks are unsuitable:
> > >=20
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >=20
> > > (1) We cannot resolve the path from the struct sockaddr in existing h=
ooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >=20
> > > (2) We cannot use the struct path from the listening socket, because =
it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time=
.
> > >=20
> > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >=20
> > Some really minor nitpicky things (below), but nothing critical.
> > However, as we discussed, I would like to see the AppArmor folks commen=
t
> > on the new hook before we merge anything as I know they have an interes=
t
> > here.
>=20
> John, Georgia, we've been discussing this new hook for a few months now
> but didn't hear from you yet.  We plan to merge this patch series with
> the 7.1 merge window (in a few weeks), so before that I'd like to merge
> it in -next in a few days to get a broader coverage.  I'm pretty sure
> this hook will work well with AppArmor too, but could you please take
> look to confirm?

Apologies for the long delay replying. I have looked it over and I have
no objections on the hook, it looks good to me. I would prefer if we
got a reply from John as well since I'm not 100% confident but he
should be out this week. In any case,

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

Thanks and sorry again for the long time to reply.

