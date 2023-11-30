Return-Path: <netdev+bounces-52403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E87FEA21
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A3AB20D6F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFDD20DD8;
	Thu, 30 Nov 2023 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZqSlTylJ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1FDA3;
	Thu, 30 Nov 2023 00:03:13 -0800 (PST)
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6BF402012A;
	Thu, 30 Nov 2023 16:03:09 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1701331390;
	bh=y+SkZschDSx1mlTO6KMgxF6aRQzLJQjSlyJB5vTM/RM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZqSlTylJ1UAKIM8WHHtZa/ExueX7iRfEr15FIG7wXmMv+WF7NTBydAtHKcn/n112Y
	 8bYXAwofcqQnD9Bq0TRCCqavo1HM2l8kVCE1va8SVUySe8PMXEpG1mzFypN4yiZGTF
	 IWgJFpKBOBoEDaBPfCQ8rDAaonCJTcXdbizBgw84bshQmQ17cHDVS6sVrqM8V7HcYU
	 MV2pGnr5PXXP5aWsOLf9RhA7LNgi9CQ5HzztXXlVqNmhfOYAJuZeRsUlAG7+aPaBrA
	 YIoJNg++g7MNy9h3ZonwduFRyqkV+E87a3IPWZ3SxYw7Z5a+FeZ10qo3hbDFlGWPhY
	 quc3SJA9Q94jA==
Message-ID: <473048522551f1cae5273eb4cd31b732d6e33e53.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: Requeue the packet when arbitration is lost
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Quan Nguyen <quan@os.amperecomputing.com>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,  Open Source
 Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>, Thang Nguyen
	 <thang@os.amperecomputing.com>, Dung Cao <dung@os.amperecomputing.com>
Date: Thu, 30 Nov 2023 16:03:09 +0800
In-Reply-To: <20231130075247.3078931-1-quan@os.amperecomputing.com>
References: <20231130075247.3078931-1-quan@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Quan,

> If arbitration is lost, __i2c_transfer() returns -EAGAIN and the
> packet should be resent.
>=20
> Requeue the packet and increase collisions count on this case.

Are you sure you want to re-queue the packet here? The i2c core would
have already retried on arbitration loss:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/i2c/i2c-core-base.c#n2223

With this change, we would be disregarding the limits in adap->retries
and/or adap->timeout.

Cheers,


Jeremy

