Return-Path: <netdev+bounces-300972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yzNIDhLpOGrjjwcAu9opvQ
	(envelope-from <netdev+bounces-300972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B56AD659
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:49:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="q/GrUnXq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300972-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300972-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 417613001A5C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65C37DE97;
	Mon, 22 Jun 2026 07:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EE37DAAD
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:49:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114571; cv=none; b=hr9P/PaIEM2tQUXilhg+h5fce+0P3vRq3fKhY8blTUUFWrk35Utwi4Fvxl96VZkyNJvj0dVyd7cw4OwNngiBlQdjxk1x0gzry6UO4xyiaQ20RBY2XacRxACaMWzJiejnYMxdkmjkojiWyH66gaBaLpth/Yq90/nNP7fh8yjhP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114571; c=relaxed/simple;
	bh=uY1IbbgzJJeZsFngawBIbFOhh2GjHioNxJUCJmJ+1Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIc8S0r3Qhqb8gnFGuEp3OJX2OU2YP2S8rr4RFiLT6vGahnZ5ngJbZ6F3dHdm/geZblEnFeRMAL2ftF6QwdcONyjeQSlmWCs/pQcqmUoWB1kHqP4UaVH0XoZvixv6zo06BZkUDhEk4sGhCUATVew5dgdJfGpmCz4KLyPqGUXA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/GrUnXq; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49230a567a9so19009635e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782114567; x=1782719367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZK2bgHSB6zGflE78FJdpdENdlxJ8sSclhnySGocriM=;
        b=q/GrUnXq9phnIwy2GD6JkI/1bPkytakfvNCG4luSAVXD4qbAYdxf6jvvi05NjADu2Q
         XjPRFaS0l2mkAS5CkqoQKgXoy9fOe46reW2SFqd5apZolaF4fLKMj+L+9bo1MJJe8OdD
         CtAR7RiEE6LwHX2HKnBP8rYZAOPcMNwZ1bIqBmaWXCif9Mth+lE6P94VDlCHxyMLPE08
         5vmNtC5/bb/hFqbtbM1hhCdEIAFL3F8s2Ik6mvXRZIOkwYb4IxxopU6nROMJmHEf4ISl
         MwTUQKcGqhHMggbsF/fMyMvLk3vJslpzOf+KTr26/FLMMPsWe2pToLj2u9fq99EWpZNv
         fXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114567; x=1782719367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZK2bgHSB6zGflE78FJdpdENdlxJ8sSclhnySGocriM=;
        b=BeC39HzeSj83JJaWEksGAnRWTaYGZYaTWi6oJ4OPxtqTnsP8QjecWJHgwFBGQSKs3Q
         BxGAYUDpxqJJfvC0kYAN+PvyRPxdDOy5Lf0yFzKhJi3jTlzvkYz+5IdaMc8hT6gSKi4G
         q7mz/Spo7h0KGi9dhayFKQPLKR3ctgOB6hud1PLcGTxlbcCxrX+T5SgOy6ABSdWXx8ZT
         vgPxWVnTFUrfG/tQs3CRwZZFYZ9e94S+a806Ac83zVEc3MYlvJRz1W2Wc1NdFKJQxmyD
         /carIygTf6b/ptysXkC6pAq3CLlvkF6mDuCaT8znyg5JVwwmr8fBgUHw6o7t2sRDUlgY
         Fp1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Alzr25t92GseuBvoRxI2V6vk3JfGNINZNPj/dCixUwKmZxTbCqQaq7l0wG/jl9fP0JoLGxV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+9y5+4nvI+ib9YIpC/KAD3FQutqWgneVwhEblOaJfbmY5fEy
	41p80PEX1pt38wJHqv1E4IdRhVpXSSOLsw1NQOEmEl3GyPjd/kNLegdA
X-Gm-Gg: AfdE7cnQPqlreJMbKUirBomYuXOTbo+OLOCQHqxqVVrIEPPVKyyg36J6PS/948DCyld
	ndUrG4FQNAwRP+qWTdKEbPgdqSkW04cm+lJEvGgouYXv3SRvjeQt40HXVaEEUfP5+faT5NOit6r
	XGEfTASCXySFNJHPN0/RX/oyHX1XmncEKZMG8Ui0fEFtG5gi7izOXRvkPVqOKBMFR1MPmSnHYm4
	TRKgjmkCmiE3mVvgeodYTVhDdE8CIwnI2BNEEf/WPSDSyzbp1tKixPfQS7Ss98DuhYIbr7TRyCY
	hyoF3BTsu3+oAn8Lpp2ImrIp1rIETiFFX8MtY0h+yGqdXO0XXFBUmwoG0RfLLAETRGj7CZlZnTg
	sMKVRVTIbMAu54rFnd8fHag6ZsBCP/db0XBupuO0j/+3/qHfuD2P+5BrUU9aGCGZXqYrDCrLXt2
	/RrS6aRi4c1Ou0DOQY0qIkxgytl5E2GGoOMTuF8Ol16fGpxILORQ==
X-Received: by 2002:a05:600c:46ca:b0:492:506b:a881 with SMTP id 5b1f17b1804b1-492506ba987mr99326235e9.9.1782114567081;
        Mon, 22 Jun 2026 00:49:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240084928sm286083895e9.15.2026.06.22.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:49:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:49:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitri Seletski <drjoms@gmail.com>, netdev@vger.kernel.org
Subject: Re: "ip help" output is an error
Message-ID: <20260622084925.6f3dfc4f@pumpkin>
In-Reply-To: <20260621082105.1196ef72@phoenix.local>
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
	<20260621082105.1196ef72@phoenix.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300972-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:drjoms@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D3B56AD659

On Sun, 21 Jun 2026 08:21:05 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Sat, 20 Jun 2026 10:36:31 +0100
> Dmitri Seletski <drjoms@gmail.com> wrote:
>=20
> > Hello iproute2 maintainers,
> >=20
> > I am reporting an inconsistency regarding the exit status of the ip hel=
p=20
> > command.
> >=20
> > Current Behavior:
> > When running ip help, the command prints the help documentation to=20
> > stdout, but exits with a non-zero status (error). This causes issues in=
=20
> > shell scripts that rely on exit codes for control flow.
> >=20
> > Steps to reproduce:
> > bash
> >=20
> > # This returns "FAIL" because the exit code is non-zero
> > if ip help > /dev/null; then
> >  =C2=A0 =C2=A0 echo "SUCCESS"
> > else
> >  =C2=A0 =C2=A0 echo "FAIL"
> > fi
> >=20
> > Expected Behavior:
> > Since the command successfully performs the requested task (displaying=
=20
> > help information) and does not encounter a system error, it should=20
> > return an exit code of 0.
> >=20
> > Context:
> > This behavior breaks standard Bash logic for automation. For example:
> > ip help && echo "This will not execute"
> >=20
> > "ip help |grep br" - this will bring no result.
> >=20
> > Current version tested: iproute2-6.19.0
> >=20
> > Thank you for your time and for maintaining this tool.
> >=20
> > Regards,
> > Dmitri Seletski
> >=20
> >  =20
>=20
> Yes iproute2 doesn't do a great job of handling error codes
> with usage vs help. Its a bug and no one has bothered to fix it.
>=20

The version I've got does write(2, "Usage...", 972); exit(-1);
Changing it to do write(1, ...) is likely to break scripts, and making
it do exit(0) is likely cause new scripts to fail on old systems.

The 'grep' works fine if you redirect stderr to stdout.=20

The exit(-1) is a bug; the parameter is only 8 bits and the high bit
is expected to be used to indicate abnormal termination (eg by a signal).
That should probably be changed to exit(1), there doesn't seem to be
a standard way to differentiate between command line errors and
operational ones.

	David


