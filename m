Return-Path: <netdev+bounces-181897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83637A86D43
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704FC1B81B99
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D21EA7C8;
	Sat, 12 Apr 2025 13:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB71E9B28
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463882; cv=none; b=ecgPUkBjfcuWnzo82F9ENV/LjiB7ABodRHobm60VGdMDXFBHYo4ON0EjffSPH7R4Vk6ygeh/PDOUzI0ZDXCs2eE0qC7k1/j3UwtCeML9UpJn7xcPXuoswhxfb0bXzODBs4qS2ZHZpVkeJqfRbqjYDcB9I17Pxiit3/JeMxSD2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463882; c=relaxed/simple;
	bh=+8+Jfk6sp8FAGEuatfQkNmPvt/MznbxpEL7vF0j7j2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVeTi/zZp3IH9CkXXrj83SOhhBQEN3uwac8abMU6x7AP4y0hE60mpv61otOhPRjED0ElfACkA07TZCRgJ9N5R6t2kkC5hEUsqPrbGlTl8SeKQ54msT2MVzed3/IpAObnRQNOqKMjyUyRZMopzwCr3N0xzdPjrKBjyogxigY3i/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZZYsl2YJVz5vMR;
	Sat, 12 Apr 2025 21:14:03 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (unknown [7.202.181.31])
	by mail.maildlp.com (Postfix) with ESMTPS id D76C714010D;
	Sat, 12 Apr 2025 21:17:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200004.china.huawei.com
 (7.202.181.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Apr
 2025 21:17:49 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: <idosch@idosch.org>
CC: <dsahern@kernel.org>, <hanhuihui5@huawei.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: VRF Routing Rule Matching Issue: oif Rules Not Working After Commit 40867d74c374
Date: Sat, 12 Apr 2025 21:17:43 +0800
Message-ID: <20250412131743.14507-1-hanhuihui5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <Z_V--XONvQZaFCJ8@shredder>
References: <Z_V--XONvQZaFCJ8@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200004.china.huawei.com (7.202.181.31)

On Tue, 8 Apr 2025 22:54:33 +0300 Ido Schimmel wrote:
>Before 40867d74c374 you couldn't match with FIB rules on oif/iif being a
>VRF slave because these fields in the flow structure were reset to the
>index of the VRF device in l3mdev_update_flow().
>
>I will try to check if we can interpret FIB rules with "oif" / "iif"
>pointing to a VRF as matching on "fl->flowi_l3mdev" rather than
>"fl->flowi_oif" / "fl->flowi_iif".
Thank you for your reply. Followed by a simple patch to restore the 
previous behavior, hopefully enlightening you.

