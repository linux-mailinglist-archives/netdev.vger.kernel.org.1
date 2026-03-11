Return-Path: <netdev+bounces-266694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGueMgSVsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:15:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5078A26726E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E13F43235672
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B631E85D;
	Wed, 11 Mar 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e6c+ElXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4003B47E5
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245339; cv=pass; b=NFB9r0YRP9MsUpybIAo9GkpnfgAjF4YL3xs7dqTVOGK28GSEdJKNp+WVuxgJO0ybbfPUXG847e5HC2FJrQSQDs+eT005lZrdw2OCMF3w9Z5tShs0DtT37Ca7nm1FXLXjY6aWuntpwrL9F1KiJk7wf1kRbobPWRyFdw0OD1Isy8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245339; c=relaxed/simple;
	bh=owVe3Qfob2UO8yuqdH2PqAC+rPmSIbbd71zfyNJWtfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5mqwrkCTqhQKgCsOcEDVIcnBjpEpSSBLnoNOyl6sDHwb2ao+7R8xk1Ol4++tkpjEI5YGd6Y8G/PLNe4UoNFk8eZxlafO9znUtdQ9R0tpn6ixtO/XbD4qNBeb9x8ZX+C0E5BVZvsXDg24bcJBAWbae/+cM6uDR0szmSJs9ugwrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e6c+ElXV; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-359ff894f0dso507151a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245337; cv=none;
        d=google.com; s=arc-20240605;
        b=I8PJzy8kV1NlCv5OejS90Jhg7iiUaBq3DiSiKNfF4q02fM4SKwrckKBL74vCmLklBA
         Eog+8PnJ4UaC+T+hkrHi7EGgik4FBu2gg84ivsibzYeMtSc1xHNVeggG+zZ12ppXDtAJ
         5nj9mDXxcEyLog4UzPQPZDMkcaRI0cCf8XYqAAl7G8m/rZExgbeQ5+ZFR2GjtQc8bbL6
         kOqdFIy05FLZkbpvHnTMuNbfqvIjdHtju3Ur8lNWbjn/PJl1D2YGSDE3v0P6oMvebid2
         meSVMiaa5itPMga7tLIzzUOjkujU2hjBID7IlNILp9HvMFneAqnxqIrVhr/PlDIsD1x8
         rltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        fh=4AxJWIgipTw7LuZGFEvcVW2jhf3Ab/8G87BztoUcL9A=;
        b=Mculw4yjPb/n9p9VVJ5eyxHcnMJ7mKqxJA/MzwMzxG1wM4p7ViOKE0PdJlfTzJNsWX
         WU2sjCcKt4FfxpkyGU9jRJ17jatTPjCGhlvbeDSgDuxrc9EsxbBGdJuBVXCmidqVrb8+
         IwiReox06uHllKIdG603v7mYLBbYTGqf99AnJdGYLntmPLyzTSa/ld0H/pMCbFJJsR2w
         Nbt1amRzNirpsjpmpUjEoXyPSY2ctGBUUE7dRCXM3sv6nWxgoMRZ9kQ8weA9aR5QxD2M
         Jd+SPPjYGC56VDANc3NXmZTkBCQlqu9aNsuo8eeHw8lgiZATpJDoKxCcjW7EE51DncwT
         REqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773245337; x=1773850137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        b=e6c+ElXV9/S8dBAt4s3Y0Qdq9+tZ8d5cWILHAnHHImVT5PIIkJUyCZiacq7jRwg0wO
         3Cebb97OPazwIb6fjRP+vY3CtMSNoYR2RIKBrDAwtxeicH+/z2rbTPh7Os6MuY5k4bsk
         ma028J0ookNSr0KijANIvgZg9rIgryyaHdtXthB65JBFV5watPKOGnOo8nJM04Fvkhcu
         1sUQwoIi9bTkdmnd5BJfx1eZGuBrZjPCVZAWLHDskfYdbIiO+mBd3Ciep3WaOeYu4bZ3
         AOcYAN3ypG4b0iCneKQdTkcp00UtTnkzuS2zWuf4D3tjbFYHt0mKsjvS4pJXtGlYQIpi
         h/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245337; x=1773850137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        b=qGrHVygxYaeN5qVSHXf9nzEhJKLHFkMbwazz2KX7X8jP1L3LACG/yvc9Ij8Y0ekYei
         XoVYHX4ewn5e6Yx8kN6fCjeWCUjcispBuSWOl4Q5z+gaQfZVEZPpMrir0vB7Jkw8WR28
         fw4odk2JfVhNn79jtdqPB89iWEp/I/zVZ0U0HGaqy9Qr59I/M0B4wsn7/t7TrimIw025
         FoJqjlvdYHXjtMbjuh5GAnU5RrcqMDWihuemkYh2mdmP1T6oB5swg+BuiYqYP+0bUUiK
         9tKmE0bmC2LyNWP9dyJHyX3Ydvxai3+2tI+0EPSPimsP2id0ZjC4TiKBjj+1kdVOHaM4
         WK/A==
X-Forwarded-Encrypted: i=1; AJvYcCUwu+rYUdz/fOrZ4T2qyX1xzvvCD2ZGrXRugCg4RVPeky50PwA5labYfdiPm2CHFonyXTQCDmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJN6/w4whP6Z16VIrzynoVDL6C4YFjDsFuWW+DthE31F+5A5fT
	yujmdkTJuhX9SdTm5SitrRc14iemd1j474MZYR7wdDUxS84lNX0Qz0PFJb8KCQmxcIr+++tHGnD
	YWML9AxYn0wUQUDhwlIr4zauatxP7QaW9GhnFNAlT
X-Gm-Gg: ATEYQzz64Y2mr6iNcP5dEsxLCLFN34ogJf/ow/B3t//2CfA/ngZIeHiS0giUUvmCUSX
	/Ta9FiT5Zr6/Gqks4E4Vl0/29Gzw6Iyr8PQMR5cOHScBNHx649+UXKGitD6v0YE9NaJQJCOeO1g
	TuyVvE5ECrJd5wbPq/liZduF4zcZs2hFRmigYnn0OuB9fyE934BareFujeBh3Jp5f0BWLOMYMAs
	ivv4Z9YSDTNQQ2ofrcuncm3ZylaxC1jcUCv+uCHm2D/UWcph/Z8wUVUfoHiuoKRGxowr/gjfg2X
	isor/wo=
X-Received: by 2002:a17:903:3d05:b0:2ae:3d7d:d905 with SMTP id
 d9443c01a7336-2aeae81490amr32213615ad.23.1773245337226; Wed, 11 Mar 2026
 09:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZcPd3OKqxwCZV-5@suesslenovo> <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org> <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
 <abFhawSTjNoa-KaH@suesslenovo>
In-Reply-To: <abFhawSTjNoa-KaH@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Mar 2026 12:08:43 -0400
X-Gm-Features: AaiRm51y1oanFGZp0hATWZweBML1M22bqKd3H2ES5tayYiLT9l2hp1VRACvAC4Q
Message-ID: <CAHC9VhSA=jaKTXg-Tmzzpaj9STGMXH3ZMgQm_XvicimRqdW0+w@mail.gmail.com>
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, brauner@kernel.org, 
	demiobenour@gmail.com, fahimitahera@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org, m@maowtm.org, matthieu@buffet.re, 
	mic@digikod.net, netdev@vger.kernel.org, samasth.norway.ananda@oracle.com, 
	serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,oracle.com,hallyn.com,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maowtm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:dkim,paul-moore.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5078A26726E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 8:34=E2=80=AFAM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> On Tue, Mar 10, 2026 at 06:39:12PM -0400, Paul Moore wrote:
> > On Thu, Feb 19, 2026 at 3:26=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@=
gmail.com> wrote:
> > > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provi=
de
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing=
 hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, becaus=
e it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation ti=
me.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >
> > ...
> >
> > > Reviewed-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > >
> > > Thank you, this looks good. I'll include it in the next version of th=
e
> > > Unix connect patch set again.
> >
> > I'm looking for this patchset to review/ACK the new hook in context,
> > but I'm not seeing it in my inbox or lore.  Did I simply miss the
> > patchset or is it still a work in progress?  No worries if it hasn't
> > been posted yet, I just wanted to make sure I wasn't holding this up
> > any more than I already may have :)
>
> Good Morning Paul,
>
> Can't speak to the rest of the patch, but I sent this LSM hook for
> review purposes before inclusion with the rest of the V6 of this patch.
>
> G=C3=BCnther added his review tag, but I was asked to make some minor com=
ment / commit
> message updates. I sent the same patch, with updated comments/commit to h=
im
> in a follow up, off-list email to avoid spamming the list. No code change=
s were
> made, just comments.
>
> I don't think this particular patch will change substantially, unless we =
find
> something unexpected. But the way we use the hook may change (esp wrt to
> locking and the SOCK_DEAD state), which is important for your review.
>
> So you may want to hold off your review until the full V6 series gets sen=
t so
> you can review the hook in context. There were some questions about
> locking that needed proper digging into. [1]

Great, thanks for the update, that was helpful.  As you recommend,
I'll hold off on reviewing this further until we have the full context
of the other patchset; we've already talked about this hook addition a
few times anyway, and based on a quick look yesterday, nothing
particularly evil jumped out at me.

--=20
paul-moore.com

