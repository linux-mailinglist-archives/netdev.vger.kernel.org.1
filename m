Return-Path: <netdev+bounces-269136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHdyK7PYumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B12BFAF5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21524306EB3D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9329B8CF;
	Wed, 18 Mar 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MGKHeso4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7D2D640D
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852235; cv=pass; b=l5wo5wwv7chRF3Ye6NRWPy6Gy/xjYC9Lvx9vL3jLno6EXZZs9y3sGHK020ckJhWxnC4gmr43nQt9BP6mJTQWe0yU6egKuTwEilnPfcMcTpnj6FWQgPGCYuim3NW8hpQMb77ECXwyxJFX9gdMtxAa3LFWSeE2m//yYlkRErJmKxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852235; c=relaxed/simple;
	bh=zXZxPJ1K3LCBhZiouT+2oJJTTv9xMqRYKfOSsTOtYD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZtYFoRNRLS4tcDIt9ICoGN2Zx7oQ98guv6IGw1fsNvcrCutZuruDWcH6EcEOgsiBCI/ZNP/AxFOGLeXhVQ9W1xv8CWiy8FgcndMCv61qqkSQUsylanbaMpheIjPjuQsyR1aKBN3V4LsbIwWxps7y5iJIyc/LmN4JzT+rSAcsOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MGKHeso4; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b04e6a989eso29025ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852233; cv=none;
        d=google.com; s=arc-20240605;
        b=HPCNKU89SVQvBNXJI4PKE2+up1INMQmuLnX8rzWMQHa3bqQ3+ysDmilbG9ebbJ03Cg
         7iIiwX7MGFHQX3C1ILtVQewmO0yMRqR3RUoHwy2cdSBeWF9jTFMkOkZ1HECL7VfCQ4VT
         RAmk1Tsu64SM/VeJZ+i+jlb69iv3H1wDkwZGCXjhHsmZ9tyZPB0I3xl3x47oQguAmOMo
         tAgm8YgpanJl7Q4enQh0bG7dHNE2eNKr/CesDVUbIYwg0Kg9ngCTTwY8mJan0/1QFPrf
         HDlHX91cNP+v5+fGilzX8RWopz7DoBNmnmhwTLdGGnXWf98tVqq54X16+J9tw8Fb21wG
         zP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        fh=KabuQ+jxCmlAyIDwUrccON6CILxShqNSp2Lshhvu5O8=;
        b=ArBqCInQOlkuiRT76OATrjC3d9Z7j8ucdNIn6/NhvNuOCbGEj1rkv4IpUZubsGy+u0
         8RjxmuMEJ/fWhwK5jE2yIQqrmIkVO3rGJ1ijkZWPFBSxSJfJ1eBTeSw3Emhz56iy8TAH
         YhjD3Ye8e81RNBaxD+ZgRt/mp2/jdVqUNkOzUeeUuLzTSGVJYg77x9oUBJfIlseKPHk7
         /S7zQDJ4QXq/L3R4D0LkwwVyVcdqbTQvkMxRCE9LDTMD9V3AkUFb6uRzvWKP/AWrgzxV
         gZYrpxhAAGt4svHpLzGqiHlONRsgV1H7RR1C56kibU76kYDL0JxDdpzGMIoUoqOQ8n97
         lreg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773852233; x=1774457033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        b=MGKHeso4Go86WhfyQXTWVzMbre9lUF5Omn2JSNl2Zc6jckdauZ6Uth9AxGK2jYQuZf
         DiPMHwZOmk+jtgS+c1QbHRov7/nqdkzMuLdLmZNK40//FiHdnOpAnJgfZFSTBo/caq7/
         zgVmEk7aeily+NtFAOx8ypbuQ8/0qZrHE1k+GUILQ+YAsTrNPZT87ci5fAp+gXHTk+94
         QZmHV0BUuuk0Tqumx9bbHhlu8ihYLq92FLCrzQu3jn7C/IBNlOrSl0U1sy9QvZYwnPsM
         P5hgALjH8aEBaAY2KI5+M4dewDvpB8pskMkmwkcqv6NwIHbixLpCVk6GQ+LMSmIRHZdT
         t6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852233; x=1774457033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        b=D1UbBqBL52zt4A2fQ2UhHbb3QHMFIwWmfVtIg+x2IU2iwHKO2MpGp+hKdckvDrtCCZ
         DU5QCpX1df3KA8VjLROblGWAz55RvrmE3Rh1528BhV4ZxqMcuYz1Zwgf3l+fJxr2XJY+
         7/bXT09iA6TJMmG7xbN85Licbe48p+oUZ+pQdYStY2w0aeXra+jrE4L/kkVQqvMKIHlb
         9Qgz/3FgZvDkyIpRZZI2wO1coWgpJr9cdZVzpOa/BiHdMxOdws5QAbjHO/5c+CBrGlg6
         5zLv+2olFztqGNQwwYTz+cDhdcabDoa9sV6WsJwvrtNEK4wRE61fz/Xm1NrIYBoZKEMa
         LqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkbqhiqrxRbQ2iS2vyIxB5EYXy4bcVt/7AFCzq60NhNoGH3KBmnq0q8nSRkK2TynkfShl/6r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytN8aFncI4FPjvH9i+Iuiay6BQ1I8/LiNyknYiI4hRKetK78zC
	JvSSTk1BBnv8pYIkzybQpjRAgU4/mXWw+oqMaiP5xm6q+sOrLZYXNIVS8ACOJeTgwP2QjB53xpf
	cM/qeRkZ3JbHuVSN3p5Fx4l2DErpbfJwX+qQ2pt9v
X-Gm-Gg: ATEYQzzCDnyJf5cU9IF1hhY+k8l2r3+HTsaeOcvdSu79UX1cDe6tmis/Zl0qr+b//41
	aN1g0v/Tj1mzD5hxnUa18POqmbUIjWLBRq/1rzWHwYyzF+q7JSlQgihxxCPCqq5KXvvwZ649ykE
	OcSBIo1C2893wwh1UQzSgzKFOYNIM0OsvdpgtWD/aSj9HKtSUEu0UE0lSrNosBu5BqDI+u3H2oY
	V+t5GnPAyNplAzJ8ZfZUM28ZgLAH4wKcKF3UbsFvY5FwZIqvUFEI4i2HFHExr6V6XiqxDnkX7zb
	gle1GzIJp0NkWaRZ6Q==
X-Received: by 2002:a17:903:8d0:b0:2b0:6cb5:c6c5 with SMTP id
 d9443c01a7336-2b06e40be78mr48856105ad.49.1773852233544; Wed, 18 Mar 2026
 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net> <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
 <20260318.wa0eef4tei6I@digikod.net>
In-Reply-To: <20260318.wa0eef4tei6I@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 12:43:41 -0400
X-Gm-Features: AaiRm52R-QUl_6FyQWVZwfUo3fZbrNzCqZ0wswhLxEPTednSfNTcmKYhFSB11MY
Message-ID: <CAHC9VhTkJ9s6SE2Hhg+zpg9R1-WF71e5HNJPENAc6krBCCyaRQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[canonical.com,gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,maowtm.org:email,digikod.net:email]
X-Rspamd-Queue-Id: 748B12BFAF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:22=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Wed, Mar 18, 2026 at 10:44:26AM -0400, Paul Moore wrote:
> > On Wed, Mar 18, 2026 at 4:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3=
000@gmail.com> wrote:
> > > > >
> > > > > Add a LSM hook security_unix_find.
> > > > >
> > > > > This hook is called to check the path of a named unix socket befo=
re a
> > > > > connection is initiated. The peer socket may be inspected as well=
.
> > > > >
> > > > > Why existing hooks are unsuitable:
> > > > >
> > > > > Existing socket hooks, security_unix_stream_connect(),
> > > > > security_unix_may_send(), and security_socket_connect() don't pro=
vide
> > > > > TOCTOU-free / namespace independent access to the paths of socket=
s.
> > > > >
> > > > > (1) We cannot resolve the path from the struct sockaddr in existi=
ng hooks.
> > > > > This requires another path lookup. A change in the path between t=
he
> > > > > two lookups will cause a TOCTOU bug.
> > > > >
> > > > > (2) We cannot use the struct path from the listening socket, beca=
use it
> > > > > may be bound to a path in a different namespace than the caller,
> > > > > resulting in a path that cannot be referenced at policy creation =
time.
> > > > >
> > > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > > >  include/linux/security.h      | 11 +++++++++++
> > > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > > >  security/security.c           | 20 ++++++++++++++++++++
> > > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > > >
> > > > Some really minor nitpicky things (below), but nothing critical.
> > > > However, as we discussed, I would like to see the AppArmor folks co=
mment
> > > > on the new hook before we merge anything as I know they have an int=
erest
> > > > here.
> > >
> > > John, Georgia, we've been discussing this new hook for a few months n=
ow
> > > but didn't hear from you yet.  We plan to merge this patch series wit=
h
> > > the 7.1 merge window (in a few weeks), so before that I'd like to mer=
ge
> > > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > > this hook will work well with AppArmor too, but could you please take
> > > look to confirm?
> >
> > I probably wasn't as clear as I should have been, my apologies.  The
> > major reason I held back my ACK on this patch was that I wanted to
> > hear from the AA folks regarding the hook's suitability for their
> > needs.  While I don't expect they will have an issue with this hook
> > as-is, they have expressed interest in the hook, and I would just
> > assume make sure it is okay for everyone before we send it to Linus.
> >
> > Since this is a feature addition and not a critical bug fix, I will be
> > quite upset if this is sent to Linus without review by the AA
> > developers and my ACK.
>
> I definitely understand and that makes sense, but even if it is not a
> strict fix, please consider that this feature still fixes an important
> gap in practice (e.g. run anything outside a sandbox with the help of
> systemd; see cover letter and reported issues [1]).  I don't want to
> bypass anyone, but given the importance of this change, I don't want to
> postpone it either (except if there is a major issue of course, but I
> think the review was pretty good).

I understand the desire to close the gap, but as this is a known
limitation of the existing Landlock implementation, I don't think this
is a MUST (in the RFC sense) for the next merge window.  It's
definitely a want, and a *very* nice to have, but if they AA folks
need some more time to sort things out after what has happened
recently I think we can afford them that in this case.

> That's why we'd like to get some
> feedback sooner than later.  While waiting for AA folks feedback, would
> you still be OK for me to push it to -next to improve test and review
> coverage?

That's fine, my comment about "sent to Linus" was deliberate.  Feel
free to do what is appropriate to gather additional testing.

--=20
paul-moore.com

