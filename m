Return-Path: <netdev+bounces-254117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOdrB+axeWkEygEAu9opvQ
	(envelope-from <netdev+bounces-254117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:51:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7645A9D86F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1899E301451B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4B33065D;
	Wed, 28 Jan 2026 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SlfXYR9D"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AB327BF3;
	Wed, 28 Jan 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583048; cv=none; b=FYSIYG/7/n5kNHxEzFuJHxAKWddtWaR8yjRbJzLOqt0SgYaEj2wycQKGKQBvedmCjtquQ7ufXpZw6UHtgF8RRHqUq13Kwb/tPEDjkjPqRI8Iuphcqdm5fq4UxGYPRmtt2zK6WC6TeJBfC1hJhla/mEkfnLyqEhmdQE0C1jEJbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583048; c=relaxed/simple;
	bh=7RhITK9JHsBgztRgzwUeN6sfv3YO8+ejbNM+YgTJ75s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxkGYX+ZrPIDZ2LMhJ9Mmp52IJsO8j/sXVSLB7OALIkCURkdiyZ3maJvpA3l6F/HQNBG6AdwquazD7nxaw5vO0ofDu7K8SyciYCdvhL0w5otMI7NkFMz8AFzoVv0MonB1UB4T4Bz0+9BmqAgYhxUC7m+Mki0TT10QrPKSlEhd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SlfXYR9D; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7RhITK9JHsBgztRgzwUeN6sfv3YO8+ejbNM+YgTJ75s=;
	b=SlfXYR9D5O8O8fTQHFDkUxy0jLR9QxjCmd9oDR8iXNTP6AwEw3JAlIAktpsUCXGBf/t5tkutB
	adNpuAiC4WjGIsDSwb/Qupg+2omAhuk5DPr2RKcL7fwpbcZJ5w08X53rVSLZPhe0kSNLBgqNUe2
	GvL9cje8WqezQyOomZGOw4k=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f1CVc5CChznTVM;
	Wed, 28 Jan 2026 14:46:48 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id ABF4F4055B;
	Wed, 28 Jan 2026 14:50:42 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 28 Jan 2026 14:50:41 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v02 2/4] hinic3: Remove redundant defensive code
Date: Wed, 28 Jan 2026 14:50:37 +0800
Message-ID: <20260128065038.1381-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <aXjm6fE7Vsv_0GTP@horms.kernel.org>
References: <aXjm6fE7Vsv_0GTP@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254117-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,h-partners.com:email]
X-Rspamd-Queue-Id: 7645A9D86F
X-Rspamd-Action: no action

On 1/28/2026 12:25 AM, Simon Horman wrote:
> On Mon, Jan 26, 2026 at 09:03:32AM +0800, Fan Gong wrote:
>> According to comment of patch 03, check codes that were merged and
>> remove redundant defensive codes.
>>
>> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
>> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
>> Signed-off-by: Fan Gong <gongfan1@huawei.com>
>
> Hi,
>
> I agree that defensive coding is unnecessary in Networking drivers.
> But I'm unsure what "codes that were merged" and "patch 03" refers to.
> Could you clarify this?
>
> Likewise in patch 3/4 of this series.
>

Our negligence did not explain this clearly.

Patch 03 points to the mergeed patch "net: hinic3: Add a driver for Huawei 3rd
gen NIC - sw and hw initialization".

"codes that were merged" means that we review the code already merged into
Linux based on Jakub's review comments.
https://lore.kernel.org/netdev/20250902180843.5ba05bf2@kernel.org/

At that time, "patch 03" could only modify the parts where the code was to be
merged. Therefore, after we checked the previous codes ,the codes already
merged are modified in this current patchset.

Thanks,
Fan gong

