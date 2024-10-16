Return-Path: <netdev+bounces-136091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D39A0467
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C494C1C21888
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD0F1FDFA3;
	Wed, 16 Oct 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MGCJGGTG"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3071FCC74;
	Wed, 16 Oct 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067796; cv=none; b=NAvw1zhtvColZGVN+LopXvd9tiXZn05dwd0DMNbABYY7oszgMO7lphaBLhMJiaeLR52sWxLxhK4LnUS8n1teebVpoCAmeWHrDH98tD0QQJ9n8+PEymi9ElvKMbtfO3JZJXQxEpU4xcf0BwMzah22KWukanyP4vqA6QdtmQxPIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067796; c=relaxed/simple;
	bh=uTxeLuSwto/BPgScS/3f9pYRmzxMRTM4H7W2/1VV4EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+FRnrIyH0wycm10gLsveVI4zW0E4CYvPHL6yzgD+4S2W6GF46jDvNMsZyhtXLCTyaj7a2UJ+jXmFoDK2RYwJ9cG2vLqgFV9fD1Qy2wwuq2M/Ur4id5IYpw5Vn05UvrREJenJutolvXw2RftjE2eKBzQ+wTfRhFVpl8BtNT1+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MGCJGGTG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0oquJHVwiMMkyIWd/5w5Q2GuFTQnhIV33AZa476I+ng=;
	b=MGCJGGTGPyGs0JgRXDDQJlvvau9YnJCScW9VoAX99/n6oDoMqbweR/okySgCWG
	469TsZOBD3gMJKjAC4O1YSQITK1fHW1UDUUewnYzRSfjJo4/KKS53t5AB5qie9xN
	sz3XAjGmJoJOg+3kSuMad5se0hyFPQAnjo5MCSsinEQvc=
Received: from localhost (unknown [60.166.103.163])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3__3veg9n+mHUBQ--.4196S2;
	Wed, 16 Oct 2024 16:36:00 +0800 (CST)
Date: Wed, 16 Oct 2024 16:35:57 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Subject: Re: [PATCH] nfc/nci: Fix uninit-value issue in nci_ntf_packet
Message-ID: <Zw967Vgatt8Ob1uO@mac.local>
References: <ZwqEijEvP7tGGZtW@fedora>
 <670ab923.050a0220.3e960.0029.GAE@google.com>
 <ZwrENfTGYG9wnap0@fedora>
 <d4ba554d-213a-4961-a9f2-6582b38fc082@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ba554d-213a-4961-a9f2-6582b38fc082@kernel.org>
X-CM-TRANSID:_____wD3__3veg9n+mHUBQ--.4196S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwl19UUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYAl6amcPcKnuWQAAs-

On Wed, Oct 16, 2024 at 09:58:53AM +0200, Krzysztof Kozlowski wrote:
> 
> Same comments as before:
> 
> https://lore.kernel.org/all/20240803121817.383567-1-zhanghao1@kylinos.cn/
> 
> Respond to existing feedback, please.
> 
> Best regards,
> Krzysztof

Got it, thanks!

-- 
Best,
Qianqiang Liu


