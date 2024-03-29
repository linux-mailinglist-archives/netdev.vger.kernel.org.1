Return-Path: <netdev+bounces-83463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909148925FA
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C531C21193
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D4813AA5F;
	Fri, 29 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE238FAD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747073; cv=none; b=IEFpzL+j6s4ROoZ9m+WmRtsDbZPWvRPaAOlVul1gnl+922OJOoBjb/HuCJ3iwPEDK1mF78WeWA2yuFgsFHBrCRseNrUIdkld7b6M1n5XUBTydlOahTDDwsLfuL7ySFyoJqk9bIJUeJ23RDhu4gE9DfMFDCA3hZRkhoyIXuxxLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747073; c=relaxed/simple;
	bh=qXxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnpzyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BIvO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-611639a0e4eso21177477b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711747070; x=1712351870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=eh3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKau
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wYi9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7rb6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM9C
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747070; x=1712351870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=e7cVRi3/WlH6zhm2UHjhxjMNGMzCdBw0kiRNGZrD3F9Sy2FYI6dT0JzxAm6Q8e6/Y4
         N3+Uhs00X1PHInoevWtoON7kMo8YWAkAs4VfYnTFSThnVc4wethbrw0HVWBw0e/Ww8oP
         2EHTf37tsviNgSPAsg1JCId8d2geyyarVnyRYeZCsBQTTglBD/mlMiy2m2I4yB/sB6H1
         bYnryK66excoEb9oSigbbsNp5+vkXgQw7SzIZXX1nq1+dSgmDcEhlO/DuoioUPXVaBc0
         LXX7/KWDbTf9Q3O0NH+g7IOBDp/X/SNjkr3lY+cQM6yuiJnb9QzodPZNl8FR24dTed+C
         yheg==
X-Forwarded-Encrypted: i=1; AJvYcCUERtuOlGCNh+VMXzI33ZvBPsWzR2U2kdDvLuwNR7FnXsCvMA6GzCyTrDZsc8eU//coZbvHPe7F+R6hGzULlGg4z+TFtqPj
X-Gm-Message-State: AOJu0YzcaDsBlcNbpASJA/SjYACTyIQrziKr/0R/QADNO9vmVTVlTSYN
	fBH5u2AgnCCd3ByQxdGLKpOww36/eR1eh479SZIeXMFtTJ1As+WzAcJV4BnOch2p+YzXPFxySgk
	ocDfstnl3/uh1PiAfXlkT8RCWbKlGKStG4TJy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEg=
X-Received: by 2002:a05:690c:dd0:b0:614:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com

