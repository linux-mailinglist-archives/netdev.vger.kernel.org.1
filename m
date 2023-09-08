Return-Path: <netdev+bounces-32555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DAD798640
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0559E1C20C0D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0E2108;
	Fri,  8 Sep 2023 11:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49C3D74
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:02:19 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2513A11B;
	Fri,  8 Sep 2023 04:02:18 -0700 (PDT)
Date: Fri, 8 Sep 2023 13:02:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694170935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+LAvGWnlgALt4uSfxPrpnW9XB5xanSlh3Wm88mPH1M=;
	b=bAw9ZvUBN6TeWE5b7Ji/AFYwnDD88klJUTWzSxQs0ExFegHbRJcw1wkw1C6qp9zKG/YaHD
	XAT3B5I7/cXyMjjYiUVleTTHVESocpNYXrCH8eP3dqekoP6OSDhAiKzig/WfdV1jfJKzef
	Cugeo90WsIsy58dU1kpyH/KIjcoFVaXTHpdJczFhxq4NyET7Q/6jEwncMlAO7Jt6aACJZz
	qEFAj8SvHLwN5dBGwFksRR8b+skXyOwNPnrrMRSij+DEovmL7XilknszzqWlqDmFIHEQuR
	GeoTP7XxnxrZjfKvm5/fnhTYksJQAnnNWGc19QHZmjdz6jaJWtKUR7B2gVVbIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694170935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+LAvGWnlgALt4uSfxPrpnW9XB5xanSlh3Wm88mPH1M=;
	b=r7pLo9/FiDxztwP8QDcDQnFy8BsJHgbTJQUDkUm1crfEcI/ToTE96VFxffihWprdLGJBUQ
	tn51hIsQ0cU+FSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
	alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230908110212.wmeihrv9@linutronix.de>
References: <20230908025309.45096-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908025309.45096-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-08 08:23:09 [+0530], Ratheesh Kannoth wrote:
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

You keep loosing these :)

Sebastian

