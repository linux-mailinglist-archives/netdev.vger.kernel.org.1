Return-Path: <netdev+bounces-107932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15291D131
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0651C20B89
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0DD42AA9;
	Sun, 30 Jun 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jyoWQLNt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50713774B
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743987; cv=none; b=WKER5VaSRzp948xtNE+JV+8gttM9V8JRzh7es86OAB+jVkmm2cJwt/FiNPWgpSjum1OVVeZ+7uJmOBA5ZcV5dzXhOZe1IWgRl1Wk1TmovBeRxnrcCmwq0L6ZUsoQwRlKbVgRjYwB/gyJVUHgD6Uk0WlB/K7iKwOnSB4KawGgztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743987; c=relaxed/simple;
	bh=GD7aEpljpWrDBQnDoYmPXFQ1P1aaimd8YiuaNl718rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooG2/Rwx4b+UY2Z7RdppdY3zQYdN/PTS9/BNbBun1Ofs6vMiHUAuzwEGdUFB1O3lg+OOj2mfH8b3tLO0T3oCJSyEafanKgMy5h2Mk8jfiDMl2wo7HnLrwL6DjV5kflzPFzS3bHUh6EuyyoOeKARrIfS2oMV5zJZxyAhFPaZemvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jyoWQLNt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E575711401FB;
	Sun, 30 Jun 2024 06:39:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 30 Jun 2024 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719743983; x=
	1719830383; bh=d0cdZadaw7x+M1i0jWPl4nnSteCyEtMjXqgFAHeLZ90=; b=j
	yoWQLNtDvBkdsZatQpl89nD9E+4so0w3i5eCoDGKut9QzkdLQo6bqjk+Pl/MViUC
	cZjZas02hIklKTtg5dKbVafwHO5Dj1DZnogNlXPAJl0UOgp03sAfpLuLa0aAmaNR
	pwoUp5uKYmjF6pOfd+k4Zv1E2eRYO+ALIlzSAfB8sQTUKGikPa4788PktzhCvfBM
	wDjupUK3cxhNUEAQKDYO2TppYgy2lTVVJKS0pBG/WvKjhDpszYIevmXY1yPzx3mh
	J3JjBtQiIzuSWWqcCQD00RJURKWlUyUlK2EyQljO9AxpqH9ditq+1116lJ+EqePS
	dlEyJc+EHtLmRIuVu76gA==
X-ME-Sender: <xms:7zWBZmo2_8BVniS2VQjpqIQPu3P_eBP3tHX2F_yC-UhW3gVc8EoZpQ>
    <xme:7zWBZkqDO9W53qh4vE9AEQ1T8PohQkQv5kg9zxlS7AG0ZD2342z_B_itSaRSrkx7y
    UXwhJaPmMOECcc>
X-ME-Received: <xmr:7zWBZrO6420kCH42Ez0GbsCtFL8PQ1ZywaZ6zaX15f-6Eva5jnHtu4m1Fo_6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeviedtudefkeejtdduieeitdettdfffeevgeejkedvhfdtkeejhfethedu
    feffnecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiugho
    shgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:7zWBZl68mv-uyVxykn_h6GiAX5kOIA0-AImXw_E6ljuchptsEdaP8A>
    <xmx:7zWBZl5sCkFXu6kfmVirQQndavlJG_NbcGbra8AOjtejBB3MnqH9wg>
    <xmx:7zWBZlg0W_rTHFZMJSdup-Xl7f1dj0-WvQSA8yv4X1KHmEAQTVzvCA>
    <xmx:7zWBZv7qmY3nKGNaChWuW4yzGheYsWmfug7IdO0_deNbjd2m5tVHtA>
    <xmx:7zWBZlFnB6RVCido0Eoc8SGia4CoC3AeBKjjdkyKSzbNeV6-L1fJdigT>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jun 2024 06:39:42 -0400 (EDT)
Date: Sun, 30 Jun 2024 13:39:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Message-ID: <ZoE15-y0wMhzQEYg@shredder.mtl.com>
References: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <20240627193632.5ea88216@hermes.local>
 <SJ0PR84MB20889120746B75792B83693CD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SJ0PR84MB20889120746B75792B83693CD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>

On Fri, Jun 28, 2024 at 02:54:58AM +0000, Muggeridge, Matt wrote:
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Friday, June 28, 2024 12:37 PM
> >=20
> > On Fri, 28 Jun 2024 00:01:47 +0000
> > "Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:
> >=20
> > > Hi,
> > >
> > > This looks like a problem in "iproute2".  This was observed on a fres=
h install
> > of Ubuntu 24.04, with Linux 6.8.0-36-generic.
> > >
> > > NOTE: I first raised this in
> > https://bugs.launchpad.net/ubuntu/+source/iproute2/+bug/2070412, then
> > later found https://github.com/iproute2/iproute2/blob/main/README.devel.
> > >
> > > * PROBLEM
> > > Compare the outputs:
> > >
> > > $ ip -6 route show dev enp0s9
> > > 2001:2:0:1000::/64 proto ra metric 1024 expires 65518sec pref medium
> > > fe80::/64 proto kernel metric 256 pref medium
> > >
> > > $ ip -6 route
> > > 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65525sec
> > > pref medium
> > > fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> > > fe80::/64 dev enp0s9 proto kernel metric 256 pref medium default proto
> > > ra metric 1024 expires 589sec pref medium  nexthop via
> > > fe80::200:10ff:fe10:1060 dev enp0s9 weight 1  nexthop via
> > > fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> > >
> > > The default route is associated with enp0s9, yet the first command ab=
ove
> > does not show it.
> > >
> > > FWIW, the two default route entries were created by two separate rout=
ers
> > on the network, each sending their RA.
> > >
> > > * REPRODUCER
> > > Statically Configure systemd-networkd with two route entries, similar=
 to the
> > following:
> > >
> > > $ networkctl cat 10-enp0s9.network
> > > # /etc/systemd/network/10-enp0s9.network
> > > [Match]
> > > Name=3Denp0s9
> > >
> > > [Link]
> > > RequiredForOnline=3Dno
> > >
> > > [Network]
> > > Description=3D"Internal Network: Private VM-to-VM IPv6 interface"
> > > DHCP=3Dno
> > > LLDP=3Dno
> > > EmitLLDP=3Dno
> > >
> > >
> > > # /etc/systemd/network/10-enp0s9.network.d/address.conf
> > > [Network]
> > > Address=3D2001:2:0:1000:a00:27ff:fe5f:f72d/64
> > >
> > >
> > > # /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
> > > [Route]
> > > Gateway=3Dfe80::200:10ff:fe10:1060
> > > GatewayOnLink=3Dtrue
> > >
> > >
> > > # /etc/systemd/network/10-enp0s9.network.d/route-1061.conf
> > > [Route]
> > > Gateway=3Dfe80::200:10ff:fe10:1061
> > > GatewayOnLink=3Dtrue
> > >
> > >
> > >
> > > Now reload and reconfigure the interface and you will see two routes.
> > >
> > > $ networkctl reload
> > > $ networkctl reconfigure enp0s9
> > > $ ip -6 r
> > > $ ip -6 r show dev enp0s9 # the routes are not shown
> > >
> >=20
> > "Don't blame the messenger", the ip command only reports what the kernel
> > sends. So it is likely a route semantics issue in the kernel.
>=20
> Thanks Stephen.
>=20
> Ok, I have reported it on my distro in https://bugs.launchpad.net/ubuntu/=
+source/linux/+bug/2071406.
>=20
> I guess the kernel netdev folks will see this thread and can comment too?

The problem seems to be in iproute2 and not in the kernel. Both IPv4 and
IPv6 will dump the route if at least one of the nexthop devices is the
one specified by user space. You can see the routes in the strace output
below.

ip link add name dummy1 up type dummy
ip link add name dummy2 up type dummy
ip address add 192.0.2.1/28 dev dummy1
ip address add 192.0.2.17/28 dev dummy2
ip addres add 2001:db8:1::1/64 dev dummy1
ip addres add 2001:db8:2::1/64 dev dummy2
ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy1 nexthop via 1=
92.0.2.18 dev dummy2
ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy1 nexthop =
via 2001:db8:2::2 dev dummy2

# strace -e network ip -4 route show dev dummy1
[...]
recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D000=
00000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[[{nlmsg_len=3D60, nlmsg_t=
ype=3DRTM_NEWROUTE, nlmsg_flags=3DNLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_se=
q=3D1719737009, nlmsg_pid=3D704}, {rtm_family=3DAF_INET, rtm_dst_len=3D28, =
rtm_src_len=3D0, rtm_tos=3D0, rtm_table=3DRT_TABLE_MAIN, rtm_protocol=3DRTP=
ROT_KERNEL, rtm_scope=3DRT_SCOPE_LINK, rtm_type=3DRTN_UNICAST, rtm_flags=3D=
0}, [[{nla_len=3D8, nla_type=3DRTA_TABLE}, RT_TABLE_MAIN], [{nla_len=3D8, n=
la_type=3DRTA_DST}, inet_addr("192.0.2.0")], [{nla_len=3D8, nla_type=3DRTA_=
PREFSRC}, inet_addr("192.0.2.1")], [{nla_len=3D8, nla_type=3DRTA_OIF}, if_n=
ametoindex("dummy1")]]], [{nlmsg_len=3D80, nlmsg_type=3DRTM_NEWROUTE, nlmsg=
_flags=3DNLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=3D1719737009, nlmsg_pid=
=3D704}, {rtm_family=3DAF_INET, rtm_dst_len=3D24, rtm_src_len=3D0, rtm_tos=
=3D0, rtm_table=3DRT_TABLE_MAIN, rtm_protocol=3DRTPROT_BOOT, rtm_scope=3DRT=
_SCOPE_UNIVERSE, rtm_type=3DRTN_UNICAST, rtm_flags=3D0}, [[{nla_len=3D8, nl=
a_type=3DRTA_TABLE}, RT_TABLE_MAIN], [{nla_len=3D8, nla_type=3DRTA_DST}, in=
et_addr("198.51.100.0")], [{nla_len=3D36, nla_type=3DRTA_MULTIPATH}, [[{rtn=
h_len=3D16, rtnh_flags=3D0, rtnh_hops=3D0, rtnh_ifindex=3Dif_nametoindex("d=
ummy1")}, [{nla_len=3D8, nla_type=3DRTA_GATEWAY}, inet_addr("192.0.2.2")]],=
 [{rtnh_len=3D16, rtnh_flags=3D0, rtnh_hops=3D0, rtnh_ifindex=3Dif_nametoin=
dex("dummy2")}, [{nla_len=3D8, nla_type=3DRTA_GATEWAY}, inet_addr("192.0.2.=
18")]]]]]]], iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0, msg_fla=
gs=3D0}, 0) =3D 140

# strace -e network ip -6 route show dev dummy1
[...]
recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D000=
00000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[[{nlmsg_len=3D116, nlmsg_=
type=3DRTM_NEWROUTE, nlmsg_flags=3DNLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_s=
eq=3D1719737009, nlmsg_pid=3D708}, {rtm_family=3DAF_INET6, rtm_dst_len=3D64=
, rtm_src_len=3D0, rtm_tos=3D0, rtm_table=3DRT_TABLE_MAIN, rtm_protocol=3DR=
TPROT_KERNEL, rtm_scope=3DRT_SCOPE_UNIVERSE, rtm_type=3DRTN_UNICAST, rtm_fl=
ags=3D0}, [[{nla_len=3D8, nla_type=3DRTA_TABLE}, RT_TABLE_MAIN], [{nla_len=
=3D20, nla_type=3DRTA_DST}, inet_pton(AF_INET6, "2001:db8:1::")], [{nla_len=
=3D8, nla_type=3DRTA_PRIORITY}, 256], [{nla_len=3D8, nla_type=3DRTA_OIF}, i=
f_nametoindex("dummy1")], [{nla_len=3D36, nla_type=3DRTA_CACHEINFO}, {rta_c=
lntref=3D0, rta_lastuse=3D0, rta_expires=3D0, rta_error=3D0, rta_used=3D0, =
rta_id=3D0, rta_ts=3D0, rta_tsage=3D0}], [{nla_len=3D5, nla_type=3DRTA_PREF=
}, 0]]], [{nlmsg_len=3D168, nlmsg_type=3DRTM_NEWROUTE, nlmsg_flags=3DNLM_F_=
MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=3D1719737009, nlmsg_pid=3D708}, {rtm_f=
amily=3DAF_INET6, rtm_dst_len=3D64, rtm_src_len=3D0, rtm_tos=3D0, rtm_table=
=3DRT_TABLE_MAIN, rtm_protocol=3DRTPROT_BOOT, rtm_scope=3DRT_SCOPE_UNIVERSE=
, rtm_type=3DRTN_UNICAST, rtm_flags=3D0}, [[{nla_len=3D8, nla_type=3DRTA_TA=
BLE}, RT_TABLE_MAIN], [{nla_len=3D20, nla_type=3DRTA_DST}, inet_pton(AF_INE=
T6, "2001:db8:10::")], [{nla_len=3D8, nla_type=3DRTA_PRIORITY}, 1024], [{nl=
a_len=3D60, nla_type=3DRTA_MULTIPATH}, [[{rtnh_len=3D28, rtnh_flags=3D0, rt=
nh_hops=3D0, rtnh_ifindex=3Dif_nametoindex("dummy1")}, [{nla_len=3D20, nla_=
type=3DRTA_GATEWAY}, inet_pton(AF_INET6, "2001:db8:1::2")]], [{rtnh_len=3D2=
8, rtnh_flags=3D0, rtnh_hops=3D0, rtnh_ifindex=3Dif_nametoindex("dummy2")},=
 [{nla_len=3D20, nla_type=3DRTA_GATEWAY}, inet_pton(AF_INET6, "2001:db8:2::=
2")]]]], [{nla_len=3D36, nla_type=3DRTA_CACHEINFO}, {rta_clntref=3D0, rta_l=
astuse=3D0, rta_expires=3D0, rta_error=3D0, rta_used=3D0, rta_id=3D0, rta_t=
s=3D0, rta_tsage=3D0}], [{nla_len=3D5, nla_type=3DRTA_PREF}, 0]]], [{nlmsg_=
len=3D116, nlmsg_type=3DRTM_NEWROUTE, nlmsg_flags=3DNLM_F_MULTI|NLM_F_DUMP_=
FILTERED, nlmsg_seq=3D1719737009, nlmsg_pid=3D708}, {rtm_family=3DAF_INET6,=
 rtm_dst_len=3D64, rtm_src_len=3D0, rtm_tos=3D0, rtm_table=3DRT_TABLE_MAIN,=
 rtm_protocol=3DRTPROT_KERNEL, rtm_scope=3DRT_SCOPE_UNIVERSE, rtm_type=3DRT=
N_UNICAST, rtm_flags=3D0}, [[{nla_len=3D8, nla_type=3DRTA_TABLE}, RT_TABLE_=
MAIN], [{nla_len=3D20, nla_type=3DRTA_DST}, inet_pton(AF_INET6, "fe80::")],=
 [{nla_len=3D8, nla_type=3DRTA_PRIORITY}, 256], [{nla_len=3D8, nla_type=3DR=
TA_OIF}, if_nametoindex("dummy1")], [{nla_len=3D36, nla_type=3DRTA_CACHEINF=
O}, {rta_clntref=3D0, rta_lastuse=3D0, rta_expires=3D0, rta_error=3D0, rta_=
used=3D0, rta_id=3D0, rta_ts=3D0, rta_tsage=3D0}], [{nla_len=3D5, nla_type=
=3DRTA_PREF}, 0]]]], iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0,=
 msg_flags=3D0}, 0) =3D 400

Following patch works for me [1], but it is missing support for
RTA_GATEWAY which is also present in the RTA_MULTIPATH nest.

[1]
diff --git a/ip/iproute.c b/ip/iproute.c
index b53046116826..3999853a1455 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -310,12 +310,28 @@ static int filter_nlmsg(struct nlmsghdr *n, struct rt=
attr **tb, int host_len)
 			return 0;
 	}
 	if (filter.oifmask) {
-		int oif =3D 0;
+		if (tb[RTA_OIF]) {
+			int oif =3D rta_getattr_u32(tb[RTA_OIF]);
=20
-		if (tb[RTA_OIF])
-			oif =3D rta_getattr_u32(tb[RTA_OIF]);
-		if ((oif^filter.oif)&filter.oifmask)
-			return 0;
+			if ((oif ^ filter.oif) & filter.oifmask)
+				return 0;
+		} else if (tb[RTA_MULTIPATH]) {
+			const struct rtnexthop *nh =3D RTA_DATA(tb[RTA_MULTIPATH]);
+			int len =3D RTA_PAYLOAD(tb[RTA_MULTIPATH]);
+			bool dev_match =3D false;
+
+			while (len >=3D sizeof(*nh)) {
+				if (nh->rtnh_ifindex =3D=3D filter.oif) {
+					dev_match =3D true;
+					break;
+				}
+
+				len -=3D NLMSG_ALIGN(nh->rtnh_len);
+				nh =3D RTNH_NEXT(nh);
+			}
+			if (!dev_match)
+				return 0;
+		}
 	}
 	if (filter.markmask) {
 		int mark =3D 0;

