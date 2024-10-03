Return-Path: <netdev+bounces-131708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D5298F4FB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073E51C21756
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1A1A76AC;
	Thu,  3 Oct 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="EujAyb4I";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xs8qFFej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSATuhCx"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C91A707B;
	Thu,  3 Oct 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976072; cv=none; b=EfOL8Il2mC5DlddKFAPrrd8prJdc6IUuu3mEc0pFftz7s158WyBkdYP7KS/Mjl8EeVwx70QyF3ZHQuDeeJlP6QmFzrXqHYKgJI7Xm3VZTgDdDoRM7ece4lSwQ2FvVuslAWNSPf/hZaacGAVhLRg/4J5qblH0IG1+TlD53OtsSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976072; c=relaxed/simple;
	bh=odplaax5nFtzkWYauYzHvoHDaAQI4Qhqdvc+ggoJRD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKVkSsRhnHV8pEwx03ftgRqNQI6YU02u+Ot2mOcN+frKE3ug5b1nahcPoktnNTd6xw8jD1VL/iajAogMpypivPKt4vapFhHkjB+1OmRQQsNXTdcjbZwEUjm0W7F3ExYrRIYLgcKT4A/mFM+QTcaKG9Iurk9F7DxC9wH/CBZX668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=EujAyb4I; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xs8qFFej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSATuhCx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 961F7114020F;
	Thu,  3 Oct 2024 13:21:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 13:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=2016-12.pbsmtp; t=1727976069; x=1728062469; bh=R33Y15aB7l
	c+DctiSTThDrHLE2YXh9+A2YLQSAwYl3A=; b=EujAyb4Io7NRFq3hgB8yeWN5Rv
	lnQhW78cYaK6sr8zCZUeG6J2H5x7Svqhm3glcLVSEF1gzE4e4W6+izhD64ndT17x
	zkuAcwD5e6DjR3AHN1q2EVVgEnb/HB2p8Mp5sW20KSZVAerqsEXyAg9VrvoD6jGm
	PqYMc4g8IyK3P8NIE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1727976069; x=1728062469; bh=R33Y15aB7lc+DctiSTThD
	rHLE2YXh9+A2YLQSAwYl3A=; b=Xs8qFFejyjWQH44lVNc6Mb6u23G0i8z6CviMw
	RmPh4HVYq42OZAPs5L3+L0SRfSzJpY6wC3Z7locxnYBLuAeHfzRnzU8F2K3tpXCq
	2kAdT0SJBNKil/LY8FviwIUbRnchdhUefQ0+LPcOT/cijt+7LTi3woHyRJ8rdO3C
	UGLkGC6trjEukLi8emy9bRR8jGYQ65ogU/g1yEwupsGVDTaGg+pI4QyNMRenRdf+
	Jt3FnqFfzfZt+RQTjKcTKp0qimHlBxjW96j9b6gt7HNDQca2T7nyEN4jdJInN621
	xiP2Q2qe8LMqyPxsL1YBAkIURuUolEiXP4V/iVDGbnJ+wptDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727976069; x=1728062469; bh=R33Y15aB7lc+DctiSTThDrHLE2YX
	h9+A2YLQSAwYl3A=; b=bSATuhCxvK1i6OgNRdckAqusjO+xQvmouigGqmzBAhfH
	w4uQEwwJ3GSZQNszrxzSSAvUzlkdLhWuD9urMHS2H/YUtcCuu8ywqY/ml8gnh9Q2
	i+7+WdbOROq6ZR9LlO/W0iCX1+gEHDdNnp4gDJQ3yJGDpI8cOlEbXED8kjiQe5Ip
	U0W67U2xgFDQTRJpyRWSsEUa3JEtfYVDZTBXzUB9xkWK7eSFQtPS+dG6PiR0d/sx
	kcfU5U3yxMnk1XexyNk+3uZN634JGHff8CcAqMgc6OJtp02/6a6pY2t3fjYNq9QN
	UzOIZBRimInEnlmijSGZclMovPuJuLZk38fNIHMvVA==
X-ME-Sender: <xms:hdL-ZpVtF47QmEM2HV-CUrFMy4eSkprXwNv8JI09Coq3FXi3KIT_fA>
    <xme:hdL-Zpmivw-aHqExKaOPX-Vxuv33pFbPKV7j5MNrI1E68d3b8T3LuifS9TuNsMZ9U
    xgxZuhJbc9bnsIMaMY>
X-ME-Received: <xmr:hdL-ZlYJGmuhsA0bvOJbtXSmwGqLAIJbce9_6QWNQNQInQ6cek8pPXZwxrQebPip05Cf020NHCZtKsLXXXnWuwQ7lvIG9VPAyH_Sqp2F9Ra8yjpDBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeduhfdvlefggeeugfejiefgtdekjeehkeevveegiedt
    ledviefhveefteffieegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:hdL-ZsWppHJKDi3DzG1gDhQG9puegZBI3ke4bAdy2t99g3aAvV0mHQ>
    <xmx:hdL-ZjkLg1TIDs6SNnT5X07_wkq8c2H49HV79BbcIFN1D5QMVaixAg>
    <xmx:hdL-ZpeZU_8a9r3T1CiO-2Ofnl-1fS9rFdV34lfAWv7YQQn-ubSFsg>
    <xmx:hdL-ZtGgZ87xKJsSazbjWhBNTBYoRucrzBnmuBeuUBG0jOCeG0n5Yg>
    <xmx:hdL-ZhZiv3XDjWvowVqjLunL3TUbms0LLVNi97S9H7fxKRvYdkbJtWJK>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:21:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 38172E3B223;
	Thu,  3 Oct 2024 13:21:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] fix ti-am65-cpsw-nuss module removal
Date: Thu,  3 Oct 2024 13:07:11 -0400
Message-ID: <20241003172105.2712027-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues preventing rmmod of ti-am65-cpsw-nuss from working properly.

v2:

  - conform to netdev patch submission customs
  - address patch review trivias

v1: https://lore.kernel.org/netdev/20240927025301.1312590-2-nico@fluxnic.net/T/

