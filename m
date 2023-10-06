Return-Path: <netdev+bounces-38490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBD7BB375
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A121C20968
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B693D62;
	Fri,  6 Oct 2023 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="DBKCNdZA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870C20F7
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:46:49 +0000 (UTC)
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 01:46:47 PDT
Received: from mail.flyingcircus.io (mail.flyingcircus.io [IPv6:2a02:238:f030:102::1064])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608083;
	Fri,  6 Oct 2023 01:46:47 -0700 (PDT)
From: Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1696581441;
	bh=Wek4atBJRZp7WWj5NHPapGH6TNHQ/njCKEJDVyTvCDs=;
	h=From:Subject:Date:Cc:To;
	b=DBKCNdZAfb5jvweObC9FRXl5eBK73E995EsCwwS6TKKdHbkcSmU/ngffOdxda0Q/j
	 +WwFVPt++hyk8gZrlL8POF7IdK9KEt7dtduGl6eLaqoES3iKYgRnn/HU06KSWwO9ht
	 bOF24xRXRa5GEPX/ZxhOrR4TrvWDttV164/HJM0A=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-Id: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Date: Fri, 6 Oct 2023 10:37:00 +0200
Cc: regressions@lists.linux.dev,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
To: stable@vger.kernel.org,
 netdev@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

(prefix, I was not aware of the regression reporting process and =
incorrectly reported this informally with the developers mentioned in =
the change)

I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic =
shaping script, leaving me with a non-functional uplink on a remote =
router.

The script errors out like this:

Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=3DispA
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + =
ext_ingress=3Difb0
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe =
act_mirred
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ispA root
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot =
delete qdisc with handle of zero.
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ispA ingress
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot =
find specified qdisc on specified device.
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ifb0 root
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot =
delete qdisc with handle of zero.
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ifb0 ingress
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot =
find specified qdisc on specified device.
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add =
dev ispA handle ffff: ingress
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig ifb0 =
up
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter add =
dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred =
egress redirect dev ifb0
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add =
dev ifb0 root handle 1: hfsc default 1
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add =
dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add =
dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid =
parent - parent class must have FSC.

The error message is also a bit weird (but that=E2=80=99s likely due to =
iproute2 being weird) as the CLI interface for `tc` and the error =
message do not map well. (I think I would have to choose `hfsc sc` on =
the parent to enable the FSC option which isn=E2=80=99t mentioned =
anywhere in the hfsc manpage).

The breaking change was introduced in 6.1.53[1] and a multitude of other =
currently supported kernels:

----
commit a1e820fc7808e42b990d224f40e9b4895503ac40
Author: Budimir Markovic <markovicbudimir@gmail.com>
Date: Thu Aug 24 01:49:05 2023 -0700

net/sched: sch_hfsc: Ensure inner classes have fsc curve

[ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]

HFSC assumes that inner classes have an fsc curve, but it is currently
possible for classes without an fsc curve to become parents. This leads
to bugs including a use-after-free.

Don't allow non-root classes without HFSC_FSC to become parents.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: =
https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
----

Regards,
Christian

[1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53

#regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40


--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


