Return-Path: <netdev+bounces-61878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85D82525E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A9F1F25821
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470E250ED;
	Fri,  5 Jan 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="eVy6Mv+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDF2510D
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7bQSgeODv9oqNl5uShGuT/541u5AzwdR0r3EjcBWS/Y=; b=eVy6Mv+M6tNX4JNwUYHzcUQ1vF
	Qh4kfDy+i55BJnWQiC5+4lP+aaNSjBzmpcppCMJ3/ztZLnKRLeTd0mz7qV8kPEoyE0TQP76NFZ9em
	tbHlSF9y0D1OzJIdgGY6+UhhpIXJOddlrEgQPKR5Evq2lCSX9xgmHv+l17WwJXAMVBv98Wxnxy3BB
	LvdaqqboxOztQpdDs4blIO8/IyR7FAP5VSDY+Iwp1lZ4rTDdrCvZ0zlJkeqzN87x+efJ9Yv6ulCJk
	Rk16A1vMdQFQ4BWfDi3KhsnLIT5wDUxQgjg1ZpnCrjIwfzs2TIM4CHpQIGP2B2Xqt45xpbGlPbKZ6
	0FsOw5Sg==;
Received: from [192.168.1.4] (port=44794 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhiX-0000eR-1r;
	Fri, 05 Jan 2024 11:46:21 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:21 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 0/6] add dsa cross-chip port mirroring
Date: Fri, 5 Jan 2024 11:46:13 +0100
Message-ID: <cover.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

This patch is an attempt to add cross-chip port mirroring to dsa core and
mv88e6xxx switches but should apply similarly to other devices as well.
It is a work in progress so I am posting as RFC hopefully to get some
feedback on the general idea behind he problem rather than on the quality
of the code itself, though provided you have the time I would appreciate
any suggestions to code as well.

Cross-chip mirroring requires creating mirroring segments on each switch
that is acting as a part of the mirroring route, from source to destination
mirroring port. For example, configuration:

  SW0            SW1           SW2           SW3
+-------+     +-------+     +-------+     +--------+
|     P9|<--->|P10  P9|<--->|P10    |<--->|P10     |
|       |     |       |     |       |     |        |
+-------+     +-------+     +----+--+     +--------+
    ^                            |
    |                            v
   P2                           P8

for which dsa tree devices need to be configured as follows:
  ----------------------------------------
  |    |     source         destination  |
  | SW |  mirror port       mirror port  |
  ----------------------------------------
  |  0 |   P2          ->      P9        |
  |  1 |   P10         ->      P9        |
  |  2 |   P10         ->      P8        |
  |  3 |               ->                |
  ----------------------------------------

This basically means that request for adding port mirroring needs to be
propagated to the entire dsa switch tree as we can have a mirroring path
in which all switches need to be setup. This can be achieved through use
of switch event notifiers. First step is to create a mirroring route
which will contain source and destination ports for each switch in the
route. Then, this route is passed on to each switch where it is evaluated
for mirror settings for this particular switch. If a switch is contained
inside the route, its source and destination ports are passed on to
ds->ops->port_mirror_add().
Things get a bit more complicated when we need to remove port mirroring.
Again, we make use of the switch event notifiers to be able to inform
all switches that make a part of the route. Additionally, we must also
check if the source/destination mirror ports are being used by another
route and if so they should be kept active as we would interfere with
operation of another mirror action.

The critical part of the patch is getting the actual routing figured out,
which is done inside the dsa_route_create routine. It is a recursive
function that makes use of dsa_link and dst->rtable which is apparently
planned to be removed at some point (indicated by the TODO for dsa_link
struct in include/net/dsa.h). I'm not sure if this is a good way of getting
the routing done and what is the general opinion on using recursive functions
for this kind of work? In lack of real hardware, I isolated and tested
dsa_route_create routine on dummy switch topologies with up to three dsa
links. Even a sort of circular topology seems to work provided that the
requested to/from ports can actually be found in the dsa tree. Are there
any other variants that should be considered?

I decided to drop passing struct dsa_mall_mirror_tc_entry *mirror to
dsa drivers in favor of simpler from/to port and constraint the
dsa_mall_mirror_tc_entry to dsa core only. Member u8 to_local_port is
replaced with struct dsa_port *to_port as we are may no longer be addressing
the same switch for source/dest mirror. In this sense, passing the struct
dsa_port *to_port as a member of the dsa_mall_mirror_tc_entry to individual
switch devices seemed a bit off. This is addressed in patch no. 1

Patch no.5 sets destination mirroring ports to 0x1f when trying to disable
destination mirroring as suggested by the Switch Functional Specification
for 88E6390X/88E6390/88E6290/88E6190X/88E6190 and Switch Functional
Functional Specification for 88E6393X/88E6193X/88E6191X. If I see correctly
we have 3 variants of mv88e6xxx_ops->set_egress_port and they are:
- mv88e6390_g1_set_egress_port
- mv88e6393x_set_egress_port
- mv88e6095_g1_set_egress_port
I guess that we can assume that above mentioned documents apply to the first
two variants, and if someone can confirm the same for mv88e6095 than
MV88E6XXX_EGRESS_DEST_DISABLE should apply for the complete mv88e6xxx family.

Finally, patch is tested on a board consisting of two cascaded mv88e6390x
switches and seems to work fine, but this obviously is not sufficient and
would be great if someone can do a bit more testing on proper hardware
assuming there are no objections to the patch itself.

Any feedback is appreciated.
Thanks,
	Ante

Ante Knezic (6):
  net:dsa: drop mirror struct from port mirror functions
  net: dsa: add groundwork for cross chip mirroring
  net: dsa: implement cross chip port mirroring
  net: dsa: check for busy mirror ports when removing mirroring action
  net: dsa: mv88e6xxx: properly disable mirror destination
  net: dsa: mv88e6xxx add cross-chip mirroring

 drivers/net/dsa/b53/b53_common.c       |  21 +++--
 drivers/net/dsa/b53/b53_priv.h         |   8 +-
 drivers/net/dsa/microchip/ksz8.h       |  10 +-
 drivers/net/dsa/microchip/ksz8795.c    |  36 +++----
 drivers/net/dsa/microchip/ksz9477.c    |  26 ++---
 drivers/net/dsa/microchip/ksz9477.h    |  10 +-
 drivers/net/dsa/microchip/ksz_common.c |  15 +--
 drivers/net/dsa/microchip/ksz_common.h |   7 +-
 drivers/net/dsa/mt7530.c               |  35 +++----
 drivers/net/dsa/mv88e6xxx/chip.c       |  91 +++++++++++-------
 drivers/net/dsa/mv88e6xxx/chip.h       |   5 +-
 drivers/net/dsa/mv88e6xxx/port.c       |   5 -
 drivers/net/dsa/ocelot/felix.c         |  15 +--
 drivers/net/dsa/qca/qca8k-common.c     |  39 ++++----
 drivers/net/dsa/qca/qca8k.h            |  11 ++-
 drivers/net/dsa/sja1105/sja1105_main.c |  14 +--
 include/net/dsa.h                      |  38 ++++++--
 net/dsa/dsa.c                          |  14 +++
 net/dsa/switch.c                       |  84 +++++++++++++++++
 net/dsa/switch.h                       |   8 ++
 net/dsa/user.c                         | 167 +++++++++++++++++++++++++++++++--
 21 files changed, 480 insertions(+), 179 deletions(-)

-- 
2.11.0


