Return-Path: <netdev+bounces-109408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E2928677
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01226B20DD9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD301487FE;
	Fri,  5 Jul 2024 10:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39641474BF;
	Fri,  5 Jul 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174309; cv=none; b=PKda4viF/YeA7r9TFPA3Q0tybX67znswN1N4ZTt/CtkHqFhT1C1pxwfOQoYmxhpizNl0s5zf1Z3BTO/BIdhRddyoZcYJFTD3nc1IC2iTZptbeW0bKx4anWTqkTBCY/9+f5oIQYrOBiC+em3rbvVxLJ5J6kiXQAkSepUkyeKz8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174309; c=relaxed/simple;
	bh=73Xez94/1jS079vZlXFxWjDVKCn3wCr4Mj2gxwzVKRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iAduH3eUpdHN+RG9Gsb2nkV2CqPf8UXyasCI0sMhOpO8XE1l3U0NnW1vS+7/Lbwzm9C8/lHcJOEVwpsJZ53cgCz4Ov5HMnNrZhKiGfOtE6tHMIUlZUNeUQ21QOpaAgLO36KdTfvt45qCmQFnBwb6WnPYXiN+MqjXW0aK44WcybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WFq6g3M93znZ7m;
	Fri,  5 Jul 2024 18:11:23 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F644141081;
	Fri,  5 Jul 2024 18:11:43 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 5 Jul 2024 18:11:42 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<tgraf@suug.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yanan@huawei.com>, <qiangxiaojun@huawei.com>, <caowangbao@huawei.com>
Subject: When does __netlink_insert return an error code -EBUSY?
Date: Fri, 5 Jul 2024 17:55:58 +0800
Message-ID: <20240705095558.20352-1-renmingshuai@huawei.com>
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

Recently, I encountered an issue that __netlink_insert() failed
and returned error code -EBUSY, which came from rhashtable_look-
up_insert_key(). I have not yet found the reason for returning
to -EBUSY. I noticed that in the 4e7c1330689e submission, -EBUSY
was changed to - ECOVERFLOW and returned to the user. Has anyone
encountered a similar problem? Can you please advise under what
circumstances __netlink_insert will return -EBUSY?

