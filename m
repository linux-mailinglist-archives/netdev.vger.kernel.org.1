Return-Path: <netdev+bounces-218336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90BB3C036
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8577BF89B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E221C9EA;
	Fri, 29 Aug 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vrsn1n21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0620010A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483440; cv=none; b=a+vSWXCne4v7Ac0clLJsiHXYvdTJYzqYJSrNbXlTT4h0wBLUwVkEagKwnD3A7yHLH0cHfTSrPTgZDC+VyhsshFY8RSegc65AIfzGTASgzN0MThkMEqG9SQvGx0uNADY4SWQSVTcqXj32tcXXSRNoXmB6N6N/KRiclmZ8U92cUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483440; c=relaxed/simple;
	bh=lQmn3opJnZN0AilYuABvGW+cV2havGyYwFchvAfAtUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoPpb93V1TZuXXtxF6VnXcvFHKB+FkS+Pdnq2p0z7mhT2a83H8iYKCbgmi2kzHXPEMoaqaje2yZL/GE10rsUrKCKzukgjf1hpvl23x0jXxkagHaJ8D3JoO7nzF1QbQ1TPD6+gnlJxYpTTiTX/gTwKyyjHZ2ld2F9+5dE4ZmDxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vrsn1n21; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7f777836c94so210708185a.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756483438; x=1757088238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjqzbl/09WfGlj7g9RWlxEQpyZ5BEnCI8fQ3kvaiBe8=;
        b=Vrsn1n217a+aWtBDuaqU5tzs355kPHIY8DSu9bDOOc9PmxpKTMvmAytYQ1FqyMX7mT
         v2Wpyz81P8oGqt5l4VqpCZrVuytv7YBf/1c64vTBT0/Zh4hQNP9hN64j6icINZdKSfy7
         dcWSF2TLeEaMl1lG9VP0vsnkOAFQegOB9Um5tF4nJTgo6/lPDfulZVEugbwAqt4jVXIH
         9zKn6VAsEwkMJhbvp/yrJwn8l/jBeMON2xeTRpHrOOAzFtPuCNiUpge2mVzPypSkUEII
         5XEseTXikWPgfzxZO4llDm6eWQE0KVWbIZ8ImFdS8JOuJN/kx9DNRFEoebfm0zRs5Nd+
         XoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483438; x=1757088238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjqzbl/09WfGlj7g9RWlxEQpyZ5BEnCI8fQ3kvaiBe8=;
        b=OL3Q+q7tWOG15DLm691+dv3HKcGD2l4vXXk9dNx8MEkfCeNFcMRbJ27VKO4kyuzt4Y
         T1pLflK1e9VyWZlmmj3ey975bljcgXN+Df/M6/a9MWUZW6nN2kODZc3usyo7p+OJB5ut
         DvLW48y2LjYBCICY6HAoZ4jsvPXF+qaMXFMAVSNXL/OHHEnsQqzvSvSepsc/F/kQRR3T
         Md74lmoo/vJWp/ADDl8qutF0E0a3cjkYLuD4aGvcz97OrWh99tsBu/7V6fqSCStfGN9h
         puY8+gYJK40togBzzuH+IxU6gCQEr9v/a/5VEoY0RDtpUBfADFCG8z7Y6MF+EjfDqH0x
         I1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsCY1+JJEHY6B8/SgD8sMeQl2IzCAggVXGTjjBX+Hw+LHKUB2YtBG5jOuu2Fn2wwnalETpEPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCq0GfMS7Iz1KiQ8JMHxoYLGOw44lwZ54eYGslI8r1EdNxl+1R
	tvQMmaV75FYAmtQpSQpeLV3PJEX1oDCYAGI/ZYD1m2p2mZv0JDVCl9mJkXJ/Zzg+/VKtcvoZa9P
	ELRDRIYRVbZ/SBI7Tnu+gV7u3GUoNIY4Sae+Ehirt
X-Gm-Gg: ASbGncvFlkiiBNsEn+Hx6BaussjDPo3GBLHb9BzMghhcOVBG4tXfW551NQY8fS8fjlc
	83hi5oAHrrX2TUhgFL11JSpCOG7ZttH9nJwxO0x2xo9ThAa/mxw3EHLZ9fHpFmGUF6LhjiCgnlo
	ILxL6NjLjFtUgj5xG+keEMnfCyTL/2eXG1jalOUagURPqKQU/8PEBv8O7TaZbgegPZM7vV//TfI
	ltVOjlhob0M6DmqFT9pG2edeDiUMQDsFENvZ20tXahPUDAs
X-Google-Smtp-Source: AGHT+IGa7i0BE3N9Yc0VQZRUvCU99ec5E8p8RshPkHfbnwCFt/tfZm6Cj2eXpPAf+q9HmAHpVb7myF7u6s3lDTNtrnM=
X-Received: by 2002:a05:620a:ac15:b0:7e9:f1c3:6851 with SMTP id
 af79cd13be357-7ea1108f69amr3297242285a.71.1756483437395; Fri, 29 Aug 2025
 09:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
 <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
 <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com> <CANn89i+-Qz9QQxBt4s2HFMo-DavOnki-UqSRRGuT8K1mw1T5yg@mail.gmail.com>
In-Reply-To: <CANn89i+-Qz9QQxBt4s2HFMo-DavOnki-UqSRRGuT8K1mw1T5yg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:03:45 -0700
X-Gm-Features: Ac12FXwGtAsUaUlBr_2Lw4clg33WfNdUv87YMBjx00lynDTqLD7aZnYW5JZ-li0
Message-ID: <CANn89i+nNZx3QftApMcyb2PBopO=v+4rR-gKZZTbUReZjT41Fg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Aug 28, 2025 at 8:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, Aug 28, 2025 at 11:26=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Wed, Aug 27, 2025 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > Followup of f45b45cbfae3 ("Merge branch
> > > > 'net_sched-act-extend-rcu-use-in-dump-methods'")
> > > >
> > > > We never grab tcf_lock from BH context in these modules:
> > > >
> > > >  act_connmark
> > > >  act_csum
> > > >  act_ct
> > > >  act_ctinfo
> > > >  act_mpls
> > > >  act_nat
> > > >  act_pedit
> > > >  act_skbedit
> > > >
> > > > No longer block BH when acquiring tcf_lock from init functions.
> > > >
> > >
> > > Brief glance: isnt  the lock still held in BH context for some action=
s
> > > like pedit and nat (albeit in corner cases)? Both actions call
> > > tcf_action_update_bstats in their act callbacks.
> > > i.e if the action instance was not created with percpu stats,
> > > tcf_action_update_bstats will grab the lock.
> > >
> >
> > Testing with lockdep should illustrate this..
>
> Thanks, I will take a look shortly !

I guess I missed this because the lock has two names (tcfa_lock and tcf_loc=
k)

Also, it is unclear why a spinlock is taken for updating stats
as dumps do not seem to acquire this lock.

This could be using atomic_inc() and atomic_add()...

