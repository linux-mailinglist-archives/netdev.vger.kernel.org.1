Return-Path: <netdev+bounces-182837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5AA8A0B1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593C13A7DA7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF961E5B75;
	Tue, 15 Apr 2025 14:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF831EDA23
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726281; cv=none; b=lgvTtznVONYonSLYyyoYJhOlEahdFwPDI9EKLxd9UZ2/9fNWhZhWcD4Dtcd4mI64ibNuLpmprdEhttycni6m93bkvsYUtk1YRSFC1MdH+ydcCZtrApNF0tDnJ0tZDF6D4wIT4xMv+j6aL8ws0K2m5Lk1FtINGFO0E51YvvVNfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726281; c=relaxed/simple;
	bh=U41wQsG6IpkvU/msznoe4qHEcMaMegAZRfxY37a418s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czdLnbPTrLLOvTVBtNA7wS2jKrGVxTpChd2HIePQzpoQnMqL/R0LMKS43RYccZrm1GKMM3JfgtTTiwCHtbGngnwlPAQQMG1vLvUAkNAjb3dgFfaKLSgsB6JqM5e/js6gIpwhA3gsrodys+Kx+esg2lBJ8WycKgBuWFEoNLqWUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZcR1057qcz27hJ0;
	Tue, 15 Apr 2025 22:11:48 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (unknown [7.202.181.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 086A11A0188;
	Tue, 15 Apr 2025 22:11:07 +0800 (CST)
Received: from huawei.com (10.175.104.170) by kwepemg200004.china.huawei.com
 (7.202.181.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Apr
 2025 22:11:06 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: <idosch@idosch.org>
CC: <dsahern@kernel.org>, <hanhuihui5@huawei.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] resume oif rule match l3mdev in fib_lookup
Date: Tue, 15 Apr 2025 22:11:00 +0800
Message-ID: <20250415141100.33811-1-hanhuihui5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <Z_1Eu2xm3QAncMx8@shredder>
References: <Z_1Eu2xm3QAncMx8@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200004.china.huawei.com (7.202.181.31)

On Mon, 14 Apr 2025 20:24:11 +0300, Ido Schimmel wrote:
>On Mon, Apr 14, 2025 at 10:17:35AM +0300, Ido Schimmel wrote:
..
>> This will prevent us from matching on the output device when the device
>> is enslaved to a VRF. We should try to match on L3 domain only if the
>> FIB rule matches on a VRF device. I will try to send a fix today (wasn't
>> feeling well in the last few days).
>
>Posted a fix:
>https://lore.kernel.org/netdev/20250414172022.242991-2-idosch@nvidia.com/
>
>Can you please test it and tag it if it fixes your issue?

Tested-by: hanhuihui hanhuihui5@huawei.com

The patch successfully resolves the VRF oif rule matching issue. The FIB lookup now correctly identifies 
the L3 domain when using VRFs. Thank you for the quick fix.

