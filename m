Return-Path: <netdev+bounces-112391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7D938DBA
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4592C281A5E
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D716A94F;
	Mon, 22 Jul 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xff0ZiAG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6316C852
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645859; cv=none; b=cpCv9F2MgUPPLvH9JawOCEmaqHVMZW1UQgIQojgAAQZAhrSXLTqG7/Nws3jrzqOeInrmOla0FsjYZT2raxHmA367BfutYiu+IRCVKRZUDvSY4eCHoDEU/GFfbFlOl67Ul/NiundZG5J3ODKG+NBgfQAP5oL8w7DVUQruz3uMo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645859; c=relaxed/simple;
	bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4w3vKm5RLL1FxPA7eYEQfp7g2mmVi+4Gm0DtLbsAAlkBAfTp7ctcH8qf+AUKzwly59qIhwgLMofkMsra51aEDbOTxGF47L4/LtFo0UPxPtHJ+YgukvazkpLH1kwfQCsZxSKI3qAE1yN/Xt5QP8AO3NBuRtTrQDAC2EYgPXeDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xff0ZiAG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721645857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
	b=Xff0ZiAGZBSAr8yiJIe8+REp57dzXMgjg64ksssZ54atcMgFisik9jwBtwEofTvJ0dZ9wb
	7fnj5yFeL1fxVzERdTsX/oi8ETEl7wxpciW3XKK1Pop3SZHqbVIOixsuPnW7Am/idj1Qo1
	jedtsOGI9KjThzA75agZaVG8W14TqRs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117--FeCPUjGPzWQFpFzdbDktQ-1; Mon, 22 Jul 2024 06:57:36 -0400
X-MC-Unique: -FeCPUjGPzWQFpFzdbDktQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7a4c02488so69327436d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645855; x=1722250655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
        b=dTuWGn+yQQpWx3Qsasv15hXNY5QiG+wMXGESkhyumbqSNkeEDbha2z1WzRVVGskIe9
         LUHsask8nzdaFq/+y1FVquqKyaetru1tRUg/eWYJvPdbq9eOW+hOrSil1Bgxw9dTgWQz
         QW9JTAoriTEeFVVZUHIIqy54oQdmxE8TRS5lCB0D/Sl9jgpIxiqy08aHGWySmrtlxlDx
         OOeg73sK1DNzCYI9M47wrRphd/4Zmq6I0N4qFaMKeouBwhZ7qHEtCPjuHUxA6Tj8F9Ri
         yPPpW7Gr1c7RJGg0XP5iVqTzEluj9Lpr/MdzpGli05XADAcEiY1RvMyyQquwG6DbxSvq
         +6nA==
X-Forwarded-Encrypted: i=1; AJvYcCXRK+YNl+DhPKsFiUk/hGGhA+arIIM2jej58Dgfxs+w58s8SYkycyXIEZVxNf44yPQU4u6d+yOun0tRsYxhoVq14OerEo8f
X-Gm-Message-State: AOJu0YyF8htNLAR5BPEV28bJibgaAuIiF5xqnOB//mI4Qtn/amTQUvTE
	mVHAG1lK5j4cVdrnI96sBsMuAMsgOFXBOQHLNewNWiLsf1td5h++u18p1rSQzuUgp2QiodFJODZ
	m7J0Lkah8LzmZwOKHnzntKUX7dd/sPEc+TLdm6TuoY4jlPKYysfQ7OZDupFdDHHLcUV6QKJ1/4S
	K0T+qywDpd7t4B2ZDArsP8+mI7gVf+
X-Received: by 2002:a05:6214:29c6:b0:6b5:d6da:fbfe with SMTP id 6a1803df08f44-6b96113814emr107769216d6.1.1721645855418;
        Mon, 22 Jul 2024 03:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhDkPy4xzeYlv5Bs/9snKzkh4KxgDdbbuGxf6Qx5CsRFMYq1KSkcwMPzP3f6fLyfuZB0iKL1TVnvB2kCz59u4=
X-Received: by 2002:a05:6214:29c6:b0:6b5:d6da:fbfe with SMTP id
 6a1803df08f44-6b96113814emr107769026d6.1.1721645855127; Mon, 22 Jul 2024
 03:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net> <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <87ed8mftra.fsf@toke.dk> <6fb46358-e92c-4264-9863-c011fa970478@nvidia.com>
In-Reply-To: <6fb46358-e92c-4264-9863-c011fa970478@nvidia.com>
From: Samuel Dobron <sdobron@redhat.com>
Date: Mon, 22 Jul 2024 12:57:24 +0200
Message-ID: <CA+h3auO1tkMTbAVbS_PkKxNUQhvdUNb5cD+jL3Cz9Zouf6ACzw@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Tariq Toukan <tariqt@nvidia.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, hawk@kernel.org, 
	Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	saeedm@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Sorry for waiting.
I've started a discussion within our team, how to handle this since we
don't have reporting process defined. So it may take some time, I'll
let you know.

Thanks,
Sam.

On Sun, Jun 30, 2024 at 12:26=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> w=
rote:
>
>
>
> On 24/06/2024 14:46, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Samuel Dobron <sdobron@redhat.com> writes:
> >
> >>> It looks like this is known since March, was this ever reported to Nv=
idia back
> >>> then? :/
> >>
> >> Not sure if that's a question for me, I was told, filling an issue in
> >> Bugzilla/Jira is where
> >> our competences end. Who is supposed to report it to them?
> >
> > I don't think we have a formal reporting procedure, but I was planning
> > to send this to the list, referencing the Bugzilla entry. Seems I
> > dropped the ball on that; sorry! :(
> >
> > Can we set up a better reporting procedure for this going forward? A
> > mailing list, or just a name we can put in reports? Or something else?
> > Tariq, any preferences?
> >
> > -Toke
> >
>
> Hi,
> Please add Dragos and me on XDP mailing list reports.
>
> Regards,
> Tariq
>


