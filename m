Return-Path: <netdev+bounces-230063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C1BE37A0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3178058395F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095E302CC8;
	Thu, 16 Oct 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YpjSCUFX"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD482E0B68;
	Thu, 16 Oct 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618811; cv=none; b=PtctpODMfUjItKK5CnYwCN40fi55No/+g/M5sc5xIG0XIJEKmIOe0mr47tG74RWcYayS+elAnzBwpct3iCw3q6e4L3HobvyPZiWLB9clNrGkwzSQsDDEGyikgkaAzKbE8ms/DdU150YqRC6tjSVhl9JqFO9a/x/oROHxTKSLQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618811; c=relaxed/simple;
	bh=GHsqNwbBs+RY3YlPhmUDhL0sPZiEyt+4voPj0oucKHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKaCOj1oRWCD4nruy5OrWLPFMeOaYjCnOejvxneQMdsT3eY8KUW/wF77JunZzRxhu35l1IAMBCd3RQHnplpEgeNeiPD5/Tb7QPUaex+bDvOi2ZMPVyqNlCt9vD30Pm/tBOQ59yqNqQTCmPCIm2w+IlD0qQyRQSDdw21XWTLga+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YpjSCUFX; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CnOT0cTwvlqTalnJASPuCRhhj5GVC1YdHDfSyx0BSi4=;
	b=YpjSCUFXiA03oETD/wr7Zvxp0ZjXe3bqcf4rkflZfNasrIxHdbdq8wYZULCPt3KSW9ZH+DQI5
	c88pzOfggkb8o4Nevc3kAqWbSsWSX4m9GtL0qsnUGkQVWc52iltoal/EZa7ScQNSk0tSBEEu7bZ
	ZKEypDUYk99OIEv3/QN2VkA=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cnSNn0Bl6zcb3n;
	Thu, 16 Oct 2025 20:45:45 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CF4E140156;
	Thu, 16 Oct 2025 20:46:45 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 20:46:43 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <markus.elfring@web.de>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<luoyang82@h-partners.com>, <meny.yossefi@huawei.com>, <mpe@ellerman.id.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next 2/9] hinic3: Add PF management interfaces
Date: Thu, 16 Oct 2025 20:46:38 +0800
Message-ID: <20251016124639.1927-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <3ed166fc-6641-4e7b-a2ba-2f17081af1d3@web.de>
References: <3ed166fc-6641-4e7b-a2ba-2f17081af1d3@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 10/16/2025 6:26 PM, Markus Elfring wrote:
>
> Can it occasionally be more desirable to specify other recipients
> in the field “To” (instead of “Cc”)?
>
> Regards,
> Markus

Thanks for your suggesion. We will adopt your suggestion in next 
version.

