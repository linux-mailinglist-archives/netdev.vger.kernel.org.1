Return-Path: <netdev+bounces-97505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F08CBC42
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24641C2160D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539407E0FB;
	Wed, 22 May 2024 07:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DD7D40D;
	Wed, 22 May 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363881; cv=none; b=UXNmhjYgEGeiU8Fw51PKRWhtEAsSiOz1CSioz+mtFjFme0AT/UvJ6MsxVt0jNMwBgpT7ki2rIrUTua0jRqy4tr8owV6Pfxq3mwIEDdYzMS5R1ZMXwn6Pc+sAC8LltX+ItgSlrJmywa2phOXWoqR6hyv3RAC5iqfzo/WUyYQQmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363881; c=relaxed/simple;
	bh=OyAYU9wdToTlNpCqVBj184wBvTfjYqMromOTV3WB6PM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ppHyE2VUkMzZRUwb5bg4al3xFuwj5khgJmjlSmpTbuJWg1r/1GqWcnMIYb5sGzbuUb3oGup3BoStpjkT5tTfIxW9nXSR6GSKCNE1723TSj/EEZv/UdNO3vSpy8BLRbXkj6yw0eNxiphA2zfC/WChLul53wtHvpvKuEwUIivdHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vkjt558xVzPmKT;
	Wed, 22 May 2024 15:41:33 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (unknown [7.193.23.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B3A11800C9;
	Wed, 22 May 2024 15:44:35 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 15:44:35 +0800
Received: from dggpeml500007.china.huawei.com ([7.185.36.75]) by
 dggpeml500007.china.huawei.com ([7.185.36.75]) with mapi id 15.01.2507.035;
 Wed, 22 May 2024 15:44:34 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
	<horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Lorenzo Bianconi
	<lorenzo@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
CC: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>, "Yanan (Euler)"
	<yanan@huawei.com>
Subject: cpu performance drop between 4.18 and 5.10 kernel?
Thread-Topic: cpu performance drop between 4.18 and 5.10 kernel?
Thread-Index: Adqr+is3Qylu3zxvSvOZrHpOxyfQ/w==
Date: Wed, 22 May 2024 07:44:34 +0000
Message-ID: <9fd382fb581e47a291ed31bfe091112c@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Dear maintainers:
I updated my VM kernel from 4.18 to 5.10, and found that the CPU SI usage w=
as higher under the 5.10 kernel for the same udp service.
I captured the flame graph and compared the two versions of kernels.=20
Kernel 5.10 compared to 4.18 napi_complete_done function added gro_normal_l=
ist call (ommit 323ebb61e32b4 ("net: use listified RX for handling GRO_NORM=
AL
skbs") Introduced), I removed gro_normal_list from napi_complete_done in 5.=
10 kernel, CPU SI usages was same as 4.18.
I don't know much about GRO, so I'm not sure if it can be modified in this =
way, and the consequences of such a modification?

