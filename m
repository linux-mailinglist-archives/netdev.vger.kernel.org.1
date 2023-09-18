Return-Path: <netdev+bounces-34592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFAB7A4CF9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B1A1C21384
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B041F606;
	Mon, 18 Sep 2023 15:44:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7F1CFB3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:44:24 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6B10A;
	Mon, 18 Sep 2023 08:43:00 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6AB81D18B1;
	Mon, 18 Sep 2023 15:08:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7515B1C0007;
	Mon, 18 Sep 2023 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695049704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ICEwPkNaYsSfx6qOGqNqEqfrERmHi6fPl1ADzWGyEK0=;
	b=CSHHUcyHUDcGQ7PORq1Lv96qz9aNr689LddmmLIf4hfgAe/XSipg40omwzhozpy7hdhML6
	sAi5q/er4cqweQM77hSgSwIovOgVbo0pFlvWqubCve37U1jFOOaWEHr+AQk2/360Jk6LE9
	ggFJV/bEKju+YCImzwFm5Auh/dKhVAhTTN0tzE8A9F1oEaQUYgv+4odK4JKvGaBBxxhx6b
	8rT77i6e/MaHArve+7AuuTDOAHJm0uwLaxSab6P5tJ5Sk7W8Q7iIZmt8nJukW4TX7Ckw+U
	wMlyvwMwRRn7ZNaJ6deHkeK976iPxQNTsVMiXP7ttnAKPGLSHvMRsV8TLmOCvw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v3 00/11] ieee802154: Associations between devices
Date: Mon, 18 Sep 2023 17:07:58 +0200
Message-Id: <20230918150809.275058-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

[I know we are in the middle of the merge window, I don't think it
matters on the wpan side, so as the wpan subsystem did not evolve
much since the previous merge window I figured I would not delay the
sending of this series given the fact that I should have send it at the
beginning of the summer...]

Now that we can discover our peer coordinators or make ourselves
dynamically discoverable, we may use the information about surrounding
devices to create PANs dynamically. This involves of course:
* Requesting an association to a coordinator, waiting for the response
* Sending a disassociation notification to a coordinator
* Receiving an association request when we are coordinator, answering
  the request (for now all devices are accepted up to a limit, to be
  refined)
* Sending a disassociation notification to a child
* Users may request the list of associated devices (the parent and the
  children).

Here are a few example of userspace calls that can be made:
iwpan dev <dev> associate pan_id 2 coord $COORD
iwpan dev <dev> list_associations
iwpan dev <dev> disassociate ext_addr $COORD

I used a small using hwsim to scan for a coordinator, associate with
it, look at the associations on both sides, disassociate from it and
check the associations again:
./assoc-demo
*** Scan ***
PAN 0x0002 (on wpan1)
	coordinator 0x060f3b35169a498f
	page 0
	channel 13
	preamble code 0
	mean prf 0
	superframe spec. 0xcf11
	LQI ff
*** End of scan ***
Associating wpan1 with coord0 0x060f3b35169a498f...
Dumping coord0 assoc:
child : 0x0b6f / 0xba7633ae47ccfb21
Dumping wpan1 assoc:
parent: 0xffff / 0x060f3b35169a498f
Disassociating from wpan1
Dumping coord0 assoc:
Dumping wpan1 assoc:

I could also successfully interact with a smaller device running Zephir,
using its command line interface to associate and then disassociate from
the Linux coordinator.

Thanks!
Miquèl

Changes in v3:
* Clarify a helper which compares if two devices seem to be identical by
  adding two comments. This is a static function that is only used by
  the PAN management core to operate or not an
  association/disassociation request. In this helper, a new check is
  introduced to be sure we compare fields which have been populated.
* Dropped the "association_generation" counter and all its uses along
  the code. I tried to mimic some other counter but I agree it is not
  super useful and could be dropped anyway.
* Dropped a faulty sequence number hardcoded to 10. This had no impact
  because a few lines later the same entry was set to a valid value.

Changes in v2:
* Drop the misleading IEEE802154_ADDR_LONG_BROADCAST definition and its
  only use which was useless anyway.
* Clarified how devices are defined when the user requests to associate
  with a coordinator: for now only the extended address of the
  coordinator is relevant so this is the only address we care about.
* Drop a useless NULL check before a kfree() call.
* Add a check when allocating a child short address: it must be
  different than ours.
* Rebased on top of v6.5.

Miquel Raynal (11):
  ieee802154: Let PAN IDs be reset
  ieee802154: Internal PAN management
  ieee802154: Add support for user association requests
  mac802154: Handle associating
  ieee802154: Add support for user disassociation requests
  mac802154: Handle disassociations
  mac802154: Handle association requests from peers
  ieee802154: Add support for limiting the number of associated devices
  mac802154: Follow the number of associated devices
  mac802154: Handle disassociation notifications from peers
  ieee802154: Give the user the association list

 include/net/cfg802154.h         |  69 ++++++
 include/net/ieee802154_netdev.h |  60 +++++
 include/net/nl802154.h          |  22 +-
 net/ieee802154/Makefile         |   2 +-
 net/ieee802154/core.c           |  24 ++
 net/ieee802154/nl802154.c       | 223 +++++++++++++++++-
 net/ieee802154/pan.c            | 115 +++++++++
 net/ieee802154/rdev-ops.h       |  30 +++
 net/ieee802154/trace.h          |  38 +++
 net/mac802154/cfg.c             | 170 ++++++++++++++
 net/mac802154/ieee802154_i.h    |  27 +++
 net/mac802154/main.c            |   2 +
 net/mac802154/rx.c              |  25 ++
 net/mac802154/scan.c            | 397 ++++++++++++++++++++++++++++++++
 14 files changed, 1191 insertions(+), 13 deletions(-)
 create mode 100644 net/ieee802154/pan.c

-- 
2.34.1


