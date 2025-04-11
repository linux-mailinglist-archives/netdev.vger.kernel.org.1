Return-Path: <netdev+bounces-181853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F93A86980
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ED2448178
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738932BD5AD;
	Fri, 11 Apr 2025 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="NKPI6ys8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uc4N2DLP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EF2253EA
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415875; cv=none; b=r+XVGl87RxJeA/N2SPUzooNSCewITNHyv08YulF++ZCaIUvelySIfRuWBx+uBpiytDF1qdgPOvWzAWjISA2gV9jnw1Ey+RWduOH3UAV0AZmlR+BF7EmpzQmjAmCi3elJjtz322cn22BlNh2iUA1zbv1khlysLJKrqw55GIQ19pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415875; c=relaxed/simple;
	bh=LDbUBZePXoPknG3mS5k3zgG5m4awine77om1NsD72fM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=LHqPT34hnvzX76cMH4rQjSrZj1cldEoEsNpNfNCKP0sxtig8O08nUSI9wDwa2JkEa3SSoL5Qy0se/BOr/WjzXuaHuBcxeWb4gOVGUMBqSHcs0a9uJqewgBA4F6UeAQ3EZG86cqb6uBtl8S2XQmk0qTDUYkg8dqlJDPH8LP5+VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=NKPI6ys8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uc4N2DLP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED91011401D1;
	Fri, 11 Apr 2025 19:57:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 11 Apr 2025 19:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1744415870; x=1744502270; bh=xADss857YAk905T3CeGog
	EmmfF+4Z7rjogB7DLXuKEo=; b=NKPI6ys8ipNuTV48X3FiJgYz8D39/5luW46do
	gGQll1TNVaStNxxDt2KkNogJUX7y0NTuKo5rfDNhCF154BRA1RfFfqRUPL/MtmQF
	OdLxMZW5qcQFo73dG1ADHHnRgaiV1owapJ5mk+PEctw72sLgg5/8W5a7UKju40Lc
	B9Z/oyuuLTGWZ+M2nvhrxAHm+y2gJqlshhOs66A9czq39XavzVzVLDO2KQ0Iz0Ky
	HiYqePttplgAz5h1ExymYT1HVxkWis03nd9/gASpsBl+lylDSzVEdQD/oly4QM3j
	fA3cWjMfpT5g5eOIt0P6tEQ2Ac2OzvQhZYPSW7svYVryxQG6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744415870; x=1744502270; bh=xADss857YAk905T3CeGogEmmfF+4Z7rjogB
	7DLXuKEo=; b=Uc4N2DLPFNAymZenwpTgVkbKaKIJQIaQCO7Yfgql7EWmYBHZ6Mg
	NWBlyRLuEPqwXeDd6sXgz3NY8fkB0121Wuon382ppz9pTYtM2sZ3hm5DcoSDZ4tA
	qPp7puqOe0aE16IKZI3mIYt5wJGtGUS9ttRKWzzQHLQ3/XTLrwqo/pOgLECN8yxm
	JpYMXpIKoiEl2PrS4Rs8zagy6aDlpnRBAqeaQOlXCUoAvH/37a38rNrqSHkcGFKC
	rfz4ZWn7pKOWtTlwblVFdwHSSj3bIObg0ZiKFy0DiXqL/dO6ozd2ggHLszz5GUDB
	GV1CXKUVLvMQyRtf52eLf+AQASaRIZAPeiA==
X-ME-Sender: <xms:fqz5Z5X6yEM828ZVkz5O4fjZvxPI5Ikd8pxWFxOFTj2yma7Bt7EBxQ>
    <xme:fqz5Z5mrBu3k2A2cZkDWHtk1JShAvPh5bQNs1JMsE9opExwMnnZk4rCG-3LyFYdnp
    IMAvApmLpZP_W7euK0>
X-ME-Received: <xmr:fqz5Z1bebsBgUzwnMtGcRW5Y9Z8O2TzBRV1ZLAr1jQj5LinwGRi-NQAh2M4QCr0jKbO6tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgruggvvghpsheslh
    hinhhugidrvhhnvghtrdhisghmrdgtohhmpdhrtghpthhtohepphhrrgguvggvphesuhhs
    rdhisghmrdgtohhmpdhrtghpthhtohepfihilhguvghrsehushdrihgsmhdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fqz5Z8VaIVs0TQRb8w2bUypgjy3Ht89xZ_hRIbFyGkyRgROUFhbH5Q>
    <xmx:fqz5ZzlooIQdkRcNevKLwOx65m69EXiZaufCGtRrn5bz5A52tJEWSw>
    <xmx:fqz5Z5cyYpnxZBZrxix9ejs2y85qQ7idJVq0ix9fbFKEewQ-H7CCFg>
    <xmx:fqz5Z9HFFJCdKGkAXl7N-XrfMWSEfy-V8-fPfUe9vxkRxTpz3f8Gmg>
    <xmx:fqz5Z32jwZpwpkGeUZyHPpus3GBbckDl0wNCWO1KXQRSdMXQOvp5Rz5p>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 19:57:50 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B86A89FD3C; Fri, 11 Apr 2025 16:57:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B56F99FC3F;
	Fri, 11 Apr 2025 16:57:48 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David J Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com
Subject: Re: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
In-reply-to: <20250411174906.21022-2-wilder@us.ibm.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com>
Comments: In-reply-to David J Wilder <wilder@us.ibm.com>
   message dated "Fri, 11 Apr 2025 10:48:15 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3885708.1744415868.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Apr 2025 16:57:48 -0700
Message-ID: <3885709.1744415868@famine>

David J Wilder <wilder@us.ibm.com> wrote:

>Adding limited support for the ARP Monitoring feature when ovs is
>configured above the bond. When no vlan tags are used in the configuratio=
n
>or when the tag is added between the bond interface and the ovs bridge ar=
p
>monitoring will function correctly. The use of tags between the ovs bridg=
e
>and the routed interface are not supported.

	Looking at the patch, it isn't really "adding support," but
rather is disabling the "is this IP address configured above the bond"
checks if the bond is a member of an OVS bridge.  It also seems like it
would permit any ARP IP target, as long as the address is configured
somewhere on the system.

	Stated another way, the route lookup in bond_arp_send_all() for
the target IP address must return a device, but the logic to match that
device to the interface stack above the bond will always succeed if the
bond is a member of any OVS bridge.

	For example, given:
	=

[ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1
eth2 IP=3D20.0.0.2

	Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently
succeed after this patch is applied, and the bond would send ARPs for
20.0.0.2.

>For example:
>1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
>2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
>3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not supported=
.
>
>Configurations #1 and #2 were tested and verified to function corectly.
>In the second configuration the correct vlan tags were seen in the arp.

	Assuming that I'm understanding the behavior correctly, I'm not
sure that "if OVS then do whatever" is the right way to go, particularly
since this would still exhibit mysterious failures if a VLAN is
configured within OVS itself (case 3, above).

	I understand that the architecture of OVS limits the ability to
do these sorts of checks, but I'm unconvinced that implementing this
support halfway is going to create more issues than it solves.

	Lastly, thinking out loud here, I'm generally loathe to add more
options to bonding, but I'm debating whether this would be worth an
"ovs-is-a-black-box" option somewhere, so that users would have to
opt-in to the OVS alternate realm.

	-J

>Signed-off-by: David J Wilder <wilder@us.ibm.com>
>Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>
>---
> drivers/net/bonding/bond_main.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 950d8e4d86f8..6f71a567ba37 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(stru=
ct net_device *start_dev,
> 	struct net_device *upper;
> 	struct list_head  *iter;
> =

>-	if (start_dev =3D=3D end_dev) {
>+	/* If start_dev is an OVS port then we have encountered an openVswitch
>+	 * bridge and can't go any further. The programming of the switch table
>+	 * will determine what packets will be sent to the bond. We can make no
>+	 * further assumptions about the network above the bond.
>+	 */
>+
>+	if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) {
> 		tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
> 		if (!tags)
> 			return ERR_PTR(-ENOMEM);

---
	-Jay Vosburgh, jv@jvosburgh.net

