Return-Path: <netdev+bounces-181294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E1A844FF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CB9A2E7F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA33270EDD;
	Thu, 10 Apr 2025 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0N6kO6xG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C8134BD
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291921; cv=none; b=swdU99F98FcSt2P8Zsb/ydQsNcicdo54NolSD2EOWUUxXti9dfD2wapHJNsB5c4VZvzAmo1Wmey2U9GRMHQs6fWWEFWqX/M7lKK4jgIDqYAJbsysR25lSVK0aIlsnd57uy6WQ7Bk4L6NrsL2nGKp7tIfJsNkxAIaIiuZqchd++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291921; c=relaxed/simple;
	bh=auk3ztZXg6ajelayaSA3xkFlMTCLOw/kWNxOETPOGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eD/Mn8XtZBSonYofakekGJD2UbM8S3+int5zMt9aQCTL/69ThDbhLlHrCHw+SFFCbpP3E0lMbLDuzCFdfYPypGsl9bAh7j1kGRqI2jeSwZD4HQ5H9uKWfI6v4U3amiFMV+wlx+4rFPuom8UqXARvtuWnpr64IFe56rl7BS9Iw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0N6kO6xG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47698757053so8365901cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744291919; x=1744896719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdWjTu5eIGL9JFIJkTx+V8ptZGr+Ye9WKOwORJmmac0=;
        b=0N6kO6xGcdMLQ+7ARrlRV9nBu103CDbiOf9MpmaHjQdYeS9a7+rqkXCFc6XfHVOyv6
         W2tTu138VDA8kk2Xl/97FeJXEIVLr+VpykorPiwtg0ePLlBH18yYM277v/63Q3GSC6IO
         t/xOZihlpHb96J6WX60V8LUO3iGJzcSCQkNe2wYgqQ/OH09eDwWlm0hCu6mMV55wYL1t
         AGDDezWTyfcOJIUMvGnEbqDu0jCVN+A8A2f2sY8jbHJ7oXZWExi2nATWg+aD28afuTHC
         fSGe/kYpdnv+NIs/vIR+Uk1CSAB0zJQ15QmgDokGAYgREYW6WNR6MmqF4RoMJhK4KY4R
         PrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291919; x=1744896719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdWjTu5eIGL9JFIJkTx+V8ptZGr+Ye9WKOwORJmmac0=;
        b=uLwZmxQDut+zPNBCZ1m2gROTMVVc5G/JtrSh/6KJJ2A7PGV7oVjRRRzkxn8Awnrltg
         L59rV/dQdzrMzt+2EbOSM80cbtcZ91q7LxAYdvMF9yUymbt+B2LMIU/xhDwPI5yDd2YI
         jUe6khpbSJQCuyZ+BTcruz2qlsVZ5PC+Wr4iqbihsH1Z+NXz1nDSLaPU7afNmlOqWEDB
         t4Wc2duMt7mdGosdvESVRcPdvac1OGwXg0T6FndKDARH33KXM1m7ZwJR4Ouilb18vWzk
         aL8kVNfTS/V6Msw+6JK1Y7y9Cm9p5uKLO1luU/K4fi6y6XRWbjK8GAHcjkJMLwABswBd
         mUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIAJv3JepgfNrZ2eDCaHs0mVGWSZh9OxikwZQx0pZoZv9sT5pR8l7z4gYIEHBEfwD6SQzdLwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvdEIbr8sQ5HVcOmV+4a+i9BjdFsuIEPC2XCYqXrJOMoFC0Fw
	DX3jCI+1/U9yuqNLHBrirvaglJABd5S5JCH7w/aN4gv5vfAe7mTxhxa1gciPOKwGd8iOslo+Zui
	1EelOtaRb2gAcB5nzMGABaxvTAGMjoWRTw3xY
X-Gm-Gg: ASbGncvNM1vtP4NZDsjYJvWGg3cP1FxuyYWrcBkD59121uZ8CoZ3X5BkxaIt5jLB+rD
	HA3ouYbmVWtgCb/meOIi8O4OM2/8Lu6cNjFMX18VsGjXZ49MdtIW4IKP0uiQusk6zyzGhfmH7wX
	vyY6fLWb9yXtMCFcR2ThZFwxM=
X-Google-Smtp-Source: AGHT+IHG4HC4pXxmLK8NKehkD9BIimMmawh3C0fto3EELU9War6RW5c3od28o4RQeckzyZRs39p52ZcA1UEWEl5CgLw=
X-Received: by 2002:a05:622a:14:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-4796e2f7d4fmr27484841cf.17.1744291918700; Thu, 10 Apr 2025
 06:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409073524.557189-1-sven@narfation.org> <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
 <3807435.LM0AJKV5NW@ripper>
In-Reply-To: <3807435.LM0AJKV5NW@ripper>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 15:31:47 +0200
X-Gm-Features: ATxdqUEK9P9NpwTJ7BNyPIqykuGoqzr3a0-GlI6TZ-lGY4GlebhmxlvGcJjysRk
Message-ID: <CANn89iJQ1Qkby8gFsWHnuYyHYO7_vasNom52OSMAGN49s5EkzQ@mail.gmail.com>
Subject: Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 3:08=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Thursday, 10 April 2025 12:13:25 CEST Paolo Abeni wrote:
> > Also this is somewhat strange: the same patch come from 2 different
> > persons (sometimes with garbled SoBs),
>
> Ok, all of that was my fault. Even the original duplicated *dev_hold. Jus=
t as summary:
>
> * v1: accidentally submitted the patch with correct content but from a te=
st
>   git repo which didn't had the actual commit message
> * v2: send correct patch but it was done from the folder which is used to
>   prepare the branches which will be submitted later by Simon -> git-send=
-
>   email picked up the Simon's name (see below) and submitted it using my
>   mailserver
> * v3: submitted it "correctly" and marked the day as "shouldn't have wake=
n up
>   in the first place"
>
> Regarding the v2 situation: This is definitely odd but it had to be done =
this
> way because there were complains in the past from netdev when Simon submi=
tted
> the PR and not all patches in the PR were Signed-off-by him. As result, w=
hen I
> add something in the queue, I directly apply the patches as him (includin=
g my
> own Signed-off-by). And Simon will go through the patches again before
> actually sending the PR, create a signed tag and submits the PR. I would =
love
> not to do this preparation/fakery anymore. But then you will not have the
> requested full signed-off-by - something which you usually don't have for=
 PRs
> but which was for some reason required for netdev.
>
> > and we usually receive PR for
> > batman patches.
>
> This was just an attempt to get syzbot happy again (sooner). Besides my d=
irect
> patch submission, we have different options:
>
> * wait for Simon's PR
> * let Eric Dumazet integrate his (earlier posted) patch from
>   https://lore.kernel.org/r/CANn89iJTHf-sJCqcyrFJiLMLBOBgtN0+KrfPSuW0mhOz=
LS08Rw@mail.gmail.com
>   This change was also published earlier
>
> > Also I do not see credits given to syzbot  team ?
>
> Correct. Is there a proper way when the reports received were actually ab=
out
> different problems (just the bisecting went the wrong way due to the
> batman-adv bug)?
>
> For example, I saw the problem with bisecting in:
>
> * https://syzkaller.appspot.com/bug?extid=3Dff3aa851d46ab82953a3
>   Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
> * https://syzkaller.appspot.com/bug?extid=3D4036165fc595a74b09b2
>   Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
> * https://syzkaller.appspot.com/bug?extid=3Dc35d73ce910d86c0026e
>   Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
> * https://syzkaller.appspot.com/bug?extid=3D48c14f61594bdfadb086
>   Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
>
> So, a lot of different problems which unfortunately all ended up in bisec=
ting
> to the batman-adv problem.
>
> On Thursday, 10 April 2025 13:20:21 CEST Eric Dumazet wrote:
> > https://lkml.org/lkml/2025/4/8/1988
>
> You also posted your patch here. Feel free to directly add it. And sorry =
for
> adding the problem in the first placed - just tried to make Antonio happy=
 (and
> then created a big mess for everyone else)

No worries, could you post the fix today with some of the
Reported-by: you are aware of ?

You can add a 'Suggested-by: Eric Dumazet <edumazet@google.com>'

Thanks !

