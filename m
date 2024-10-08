Return-Path: <netdev+bounces-132996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD09942DF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB72829D8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A741D1302;
	Tue,  8 Oct 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgGd9qBK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2B1422A8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376652; cv=none; b=r7ShgpavRSq7kw6U76BSJ3PmHG+/DGpjKoyLcO6asGhhwz5RcBTZvwsh89BDq5MPyyn25PbQxFjJ//3qmphwAAAjIaZfeNIVOoEbNmuS3KbyTjXWexmBAfkz3DwpRXk7iPcnZsRvSUVHWEAMqEXgC5kghLajBK9fxs0T/0Gro0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376652; c=relaxed/simple;
	bh=9JBSPHkY58XwNar2BQD8o09VbLgjPF1fqhDYp4BPo8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3qaAd80MS5gHOWxKoQFINe1mUHhUSDmEjqSWuowEdRwjeEOywOzTX/OoB0syItPlBFPPgm5c2sAU44l4KpjABe+p48a0jPBCD5JCSQTR2rC9Jur0AyQi8xXoG+dfphB9rPlAK25fJfkPQ3iknVqg3DqGcycYMZzp4UFJXhmUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgGd9qBK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F02A113806E8;
	Tue,  8 Oct 2024 04:37:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 08 Oct 2024 04:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728376649; x=1728463049; bh=SQcRkKwMZGHAl5vGVD0tl8fitMw0
	31RATVA4E87/FCA=; b=WgGd9qBK07rhf5uOfbnrDBgYhv06AgWd4HnoJHL1hGcn
	n2ZrpVjoBexLBYQCnBXJCSLDGq0JpTFB2zPJVOwy3bzUM43mk6Q5a5u2+l7TS1Yc
	8N8t8GYU5bljeecYu+nOKbPftv7/NpegbVwiFO+MBD/CMI12VxkO63+Ax8c/aUK3
	VpIGdZzAST7TIzqQ5PhWhhdFakzF5crcd2VQZ/MvNrE8LXExncLtWGenk3Komv0N
	Xwkqci7bAjyYTTq3tMRlo5aVWbioSdmSNf9+R78aecXFSyj1tsT2uKX4adcmBE92
	fOcZgwwnGXUEqKv48ynRNyzPemjufMD1jZ1UqFfznQ==
X-ME-Sender: <xms:Se8EZ65BhYTxJgV5TOeh_CnjwJILOSRcuWxbKHeTX8wzYq-qlhcTPw>
    <xme:Se8EZz5nHd66EAvkVTbZhgxFUTNoy-utgqEVFyidLREDjvFyLY-iPste808pT99Vx
    FAGvLq3CjNf_bQ>
X-ME-Received: <xmr:Se8EZ5cBz-U1WVIvp88eVMLpVtBuPPcEwAjiBtO56n0FaUfKJX94lJU6kH0t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhnrghulhhtsehrvgguhh
    grthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhl
    lhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Se8EZ3LDqIJ2Fvl6F41ScBdrmBRdAZfLV0CwV0pG5gMwat5mPXCRgg>
    <xmx:Se8EZ-Jnz4YbLUepbTTGbrYHXaYB6S_rxjeqL2SGU2R2JyyMEz4E1Q>
    <xmx:Se8EZ4zj4v6Vo01L4bJzXZe4OLC9hoEVKMJWd5opSPyr85_DZv1xow>
    <xmx:Se8EZyI8uP5jpxk0I5hLYJ10DFslMVzlU6jr1Z4j3sQe2_0yMSL3vQ>
    <xmx:Se8EZ_o8x5oS-aqhKThqUyXoyCcOtDtakiillyLuzW4NRfCCO7nrw8Bg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 04:37:28 -0400 (EDT)
Date: Tue, 8 Oct 2024 11:37:25 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 0/7] ipv4: Convert __fib_validate_source() and
 its callers to dscp_t.
Message-ID: <ZwTvRR9_OX-Nq_Pj@shredder.mtl.com>
References: <cover.1728302212.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>

On Mon, Oct 07, 2024 at 08:24:23PM +0200, Guillaume Nault wrote:
> This patch series continues to prepare users of ->flowi4_tos to a
> future conversion of this field (__u8 to dscp_t). This time, we convert
> __fib_validate_source() and its call chain.
> 
> The objective is to eventually make all users of ->flowi4_tos use a
> dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
> regressions where ECN bits are erroneously interpreted as DSCP bits.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

