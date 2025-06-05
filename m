Return-Path: <netdev+bounces-195252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C978DACF122
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9255B16D8EB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43825E44B;
	Thu,  5 Jun 2025 13:43:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9725D91B;
	Thu,  5 Jun 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131032; cv=none; b=p/9mxA1/n1JnF/86sLlWjHWUXA5jgZaZmyqTZJg0y3OeKhLfEvFyZVXefPixQKBYY36ob8aOy/GXq93mSCTEJyxWUpnVsjF0p4OxX6KRdFRNnoughgCRM5/zyjY5SPQZocsKXEhC0xIPwmaP+ckM+WbbZauEu1QjBItMUURDMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131032; c=relaxed/simple;
	bh=u0BlaY6w9UmwyT8MLWjXkQqgoz6G3YoduK/7SgtXSs4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BjNG2sPtF3lPyXkI9eu0E4FJ+ZYW3xfAXjGRTmUCKaPdRlSBUxWk3HYTMjMX3+iLTc6A3sEr5FR5xL4YGNOZ/ANYh2aZ6blxslHdjB3o599O0DkOuJ9/5ZxfXKuXNsoevq6YTHJsr1eyS1l54Z24XHXB6HfUUVi+Bz8AsSKPTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bCm056bpfz27hdN;
	Thu,  5 Jun 2025 21:44:37 +0800 (CST)
Received: from kwepemj100008.china.huawei.com (unknown [7.202.194.2])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C29C14027A;
	Thu,  5 Jun 2025 21:43:46 +0800 (CST)
Received: from kwepemo500008.china.huawei.com (7.202.195.163) by
 kwepemj100008.china.huawei.com (7.202.194.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Jun 2025 21:43:46 +0800
Received: from kwepemo500008.china.huawei.com ([7.202.195.163]) by
 kwepemo500008.china.huawei.com ([7.202.195.163]) with mapi id 15.02.1544.011;
 Thu, 5 Jun 2025 21:43:46 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Stanislav Fomichev <stfomichev@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Yanan (Euler)" <yanan@huawei.com>, "Fengtao (fengtao, Euler)"
	<fengtao40@huawei.com>
Subject: skb defer free casues a lot of memory not released in hugepages 
Thread-Topic: skb defer free casues a lot of memory not released in hugepages 
Thread-Index: AdvWHw8FJG0wn6xrTCa1JQxTrnFH+Q==
Date: Thu, 5 Jun 2025 13:43:46 +0000
Message-ID: <42c422c6cc99497586a4a678dfe8ba34@huawei.com>
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

Hello:
In my virtualization scenario, physical host enable hugepages feature and s=
hare hugepages to the virtual machine running on it.
A large amount of data is exchanged between the host and the vm through TCP=
 local communication.Later, the vm is no longer needed and is destroyed, bu=
t the hugepages shared to the vm was not fully released back to the host.=20
Tracing showed that the hugepages are occupied by skbs in host due to commi=
t 68822bdf76f10 ("net: generalize skb freeing deferral to per-cpu lists").
it will remain some skbs in cpu skb_defer_list to defer free, it seems that=
 may cause infinite delay if there is no triggering for net_rx_action().=20
A large amount of memory is not released because there are many CPUs and hu=
gepages feature. Host can't recycle memory fast enough will affect the subs=
equent VM hugepages allocation.
Maybe we need a general method to release skb immediately or a timeout mech=
anism for skbs in defer list to release?
Best wishes!


