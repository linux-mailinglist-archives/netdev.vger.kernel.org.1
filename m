Return-Path: <netdev+bounces-204605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAEEAFB6ED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510C8179E15
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DD29B79A;
	Mon,  7 Jul 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="bhBoWRnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFpkMHn1"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385EEEDE;
	Mon,  7 Jul 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901108; cv=none; b=E9T6jgccAioAbSjtwJ/s7NoHWQXV9GOZQvnt2aq3XZV6YueMGibYwfgR4Hftq9FM3PwxySpHuTMWMksgNiW1TXpyIuYrg7nP63/QIMF4NXD/6CFSUSNOUIqhk81hrriFQ5Eht7QSIfEZUi0VdR0XM+Uzvbbb4RvvHkUCfH/7LEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901108; c=relaxed/simple;
	bh=/ARAXRQbSZWdg9pZaoBuhq9UVIh0+v78Jr3NrAo6aJw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=AW8vYXDI0m4P+AMQDpCkFK9BdLI7RrZ11NZO8aBgKLEIgz0I+nM/cTCBZEVZlQAMzengIgtiKjn/EeoOxnakwCHGnoon0OukkRUbLxxfjzHU25s4aOIt1x5em6SKS5OmDBRn6KYyE0xfWCJp831WNurx0N+NJ6kcDr678hsRrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=bhBoWRnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFpkMHn1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EEC31D000A2;
	Mon,  7 Jul 2025 11:11:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 07 Jul 2025 11:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1751901104; x=1751987504; bh=wUtS/ivm21AFbgEek477k
	pVSpKUMueuzQzPLVXyifMo=; b=bhBoWRnk7JEdIFVy4d4mVfs4c1gytJOQiSepm
	0m7ndkhHHE+s655P4jCmRNe5ZiVTaaoB4xl5qgdD8v0ObvYYeEjwwnTLn/rzqRdn
	FjUBdw8m8S9ZEaLmy6C4gs6GjQWJZ4ckD4SplQC6ZSg5N9FljcqzR+WeZwVtQPsY
	6OjqFC+ZdvPls2CjvTdbiJlu6dp2SjeJJkgL05G2eQQh6xmxhADR0J3KXjmEL3ym
	73xpbEPmwXhIF70YE0YOVozak/oXZX+ahXjaHnFcV8ald4SZCwjoFncsomX2fi8p
	Xwa4sCsHYyvG0yguF+atfSxc+221RUuDMk2SSpI8YRqYYlrjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751901104; x=1751987504; bh=wUtS/ivm21AFbgEek477kpVSpKUMueuzQzP
	LVXyifMo=; b=ZFpkMHn1kI1sIr57WFM2mLpsm27Bz6kckGaxOWWAYnsux2BUPkb
	LQb8byIbysZNGuR8cliiZjQVIxN9DFGlBrAI95ST+6s5gLvmAULTl51EI29Pcdj3
	QFvuiMoKLFNsbb4DlCTrvZ+1JDGE9gKtcsuROAV5UGLPzvH7m7NQMZlQt9teXRHN
	ecm4arppy8kpnasgVYak+Ry2SAYHFy4G+EdqCFtJ4wbNh7+WghBM8gcirwA6qEjQ
	ZlUqDejmKED2T0PbeiJZh6nTA/u2HuiTcO6J9xJRUWaWBI6ViQKL4vY2FSN4UlYc
	5SGOsTJDdKXrnFOl+CqErLfyC/mZ7tL/v3Q==
X-ME-Sender: <xms:r-NraJS7v827MQ0DLXK2aHLZLvHwt_vpihpeTj5EG3ij5IMzLJlqNQ>
    <xme:r-NraNYFGqNACEEJ_FrjIhqh_9_C5Zqf8KGkjsnuEHtP7QxAubJwTLJWrJIFAyRxY
    Ptmopz4vv7sP71qpyk>
X-ME-Received: <xmr:r-NraE12PNqF6Oy8P_jW23bOH_i7MXdcnpkFY_q8CV96Ccs_yCJspI-wBV0-eU1Qkg61TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehgnhgslhgrohesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihifrghntghhuhgrnhesgihirg
    homhhirdgtohhm
X-ME-Proxy: <xmx:r-NraAqJCtyFsA4h0XiAlcliWpGB0mqMGB2l2xi4-lWiio8ZrrizUA>
    <xmx:r-NraDM8n6BHjfQa1kSNG0BQ1B6oQQOA14x2zpfVHSrTvFWl6anNkQ>
    <xmx:r-NraJqsjKCQU0xjTl5OOG4YENlCFFBcUJOLGvlAG9yg1MalJZSN_A>
    <xmx:r-NraOvaZJm3Hp8lJfCU_rci9Q2-pos--atfqwkWLn_8ARQBMR1P3Q>
    <xmx:sONraNcLfJgwcKQOVNZa3OYlqji1v0FYWihUyApeQ3Qfj3Lrk_6RkJ5->
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 11:11:43 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 448C59FC7D; Mon,  7 Jul 2025 08:11:42 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 431439FC45;
	Mon,  7 Jul 2025 08:11:42 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Wanchuan Li <gnblao@gmail.com>
cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Wanchuan Li <liwanchuan@xiaomi.com>
Subject: Re: [PATCH 1/2] bonding: exposure option coupled_control via sysfs
In-reply-to: <20250707091549.3995140-1-liwanchuan@xiaomi.com>
References: <20250707091549.3995140-1-liwanchuan@xiaomi.com>
Comments: In-reply-to Wanchuan Li <gnblao@gmail.com>
   message dated "Mon, 07 Jul 2025 17:15:48 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73001.1751901102.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jul 2025 08:11:42 -0700
Message-ID: <73002.1751901102@famine>

Wanchuan Li <gnblao@gmail.com> wrote:

>Allow get/set of bonding parameter coupled_control
>via sysfs.
>
>Signed-off-by: Wanchuan Li <liwanchuan@xiaomi.com>

	No to both of these patches.

	For patch 1, the bonding sysfs API is deprecated, and should not
be extended to add new functionality.  All bonding functionality is
available via netlink and iproute2 (/sbin/ip).

	For patch 2, new module parameters are disallowed in general.

	-J

>---
> drivers/net/bonding/bond_sysfs.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 1e13bb170515..5a8450b2269d 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -479,6 +479,18 @@ static ssize_t bonding_show_carrier(struct device *d=
,
> static DEVICE_ATTR(use_carrier, 0644,
> 		   bonding_show_carrier, bonding_sysfs_store_option);
> =

>+/* Show the coupled_control flag. */
>+static ssize_t bonding_show_coupled_control(struct device *d,
>+				    struct device_attribute *attr,
>+				    char *buf)
>+{
>+	struct bonding *bond =3D to_bond(d);
>+
>+	return sysfs_emit(buf, "%d\n", bond->params.coupled_control);
>+}
>+static DEVICE_ATTR(coupled_control, 0644,
>+		   bonding_show_coupled_control, bonding_sysfs_store_option);
>+
> =

> /* Show currently active_slave. */
> static ssize_t bonding_show_active_slave(struct device *d,
>@@ -791,6 +803,7 @@ static struct attribute *per_bond_attrs[] =3D {
> 	&dev_attr_ad_actor_system.attr,
> 	&dev_attr_ad_user_port_key.attr,
> 	&dev_attr_arp_missed_max.attr,
>+	&dev_attr_coupled_control.attr,
> 	NULL,
> };
> =

>-- =

>2.49.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

