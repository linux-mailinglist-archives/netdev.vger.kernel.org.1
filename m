Return-Path: <netdev+bounces-39729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD07C43C0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569811C20BBD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520F32C7F;
	Tue, 10 Oct 2023 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="hDxAk9JB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2B315A6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:24:38 +0000 (UTC)
X-Greylist: delayed 148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 15:24:35 PDT
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [IPv6:2001:4b98:dc0:41:216:3eff:fe56:8398])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A19D;
	Tue, 10 Oct 2023 15:24:35 -0700 (PDT)
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 39AMLW2b3324422;
	Wed, 11 Oct 2023 00:21:32 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 39AMLW2b3324422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1696976492;
	bh=1jk5idWYaUQ5kRihQ+KrfsDVP7GFGMxbdcsWlzUtJfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDxAk9JBiB7JU7Z9LUTw0rkaRXwa9cK5JMEX/p5lhBnHQBM9VBy3NV7/dZBruL1Zt
	 eQTZXNYQh4nLFsv3d2kLyeLbbL737AdcGt2Jtl3dm2Zw1cnlYi/yyK+LcejDaDfAw1
	 c09IgvzXVJlq3AxH00Jurn6lBMWNL3JSPVm57Q7I=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 39AMLVg93324421;
	Wed, 11 Oct 2023 00:21:31 +0200
Date: Wed, 11 Oct 2023 00:21:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Wei Fang <wei.fang@nxp.com>, kernel@pengutronix.de,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
Message-ID: <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
X-Organisation: Land of Sunshine Inc.
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Marc Kleine-Budde <mkl@pengutronix.de> :
> The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> dm9000_phy_write(). That function again takes the db->lock spin lock,
> which results in a deadlock. For reference the backtrace:
[...]
> To workaround similar problem (take mutex inside spin lock ) , a
> "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> sleeping in dm9000_timeout callback"). Use this variable and not take
> the spin lock inside dm9000_phy_write() if in_timeout is true.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> During the netdev watchdog handling the dm9000 driver takes the same
> spin lock twice. Avoid this by extending an existing workaround.
> ---

I can review it but I can't really endorse it. :o)

Extending ugly workaround in pre-2000 style device drivers...
I'd rather see the thing fixed if there is some real use for it.

-- 
Ueimor

