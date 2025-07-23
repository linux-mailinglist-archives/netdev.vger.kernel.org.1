Return-Path: <netdev+bounces-209263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3CB0ED8D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE01E3B72FA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7F277CA2;
	Wed, 23 Jul 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P2N0KK0k"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931027990C;
	Wed, 23 Jul 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260316; cv=none; b=sTei9Ku1e/REBpuLRgUY48WVnkBsowu0S6DRWY3zmxRgn/o2zYhcs4YhaMBGt9MCui+JQMAv22uB11nn6RlhKr1XzeMyBHFtfAAfP00D6j0n32EyGqXFF8fjeIKtNW30MGIn3565qoXOY9DZKQJvC+Enymt3tbxxtQ2WiJI80rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260316; c=relaxed/simple;
	bh=juf9ggKeJ2S2DwzYU3ii5rklPp81WUO8OyahSzXouI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxilhc1gffzxuq2vxNKDY+5c+sxWRQiWUEeutY8ah/iXRKcBKqH7IoScoTysLOVBYVrPysj/sI/xtY07ubj8Ws473q8eeh5e3ou27JrLZyWzFoLiijSlyeeI01BtjWuH9Wn0VPm1YLZaOrDVgxYIxKr1/H7A0MK97yra5ddy2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P2N0KK0k; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Kh7Twf/JLXX4QIJ0YUBvAzwYRNxCP5KMdOZH9O0+eaE=;
	b=P2N0KK0kD5hNE+SeqIdEGVe+vH1facgRuAGOOLRwo3b9i4eGRnZ6xyhW8JT22d
	CxARBh7V13P02rGoBoZ9rJwPWCCNwXCzYvisDFL/lqOPiRRH0K7cYKEe7VMF3EKV
	ToubNpvVG4NPTSdUrG6gmmZFb2nohMTLKtcir/ixPYKr8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3MS8IoYBoqoVeGw--.4006S2;
	Wed, 23 Jul 2025 16:44:56 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of MII
Date: Wed, 23 Jul 2025 16:44:56 +0800
Message-Id: <20250723084456.1507563-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6373678e-d827-4cf7-a98f-e66bda238315@suse.com>
References: <6373678e-d827-4cf7-a98f-e66bda238315@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3MS8IoYBoqoVeGw--.4006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18uw1fAr1xWF48CFWfZrb_yoW8GF18pF
	WFgFWUK3Wqqr4xJr4kZw4UWFyFvw1xXrW8GF1rCryUCF4akF9xWr18KFW5CFy0grZ5Cw4a
	qF4UX3Z5Cayqv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyYLkUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzReT22iAiItzUQABsa

On Wed, 23 Jul 2025 09:17:02 +0200 Oliver <oneukum@suse.com> wrote:
>
> On 23.07.25 03:29, yicongsrfy@163.com wrote:
>
> >  From these two tests, we can conclude that both full-duplex
> > and half-duplex modes are supported — the problem is simply
> > that the duplex status cannot be retrieved in the absence of
> > MII support.
>
> Sort of. You are asking a generic driver to apply a concept
> from ethernet. It cannot. Ethernet even if it is half-duplex
> is very much symmetrical in speed. Cable modems do not, just
> to give an example.
>
> I think we need to centralize the reaction to stuff that is not ethernet.

Thanks!

I think I understand what you mean now.
You're suggesting to create a unified interface or
framework to retrieve the duplex status of all CDC
protocol-supported devices?
This seems like a rather big undertaking, and one of the key
reasons is that the CDC protocol itself does not define anything
related to duplex status — unlike the 802.3 standard, which
clearly defines how to obtain this information via MDIO.

Coming back to the issue described in this patch,
usbnet_get_link_ksettings_internal is currently only used in
cdc_ether.c and cdc_ncm.c as a callback for ethtool.
Can we assume that this part only concerns Ethernet devices
(and that, at least for now, none of the existing devices can
retrieve the duplex status through this interface)?


