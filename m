Return-Path: <netdev+bounces-32197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7857936E0
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4228D1C20924
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B97A59;
	Wed,  6 Sep 2023 08:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3ECED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 08:08:47 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CBE56;
	Wed,  6 Sep 2023 01:08:38 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:08:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693987716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQsFJW/rmJbrYDUykXvzIQ/8e3FNYhD5XlVtRJWM5Kg=;
	b=FEBRc1UY1XN7TDZ4ASAUqF2PEl4NJSQAASSeDvbJQyB+RyBXO1q+epmJLxTVfJF82bXhaK
	Yv+q1rVfr6D1L82ieH1xXPTthjjNfiKkFIywqe/MY/uzAPsjvx0l+KsPOZO6w6cAcuYXt6
	5BMNU6uL3WtEB3YTQiFUSm24UKVc+bX7EWOdn/7BUYKQ7ReOFioxtRQzXOGqNd0z+dh1PF
	Na6kHdjZo0hcSRvsY90LbxyMZnQbULqebnl4Ttu3v6HBtrTG+mPGRI2ktuImOiyn0asxAv
	ESxz72c16MTfUUnl+vX3sMMjrv3xTB3j6rnMbKdlyW3o+XtbWJSSp2GAzHOZwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693987716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQsFJW/rmJbrYDUykXvzIQ/8e3FNYhD5XlVtRJWM5Kg=;
	b=GWP2ke0rDlPZWs/IDkA4AjPQpQu8Ix7Op/D4Uo20Nl1nXSw9rUfHlxDqwcYjZVyeREB/4c
	ANTljK0V295VEfBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
	alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH net v1] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230906080831.k5HXMqlN@linutronix.de>
References: <20230906033926.3663659-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230906033926.3663659-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-06 09:09:26 [+0530], Ratheesh Kannoth wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 8511906cb4e2..5bba1f34e4f6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1082,38 +1070,16 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u1=
6 qidx)
>  static void otx2_pool_refill_task(struct work_struct *work)
>  {
=E2=80=A6
> +	napi_schedule(wrk->napi);

This will delay NAPI until "some random point in the future" for
instance if an interrupt on _this_ CPU fires. You only set the softirq
state and never enforce it here. This works as intended if invoked from
an IRQ but this here a worker/ process context.

You can either put local_bh_disable()/enable() around napi_schedule() or
use it from a timer callback and skip the worker.

Sebastian

