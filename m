Return-Path: <netdev+bounces-205189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D6AFDBEE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9A45416A0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213A23CEFF;
	Tue,  8 Jul 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="kV2DUTIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDr0aQlk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FA23E334
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018247; cv=none; b=EUt+HhUV1YF5Ip8xClbU1cBpKlSaRQJ8J4UuEPuQf2apxIHkGT03JxVe0209MRDzAJXl+s1iBxOqO5RNcOVZmfnpmqV5cw51CF0uAcm+SfOsD9lssguBasV7pEKdE4x0xe/1rwRC2vZ5wd0XMFtaV7NhRQ5I0oKzrygxvTOO3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018247; c=relaxed/simple;
	bh=4fTnAHATmCqI7h54WJs0VAyGHJSfkmWPcZH8AiJsPCk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=YoU9BIQP/cuTH2AFaeZkWu9/lY6VXo4ESPyR9lauSPoT+PgZYpNn8uWxb7Py8znD/UwhzCRQk0zJuMYIMB9LqluO0R+ElQW2Fw7VWfGYSF0XYQc+a7/HA/GtFuPGYsK607TFqtGfpoC0TYLDIl5vcXoY++BnRERxmAXoeUisvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=kV2DUTIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDr0aQlk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70F1D14001D6;
	Tue,  8 Jul 2025 19:44:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 19:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1752018243; x=1752104643; bh=2urzr49k9JiTIpp/5NrBE
	cA8Tr0w8d93G9k838E6t18=; b=kV2DUTIMQFixuzxYt03IaCg0q1rk39M3/K7vP
	E60cbTXDl06si14TBucgOLstIrr7d+eh4L4hEjB0AGQWel4VoRfqQd8bUd292mx/
	roMX6n0UkbHgmm4+wf5shOYDPa7LDwyqIOHPXrhhKwaOekN+h587Tl39Shkr+g+8
	j7x7ks29uAdtf5/gUNUvDuj6tUOKgH2E17YrjNsCWu9zWWxvpuArSc99uIdYAXYC
	KvVr+23OXh9eHGVTzJeB4Vaal6PS1XzDi/tKshlj6nWvBj0sLdYxsiE0+ZdWJF5p
	C4fU+TP67zJuk3IDSA1ltX+bguiKXbSmj1uBbkv0z+WY1tjvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752018243; x=1752104643; bh=2urzr49k9JiTIpp/5NrBEcA8Tr0w8d93G9k
	838E6t18=; b=hDr0aQlkTQotskW1Ppn74TmHqQL7Bg4lq++jCwzQSnadRdGCV5Z
	gXiMovhkCdF79ZGgMFBJ+BwMXKh1Kfc/kQRS0Zi5/wotu1T5J7MNovs/rBe3M69f
	dauWaZDgvq0xgp1LmvwLV1uNRj97L37/regX1ytCIyVvjKZSsSUs7ua4AVf+Cs8q
	UPCqrdcb+l++4tyYgEa/I5Pa5BHq8/de87egK+qZ8b3mTQj/qX51flxpzaIQ92eO
	GIK+4bBeo6+HuaxEN98DfpQE9vU1R5hNG3jRWrdA9igAEYUxjEQD6al8rCCqzhUI
	aMXa4DyRIvy/ifZZz2cuvOwnH6Yg8MZJMcQ==
X-ME-Sender: <xms:Qq1taOLKoVKpQvunF6AwqYrwBb6e_xp2Bwu5n8Vfar6y5vhMbS-gLA>
    <xme:Qq1taDhGoOt1yXEC3fpVqfr18sFkARYHGqJiaPBSubw-DUMOd6Ur-iQHa8JsYX4ao
    PuhpYgjwhuq9S-0DYM>
X-ME-Received: <xmr:Qq1taGCt9nYpFQvcbx-xM63iKEeW_c-3Zx3rbpozV26rrZOtCwX-ga9QnzS0jTKuNDlnJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedtfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Qq1taN56DO8dxVQjsY1qGM_nQhmdwa0OOqyMRBqQ_pV3fawYulvAkQ>
    <xmx:Qq1taDHVzYkORadUxQO9cBcylFivDYMo5ZI8g-gTw_RVVps89xhvXg>
    <xmx:Qq1taACO1CoU4QXdLmZIR-12pgGzdgZDumjbteU6kFQCOpEvN7aR-w>
    <xmx:Qq1taAz8jH4HG1goByT4MvZFpSg8B7oTb70dujwlaS5rHsCzJNkFKQ>
    <xmx:Q61taDtzuC2unO97mzPXGjXT2P8AhO6R34XUQRfM62HJvSZeoyiejlTv>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 19:44:02 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2EA5A9FC54; Tue,  8 Jul 2025 16:44:01 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2B9499FC3F;
	Tue,  8 Jul 2025 16:44:01 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
    Pradeep Satyanarayana <pradeep@us.ibm.com>,
    "i.maximets@ovn.org" <i.maximets@ovn.org>,
    Adrian Moreno Zapata <amorenoz@redhat.com>,
    Hangbin Liu <haliu@redhat.com>,
    "stephen@networkplumber.org" <stephen@networkplumber.org>,
    "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
In-reply-to: 
 <MW3PR15MB3913AD3F5DCEB5D95C52DB85FA4EA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com>
 <20250627202430.1791970-2-wilder@us.ibm.com> <163667.1751993497@famine>
 <MW3PR15MB3913AD3F5DCEB5D95C52DB85FA4EA@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Tue, 08 Jul 2025 23:12:21 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <188179.1752018241.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jul 2025 16:44:01 -0700
Message-ID: <188180.1752018241@famine>

David Wilder <wilder@us.ibm.com> wrote:

>________________________________________
>From: Jay Vosburgh <jv@jvosburgh.net>
>Sent: Tuesday, July 8, 2025 9:51 AM
>To: David Wilder
>Cc: netdev@vger.kernel.org; pradeeps@linux.vnet.ibm.com; Pradeep Satyanar=
ayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@netw=
orkplumber.org; dsahern@gmail.com
>Subject: [EXTERNAL] Re: [PATCH iproute2-next v1 1/1] iproute: Extend bond=
ing's "arp_ip_target" parameter to add vlan tags.
>
>
>>>This change extends the "arp_ip_target" parameter format to allow for
>>>a list of vlan tags to be included for each arp target.
>>>
>>>The new format for arp_ip_target is:
>>>arp_ip_target=3Dipv4-address[vlan-tag\...],...
>>>
>>>Examples:
>>>arp_ip_target=3D10.0.0.1[10]
>>>arp_ip_target=3D10.0.0.1[100/200]
>>>
>>>Signed-off-by: David Wilder <wilder@us.ibm.com>
>>>---
>>> ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---
>>> 1 file changed, 59 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
>>>index 19af67d0..bb0b6e84 100644
>>>--- a/ip/iplink_bond.c
>>>+++ b/ip/iplink_bond.c
>>>@@ -173,6 +173,45 @@ static void explain(void)
>>>       print_explain(stderr);
>>> }
>>>
>>>+#define BOND_VLAN_PROTO_NONE htons(0xffff)
>>>+
>>>+struct bond_vlan_tag {
>>>+      __be16  vlan_proto;
>>>+      __be16  vlan_id;
>>>+};
>>>+
>>>+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_li=
st, int level, int *size)
>>>+{
>>>+      struct bond_vlan_tag *tags =3D NULL;
>>>+      char *vlan;
>>>+      int n;
>>>+
>>>+      if (!vlan_list || strlen(vlan_list) =3D=3D 0) {
>>>+              tags =3D calloc(level + 1, sizeof(*tags));
>>>+              *size =3D (level + 1) * (sizeof(*tags));
>>>+              if (tags)
>>>+                      tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;
>>>+              return tags;
>>>+      }
>>>+
>>>+      for (vlan =3D strsep(&vlan_list, "/"); (vlan !=3D 0); level++) {
>>>+              tags =3D bond_vlan_tags_parse(vlan_list, level + 1, size=
);
>>>+              if (!tags)
>>>+                      continue;
>>>+
>>>+              tags[level].vlan_proto =3D htons(ETH_P_8021Q);
>>>+              n =3D sscanf(vlan, "%hu", &(tags[level].vlan_id));
>>>+
>>>+              if (n !=3D 1 || tags[level].vlan_id < 1 ||
>>>+                  tags[level].vlan_id > 4094)
>>>+                      return NULL;
>>>+
>>>+              return tags;
>>>+      }
>>>+
>>>+      return NULL;
>>>+}
>>>+
>>> static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>>>                         struct nlmsghdr *n)
>>> {
>>>@@ -239,12 +278,29 @@ static int bond_parse_opt(struct link_util *lu, i=
nt argc, char **argv,
>>>                               NEXT_ARG();
>>>                               char *targets =3D strdupa(*argv);
>>>                               char *target =3D strtok(targets, ",");
>>>-                              int i;
>>>+                              struct bond_vlan_tag *tags;
>>>+                              int size, i;
>>>
>>>                               for (i =3D 0; target && i < BOND_MAX_ARP=
_TARGETS; i++) {
>>>-                                      __u32 addr =3D get_addr32(target=
);
>>>+                                      struct Data {
>>>+                                              __u32 addr;
>>>+                                              struct bond_vlan_tag vla=
ns[];
>>>+                                      } data;
>>>+                                      char *vlan_list, *dup;
>>>+
>>>+                                      dup =3D strdupa(target);
>>>+                                      data.addr =3D get_addr32(strsep(=
&dup, "["));
>>>+                                      vlan_list =3D strsep(&dup, "]");
>>>+
>>>+                                      if (vlan_list) {
>>>+                                              tags =3D bond_vlan_tags_=
parse(vlan_list, 0, &size);
>>>+                                              memcpy(&data.vlans, tags=
, size);
>>>+                                              addattr_l(n, 1024, i, &d=
ata,
>>>+                                                        sizeof(data.ad=
dr)+size);
>>>+                                      } else {
>>>+                                              addattr32(n, 1024, i, da=
ta.addr);
>>>+                                      }
>>>
>>>-                                      addattr32(n, 1024, i, addr);
>
>Answering your last question first,  IFLA_BOND_ARP_IP_TARGET was
>already NLA_NESTED (see: bond_netlink.c).
>
>>
>>        Another question occurred to me: is this method for sending the
>>VLAN tags going to break compatibility?  New versions of iproute2 need
>>to work on older kernels, so we can't simply change existing APIs in
>>ways that require a lockstep change of iproute versions (going either
>>forwards or backwards).
>
>I manage to preserve compatibility forward and backward.  Both a new
>kernel and old kernel will work with both an new and old iproute2.
>
>>        The above looks like it changes the structure being conveyed
>>into the kernel, which I don't think we can do.  In the kernel, the old
>>API will need to continue to function, and therefore the new "with VLAN
>>tag" case will need to use a new API.
>
>I thought adding a new API was what we wanted to avoid. But a new API
>is unnecessary as I am extending the existing one in such a way to not
>break the original api.
>
>The original code sent 4 bytes of data (the 32bit ip address) in each nes=
ted
>entry.  The new code sends the same 4 bytes containing the ip address.
>If a list of tags has been included the data is appended to the 4byte add=
ress.
>Type NLA_NESTED has no fixed data size.  If no vlans are supplied then th=
e
>data sent to the kernel looks exactly the same as with the old iproute2.
>Therefor a new kernel will continue to work with the old iproute2 command=
,
>you just cant add vlan tags until you upgrade iproute2.
>
>An old kernel will continue to work with a new iproute2. The kernel will =
be
>sent the same 4Byte address in each nested entry.  If you try to add a li=
st
>of vlan tags the kernel ignores the extra data.
>
>I tested the various combinations.

	Excellent, I stand corrected.  Could you include the above in
the commit message somewhere?  Doesn't necessarily need that amount of
detail, just a mention that the new logic is compatible in the proper
ways.

	-J
	=

>>
>>        The existing IFLA_BOND_ARP_IP_TARGET type doesn't use nested
>>netlink types, it just sends binary data, so I'm thinking we can't just
>>change that binary data, and would need a new IFLA_BOND_ type.
>>
>>        -J
>>
>>>                                       target =3D strtok(NULL, ",");
>>>                               }
>>>                               addattr_nest_end(n, nest);
>>>--
>>>2.43.5
>>>
>>
>>---
>>        -Jay Vosburgh, jv@jvosburgh.net
>
>David Wilder  wilder@us.ibm.com

---
	-Jay Vosburgh, jv@jvosburgh.net

