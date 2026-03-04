Return-Path: <netdev+bounces-263591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iACsEffBp2l1jgAAu9opvQ
	(envelope-from <netdev+bounces-263591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:24:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FA1FAD8E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1408301BF45
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A53264F4;
	Wed,  4 Mar 2026 05:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="U/qEWd4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRHAtJT0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811B1DFDA1;
	Wed,  4 Mar 2026 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601843; cv=none; b=ZboBpDZ9q4FZbnIQb0IV2PdWcf54rD1/YbISx4gQ60Ypmg16IsFmP9Iyk7k+mb078qtTr0iBmStZv2r7G50Zhig5GIO1HwPu9FEiu1wAFR/lnnQQgVkzcvlYAWvqWL/bZOSiDw2qxrfVBqaiGNyuOUs9iMke+i3PPoOX3Ud0gOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601843; c=relaxed/simple;
	bh=y238ubiuZijneBu6d5QYYCF1rPKNMUMebyAZGCn55Gs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=kjduBhfHTDrsbKCW8Y6xVSi5DMc6sTUeg62v68p4VvGTW7NvSwwvvc7q8/aR09CMR9J9gGjtMVb5OZTOwsSYQ5RlRGdT/5nqfX0LTo14lJbDmQdzwbyYY+0Zos1pwsrrnCpLtepqOp1e5egPiUVOXgYkMNJHLVGoD3xXlOqec6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=U/qEWd4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRHAtJT0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F9EF1D0018F;
	Wed,  4 Mar 2026 00:24:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 00:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1772601840; x=1772688240; bh=owTFGO47o/tsXSGEUpaLw
	rWEC2ihdOP3ar9ujd58bpQ=; b=U/qEWd4LPjqaX4Bh31kSgk9f6y13mC9QNfmWO
	t2STeLQKeKPQYCD8vN96YxGXcQZFCwXNh+/bpeqmGGpcKqlN6kWaFHt+j8n5MqCu
	Iu9UkBiGrEqGC6BJ+PfuySY0RsvFJJ9Wxz1zPof17ONQRTubm/EIku+Hcy3T+bRp
	Fc8A10iUvBxorqjWDGUkg7cbV0T4t4HK3t5BtD7PG9xxjXJkp/0SUf2CBYGE4OTu
	JR1z5guvun8oSLNgHAROx3goBMsUpXHA5XddxPVR6D0O9h+4POC9+4h3CDjDcswN
	HDVUdD5umR3uCRoRMgbN4d4M1YzVofE0OIao2KSpP0TGugUIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772601840; x=1772688240; bh=owTFGO47o/tsXSGEUpaLwrWEC2ihdOP3ar9
	ujd58bpQ=; b=IRHAtJT0H2UzTwP9HiIOJRl10gnxkRQqrn5RAy4DCLlqKS2dRUh
	jPeQ4MJipLoyYbSx6F1QguldajSs34pRMWJGB6VobznM9JX/CtMdXv0o/W15Otai
	/dhRiOy/EzRqOQHrPV6DkRZSCIYQ/EShU/483GXkaJIHP5e/Rqi4Zrc8s/4KgmvH
	8eJ4L9ND0SgqKxVuRXndIDdNwuDwhwg/yItKn9ZDzvurrBINT/E3r1I+VOBKP3hF
	iB85SvdMDE+hVboNWtsE1yhj4yF4lkukJl8M+sDjpiy9EnP9npXeVtn4v3xBudSb
	STq6TjamAyO8IHKsYqPA2IusveJWbavJ+vQ==
X-ME-Sender: <xms:78GnaU8R667Zm_4-ykAOONleIc3uODabWlHmH_8Vg-SMpNJQc-yg-w>
    <xme:78GnafxZ7FL-FHChX6ZNETUYH3ze0g48k5AN0MfQIFN91kjy6sagEjKvH_72JbVEs
    FSFfQHQ6GyMrS-Ivu0-tm6vDS4J3o5doV6wvHfFYVto-dUKulcV8HYP>
X-ME-Received: <xmr:78GnaUqQ6H90TnxgZGc0eBZyCT52uQzVgwh0ZkVlDadVZdLhqdjpTcvc08tYPpUTCRjbHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgrhihurghnrdgthhgvnheslhhinh
    hugidruggvvhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
    pdhrtghpthhtohepphhshhgvlhgrrhesnhhitghirhgrrdgtohhmpdhrtghpthhtohepph
    grsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihgrhihurghnrdgthhgv
    nhesshhhohhpvggvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:78GnaQpj4nC0F_7MzThkRFlh3IQPveJPPpFqmHlG0r4LHHafCGY3Lg>
    <xmx:78GnaUCQVwKKBYFwUrJrBDJAed5mgZvN8Y9Fd3_I0FTp9gzXDktemA>
    <xmx:78Gnaev7U-ja3i1qLlD6NXsvvboO-9RZ1cazoJAc59lnWB8XQt-Heg>
    <xmx:78GnaTInNvANNuNJ3_Zz4oaRJU12k2EaYYYRJaGFUllozpk2Fp7OTg>
    <xmx:8MGnaQCnLQtSdn9STDRk4GuTOMOCsU8b4B68RnFtPjvOtvcCekSIbegW>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 00:23:59 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 607809FD44; Tue,  3 Mar 2026 21:23:58 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5CFBE9FCB1;
	Tue,  3 Mar 2026 21:23:58 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Pravin B Shelar <pshelar@nicira.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] bonding: fix type confusion in
 bond_setup_by_slave()
In-reply-to: <20260228095854.391093-1-jiayuan.chen@linux.dev>
References: <20260228095854.391093-1-jiayuan.chen@linux.dev>
Comments: In-reply-to Jiayuan Chen <jiayuan.chen@linux.dev>
   message dated "Sat, 28 Feb 2026 17:58:53 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1268308.1772601838.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Mar 2026 21:23:58 -0800
Message-ID: <1268309.1772601838@famine>
X-Rspamd-Queue-Id: 3F1FA1FAD8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263591-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,linux.dev:email,jvosburgh.net:dkim,jvosburgh.net:email,shopee.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

>From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
>kernel BUG at net/core/skbuff.c:2306!
>Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>RIP: 0010:pskb_expand_head+0xa08/0xfe0 net/core/skbuff.c:2306
>RSP: 0018:ffffc90004aff760 EFLAGS: 00010293
>RAX: 0000000000000000 RBX: ffff88807e3c8780 RCX: ffffffff89593e0e
>RDX: ffff88807b7c4900 RSI: ffffffff89594747 RDI: ffff88807b7c4900
>RBP: 0000000000000820 R08: 0000000000000005 R09: 0000000000000000
>R10: 00000000961a63e0 R11: 0000000000000000 R12: ffff88807e3c8780
>R13: 00000000961a6560 R14: dffffc0000000000 R15: 00000000961a63e0
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007fe1a0ed8df0 CR3: 000000002d816000 CR4: 00000000003526f0
>Call Trace:
> <TASK>
> ipgre_header+0xdd/0x540 net/ipv4/ip_gre.c:900
> dev_hard_header include/linux/netdevice.h:3439 [inline]
> packet_snd net/packet/af_packet.c:3028 [inline]
> packet_sendmsg+0x3ae5/0x53c0 net/packet/af_packet.c:3108
> sock_sendmsg_nosec net/socket.c:727 [inline]
> __sock_sendmsg net/socket.c:742 [inline]
> ____sys_sendmsg+0xa54/0xc30 net/socket.c:2592
> ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
> __sys_sendmsg+0x170/0x220 net/socket.c:2678
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>RIP: 0033:0x7fe1a0e6c1a9
>
>When a device (e.g. GRE tunnel) is enslaved to a bond,
>bond_setup_by_slave() directly copies the slave's header_ops to the
>bond device:
>
>    bond_dev->header_ops =3D slave_dev->header_ops;

	This is true only for devices that are not ARPHRD_ETHER.

>This causes a type confusion when dev_hard_header() is later called
>on the bond device. Functions like ipgre_header(), ip6gre_header(),
>vlan_dev_hard_header(), and macvlan_hard_header() all use
>netdev_priv(dev) to access their device-specific private data. When
>called with the bond device, netdev_priv() returns the bond's private
>data (struct bonding) instead of the expected type (e.g. struct
>ip_tunnel), leading to garbage values being read and kernel crashes.

	I believe that vlan and macvlan are both ARPHRD_ETHER, and thus
won't take the bond_setup_by_slave path (which was originally
implemented for Infiniband).

	That said, your description for the GRE paths seems correct.

>Fix this by introducing bond_header_ops with wrapper functions that
>delegate to the active slave's header_ops using the slave's own
>device. This ensures netdev_priv() in the slave's header functions
>always receives the correct device.
>
>The fix is placed in the bonding driver rather than individual device
>drivers, as the root cause is bond blindly inheriting header_ops from
>the slave without considering that these callbacks expect a specific
>netdev_priv() layout.
>
>The type confusion can be observed by adding a printk in
>ipgre_header() and running the following commands:
>
>    ip link add dummy0 type dummy
>    ip addr add 10.0.0.1/24 dev dummy0
>    ip link set dummy0 up
>    ip link add gre1 type gre local 10.0.0.1
>    ip link add bond1 type bond mode active-backup
>    ip link set gre1 master bond1
>    ip link set gre1 up
>    ip link set bond1 up
>    ip addr add fe80::1/64 dev bond1
>
>Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")

	Has something relevant changed more recently than this?  I seem
to recall hearing of folks using bonding with GRE more recently than the
2013 date on c54419321455.  I didn't do an exhaustive search, but I feel
like someone would have run into this in the prior 13-ish years if it's
been broken the whole time.

>Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>---
> drivers/net/bonding/bond_main.c | 41 ++++++++++++++++++++++++++++++++-
> 1 file changed, 40 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 0ccf928eecde..e1d1e3b49cb9 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1509,6 +1509,44 @@ static netdev_features_t bond_fix_features(struct =
net_device *dev,
> 	return features;
> }
> =

>+static int bond_header_create(struct sk_buff *skb, struct net_device *bo=
nd_dev,
>+			      unsigned short type, const void *daddr,
>+			      const void *saddr, unsigned int len)
>+{
>+	struct bonding *bond =3D netdev_priv(bond_dev);
>+	struct slave *slave;
>+	int ret =3D 0;
>+
>+	rcu_read_lock();
>+	slave =3D rcu_dereference(bond->curr_active_slave);
>+	if (slave && slave->dev->header_ops &&
>+	    slave->dev->header_ops->create)
>+		ret =3D slave->dev->header_ops->create(skb, slave->dev,
>+						     type, daddr, saddr, len);
>+	rcu_read_unlock();
>+	return ret;
>+}
>+
>+static int bond_header_parse(const struct sk_buff *skb, unsigned char *h=
addr)
>+{
>+	struct bonding *bond =3D netdev_priv(skb->dev);
>+	struct slave *slave;
>+	int ret =3D 0;
>+
>+	rcu_read_lock();
>+	slave =3D rcu_dereference(bond->curr_active_slave);
>+	if (slave && slave->dev->header_ops &&
>+	    slave->dev->header_ops->parse)
>+		ret =3D slave->dev->header_ops->parse(skb, haddr);
>+	rcu_read_unlock();
>+	return ret;
>+}
>+
>+static const struct header_ops bond_header_ops =3D {
>+	.create	=3D bond_header_create,
>+	.parse	=3D bond_header_parse,
>+};
>+
> static void bond_setup_by_slave(struct net_device *bond_dev,
> 				struct net_device *slave_dev)
> {
>@@ -1516,7 +1554,8 @@ static void bond_setup_by_slave(struct net_device *=
bond_dev,
> =

> 	dev_close(bond_dev);
> =

>-	bond_dev->header_ops	    =3D slave_dev->header_ops;
>+	bond_dev->header_ops	    =3D slave_dev->header_ops ?
>+				      &bond_header_ops : NULL;

	Can slave_dev->header_ops actually be NULL?

	-J


> 	bond_dev->type		    =3D slave_dev->type;
> 	bond_dev->hard_header_len   =3D slave_dev->hard_header_len;
>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

