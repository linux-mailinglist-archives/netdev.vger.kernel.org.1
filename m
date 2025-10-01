Return-Path: <netdev+bounces-227419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BAABAEE67
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DC3C755C
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C91DC994;
	Wed,  1 Oct 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7vzc2p3"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C415E5D4
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279168; cv=none; b=M8dKtUY+QwtOw4AmGvLJZxLF3GUQhNxiwFaxVRuQDueHZUhptVJIxEPb45M1QCe9kqJQs5qlCKQW46i6hDJk3LIrEfRGEVcY3ABtSDl2i5ciIOW/S9UooqFnTwlYMIwHJ3DdeEdXzeqHgLMseDH0Bygd3wb+sJXqX23NYjo1IYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279168; c=relaxed/simple;
	bh=7x8PuX5ZgkEIOojjP0Agfrb4/dDCHAcNcZ6fxfaO2Ek=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Sr8iPzQ7iWNesKwQUckuHPOX9aUOIqL5HVw40PmGMBXwelph0Zg7760fRlo52FKuFGdBlgHKSTG1j30PkK0tYf3ZY8XgO+VaoOQoiv1yFUjAAnx5oYnkLq95ZAXpZ9I6ihUQuRhKI5hD3f4+u9cmCqN7JSE17ic5lyj036zQi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7vzc2p3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759279161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oh6xIYBocyRKS7MZ2kUS8uAV1pPqbMFHX1IE0gh13A=;
	b=G7vzc2p3TZIw+Cfe6hp+rahDbSizucGSes4FtedZWdKuH+mC472z6Bb20OY8YAgh4UEcqy
	WXpeHuJKlWEWDEFmS4lpzfjD5v2wXfGSq47R9HOIjHMGjtSFUqLm4TPfGWX27K+TTT2f1V
	AiU0fw5xmWBmC6YG5kqylYTsknRZ2ow=
Date: Wed, 01 Oct 2025 00:39:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <98852ec27b03a4b7a16243e32b616a0189e32165@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] usbnet: Fix using smp_processor_id() in preemptible code
 warnings
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
In-Reply-To: <20250930103018.74d5f85b@kernel.org>
References: <20250930084636.5835-1-qiang.zhang@linux.dev>
 <20250930103018.74d5f85b@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Tue, 30 Sep 2025 16:46:36 +0800 Zqiang wrote:
>=20
>=20>=20
>=20> The usbnet_skb_return() can be invoked in preemptible task-context,
> >  this commit therefore use get_cpu_ptr/put_cpu_ptr() instead of
> >  this_cpu_ptr() to get stats64 pointer.
> >=20
>=20We also call netif_rx() which historically wanted to be in bh context=
.
> I think that disabling bh in usbnet_resume_rx() may be a better idea.


Actually, the netif_rx() will disable bh internally when call from
process context.
but the skb_defer_rx_timestamp() is usually called in the bh or
interrupt context.

Anyway, I will disable bh in usbnet_resume_rx() and resend.


Thanks
Zqiang


> --=20
>=20pw-bot: cr
>

