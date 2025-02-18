Return-Path: <netdev+bounces-167430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B44A3A47A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404D116F82F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F426FA75;
	Tue, 18 Feb 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7wggzbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B3246348
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900327; cv=none; b=VdzEIBXMsQ8xy+1OaG1MblWyf78Kmp/LuRc2l1AhWuD6+FupEH/ZUX6f2B7PY6ape7LOh1oX9v5fJOtbEX4QsNbZmC1+sLrhPyzzZH3D/v2jidahE7o49dIxX7i2G1SiDjbp5hXxkWNLRsZIK5NlYGFX4V8R4ePpEQwPpWFLXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900327; c=relaxed/simple;
	bh=SPwAYWh6grl2C84gS+iSBukMQoYjvnmKDV5GD6p3bQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiYxupqUqEnABGl2dv0aHb5CmQNHvvq9w5q36myCtBSmrSIlquCVRapaCX6wAVgRcCFRKi1Fnxuu1VAqo+rSfNdn/J+cxSFRpoU/8GKxqcgCmnNZM4P+VyUnY1hD6GdkYUNnvm43ir0LcsDY2jvvKoF3tAl4PI3NjjY6/uGTaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7wggzbo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso4475739a12.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 09:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739900324; x=1740505124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPwAYWh6grl2C84gS+iSBukMQoYjvnmKDV5GD6p3bQs=;
        b=c7wggzbo99AtD5R92eIL2dO7wwCwlDhtIBxSLAXmVNnM3lK3M2Hlm3Qs5MTsdyegaM
         6sGwt+3ZCehkaC/OEEZkP2eLFJoh/rNtYJKZpANfR3ijuzbESqWt4+oGapHXJVEhPlR6
         6z+8GqPwmirt9AujUUNsFjr7KF3hdNjm4JqPRGIhIyF/AUCdoFd7Imzr2a9f7gWq1ZFa
         KS1ax0tc+qshrZN8fWUyubYWoJxwWWnlZaPHGEYeoFqXcJ0j5KE8suNkF5vAvYfqBDob
         KXQQJxYUC/MPzk6/v7BHOMy4MFIBUHE+ahDlLmJUj1+TxfXwfU3Gv3SQHOhgwFh+6eEs
         FVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900324; x=1740505124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPwAYWh6grl2C84gS+iSBukMQoYjvnmKDV5GD6p3bQs=;
        b=t6f1mWAyMXiMRDAw2aeSxy8ei1qcp3MEc60Pu+jPuUfHzJeSENcUINOEGvPhHKQWYl
         EwYjyuu1eASgdAr52CuXnLGEWDPn1FbN5Hz05N5IxGh4fQDw+ulaJZFMG8Wb5cm+SjAz
         6jdF1guV1HjDkqVzkh1/Cy8gbq8AuS3dqIKfW2oNPjxQ8dHwCzfYL7HBnrrrSc00tSa9
         vAZ3kqGsS3NdHLznKg3BVfD0Rw3LU6wylW6m+KSckOrA4qq2mKzK9cZAPk3xDq0Zua5q
         x7OAwpEuMJwhFqF54URIHH/6fL6zjN87ghnzdjKlP+mJSgO6gSD9HacXIrkPwwqzEcjw
         +KAg==
X-Gm-Message-State: AOJu0Yyuy4cqqoTuxujPZ55Sf0bfISagMduiPTJGP1fggwjljKgDwUmq
	RFQ+Pf1zGhm3xmlut3NyYVAvjgU9awaHJ4t4UbJLaa1OvW8h4XNiE1a5HOeTyt4POV0VMhTEqIN
	XoBYReAWLExZx/0fnjdCSnXv46DuLMVNLRyGL
X-Gm-Gg: ASbGnctXbB/lZZdI9eQVJdouHeSYmtGEMmoHT/fF284LNyiLWt9rPE29WSnoFe5iyx4
	CJoOv09vAplnW5h5+RCkYYt5LBLFQejInt256nNcEz6EBBxbA9N87g2EBO8RgAUB/WZeFgf2d
X-Google-Smtp-Source: AGHT+IHf8xCyV3QcP62cNKoM29Jy1+OrHSOHiqvO8vfrrIg/sN+KeSdjxaAwCNHsDTc3puzafi/q/Vx/uBOZBOnFbcI=
X-Received: by 2002:a05:6402:2812:b0:5de:e02a:89c1 with SMTP id
 4fb4d7f45d1cf-5e089d39997mr244705a12.26.1739900323583; Tue, 18 Feb 2025
 09:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
 <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com> <CANn89iLbe2fpLUvMJk-0Keaz1yvWb7WUe9X-3Gd5wmNQn7DN9w@mail.gmail.com>
 <389ee8e5-8c25-414c-ae19-7dfeebecf1d3@redhat.com> <2f3b3cef-e623-4c02-af71-9d1f861075d1@redhat.com>
In-Reply-To: <2f3b3cef-e623-4c02-af71-9d1f861075d1@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 18:38:32 +0100
X-Gm-Features: AWEUYZlugvNpkmXW7i_FIQNfvKLqCU4G6__1u-AAS9-xP4whmWKOZWZ_35ACam8
Message-ID: <CANn89iLDW_UtHUbgT7+4zUYkUSF=KtqV--_A=GcAvwrHVZ6-kA@mail.gmail.com>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 6:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>

> Please ignore, the needed config is actually quite obvious. I did not
> take in account that my running config here had a few common options
> stripped down.

Sorry for the delay !

