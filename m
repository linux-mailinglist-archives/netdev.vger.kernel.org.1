Return-Path: <netdev+bounces-222745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9044B55A84
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D7EA0863F
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3A632;
	Sat, 13 Sep 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFCxvmp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324CA59
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721992; cv=none; b=EAJg31o0rVTZb20U3THe6Hkja0+Y8ZcDrSGwzS1wUZJZ1/RyGjpxDs3UkhX5CdD4DAsbnKDb4n3E6JJ9dbA0PxqZ/A9c5X/5gzdb7DIRuxrUv4167VJQJQ/RJJrblvbUkKrrvc02fphFtegqO5XgWlONljoBp52nl06Z89DudTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721992; c=relaxed/simple;
	bh=iXgH6JeAFrjlcrDSwuD4+hZc19CzKawBfDiZ3J0LxqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzhRTl+3xQQRos5bli7UQP6KDaHlQsGfMMEoSrJW7KHDhTDE25kPbkEcjZ9VNUgIV75q0nWsjlsyLm1/VbC/K19mRPAo8+le2WzpMrXIAwTt3SpMdT0FFnbE9bv7eevwMwRT2a3wjEYp5BuJfd3d+uD1ZZyIPG324Bv73NrZSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFCxvmp4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54a74f9150so1450191a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757721991; x=1758326791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h2jGyHGIPAIN32jMnku1cih44e2Oi8t83/aL8WHu4w=;
        b=vFCxvmp4jy2DKM7qBE/OzviJD1/5ZP0V3ELz3SpWOQQhoigD2g1M/jkx4MWLtGqdl/
         OHtlWYIPiLTOUbaIECTZCpuPqPM4GN181Qb/kM7hQ4VgSKBRkcl4BoHnLEssYRyXAm2z
         H43njTr7f7XNH2OppGbeViTGjikrq2isnpqQDHe7v2a52B1eXAbxHUnuT3fl9Wjv34ih
         qfECH6cfOoUtWBZoYebvY9RiODx9DZThyGidMicsDgHW228cmaAjuy/rJ6E9c0oJxYOn
         r+DXgRpnsdYGScaXp7FgovBAUECynVOhj+x3B35hQfGiBNNqO8/u/Sg7wP2RKUi5GSvl
         RVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757721991; x=1758326791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h2jGyHGIPAIN32jMnku1cih44e2Oi8t83/aL8WHu4w=;
        b=p5sr6ErsI24rCF6sKINn4dFJ91QwVMR1gFBtALKxuMGUJ9dL9eAmYuGxmHy2DpST0l
         h2GhHvMzp9Dcsw4FeEa0+oKKRNs1nqm1QwudeaoFxOal3Gh03mi2LkutSUySKLI154gA
         siyddBFJ2IkUmGlsoXeUO9CLInPKKU5qXjtjkaNDTGzflZr2croV/y9VJSHxHRHegaCc
         246kuEBPI/oxci9QM42peq1JNvjlJhmvPOLokaqqkOthg6KwmhVq0MPcJPpft/B9x0R0
         HBNq94wFhoADod+VgU1+mTOGqlpeT7CwScbEwKp3/iv3rjIznLJlzXuj++OKq/9zuHqs
         0gBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwSr9XrATv/6GMSCWMD/Hc2lFS8BAWZhd0zehMAbMEHBGM1wsh+fGHnpcpSWE+iHt9GqdN2rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegMWXd8klTCmGEkcvDwNJSYaG1Llz8s9dnWNHhQNm4jUQi99+
	SKjFVQVUJZ4yD8AnWX2vXJLyuXgRMCAuwK8eH9CZ1NyY10Rm+fF+lGNlB7cqKTT9JHMEE2ZtJIl
	1ujLSjNLmIvut1+lUcTdDR24nJnVijI+FRWRTVnRy
X-Gm-Gg: ASbGncvaIkev3q+b6YkZiCLoIiXuSmCDcgwZs++7xfJYY0Q5OKsPuLooF7bzAj8Ch3H
	+6aDJhRobu0mHc9H2js8DqKzhj5i5sv+Pi+Ch4W0hif4bEvxeLNL6LdpXwsEFC3NlqMfOayWO5t
	2RM6/gYR5oY2ePmHTRO05QEswxJOLbhXRCYFBNp2jowSh5RMfgmzR1oMNeRy7WPPDUfaoJJMOrH
	e3Ac+GLKawhGXS8alt1GofNsLkN2Xg4F8oFDDtAuR0fn90=
X-Google-Smtp-Source: AGHT+IEtbL8WtkiNHFtW3ygvPhm09UelHFgfGnMRRLObMc75pu8jb7cXwzkTVygOSfV5AItmsGfpvFkwFyDpWekF7hU=
X-Received: by 2002:a17:902:ec86:b0:24e:6362:8ca7 with SMTP id
 d9443c01a7336-25d2782a973mr51618975ad.53.1757721990429; Fri, 12 Sep 2025
 17:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-3-kuniyu@google.com>
 <3ac0ee3d-c0bf-4768-8ccc-8f853762a8db@linux.ibm.com>
In-Reply-To: <3ac0ee3d-c0bf-4768-8ccc-8f853762a8db@linux.ibm.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Sep 2025 17:06:19 -0700
X-Gm-Features: Ac12FXyfIfCCEL3oHmeS83NJDkl6s586fP2i0JhUd-6Pz7cXbz_OiINC5KnIrjs
Message-ID: <CAAVpQUB+Tv2Bqw5egWGqZgFAH-YXHG8+f4KYhO9QMDRV-Hb5rA@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/8] smc: Fix use-after-free in __pnet_find_base_ndev().
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Ursula Braun <ubraun@linux.ibm.com>, Hans Wippel <hwippel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:55=E2=80=AFAM Mahanta Jambigi <mjambigi@linux.ib=
m.com> wrote:
>
> On 11/09/25 8:35 am, Kuniyuki Iwashima wrote:
> > -     return;
> > +     dev =3D sk_dst_dev_get(sk);
> > +     if (dev) {
> > +             smc_pnet_find_roce_by_pnetid(dev, ini);
> > +             dev_put(dev);
>
> Nit: Should we use netdev_put() along with netdev_hold() in
> sk_dst_dev_get()? Same query for other places where we are using dev_put(=
).

I think dev_hold()/dev_put() is fine for fix and temporary use.

