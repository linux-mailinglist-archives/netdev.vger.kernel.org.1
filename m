Return-Path: <netdev+bounces-205090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D74AFD2F7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D364E7B1D5E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649722E4985;
	Tue,  8 Jul 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="p8VNGwrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZevqjWv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4D14A60D
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993503; cv=none; b=Kk+2ZVLB/Kkf61tlkKT+29oZ3Z9X0xhtzlaz98K94iPnHQMW+PU8Dz0ZsOLdmW3A5Cg+Z3r9fDxjexjxg2/fI/TzLJhHBbSiUeCIvV79PElCriBnXUYnTCIBdZNry/HaOww+QfKIDYQDA45QmTj0RW0qUT8LIjX0IRipg09drDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993503; c=relaxed/simple;
	bh=OyljT9PSVKnpfH3jdIqUZjzrh0JCfRE96BnTBLczcIo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=mpk7RHHAANUNBQ3m0PC+83Sm9m2mQQgRdhfQ3cYsBpjMAOajUyW/ad/nVR+ufG6zA4qXz0HtGAllZqOMZgrUqbvx8UG7EsbRMVPduTI2caA+1L7/DuoxWAPknTGaRfJiHVC3JWe+x/K7a3HnUr2JnY7qZ4gNOAgVQAeggVmEG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=p8VNGwrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZevqjWv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C90A7A0295;
	Tue,  8 Jul 2025 12:51:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1751993499; x=1752079899; bh=azCWh3JV1z2s7t1pYzDf4
	+nhXiDyVCZ87JjSSxlCDFg=; b=p8VNGwrWBY2bnjh5RlYFBJUFsLE+7ReG92oRV
	2edqxd/NmijGLN6NRCx+X9Z7QR2TQruKTDDum52OaaUumUpk9Z/0bKP4XRTbntJN
	XFGjAasnqzNeFGUDGt6ybMMt/MCtzVK0n/TH39qv+xyjPDu3cNDn9ofwOvIrsQfQ
	sy3wWN5sjJgcv2OH5Y92gDn9gk2RCJVCkS7su1kybvbq1ad2HJtwr4xqmySJdsvI
	EQCLBG5ryvydXHYDOpgtgbCVa6snnGLE4iKQTiVjX3Jta32F4/9Zvr7PS82V6Uu7
	5By/IgV4DvE6bg1dKqkiKGC5owEZPVki3oHQQqWmk9B1wXRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751993499; x=1752079899; bh=azCWh3JV1z2s7t1pYzDf4+nhXiDyVCZ87Jj
	SSxlCDFg=; b=dZevqjWv9YjjPeTVcWEPxQDSitNRBJAXouZJlhbb8UyiOsXYakR
	gJvCzt/eskjDiksdoad4zn5JqmvjBOQ/ozFjybl7oXxykrtkVUQ8RrHlKEPDBogY
	Ky8YL+Zc4LRZa8UpdnvuZyV/QGhUrbrXa4Fdwn0fX9SrCik/ZPI6OAaTf5OOfINd
	luhHyjETMorU8RTm5xl1VPVLHxUO2lp6GnRcGVAQumYUsCTeqt3FITdOoyh2T8Yh
	C6wTfwbiyj6eqf4EAe6KOsw1mSBgTrz1Cc/3ePLJYqjgFesvMZJYFnRM/fP2Lyhz
	G4iuPTgIdHxIHiGW0ZxHZ3a+kK5R0E0ysAw==
X-ME-Sender: <xms:mkxtaGDlQcOA3aapOKmmat2HDFNgweIIU6A1LVsfU0q9nCWYpmamZg>
    <xme:mkxtaN7BwGekLt-ktlLLj0IZBykiDMfnwNPbtT9CVlFXFR9CHSGv8PqbFUtWQQLAI
    qjZ48LRf2cRlxWS3W8>
X-ME-Received: <xmr:mkxtaA536nAB6zvUGrEdRPQtXMEXrbykXeHb3Ns0klAeyCsr1438FBhYFxs4BETZJrThSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:mkxtaPStczP27yg2mG6hOR1ehSagb_GOGE6Dj12m6enbSIhu-5JhwQ>
    <xmx:mkxtaI9Z7I2XtPzHb3GkErc5m6kY5CY4zDolrfbdNouzcuLzOkgFbQ>
    <xmx:mkxtaAZeZ-H4V2FwUukBsD013RNEiM-HuhHB-CgiDkYqWwOnQbtCEg>
    <xmx:mkxtaJryfBsnmUseD6UJdLVFuxcGb5A_1FFAgBkU_7T0FulsDsTCcw>
    <xmx:m0xtaJHgLD8cR8w3UI1jPIEtDDs4-0dn-z6BlMoD6DeFO6YnKW1MumUJ>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 12:51:38 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 521BE9FC54; Tue,  8 Jul 2025 09:51:37 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4ECD79FC3F;
	Tue,  8 Jul 2025 09:51:37 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
In-reply-to: <20250627202430.1791970-2-wilder@us.ibm.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com>
 <20250627202430.1791970-2-wilder@us.ibm.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Fri, 27 Jun 2025 13:23:44 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <163666.1751993497.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jul 2025 09:51:37 -0700
Message-ID: <163667.1751993497@famine>

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

	Another question occurred to me: is this method for sending the
VLAN tags going to break compatibility?  New versions of iproute2 need
to work on older kernels, so we can't simply change existing APIs in
ways that require a lockstep change of iproute versions (going either
forwards or backwards).

	The above looks like it changes the structure being conveyed
into the kernel, which I don't think we can do.  In the kernel, the old
API will need to continue to function, and therefore the new "with VLAN
tag" case will need to use a new API.

	The existing IFLA_BOND_ARP_IP_TARGET type doesn't use nested
netlink types, it just sends binary data, so I'm thinking we can't just
change that binary data, and would need a new IFLA_BOND_ type.

	-J

> 					target =3D strtok(NULL, ",");
> 				}
> 				addattr_nest_end(n, nest);
>-- =

>2.43.5
>

---
	-Jay Vosburgh, jv@jvosburgh.net

