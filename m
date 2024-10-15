Return-Path: <netdev+bounces-135796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EC99F3A9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8E2815BC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C01F76B4;
	Tue, 15 Oct 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpGDbq39"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FC17335C;
	Tue, 15 Oct 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011809; cv=none; b=mpIbjijH6kt95dBz+Gw+t1xefwOMhKijlugQJOtJSr5dIRaNbUAyVT+Yb7YuGXpaaK4Bm1Co1q5LlbVa/s1sw1TYFpwwXAvqpfuMabVcKCmkISEwqfmWQVjjZOUSpPG07MTOoyPWTlKLp1ohJmDDhgPJjgjBiV2Ot5dE3i4Ik2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011809; c=relaxed/simple;
	bh=sElP02gDfmSlCKPHIA7lAHvevSASdNO/PoVzfxITPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3HulrGaSHKyWJa4VjiH1fbWsD9UrVZTfA8BMl1wdv2bJUThykF9zqxKce39mIJqNgraNGxgJD5Xl88ExxPxuprPLbVh8xKnaZGUF6XWx2Wceoo7aTrgclAx+FMSIKY2iMfJw0pqPsRQkC8bBm/G4PoirEwAJ9J06HcYvNZAHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpGDbq39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBDFC4CEC6;
	Tue, 15 Oct 2024 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011809;
	bh=sElP02gDfmSlCKPHIA7lAHvevSASdNO/PoVzfxITPBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpGDbq39zCH68/UKPG73ZcRr2MJ6hqFd8Kpeg9hlpKcgrBKCmHKzI8d0mspcFw+zU
	 IqN55yRN2Nibyc70OuDBXzb4roGTamf8ItMJPabnRA8DqWmOT/Qnm8kTwZ8qx8IIIE
	 X1UrD/e17D/2Ya4x6+7lY2Vx4f6D2H8Ns/GYKtEKTlH02zIGjRIfvSzRpneO4Igs6N
	 kzzbZQesozDOxm99vbwzJytT7yQWBDkRBhI3Gc+HZdX8NnwsBlJVL8DYIg/J9JNxeb
	 /g825upkqtv1KKwaU0bZSv2HLyosaSKz8S+BL0MQXg1vq7Qckd0kjzUqApR/hwg9RP
	 SpToHTnScBTwg==
Date: Tue, 15 Oct 2024 10:03:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: <andreas@gaisler.com>, <gerhard@engleder-embedded.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <zhangxiaoxu5@huawei.com>, <kristoffer@gaisler.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: ethernet: aeroflex: fix potential memory
 leak in greth_start_xmit_gbit()
Message-ID: <20241015100327.59c3e313@kernel.org>
In-Reply-To: <20241015100127.1af51330@kernel.org>
References: <20241012110434.49265-1-wanghai38@huawei.com>
	<20241015100127.1af51330@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 10:01:27 -0700 Jakub Kicinski wrote:
> On Sat, 12 Oct 2024 19:04:34 +0800 Wang Hai wrote:
> > The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
> > in case of skb->len being too long, add dev_kfree_skb() to fix it.
> > 
> > Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")  
> 
> The fixes tag is incorrect. Please pay more careful attention.

I take that back, sorry. I was looking at
greth_start_xmit vs greth_start_xmit_gbit

