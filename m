Return-Path: <netdev+bounces-219651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88712B427ED
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DCC563E34
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62472F83D4;
	Wed,  3 Sep 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="il3HqTk8"
X-Original-To: netdev@vger.kernel.org
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04081547C9;
	Wed,  3 Sep 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920297; cv=pass; b=U6QAhImvzTCxowKDxjtk9dc1BRAwRbzFn2TSY/OlWKzMarXsrsAVpnsozGOch0ThINvI1kNa5xaAx/Cd5E2JWP6r4qKhocfD5uy9gl5IHVn0JwV7T3Tf7QhxH0UUW4+ttIsCsMPgsFU9CWN+yWaDau7q6fqlCZk0oAiHtJTGdOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920297; c=relaxed/simple;
	bh=LwUSTfALKG1VVys3qBQY4G6QJCtMUSyQC1+vjXnTy3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK/lni1lLY/gp6pJSvo/+fx0Z+8ZQME/Z8KnZKazDJ0MsEoJcHD+I3hKFhbnvN1PbNxWGlTcm5p4qRSdA3/LcHkQWCxZkoI2/DVYqBRLKdI2RM9LRs99WZLLDWn9tonFLzcTJsvzpKXn/eEWA4cuz/hD45FMAZi4qCdiTsV/DYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=il3HqTk8; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4D740903B21;
	Wed,  3 Sep 2025 17:24:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (trex-blue-0.trex.outbound.svc.cluster.local [100.102.62.95])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D5218904F2D;
	Wed,  3 Sep 2025 17:24:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756920288; a=rsa-sha256;
	cv=none;
	b=yE72xaWcnsnPjyCuTLtc6XTHDseb7aR3Uk2EZBaaO6NUc1sh69EDcow95geLdsQvQjicdi
	EQxKGj4jU361uWRoZi/0BXQrQidwcX6XAS9CYNTPE9tWvacD6OxnnqGURXGQi7cotXtOTR
	yLn86sIKkzaQc5LPI5LciTOhdMecz2m1495KLhK/07mYHvgkk1iYLCeNEAmZWMyKswahiN
	IuBrDm7jMK7GFjjygGx9t5MiHkmtFDkFcKfLug9+jL7TH7RYQfjJ84EWXXacgsfTj9arFd
	1ui3gY3TKalNet6DltqQ51KWiYM481oQLUghgXt4SYdgBdy1OWIAyKx5xnQf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756920288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oxVC+Bd/rKhNc7RxcEhIl/qxpsoIJR8Waw8jEId9/b8=;
	b=356AnktVPnvnRTslEBI6wJCsoEwsvq0yJ42COywn0yjetb4VfSyl5pBXCO3uJqtH/ewXiY
	6I1L9Z3siA0BZuGVX64+HpGFSPSt6rDGuoh0Bs2iGNIqWNeIR9iDzX6O8BZA6/p3l4uLYk
	lpmIX6qFVmM0Cb+DDFqOUqaQf//sHZxBaPWa6v3lrVyi1f4DWeHoOm4LSVIPqux6TcOLUK
	Yhbv20LeU/eCjYWsLZWH+JhTRHc5YmrsB76vbuY56+r1jdg6b3zeeO/5M8MYIgemf5WEQI
	693sJhG8Vv8wLA9tFHmNODgH4RvZ91bFadLthLe11WKtaxTNC2RygtfQVwtV7g==
ARC-Authentication-Results: i=1;
	rspamd-8b9589799-7n25b;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Celery: 61552a3a02cb5d8b_1756920289170_2804699016
X-MC-Loop-Signature: 1756920289170:4194458324
X-MC-Ingress-Time: 1756920289170
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.62.95 (trex/7.1.3);
	Wed, 03 Sep 2025 17:24:49 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4cH8cc0SSRz1j;
	Wed,  3 Sep 2025 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1756920288;
	bh=oxVC+Bd/rKhNc7RxcEhIl/qxpsoIJR8Waw8jEId9/b8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=il3HqTk8io1vPVMF6IElivCy2/9lfEh2J/TpQM2wE0bHa6ZiXdT9qvsA2RstxPzig
	 G8R3bCSlA0rfc5Rq+xWpa8FqJe3akn5ny/FbLsRzvEfnrewD8k/ESUTEPRyw57h1cw
	 ByV7ohUi0jShW/KR+Rjyrt9Vy8ILEUw5cYxbQ3P99B8QRPn6La1etypJBNFmQ/xsUE
	 qfYdK5RNuJBHXqa8SHWb/wab3UXI/TbESwCGTztAOCzj5aQTgFfwlkf92QX0t3sLVu
	 JPk1QbUXzpsNiA54dew+OoKWL81J2s07XRh9IygYwaN1f6MLdacMHg5ByPO4gLemhi
	 HQEPYKX1WBtpg==
Date: Wed, 3 Sep 2025 10:24:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 19/22] cxl: Avoid dax creation for accelerators
Message-ID: <20250903172445.rp6zajnhj6yufrkd@offworld>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-20-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250624141355.269056-20-alejandro.lucero-palau@amd.com>
User-Agent: NeoMutt/20220429

On Tue, 24 Jun 2025, alejandro.lucero-palau@amd.com wrote:

>From: Alejandro Lucero <alucerop@amd.com>
>
>By definition a type2 cxl device will use the host managed memory for
>specific functionality, therefore it should not be available to other
>uses.
>
>Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/region.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 4ca5ade54ad9..e933e4ebed1c 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -3857,6 +3857,13 @@ static int cxl_region_probe(struct device *dev)
> 	if (rc)
> 		return rc;
>
>+	/*
>+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
>+	 * Skip device-dax registration.
>+	 */
>+	if (cxlr->type == CXL_DECODER_DEVMEM)
>+		return 0;
>+
> 	switch (cxlr->mode) {
> 	case CXL_PARTMODE_PMEM:
> 		return devm_cxl_add_pmem_region(cxlr);
>-- 
>2.34.1
>

