Return-Path: <netdev+bounces-48985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1217F044C
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 05:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0712E280E16
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 04:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47B2109;
	Sun, 19 Nov 2023 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp4YyRG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE24C60
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EE1C433C7;
	Sun, 19 Nov 2023 04:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700367728;
	bh=46ZpEAegBzDsGRG/6xeHo6oLyXNnMQAtkVXlHiBHSKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qp4YyRG++RoMvkw8/Co9B0TbaVvIzlXjc3rhJ7zj2V6SeqSThtmiNz10FM4OQPHmF
	 1ffEwiVWo2ZabFMcNiLDXu1xWS/QiQ4W5oj30/BV3umwtYvoutGpsgoKvUTsuHZmRM
	 PDryk4UxdFSTFT2DlE3w6N+8g/N09ceNKi8DzUllEPrpaNLKKep9yCtDJbRpQ9X8Q6
	 5+scIoXIgk1snDpd8MzQl/6Usen3OjXvyzs435HLO4wilfecd+j1dNYlhrKN81U2gE
	 A14IIhMGaek8Zj5bNgqX2ny3iN0DZwUJm6LRzBe2ooqvdAGZzvcEyVkbKRlw9+X00J
	 516riIEo9LD5g==
Date: Sat, 18 Nov 2023 20:22:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: Denis Arefev <arefev@swemel.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: flower: Added pointer check and continue.
Message-ID: <20231118202207.16a60834@kernel.org>
In-Reply-To: <ZVd4RYURdHLL+F2h@LouisNoVo>
References: <20231117125701.58927-1-arefev@swemel.ru>
	<ZVd4RYURdHLL+F2h@LouisNoVo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 16:27:17 +0200 Louis Peens wrote:
> >                 acti_netdevs = kmalloc_array(entry->slave_cnt,
> >                                              sizeof(*acti_netdevs), GFP_KERNEL);
> > 

Unnecessary new line, please remove it.
There should be no empty lines between call and error check.

> > +               if (!acti_netdevs) {
> > +                       schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
> > +                       continue;
> > +               }
> > +  
> Thanks for reporting this Denis, it definitely seems to be an oversight.
> Would you mind adding a 'nfp_flower_cmsg_warn' here as well, so that
> this case does not go undetected? Maybe something like "cannot
> allocate memory for group processing" can work.

There's a checkpatch check against printing warnings on allocation
failures. Kernel will complain loudly on OOM, anyway, there's no need
for a local print.
-- 
pw-bot: cr

