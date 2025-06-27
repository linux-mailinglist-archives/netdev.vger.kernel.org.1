Return-Path: <netdev+bounces-201736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D200AEAD34
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D122B4E23D1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82185192B96;
	Fri, 27 Jun 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K/bJIxMO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0E423DE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993897; cv=none; b=p8duu+4h7YDlIV8h0D4DGnfTrBz2nuQLqkuGXAjaLhmK6xddBKcIFCZjah5QCb3q+fm8irgcRAbLk8/gDjbi8jcUpBEMSzmHXCFKHtA0lveKmnEKHX6PthFEEY5MzfsvcCA6GCpPOfMWS/aVnj/Ia44c9i3L+YYmeOmUBcKw4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993897; c=relaxed/simple;
	bh=nlcPshRdbToTPxImylc0Vmo/MTHnwfaG8pY4OWRlsic=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pS7KxEfyiKfK+jNIWxasiEPZvExBwa47ddB8b39NLd2YUbDsZ6B+SWkBy05KB0ToQgiAX/NkfJxlboxbcfVoZYomlgdA9pXDCm1vjVe54RgnWGzTlVA7ohOUzIBut7dCw+eeglCXylOC2JtzdvKJbiLFlOK+mNZT2SpysmH1mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K/bJIxMO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Mime-Version:Subject:From:Date:
	Message-Id:To; bh=ZsnFS/v+FPgoY3ZK/ydQfXMRZIbNVbcRWC7h/xHkL4c=;
	b=K/bJIxMOzkvc7X9CbK4sCe14VAXU/gTpk9enfaL/hWQ1jcB1MxHDkeTUEBo3QF
	oRwXRcnFrWevsebEpnTCymw36mMJ7ZnZsOfPTYpIlkgWcLcEoOoTKapGp1CTjxQN
	tow7o5fc7p1ECJPtSqL9GYmNamuyoGGqorOu/jvlRDMI4=
Received: from smtpclient.apple (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA39BSeC15o43VVAQ--.40850S3;
	Fri, 27 Jun 2025 11:10:23 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: net: openvswitch: incorrect usage in ovs_meters_exit?
From: lihuawei <lihuawei_zzu@163.com>
In-Reply-To: <08200104-eda5-47f5-9538-b0be2b7fe1fc@ovn.org>
Date: Fri, 27 Jun 2025 11:10:12 +0800
Cc: davem@davemloft.net,
 netdev@vger.kernel.org,
 edumazet@google.com,
 pabeni@redhat.com,
 kuba@kernel.org,
 xiangxia.m.yue@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <71FB508D-5829-4237-9D8D-727235934971@163.com>
References: <6B26C96C-1941-4AFF-AEAC-6C7E36CDFF02@163.com>
 <08200104-eda5-47f5-9538-b0be2b7fe1fc@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-CM-TRANSID:PCgvCgA39BSeC15o43VVAQ--.40850S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45ZF17WFy5XF47Gw4UJwb_yoW8GF1fpr
	ZYga47Krn7ArW7KrnF9w4xZryYvw4fGFy3ur1DC398Cwsxt34xWFW2yrn8GFWYkrWkJr4j
	93y8twnxua1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvkskUUUUU=
X-CM-SenderInfo: 5olk3tpzhls6l2x6il2tof0z/xtbBgBZ5vGheCxwPyQAAs0

Okay=EF=BC=8CI got it, thank you Ilya Maximets.

> 2025=E5=B9=B46=E6=9C=8827=E6=97=A5 01:16=EF=BC=8CIlya Maximets =
<i.maximets@ovn.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 6/26/25 2:59 PM, lihuawei wrote:
>> hi, guys,
>>=20
>> 	Recently, I am working on ovs meter.c, after reading the code, I =
have two questions about the ovs_meters_exit function as bellow :
>>=20
>> void ovs_meters_exit(struct datapath *dp)
>> {
>> 	struct dp_meter_table *tbl =3D &dp->meter_tbl;
>> 	struct dp_meter_instance *ti =3D rcu_dereference_raw(tbl->ti);
>> 	int i;
>>=20
>> 	for (i =3D 0; i < ti->n_meters; i++)
>> 		ovs_meter_free(rcu_dereference_raw(ti->dp_meters[i]));
>>=20
>> 	dp_meter_instance_free(ti);
>> }
>>=20
>>    1. why use rcu_dereference_raw here and not rcu_dereference_ovsl?
>>    2. why use dp_meter_instance_free here and not =
dp_meter_instance_free_rcu?
>=20
> Hi.  AFAICT, the ovs_meters_exit() is called only from two places:
>=20
> 1. As a cleanup for the datapath that we failed to fully allocate.
> 2. =46rom the RCU-postponed destroy_dp_rcu() when the datapath is
>   being destroyed.
>=20
> In both cases there should be no users of this datapath at the time
> this function is called, so it doesn't make a lot of sense to hold
> the lock or postpone the destruction of these internal fields again.
> Half of the datapath structure is already freed here.  So, unless
> I'm missing something, we can just free the meters directly as well.
>=20
> Best regards, Ilya Maximets.


