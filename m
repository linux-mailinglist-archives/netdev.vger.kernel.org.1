Return-Path: <netdev+bounces-94775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230E8C09E3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C511C209D1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724313A414;
	Thu,  9 May 2024 02:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4213AD0E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222601; cv=none; b=l/Gry/ZH4TonrdVCTq5Wdv+5UMN5P2BAuW/DuCnOLYukB8L8xyTGZpDDRNABYcpeZOXtZn0z9lQAvHDaheVIjNnYgzjJ+lRgB6i4X2etLnByONJJnMXdkPAqjdy6sYkWmy9DQTD7hQKPdNQc+n7qc+yzkWmx5gKywqVw1xmWb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222601; c=relaxed/simple;
	bh=kIZLAlOJZG1H04luQj/Aon1q5SGKrKDL095iTKMpL+E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvhTBo318mbp+hu4+x+S4opt14wEgRQvHsqpFwak/NzgtytdKS+kOrt9QP7+C0THFEYb6zp7wbU8VDx1KnlvPg9f4wJDOgHfsQInArqmCtoV3QWJjSjOabqv+kSu04e0KrGhpiZlMQGwpgM/9Wpx74l7lV0DnChWIo2HOcwhI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1715222363t207t37108
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.129.236.74])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 852496616481411263
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>	<20240429102519.25096-2-jiawenwu@trustnetic.com> <20240430185951.5005ff96@kernel.org>
In-Reply-To: <20240430185951.5005ff96@kernel.org>
Subject: RE: [PATCH net v2 1/4] net: wangxun: fix the incorrect display of queue number in statistics
Date: Thu, 9 May 2024 10:39:22 +0800
Message-ID: <009c01daa1ba$1986bae0$4c9430a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKMAc/6KzgCZu6RyYLqheGkGVll8gKXsrC2AVA+vb6wCXQ3IA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Wed, May 1, 2024 10:00 AM, Jakub Kicinski wrote:
> On Mon, 29 Apr 2024 18:25:16 +0800 Jiawen Wu wrote:
> > When using ethtool -S to print hardware statistics, the number of
> > Rx/Tx queues printed is greater than the number of queues actually
> > used.
> 
> The ethtool API fetches the number of stats and the values in an
> unsafe, non-atomic way. If someone increases the number of queues
> while someone else is fetching the stats the memory of the latter
> process will get corrupted. The code is correct as is.

So should we keep the old code, showing stats with fixed maximum
number of queues?


