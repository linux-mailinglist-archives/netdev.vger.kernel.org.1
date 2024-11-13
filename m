Return-Path: <netdev+bounces-144395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808799C6F34
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458BB28709E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2C1DF97D;
	Wed, 13 Nov 2024 12:40:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFE17B401;
	Wed, 13 Nov 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501643; cv=none; b=gBtk0BW1sdyn/VZoWI+g0fm0qUD3vU2ZkfmTkld68O+I2FNZHfVtTpw3CgzB3r0vwf8NoxhPW4GJFgasalW3qtYz1RGr2ChluHa32C4nR0dVpS+8SDqmZJgAPhW/6/xlEtq7kWlzNLMRV7xzAR5HbeD+MxZ9U40/w25NHYsfsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501643; c=relaxed/simple;
	bh=UhGcyZX4vutfzSFJhUGPvX8YAj3ctV0CaZSmGsKNu44=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GUZmdA92sUMKIbdArTYodSkknbZTBh3+9bI7Jl7BGb0x1CO7QHIHi0Zyb+GosO7T+0DXyTQYKQyw69Z9ABNBObRUBJ5Gi4x22l21zcnXFGbufzshU+5rAjwdVUYacQ1l6H88BexPlvtXNxy79vBQxeiul4dg5J2eOkWU8LDb9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XpN9T6Vf8z10R3g;
	Wed, 13 Nov 2024 20:38:05 +0800 (CST)
Received: from kwepemj200009.china.huawei.com (unknown [7.202.194.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 676BE140157;
	Wed, 13 Nov 2024 20:40:35 +0800 (CST)
Received: from dggpeml100007.china.huawei.com (7.185.36.28) by
 kwepemj200009.china.huawei.com (7.202.194.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 20:40:34 +0800
Received: from dggpeml100007.china.huawei.com ([7.185.36.28]) by
 dggpeml100007.china.huawei.com ([7.185.36.28]) with mapi id 15.01.2507.039;
 Wed, 13 Nov 2024 20:40:34 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>, "Yanan (Euler)"
	<yanan@huawei.com>
Subject: kernel tcp sockets stuck in FIN_WAIT1 after call tcp_close
Thread-Topic: kernel tcp sockets stuck in FIN_WAIT1 after call tcp_close
Thread-Index: Ads1xkg7IqNH0XX0Qgm09Woz06bvyw==
Date: Wed, 13 Nov 2024 12:40:34 +0000
Message-ID: <c08bd5378da647a2a4c16698125d180a@huawei.com>
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

Hello, Eric:
Commit 151c9c724d05 (tcp: properly terminate timers for kernel sockets) int=
roduce inet_csk_clear_xmit_timers_sync in tcp_close.
For kernel sockets it does not hold sk->sk_net_refcnt, if this is kernel tc=
p socket it will call tcp_send_fin in __tcp_close to send FIN packet to rem=
otes server,=20
if this fin packet lost due to network faults, tcp should retransmit this f=
in packet, but tcp_timer stopped by inet_csk_clear_xmit_timers_sync.
tcp sockets state will stuck in FIN_WAIT1 and never go away. I think it's n=
ot right.

Best wishes!

