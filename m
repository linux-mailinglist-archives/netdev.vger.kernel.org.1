Return-Path: <netdev+bounces-102621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F6903FBC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9C61F2614D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897518E1E;
	Tue, 11 Jun 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRFMNOCB"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EE20DC8
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118389; cv=none; b=G/FeHlwXCDuUtsmsrzRq9N4a3RufMbUX5MnLFF6VQ+UUiknCUhGM87xf+Ca9uOqK+IavARzRTYyGg8nlr1ArytVFpK1TBCg+ON/K4jv1ZznboH7YgIOMuNWpTSac43Zv9MQHJLD7FXhmn4vd4ZqfF1VYHZXIRBHw1cwC8RACbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118389; c=relaxed/simple;
	bh=nOt5urHZ6YolUIcMwNLT/hdMPG5CeiZgEvDlqVxEjdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZw1BOH/ZyUiTJK2V8gGPAOHwBGkKE0VKegKfSH5EmR3KA+zRi2gik7x+gLV/EfydEnpytEvL7kry7lm2Wv9FZn4gIfw2zyxREwv+LiNGFZ9CXfplm4/kGQ7L/8Q3NE3ZKRL/KNKPgOVSkL1hue2CxsM9byj0D1fEQXzxSdDM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRFMNOCB; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrew@lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718118385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0aa0B8ChIF+mHezAp/R9HTe7kWW9pZH2yyyhrXiFF0=;
	b=FRFMNOCBURkGgNiRwdQjskn6JC0c3uRW0W52Sszed5ab4rK3EMuOb2lX1zLJw+gZ4/f4Oi
	WblrkxY5Q8yAx838JJ5gvifUL1VI54QrRA7IXFlHRSNoprkWuE5BgRyNftiNJgx6drVdyo
	tTtzOHtRFOCKwwI7UOuEiy5939UO/g0=
X-Envelope-To: radhey.shyam.pandey@amd.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
Message-ID: <68c47426-f459-4b83-9cf9-b38cd9d65a94@linux.dev>
Date: Tue, 11 Jun 2024 11:06:19 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: xilinx: axienet: Use NL_SET_ERR_MSG
 instead of netdev_err
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-2-sean.anderson@linux.dev>
 <42fff229-ee8c-4738-854b-6093f254408f@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <42fff229-ee8c-4738-854b-6093f254408f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/24 19:49, Andrew Lunn wrote:
> On Mon, Jun 10, 2024 at 07:10:20PM -0400, Sean Anderson wrote:
>> This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
>> the message is returned to the user and to avoid polluting the kernel
>> logs.
> 
> This has nothing to do with statistics. So it would be better to post
> it as a standalone patch. It is the sort of trivial patch that should
> get merged quickly.

I included it in the series since patch 3 touches lines near it. But
upon reviewing that patch, it seems that these lines are not in that
patch's context. So I will resumbit this separately.

> I would also comment about the change from EFAULT to EBUSY in the
> commit message.

OK.

--Sean

