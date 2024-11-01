Return-Path: <netdev+bounces-141130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B029B9AE6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2486281FB7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369941E766E;
	Fri,  1 Nov 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H3KRwMeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bs1Jzz+G"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D849156C72;
	Fri,  1 Nov 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730500931; cv=none; b=ED6Z/5znNQOk/MIOU2W0j3jDBAmUkEvZvhNgf12+Ntidx0Kgk37FTNeJGUQC0Yo4GxBDLhoeSLqM3EVQe5WdAImHFioSm2U4XO1wY6+LnZCGTavyFFfBQItZcQeXPUmPF3z0P0xWm0221NdAxahnXzNeXnWqiGIJXKnjxMyLXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730500931; c=relaxed/simple;
	bh=iSc6JQFoKMhO+827v4A9jyVHRHhtQlFdqUNalc6pxFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6cZyh3EUpC1EzUhAqt3E1u3KiSmBJFLL+3BykP1ut0MFZANbjwKAPpxwwoshE7IgcPs9OzNXMHzaNz4JwR2r5/iN/a1zWIH86y6upTxXBoCKKhSRoqsr+BiAoYndzFeoXcP1hyDImptqaxpDbf6Ms87Yz9SaZR2KIOxsb1cC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=H3KRwMeW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bs1Jzz+G; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86DCA1140151;
	Fri,  1 Nov 2024 18:42:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 01 Nov 2024 18:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730500927;
	 x=1730587327; bh=jkbaR9YdJ9L6NoJMxPNgQubzM5Uxet+B+2J30gs87NA=; b=
	H3KRwMeWCD9xIdL4uYnO/vXqhTLAh7+S67BQIIjwEq+vwbVKqXC907cetmKawGd4
	/iISzXLSoI7rzM7BnyxoT4LK78oMlM+dtf+ktlyus7bBiYbfrmd1mlTD9RwYAAha
	HO/nelVv0c3QZhF4mjWM05foAKiViZdHln5CEBWcL2iUHzt1AHxEcvAQcBhneX+x
	FMj9q8t8iZh/H4y1i7MhGPUXYnOC+5x1XfOfkSpEq3EtQo0/hUAWYignX9pvwMQH
	Bw8cKUvDOp+CTq2RacQ2HdYV/JZQP95iJepLVp+3x2uKumJeT1XMC4d4crKVE/fW
	Xu5SFGMRD4VjQFiCXQ7L3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730500927; x=
	1730587327; bh=jkbaR9YdJ9L6NoJMxPNgQubzM5Uxet+B+2J30gs87NA=; b=b
	s1Jzz+GURrU4TQ3DPcKMvB8JWbNOChQeDB2SDqp5d8KcCoL+dD4owEA6LPJt0e/b
	VV7fXTd5SxIkeTl6pS5XGGFciAN1wrBeoWu+Yjnn1l2MNz9Pi6/sJfSzo2Sm1HAP
	MSFjQRpV1T5gr3ls+w5IoiMI42O1KIltrpfmk8Eh/DWXWkVmhMcUJzO0vrnnXOTx
	qB9fz7wFn3ut2UabiLgQbFxjFgPas32wuc60ij5BrMnsNIK/4b7ppv1jP1D08r8o
	11DKsxCFwuW3RSfLDipItAsNFxvVlfRMZ69Jcbet2UR1OcTqdEiCFxY8bkWgZvaK
	wwbjrrfpB7xbPFW+2g6WQ==
X-ME-Sender: <xms:PlklZ8Es5AdP8why7corx-AEFUTnfRxN0gyEn_RsG44-aSMl7qSj3g>
    <xme:PlklZ1WQPkTHJTsVcy8GRtyng7rvssXQoVQpBJg0sBiI5-O-xKgFw8qRObcNfNiut
    A3u0Y29jrkXeH04qw>
X-ME-Received: <xmr:PlklZ2IqDAC0zE243PNr4pExVbcgCZLYH6zPELav_97sIHP7szu-GkLcFx_K8dajj4xd7fXRL0JZ8iAISaC4j0E7hNyzvpNsTv429TlGOYiO_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeff
    leetkeekkeeggeffvedtvdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrggvlh
    drtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhkrghsrdhguh
    hpthgrsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegrnhgurhgvfidrghhoshhp
    ohgurghrvghksegsrhhorggutghomhdrtghomhdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggu
    tghomhdrtghomh
X-ME-Proxy: <xmx:PlklZ-GDfUb4BjVrtVL7F8SUE4jknBeQJrqxX-PMR2Eg2LNWwVAtYA>
    <xmx:PlklZyURnbX3cdXWOzfZ8yWuVVlJmPjtFmkoI_ttzUdNvOmoTw73ig>
    <xmx:PlklZxMnStZ0B6DKW11qBRihq0IxN2tAtbFrMyM8qSMaKViCVvaN5A>
    <xmx:PlklZ51Gz86dyHKcbyLJ9A1LAp8U5V25BF-zn5l-ekiUPJNW2Ff5Iw>
    <xmx:P1klZ7WeIR2x_W1371h61YeKBXsyADNmbzGSzAuj052PpIZZ3W7KFrEI>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 18:42:05 -0400 (EDT)
Date: Fri, 1 Nov 2024 16:42:03 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	kuba@kernel.org, vikas.gupta@broadcom.com, andrew.gospodarek@broadcom.com, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
Message-ID: <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
References: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
 <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com>

Hi Michael,

Thanks for taking a look.

On Fri, Nov 01, 2024 at 12:20:44PM GMT, Michael Chan wrote:
> On Thu, Oct 31, 2024 at 9:59 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Previously, trying to insert an ip or ip6 only rule would get rejected
> > with -EOPNOTSUPP. For example, the following would fail:
> >
> >     ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
> >
> > The reason was that all the l4proto validation was being run despite the
> > l4proto mask being set to 0x0.  Fix by only running l4proto validation
> > when mask is set.
> >
> > Fixes: 9ba0e56199e3 ("bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP")
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> Thanks for the patch.  I think the original author Vikas intended the
> user to do this for ip only filters:
> 
> ethtool -N eth0 flow-type ip6 dst-ip $IP6 l4_proto 0xff context 1
> 
> But your patch makes sense and simplifies the usage for the user.  I
> just need to check that FW can accept 0 for the ip_protocol field to
> mean wildcard when it receives the FW message to create the filter.
> 
> I will reply when I get the answer from the FW team.  If FW requires
> 0xff, then we just need to make a small change to your patch.

FWIW at least my HW/FW seems to behave correctly with my patch. I did
some quick tracing last night w/ a UDP traffic generator running to
confirm redirection occurs.

I tested on:

    driver: bnxt_en
    version: 6.9.5-<redacted>
    firmware-version: 229.0.154.1/pkg 229.1.123.1
    expansion-rom-version:
    bus-info: 0000:01:00.0
    supports-statistics: yes
    supports-test: yes
    supports-eeprom-access: yes
    supports-register-dump: yes
    supports-priv-flags: no

By the way, I noticed after I sent this patch that the get codepath
needs to be correspondingly updated. I will send a v2 with it.

Thanks,
Daniel

