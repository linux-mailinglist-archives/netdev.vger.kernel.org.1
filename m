Return-Path: <netdev+bounces-71356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDC8530FC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F51B21AB4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECA42078;
	Tue, 13 Feb 2024 12:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 8.mo560.mail-out.ovh.net (8.mo560.mail-out.ovh.net [188.165.52.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB6383AE
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.52.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828946; cv=none; b=clTt+ezVW8InRIOj6P+o3VNGL1uswCvHHgZwbsTOWbyvHZYP/uy446ZVqvTlQyWlF1/b3VEFcqKDbEWSsNQsAe1CfsvDUydG9/SLs62lHL39XzvJQytICrBJzXlyL0V0k0Sr5kZ4bHluh9wg0NYc3/l7ISCJnH3pzrB5cLmcVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828946; c=relaxed/simple;
	bh=0MITEjaq0HVHcr9lD/N/N/1MZkCXadxh54dHMWq8gUE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EdQZWe68lm86NbRYhab3EiUae8bxXAwUbfXY8lp7O2w+v66zp7o8of2JVudOjMlocAFDT864GukjqNtWsz248kKssQtee9KLD4d4wteCY3yZ1VZXHHbjgaNFfctQDhuMJu5ckw/0ioGkgNIEBGZ0J5uQMwgSDlT1bM0PvDOEYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=188.165.52.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.9.217])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4TZ1XD1cDQz13Kb
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:55:40 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-frr6m (unknown [10.110.168.145])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5869D1FEC3;
	Tue, 13 Feb 2024 12:55:39 +0000 (UTC)
Received: from courmont.net ([37.59.142.106])
	by ghost-submission-6684bf9d7b-frr6m with ESMTPSA
	id 2674Dstmy2UDqQAAnbIfag
	(envelope-from <remi@remlab.net>); Tue, 13 Feb 2024 12:55:39 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R006d847666b-07fc-4e31-8631-11f0760ee372,
                    A20BB40909ED6AD0948787802399DD68533E41DF) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.95.21.213
Date: Tue, 13 Feb 2024 14:55:37 +0200
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Paolo Abeni <pabeni@redhat.com>, courmisch@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
CC: netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
User-Agent: K-9 Mail for Android
In-Reply-To: <9c03284dedb5559de0b99fde04bc3e19b5027d6f.camel@redhat.com>
References: <20240210125054.71391-1-remi@remlab.net> <9c03284dedb5559de0b99fde04bc3e19b5027d6f.camel@redhat.com>
Message-ID: <B523FFF3-4D2E-4295-9D0F-374FF3359DF1@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 7407295488023533943
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpedtheettdehgeefjeefteehteegvdevkeekjefhgfeggfeiveevfffflefgheeujeenucfkphepuddvjedrtddrtddruddpkeejrdelhedrvddurddvudefpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgvmhhisehrvghmlhgrsgdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth

Hi,

Le 13 f=C3=A9vrier 2024 14:12:57 GMT+02:00, Paolo Abeni <pabeni@redhat=2Ec=
om> a =C3=A9crit=C2=A0:
>On Sat, 2024-02-10 at 14:50 +0200, R=C3=A9mi Denis-Courmont wrote:
>> From: R=C3=A9mi Denis-Courmont <courmisch@gmail=2Ecom>
>>=20
>> Reported-by: Luosili <rootlab@huawei=2Ecom>
>> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail=2Ecom>
>
>Looks good, but you need to add a non empty commit message=2E

With all due respect, the headline is self-explanatory in my opinion=2E Yo=
u can't compare this with the more involved second patch=2E Also the second=
 patch was *not* reported by Huawei Rootlab, but inferred by me and thus ha=
s no existing documentation - unlike this one=2E

As for the bug ID, I don't know it (security list didn't pass it on to me)=
=2E Anyhow it seems that Eric Dumazet already either found it or filled it =
in, so I don't know what else you're asking for=2E

