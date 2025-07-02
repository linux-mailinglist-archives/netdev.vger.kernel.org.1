Return-Path: <netdev+bounces-203490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF0AF615B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4503BB842
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0AA1FFC46;
	Wed,  2 Jul 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="G972zOVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEwPwEDb"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF51F2BAE
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481146; cv=none; b=oqTWxcyqPY591zGd4KRK4zHS1knQbGlmM3FL8QG4RtOGrWpI2u11dFrxNHhK3Tg75+1zAWLPTO72Wz6P15cNnM9LIxd390D/x0yidZ7YG9kYow0fSBnJhtCkEOdYSh9MmVRColktrhXeFDma/kD+q9Mg4T97d9phnrKvbK0iKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481146; c=relaxed/simple;
	bh=YqQD4c9Z0xbqiSRe8VWw+Zi1IFsNNGekirZqSKRFp+c=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=NY1sTYGVfMRiBCazYoZ/sk0zneO1WBY/FDeKEDF0SwuJhdLM+n/A/VcwXtlcsQWZP7HTRuua8wKlk6bos7Nax0YoxJgt9ZEG936lfiLePveAgmtaDs2Hb5Llwww8oi/t5JJYMklkGTnBJwHPfmfC8jq0In7hjgKqYg4XP4qPhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=G972zOVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bEwPwEDb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01F2D1400112;
	Wed,  2 Jul 2025 14:32:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Jul 2025 14:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1751481140; x=1751567540; bh=b+GZx9e0zKTM/jQLPNUu7
	p147XLbSxY/wvkvpm2oXmI=; b=G972zOVK04o/q+I/eEp4X7wuf+ZBCXxL4931D
	euJufEjsqbfd1d36CfsnmnGkj4mvVcVzesMI37fhz44A3ygxqrUit+AF/nucTqh5
	Ovwke9ROribWWAja7pQ+ueh4covnx0BgDSdrikmbI/IkHVX3V82tL9U2IzSaAZSy
	b1w+x+NGLmn8fI25Pc0dOL2EfIabK1okec6fLvypEDIO/1uF8X/gV7kCg247pCAB
	ddfQsV8lqBrUs/v674MTObcI9DOdcv1NZO6ntXlmfs7+87aX6nqpGCfafLmd3fYo
	EerL4LdOAg4ToJPq9ByQ+jYSA8DluxTyGz5eRjN8+fVA//EbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751481140; x=1751567540; bh=b+GZx9e0zKTM/jQLPNUu7p147XLbSxY/wvk
	vpm2oXmI=; b=bEwPwEDbBvPKdsk6zftekBgaha66rFsnsZRsnvmp2OzJSzeS1Q8
	+gblaDnF9hWHA82i7/biYJX6KaeJsUTPALCblNR2hnPbZVEOrbmY5J+lmC/H27F9
	ie5OJG/488faBQKTY5SWlB+nvnZCRPSn9RY/L+FyhYjVP4eY4TSf0Om4VnRKM2fx
	lTLhRRBYA0npcM8tSAMU/UXoogz+9MczbntiiTEdkbAyJQaK5fffQgbXq2/Taeqw
	8vp5Mk71tlY5rQcYbeWrDYL+N1P45Xpy9UNjht66Tmyh6lUkLtutSh0KyGoQgd+w
	Kyd4VhpU7MkjQNnXfMYdJg1a1J+ZnwAODGQ==
X-ME-Sender: <xms:M3tlaDGuig77t6koL8N03n2DdLluV9opZby9HnTMXmNaXaquuUcQQw>
    <xme:M3tlaAVNriRdycSy4I4uAbvKsvTG4gCingm2Jdu-vdv56rce_gl-oGGC0ty9KL5H_
    6OZuxWCjr_VS_9KeXc>
X-ME-Received: <xmr:M3tlaFKhZYXu5mVCa-mHx9eGDoUyq0wpTuFP-xkJzgLpVpMd62N3oVf9f2YJGej2xWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepphhrrgguvggvphhssehlihhnuhigrdhvnhgvthdrihgsmhdrtg
    homhdprhgtphhtthhopehirdhmrgigihhmvghtshesohhvnhdrohhrghdprhgtphhtthho
    pegrmhhorhgvnhhoiiesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhgrlhhiuhesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepphhrrgguvggvphesuhhsrdhisghmrdgtohhm
    pdhrtghpthhtohepfihilhguvghrsehushdrihgsmhdrtghomhdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M3tlaBHIsDOmpjbat4ldMP-Kf0rk3JQCKx0R7pi7_hjXB6QBupyPPA>
    <xmx:M3tlaJU59D9ufnqHzFoL90OXL62Ux4ieLvP3wo23fXeigWleYz33Vg>
    <xmx:M3tlaMP--nJlC5tlobyBGdoT0rJAGKPRNcu3D8F9ZxkUoam2_inWqQ>
    <xmx:M3tlaI08I94loJki3HIH7vsVNC6THLcuH5YT2HS4oLuMDpTmwD04Iw>
    <xmx:NHtlaIfkeCJNisI7uYIR2it5d3BZJ5pbp9JS3g11-3LarDYdXGHl8lco>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 14:32:19 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 62E691C037C; Wed,  2 Jul 2025 20:32:16 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 61B5A1C0081;
	Wed,  2 Jul 2025 11:32:16 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com
Subject: Re: [PATCH net-next v4 6/7] bonding: Update to bond's sysfs and procfs for extended arp_ip_target format.
In-reply-to: <20250627201914.1791186-7-wilder@us.ibm.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com> <20250627201914.1791186-7-wilder@us.ibm.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Fri, 27 Jun 2025 13:17:19 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2140655.1751481136.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jul 2025 11:32:16 -0700
Message-ID: <2140656.1751481136@vermin>

David Wilder <wilder@us.ibm.com> wrote:

>/sys/class/net/<bond>/bonding/arp_ip_target and
>/proc/net/bonding/<bond> will display vlan tags if
>they have been configured by the user

	I don't think we need to do any of this, the sysfs and proc APIs
to bonding should not be updated to support new functionality.  Netlink
and /sbin/ip must do the right thing, but the other APIs are more or
less frozen in the past.

	-J

>Signed-off-by: David Wilder <wilder@us.ibm.com>
>---
> drivers/net/bonding/bond_procfs.c | 5 ++++-
> drivers/net/bonding/bond_sysfs.c  | 9 ++++++---
> 2 files changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
>index 94e6fd7041ee..b07944396912 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -111,6 +111,7 @@ static void bond_info_show_master(struct seq_file *se=
q)
> =

> 	/* ARP information */
> 	if (bond->params.arp_interval > 0) {
>+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> 		int printed =3D 0;
> =

> 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
>@@ -125,7 +126,9 @@ static void bond_info_show_master(struct seq_file *se=
q)
> 				break;
> 			if (printed)
> 				seq_printf(seq, ",");
>-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
>+			bond_arp_target_to_string(&bond->params.arp_targets[i],
>+						  pbuf, sizeof(pbuf));
>+			seq_printf(seq, " %s", pbuf);
> 			printed =3D 1;
> 		}
> 		seq_printf(seq, "\n");
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index d7c09e0a14dd..870e0d90b77c 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -286,13 +286,16 @@ static ssize_t bonding_show_arp_targets(struct devi=
ce *d,
> 					struct device_attribute *attr,
> 					char *buf)
> {
>+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> 	struct bonding *bond =3D to_bond(d);
> 	int i, res =3D 0;
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {
>-		if (bond->params.arp_targets[i].target_ip)
>-			res +=3D sysfs_emit_at(buf, res, "%pI4 ",
>-					     &bond->params.arp_targets[i].target_ip);
>+		if (bond->params.arp_targets[i].target_ip) {
>+			bond_arp_target_to_string(&bond->params.arp_targets[i],
>+						  pbuf, sizeof(pbuf));
>+			res +=3D sysfs_emit_at(buf, res, "%s ", pbuf);
>+		}
> 	}
> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
>-- =

>2.43.5
>

---
	-Jay Vosburgh, jv@jvosburgh.net

