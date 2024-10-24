Return-Path: <netdev+bounces-138870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32B9AF424
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A91C20C94
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA219E975;
	Thu, 24 Oct 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JIuU5GPv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMabJBi6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C122B64E
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803465; cv=none; b=hm2dZpbqQtslEUpA1Dbf+Jiw4f3pD1qaRfcXRgRZ7KFjiZ2eXYqejEA8cIbkovCl3azTM1lNnZmgMAn1ZL0I1yVvSIq+AszqunRDZEBbde3ocevbluyjHZ6nz0Az4qedEbeUhD7o9MOnEJpFXUOYyA/50iMgK7YJ6EQVOjL7N80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803465; c=relaxed/simple;
	bh=p5sJzZEyDqSRG1Fs9NjbAB7cR1K1VcW3bQvLFNs9H6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tH84s1oO1UWsSKWsY9OIBfrkNm5UxBajy19DLOxUyqxIbpWekDcBMzvkGMRkgDa7a8MrU3zqERmyy6ZNmCr5wTKGloXONTdREU7UBZM7QZfMVX8QCegMfhH5OfqRmMvfUTCiTrWdGfvw2XWTXqY6y0hNBrIM6BDABPHu8jDGZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JIuU5GPv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMabJBi6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CFCC25400DF;
	Thu, 24 Oct 2024 16:57:42 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 16:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729803461;
	 x=1729889861; bh=p5sJzZEyDqSRG1Fs9NjbAB7cR1K1VcW3bQvLFNs9H6w=; b=
	JIuU5GPvxDRpUiZpzOvGXsKFyVXsBu1FHy8i5MqheFWsGMboQ2HxO/rcNR9l9zQD
	dptLlRCIq+MHmfWscBBEKD1aFuLNHRRTxLMXMB/t7bAJBfhNpKrEZ4bKZh/qGUlU
	hLiTHmp9LpMu+USMEaaSUF3AGnTAhhzUzMULtyygymsgksPS732qo1z38+Ftst9D
	3gzHQtPxU1P3vtWnvdgxuG991ZzveNezl3ZMRPJXFKsp0aovl7qGJdJ1P0AaoMIZ
	UPKChUFJyyGOqVfNMSPHcLiY4oe19R+CiFOOGfJYTyyQkVoP8o5m2TxbLvg4si1U
	wscN4irEmwzPxXhhTo4VkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729803461; x=
	1729889861; bh=p5sJzZEyDqSRG1Fs9NjbAB7cR1K1VcW3bQvLFNs9H6w=; b=E
	MabJBi6dbjv3cJ6DzAOKDxOPYv91+ANRRu6d+nk3c7ySsuo9ZE48YHxIRKmXaaGo
	1L32TbaC3hAcqFQHkFbkBmq7bGxJUe+Yhtjzx46pwewtGeHf81aqcwjOUrKhcj8d
	xCUWo0Mk6xvWKNnopz0KJ2tjxz05+hMPfPHuVOz9wcOtTe4U0tJvhOGvC27iGD9J
	j0bBrPrDHj6Rb96rqfcfDiLptEbNe+GRK06u/Wao5p2qGgGCMDIKDPhD/hrmkXtJ
	pyiWg6aAQH36n/X+lYTn8Hsp/eW5oB4aOwX+gZo0z1jeaHq5WyAMwUwa7bJEuBSl
	qveOCxqRjYVjiYszA398A==
X-ME-Sender: <xms:xbQaZ96VoRYKYFRs7VBrJ8a62pOjT9-3Zlu66d6DxFj2GN1iH7Nliw>
    <xme:xbQaZ65fEMQB3FLCeDKXGgJFnbrwmsE4ZqJD1mbFstwFWMERIBNQxiXq6n1ROoCQx
    J0UUiD04sB0kV1lHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfev
    kfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceoug
    iguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefh
    ieefgfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgs
    pghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlrghorghrrdhshhgrohesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvghnghhlohhnghekrdguohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xbQaZ0dpt0CN3xOdR6hgL1wsmX7XMVDBr10N5H-sO8zZxF_zl1L7DA>
    <xmx:xbQaZ2IJBTvf6NuXAkts-vfUBhCot_VjclKZWcyPu6AhHCyLKMY_iw>
    <xmx:xbQaZxLPLoYHXTHSjItRxlh5Gs859eeZn0Zf9wKaMUYBoYOx4TKIUw>
    <xmx:xbQaZ_zydjHSSmTa-aMV-M4HZtd3SIUev5m7Pxw7yTR9oyJQmBb96g>
    <xmx:xbQaZ2oxKXZdTlZdFgjir51FxUXLLzLjhFVc2sgLjnDQQbLIhoDQv_AD>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47EF118A0065; Thu, 24 Oct 2024 16:57:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 13:57:17 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Yafang Shao" <laoar.shao@gmail.com>,
 "Eric Dumazet" <edumazet@google.com>, "David Miller" <davem@davemloft.net>,
 dsahern@kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "Menglong Dong" <menglong8.dong@gmail.com>
Message-Id: <a4797bfc-73c3-44ca-bda2-8ad232d63d7e@app.fastmail.com>
In-Reply-To: <20241024093742.87681-3-laoar.shao@gmail.com>
References: <20241024093742.87681-1-laoar.shao@gmail.com>
 <20241024093742.87681-3-laoar.shao@gmail.com>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for
 tcp_drop_reason()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Yafang,

On Thu, Oct 24, 2024, at 2:37 AM, Yafang Shao wrote:
> We previously hooked the tcp_drop_reason() function using BPF to monitor
> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> To address this, it would be beneficial to make noinline explicitly for
> tracing.

It looks like kfree_skb() tracepoint has rx_sk field now. Added in
c53795d48ee8 ("net: add rx_sk to trace_kfree_skb").

Between sk and skb, is there enough information to monitor TCP drops?
Or do you need something particular about tcp_drop_reason()?

Thanks,
Daniel

