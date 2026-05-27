Return-Path: <netdev+bounces-292436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFCZELZHF2qS/QcAu9opvQ
	(envelope-from <netdev+bounces-292436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B965E990F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1BF4307F4B2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355738AC9E;
	Wed, 27 May 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CorZZmB2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqTYWp3K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CD389DF0
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910518; cv=pass; b=nS5+xtHvY+fi16wYCnTyp4pWSNg4kVFQeFWnDhw8XedEURo5DIZqTR3q5cd9bO0BUrXGCFgc6IkoD2B8bx/sdU5ltLLH2Uf8BOHPgZldPbyovxP1PtKDls4eYMGHDJEL2LWU+7Uz2ETPu9KLQ+nRlZon1dPeWCazqwtxN8rkvUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910518; c=relaxed/simple;
	bh=UioVoqnLSFh+ScDWF0CUCSjlPvyH3Iqmx7+g1G8fJI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNBbU36/SwlSgDYWeAol8apSIiD2DMwi/VUBiZGac72rWkD/mSuN8J8Xqyof+OmaCeGZuRWyrM8KMZ2u+hJjuYYqu1bHh8icjkumtZsAUllezCBD9VhsC/CumulaL60l1BA17d7Ombnsz+TJwiEfMEmzTsvgKR0OzpgzVRRDAXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CorZZmB2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqTYWp3K; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
	b=CorZZmB2cujnSNi6v8cyj2AL7Y2rwkwI2p3lF26sX9BxL1REBgEvgjNh+VNcfD/kilZBWv
	62lE76e5+YTXZ1H5IXb3wiKe7NGN4xUcsMGvn3sxL51HhwLFp+B95r1W6oh8RCP0IwFGzo
	hKTi25PKK0ZOx1egtLgkf+Tb33eZvto=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-AU3GhJ-JNn-GKP82NyZuZg-1; Wed, 27 May 2026 15:35:02 -0400
X-MC-Unique: AU3GhJ-JNn-GKP82NyZuZg-1
X-Mimecast-MFC-AGG-ID: AU3GhJ-JNn-GKP82NyZuZg_1779910501
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bdad545342aso274687466b.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779910501; cv=none;
        d=google.com; s=arc-20240605;
        b=XibxRlWGEs18WwhhqJbmwJbHYK9/4PNug5uCFGGJedPgYz8TwG1ED9wp/6GAE3bIJE
         gJsNRylS5wJezZUXX6/kXRFf5pX7m1j5NN9wcDQKw1C2oJE/YnHmIsCWhOMeN8NsFcGP
         lHAs7isOEj9P49u0bjpYYnNjrkgxAHizsop5j8XL4eAjNoggz+2xWizWdLQXjN0Zw7NS
         GrCtoz4TvChvX13dbFtyzc3b7yDHlS1MEm1fLOGtyFl8ETNViWHpA8t3bkWDrfyU2OyW
         oD6iLjh+4TFDECgGPIwR4PFAxTwlfNGj2wm9ksxMLWvMb0bmrGSdpKX2IlG+iyc9YAgS
         E9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
        fh=ZYdmskVbz8XQjE/yZbllkM39RwYNySgYuzEttdpWtvI=;
        b=TrESq986RyE3glWs+degs+21WJ/VAD3UZptguXJIMVkAMwb81glb2S6ALlFEqX0Yus
         rn99lpDJpmvU5qD/V4GpTcPVQDXhfJac2D0Wy5cI0aoqwbKyEBbkVubVHFeVEX6gimCr
         ndWh4yi5Qvgd4jRhj32t1S+LoFYGzeQpok4Qoe4mInaCOXu0fKUsKARn6rOzL3UPS4mf
         mEutlWbDUSvdSj7n0iYAtc9+C23AtFsQa4zCRaBw+ZFG3G5STj4ML4+DHRQSK+eou1cT
         te5OLwdk8y6fgZL2ka4YhTyu6m0RVVvmDaWD0CMDcr/Cok6S+arkqUsC0yn3LN1sTuzw
         IUAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779910501; x=1780515301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
        b=bqTYWp3KAOexqkL04Tri5jSW4iRtM1E4wXLApk7oelTmWrqFpY5Iz2azwH/WYllRJr
         m4ZT6HjWKwgpBCG49YPuKClSV8ndo3qWc7iR3SmwM8kj8qNRDmiYJPZpnBWy1vxjk7VL
         ch2n2sKwKJHIQrUVQW8M86EibOFAOSCY21BCAwo17eMSCgzqL6YFirLZFPTXUjQSjDtR
         yEGRQ4NwdxywKcG9clPkILRziqKXQ0OxtK/6LvtjNcqjYzV0UaPJ6v+2WUPo9qRYdFtL
         tpIKYckwSy2sQ6byLceSET38pblP9RUpU88btF6nfeHHsdGjv8Hf7gIXhqt7+wXaEFmE
         UOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910501; x=1780515301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
        b=pNbLnjWuErwlopyom9/eHSItKEQk0SxsGjlbLYf2VLMhPI9BsGrBf/1F6edso4jQjr
         i/pYvj+etK3ay+KqIrSF2Jyc2upj1UkVjZ1Cwo3TV32k/a+uYWRqM83V3tHx4cG1q6+A
         k53iue0q1iv34LMCX1G6TJElFlDiaOxTz243z7itV8fKkAQVA05P4FOgCq6cd0r5X3Sw
         1UjU36WJ9B3ezMo3VgLBA4115AISc7UcKN7RBpVHiUhqQmq2J3yj+uTqQzxpQaJacViN
         IZDnPrj+38NR8UCjwY/B+UL0aqBca9/h7V3WDjTGemZIcw4qEeIhrBIcEjDT10Krvi0W
         V0Vw==
X-Forwarded-Encrypted: i=1; AFNElJ875rgarsWQKlZKLFe4zsI5glmW8g/fvGVgJ4NLhGvbBySKgVDRdkM0InwWoQg7jbgz8Pj+P6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuZO3rG3IdbsMc2cGtKMR7ywl9bCPCK7otP+z3DuKeeI4GCY+
	OcGOkfS5U8HNt/hbARP+1skN2MjLXZlOB/cYR/F8Y+3rmIDHII9PbMA5fZBHOpPLl644EjTTK4c
	+pAy7qtdbFg0/W9gwOK11dznGKM4pN7xp66miXMoQB5OldKnh45IeaPdZ1G9jpU9/B+H/hiknob
	aG5UiG6qvpFLtY0ndsUkPfSTKxbFdRszi2
X-Gm-Gg: Acq92OH+1n1fktaWiKvsPBVdCEede6oidk1H25/4tHcqjIhK2EmZcK04F5mokjVrkeE
	7an/veYpR2FRfPZaeH6m/NAQRE8fY60xgAbk0PNmEg1fOsgjw4H+uYI9hYSFRWuZKCKAbU8+3Jl
	/1zxSE5aJRN1AIgOQRt3DOFvVISBv59UnuExZzKSkwq+Lz0DPHC+VBdtyzkNyIlen6xax1jHBgm
	U3z39z/ZNMt+TQBVgEb6+BoJnQX0StqoTjb05A6p/w3kuUEkwBSq69aEIjGKYL5jIHFSGNq4ftK
	8zE6ywiLaursaKIx+0aJGiAH2wLe9Ea1ib8=
X-Received: by 2002:a17:907:7848:b0:be2:d66:eb4d with SMTP id a640c23a62f3a-be20d66fad5mr604749066b.44.1779910500770;
        Wed, 27 May 2026 12:35:00 -0700 (PDT)
X-Received: by 2002:a17:907:7848:b0:be2:d66:eb4d with SMTP id
 a640c23a62f3a-be20d66fad5mr604747366b.44.1779910500315; Wed, 27 May 2026
 12:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
 <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
In-Reply-To: <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:34:48 -0300
X-Gm-Features: AVHnY4Kc83ebKqVSHeiSfUT51upa2HdihkVQbYI9amS-pNOG_aGc7MyxSSH-1ZY
Message-ID: <CAABTaaAO6_OB0EBpttCgo+pDjip8BbpX6CQa1-f+_Ywrgem0-g@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Paul Moore <paul@paul-moore.com>
Cc: Jakub Kicinski <kuba@kernel.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, eparis@redhat.com, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292436-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paul-moore.com:url,paul-moore.com:email]
X-Rspamd-Queue-Id: B0B965E990F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, May 18, 2026 at 8:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks =
on
> > > the netlink socket.
> >
> > Holding socket lock during slow IO sounds very wrong. One could say -
> > that's abuse of the socket lock?
>
> It's no different than any other kernel subsystem sending netlink
> packets to userspace, although in some configurations the rate at
> which audit sends netlink traffic is likely much higher than the
> majority of netlink users.
>
> Arguably, audit probably never should have used netlink, but that
> decision happened a long time ago and there were other issues
> complicating the decision.
>
> > > If the wait timeout fully expires (timeo =3D=3D 0),
> > > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > > request. It then triggers netlink_overrun that drops the event,
> > > completely bypassing the audit subsystem's internal retry queue, and
> > > falsely returns ENOBUFS to user-space, resulting in the following err=
or:
> > >
> > >  auditd[]: Error receiving audit netlink packet (No buffer space avai=
lable)
> > >
> > > Fix this by detecting when a blocking sender's timeout has expired
> > > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, ins=
tead
> > > of retrying with timeo=3D0 (which would incorrectly trigger netlink_o=
verrun
> > > on the next iteration), safely free the skb and return -EAGAIN, allow=
ing
> > > the audit subsystem to gracefully enqueue the pending event into its
> > > internal backlog.
> >
> > The socket _is_ the queue, normally.
>
> There is a joke in there about audit and "normal", but I'll leave that
> as an exercise for the reader.  I will say that audit has a lot of
> unique requirements regarding queue management and that dictates a lot
> of the wacky stuff audit has to do with it's record queue; the
> standard socket buffer functionality doesn't have everything, and I
> wouldn't want to ask for it to be augmented in a way that satisfies
> audit.
>
> > Please explore fixing this in audit?
>
> Ricardo, I was kinda hoping not to have to do this in audit, but I
> think you can probably get away with just open-coding
> netlink_unicast() in audit and then going from there ... we might want
> to do some other things differently, but let's see what a basic patch
> looks like before we spend a lot time redesigning it.
>
> --
> paul-moore.com
>

Hi Paul,

Thank you for your input here, I appreciate it.

Before pursuing the open-coding approach, I wanted to let you know I have
a v3 patch [1] ready that addresses the concerns raised before.
It introduces NETLINK_UNICAST_TIMED as an explicit
opt-in constant (value 2) rather than the broader heuristic in v2.

Would you be open to reviewing this approach first? If you still prefer
the open-coding route or if v3 gets pushed back, I'm happy to go that direc=
tion.

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo


