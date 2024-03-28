Return-Path: <netdev+bounces-82708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FE88F532
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 03:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854BB1C261A7
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5117758;
	Thu, 28 Mar 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="B6Qz/nis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C2BE6C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592275; cv=none; b=rdRFcLBNburoJFCcqk4Fgdd1Z4IcfQenWOwcjjUImo0VpW0+/TsejN32Hiq6zFWNjrWNDvqoliH/Mz7kLjygvvkT6LSoDh56E4SXpaqLxQeRzjOMPoluefzd0GGfDaqNQA/QgK6dUDuEWFnfw9/sFbR+XaqwEyrb2BO9VLA2Lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592275; c=relaxed/simple;
	bh=dkVEVkIRKFA1HU/GHjJVqfG3aWdxOeI8rHcQ0XmMwyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc+RQ4ihD7llEek6chcKymqY8/1icxVwojE89/bVe6USVvAzNF/YpWb9lJqoAwnrsp9ARMI0rmMFVOp77PRpQcPhBCQs2CS7Dx8QnCzCzoQ5qWZ/awDWvfyxJ2NNz981274UrZDeg8/49s9NRRPBml9Bg1nq1w7VMxInEIt4+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=B6Qz/nis; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3df13fe31so321665b6e.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711592272; x=1712197072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keS6Nwe0n85aMullLK89O4ZfPm3brRYudBEywgHPkJg=;
        b=B6Qz/nisNY7pYUSBCvdEYvIAMMV+Q+pbaRB5qFCZPWkOVpm6g0YVM0q8P6aFCmSc6T
         ylacUaGGc4HtDEMJBOOARBE+9OiJAXpaEhLLlCKq4aRqBTQjnU2MhGlK/w2NQd7vmSKa
         U/9fxY+FbSNKUq9jXuNiPQqTz52SEj8/lzGydJXANi3hO7/m/aq9e0J0gYFynJ2sW15P
         bg7I1fVWW+sxmZzSSdD0HiezCyH6eoDE7538vJCBmQhiK7a5Jz2Z/ERkDLF9GP57bupm
         1lFpSd/8HKIEgw7md0DY20oR4ecVoJu06kbfFJGRDSZF0QjhpNTCe3zO2omOukfKLXuk
         Dbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592272; x=1712197072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keS6Nwe0n85aMullLK89O4ZfPm3brRYudBEywgHPkJg=;
        b=shtaRZg9IuuMZIwmnf8XPEYCp34fSbhq7hl0aIH9G7s/dqmdXcue3s6At9bzyavXUS
         EnYUG7LiOyAdc8RwNmDYWfCJ3bwoaY/8B+a/Dx48Y8xDNyP/HjFb+ETdvmXC0tkbphO5
         9tWqwHR+cVHdUb7hOw9VYTj2kxrQwj418yhMB1CzAk7LywEuMoQZsUm1B6EQvA2pYr5y
         rI1N9u4j35o4+GoadxYcWJJg1evgsXt8TNePWiIsrTCA5RP7IsVwxcmC+JN8fiXQpcAx
         GNAyFITEW5hPbsibdmzBkhPmOPJM3sVHstTYlDQEdb71xoQ+d3XsR2KigpA5dcTGGVPY
         XwTA==
X-Gm-Message-State: AOJu0YwsbMjxEL/qhWt8rGD7HR2ec+auujHKy9qG3lpj5kQhA1AKpD9Z
	YH5JJF6qbiyXSVprPsVglbMHbCW8oXoQGyHFSCkf3MVJIVoh6AxhXwWnCSue+qg=
X-Google-Smtp-Source: AGHT+IHhEsEKL34cj599L67qta76NDeIsmKhsJsCWCDbWUC+Uz5go9X9wRjf5pzAxXlSv04DefJ+bg==
X-Received: by 2002:a05:6808:23cc:b0:3c3:e0bf:ceb6 with SMTP id bq12-20020a05680823cc00b003c3e0bfceb6mr2092552oib.17.1711592272524;
        Wed, 27 Mar 2024 19:17:52 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id k196-20020a633dcd000000b005ceeeea1816sm199508pga.77.2024.03.27.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:17:52 -0700 (PDT)
Date: Wed, 27 Mar 2024 19:17:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yedaya <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ip: Make errors direct to "list" instead of "show"
Message-ID: <20240327191750.2fa35c98@hermes.local>
In-Reply-To: <ZgHwYUtxrDP1Y+BS@abode>
References: <20240325204837.3010-1-yedaya.ka@gmail.com>
	<20240325141920.0fe4cb61@hermes.local>
	<ZgHwYUtxrDP1Y+BS@abode>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 23:45:05 +0200
Yedaya <yedaya.ka@gmail.com> wrote:

> On Mon, Mar 25, 2024 at 02:19:20PM -0700, Stephen Hemminger wrote:
> > On Mon, 25 Mar 2024 22:48:37 +0200
> > Yedaya Katsman <yedaya.ka@gmail.com> wrote:
> >  =20
> > > The usage text and man pages only have "list" in them, but the errors
> > > when using "ip ila list" and "ip addrlabel list" incorrectly direct to
> > > running the "show" subcommand. Make them consistent by mentioning "li=
st"
> > > instead.
> > >=20
> > > Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com> =20
> >=20
> > That is because ip command treats "list" and "show" the same.
> > Would it be better to do the same in all sub commands?
> > =20
> I'm not sure what else you're talking about changing, I couldn't find
> anywhere where a "show" is referenced in output. Do you mean treating
> "show" and "list" the same everywhere?

Almost all of iproute utils allow list, show, or lst.

You found a couple of places that may not.
Perhaps this will fix it.

=46rom f65a5b0d0757ab7d9c57d0962ca903dd095ce20b Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 27 Mar 2024 16:55:09 -0700
Subject: [PATCH] ipila: allow show, list and lst as synonyms

Across ip commands show, list and misspelling lst are treated
the same.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipila.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ip/ipila.c b/ip/ipila.c
index f4387e03..80f34f29 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -301,7 +301,9 @@ int do_ipila(int argc, char **argv)
 		return do_add(argc-1, argv+1);
 	if (matches(*argv, "delete") =3D=3D 0)
 		return do_del(argc-1, argv+1);
-	if (matches(*argv, "list") =3D=3D 0)
+	if (matches(*argv, "show") =3D=3D 0 ||
+	    matches(*argv, "lst") =3D=3D 0 ||
+	    matches(*argv, "list") =3D=3D 0)
 		return do_list(argc-1, argv+1);
=20
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip ila help\".\n",
--=20
2.43.0


