Return-Path: <netdev+bounces-292694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGrAKT5FGGr5iAgAu9opvQ
	(envelope-from <netdev+bounces-292694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:38:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD45F2D92
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2256D307F51A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3A3E8688;
	Thu, 28 May 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba37RqWL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNndeiZQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832F3E5A18
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975134; cv=none; b=h//cYBuSHN69349Rn7uM0/bo5N4KKbRLmoJzTPurzvG0g9ZlSb8U/aRQcYPysiJR3keuzKVM+YexoxRCflrDRwrNbycPSG7cWm/3lfBDRB/IbSdbhU7cr9hTAmW6drEgL8JoRq0jtZo9P6gaxK+1xiCRdFBwGrBQkltXLL2cg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975134; c=relaxed/simple;
	bh=vPU45GJtVWhMcvje9QDFhnwGgFdKM2fePKG3Kcsn2hU=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=V9Inx4t+TguOPTFB+IKrjutp8CRrHorXq6znfuoqJOHPkPyPhV0mm9wkccKtyzXvcSWL5fQmqgGbvLp469pE6dnm7EtIs1p3wlQqnym4BNIqNtFTgSCpQS45iZi0brTixVZOG2Co0tKefWv7BpizvhQ077W8lvmzZwjKthxpsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba37RqWL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNndeiZQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779975132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPU45GJtVWhMcvje9QDFhnwGgFdKM2fePKG3Kcsn2hU=;
	b=ba37RqWLieoMxxR4ukeVtOHg1zbapMHLa++S9nXV1W5HlzBHRK3IaY3H9enCjzpoeTtWXd
	KROvvvBjN0JZo712slI5sy+IjyhCwRq4yuvm1MWhQMK0M/rTGsDmUmJMi2Z9JFBvB05xFh
	rZ3/drzr1CazkmcOJZ/wODMi9HErQj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-_9GnWynYPDq7Ie1MiPYS2g-1; Thu, 28 May 2026 09:32:10 -0400
X-MC-Unique: _9GnWynYPDq7Ie1MiPYS2g-1
X-Mimecast-MFC-AGG-ID: _9GnWynYPDq7Ie1MiPYS2g_1779975129
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49051422d55so59360195e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779975129; x=1780579929; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPU45GJtVWhMcvje9QDFhnwGgFdKM2fePKG3Kcsn2hU=;
        b=PNndeiZQjuonHalpdngY/MQzKjJ7RkE2MJ7xhOnFoH8ESZmarWehU/vfSfyoNOkxw/
         L+FyznCWFaymIrg8Vsz1NtfiFbXud5vtnwaaht93nDrkuZwXwtAbfjoqyT80BHZLpyPN
         TJ5wMte8G/uzs4MPr9xyokzoWpYVvukz0cCAlllWB3Ard459phJm1krBuJvQ/RQ/ThjC
         WREwVInWcClB1VpRyHIaCEq1p37ChxDokZw+hIpJbP0ocAqPkqxsciKs3Vn27wcjYOhP
         L0+RmyHvvm5wtchjRMYHUqPCC1pmVsrDPSUK+vmHemR6zXgWfiEsEVnWvXZyylaFSPCs
         Q8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975129; x=1780579929;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPU45GJtVWhMcvje9QDFhnwGgFdKM2fePKG3Kcsn2hU=;
        b=HLIBc/S6x/aL1296eAKMTKz+Ke3F9VQsudQ1ErPED4EMY8n5DGZbU/oOp/bOOfHaLC
         Vp15QrvSc5sDRy1qwBtXtFjRao8PRpZtwNuPzprRRxoemXle9ruD5FeblbWWrihVDdMj
         oIRDW3179f9gi503V6y6AqSTr2k8gOw0Eyclh3TwgTIf5r4KFxfex/n27CbccNqwTuHn
         t8CiRaUBs9wrGXT9+8HTZbWaImqt0DE4LIki//MwZzcWRAZBVOzL/6PTAdRyvBWfUQxr
         ei88nF+s99TWriQJPQ4mqV4GuCnwuHX/SK17sAA8mFilJS6ALsT3mTiSQxYgwAZQrMxu
         NL6w==
X-Forwarded-Encrypted: i=1; AFNElJ/A+rYEqVwIh0rfFKdOlKmZ5PbCLGSCHY+R7dSR3XTqQf3VNtQwY1oub9OS7i1evLj1pvMPUAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGr18b3NPtms3moLELef80F0OQLdOydpWzMmIaPow2WeO8M6rj
	lh+n+gojJ1HcdpY12BkgDhAyejSQQbUvB8pCsEod4nqDezdsbJNSkDD0XqZ3u9KG+y0eU1nrvqg
	nV5Z9brM5DjgWTB2gPftk/plarkgwPOMawev4TrSWP5bX9ftyNnN10zJikw==
X-Gm-Gg: Acq92OGNbSLkwXytPpTj0FQPgxqLfZ0qPqDCbZd/E12148m0l12P8+mxIxJPZg+Vf+N
	QLCGwgQyDDZWOLKs/RoPqISkpD1115f99KcoEiMSu9up5U9iJU5OprX2d/elRSFV37F64ZhWX10
	oxVmtVExeGbswAvUqVoIHdmbUkvwhCKvO338tXBsBOQDdemQVnL0ewIFxA4WZt0lYBbGvnbEMQ6
	m717PAh7rAMOOH1z8Ijaa8M8wzwx7dLcm/XXkVRcO804Kj2+JjK74P79iqj2O6tIaZldJUkum8q
	1pNZz10eDSxQTHZSg+HZG+LePkEXc4NK1fLc6rNqCYNJo8hTaTz24pX+yrc+9GMd3AZoUW57VhG
	mMG/FwfqD18f4peDJ0bTpCf/y92/EzHk7zdYPX7afeIhUNxGxyl6U4YVtccqB
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490426bc737mr501349855e9.19.1779975129020;
        Thu, 28 May 2026 06:32:09 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490426bc737mr501349195e9.19.1779975128387;
        Thu, 28 May 2026 06:32:08 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0980d7sm15200665e9.28.2026.05.28.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:32:07 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, ihuguet@redhat.com, Linux kernel regressions
 list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528153202.14900687@elisabeth>
In-Reply-To: <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
	<20260528131250.1352ab48@elisabeth>
	<b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
	<bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 15:32:06 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292694-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leemhuis.info:email]
X-Rspamd-Queue-Id: 0ACD45F2D92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 14:29:50 +0200
Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> On 5/28/26 13:29, Fernando Fernandez Mancera wrote:
> > On 5/28/26 1:12 PM, Stefano Brivio wrote: =20
> >> On Thu, 28 May 2026 12:46:05 +0200
> >> Fernando Fernandez Mancera <fmancera@suse.de> wrote: =20
> >>> On 5/28/26 7:38 AM, Stefano Brivio wrote: =20
> > =20
> >> - regardless of this, would there be a way to make NetworkManager
> >> =C2=A0=C2=A0 robust to the order?
> >>
> >> =C2=A0=C2=A0 I'm asking this because yes, strictly speaking, you might=
 say this
> >> =C2=A0=C2=A0 change breaks userspace (NetworkManager), but at the same=
 time it
> >> =C2=A0=C2=A0 fixes another part of it (pasta), and changing it back wo=
uld break
> >> =C2=A0=C2=A0 pasta again (in a way we can't really fix). =20
> >
> > Ugh, that is a mess. =20
>=20
> Well, yes, but one that happens regularly. :-D
>=20
> The problem here is that it was reported only some months after the
> culprit landed, as fixing the regression through a revert or so could
> now cause a bigger regression. Do we assume this to be the case here?

Not a bigger regression, but a regression definitely, even just for 'ip
address' or 'ip address showdump' which would now go back to display
/ save addresses in the reversed order for IPv6 (only).

> It
> sounds like pasta would "only" be broken about as much as it was before
> -- then a revert or something like that is the right solution to get
> back to the status quo. Or does pasta already depend on the new behavior
> somehow and would now break even more if we reverted the culprit?

It doesn't specifically depend on it. There might be users depending on
it because, if they choose to copy container addresses from the host,
they will be reversed, and also picked by the kernel in the reversed
order (if all other criteria based on scope and prefix length are the
same).

The likelihood of that breaking setups should be relatively small. It's
just not zero so if we had another sane option to keep this "fixed" I
would probably prefer that.

> Then it's really a mess. :-/

I guess not so much, it shouldn't be a drama for pasta and containers.

But then again if we revert this, how do we fix the issue later,
without resorting to any of the ugly things below?

> But there are ways to fix even this, it's just that most of them are
> ugly. Like adding some bit somewhere to /proc/ or so that a fixed
> NetworkManager (if it's the only affected app) could flip by default to
> change the things from the old behavior to the new one; and one pasta
> could check that bit and warn. Config options are also an option, but
> that's even uglier.

Actually, an eventually fixed version of NetworkManager doesn't need to
know the behaviour of the kernel: it can just order addresses by
timestamps instead, as Fernando mentioned.

And I'm not sure how relevant this is, but if we revert the fix,
current combinations of NetworkManager / kernel versions would be
anyway affected.

So at this point the only robust / complete fix would be changing
NetworkManager to sort addresses as needed. Are you suggesting that we
should anyway try to minimise the temporal impact of this with a revert?

> >> =C2=A0=C2=A0 Now, I suppose NetworkManager is much more universally us=
ed and it's
> >> =C2=A0=C2=A0 definitely a more mature project so it's a bigger userspa=
ce breakage,
> >> =C2=A0=C2=A0 but at the same time it's a ton of containers (Podman use=
s pasta by
> >> =C2=A0=C2=A0 default, Docker/moby optionally via rootlesskit) we might=
 introduce a
> >> =C2=A0=C2=A0 regression for. =20
> >=20
> > I think the main argument here is: while we know it is affecting
> > NetworkManager, we cannot know if it is breaking something else. The
> > kernel rule is usually "do not break userspace" and this is likely
> > considered a regression from my understanding. Cc'ing Thorsten as he is
> > an expert on regressions. =20
>=20
> From the mail at the top of the thread it definitely sounds like one.

--=20
Stefano


