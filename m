Return-Path: <netdev+bounces-249655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59AD1BED1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB06430581D6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516729A9FA;
	Wed, 14 Jan 2026 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plMj6BHK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6242882A7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353837; cv=none; b=Mg/Jmw9cjqJVNxhBwiNP7zQpZYPv/uowwHv1JdIqB9JH2zvWHVWadS7sB04OgAWWqc6nRdVe0e1OiiqrCQIVT8cxUoIb1WX1TFzfmelips1PHhvrfeHLvYyR42m1ercyPL5eBRJLSQ6v1I8x6I0RFYUzX4rtygpjv7qSPPtBu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353837; c=relaxed/simple;
	bh=08AbPmp+yk9h9epQkxCWty5lGK6QIZCQ+b/1tnOcYOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhjySnfAeH6GThG012BDpZV6rYypk0bSptC8DcOvJO2UnF7dJtff/1/oA1bshSD6C9YNk9f3kvGoAqMklITe10usjj/6rOz7pD7Z6vfYH/mVrbaxEodav9g+YNMq8o2bdmqxUX2c8RNU/7NAaLkqgJepLt2ykLhyfcVgME1frJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plMj6BHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF822C19423;
	Wed, 14 Jan 2026 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768353836;
	bh=08AbPmp+yk9h9epQkxCWty5lGK6QIZCQ+b/1tnOcYOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plMj6BHK5Pg4Vf2rrv4/YCH05K4QqpsqKbIpHhlJOthwaf5g1SyAJNO6ti1JMylMb
	 xX3HAeMwkM9HCpbJGK6l8fOwIwq7yeGU0FeYUXyuEhQ1TTJ56hdRNY/rDP6KX/yg4w
	 8vORUC96QJFl8Esjo/3xPIXE5gQzOXJXR0vQGuvY3pI1OzmK2PaddeYa2R1D4OMWUw
	 BJHGMq0hBAuhNtWi5BaPNsEkQamJFLQLvJuW6otCljBJGj+ZDnmeIs4idjWdMPIujS
	 IhuB0dwGd7VsSefO8gKsUSjGsnGUmCUG3Sql3tnLALpgJcg97Jw4XMoDdLHMnUfEG7
	 7K1Es9960quvA==
Date: Tue, 13 Jan 2026 17:23:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Dong Yibo <dong100@mucse.com>, Dust Li
 <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v19 2/6] eea: introduce ring and descriptor
 structures
Message-ID: <20260113172353.2ae6ef81@kernel.org>
In-Reply-To: <20260113011856.65346-3-xuanzhuo@linux.alibaba.com>
References: <20260113011856.65346-1-xuanzhuo@linux.alibaba.com>
	<20260113011856.65346-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 09:18:52 +0800 Xuan Zhuo wrote:
> +void ering_irq_unactive(struct eea_ring *ering)
> +{
> +	union {
> +		u64 data;
> +		struct eea_db db;
> +	} val;
> +
> +	if (ering->mask == EEA_IRQ_MASK)
> +		return;
> +
> +	ering->mask = EEA_IRQ_MASK;
> +
> +	val.db.kick_flags = EEA_IRQ_MASK;
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +}

AI code review points out that this is writing out a partially
initialized structure. You're only setting kick_flags, so 1byte
and the other 7 bytes are whatever was there before on the stack.
This needs to be fixed.

In general we recommend using FIELD_PREP()-family of macros to encode
bitfields.
-- 
pw-bot: cr

