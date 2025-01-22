Return-Path: <netdev+bounces-160156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84CA188F8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0177A3E82
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265F4C74;
	Wed, 22 Jan 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LMmdoRC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zhox1c1L"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080193C1F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505956; cv=none; b=dVoYMMwrHeVQbvnqJW4Wp/tCg/JIH5/hR7As0K+PNm1nayfn4FhpjIMFoDyT9vnNi8WbFp4kTIi6ypq73ttF6aX5CC/NmOLtdSKSxfH3O7RWAc+t6ZL0PrwkqGIqRN7qeSV7WuYyickXY98kCOHcVpF/ZSUh6FSDjnHaBo5Nqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505956; c=relaxed/simple;
	bh=n9G2tz20pLDkjn2TwnbqISQsyTZlZ4fI5dQ8XtLnP2E=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=BqYB1eUU5/1Vn2AFw+kpOsWsyzB1VAK56Ijki9fv8Ir3sZx/DBpUY469luETi8RdbnP/LeA/egfgBz0uwuB1dqjyjA5ETA6COpldxh8f5+HWKVq+A9J7vNPVuBUkteK38CZ9MoDpIX4ASFobwvq1tXoaWBGWb+24pQrOgZFK86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LMmdoRC9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zhox1c1L; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E10B211400FC;
	Tue, 21 Jan 2025 19:32:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 21 Jan 2025 19:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1737505951; x=1737592351; bh=Raayv0SsSPdwDcYBksOiu
	bkWqxdhcNfnadoghLhPjG4=; b=LMmdoRC9GFD5X8szyQZ2uhGD2wOyYgfJyImjz
	8q1T6Rm/Vsrxn0KqmoaZhXPQSNgcqtP/uGP2fE6KmhyL5reDqjQTz0RPBbPGtJPO
	BKR2e0dCG6hF9IcbB9bg+/gpOfv1uNSbO3zepP8aDBNPwtzQZLHlNYdZ+KKcg1AF
	k09QPuaDw3NjRe3+BaNfujSkuizE6TX/OfxmSKUqnS4iGU4/T79JGHSUC7loCwfv
	K8EgmGBAgJ942TFy/RWdaY+0hAJBWtWqz/ZPod65wIxwfhwXnqOVFU95KlTeKklN
	v1yTqaMAfwJmeGyUUtWNjQ3SxTvuYYCUJZVUJxkEBf2bAIXug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737505951; x=1737592351; bh=Raayv0SsSPdwDcYBksOiubkWqxdhcNfnado
	ghLhPjG4=; b=Zhox1c1L0ogcc7tH3gvqtlVM5aac+YxP8ECyXFWbIN0S0KX+qA1
	46t77HmCH7t/Z+LI2XZRPNFbAnCLrf0Ome41O9x+09ZpnFfYFTkOIdR5cByWMZ51
	axRXYZnNmQD3nPm6ZXCpGJxn/n69dfNbq0adhu4iydN7OUes5Kxv/cVTba5VilxW
	pxr7YbDi0uTzgooHQeJ/LixVZasaGZ4maZaZFsd+WFjPIuqt0JWcN4ru9y/PlkJv
	qllOCgeNvIng6fgMbJj31Sr5z5bSLwgOOxY22ZMvPPLiVOn+kFVXNx6583d3Tka7
	1ZlUS8X+ypPTKmTy8/fbs0oJxFhux3UNYbw==
X-ME-Sender: <xms:nzyQZ5BQDFFKJxCAGrkCpd_sSTqRjHGW0dQFNJnLpcQCRDvi75zggg>
    <xme:nzyQZ3jJVf-dhTxTATJVBaW730gBPBbV2ilXv55EtKKvPE3O91HhH_mhtsIMsHj4V
    WhF6eBTmzM2b3CElQw>
X-ME-Received: <xmr:nzyQZ0nwiIxWaQM-rCRDljd35aI3URIU0vDmAl7ZnM4N_5NipeeYUDM33RSyWq59c5m0FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddv
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveel
    ffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihgrlhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nzyQZzxRX_SRW6AJV9xm_7avfVW-9rB7N6zS6r8VPP1HAR7qrNSb0A>
    <xmx:nzyQZ-RCJdeDXTO6CwVf-LSEXwbXMYHos53UcV0w5b5aqo1imZ1jTA>
    <xmx:nzyQZ2bvDPgJHuCpKG4IoCNk59Cn50z8WQEOCJY03dRh1cR5MiIm3Q>
    <xmx:nzyQZ_QjPdW8nDVztYZ1Hvt4OrmqHbJ5KGhTSk_eKctPIMqMhMA01g>
    <xmx:nzyQZ8ebwdsQTUos5JsLot-hIoTWYb5yfD5UpFT0VNW2M03ItaNouSUW>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 19:32:31 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 400E39FCB3; Tue, 21 Jan 2025 16:32:30 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 3F3709FC8D;
	Tue, 21 Jan 2025 16:32:30 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [Question] Bonding: change bond dev_addr when fail_over_mac=2
In-reply-to: <Z49yXz1dx2ZzqhC1@fedora>
References: <Z49yXz1dx2ZzqhC1@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 21 Jan 2025 10:09:35 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3990672.1737505950.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jan 2025 16:32:30 -0800
Message-ID: <3990673.1737505950@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>
>Our QE reported that, when setup bonding with fail_over_mac=3D2. Then rel=
ease
>the first enslaved device. The bond and other slave's mac address with
>conflicts with the release device. e.g.
>
># modprobe bonding mode=3D1 miimon=3D100 max_bonds=3D1 fail_over_mac=3D2
># ip link set bond0 up
># ifenslave bond0 eth0 eth1
># ifenslave -d bond0 eth0
>
>Then we can see the bond0 and eth1 both still using eth0's address.
>
>I saw in __bond_release_one() we have =

>
>        if (!all && (!bond->params.fail_over_mac ||
>                     BOND_MODE(bond) !=3D BOND_MODE_ACTIVEBACKUP)) {
>                if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->pe=
rm_hwaddr) &&
>                    bond_has_slaves(bond))
>                        slave_warn(bond_dev, slave_dev, "the permanent HW=
addr of slave - %pM - is still in use by bond - set the HWaddr of slave to=
 a different address to avoid conflicts\n",
>                                   slave->perm_hwaddr);
>        }

	If I'm reading it right, I don't think the above will trigger
the message for your example, as "!bond->params.fail_over_mac" and
"BOND_MODE(bond) !=3D BOND_MODE_ACTIVEBACKUP" are both false.

>So why not just change the bond_dev->dev_addr to another slave's perm_hwa=
ddr
>instead of keep using the released one?

	That would cause the MAC of the bond itself to change without
user intervention, and the active-backup mode won't change the bond's
MAC except for the case of fail_over_mac=3D1.  It's not uncommon for the
network to have dependencies on the MAC address itself, e.g., MAC based
permission rules.  There's also an cost associated with changing the
MAC, requiring a gratuitous ARP and some propagation time.

	What you describe is also the behavior for active-backup with
fail_over_mac=3D0, in that the bond will keep using the MAC gleaned from
the first interface even if that interface is removed from the bond, so
it's not really something specific to fail_over_mac=3D2.

	I don't think bonding should automatically adopt a new MAC
address in this case, but loosening the logic on the warning message
would be ok.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

