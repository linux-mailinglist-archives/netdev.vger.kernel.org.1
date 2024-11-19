Return-Path: <netdev+bounces-146323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EBC9D2D85
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719BB1F260D2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6791D14FD;
	Tue, 19 Nov 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1LtgXUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50F1CF7BE
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039486; cv=none; b=b1CNtXSPUZeaKZUuFaobuXi9bN/8uAELGVaAtbKqBjnZIofoZ+RMZD2WUY14aWgVaJu2h3C0kAaxqcqODX/YmWP/Mx2X9LiQC8LlNZ+SQKBrWyX1az0J3jwRT3uQuaU5OQe+cY8k/Krx1EyWHDozkqh3Nhs1rwD9attWLB+jTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039486; c=relaxed/simple;
	bh=T9H7J35boGQ/S2lh3DCWExVaNekUfzLOlJkJdFAwyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObnqpXFSYxvbbV9jd6T37aqIxQoSY5YOM/iEHt16hAAFnhczGrYUwYvZDT4Dm+SyeM6Ul7rDQFx9Xj6qKYZzNeAE8blYZ/lrQ5+wJk15xpmVq3fSME/47oxGvKAbDAt6bWoV5xziWX7TnN3jwtf3S4uQaz/sWwS6OXtw8fN/Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1LtgXUb; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e607556c83so742405b6e.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732039484; x=1732644284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9H7J35boGQ/S2lh3DCWExVaNekUfzLOlJkJdFAwyzw=;
        b=Q1LtgXUbnW77xwADbwNNE6KL3Pp12f0vxexDiN9sKeuKeHjrfzqhd6ENapkDsy06Kx
         N+MlAozWJYau3nnNQqMDTazhVWrLkep8HujQWL8wY/6/Sfkf8roghdGKhVAJ8yNTxcOa
         HsSWDsz7PCt/rjWXqXDxWKduyx8HzVNnMHk+oMN+eNDks3vVMfAJcrgvNOwHveznrBWn
         jd5IsXl5Nv72eggUD1IvRz31PpTHLgCJKsNRbIY883aNxWWasc3pXVYQjSbcveqH0Ipb
         UAREsBnKLCDdAB9AkkU3bbpEJ7Qdz1ZcqNerH3zptxm491sU4PTQ64mt4BFh5ZzAhQgX
         ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039484; x=1732644284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9H7J35boGQ/S2lh3DCWExVaNekUfzLOlJkJdFAwyzw=;
        b=iq2LCauO8yYwbJ135Ghw7dcagvQ3g+YRolkrKK4cg53qqxyMkO114Uo7eJZ1sItzCd
         jxaTWujM61DhxJ15bvyKbajG2NJXOXM1BJEWahpiJp/0OXQiPA89lI5Sz8z2Cola3Iaf
         v9bDFd1o0191+mF3OdNfaigNF3wt6+sutd0Q9pGVIS3kigMNAVVbJwSSZIehWHzi1DQi
         cg1h79XyFPG5cnxrG8PM0UspZY8kci2SCQsHMOVIr9Qo5/FvRfzDANCvvTa3MiIip1Gf
         YSccGcsJFLO5IWQKxrrQ6GakNwv4VQvhqqrZ0RMOHfDJVr1cdXHkC2XcYiLrpg1nUp0e
         ziTA==
X-Forwarded-Encrypted: i=1; AJvYcCXfKYGIBxhRGK47c9Nchwao0pTujK2oBJ2S7HQMe/1l+w13vVRqsoW/gFBTJZRYCyk//BBGYPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwj2hPrJgfhwR+uxDY4VD4FqovHm/Lyem8H9woczR097dxu6b
	qivDcGKaTJFjShiLwRy4N/atyXnnj1GKyhV3KeFQkdkDZn1hH0Wk+viRkmZEgITV6lnFBYjP4CM
	LyhHA72LcQKjc8HajJx/5tAQq9zg=
X-Google-Smtp-Source: AGHT+IHCLKcX+haFD1McFVPUfGnofTUCmgA179ydnpbFnlvjrqkbUDXdD9lpqzIXjNSURrUI9NjLFVjxlOK+Jw1OLPg=
X-Received: by 2002:a05:6808:1b11:b0:3e6:3647:ba55 with SMTP id
 5614622812f47-3e7bc8546a8mr15820067b6e.32.1732039483856; Tue, 19 Nov 2024
 10:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder> <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com> <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
 <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org> <303f83f8-e2cc-4a33-8bfe-ba490f932f18@candelatech.com>
In-Reply-To: <303f83f8-e2cc-4a33-8bfe-ba490f932f18@candelatech.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 19 Nov 2024 10:04:32 -0800
Message-ID: <CAHsH6GsiQGwP329zW2ZTB4q8fQnJm4dLRbZFCOvT842Z=LdDyg@mail.gmail.com>
Subject: Re: GRE tunnels bound to VRF
To: Ben Greear <greearb@candelatech.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 8:58=E2=80=AFAM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 11/19/24 8:36 AM, David Ahern wrote:
> > On 11/19/24 7:59 AM, Ben Greear wrote:
> >>
> >> Ok, I am happy to report that GRE with lower-dev bound to one VRF and
> >> greX in a different
> >> VRF works fine.
> >>
> >
> > mind sending a selftest that also documents this use case?
> >
>
> I don't have an easy way to extract this into a shell script, but
> at least as description:

FWIW I once created a tool for helping to jumpstart such scripts - see
https://www.netpen.io

If I use it to create something similar to what you've described, the
outcome is something like this (the link just encodes the relevant
diagram info in b64):

https:://netpen.io/shared/eyJzZXR0aW5ncyI6eyJ0aXRsZSI6IkdSRSBFeGFtcGxlIn0sI=
ml0ZW1zIjpbeyJzdWJuZXQiOnsibmFtZSI6ImdyZWVuIiwiY2lkciI6IjE5OC41MS4xMDAuMC8y=
NCJ9fSx7InN1Ym5ldCI6eyJuYW1lIjoiYmx1ZSIsImNpZHIiOiIxMC4wLjAuMC8yNCJ9fSx7Im5=
ldG5zIjp7Im5hbWUiOiJuczEifX0seyJ2ZXRoIjp7Im5hbWUiOiJ2IiwiZGV2MSI6eyJuZXRucy=
I6Im5ldG5zLm5zMSIsInN1Ym5ldHMiOlsic3VibmV0LmdyZWVuIl0sImV0aHRvb2wiOnt9LCJ0Y=
yI6e319LCJkZXYyIjp7Im5ldG5zIjoibmV0bnMubnMxIiwic3VibmV0cyI6WyJzdWJuZXQuZ3Jl=
ZW4iXX19fSx7InZyZiI6eyJuYW1lIjoidnJmZ3JlZW4iLCJuZXRucyI6Im5ldG5zLm5zMSIsIm1=
lbWJlcnMiOlsidmV0aC52LmRldjIiXX19LHsidnJmIjp7Im5hbWUiOiJ2cmZibHVlIiwibmV0bn=
MiOiJuZXRucy5uczEiLCJtZW1iZXJzIjpbInZldGgudi5kZXYxIl19fSx7InR1bm5lbCI6eyJuY=
W1lIjoiZ3JlMSIsIm1vZGUiOiJncmUiLCJzdWJuZXRzIjpbInN1Ym5ldC5ibHVlIl0sImxpbmsx=
IjoidmV0aC52LmRldjEiLCJsaW5rMiI6InZldGgudi5kZXYyIiwiZGV2MSI6eyJuZXRucyI6Im5=
ldG5zLm5zMyJ9LCJkZXYyIjp7Im5ldG5zIjoibmV0bnMubnMyIn19fSx7Im5ldG5zIjp7Im5hbW=
UiOiJuczIifX0seyJuZXRucyI6eyJuYW1lIjoibnMzIn19XX0=3D

Eyal.

