Return-Path: <netdev+bounces-64856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB318374FD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21F91C24927
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82E047F47;
	Mon, 22 Jan 2024 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="Rag8BcGu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asGufOFD"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20563D962
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957897; cv=none; b=GKvnmmNGTDQ38bNdJEagpr1C+Zb3ejFSiDPZ+OxNi5W9IM4Ft4wGjGPJzm2k6flTA9NPYZuGmNWCrmryGv4lWIpcHQpCTIhKkC07G6xuN+uiKs3t69XGrznPIuu7/uiKArEWzm7beLC4QeQPToQ71S7GDjNxJwbYyjJaggMTcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957897; c=relaxed/simple;
	bh=vMS6rissTZrcxwOkQBtBKEHXZ3h8/lCg0tQzB6Xluxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN1YtiDtNQgzxwlCHMO7NBtIr2zBhEdTLDqeIpIcOqzhZYgDSh/srOcC7dXUYPnbIPkZWkoE7X7BpOO301Zep3ldilcvHoLCQuyxQw0FayIwqWz7WbDInu8JAA83JDAzGEB7oeJldgsDAFqqzaJO9lY+QEufLirqUTcxOEjHCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch; spf=pass smtp.mailfrom=bernat.ch; dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b=Rag8BcGu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asGufOFD; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernat.ch
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E02205C0126;
	Mon, 22 Jan 2024 16:11:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Jan 2024 16:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1705957894;
	 x=1706044294; bh=1V/n9CLuzsMCccrCqNsPR88hpo4w4EwIoULun1Srh5w=; b=
	Rag8BcGuSecMpnyeykUtXTQff0ePpkeYCC2xCi56Ck/w7OcnfTd9gcQrpmWAhnhX
	riqrKVwOVRoUMTEt/BeVf9Qvvvd4Gdz6tRDXnXvJ1RVyi02BB5AaX6JMvD16m0Cw
	Fc0pIiRjBlv6tumQBe5KD5p6fGdThkYf9dpSUuih/YigU5LT6ZYqUM1tiZelOTRI
	0pVQmeZ2qtSDcXUAyL/Qu1z4hsAGHv3Yj4sJuB4v6PeB7jtT/E4gbIFpbFiAICm+
	jQbC0JkXcMXYjVsj4eQ7+sbhVsakWdPBYpm9K1Ff/VOpjTjVQTPPm4jrNdPTD/+y
	ZCje+mXBG2rUiXBIlqTxJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705957894; x=
	1706044294; bh=1V/n9CLuzsMCccrCqNsPR88hpo4w4EwIoULun1Srh5w=; b=a
	sGufOFDfj6FHtmHAkCJjU6GUpFRNLQmSX8q4KPrZeqkVkzPyNYm08kLE9W6zN0cJ
	hX6vK7SrVplVDfLCX39knI5ubm7TuwZ7aKKg7HguINKDjHK5/eNNYF3+uaQ2vK6L
	QD96KPCd0FVdlSRfjmPSrmSN4OH4+GV4OUGC/PX1yGLF92DNhr0jf37ANUlU6tp3
	7EEkB6Xs0V786H0o0UbYCuWfqe5SLDgD+s9lIR8DsPvkEfqrl0kHjqvWjkIhvqb4
	8TfVSbO9Y4sGroWiswFtZiNFkLJ2D8cJXyN32O38tC5YbfD0bQ8XlwSpfmNZBJ8c
	DmU80oRzY4AaNmlhDnFWA==
X-ME-Sender: <xms:BtquZQlVponlPW_fP0kN3-zQHdTiss20yPu3cdM1-PUjQvew0Emt0w>
    <xme:BtquZf1meoaUfqWFh89p2oglenwLJ-yvgkU2VGpeqPl7_ZHuAAD81P4ww-nJHWN3v
    JHoQ4iq4_nx9cHVi1w>
X-ME-Received: <xmr:BtquZep_QYky6Hxwa9k6IkUwb6MQA7snxaxf7jWfq-feZwTRKQqc5FlfppklqsmX3aumcQNdDI0cKbIYSmR5N_Vyd_oVMNV2WGMfbnfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghi
    nhgtvghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecugg
    ftrfgrthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeu
    leffgfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:BtquZckea2ZLHaSCFa-Ai5UFI3JuO5-GB1vnY44CYYmH2kiF5V7xHw>
    <xmx:BtquZe111MS_GWhnktiIuAN5mAIB06NdLjHIxzvjSZHLcGS7RneKRg>
    <xmx:BtquZTvAy20TVyPbSrPmUpgurWCtAPHLNdEa3iEB4qhd14j61DwyiA>
    <xmx:BtquZTzS1wbCF-3TnUhahV2b7GJTraNvpGAdyB4Eg7hF6aoTMDYe7w>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 16:11:34 -0500 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id 527B12B8;
	Mon, 22 Jan 2024 22:11:32 +0100 (CET)
Message-ID: <d94453e7-a56d-4aa5-8e5f-3d9a590fd968@bernat.ch>
Date: Mon, 22 Jan 2024 22:11:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
To: Ido Schimmel <idosch@idosch.org>, Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder>
Content-Language: en-US, fr
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <Za5eizfgzl5mwt50@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-22 13:24, Ido Schimmel wrote:
> s/flowlab/flowlabel/ in subject
> 
> My understanding is that new features should be targeted at
> iproute2-next. See the README.

You may be more familiar than I am about this, but since the kernel part 
is already in net, it should go to the stable branch of iproute2.

