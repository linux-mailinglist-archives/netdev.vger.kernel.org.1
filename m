Return-Path: <netdev+bounces-52447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4807FEC0A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EA5281FCD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79E38DDB;
	Thu, 30 Nov 2023 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hM/Z6N99"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550FD50;
	Thu, 30 Nov 2023 01:40:55 -0800 (PST)
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 49C622012A;
	Thu, 30 Nov 2023 17:40:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1701337253;
	bh=DYVEjPmENldAVn0veRVABWTZgAuQcmimV8LUyiPCHM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hM/Z6N99MvavxIsvBoks6ZDBxgNEdEzG3kKR0Cg9XBzj/aExsAtiJnxH0zrn8B/pZ
	 YCR1YQkJy63HAkaz8MEewL9dVh6DGVsmmMt7VBEKG3A7tcj4B2xRP7MEy5T9yKwUJ7
	 VICpkg7El0MH2kaSRVyHJzI/P7g5ApM111hXdwud2sM3RRMT5aEvtsBST5JnX2Cqj1
	 OcEVyB5xIK3Ls1abvIm0IoF41gL7WAKSTMdVGAmvEtAQRoSMPWUzdyLTcqIVF5nzdI
	 8RR9Se6yVvhym0WUMeVlDoi137oysraZ0pwFK9JZJNksWVZQdM35v/uawp+0l0hnZz
	 Ty11P6XYAnz+g==
Message-ID: <852eaa7b5040124049e51ceba2d13a5799cb6748.camel@codeconstruct.com.au>
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
Date: Thu, 30 Nov 2023 17:40:51 +0800
In-Reply-To: <706506b7-a89c-4dfc-b233-be7822eb056e@os.amperecomputing.com>
References: <20231130075247.3078931-1-quan@os.amperecomputing.com>
	 <473048522551f1cae5273eb4cd31b732d6e33e53.camel@codeconstruct.com.au>
	 <706506b7-a89c-4dfc-b233-be7822eb056e@os.amperecomputing.com>
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

> With this commit, we all see the packets go through peacefully just
> by requeueing the packets at MCTP layer and eliminated the need to
> retry in PLDM layer which would need more time.

It's certainly possible that this tries harder to send MCTP packets,
but it's just duplicating the retry mechanism already present in the
i2c core.

Why do we need another retry mechanism here? How is the i2c core retry
mechanism not sufficient?

It would seem that you can get the same behaviour by adjusting the
retries/timeout limits in the core code, which has the advantage of
applying to all arbitration loss events on the i2c bus, not just for
MCTP tx.

Cheers,


Jeremy

