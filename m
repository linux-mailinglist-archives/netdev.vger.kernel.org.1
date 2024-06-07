Return-Path: <netdev+bounces-101918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AC90098D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94E91F23143
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B1198E86;
	Fri,  7 Jun 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6IuiIJk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989771E52A
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775246; cv=none; b=p+kg9MDqoGSwvYFqd6l+oF6tRhX3/pXFrJoWahomd3rBx3T4JdHC+fcfsUA7DopoDyK5oLd+0mGtS84BLe0FLUsYVqmIAp7IJ/Gj3v9GZ1PqyhXVz/jBTcEc8SAIydhtp6rFPWDiD+C8RhKngYPnE4iPbTwnga9+xeozSBiDnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775246; c=relaxed/simple;
	bh=CShtKqBAKVaWF2SeSkDUPmUqFbx6AeJcpaTZSt41drk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrS+loxRUh5R50PtoyxUT5A7LBHfRePAGkRq4/jsuLGlCxpi+jdq3KwzW8c8228fEQZdSPJfB4fAyFwj8ry6eDrT5vZoiCu7S3rCyB0PehS7syTnpJGUStU8DeZDvnlV0cdyoNvtKTTpJWbHhVaQIhYIJni0IeFvHemow9/Zh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6IuiIJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717775243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQCecZL5TMRFpvq7f1WP4hnKckjUHkKLcuYm0ceE7N4=;
	b=g6IuiIJkzViFC2l9FWRU0bHc6E2qKIUPKducMIavA6ib7D0PvB4vL/SBMsyzx/hQubM3qv
	OUhzdWofTNB+6/k/qjhSSLofmU2Kg4jlhmnfw1M8nihw4HOD9ZbAKVpSNJjvXmQMc+NE7r
	7eE6QKRmDbA33DVYuT+XHx4nAy6pjks=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-VfoMlvbrPTKtuWukiC44eA-1; Fri, 07 Jun 2024 11:47:21 -0400
X-MC-Unique: VfoMlvbrPTKtuWukiC44eA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1a23d1382so2173664a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775240; x=1718380040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQCecZL5TMRFpvq7f1WP4hnKckjUHkKLcuYm0ceE7N4=;
        b=mBkdP3cxwiana3uCndgfoENk1g9qSi1hPVrBithLYYDNPxuQiwpkPhwr0Q2R8y5dSQ
         LOBhCvrEA5fMAfB7SbFCO5Uc7ncIOHGXPYylMgqzRh4Rwcb6uXJleh9rMsZmg7FO3lIv
         X2XYXnzoZa+FbJ87GNGEV3VAwmV/OcKgKT/YNHVEMdory15TvCV3IkWujMQxz3jNzSVN
         Eodg4mrbL7Xp8s1/SfqxCo2LU5d2IbRNv58yx2pC+Ucq3csrHMgU9zRLtLV1ujSZgxGA
         bTTt9gnkQ2XX/G9E0+i7xVWz4sPz/QVGaPpw9CNxdgidJblPaK8Sh6DcKejR1J1EZ5fl
         3+uA==
X-Gm-Message-State: AOJu0YwGHKSeNBMbf3NHTL6SqesPWv1V6wCuXjoqOkdQslixTV4o/XK7
	Uv0SpTOyacHYwEUuBVrRE3EMXb8Cux2u0DrGtAwOdQ9eCLEavAGDbC81wxLAnKoTh/Jt/RI9/q8
	pUlHxsjcFfVmnOgwECVmGKNuhhGfduB9s86Tf7R1u/lXnlXclGXI7I7KcoRtmyg9tzqp/YCc3u/
	8Z0j1QC+UOVHppnhllY7APChz9Jweb/HvX5ox6VV8=
X-Received: by 2002:a17:90a:6541:b0:2c2:cfca:df5f with SMTP id 98e67ed59e1d1-2c2cfcae024mr1132756a91.36.1717775240639;
        Fri, 07 Jun 2024 08:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb87vcx2eefUnVvWfHkTcqB7wwLwFgHZRIdJn6Vi02LfBGmajNAAbYALuj51i52HcSdJLAdGZG0Iuqrxx7q7c=
X-Received: by 2002:a17:90a:6541:b0:2c2:cfca:df5f with SMTP id
 98e67ed59e1d1-2c2cfcae024mr1132740a91.36.1717775240258; Fri, 07 Jun 2024
 08:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
 <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
 <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com> <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com>
In-Reply-To: <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 7 Jun 2024 17:47:08 +0200
Message-ID: <CAFqZXNsy86uN0J41HOhjH_Rq-WRU2DVzhbJOx3xtxtB5PbwFFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, May 14, 2024 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > I tried to test what you describe - hopefully I got close enough:
> >
> > My test setup has 3 VMs (running Fedora 39 from the stock qcow2 image)
> > A, B, and R, connected via separate links as A <--> R <--> B, where R
> > acts as a router between A and B (net.ipv4.ip_forward is set to 1 on
> > R, and the appropriate routes are set on A, B, R).
> >
> > The A <--> R link has subnet 10.123.123.0/24, A having address
> > 10.123.123.2 and R having 10.123.123.1.
> > The B <--> R link has subnet 10.123.124.0/24, B having address
> > 10.123.124.2 and R having 10.123.124.1.
> >
> > The links are implemented as GRE tunnels over the main network that is
> > shared between the VMs.
> >
> > Netlabel configuration on A:
> > netlabelctl cipsov4 add pass doi:16 tags:5
> > netlabelctl map del default
> > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > netlabelctl map add default address:::/0 protocol:unlbl
> > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
> > netlabelctl map add default address:10.123.124.0/24 protocol:cipsov4,16
> >
> > Netlabel configuration on R:
> > netlabelctl cipsov4 add pass doi:16 tags:5
> > netlabelctl map del default
> > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > netlabelctl map add default address:::/0 protocol:unlbl
> > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
> >
> > B has no netlabel configured.
> >
> > (I.e. A tries to send CIPSO-labeled packets to B, but R treats the
> > 10.123.124.0/24 network as unlabeled, so should strip/add the CIPSO
> > label when forwarding between A and B.)
> >
> > A basic TCP connection worked just fine in both directions with and
> > without these patches applied (I installed the patched kernel on all
> > machines, though it should only matter on machine R). I ignored the
> > actual labels/CIPSO content - i.e. I didn't change the default SELinux
> > policy and put SELinux into permissive mode on machines A and R.
> >
> > Capturing the packets on R showed the following IP option content
> > without the patches:
> > A -> R: CIPSO
> > R -> B: NOPs
> > B -> R: (empty)
> > R -> A: CIPSO
> >
> > With the patches this changed to:
> > A -> R: CIPSO
> > R -> B: (empty)
> > B -> R: (empty)
> > R -> A: CIPSO
> >
> > Is this convincing enough or do you have different scenarios in mind?
>
> Thanks for verifying your patch, the methodology looks good to me, but
> as I mentioned in my previous email I would feel much better if you
> verified this with a different client OS/stack.  Do you have access to
> Windows/MacOS/BSD/non-Linux system you could use in place of B in your
> test above?

I don't think I can easily plug that into the framework I used for the
testing (there doesn't seem to be a convenient way to install a
FreeBSD VM without manual interaction and the rest is proprietary).

I still don't quite understand what exactly you expect to break under
that scenario and why - could you elaborate on that? If anything, I'd
expect the IP header growing along the path (which already happens
pretty much by design in the opposite direction) to be more likely to
cause an issue.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


