Return-Path: <netdev+bounces-130877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247598BD73
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEC8283782
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD21C3F04;
	Tue,  1 Oct 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXiUbZKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1FC2E3
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789230; cv=none; b=gSOhaSyxTAf//H6MwPzwMO+5f6bBsCK24Jc7JsGbS1qB5XeDHfJ+FCb0RFae7mdJOY7S34VJKH0Ynj3B57Gs6YsGGBHMTMZn/OBlGzekwmpn4rJfzn6CHfnQYCmR2ZpO1LAdqz0Z1gi/JsWOq9L7NqbZqDK8AEaOzRwyWKfuZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789230; c=relaxed/simple;
	bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3n+SfveeQ4tHj9NBTp+Ci59TeaMydifuzNoaC7QiP+jjq5QDW6FeHpw+PosD0QPM/n4F1ZemsXKgG0yCVLIqakrORIB1ACI5gFptRHZL4c/GuBm+uzxOhbtxEbWvU+4WsYPcoAcSvQrbTdU3Io1fj0knS1VIN3YlS783pymCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXiUbZKK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso5596206a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789227; x=1728394027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
        b=JXiUbZKKPKq+tbRCZp9ZN0Dq2h6lPPXMAQFBQi9CyVpwi7YY9nX+/9PQdQVOog3cGA
         MWyeT58hyUloMAeNDwgHV5ytbN3g8TPsU2ccghodXGvAbuIkF7QQBGu1AepQP1K8Vt3Y
         Dcz/iOwT0pOIQCnnGNWs9fR8SDFRrQ/24cCgkS8ch4Pd/JbdpUzyONyIi1pAtMbB0Xle
         NYmO/8V/EOHrQ9Qg15J3ss2TXE1NxIdm+Cyv8AyBsMhG8V6f9kaxEkF9Wf0CSd3x5JGo
         kupYJz8EWm3MoO8Lvk50QyCUCnmjke+TmbMPmX1xpKLsujPU+i39VGHyGofxkUM/Mnn5
         HRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789227; x=1728394027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4WSEnDpuB4eGtxy9YAw4aeZCRyT8eL+xWjfdg1QsNw=;
        b=WxM9Y0qYsYMvVfh08HIJH23fXpNBNesaEV59DVmzFrqtlh9q5FP2XjzqVhzSTrIdFO
         ld0qVoSJumB5mmBkBCHhyl5exMwB1QMqb7tf915+VWAumANlaQsVfOEREcPDeIGsqw1D
         Q6fcBKQSRZebsa80bDNttiNyUwhb9e1bLXfmlLYM5XSriBowQrfXWIHXzLNSepLHX8Z1
         5ZGxZMZramPs//5djZhN4KRoG0sd3iwxh//V2tax5PTfOTGQbkGqO9SElxdgl9h9bYh2
         M3+jSGMUcsLCuKH8TXL9Uci7PBtiIYKNKjT0pnbnRnQeL6U83X2TE4r5rqawwrLaD2F9
         iJUA==
X-Forwarded-Encrypted: i=1; AJvYcCXxzSSSMT2FkE2HGkHTT9Dcqlkfhp9OuX+Vnyb2U9rTGsLD1M/zNZ+uOCYLXpShWkum2dXey0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1pekA+0KT+PVZSdAAXeMxqnApyyFwMQig5u1S0Motp+5njFR
	N3om6CUt+/LwUSVR4W6LLN1c/spPK6xpxaxrzG5b1+5+knSVdE3mMmtzP008ZcwDdDQ6TVkII0+
	yblrzaZ/Q4XiY22/pimER23Wx1uc/E5Y/BYu+
X-Google-Smtp-Source: AGHT+IGkw0e9HglM1R2Hwa0tlntKnazumrMUcOEW6TH60bfpnaXkt29tvx7Cfut1P3x3OVT2Cu7hcKnSpjImRfnjSTA=
X-Received: by 2002:a05:6402:40d0:b0:5c5:cd34:48d6 with SMTP id
 4fb4d7f45d1cf-5c8824d0111mr12511337a12.1.1727789226905; Tue, 01 Oct 2024
 06:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
 <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com> <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
In-Reply-To: <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 15:26:49 +0200
Message-ID: <CANn89iLC5SgSgCEJfu7npgK22h+U3zOJzAd1kv0drEOmF24a3A@mail.gmail.com>
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:50=E2=80=AFPM Stefan Wiehler <stefan.wiehler@nokia=
.com> wrote:
>
> > OK, but RT6_TABLE_DFLT always exists, ip6mr_get_table(net, RT6_TABLE_DF=
LT)
> > can never fail.
> >
> > This is ensured at netns creation, from ip6mr_rules_init()
>
> OK, but nevertheless we need to enter a RCU read-side critical section be=
fore
> ip6mr_get_table() is called.

This could be a lockdep annotation error then, at least for
RT6_TABLE_DFLT, oh well.

Note that net/ipv4/ipmr.c would have a similar issue.

Please split your patch in small units, their Fixes: tags are likely
different, and if some code breaks something,
fixing the issue will be easier.

The changelog seemed to only address the first ip6mr_vif_seq_start() part.

