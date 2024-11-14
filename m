Return-Path: <netdev+bounces-144694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733E9C8354
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215681F23CF9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1441E0E13;
	Thu, 14 Nov 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hXKtTdUZ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A542A9B;
	Thu, 14 Nov 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566944; cv=none; b=P8eg9TT8zyOv97KLj5MfPcHmKo0hrUpUVbieOEqvlDhWEWoUOY4h0HS1nwR5mHGPo9AVSJVMOSYQ3KSqkT5b8FjvocSUefR4B5d5czD7Q5l7bK3TOeZ8BTCFCePuZ/WfSlAk/5gGMNsDgZxTh5JZGkj24yOFkoCYjepnj/rYvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566944; c=relaxed/simple;
	bh=l3pxRJEbk5I8ElPJ0O4bm9PCHLIuDvWhbnu7via+PTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIrCQHosNRRP6YZkXBzyf0Sm1Znlm9rX3hz10G+xHEi4jm9mdqke5hdzpBElAab+uPtbe8hBQ9zP7lWsgfruebyKwBnfgDmK8sQMma6yOJks7tM+dwFbL6znfIQxhMT9glz7npeQlglxcTriDk73lzoSKocNK3aocoHw/f7d7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hXKtTdUZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731566939;
	bh=l3pxRJEbk5I8ElPJ0O4bm9PCHLIuDvWhbnu7via+PTg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hXKtTdUZWdtvVoARYGY0z4X5BhBaa1m7gSu2BuHL/YfXE4mAZNPHgi68MQPTgU+n4
	 EIAJzb49mfBOZSz99mpl7lq8iMrSFfF7WH7BeVmV5kwoKNNHHSWP6iMN1mLM8E69jW
	 6cLZ4rL60jmO+UBllKClkXZHKf9Vtn+EJ4Kroz5lK7+A/QIxjG79q+3ROgE5cgd4g+
	 WzqEvBOXy1JDUaYbvnhZxyed/IOsfnc2YhQ8qlly0Q8mjWPdQ24L1W6a1d1Ao+Y2/b
	 /+TmptzT1Qla3wbdIsTpimhBxyAJz2WquN809zvCiLNNdPOuP7zttYaFXzUKglA5kY
	 /TImNCLqxcafA==
Received: from [172.16.160.229] (static-98.141.255.49.in-addr.VOCUS.net.au [49.255.141.98])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9A08966801;
	Thu, 14 Nov 2024 14:48:57 +0800 (AWST)
Message-ID: <42761fa6276dcfc64f961d25ff7a46b764d35851.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jian Zhang <zhangjian.3032@bytedance.com>, netdev@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Matt Johnston <matt@codeconstruct.com.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,  open list <linux-kernel@vger.kernel.org>
Date: Thu, 14 Nov 2024 14:48:57 +0800
In-Reply-To: <20241113191909.10cf495e@kernel.org>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
	 <20241113190920.0ceaddf2@kernel.org>
	 <da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
	 <20241113191909.10cf495e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,


> routing isn't really my forte, TBH, what eats the error so that it
> doesn't come out of mctp_local_output() ? Do you use qdiscs on top
> of the MCTP devices?

There are no qdiscs involved at this stage, as we need to preserve
packet ordering in most cases. The route output functions will end up
in a dev_queue_xmit, so any tx error would have been decoupled from the
route output at that stage.

I'm happy to do the exploring myself if you don't have strong opinions
on an implementation.

Cheers,


Jeremy


