Return-Path: <netdev+bounces-193067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E371CAC2610
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4344B7B0BBA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5973296162;
	Fri, 23 May 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VUYO6BdF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7G17YPv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7F296157
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013093; cv=none; b=cfDaPVJpb6TX6EvFXiAamVZNXKZmHYJdnfUbs/fmlgLw6JXuePe/l6dU3ouZ2PKPKSbaLxF2Lj9co7sIJrbNtKO7t122IEJC8lHnqGqCZ0chDWremT86nVQu+0hX5LN6HWcRCGjnQHu6QKAkSe6eStmyVH56V0BKjRoHWXCfXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013093; c=relaxed/simple;
	bh=odcgkUqk/KlJbuIHgHXbqyDtD1E2awDZLRi2ZwfoW+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Je0WPNn/rx3dqiHfz3QN+O9d9Rspz3SyFzMcTUa3giqIIoGjd/sK0uR4+TM5Ai3jHApyD40/+wvg05INPCZjtOhJCvBoc6UnAyrGFgfs5yEcv1lwYIJNBgFigaLutqSmo58Ln0VXy93xQufU5pkHAi+drzbvDJAHpFQ2EarZPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VUYO6BdF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7G17YPv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9842E2540151;
	Fri, 23 May 2025 11:11:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 23 May 2025 11:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1748013088; x=1748099488; bh=bfAHQSjDdx
	oGhFUzd1qXVE32i0qXx2XLvdp91OcS5/o=; b=VUYO6BdFX7p96M3+6B5i0UZmhX
	HrIXOU86N3P9KGLz63z4i3+/5ntHPQ2Z8v+Zp9v69zOBv6a74Nkl30tYV4L2AdYJ
	NvPldsuMVgKn8m7EF/P/9rmvRZcwbkdVlMwt1wxiTI0PAkKKW2jIkjsjhODq7Q43
	VUXyplzFX+N6be/juSFGVNdrhEPMB9Fi6+hM3q+VwLN/G/0hQxjrrFpzQllshy+B
	EfQNlpHUWY9vN7MvxKl6PbUY9O25ycYwcL56Mh0AmrgOEKsnibpW22w6devNhHVE
	EHGdqmxmxjet1AFUHzZsWu3GFq8QG1NHYoKZ0IhMD9Ro1rkiCTkwvktbj5kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748013088; x=1748099488; bh=bfAHQSjDdxoGhFUzd1qXVE32i0qXx2XLvdp
	91OcS5/o=; b=v7G17YPvO4SR9mmEMmpOn41iVn2lj4a9U1+Bdq3omJ7Au9kmaZy
	PyLs7hnC+uNqnTZr1V1LZLeGv2qmp/BNUva3Bqxd5Vz/zJMlJUkHaxoDqqbOlRQd
	3vlHh9MTycfuwooXkfdYwDqeEPjAX4BCS9r7lIVwVtkrvkivrS2yByCbpXGE7DK9
	TsrxKx0R8/YZhTNUL/fHVMCH97nfCNKgkjArfHiDzEZ1VIYaSLAllZHuvvXpXWVY
	07ktO+xn1FH3WXWJLDJ6h/Xszfz3OfXaYWESjYzPiW2Q+SrVwrsr7GbLnfZ/4adu
	Nx5Pw2WYfXr5E+eEAYcMbRHn54McwOHQWyQ==
X-ME-Sender: <xms:H5AwaIEP71H0WkWJpfOC5MMMxVytSw4aVwgBTzwcvVwhom3xbAvmew>
    <xme:H5AwaBWcmRuYCvIgFotx1Qc8vgItk8RnVHoQ4_vat9p80pQgodjy9Qhcokep8Yu20
    DPj_0lhOalv6qec0Uw>
X-ME-Received: <xmr:H5AwaCKrXtORxr9pyFCAbhvLHDO0mmyvKT9GKfuXl2CuQaV_5yg_j0NDVKs2RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgg
    gfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsug
    esqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheptefhieejudei
    leehvefhjefhudduheekleelvedvkeffieevjedvgfeljefhudefnecuffhomhgrihhnpe
    hshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvg
    htpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvg
    grshihshhnrghilhdrnhgvthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghr
    thesshgvtghunhgvthdrtghomhdprhgtphhtthhopegrnhhtohhnhidrrghnthhonhihse
    hsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepthhosghirghssehsthhrohhnghhsfigr
    nhdrohhrghdprhgtphhtthhopehffiesshhtrhhlvghnrdguvg
X-ME-Proxy: <xmx:H5AwaKHVSpEWlKuz6k_Y67a_fYF6PDide0Oa--fjjrPCG7bYR0CekA>
    <xmx:H5AwaOVfe-OXbJhV_DjxveAoXrGb3BWw8r4V8vdj_AvU_wiNVCvtkw>
    <xmx:H5AwaNMusjGnMTZ6np0HJH9ZV9HPtGRIdpTnmw0uqkvuktKZv7v10g>
    <xmx:H5AwaF0TEdb-61SqhgPVwKP4NG7MKPB-UkDL-k1bBJy-LO8e3tprFg>
    <xmx:IJAwaBbbB2Qx_dGrHKg-Us0QAYf1SEILi72_Q-vuGSwlRKxeA3kcqLJn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:11:26 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec 0/2] xfrm: fixes for xfrm_state_find under preemption
Date: Fri, 23 May 2025 17:11:16 +0200
Message-ID: <cover.1748001837.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking at the pcpu_id changes, I found two issues that can
happen if we get preempted and the cpu_id changes. The second patch
takes care of both problems. The first patch also makes sure we don't
use state_ptrs uninitialized, which could currently happen. syzbot
seems to have hit this issue [1].

[1] https://syzkaller.appspot.com/bug?extid=7ed9d47e15e88581dc5b

Sabrina Dubroca (2):
  xfrm: state: initialize state_ptrs earlier in xfrm_state_find
  xfrm: state: use a consistent pcpu_id for xfrm_state_find

 net/xfrm/xfrm_state.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

-- 
2.49.0


