Return-Path: <netdev+bounces-249811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC135D1E62D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC9C303CF71
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1461393DCA;
	Wed, 14 Jan 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CnsbC/NP"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524A3803C9
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389965; cv=none; b=jsZd4rZaAigGP/ZARHwbQD5oiSlA9gBTynxyGrD29024qUX6ILARltF6XZeWTZklVigokUV6uWBGf1eugnqZqaB4vNpso8V+FZLpqUnGr+yqpH53ESe2wxnHNDyQ9BmzjuoOU7Boh559bTTBVLwnubCFPqfysnMrc97hJam2e/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389965; c=relaxed/simple;
	bh=A0RpFqbVl71pv3ZuurKlZLyRiWsdbVEuzs/fhSab3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/HUEejjATlVK2phsfFZMla9GD7TvuwAxa2K+TpNAYrRK2W6c5jCBhvgQqxEkP0R2K5hgJSt+FjpDg1xEUe0+jfcoZf9uPcIIV00/Xr+k5yXYuTCbi5/j68IPu1xHFc+V2EPPgXqtQeW8XkqwRGu1GWHs/zONPO41HmtrZxKVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CnsbC/NP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <625082b4-96f0-4c24-9f2d-f88500351dad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768389961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cukmrp0C0gPI66v5wsrL81EGyRSKzJcXXMhBvLN24g8=;
	b=CnsbC/NPKfvGJbJllDgBMdv2n6m6theJyd6N68rqrkfUT8SFtpxphK0h534TLDcAXt8wIi
	j+kFpeV8OX84UfnTLBpkPqmbEEonxetdKkspsQXVQQPGW88WKMkVlM7i+xQGPFYpP25Pmu
	7fq+/g/aKAoj3b98wmtIDmKRUwx5+ZA=
Date: Wed, 14 Jan 2026 11:25:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] xgbe: Use netlink extack to report errors to
 ethtool
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com,
 Vishal Badole <Vishal.Badole@amd.com>
References: <20260114042927.1745503-1-Raju.Rangoju@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260114042927.1745503-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/01/2026 04:29, Raju Rangoju wrote:
> From: Vishal Badole <Vishal.Badole@amd.com>
> 
> Upgrade XGBE driver to report errors via netlink extack instead
> of netdev_error so ethtool userspace can be aware of failures.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> Changes since v1:
>   - Remove \n at the end of the extack string
>   - Don't use _FMT if there's no formatting going on

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

