Return-Path: <netdev+bounces-81075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DA885AA9
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431FE1C2107C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756185279;
	Thu, 21 Mar 2024 14:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1C85639
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031256; cv=none; b=LDOZ9tzAB1hcjE1d80D2SfN0P/bqJP84Dw9QHlqKspAOYmSfoE/s0hRXgTSyukG8hKwFjDP1EGWN+43KQmwDNvRiM097I4yKou7jdod5oprmbN/XmK6JvrC2Ve99YcgQIqE4OECEQd7GRhBIjz+wfYxpvj8CghYwiGp4Es/DOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031256; c=relaxed/simple;
	bh=xIQmHTJQZluUt03kHsPGGCvZmh1fklh5ZKbS1v0EOyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4dWtnaNeHIfQ/LEghrmPcWu4QZg6I+on81VpdzHua/KZdrAdPw7pmTViRuq0rOQwooWG8fjSTsE9UFf29rXhMokyM/YUmhAe9CwfjGUe/kLvX8z4OWhflfnbrL89vk1AG5chDGMHZCWe1vLyTVLku0A/MDTOAX50fE4UHoONHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V0nm72TBDz1R7Xf;
	Thu, 21 Mar 2024 22:24:55 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F7C31402CC;
	Thu, 21 Mar 2024 22:27:30 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 22:27:29 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <netdev@vger.kernel.org>
CC: <renmingshuai@huawei.com>, <yanan@huawei.com>, <chenzhen126@huawei.com>,
	<liaichun@huawei.com>
Subject: [PATCH] net/netlink: how to deal with the problem of exceeding the maximum reach of nlattr's nla_len
Date: Thu, 21 Mar 2024 22:14:00 +0800
Message-ID: <20240321141400.38639-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100005.china.huawei.com (7.185.36.102)

RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
due to the maximum reach of nlattr's nla_len being exceeded. As a result,
the value of nla_len overflows in nla_nest_end(). According to [1],
changing the type of nla_len is not possible, but how can we deal with this
overflow problem? The nla_len is constantly set to the
maximum value when it overflows? Or some better ways?

[1] https://lore.kernel.org/netdev/20210123045321.2797360-1-edwin.peer@broadcom.com/

