Return-Path: <netdev+bounces-218033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6CB3AE91
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13185826CB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F9276059;
	Thu, 28 Aug 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cH3HiNTp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F3213254
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424992; cv=none; b=M2HlUH1QBnkr92laSj1qJgNj7QRy2Q4RD7gbHCCHswxJycywTgLXqBG+9rqcpejGXTk/t4CFOtDoH/VL/LOUye640TKJAIC32/ntJlEnbQwKtrhVT6EgoMr7BcDmminuQ8mLkPQgGa8mwWZIbyJUYhNtPn/qDiOKLj1c3rmbNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424992; c=relaxed/simple;
	bh=FshFE/VAhRZtpdKFfNCtF3IGJFakwng521QISpslE8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKwEIhZAs9O52Pdtp2qVSv8JaI0/fXCm+98wzsjt9KoY/4deiGF/+jwiRchl5VTUaa17nxRL3s2WyEauc/dPxbyCPQJYnMkcgMvII66GvzN76rZOkZNG1Iqex7U+0VgEpwK9RXiqMVUSG5aKPAWmJDVx1XJT61S6WCkwLbPzETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cH3HiNTp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756424989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PlKQSWkoh7chmxOC3lP1jMsgMMLDZHYp6T05N9ls2w=;
	b=cH3HiNTpoGJrwfYoo49GEsiIFh9LfRPw7m5izEuyg7TV92wzCoTO63Nfi5RpnivGEQR3Gx
	DUN3BWpCioHmkaqbWnqFB6gAmWQpugPWqFmryMKe6/A3aioxkFDvmwMolWc4fzxVBDIL+b
	I2iBCFcek7wRmdlguTxT9RlM72TaJRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-qQN_EzN6MKC7QPAIJyjO7A-1; Thu, 28 Aug 2025 19:49:47 -0400
X-MC-Unique: qQN_EzN6MKC7QPAIJyjO7A-1
X-Mimecast-MFC-AGG-ID: qQN_EzN6MKC7QPAIJyjO7A_1756424987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so11625225e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756424987; x=1757029787;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PlKQSWkoh7chmxOC3lP1jMsgMMLDZHYp6T05N9ls2w=;
        b=wTBuQVgyAZC+jq2D/a8RcQkKVIJ1+7P1NUYfKk3y6BN9uIwXCHuN/l+02obYLPC0N6
         234xOp/m2/I5n5cSKwnAMXBZiVlGIo6MIRtiJbJXhd7vnF1uos0/Pc3nQyeTNF0oNLAu
         d/Xa7yTiKVXabfGGeuXJhkF6urdIotmxyrUWBtXVCp2hIXG5ccS54bej3G4sCy9HaiKS
         8MaLd2zXc2jN26YJSDzTvns9ydxg/xgHBs0WfsgwDxxsHo5hCRfJ6bJ/r8LqNRcSUkDV
         m2zcPz+8UaBqh3lJ6Ra6CLMqow42EWTh6ZWl/2c3RbW1ww4jWajigYxJAHbMEzqr9rcG
         J1qA==
X-Forwarded-Encrypted: i=1; AJvYcCUvHH28MpguIIOPPUkEW/0y4QUh43nRib20F8XPU5ON6//1Pr11fmf54mwuVYgILrJCIZ23F+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagnsNys2bC4aLe03hVEBpCpydtDqgs/n5Ipcm5iYuUyLklo9l
	Su4XwE1/SQkBTqOjUt8Dmmw/Kx1eAOBrSUQmj6wdTMp/V167wZcQgArNezhwk3b9dv/ZXTlFZ7s
	a7XtbhWLXziSRaTRAKENgKQPKSVbSyaXt58glQZotPm6jtX6Wk3zZhHDycg==
X-Gm-Gg: ASbGncuBfIqtjowbBy9qmMbkjtET21ODi9DuxKiSYt+VF42liopqAvQe+i3JnEmocQR
	/ze1J1frQB5n87a/e6PFQ8aybDpIh4QGVPHFo59uwze7YXK1xxjWYXYCrJtcKPTSKydVLFJGF1I
	kv/YwwmCyl6jq/YVUN5oyEcrnMug7lWCrJfiKFn3T/VUt6p/ra5hRt/QCeK97Sjx5ZrfvfvJNN2
	FhgN4Skv5E3Ke8HDkToIOOumMXBhru39ijgqcNF40daLLAvGpUPvJpiODNeblyNnJHAlSAL0zgS
	JMdMkeoSQhwSkTF8BLkcoHyOhPJBD4ogj3cq1OjxL03qRwGqpEVpfdH60MFZXEO7xMHf
X-Received: by 2002:a05:600c:5493:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b517d3998mr245490745e9.31.1756424986492;
        Thu, 28 Aug 2025 16:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5DiFKOa/ju+4dbi6zloD6KzInAOofv0iMn4SjDJAvVoWrmBhNvDrOf6bB2iO1K6o6/ueZew==
X-Received: by 2002:a05:600c:5493:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b517d3998mr245490645e9.31.1756424986013;
        Thu, 28 Aug 2025 16:49:46 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d305fsm106534855e9.8.2025.08.28.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 16:49:45 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:49:44 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Paul Wayper <pwayper@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 jbainbri@redhat.com
Subject: Re: [PATCH iproute2] ss: Don't pad the last (enabled) column
Message-ID: <20250829014944.1bea25f0@elisabeth>
In-Reply-To: <137a3493-bbda-490f-8ad4-fa3a511c2742@redhat.com>
References: <20250821054547.473917-1-paulway@redhat.com>
	<20250821123555.67ed31d1@elisabeth>
	<137a3493-bbda-490f-8ad4-fa3a511c2742@redhat.com>
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

On Mon, 25 Aug 2025 11:51:20 +1000
Paul Wayper <pwayper@redhat.com> wrote:

> On 21/08/2025 20:35, Stefano Brivio wrote:
> > Hi Paul,
> >
> > On Thu, 21 Aug 2025 15:45:47 +1000
> > Paul Wayper<pwayper@redhat.com> wrote:
> > =20
> >> ss will emit spaces on the right hand side of a left-justified, enabled
> >> column even if it's the last column.  In situations where one or more
> >> lines are very long - e.g. because of a large PROCESS field value - th=
is
> >> causes a lot of excess output. =20
> > I guess I understand the issue, but having an example would help,
> > because I'm not quite sure how to reproduce this. =20
>=20
> Hi Stefano,
>=20
> To reproduce, do a `ss -tunap` and look at the output with something=20
> like `od -tx1c`:
>=20
> 0000000=C2=A0 4e=C2=A0 65=C2=A0 74=C2=A0 69=C2=A0 64=C2=A0 20=C2=A0 53=C2=
=A0 74 61=C2=A0 74=C2=A0 65=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N=C2=A0=C2=A0 e=
=C2=A0=C2=A0 t=C2=A0=C2=A0 i=C2=A0=C2=A0 d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 S=C2=A0=C2=A0 t=C2=A0=C2=A0 a=C2=A0=C2=A0 t e
> 0000020=C2=A0 20=C2=A0 52=C2=A0 65=C2=A0 63=C2=A0 76=C2=A0 2d=C2=A0 51=C2=
=A0 20=C2=A0 53=C2=A0 65=C2=A0 6e=C2=A0 64=C2=A0 2d=C2=A0 51 20=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 R=C2=A0=C2=A0 e=C2=A0=C2=A0 c=C2=A0=C2=A0 v=C2=A0=C2=A0 -=C2=A0=C2=
=A0 Q=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0 e=C2=A0=C2=A0 n=C2=
=A0=C2=A0 d=C2=A0=C2=A0 - Q
> 0000040=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20 20=C2=A0 20
>=20
> 0000060=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 4c=C2=A0 6f=C2=A0 63 61=C2=A0 6c
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 L=C2=A0=C2=A0 o c=C2=A0=C2=A0 a=C2=A0=C2=A0 l
> 0000100=C2=A0 20=C2=A0 41=C2=A0 64=C2=A0 64=C2=A0 72=C2=A0 65=C2=A0 73=C2=
=A0 73=C2=A0 3a=C2=A0 50=C2=A0 6f=C2=A0 72=C2=A0 74=C2=A0 20 20=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 A=C2=A0=C2=A0 d=C2=A0=C2=A0 d=C2=A0=C2=A0 r=C2=A0=C2=A0 e=C2=A0=C2=
=A0 s=C2=A0=C2=A0 s=C2=A0=C2=A0 :=C2=A0=C2=A0 P=C2=A0=C2=A0 o=C2=A0=C2=A0 r=
 t
> 0000120=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 50=C2=A0 65=C2=A0 65=C2=A0 72=C2=A0 20=C2=A0 41=C2=A0 64 64=C2=A0 72
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 P=C2=A0=C2=A0 e=C2=A0=C2=A0 e=C2=A0=C2=A0 r=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 A d=C2=A0=C2=A0 d=C2=A0=C2=A0 r
> 0000140=C2=A0 65=C2=A0 73=C2=A0 73=C2=A0 3a=C2=A0 50=C2=A0 6f=C2=A0 72=C2=
=A0 74=C2=A0 50=C2=A0 72=C2=A0 6f=C2=A0 63=C2=A0 65=C2=A0 73 73=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=C2=A0=C2=A0 s=
=C2=A0=C2=A0 s=C2=A0=C2=A0 :=C2=A0=C2=A0 P=C2=A0=C2=A0 o=C2=A0=C2=A0 r=C2=
=A0=C2=A0 t=C2=A0=C2=A0 P=C2=A0=C2=A0 r=C2=A0=C2=A0 o=C2=A0=C2=A0 c=C2=A0=
=C2=A0 e s=C2=A0=C2=A0 s
> 0000160=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20 20=C2=A0 20
>=20
> *
> 0000220=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 0a=C2=
=A0 75=C2=A0 64=C2=A0 70=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 55 4e=C2=A0 43
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \n=C2=A0=C2=A0 u=C2=A0=C2=A0 =
d=C2=A0=C2=A0 p U=C2=A0=C2=A0 N=C2=A0=C2=A0 C
> 0000240=C2=A0 4f=C2=A0 4e=C2=A0 4e=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 30=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20 20=C2=A0 30
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0 N=
=C2=A0=C2=A0 N 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
> 0000260=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20 20=C2=A0 20
>=20
> *
> 0000320=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 30=C2=A0 2e=C2=A0 30=C2=A0 2e=C2=A0 30=C2=A0 2e 30=C2=A0 3a
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 .=C2=A0=C2=A0 0=C2=A0=C2=A0 .=C2=A0=
=C2=A0 0 .=C2=A0=C2=A0 0=C2=A0=C2=A0 :
> 0000340=C2=A0 34=C2=A0 36=C2=A0 37=C2=A0 36=C2=A0 35=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20 20=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0 6=
=C2=A0=C2=A0 7=C2=A0=C2=A0 6 5
> 0000360=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 30=C2=A0 2e=C2=A0 30=C2=A0 2e=C2=
=A0 30=C2=A0 2e=C2=A0 30=C2=A0 3a=C2=A0 2a=C2=A0 20=C2=A0 20 20=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 .=C2=
=A0=C2=A0 0=C2=A0=C2=A0 .=C2=A0=C2=A0 0=C2=A0=C2=A0 .=C2=A0=C2=A0 0=C2=A0=
=C2=A0 : *
> 0000400=C2=A0 75=C2=A0 73=C2=A0 65=C2=A0 72=C2=A0 73=C2=A0 3a=C2=A0 28=C2=
=A0 28=C2=A0 22=C2=A0 77=C2=A0 73=C2=A0 64=C2=A0 64=C2=A0 22 2c=C2=A0 70
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=C2=A0=C2=A0 s=
=C2=A0=C2=A0 e=C2=A0=C2=A0 r=C2=A0=C2=A0 s=C2=A0=C2=A0 :=C2=A0=C2=A0 (=C2=
=A0=C2=A0 (=C2=A0=C2=A0 "=C2=A0=C2=A0 w=C2=A0=C2=A0 s=C2=A0=C2=A0 d=C2=A0=
=C2=A0 d "=C2=A0=C2=A0 ,=C2=A0=C2=A0 p
> 0000420=C2=A0 69=C2=A0 64=C2=A0 3d=C2=A0 35=C2=A0 39=C2=A0 35=C2=A0 37=C2=
=A0 2c=C2=A0 66=C2=A0 64=C2=A0 3d=C2=A0 31=C2=A0 34=C2=A0 29 29=C2=A0 20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=C2=A0=C2=A0 d=
=C2=A0=C2=A0 =3D=C2=A0=C2=A0 5=C2=A0=C2=A0 9=C2=A0=C2=A0 5=C2=A0=C2=A0 7=C2=
=A0=C2=A0 ,=C2=A0=C2=A0 f=C2=A0=C2=A0 d=C2=A0=C2=A0 =3D=C2=A0=C2=A0 1=C2=A0=
=C2=A0 4 )=C2=A0=C2=A0 )
> 0000440=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=
=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 20=C2=A0 0a 75=C2=A0 64
> \n=C2=A0=C2=A0 u=C2=A0=C2=A0 d
>=20
> You can see the spaces after 'Process' and the process name (i.e.=20
> 'users:(("wsdd",pid=3D5957,fd=3D14))'), just before the end-of-line.

Those spaces _should_ be harmless because they _should_ align with the
end of line anyway. We can drop them, but:

> The problem we had was with the output when there was over 1000=20
> processes all listening on the same port.=C2=A0 That pushed the line leng=
th=20
> out to ~35,000 bytes, with almost all of that being space characters.=C2=
=A0=20
> Unfortunately on this server there was also ~21,000 connections in=20
> TIME-WAIT, which -a will show, so we had ~21,000 lines of ~35,000 bytes=20
> which added up to a very large output.

...I don't understand, from this, if your issue is that there was a
single process with a very long name (which won't be solved by just
dropping spaces), or the waste of bytes (which would be solved instead).

Having the exact line(s) causing you trouble would be helpful.

> What's messing with my head right now though is that in the `ss -tunap`=20
> output, when the 'Process' column is on the end, the current standard=20
> 'ss' on my Fedora 42 machine outputs the Process header right up against=
=20
> the 'Peer address:Port' header:
>=20
> $ /bin/ss -tunap | head -4=C2=A0 # trimmed for email neatness...=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 problem=20
> is v- here

First off, note that if you pipe the output to head(1), isatty(3) in
render_screen_width() will return 0, and that affects the output of
course, because we can't fetch the number of columns.

What did you trim exactly here, and what do you mean by "problem is v-"?

> Netid State=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Recv-Q Send-Q Local Address:Por=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Peer=20
> Address:PortProcess
> udp=C2=A0=C2=A0 UNCONN=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0.0.0.0:46765 0.0.0.0:*=C2=A0=C2=A0=C2=A0=20
> users:(("wsdd",pid=3D5957,fd=3D14))
> udp=C2=A0=C2=A0 UNCONN=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0.0.0.0:32772 0.0.0.0:*=C2=A0=C2=A0=C2=A0=20
> users:(("firefox",pid=3D8059,fd=3D279))
> udp=C2=A0=C2=A0 UNCONN=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 127.0.0.1:53=
 0.0.0.0:*

I can see something like this as well if I pipe the output and I don't
set COLUMNS according to the current columns from my terminal. The
reason is that we try to pack as much output as possible into one line,
and we pack one byte too many, so the space between "Port" and
"Process" is elided.

This should be fixed, but it won't help with the issue you reported.

There seems to be another issue: render_screen_width() calls=20
getenv("COLUMNS"), but, with $COLUMNS set to 211 for example, for
whatever reason, I get different outputs between 'ss -tunap' and
'COLUMNS=3D211 ss -tunap', as if environment variables were scrubbed or
something. I didn't debug that yet.

> $ rpm -qf /bin/ss
> iproute-6.12.0-3.fc42.x86_64
>=20
> Is this something that I just haven't noticed until now?=C2=A0 Or is ther=
e a=20
> more fundamental bug in the way the table spacing is calculated?=C2=A0 I'=
ve=20
> tried changing the 'ldelim' to be a space, as it is in the non-first=20
> left-aligned columns (State, Recv-Q, Send-Q, Local address: and Peer=20
> address:), and that fixes the header but adds an extra space before the=20
> 'users' process description.
>=20
> > There's a problem with this change though, which I didn't really
> > investigate. It turns something like this (105 columns):
> >
> > $ ss -tunl
> > Netid   State    Recv-Q   Send-Q                           Local Addres=
s:Port        Peer Address:Port
> > udp     UNCONN   0        0                                 10.45.242.2=
9:49047            0.0.0.0:*
> > udp     UNCONN   0        0                                192.168.122.=
1:53               0.0.0.0:*
> > udp     UNCONN   0        0                               0.0.0.0%virbr=
0:67               0.0.0.0:*
> > [snip]
> > tcp     LISTEN   0        1024                                         =
*:12865                  *:*
> > tcp     LISTEN   0        20                                       [::1=
]:25                  [::]:*
> >
> > into this:
> >
> > $ ./ss -tunl
> > Netid   State    Recv-Q   Send-Q                           Local Addres=
s:Port        Peer Address:Port
> >          udp      UNCONN   0                                        0  =
   192.168.122.1:               530.0.0.0:
> > *                udp      UNCONN                                   0   =
  0         0.0.0.0%virbr0:67
> > 0.0.0.0: *                 udp                                      UNC=
ONN0                  0     0.0.0.0:
> > [snip]
> > *                tcp      LISTEN                                   0   =
  4096               [::1]:631
> > [::]:   *                 tcp                                      LIST=
EN0                  1024  *:
> > 12865   *:       *                                                    t=
cpLISTEN             0     20
> > [::1]:  25       [::]:    * =20
>=20
> OK, that's weird.=C2=A0 I'm not seeing that:
>=20
> $ misc/ss -tunl | head

The same note about piping the output applies here, but anyway:

> Netid State=C2=A0 Recv-Q Send-Q=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Local=20
> Address:Port=C2=A0 Peer Address:Port
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 0.0.0.0:46765=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 127.0.0.1:53=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 127.0.0.54:53=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 127.0.0.53%lo:53=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 127.0.0.1:323=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 10.215.66.73:370=
2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 239.255.255.250:=
3702=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 10.76.18.168:370=
2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*
> udp=C2=A0=C2=A0 UNCONN 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 239.255.255.250:=
3702=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0.0.0:*

...the alignment is completely broken even in your output. This is
with the second version of your patch, in my environment:

$ ./ss -tunl | head
Netid State  Recv-Q Send-Q                      Local Address:Port  Peer Ad=
dress:Port
      udp    UNCONN 0                                   0     192.168.1.185=
:         564080.0.0.0:
*            udp    UNCONN                              0     0      192.16=
8.122.1:53
0.0.0.0: *             udp                                 UNCONN0         =
    0     0.0.0.0%virbr0:
67    0.0.0.0: *                                             udpUNCONN     =
   0     0    =20
0.0.0.0: 111    0.0.0.0: *                                         udp     =
     UNCONN0    =20
0      0.0.0.0: 33335  0.0.0.0:                                   *        =
        udpUNCONN
0      0      10.45.242.21: 42711                             0.0.0.0:*    =
              udp
UNCONN 0      0      0.0.0.0:                                51540.0.0.0:  =
           *
udp   UNCONN 0      0                             224.0.0.251:5353       0.=
0.0.0:*

...and without it:

$ ss -tunl | head
Netid State  Recv-Q Send-Q                      Local Address:Port  Peer Ad=
dress:Port
udp   UNCONN 0      0                           192.168.122.1:53         0.=
0.0.0:*  =20
udp   UNCONN 0      0                          0.0.0.0%virbr0:67         0.=
0.0.0:*  =20
udp   UNCONN 0      0                                 0.0.0.0:111        0.=
0.0.0:*  =20
udp   UNCONN 0      0                                 0.0.0.0:33335      0.=
0.0.0:*  =20
udp   UNCONN 0      0                                 0.0.0.0:5154       0.=
0.0.0:*  =20
udp   UNCONN 0      0                             224.0.0.251:5353       0.=
0.0.0:*  =20
udp   UNCONN 0      0                             224.0.0.251:5353       0.=
0.0.0:*  =20
udp   UNCONN 0      0                             224.0.0.251:5353       0.=
0.0.0:*  =20
udp   UNCONN 0      0                             224.0.0.251:5353       0.=
0.0.0:*  =20

> I'm not doubting you got that result, and at a rough guess it looks like=
=20
> the count of which field we're aligning is getting out of sync with the=20
> field we're actually printing.=C2=A0 That makes me think I must have=20
> interfered with the 'render' function's field output loop, but I didn't=20
> touch it.
>=20
> I've tried changing the loops in the render_calc_width function to use=20
> LAST_COL rather than COL_MAX but it didn't change the output.
>=20
> Stefano, are you using any CC options in your environment I should know=20
> about that might change the way your binary compiled compared to mine?

Not really, I'm just building with 'make'. The resulting command line
is:

gcc ss.o ssfilter_check.o ssfilter.tab.o  -lselinux  -ltirpc  -lelf  -L/usr=
/lib64 -lcap  ../lib/libutil.a ../lib/libnetlink.a -lselinux  -ltirpc  -lel=
f  -L/usr/lib64 -lcap  -o ss

and that's with gcc 13.3.0.

> > It's not referenced explicitly but it's definitely used, see also commi=
ts: =20
>=20
> Yeah, I should have just left it as is but marked it as explicitly=20
> disabled.=C2=A0 I've put it back.
>=20
> I really appreciate your help here Stefano, I'll send through an updated=
=20
> patch today using git send-email for the right formatting.=C2=A0 I'm new =
to=20
> submitting patches to the Kernel so all advice is greatly appreciated.

Except for the missing 'PATCH v2' in the subject line, and the missing
description of the changes compared to the first version (check mailing
list archives for examples), your patch submissions look good to me.

It would be nice if you could drop the HTML attachment from your other
emails to the list (it just adds bytes) and the Red Hat logo as well,
by now we all know how it looks like. :)

I still have to go through your second version in detail. I'm not
really sure what exact problem it's meant to fix, though, and it would
be helpful to know that in advance.

--=20
Stefano


