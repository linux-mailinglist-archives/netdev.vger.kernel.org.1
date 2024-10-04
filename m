Return-Path: <netdev+bounces-131874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28898FCAD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3A5284178
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8874D59F;
	Fri,  4 Oct 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="qhUT4hT9";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cce474iX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CABU1mJh"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CC7711F;
	Fri,  4 Oct 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015148; cv=none; b=VuR/jUXnyNRHsc9kzuEwvmBjubSDKjK0+qBU7PyPygLj6Itk7WKkbsb5bG/qk3bzvHbhHpsauzeUfeZD22XBS33moFKLP60fZl4e8ZSttPpR5Hm8hXkyYFB0O56kySEdOio9UXiI3Vds5QnrEb24DnL6nXiwZRH7BIfGZeviIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015148; c=relaxed/simple;
	bh=dpmI0Hl7UUgNdEPFbeJni0IibizIDPd2GnahdWQSAjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePT7tepTWvvtNETA/akemPYfJfbesPOTosnte8FMgiIWVS0Pww5/bJL81n6p+wVX3ZPsd5mCdiP/ZfcJloHGQiyipOmCeMg7e8R4uNNdUwjHYHYDPWu7ALiQxAHYR/jYGsPz38GLukoEdcqVEyxgvgLRSOWfVc5jCkrGzESqiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=qhUT4hT9; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cce474iX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CABU1mJh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ABB413801CC;
	Fri,  4 Oct 2024 00:12:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 04 Oct 2024 00:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=2016-12.pbsmtp; t=1728015145; x=1728101545; bh=Zt4u6nvRmr
	fpmFFoauivpQsKnENIj0tVMTWtbcgE2jc=; b=qhUT4hT9AQZrvAsmQYW2BAOu/q
	Y+Xcjb/kKrBrzqb+/2nku4t6GU9cckK50k6t4Rc80sie3qrco3z5fJmxJYe7M5TW
	wfFYCx7lhXOIiHD9kt7MS/G0pE80gpLsp5ntX/0HXvzwJrYoEm5e3GINffRhBVMu
	tjCUMAzuX5B4TfPLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1728015145; x=1728101545; bh=Zt4u6nvRmrfpmFFoauivp
	QsKnENIj0tVMTWtbcgE2jc=; b=cce474iXWlhMz9Y3FxrW4Nh6zg+BxPm4SJ1r8
	x7bSQel30kZwpzHLti+MRyYZZHKQ0BShZhKpo6UNvA6WPOBcFrmLXLROTgvBoeQX
	0uAc59+BL3m8amxLdNtpC1iY06ys2Gz8c7xxme8S31OOiotdtEsZPbsnHEPoZX6c
	BDCFB5wWzMM/sgiRAB3Nqsdc5dGkTnwqQagmGRzUUN5dsO02YowgC73gJWhD4t/Q
	6KaN5M/7BuZUGyMqF74u4dgS+YQ6RC0NawI4OnMIRTFv6Kzu/KCpIaImIL+KIzOf
	l0RViCjeML77cTSEOmQm8uydvA501I5GCwXlHi7DZ4rore+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728015145; x=1728101545; bh=Zt4u6nvRmrfpmFFoauivpQsKnENI
	j0tVMTWtbcgE2jc=; b=CABU1mJhxDbWmAi4RRSnF9l6dV2WkGFW3PMbzz3ofh+l
	A12X3M96dNmJDqKh7mQwjxa+wo3ySuLdwEebo+VzkToCIMwIewiyweXbSzMwpVQq
	x1AJi4tsCKI8VKsyMMHmNy6N7JqH6M1HMdT1SQpPsAH4xjRo//OSyIpL8Ux/TIOy
	vrMfCTGt/CRQLOLe/YQJIL52xGtvtcGZull4QdSinwiekO4uZYsi0wVizGW3GIXI
	O1r/ilyjCyeHPrXf9xODSHlPWnCkNPrNK7lyqOhfE2+Lkreb4mZdgSS38ewTE1DQ
	pd4YcpwkRPC7ysS83fXrph2BnUU9PaLfuyJ1Y/iTdw==
X-ME-Sender: <xms:KGv_ZrzRhr40HMJ88iAiObu4iMK_sjD1LDvetMZitMh5Vbh9yuUlSg>
    <xme:KGv_ZjRRHOnp7ul2Zu0hIJ3Rph8-na2d_wWcQTUqd6Clco7PJd6LwxRtiFMxbkmOC
    6a4TOzqLR6xg39wg5A>
X-ME-Received: <xmr:KGv_ZlWjU52YC8C0qWtW5Brw9f8xCfJoYwG4ghW3W1jhUAnqoaR7rNUkf4jRm2ReaDGcdqcfbnz6SPS5HrEKixv9mayojW9gi1r5uHcJ-NbFi-luWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvth
    eqnecuggftrfgrthhtvghrnhepudfhvdelgfeguefgjeeigfdtkeejheekveevgeeitdel
    vdeihfevfeetffeigeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhig
    nhhitgdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehrohhgvghrqheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhh
    khhosehtihdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KWv_ZlhVmq4DMi5t6j6-MdZqlTApRJNdiGciyq4eW3TFG7JQ3l_PcA>
    <xmx:KWv_ZtAqxzntfJwAY1Zv0tBBVhGOWYbbWwpqnB8xCS6rFyIsGm6zTA>
    <xmx:KWv_ZuK26uJRNDoXBOjpH_aUgTy-q_-VspGZGdiZ7x34d5_1fvPDeQ>
    <xmx:KWv_ZsB7NIUtUZoQAEwvqsbq6gMpFkmLf2R-Gtq4UFUaqxerDfdYKw>
    <xmx:KWv_ZiJGBFBX-cJMMj64h8-MjZ0TNcNsKGzrd6bmo7z-HoHSFakrc02A>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:12:24 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0FC6EE3D83B;
	Fri,  4 Oct 2024 00:12:24 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] fix ti-am65-cpsw-nuss module removal
Date: Fri,  4 Oct 2024 00:10:32 -0400
Message-ID: <20241004041218.2809774-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues preventing rmmod of ti-am65-cpsw-nuss from working properly.

v3:

  - more patch submission minutiae

v2: https://lore.kernel.org/netdev/20241003172105.2712027-2-nico@fluxnic.net/T/

  - conform to netdev patch submission customs
  - address patch review trivias

v1: https://lore.kernel.org/netdev/20240927025301.1312590-2-nico@fluxnic.net/T/

