Return-Path: <netdev+bounces-134782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647AD99B26F
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5EC2835EB
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825B1494AB;
	Sat, 12 Oct 2024 09:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28654610D;
	Sat, 12 Oct 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728724344; cv=none; b=H4RTVWvREpgP7FegKlv8KtdvLhrFLShCl0iC0Yky0BiZ1Mog5KKu4JW0T5+yqUIJIJZvUZIi5BdSiUR2JvGRt2TjomyzpOx9FF2NBpeuTYjZ6quvroRI5nUUsazKS6DIaVDIxi7OggxguY0fIXZXBNHQXiBEJYdxLCbcIZF+Z+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728724344; c=relaxed/simple;
	bh=C2yu17Z7rF6AUbYWy9HUXKzZAEbp9PPKR8pi5U7HUgg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sBGE9/bbC7R/h7oFq58WX3wU2XJstRktK0EeiZW390fSBI9AK4FKk6wiui02zrK2Nm9zgFv7C74g1hZNjcg9Cs9njluBkYh+lhl+Tk5Db/dev9A2rAoL0Kv5HYmWEFjKw7PUMuiSmxqsrvSZEYH41zCEkePsPxXF7bKME4CJvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XQd5x1ymLzQrbl;
	Sat, 12 Oct 2024 17:11:33 +0800 (CST)
Received: from dggpemf100014.china.huawei.com (unknown [7.185.36.231])
	by mail.maildlp.com (Postfix) with ESMTPS id 3915D140157;
	Sat, 12 Oct 2024 17:12:13 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (7.185.36.43) by
 dggpemf100014.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 17:12:12 +0800
Received: from dggpemf500014.china.huawei.com ([7.185.36.43]) by
 dggpemf500014.china.huawei.com ([7.185.36.43]) with mapi id 15.02.1544.011;
 Sat, 12 Oct 2024 17:12:12 +0800
From: tianmuyang <tianmuyang@huawei.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "dsahern@gmail.com" <dsahern@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "willemb@google.com"
	<willemb@google.com>, "brouer@redhat.com" <brouer@redhat.com>,
	"anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
	"alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>,
	"magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>, "mtahhan@redhat.com"
	<mtahhan@redhat.com>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "Yanan (Euler)" <yanan@huawei.com>, "Wuchangye
 (EulerOS)" <wuchangye@huawei.com>, Xiesongyang <xiesongyang@huawei.com>,
	"Liuxin(EulerOS)" <liuxin350@huawei.com>, "zhangmingyi (C)"
	<zhangmingyi5@huawei.com>, "liwei (H)" <liwei883@huawei.com>, tianmuyang
	<tianmuyang@huawei.com>
Subject: Questions about XDP hints
Thread-Topic: Questions about XDP hints
Thread-Index: Adschr1DOKSSRg+zQgOfeFDtypgqTg==
Date: Sat, 12 Oct 2024 09:12:12 +0000
Message-ID: <90c1c6b53a654cf197eb412917fad31a@huawei.com>
Accept-Language: en-US
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

Hi all:
	There has been some discussions about adding checksum hint in AF_XDP such =
as this thread[1]. Now, we also plan to add checksum hint. My questions are=
:
	1. In this msg[2], is it appropriate if xdp_csum_status only includes 4 en=
ums/macros(CHECKSUM_NONE...CHECKSUM_PARTIAL in skbuff.h)? Thus it becomes m=
ore generic. Also, in this msg[3] we can simply pass skb->ip_summed to csum=
_status in veth_xdp_rx_csum().
	2. What should be taken care of if I want to add a new hint? IOW, what is =
acceptable to add a new hint?

Thanks!

[1] https://lore.kernel.org/bpf/CAADnVQJPgpo7J0qVTQJYYocZ=3DJnw=3DO5GfN2=3D=
PyAQ55+WWG_DVg@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230728173923.1318596-13-larysa.zaremba@in=
tel.com/
[3] https://lore.kernel.org/bpf/20230728173923.1318596-18-larysa.zaremba@in=
tel.com/


