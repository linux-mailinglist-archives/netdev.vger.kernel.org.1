Return-Path: <netdev+bounces-286108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEgwKLvQ/mn3wgAAu9opvQ
	(envelope-from <netdev+bounces-286108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF944FE367
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB04F30087FC
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7E37F8AD;
	Sat,  9 May 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VgcOa4s8"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5B37B019
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307256; cv=none; b=ADWkfOoV8+q/MMoNjFYWzWnWAeOu5cqbwemgWsWCkhmLecRDtyg5uwpfheirgFVFDnkx6Z9d7XvUKN/7gX7X11An+M+Xr7NM0hUJ3mIWfsT0x9ls2EK11KJmMgHotefX6EycPUZsZMjprMBkGfQPFgDRL0QZVMpmTRVpqw4iq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307256; c=relaxed/simple;
	bh=gtkpfcCwkByjYlS2K4GkRbbgvbNfOoIU302Rit6L/T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLaaeRv/jFKgTKLpRriSxA3r1GY2RFR7IJjXP/2gKQhI1MGuk73DLl2mypBdzf3M0rhmcg7jX3/vWkk+yoi9hiyjpiq5jkjcbAPfv1LaQymLrP+ySgyL8oIpY7gBlfukZPaYRcdgMd0gFqaLy1gRe7R5iLkW+QiFCr2T1F4ZmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VgcOa4s8; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778307250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vtxIsiljOlnpwK25ZIpoLjkqO0ism5mQrARswMyOac=;
	b=VgcOa4s80fQfWC3hOzcuUsuwiX9z+RaS9Kc56TUuq7PimCVLGc/gGaSjfxyjqCSTBuKdMj
	tjsYTfFgb+G+b+h9knt5o1WUchmDMXzXOePm7f/+e/g6+T2oeCBEqoC35jmcIfNi7rhKWn
	XRDvF9IzEMqMzfJzhbZ9B6aahnOzpIM=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: gregkh@linuxfoundation.org,
	imv4bel@gmail.com,
	h3xrabbit@gmail.com,
	steffen.klassert@secunet.com,
	benh@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH v5.15.205] ipv4: set SKBFL_SHARED_FRAG in the right skb field
Date: Sat,  9 May 2026 14:13:50 +0800
Message-ID: <20260509061351.421344-1-qingfang.deng@linux.dev>
In-Reply-To: <20260509053751.45007-1-zhoufeng.zf@bytedance.com>
References: <20260509053751.45007-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: EEF944FE367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,secunet.com,debian.org,vger.kernel.org,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286108-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email]
X-Rspamd-Action: no action

On Sat, 9 May 2026 at 13:37:51 +0800, Feng Zhou wrote:
> 
> commit ab8b995323e5237041472d07e5055f5f7dcdf15b
> ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> backported the shared frag marking to ip_append_page(), but it writes
> SKBFL_SHARED_FRAG to skb_shinfo(skb)->tx_flags.
> 
> SKBFL_SHARED_FRAG is a skb_shared_info::flags bit, so storing it in
> skb_shinfo(skb)->tx_flags does not mark the skb as carrying shared
> frags for later consumers.
> 
> Set the bit in skb_shinfo(skb)->flags instead. This makes the
> backport actually tag spliced UDP pages as shared and restores the
> protection intended for the ESP-in-UDP path.
> 
> Fixes: ab8b995323e5237041472d07e5055f5f7dcdf15b ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>

Duplicate of commit fe785bb3a809.

FYI, stable patches should be sent to stable@vger.kernel.org.

Regards,
Qingfang

