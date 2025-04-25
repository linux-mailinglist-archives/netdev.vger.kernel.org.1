Return-Path: <netdev+bounces-186175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C076A9D5F0
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59041BC660B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F832957D3;
	Fri, 25 Apr 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xTh6vRQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFA224AE1
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621565; cv=none; b=dg9uz9Z1w8skktriP55U4eHgg4Dbf6SEfn3+7tkHC82PI5OCWHvFC2/js+m/zeDuUC0VT7n7MdZpDGJtvy5o+yuO4vjlnfLE8vaBHDzAHfkh9Rt3VJXWFwUgmpamECatalCVpBUNtqVMPgrc9yPc8HtZaqa1NED0CR2J2YZ/9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621565; c=relaxed/simple;
	bh=BfaMo9yLPsnsNnbiyZuFnRq/xEk0PHa4fhiSWWOF+jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GTzY3zSpL5nXL2rnlQ7WjclmwmB5eBiahm1/t2dG2rNYolYOV4H7skqlpWNGobYTbcC6lqiAjDzZ3pv5dWGn8cEtVaYupzMo/tNREmj5qWYpHX2VyZ2DI+DdKFaP4anjOCwwA0PInYU9bltwDzAAFzeI+l8LIJgKIhVq9iTkqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xTh6vRQX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2263428c8baso28265ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745621563; x=1746226363; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NWl7wwmE/kiiyslv+ZlD5ktLIxETB0MXJfTa3Rise0=;
        b=xTh6vRQXFx1ADEIGxGSmQbN9o4WYlZGUmSMt8ukwTycQy+8p7CwOKeksqpaVez9Bga
         93xOsZRHaXr550WU2OG4LD9a/k4ix3U/x9lxiwFc9sMQP9NZC0TICm5W0U3iTJhGf2y6
         Lmu0/KsizXNoQaoCnlVMY7bTnJCO7Fel1f7AAi8vqCBbA5K4Hk2wF44gsiHk5Nhd9aDu
         WuZWfYDp5CiDJzcAiBgbZdiqGJ4enTreA1Xx9/MBiDJjcdplSMIJum2F+1nRqkHYB2nz
         wX8Wgc2XuiLTVHZ3Nt6gXupzDvVAUvGt5KTY8+el/EcTtsdK41ffne8wRCdhF6S1hWT4
         S9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621563; x=1746226363;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NWl7wwmE/kiiyslv+ZlD5ktLIxETB0MXJfTa3Rise0=;
        b=r1n1aNLI0zswZIBq7fuOY52Nk672uS/na0h+H+TBakdKUYCJEuCU9nZMJIHutVUlD9
         Oqa0q0h/8EHfWwzou2ZEioRZnI/ofG+I97N2tbUADSuDAtZ6OBa8xCKQf+DpgSRGluuR
         cgm1Gjysg9fewcSyjAcBDMsBlKtZpPjDnDBmiiin/V2NJXkP5FiZDaBO12FavfG9F7zE
         Ahw4aodbwzINvCho2GIuqjNkNlQVLGgdT5tMYnmN/gjoD3Pa8SFTS882VYruuZlCE0TV
         BZMLK80TDV2HWwIZkTbo4kP9m2bjsPcZBEnLci8efNLV8VC6ASnOx22JJTgSOEc4ofFG
         BsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBKXwae3KXS8bF5NOrC85IGilCpJBkjI07hDPrs1BY9+JLhCI7Rc5S+qISacJL3f9R1OVNCn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhHCt1bVc8H7kGRAEI+y6g2t8UUzw6hmEXHPhB0R2gaUDIpMS
	T1HjG2CsQ3FY2NBsVve1LDcwFrEv8xBa4bY5voMiOHiHy+LtxFeExUgwEU4BZSlcEoTk85mJtg7
	scOmqoXWAXxwN6/Cwu/PgUaTUiDm2CquGWbfr
X-Gm-Gg: ASbGncujkM+NbSopCWnE30V6vh7D3zl6HLh+aRV6ArroVEw+oCHKIR9YsPLPGViEA3M
	/WawFBmTT4EOUUwQByO3jp9BOmizJ3j+2R+0YHdpkJiJS5xC1V+ZWjBjGILv06mVROYR5g7GZuc
	cdP4dwDjCfWapRPgHx5P4HsH/95ohK42AhcmGKyywN8lqQAcDoKYRiFLQ=
X-Google-Smtp-Source: AGHT+IGpzxj7ysQYmeA/o9d6s2gZ0MaRCvmvZVCl+YYenlJsEuq8AdsxZ9BweQ0D9rjdeGIluEVwk7x4iQuzVThVPx8=
X-Received: by 2002:a17:903:18d:b0:216:201e:1b63 with SMTP id
 d9443c01a7336-22dc907a3a9mr444345ad.11.1745621562879; Fri, 25 Apr 2025
 15:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423201413.1564527-1-skhawaja@google.com> <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com> <aAwLq-G6qng7L2XX@LQ3V64L9R2>
In-Reply-To: <aAwLq-G6qng7L2XX@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 25 Apr 2025 15:52:30 -0700
X-Gm-Features: ATxdqUF6cnlzv3UW7k9Q6OGPBQlGRUoo9bRjVyF8_ojCZlDgdHdrTy_YYG9Z3Cw
Message-ID: <CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:24=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Fri, Apr 25, 2025 at 11:28:11AM -0700, Samiullah Khawaja wrote:
> > On Thu, Apr 24, 2025 at 4:13=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Wed, Apr 23, 2025 at 08:14:13PM +0000, Samiullah Khawaja wrote:
>
> [...]
>
> > > Thanks; I think this is a good change on its own separate from the
> > > rest of the series and, IMO, I think it makes it easier to get
> > > reviewed and merged.
> > Thanks for the review and suggestion to split this out.
>
> Sure. Up to you if you want to split it out or not.
I meant splitting it from the main series about busypolling.
>
> [...]
>
> > > > +
> > > >  int dev_set_threaded(struct net_device *dev, bool threaded)
> > > >  {
> > > >       struct napi_struct *napi;
> > > > @@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_s=
truct *n)
> > > >               napi_hash_add(n);
> > > >               n->config->napi_id =3D n->napi_id;
> > > >       }
> > > > +
> > > > +     napi_set_threaded(n, n->config->threaded);
> > >
> > > It makes sense to me that when restoring the config, the kthread is
> > > kicked off again (assuming config->thread > 0), but does the
> > > napi_save_config path need to stop the thread?
> >
> > >
> > > Not sure if kthread_stop is hit via some other path when
> > > napi_disable is called? Can you clarify?
> > NAPI kthread are not stopped when napi is disabled. When napis are
> > disabled, the NAPI_STATE_DISABLED state is set on them and the
> > associated thread goes to sleep after unsetting the STATE_SCHED. The
> > kthread_stop is only called on them when NAPI is deleted. This is the
> > existing behaviour. Please see napi_disable implementation for
> > reference. Also napi_enable doesn't create a new kthread and just sets
> > the napi STATE appropriately and once the NAPI is scheduled again the
> > thread is woken up. Please seem implementation of napi_schedule for
> > reference.
>
> Yea but seems:
>   - Weird from a user perspective, and
>   - Keeps the pid around as shown below even if threaded NAPI is
>     inactive, which seems weird, too.
>
> > > I ran the test and it passes for me.
> > >
> > > That said, the test is incomplete or buggy because I've manually
> > > identified 1 case that is incorrect which we discussed in the v4 and
> > > a second case that seems buggy from a user perspective.
> > >
> > > Case 1 (we discussed this in the v4, but seems like it was missed
> > > here?):
> > >
> > > Threaded set to 1 and then to 0 at the device level
> > >
> > >   echo 1 > /sys/class/net/eni28160np1/threaded
> > >   echo 0 > /sys/class/net/eni28160np1/threaded
> > >
> > > Check the setting:
> > >
> > >   cat /sys/class/net/eni28160np1/threaded
> > >   0
> > >
> > > Dump the settings for netdevsim, noting that threaded is 0, but pid
> > > is set (again, should it be?):
> > >
> > >   ./tools/net/ynl/pyynl/cli.py \
> > >        --spec Documentation/netlink/specs/netdev.yaml \
> > >        --dump napi-get --json=3D'{"ifindex": 20}'
> > >
> > >   [{'defer-hard-irqs': 0,
> > >     'gro-flush-timeout': 0,
> > >     'id': 612,
> > >     'ifindex': 20,
> > >     'irq-suspend-timeout': 0,
> > >     'pid': 15728,
> > >     'threaded': 0},
> > >    {'defer-hard-irqs': 0,
> > >     'gro-flush-timeout': 0,
> > >     'id': 611,
> > >     'ifindex': 20,
> > >     'irq-suspend-timeout': 0,
> > >     'pid': 15729,
> > >     'threaded': 0}]
> > As explained in the comment earlier, since the kthread is still valid
> > and associated with the napi, the PID is valid. I just verified that
> > this is the existing behaviour. Not sure whether the pid should be
> > hidden if the threaded state is not enabled? Do you think we should
> > change this behaviour?
>
> I don't know, but I do think it's pretty weird from the user
> perspective.
>
> Probably need a maintainer to weigh-in on what the preferred
> behavior is. Maybe there's a reason the thread isn't killed.
+1

I think the reason behind it not being killed is because the user
might have already done some configuration using the PID and if the
kthread was removed, the user would have to do that configuration
again after enable/disable. But I am just speculating. I will let the
maintainers weigh-in as you suggested.
>
> Overall, it feels weird to me that disabling threaded NAPI leaves
> the pid in the netlink output and also keeps the thread running
> (despite being blocked).
>
> I think:
>   - If the thread is kept running then the pid probably should be
>     left in the output. Because if its hidden but still running (and
>     thus still visible in ps or top or whatever), that's even
>     stranger/more confusing?
>
>   - If the thread is killed when threaded NAPI is disabled, then the
>     pid should be wiped.
I agree. I think in the selftest I will also add PID checks just to
explicitly verify the existing behaviour is preserved.
>
> My personal preference is for the second option because it seems
> more sensible from the user's point of view, but maybe there's a
> reason it works the way it does that I don't know or understand.

