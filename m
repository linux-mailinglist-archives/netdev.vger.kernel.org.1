Return-Path: <netdev+bounces-127878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FAD976F07
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C691C20BF1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153F1AE845;
	Thu, 12 Sep 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="n0pI0bbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lG17qCaI"
X-Original-To: netdev@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E817BED2
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159574; cv=none; b=fhzeaHF2wAGU4/fQXQgJd6UOlxVE56Kstp9qWOXBBpdHKOlU9enj3cJc0NCe/HAVZmVOSNKP/F/FIatEP8F1xoJcO0tje8jEPpH/XmyTHSC2aKhuVTDPa16qfBB9PJWZr8nKb0b7RQHNOujFvU+ycPmgSAykD2uDPvq4hCP7gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159574; c=relaxed/simple;
	bh=/XcJ7oKix/Eu0RdyNgqwKKxPKkabS524PCuYlGa0+Ro=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=puhKBeLwdfJWWWvUnHc0iT6Cv/rX8XX6LWDjO4Wbveg9hg5f+f2aL2DabRkfE7HhhUAAYI1HMxe4pDOJZm6ZUw9aSMQLcThyZ1bgVxjtNSmNyOf2yJXyN+m12pW3cD8c9Rhiqht98OxMcVzBzs656GDjmmP26H4hi3/qcVGMz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=n0pI0bbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lG17qCaI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 82AAF1380226;
	Thu, 12 Sep 2024 12:36:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 12:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1726158975; x=1726245375; bh=aaweFkwW6x/5eAJ/IyPp0u5PDtnYEDar
	gBRK5QFWJWw=; b=n0pI0bbVrOp0J+a0gZ+a0aSekZGaFZ1ktrscPG/tE6uCkwC6
	/ksAqsVCkaso2ZiK1qlhCUHKhpkpAsSOjQCVlJdLyVihLOk338zDoOgiivHv2vS/
	Aij7n8kmR+1cuh+6EzT/ye6ey2aosgVcJFXKUwG0nIyOziT/7acTwGEXX676VKOx
	saFyf/k0RHlQyupt/RAKprRTwQIKUsLLV0NC/8RxceMmYi9zlNS30YzRRt0MZcp9
	4ltbofmyEIY2ZG1T2XQiNbAdUMFYi6ryMAaylC+X5wLwSdPuAM3Nz3YFpdGbQydD
	ZG6b/S7Sbwmlpvkv7mHQFlpXdpxGSRVSAox91g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726158975; x=
	1726245375; bh=aaweFkwW6x/5eAJ/IyPp0u5PDtnYEDargBRK5QFWJWw=; b=l
	G17qCaInZIAcYVhMhg/KDVKTxP+GyRFpc3y1dfNNgLDMnyZUngSwTT8UEvheSQKo
	0M8hCgYy/qYiE0BC7Us37btekzP7a4pkuJLM2mEhoIMBK0ntY4i6P+024+1uKcor
	/923s30qnrGSeQRedOTCV4ULgDXmDYyxb9aoxdiJRPE0y2okwdD7nTYEGANEa4YS
	Ygle+YD9DozrJ5FW84gsWlCPJLRkUKPDWD+u0maqJyXgjx1v41kQTkZFyLXHN8bw
	czJDan73NGAcCcrLc7UxkxGfGLqJnv9+4ZZqdazFfsIjGoac2u/L6PoqZPo0QoLG
	onEfZHwL5d/KE1OB2bQSw==
X-ME-Sender: <xms:fhjjZp-a2OYhc92cIqWy8D6bcwxuo0wACb_sPVKtsU8rJgA_lDLYcw>
    <xme:fhjjZtvLrpls59bkfP6pTnlxi35TO-rDgwm-x3sSRiKVyN78XiVMkrccOlmRf7ZsV
    8MneGeOb1e2CUFdf68>
X-ME-Received: <xmr:fhjjZnDm10mcZt58ePovUYMgHVlq32HiA9gLPqCUJppYKjPrxP2oI92w9TgvliVt0gjduQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    jeenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegfefghffghffhjefgveekhfeukeevffethffg
    tddutdefffeuheelgeelieeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtg
    hkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnugihsehg
    rhgvhihhohhushgvrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehirdhm
    rgigihhmvghtshesohhvnhdrohhrghdprhgtphhtthhopegrtghonhholhgvsehrvgguhh
    grthdrtghomh
X-ME-Proxy: <xmx:fxjjZtcpGT4nFIFZqW957iUHsPBQjPqyEHb39YWNsijqJKhzmG05ow>
    <xmx:fxjjZuO-xUzkCcCmY8WLALhgz0SNe05KPFb4bUMelCBQ8vNF3fJ1Kw>
    <xmx:fxjjZvnU3K3pi254ZjIdsZNDnKQamII9JXeyKIDd4DBaT629J-fMfA>
    <xmx:fxjjZov1hyRjK_k6WGdpGBh2h6BgPfLI4ciah2bW8r6C6JHjEy8-MQ>
    <xmx:fxjjZotvANpncMudjnw-iZRwtNkjRGHNfZplSDyQMXXNwbf6ufrurRtW>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 12:36:14 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 465E29FC8F; Thu, 12 Sep 2024 09:36:13 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 454B59FBCC;
	Thu, 12 Sep 2024 09:36:13 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>,
    Ilya Maximets <i.maximets@ovn.org>,
    Adrian Moreno <amorenoz@redhat.com>,
    Stanislas Faye <sfaye@redhat.com>
Subject: Re: [Discuss] ARP monitor for OVS bridge over bonding
In-reply-to: <ZuAcpIqvJYmCTFFK@fedora>
References: <ZuAcpIqvJYmCTFFK@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 10 Sep 2024 10:17:08 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 09:36:13 -0700
Message-ID: <385751.1726158973@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi all,
>
>Recently, our customer got an issue with OVS bridge over bonding. e.g.
>
>  eth0      eth1
>   |         |
>   -- bond0 --
>        |
>      br-ex (ovs-vsctl add-port br-ex bond0; ip addr add 192.168.1.1/24 de=
v br-ex)
>
>
>Before sending arp message for bond slave detecting, the bond need to check
>if the br-ex is in the same data path with bond0 via function
>bond_verify_device_path(), which using netdev_for_each_upper_dev_rcu()
>to check all upper devices. This works with normal bridge. But with ovs
>bridge, the upper device is "ovs-system" instead of br-ex.
>
>After talking with OVS developers. It turned out the real upper OVS topolo=
gy
>is looks like
>
>              --------------------------------
>              |                              |
>  br-ex  -----+--      ovs-system            |
>              |                              |
>  br-int -----+--                            |
>              |                              |
>              |    bond0    eth2   veth42    |
>              |      |       |       |       |
>              |      |       |       |       |
>              -------+-------+-------+--------
>                     |       |       |
>                  +--+--+  physical  |
>                  |     |    link    |
>                eth0  eth1          veth43
>
>The br-ex is not upper link of bond0. ovs-system, instead, is the master
>of bond0. This make us unable to make sure the br-ex and bond0 is in the
>same datapath.

	I'm guessing that this is in the context of an openstack
deployment, as "br-ex" and "br-int" are names commonly chosen for the
OVS bridges in openstack.

	But, yes, OVS bridge configuration is very different from the
linux bridge, and the ARP monitor was not designed with OVS in mind.

	I'll also point out that OVS has its own bonding, although it
does not implement functionality equivalent to the ARP monitor.

	However, OVS does provide an implementation of RFC 5880 BFD
(Bidirectional Forwarding Detection).  The openstack deployments that
I'm familiar with typically use the kernel bonding in LACP mode along
with BFD.  Is there a reason that OVS + BFD is unsuitable for your
purposes?

>On the other hand, as Adri=C3=A1n Moreno said, the packets generated on br=
-ex
>could be routed anywhere using OpenFlow rules (including eth2 in the
>diagram). The same with normal bridge, with tc/netfilter rules, the packets
>could also be routed to other interface instead of bond0.

	True, and, at least in the openstack OVN/OVS deployments I'm
familiar with, heavy use of openflow rules is the usual configuration.
Those deployments also make use of tc rules for various purposes.

>So the rt interface checking in bond_arp_send_all() is not always correct.
>Stanislas suggested adding a new parameter like 'arp monitor source interf=
ace'
>to binding that the user could supply. Then we can do like
>	If (rt->dst.dev =3D=3D arp_src_iface->dev)
>		goto found;
>
>What do you think?

	A single "arp_src_iface" parameter won't scale if there are
multiple ARP targets, as each target might need a different
"arp_src_iface."

	Also, the original purpose of bond_verify_device_path() is to
return VLAN tags in the device stack so that the ARP will be properly
tagged.

	I think what you're really asking for is a "I know what I'm
doing" option to bypass the checks in bond_arp_send_all().  That would
also skip the VLAN tag search, so it's not necessarily a perfect
solution.

	Before considering such a change, I'd like to know why OVS + BFD
over a kernel bond attached to the OVS bridge is unsuitable for your use
case, as that's a common configuration I've seen with OVS.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net


