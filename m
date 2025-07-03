Return-Path: <netdev+bounces-203594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD1AF67AE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E8D3A84CE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF8199938;
	Thu,  3 Jul 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="lwQgDtwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdYdjd+y"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C019CD01
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508283; cv=none; b=iY2bSL+Za0/4elAGvZULMfufUHQz1doErvlNOfd2xt+AZA/ANdLUoh5adQrDSHoLE+Stk00qNW4OmyN4rmJW2PUPNzIlzgoA6tkWw743FWa1HfJpUnJKcKSxZn66wVpjSfrBX4KC5icI44KE8eAA+LwSFeoFSt/nPf9wMn2ifCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508283; c=relaxed/simple;
	bh=QwbwxHuUSZw7VthUr64eBXdnm41ll7boPk8Dcx/dEfY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=XF0Zs3Xn3aFpAN9sJyriodAPpbNiK/KqSt5H2oOyHfEiJqw3cKXu0VkjeQgRoP2tGGuR8Jn07SgalWbn5PCelJJg8KPPijNGgF5kFeHyhqHLsVAyMxhhveWtLOYsjzjrnby0/IISU9zD9uE86k6dGhvjmMv1rQyrnVPLo2kcnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=lwQgDtwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdYdjd+y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48E5B7A01B6;
	Wed,  2 Jul 2025 22:04:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Jul 2025 22:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1751508279; x=1751594679; bh=LgCboNf9VRh2HsoffQHcB
	ujniFP5VYigWjgrnH4BqUI=; b=lwQgDtwe1GzJ+wa/r4kNrKSgp99bvI8d562HD
	C/rsfcEmP/f4TaExb51lWEyrhQ8IEg3zfA++EqGV0cPMfzLe/eczo16YOhw2XuYu
	2OLLIXvwz71rlPkWpg1tBEJLlgcCJ5kSLupF22I/ZrHu4J7QJJAd9+fEnhJ3ys86
	WZQXyASMdKO0PqU3dSeFqQFjwJ5FxkNf3kHeajlU0tvrVUv7/LuVi6jLIoYVTPWF
	6HGhzCn1nbRcuo3uUH9JWvBgF4Y2D1W8/z/6p9Sa5C/AMdAmkh6INCvOVyj7Dm4N
	48g1ovPXJqbG35FIyvpBNAmT8yX2G7PvJJpG44W42MgqVqdtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751508279; x=1751594679; bh=LgCboNf9VRh2HsoffQHcBujniFP5VYigWjg
	rnH4BqUI=; b=IdYdjd+ysxu8x/hgrL5c51XqH6XwBmhNL9aA/MvoRoCCxT9OgYu
	uNg0Y95wF13uUlSZftWNrJLIvfnwDis0eqqY1wGrmpBKBwmHnQ/NfrKM4+mJs76X
	tCYRuaBD+JbkdOKxRGbTe+K9oYqojKS/zUVag8zgIxIQdlvgtaUb5dTGcGQJyoHo
	dLwaZWyrni+QvYWRIjSx2j30Rw4k6S8x18/GxiVtrm9i7hlOL/Gl3qeMOthKtuyU
	zoDfR7fwrPwW72JdaKO2zcTKOeayNOb81/LMOYK2EVF0sgRNfOpxsSFhuNL8IqwZ
	zhE2OEdBH7YbUQvfnPTbsk0T6Arb03v3cMQ==
X-ME-Sender: <xms:NuVlaP_JZTV380YVGIeTqKX3oOduizLzqth01a59o03RkDtNpN1dCA>
    <xme:NuVlaLs33NDAm4pbjSvmu7isG2n-HWe6eW8Zpsya3lttP29FopiVeov9MFMJMrlAp
    q8NqdYjWRf3fS0-zmo>
X-ME-Received: <xmr:NuVlaNAUmkl2gev_SSTIRG3p9DaP3oIsb83UVL0fSZXMcfl6cD-6AyALsK-qSs8KbMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepughsrghhvghrnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hprhgruggvvghpsheslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhrtghpthhtohep
    shhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepih
    drmhgrgihimhgvthhssehovhhnrdhorhhgpdhrtghpthhtoheprghmohhrvghnohiisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehhrghlihhusehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehprhgruggvvghpsehushdrihgsmhdrtghomhdprhgtphhtthhopeifihhl
    uggvrhesuhhsrdhisghmrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NuVlaLco8ZntqTHhBEgNxw5QisGgb23qzbp5wYmj1xZ_aiywbiKcMA>
    <xmx:NuVlaEOEOq3iF3DeLOtdHCs6HB3UwoprKCE_6edQ3Gg91zjhKVWzug>
    <xmx:NuVlaNkead1gZ5UewKdlAVnRKJfXHlh3P-UEU-g0b4mWPqagu57Hvg>
    <xmx:NuVlaOupIsghoqOd5KnQ3KmxYM2sEZelc5MUqVVfB3rhIndJPOHR8Q>
    <xmx:N-VlaMTo9mOOlVL-VpofLTHbbd-_WenFy1329Okh2PaVjCDbrVGPfgUC>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 22:04:37 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 8E3D91C01B8; Thu,  3 Jul 2025 04:04:36 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 8C31D1C0140;
	Wed,  2 Jul 2025 19:04:36 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
In-reply-to: <20250627202430.1791970-2-wilder@us.ibm.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com> <20250627202430.1791970-2-wilder@us.ibm.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Fri, 27 Jun 2025 13:23:44 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2156541.1751508276.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jul 2025 19:04:36 -0700
Message-ID: <2156542.1751508276@vermin>

David Wilder <wilder@us.ibm.com> wrote:

>This change extends the "arp_ip_target" parameter format to allow for
>a list of vlan tags to be included for each arp target.
>
>The new format for arp_ip_target is:
>arp_ip_target=3Dipv4-address[vlan-tag\...],...
>
>Examples:
>arp_ip_target=3D10.0.0.1[10]
>arp_ip_target=3D10.0.0.1[100/200]
>
>Signed-off-by: David Wilder <wilder@us.ibm.com>
>---
> ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 59 insertions(+), 3 deletions(-)
>
>diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
>index 19af67d0..bb0b6e84 100644
>--- a/ip/iplink_bond.c
>+++ b/ip/iplink_bond.c
>@@ -173,6 +173,45 @@ static void explain(void)
> 	print_explain(stderr);
> }
> =

>+#define BOND_VLAN_PROTO_NONE htons(0xffff)
>+
>+struct bond_vlan_tag {
>+	__be16	vlan_proto;
>+	__be16	vlan_id;
>+};
>+
>+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list=
, int level, int *size)
>+{
>+	struct bond_vlan_tag *tags =3D NULL;
>+	char *vlan;
>+	int n;
>+
>+	if (!vlan_list || strlen(vlan_list) =3D=3D 0) {
>+		tags =3D calloc(level + 1, sizeof(*tags));
>+		*size =3D (level + 1) * (sizeof(*tags));
>+		if (tags)
>+			tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;
>+		return tags;
>+	}
>+
>+	for (vlan =3D strsep(&vlan_list, "/"); (vlan !=3D 0); level++) {
>+		tags =3D bond_vlan_tags_parse(vlan_list, level + 1, size);
>+		if (!tags)
>+			continue;
>+
>+		tags[level].vlan_proto =3D htons(ETH_P_8021Q);
>+		n =3D sscanf(vlan, "%hu", &(tags[level].vlan_id));
>+
>+		if (n !=3D 1 || tags[level].vlan_id < 1 ||
>+		    tags[level].vlan_id > 4094)
>+			return NULL;

	Two questions:

	1) Do we care about 802.1p priority tags?  If memory serves,
those manifest as VLAN tags with a VLAN ID of 0 and some other bits set
to provide the priority.  The above appears to disallow such tags.

	2) This loop appears to be unbounded, and will process an
unlimited number of VLANs.  Do we need more than 2 (the original 802.1ad
limit)?  Even if we need more than 2, the upper limit should probably be
some reasonably small number.  The addattr loop (below) will conk out if
the whole thing exceeds 1024 bytes, but that would still permit 120 or
so.

	-J

>+
>+		return tags;
>+	}
>+
>+	return NULL;
>+}
>+
> static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
> 			  struct nlmsghdr *n)
> {
>@@ -239,12 +278,29 @@ static int bond_parse_opt(struct link_util *lu, int=
 argc, char **argv,
> 				NEXT_ARG();
> 				char *targets =3D strdupa(*argv);
> 				char *target =3D strtok(targets, ",");
>-				int i;
>+				struct bond_vlan_tag *tags;
>+				int size, i;
> =

> 				for (i =3D 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
>-					__u32 addr =3D get_addr32(target);
>+					struct Data {
>+						__u32 addr;
>+						struct bond_vlan_tag vlans[];
>+					} data;
>+					char *vlan_list, *dup;
>+
>+					dup =3D strdupa(target);
>+					data.addr =3D get_addr32(strsep(&dup, "["));
>+					vlan_list =3D strsep(&dup, "]");
>+
>+					if (vlan_list) {
>+						tags =3D bond_vlan_tags_parse(vlan_list, 0, &size);
>+						memcpy(&data.vlans, tags, size);
>+						addattr_l(n, 1024, i, &data,
>+							  sizeof(data.addr)+size);
>+					} else {
>+						addattr32(n, 1024, i, data.addr);
>+					}
> =

>-					addattr32(n, 1024, i, addr);
> 					target =3D strtok(NULL, ",");
> 				}
> 				addattr_nest_end(n, nest);
>-- =

>2.43.5
>

---
	-Jay Vosburgh, jv@jvosburgh.net

