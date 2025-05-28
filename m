Return-Path: <netdev+bounces-193788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F905AC5EA1
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D9A7A5633
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30F80C02;
	Wed, 28 May 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw/2meI3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB373EA63;
	Wed, 28 May 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748394555; cv=none; b=QZDshWBGGCHZEKdYX/ShfkLCfpOmxAidI2c1EWgCTrpRjO7gZg+wiUNtiUfg99wDv9sF6Hi2uBOkYevIwa6DOr0K6xYhaCM8gAK6KUq7HnBKfjVRp9XKLohwgl3AlGjm6w8RBh+dM/yt+jph8muhX0AeMicvAkEZmjuCXqqnIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748394555; c=relaxed/simple;
	bh=35XjSUZ1CLasS93y/XIvP6USHJ5NBDcHU5gRAqN38EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBAc9ZTUK4Xtf0FTd+DgRa+2/apBU2V5f3tFCDCW3LVmc7CDP7PHj9ETf46ZG8gtsey2+8nroANQy5cmaNXBYoHwK3pqh7cCsngjpZAYXuWwvG7thZ5nPsFK7XkRX9BYBj7SRnM/zj5a79UvUkeJVePQ7Ow28GVSp5N6nIajFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw/2meI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4109DC4CEE9;
	Wed, 28 May 2025 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748394555;
	bh=35XjSUZ1CLasS93y/XIvP6USHJ5NBDcHU5gRAqN38EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tw/2meI3n8e3VUJUR9stBe4zbkS18uBc0q61loxZEZoYGbGhPVOo9ziwx4tDt2Q1Q
	 Yr2i9oxewjuqISg1uP03BYezc+BizdeRsD3UQZkV3bK6Wz9H67GAOmrwFIq889K0An
	 eGLyyKY9WHTMPI1Z5IThRp9ig4bU66CJoi9MSz/JJLQ691E5VkDTCkcismq+zLElv8
	 yfiAilSshr8AVfK0HeaLxj4TWGkHq9iuIRlCZBQbo4CadxiHEiVSUQSCJ6qo1z1zxP
	 Ryos+UJQuwhRqxSLrjfqTB1EW0uKI0OOc5/NJ0vDM9lNYWwc7TntzECIn6srrXhPIq
	 VBYTOzbxL3Cyg==
Date: Tue, 27 May 2025 18:09:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <jiang.kun2@zte.com.cn>
Cc: <horms@kernel.org>, <kuniyu@amazon.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <fan.yu9@zte.com.cn>, <gnaaman@drivenets.com>,
 <he.peilin@zte.com.cn>, <leitao@debian.org>,
 <linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <qiu.yutan@zte.com.cn>,
 <tu.qiang35@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
 <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH linux next v2] net: neigh: use kfree_skb_reason() in
 neigh_resolve_output() and neigh_connected_output()
Message-ID: <20250527180913.4b9f1027@kernel.org>
In-Reply-To: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
References: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 10:14:08 +0800 (CST) jiang.kun2@zte.com.cn wrote:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() used in neigh_resolve_output() and
> neigh_connected_output() with kfree_skb_reason().
> 
> Following new skb drop reason is added:
> /* failed to fill the device hard header */
> SKB_DROP_REASON_NEIGH_HH_FILLFAIL

Looks like this got applied already but can you explain for which
protocol you see these drops? I checked random few and none of them
can fail in ->create().

