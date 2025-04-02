Return-Path: <netdev+bounces-178882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F92A79563
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E741172024
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7081DDA24;
	Wed,  2 Apr 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGlrPRiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326891A3156
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619577; cv=none; b=a0bwpaJYTQSp26cfWT3WbikaDtfnLVqtOH+szsLEq+mt501/7ex9fe2CwRhgvUpWVtQ11rJQiZbOKPJM4eq9INJE2dmVJFhvm0kiZVq+EwtPosukBVOYHm/iPiFfCcReHQIlkaxgRp7G5ZfrNpdNIFwtjgx24jKrcsuhNZH+BpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619577; c=relaxed/simple;
	bh=0S8Yg3ZIxZa7c2zadtSpDzyjjoYO8OJk5dJF116+cmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQO1txNRJBGmN1+m4VPHfUt07eg1D/kClTpBU+XjLKvgdRxVpThGyphhTrXw8LbsB14YEnuhuQi0pC300ZXOkVk21crgLIx4Vx/8qmLVhKhdj8B/PJrlqnnmSsVkEMJo7yWK0ki9ltCwb7/cc3gdgimFJaxNdFZAeIyqT9lK8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGlrPRiJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so330415ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743619575; x=1744224375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o31BAxPc1jxMK6zymf4qyMVSyHB+1btky9d72lcB3Yw=;
        b=JGlrPRiJV6PWQetoGcI6j2Y70H4RUlX+Age4ZHKL6ibweXO0Upn1McNfRoVaWxSMrL
         QHTBNmo4ZhSlQlBcsct7YV4bhg2ekRKh6WG6VbAPTtL15PGjdp2UAKX0e/fHfeNLirsB
         76869UF+VxAxuqUBSgkewI365lpI7pODgPhqrJJPQKORgCxsorfzbzMJEQnvuBmEZShb
         qAQljZtfbeDm/3OILtgZnrz6dbJZWUsv8g+jppaCmfs0TOJmJISxcUUkphzKxUptcOU+
         TSwgV71ePG2g+T5MBuS34GyW/WI62MwPnmW94bEsCOM2txulVC8aMXQZeRqq/H+xwZOP
         GQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619575; x=1744224375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o31BAxPc1jxMK6zymf4qyMVSyHB+1btky9d72lcB3Yw=;
        b=NySc8O2H6TiGtW3YtqGphmRYGUOMC/rOZkvcetRSWuTXG5o9U0Qq0+GyMIuFKPUFHT
         nwBGojdkzd0oa773hHjAhtgmIcaGzuAC4J1plCVqX9UlXBvFWYwXRIGS4kkzg6ZQpKwq
         70e9QEgjBSDkFYiOrouyC8Q3VkvhOfkvGQ83VVWpyf3DjHNxO9nEa6DL76AdFsIonCsT
         b+56itHmo7ySuSIRAl7ibGSTm7MIrGL31rCsBMdDsL9QBbJE94/ObaOUQepaVulTp1wd
         sQAOzY5JOVAzcCwMYEBP9E4Ywjnk4y+kjCo2ntpaVaOKlPWIPGwR5vTPDmoNVwcXgMGw
         hASw==
X-Forwarded-Encrypted: i=1; AJvYcCXBsoeQztLWgkeZj8TXDcDQf5EJxC7zIzPSlxX6/uJLNa6bc4W0U3XMhIm0GrtBPjyfFBcTgLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8whSOlh6EDNWZkE1dF/kDVBs1Xmk7TvPUxg/18QzWQ82lf4J
	hjcvLZLwHJT7sbmchhDRWhOBlqVG0cbk9j2k18X35f6dabv9cGpwHSudnSTurrOjOyVg5Uv2kzP
	Y4/4eLRHsaDO6Kk5kCvFD1icOWoFeqnwefklY
X-Gm-Gg: ASbGncsvC07ll61L/W6S3oj24WgTLaLn6tPsa4TQAujMucpqWbw7JCmNZweD0Gupb/U
	Md7TZZp2CtWqWbzo4cCaiuPa+ZVq6MbQ3sdw1txV4LbKSYAqTBtmPLae2fyjS/ZT1EC1GKPa+u8
	BvCZAIw2ZIhRwQK7uGL0+9fBRxs5AHD+we4fbcnaLSGx7q6S9bwX+4f9iC
X-Google-Smtp-Source: AGHT+IHGQ1JHqdiG9puv//W9TEA/Vm1YPHYXACeMqPyaXetksEKekpKti3NSYJE9pq6gWutMh3w8CA+VHNl33vptR3Q=
X-Received: by 2002:a17:902:d48a:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22977604576mr240445ad.9.1743619575129; Wed, 02 Apr 2025
 11:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331194201.2026422-1-kuba@kernel.org> <20250331194303.2026903-1-kuba@kernel.org>
 <32917bbb-c27a-4a65-8ba6-1df5c4729c12@gmail.com> <20250401080036.5aad536b@kernel.org>
In-Reply-To: <20250401080036.5aad536b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Apr 2025 11:46:02 -0700
X-Gm-Features: AQ5f1JqncX3jsNPZiXIaiNNSmcd6EgAtC2Ur3zdQP6nSQ1iEtqxjcKU6-0DcLoM
Message-ID: <CAHS8izPwADTAf1NxRXECDhYQNRsNRq-A2Cwzq7Hy_b=Gjc_pJg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: move mp dev config validation to __net_mp_open_rxq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, ap420073@gmail.com, dw@davidwei.uk, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 1 Apr 2025 12:37:34 +0100 Pavel Begunkov wrote:
> > > -   err =3D xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b=
,
> > > -                  GFP_KERNEL);
> > > +   err =3D __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
> > >     if (err)
> > >             return err;
> >
> > Was reversing the order b/w open and xa_alloc intentional?
> > It didn't need __net_mp_close_rxq() before, which is a good thing
> > considering the error handling in __net_mp_close_rxq is a bit
> > flaky (i.e. the WARN_ON at the end).
>
> Should have mentioned.. yes, intentional, otherwise we'd either have to
> insert a potentially invalid rxq pointer into the xarray or duplicate
> the rxq bounds check. Inserting invalid pointer and deleting it immediate=
ly
> should be okay, since readers take the instance lock, but felt a little
> dirty. In practice xa_alloc() failures should be extremely rare here so
> I went with the reorder.


FWIW yes I imagine accessors of binding->bound_rxqs should all have
binding->dev locked at that point (and rtnl_locked before the locking
changes), and I preferred the other order just because restarting the
queue seemed like a heavy operation with all the ndos it calls, even
if it doesn't hit the WARN_ON.

But the error path should be rare anyway, and I think that works too.
I could not find other issues in the patch.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

