Return-Path: <netdev+bounces-204352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B60AFA201
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19853AE846
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044E239E99;
	Sat,  5 Jul 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="S1Kdg+SM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2044189906
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751750661; cv=none; b=iN4rInEef0Km2YT6jRvQxYmLS71msic/uadDiyINUtfooZK0AvaceIdmXIf5fsP0CtsovLeSZZH77FJmu/AzsBMb2tAShZ5Nb9F9aVQJ+sa1YVhMle2KuwHOyihHH3MqJmtLx2+OFz2OOJ9kI81dLNESdB8iYs1WvcVp/u+y/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751750661; c=relaxed/simple;
	bh=AsrfOQcjN8R6IS5Xn5V5zqjkKRW0iC38yztpjCVJ+so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yiq0DKfNLN7IfqumDlJl1ltkC8YBZAd6bKyblvezI0P4nKp4/8ICfSNF4oafvbb0p1Lcrrb+JiXE+OYAEW46HGP3Odz4qHSLge+rgvOT9mgcJ52kcLOu9L/ZoB9Vpkg5TrCemnmqNAPSE035cfNDWtEAgFm01tswFDzpu7fNQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=S1Kdg+SM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a77ea7ed49so40197531cf.0
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751750659; x=1752355459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :disposition-notification-to:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyvMA6zN/L+TamwoiI6+GUF+wHHi++KV8KKferm8P1M=;
        b=S1Kdg+SMGNg3rxmfS3UcXfUPYW2mcGvko1YBnkdhLeJRFjENMtjX0YlBWLbk86K4xT
         Wugfw7tuFfMfvLhtTXIBm/QFTORzMQdG2ZlBRh+/l+2Lt1DPlLmPVgkAYe0zLhDvgWQU
         GKuGz+S0qk0t2Q5uIBUqGGbEvTRdKnGBtURkmavBbMT4nlzChwMFMZK18B5e79dMFOGD
         qB6bOzYSVvWBxOZPjMvTo30mxWfuAFn4ztaiDwzviqT7dd19JwHDCOfIey8QyNQS8d/H
         4Mg6daFPTBLBUn274ZybXHeASAXOIs751YWZSHqKfkrUkYSd3ScxLGiecQB+is7vU2dq
         WMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751750659; x=1752355459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :disposition-notification-to:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyvMA6zN/L+TamwoiI6+GUF+wHHi++KV8KKferm8P1M=;
        b=QgV9C47Xw0eQ6cir9q/wdrkqmPsm/Ak3n42Qa2yEzTssT49PJ3IsNpOrpldaWSDhJb
         p6IisLJttUOiVl2045Sd0oy22PQBh0+tDNeSq+b7fnjwTAcN9sAbYBjH1JqWzbMCUzZC
         7RtiYBEWaII5FMDlqmBbsOILAL2shJX6wh0x2YoBuvfu4D6adASFK4ARQnXliVn4vF+3
         kxvMDdda354ixndrG/bkpjM6Lrynv9Uhmf+q9B9vkwEdlcfCWbCT7HU/Ixg4grtkB2cb
         mWwGKxIKgOJH7HqpenxAdWsz+TpfFpp3jQ1kKlbYObUwFbzfyrTZPMojPVRJa8yfURdA
         +WkA==
X-Forwarded-Encrypted: i=1; AJvYcCWFjvTViv1EmvCEypk6B1/jwDrxnNWvJjhkez6B8wMzZzqbZdM2im0Jlg54ppljxUuVu7uZj9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxudcrJFpdq3+YuFRQD3yYEgt59Zd6Jy37JD7IvNFmL9RVq4wO
	B59tMcWD3TUwBD1H/mNTw+/k+UNT+bUQBNsus5LP9VVsdCp2x4j6cToYReXWZSszinwL7H2ayHo
	ZOsB0wrIapAJQv5PNc3bFhjwCQDiOsRYA23IOOn4+
X-Gm-Gg: ASbGncsnn65gws2axAH/Gf5c6MUSSkfKv3y1vWyoON8uYEvyNAOUjdqdr3j4c/JCkHv
	fWa3V71Me27qHfyF5/+T/W50/PLRb+0326sUuqOlATB0niUOUYLMlH1iisQH86m89c9+qFsTYJs
	sR4MPz8Ye1CY9wqRysO0FvfnQvauLySXR/xFizn3w2HA==
X-Google-Smtp-Source: AGHT+IHcg7BeYW45upMxRau4qdqZ57Fb0IRHaRFwALUFw6VhQets/lQeCgEhlA/bx6NODk1tpOq989jPTQl9DVeOCJw=
X-Received: by 2002:a05:622a:4818:b0:4a7:7326:71be with SMTP id
 d75a77b69052e-4a994e738efmr118301691cf.5.1751750658836; Sat, 05 Jul 2025
 14:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025070255-overdress-relight-21bf@gregkh> <20250702083001.10803-1-xmei5@asu.edu>
 <aGdceCwEZ/cwzKq9@pop-os.localdomain>
In-Reply-To: <aGdceCwEZ/cwzKq9@pop-os.localdomain>
Disposition-Notification-To: xmei5@asu.edu
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 5 Jul 2025 14:24:08 -0700
X-Gm-Features: Ac12FXwDfCOr-Bw9bs9rNv9cASQ1Wamt_d2yEKYVm75yx4vI8NtUK2ozrUFXF84
Message-ID: <CAPpSM+TOikVgwiCFZSAT2iON8JBdRuQ7dRYaMJh4KPvT+jPs9g@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix null-deref in agg_dequeue
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your code review. After reviewing the purpose and order of
these header files, I found that your suggestion makes more sense.


On Thu, Jul 3, 2025 at 9:45=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Wed, Jul 02, 2025 at 01:30:01AM -0700, Xiang Mei wrote:
> >  include/net/sch_generic.h | 24 ++++++++++++++++++++++++
> >  net/sched/sch_api.c       | 10 ----------
> >  net/sched/sch_hfsc.c      | 16 ----------------
> >  net/sched/sch_qfq.c       |  2 +-
> >  4 files changed, 25 insertions(+), 27 deletions(-)
>
> Looks like you missed the declaration of qdisc_warn_nonwc()?
>
> $ git grep qdisc_warn_nonwc -- include/
> include/net/pkt_sched.h:void qdisc_warn_nonwc(const char *txt, struct Qdi=
sc *qdisc);
>
> I suggest moving both inlined functions to include/net/pkt_sched.h.
> Sorry for not noticing this earlier.
>
> Thanks!

