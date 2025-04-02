Return-Path: <netdev+bounces-178777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC6A78DF2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5E3AFF38
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9341238166;
	Wed,  2 Apr 2025 12:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0E23371D;
	Wed,  2 Apr 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595947; cv=none; b=bkts13eEkXiA7VT4E4KsPGvOjUNSiLC20uawM4nTLq6uH0CyT9u5B+djnUXa8H+PiMzy7vpUW9FWUw4BVxclY3ITTB/gspWov4l5ZrCHK9g9+oZxkh/j9o+IbfNwM4zsBARHxJH/7AJrjj6pm9XxDvBq+BhVL6Li6rzeLOphBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595947; c=relaxed/simple;
	bh=93MsZgHZPuKgHFlXUFE5ODJyARsiBlTJ4w2tRPzDcsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+zceAKZd4dHM4ZTI0Ns1wJpf9tpTxL/hDDSU1GDOA8O7KggwXaHrE0tgNTKrP2qkW5fIWG1U8wiUwwySKCL+REp7vupVQg7OeR8ACFU2yCtvxFpfHbKTgxeb5eki6VpGyDaQJZ1NRk45nmc3JV3SmgL66Mu6cyU2sjO/6JEB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZSNxS5C5BztQfs;
	Wed,  2 Apr 2025 20:10:52 +0800 (CST)
Received: from kwepemg200016.china.huawei.com (unknown [7.202.181.67])
	by mail.maildlp.com (Postfix) with ESMTPS id D71F518007F;
	Wed,  2 Apr 2025 20:12:17 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemg200016.china.huawei.com (7.202.181.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:12:17 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>
CC: <kuba@kernel.org>, <yanan@huawei.com>
Subject: [Discuss]ipv6: send ns packet while dad
Date: Wed, 2 Apr 2025 20:12:05 +0800
Message-ID: <20250402121205.305919-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200016.china.huawei.com (7.202.181.67)

Hello, everyone:

I have an RFC-related question when using ipv6.

Configure an IPv6 address on network adapter A. The IP address is being used for DAD and is unavailable.
In this case, the application sends an NS packet to resolve the tentative IP address. The target address
in the multicast packet contains the tentative IP address, and the source address is set to the link-local address.
Is this allowed to be sent? Does it contradict the following description in the RFC 4862?
(https://datatracker.ietf.org/doc/html/rfc4862#section-5.4)

>Other packets addressed to the
>tentative address should be silently discarded.  Note that the "other
>packets" include Neighbor Solicitation and Advertisement messages
>that have the tentative (i.e., unicast) address as the IP destination
>address and contain the tentative address in the Target Address field.

Or is this description just for receiving packets?

The actual problem I encountered was that when proxy ND was enabled
on the switch, the reply ND packet would cause the dad to fail. 
So I'm not sure if it's the NS sending problem.
Thank you very much, if anyone can reply!

