Return-Path: <netdev+bounces-245732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 144BCCD65C2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1279302C8C8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCCB2C17A1;
	Mon, 22 Dec 2025 14:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEF126BF7
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413501; cv=none; b=Rtbg5X9ZJLNJrRHNQ85E1+l7bx6kF6RqXlohzaYro8d9J9RbSCdI66JBGifONxzwfsZ6nd2gnmb+zktSKTqrVDjV2Q6ZLtRVTQ+zdGEsA71AS4Pcl2YjyU4+r2F15r6a4VIX2711+JYvIMT8kSOG+Vp2iUb49ZTCwNUFHEUbghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413501; c=relaxed/simple;
	bh=BI6noF3mTn5ai0Gvqk/57/B7ubnwN8YPNkZmm3wM/SM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OrqqNbd3xz3C6Ess8MsJMXQVWI5yL2ATsrKm0W9RtgY5e9Dm2XKazg5Cwli98g4+8dBIHIrxuVI9CMlOb605HvC6biVMHtSMXCzAA1xHaTiCbDcqFCgB0qfkU7wkXl0gWI1B38dGKg9z0GAJRvlEsNMsvx4DSq2cMRytv9D743M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz16t1766413481t370c5a59
X-QQ-Originating-IP: cgj+cyeSU28uoMzdBYlpxyTMD0RxGJBzvdui3wjRzyk=
Received: from smtpclient.apple ( [183.241.15.10])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Dec 2025 22:24:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17444312089032528899
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 2/4] net: bonding: move
 bond_should_notify_peers, e.g. into rtnl lock block
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <CAL+tcoBJOuLCr1tvFr6cMbTjBOO_JRW__h4YN90Bxg-TComtsQ@mail.gmail.com>
Date: Mon, 22 Dec 2025 22:24:28 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54584F46-3B69-4CEC-8892-A3FB3754A726@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-3-tonghao@bamaicloud.com>
 <CAL+tcoBJOuLCr1tvFr6cMbTjBOO_JRW__h4YN90Bxg-TComtsQ@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NE8iuDeseKq8GRCpDOnOA0XC5LtkQmgwcZHMcPyWORI5NO6XhdM4izNf
	z9Sq603Mt2IkmTIB7HiDsOPQoR60gaPzbeCxF6pssQZ0+zmdG73PsqV1leR4v5dSkr30bmY
	Ycm4SzC9EO+f5bgSnJjKDZzlL3oA6d7SkUo2ELi9/kUQmHQpW/vXOi8pER0awviNtmSrs2F
	XcA8jws9Ro0+Oc4zaFN0ywcXsTfXIRhuzKDvRF+fNclTKHmLtdLu4yQwigTOGJwzSju3Hwy
	siGtxtTCiXQFxld5CXciHTfgUY+8cKSeZngjBU+aIDLDGbk0xPDQ8DnWgK5YeeTEzJk2Rho
	qKqdDgpoZlxPs53gjOshP4Qf8PbsgSGkVWC32x6a8jUKuTAhEbhqVUchL8/OJ8swkYRnp38
	96kxrwJnX2g+INXHcqGhMqNylVsDN0VIviwYNxZs0K5/1px0rvcsmq+LtSiYuHCpr+Pk0dd
	hTsfhiBKQB1OZK79mm2/1F/qh+1QHZGfvlWnkNGuDt50ZO07EC35qPOJp1Io8W8xQeEKiVs
	baEMXjtVNDgBP7YSZZEexTVnyEC01OAP0NHK/osDEGtd4nvnYPgXaCOhGOVy5LLhH59V6g8
	LcuPGHh0OlbUArbCtFyCIYcvWDzuXuKZ8EnX9pD8DQENsoWLbq/h4xKsKimonMLyy+PMJXm
	ATgHpN3gltICvyoAf1Jrz0R7vGWymp0C/j9i3nkYHzsooUfLhVqdN49uu6EtcSe+docAHnO
	f/TwSc6SqY/B598QHKdzHzEmmHIrK0VyrXURODV6FQfsz7Rii8r/YOA3zz1OoJWt38V3y3s
	LCqwiJVR5aGhGABwEKSY/Zi/zkZzBjGcyClmZZjIWWbuYJjgIXCAhVA0nE5x3UDF2H+AfIW
	yQWmdqfBHZZWyQvqXUa5se/i61d0XhQCvy+0pSNAj9aBaQdygnFjGfmjiCwLbvQa94VPk5v
	xOVf7/kvA4mGyWM/PUYK6WsjubuCSv5sl5Rjr8sgeroWAkV3hwkbkK4BongKFnl3DjP0=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0



> On Dec 2, 2025, at 09:54, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Sun, Nov 30, 2025 at 3:49=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>> This patch trys to fix the possible peer notify event loss.
>=20
> s/trys/tries
Ok
>=20
> Is this patch standalone as a fix since you mentioned 'fix' as above?
No, this patch works together with other patches.
> If so, then you would add "Fixes: "" <>" tag to manifest which commit
> brought the issue and then post it separately to the net tree. It
> would be helpful for the stable team to backport fixes.
>=20
> Thanks,
> Jason
>=20
>=20


