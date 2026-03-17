Return-Path: <netdev+bounces-268499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PLBMOkduWmbrQEAu9opvQ
	(envelope-from <netdev+bounces-268499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28C2A6998
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5CB53053F1C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A636EA93;
	Tue, 17 Mar 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TEGwqO50";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqtKTrB2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CED35B62F;
	Tue, 17 Mar 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739177; cv=none; b=KKXOencYyjnAdffkL43jQDszBmUT4DhzT1kJWsiH1dpEjVUYXM1FKUz1gfdsILWXHqqGQ9VvrVWv71/wjw98OdBMkuakKvn8DDb2Mndf4cpjf/7FEwotdSrJ0xGqhGDd37pSo2aKliRXowBpAXeyJnUWw279aTQqkSMKfq2jpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739177; c=relaxed/simple;
	bh=OyOWpIYAg37ljOOCQd/vHb4rHlLIRmAfgms8yuzkksU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfPNLHfqZcOjAOqDMl3YhpKJS0qcy9gxEC3RNxA50QbAOeL0sw8G7de9y7iyrzYmoibnwv0zcrflXI3aUT8P4YNoSM/GBKu3XYOfMUcmAawJ0DeTl+WKhQz91VUYCvfhWDNMonJsbOJaGhX/Onq/iHQnJgJ8TEp/vk73TxeOPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TEGwqO50; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqtKTrB2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C30D1D00144;
	Tue, 17 Mar 2026 05:19:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 05:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773739170; x=
	1773825570; bh=mxpAyC1s7/VO7u79kIstiYH59Ic5wP4Xx6EiPC23nvs=; b=T
	EGwqO50SMtz9UyggQ52u8YvsBX7yzsbhhh5DTWTA2zP+ARSRgtQF5yMZ17Z9tajz
	sBPNsIgmcn1+b2MwmOw9GlPEzi1uYVJqaN9ERw13lAkt7VGkSxjbTmKpv55xHlYX
	Vk/omvB/Rgg8AvB8X3gUsQij0Zm5mS6ER3f9ZBQU6fwhM2RXWX73koke+wwe3Lwq
	F+HkqgXGrZrcamB3EOhM+u3qYMwAMhErnZ8iIAv+5J+VrYB+A/nw00KW0NhZee31
	6OTykKi0WAkiw/56WgWvnwU+g+bBKMRbMigOeaDitlmWzRSl82cvpheNTvoJkJo+
	ul/kQwpy2DNJtA94qz18Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773739170; x=1773825570; bh=mxpAyC1s7/VO7u79kIstiYH59Ic5wP4Xx6E
	iPC23nvs=; b=pqtKTrB2XSyR/rYthSoZw1JQ8J28pcLV1vmG/RTHo5oYJzoWcVm
	b2i5OWJESUR7ytmtRUE00THEg4qqHmUX+mxzwz+jQKgZqGrovPeCNXrqAmHTmfaO
	rBl1c54NWAE5DndmKBTkXz+v9dRtRmihGKOCo7Pmw0ANvwyev8DYikIahhwz3qP6
	PGyeKCCFI1ESL9/QlIZA2oN1f4AyihTUwPMQkauDLRMHzfZxxOprYoOW4Z6549BQ
	cqXLnvO0Vei+uGx7r5ztSppos0Cb3TJWx7s8AwUrT+TQKR0fVGUWSPfEhh5z0DqO
	u99QQn8YMdMadOcV05qBmz/D3ZZAn5P5z6A==
X-ME-Sender: <xms:oRy5aZJLMGALHEU0PXuFBca-kCszg21I8-FhGL1vxgCXqT8sWautnw>
    <xme:oRy5aRcjj0xNEJxPMiom2eQSuFQRYHxH6u0geKVTfWmCA-QP8ZLy0UqwOa_QqMRmi
    ml9f4-8Le3fr-4aH_Gynavqv2b14aFV3qG_mJzmaH11OXkCb8lCLb4>
X-ME-Received: <xmr:oRy5aTU9ojeMG5U21JkI2w2voBL8Pu2U8EERYwzzvZ-Zo_CB7iiaIl45lOuF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhlfhhrvggurdhmrghllhgrfigrseifuggtrdgtohhmpdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughlvghmohgrlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oRy5aXhsMh_C4C6O2OHrvx5B4nS42vvuqxMWcuI7k-41_Kz-Bi1oHQ>
    <xmx:oRy5aVibbWeh0kI7O8_xJ1gHSK4QvCimMxkoHRkR9ag-4T2lqD8P0w>
    <xmx:oRy5aUsNAivdeU3hTtKobJe7-EOxtNwG4ot852dfVaarkAG1pxDutg>
    <xmx:oRy5abu9tH9IcKdOOXExGsKbCSBitrMBzBLrZDQoi3vr5edPpkkQIQ>
    <xmx:ohy5aekr5c4ZeVFDRhwSPowm0KuWnqPAsNqU63DuH2ryTD5yVBRZ9pM6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:19:29 -0400 (EDT)
Date: Tue, 17 Mar 2026 10:19:27 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Daiki Ueno <dueno@redhat.com>, Simo Sorce <ssorce@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Message-ID: <abkcnzIJ5q0XCVJ7@krikkit>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
 <20260309054837.2299732-3-wilfred.opensource@gmail.com>
 <abQOGm6BqAE5eEln@krikkit>
 <20260314073919.2f92b966@kernel.org>
 <9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
 <20260316180355.37d45785@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316180355.37d45785@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[wdc.com,lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,redhat.com,linuxfoundation.org,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: BC28C2A6998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-16, 18:03:55 -0700, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 00:53:07 +0000 Wilfred Mallawa wrote:
> > > Or maybe you could refer to existing implementations of this feature
> > > in user space libs? The padding feature seems slightly nebulous, 
> > > I wasn't aware of anyone actually using it. Maybe I should ask...
> > > are you actually planning to use it, or are you checking a box?  
> > 
> > For upcoming WD hardware, we were planning on informing users to use
> > this feature if an extra layer of security can benefit their particular
> > configuration. But to answer your question, I think this falls more
> > into the "checking a box"...
> > 
> > I'm happy to drop this series if there's not much added value from
> > having this as an available option for users.
> 
> I'm not much of a security person, and maybe Sabrina will disagree
> but I feel like it's going to be hard for us to design this feature
> in a sensible way if we don't know at least one potential attack :S

No, same here, that's why I tried to CC some userspace developers on
the cover (as well as for awareness of what's going on in the kernel
and the API being discussed -- adding them here again).

My understanding is that attacks of this type are mainly "observers
will figure out what type of traffic I'm doing based on message
length", and I feel all those "traffic pattern masking" features are
only interesting for very paranoid users. The RFC links to some
research, and maybe the kind of statistics/machine learning that those
attacks require has improved since, which could make such attacks more
realistic? No idea.

-- 
Sabrina

