Return-Path: <netdev+bounces-36589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B967B0BA8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8C3DBB20C1B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098D4B218;
	Wed, 27 Sep 2023 18:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232AF9D3
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:12:26 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C690A1;
	Wed, 27 Sep 2023 11:12:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 620ADFF812;
	Wed, 27 Sep 2023 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695838339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eC3Z92ZN43+u8FMsg+0ea05ry75LHG8JsiM48wC57h8=;
	b=HjQcxm5aFUgZv06Yxkd0Q4zVc43NH9u1fojPo9AA2UORyRU9qVVvTZLDdbpwIxXaBya6TM
	i7yZQ6+Td6OyE2bfgfq1O6+bC13l7XkeGN08tAJXhcRyhx1hggE9z1xhVaEevLIjyPP/SL
	z3jw8hYuD1Vdvuk5s/x+Zz0f3166xvxW2fheil+Dh0B4cLN7lefluY5AAcFzof0EMtVnq2
	6O773ezLUaiP9Nc5uoYKF1u16lHSH43FWnGelCBykg3I//mFurd/gJ4g1ILFR3DeD8KjYW
	uzo0qhNM9J2gXpeT35w3wER1sJjUifTaQU+lMRedYqN6DE0P14mPPRpuYmrkrg==
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
Subject: [PATCH wpan-next v5 00/11] ieee802154: Associations between devices
Date: Wed, 27 Sep 2023 20:12:03 +0200
Message-Id: <20230927181214.129346-1-miquel.raynal@bootlin.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

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

Changes in v5:
* Fixed (again) the helper supposed to check whether a device requesting
  association/disassociation is already (or not) in our PAN. We don't
  nee to check short addresses there.
* Changed the name of the helper a second time to make it more relevant
  and understandable:
  cfg802154_device_in_pan() -> cfg802154_pan_device_is_matching()
* Fixed a kernel test robot report where we would use an int instead of
  a __le16. Solved that by using cpu_to_le16 like in the other places
  where we use definitions as arguments.

Changes in v4:
* Ensured any disassociation would only be processed if the destination
  pan ID matches ours.
* Association requests should be made using extended addressing, it's
  the specification, so ensure this is true. Doing so helps reducing the
  checks down the road.
* Updated a copyright from 2021 to 2023.
* Improved the comment for cfg802154_device_in_pan() and only accept
  extended addressing when using this internal function because there is
  no point in checking short addresses here.
* Move nl802154_prepare_wpan_dev_dump() and
  nl802154_finish_wpan_dev_dump() outside of a
  CONFIG_IEEE802154_NL802154_EXPERIMENTAL #ifdef bloc as now used in
  regular code (not only experimental).
* Added a missing return value in the kernel doc of
  cfg802154_device_is_associated().

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

 include/net/cfg802154.h         |  70 ++++++
 include/net/ieee802154_netdev.h |  60 +++++
 include/net/nl802154.h          |  22 +-
 net/ieee802154/Makefile         |   2 +-
 net/ieee802154/core.c           |  24 ++
 net/ieee802154/nl802154.c       | 225 +++++++++++++++++-
 net/ieee802154/pan.c            | 103 +++++++++
 net/ieee802154/rdev-ops.h       |  30 +++
 net/ieee802154/trace.h          |  38 +++
 net/mac802154/cfg.c             | 170 ++++++++++++++
 net/mac802154/ieee802154_i.h    |  27 +++
 net/mac802154/main.c            |   2 +
 net/mac802154/rx.c              |  25 ++
 net/mac802154/scan.c            | 397 ++++++++++++++++++++++++++++++++
 14 files changed, 1180 insertions(+), 15 deletions(-)
 create mode 100644 net/ieee802154/pan.c

-- 
2.34.1


