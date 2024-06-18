Return-Path: <netdev+bounces-104318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF390C204
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2ED41F21DEB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2C19B3DD;
	Tue, 18 Jun 2024 02:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2953197A7B
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679442; cv=none; b=eVXDCBAz9pw8Ws7O0Ov7kmWMNDDHml3K28aeLLY+/AM1NPhle28UD93e/e8bmyslPruf6coqy79crhuUv/74V2V6phE1FLwoJHmps4ExXheUbKQZHIww4p9kZg4OIGAwSn+3H6lLi9tPOmFl+G2aez11PPEgvV941k+0wCD3Ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679442; c=relaxed/simple;
	bh=z4yyF+UmXxEc5mtHCyYsfU2zNwtL4Y+ZVskAsRua9T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUP4OFVqtiHFs+6yyJDc+S90WnVznIlt944T6C/JHJhwPSqwC1p6obfxDNwOl/SqtvlKZyFr92suR+tCdPgSkyYqLTaRAVazW0CAbgoRm6U3negHS7JrkFjMYvTUQuvs1ifhZvgq37SEzuOU+QSkzRhldctRPFPOttpAOqh6wiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45I2ulH6041517;
	Tue, 18 Jun 2024 11:56:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 18 Jun 2024 11:56:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45I2ulke041514
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Jun 2024 11:56:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3b9e4f5a-3008-4480-9816-080f74179a23@I-love.SAKURA.ne.jp>
Date: Tue, 18 Jun 2024 11:56:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value
 in receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <000000000000d10c260619498c25@google.com>
 <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
 <1718674059.0143738-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1718674059.0143738-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/18 10:27, Xuan Zhuo wrote:
> Maybe this patch can fix this issue:
> 
> 	 http://lore.kernel.org/all/20240606111345.93600-1-xuanzhuo@linux.alibaba.com

Yes, thank you.

#syz fix: virtio_ring: fix KMSAN error for premapped mode


