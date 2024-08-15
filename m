Return-Path: <netdev+bounces-118965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0439953B03
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40036B23DFC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21D78C73;
	Thu, 15 Aug 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aZGWwxZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D44C94
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750984; cv=none; b=Hk7EBxRh0iKD318Ta8YjWx/NHTWHXmhHuZN5hhopqKQCt9PSKGDGrIRqo9+ZlCg3LHgGsvLLU8JLifClDjwTstuhPK/TGj1xgVLVQ6z+TE1Xra3oHRARWyZ4sGm+P8vv/hxI7bqEYMkb/s5brISkc4/JAzIGfarhoogmuLY6qC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750984; c=relaxed/simple;
	bh=sEyGgIsx4I0i1iKMrpzB60ko2kOeXUeaYFB6teuKaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGy0OfpapDD+gAKr4XoEXsTox88TDwRjFeoDaQyG1IN2Ow701DuySaOQPDuhxHcvg6n4kafVduEy75I2XaWr/ToAfWCw3zIqN+F0mnDWVN3ZO/OkGlV6ukpIn7M0J3AXjuW2o0kNy+il/o+jZ5Mq1gar1G7w1rfUjJ8FIk86R6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aZGWwxZF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so2104611a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723750981; x=1724355781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEyGgIsx4I0i1iKMrpzB60ko2kOeXUeaYFB6teuKaKY=;
        b=aZGWwxZF/gNufBeaGwJHFUHgOO5roAoB8OcPfnTxg4jIFUuKrotAq+o4trK8kmSJDU
         jOr9/mw6sKDJZWyKnReT/o79nfSZxvsm8Wry0dg9fqeRJ5KviJJrqts6zqNX1iM6670o
         wYOEym83lbf0JzGZea/Q698yI0ugvyoU1tKidvOcFxvdVaFGpzIbSOaZlJJaro0zEuEV
         hels1Z0MElXpBzqozFc3unW/e+g3sw58PRRAwr7hSa/Bw5GEHGAtRLnZhO3e8fyqyQhn
         9ekJpRn4Kgx8ISA6Gjxk3eVU356ctgBUFMvfll3XsaFmK6PFk+YCoRUJAwFFrSyLL5DL
         Anrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750981; x=1724355781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEyGgIsx4I0i1iKMrpzB60ko2kOeXUeaYFB6teuKaKY=;
        b=JkaQU64Cz+s1jyw7uonG/DUola1zm0tsDIUgUyRJXZc9pbq3hPO2h/jxb+IWdS1Fyr
         swR5f+Ob3g20+6iIqx4buetjDJ0TW7YyxAVObCHAefANaNkTEl0Uzxe8l4rfe51HEHtr
         00c8kOKt2AUgp0L/f/xaeF4+szAZkzIVbDT+BudTx6jq03EFNoBXTN6Bugvffakp6rOG
         TUEPv0+7s8Xev9YhcJXFLo+lx38WNQ3r0apD67J1i2I0I3eYpFBrsGIRUurnnwMpCleg
         9RhFhc5cmnt+HhceSrQUs0EFahl+N4QB+eHLHNIh4lk7rkb2+mH/ee9mobMCT/Tzo6be
         1t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOP1ksHdsXhvwY0c6M6i7NXgoqNjbdrKehX8C8y5plLb4+9A7lsiCQEhCGbkqXfjGwfQYeAMQcVMdLqFMYsSeZkdQ9TTya
X-Gm-Message-State: AOJu0YxsqHRjgVx9Pq619T/R0kKPqwzbRzWyMbcYcZurHzvqZAEaaz7N
	SwVADWxnl7tQYvCsvruIzUTTmiBiwTvtcfJII0o58ponzroj3P20PHvMZ++uJRIKrSfbVfWs6uM
	N3RQUJ2RBeWPFyj5SpwLD14pVRM7Vxn4OW2S9
X-Google-Smtp-Source: AGHT+IHe9tB9fPoSHvMFHqoGuRET6sAyFziPG5D+6p2mNSNAZLZBMFrN1dWKk0OAzsZycakW1HBGJf1XA09Asum5Se0=
X-Received: by 2002:a05:6402:1e89:b0:5a1:4ca9:c667 with SMTP id
 4fb4d7f45d1cf-5becb5edc13mr308280a12.11.1723750980553; Thu, 15 Aug 2024
 12:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <20240731172332.683815-2-tom@herbertland.com>
 <CANn89i+N2TGk=WjyUyWj=gEZoYe2K2xYPw+Nn2jb-uDf3cu=MQ@mail.gmail.com> <CALx6S36HFR2TnxzHuf8x-76VSBTbEZDF2pJEpSp400PWBS83xQ@mail.gmail.com>
In-Reply-To: <CALx6S36HFR2TnxzHuf8x-76VSBTbEZDF2pJEpSp400PWBS83xQ@mail.gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Thu, 15 Aug 2024 12:42:49 -0700
Message-ID: <CALx6S36CPBvPCTGfzOqnkQpdxtR+2oR6z5Fi+OzYHO=TsK2Qww@mail.gmail.com>
Subject: Re: [PATCH 01/12] skbuff: Unconstantify struct net argument in
 flowdis functions
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:50=E2=80=AFAM Tom Herbert <tom@herbertland.com> =
wrote:
>
> On Fri, Aug 2, 2024 at 6:34=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Jul 31, 2024 at 7:23=E2=80=AFPM Tom Herbert <tom@herbertland.co=
m> wrote:
> > >
> > > We want __skb_flow_dissect to be able to call functions that
> > > take a non-constant struct net argument (UDP socket lookup
> > > functions for instance). Change the net argument of flow dissector
> > > functions to not be const
> > >
> > > Signed-off-by: Tom Herbert <tom@herbertland.com>
> >
> >
> > Hmm... let me send a patch series doing the opposite, ie add const
> > qualifiers to lookup functions.
>
> I had done that originally, but there were a lot of callers so it was
> pretty messy.

Oops, I see this was already applied. Thanks!

Tom

>
> Tom

