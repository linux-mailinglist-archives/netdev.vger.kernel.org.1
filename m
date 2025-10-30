Return-Path: <netdev+bounces-234523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB9C22BD6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 753444E0591
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378112D8DA4;
	Thu, 30 Oct 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="pEF9HLgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzmvbtLy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F46299947
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868314; cv=none; b=XNGHALmaUN4CJ7NQfLQRXuPcsoUfYMf0J2fhds2ThqdRpDkXlGAPi9SuX/flJ3bYOsd8PXiPyG8hcRAOH4x4C6089Zlb05cdgyPw7un/Hpc8USHbe6YFoO+ZFcf7OuUlc4t6QltouA8VtmTaFhpue/iOf9p4Zv/9nFQIxj0Njpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868314; c=relaxed/simple;
	bh=xJf8jQHPXxC0ZKiqwmlRia00wx4eSbG7NxgVOurDf+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APAy1hqjCRfQ/R7erdjxDUQz3YgPzbU31V6th6bxOEsdestMATFxcyEk28DQrZIafqmwEOamHiooyoR3vOGm+0G0EFHkGVw4lwZb21xZpOerp3HwYsUCRiZPxV458yzYRPEc5IdfImBHgxhFM9/XoT3qxIeiuYfY0QHgyT3IVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=pEF9HLgV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzmvbtLy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97C957A00A3;
	Thu, 30 Oct 2025 19:51:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 19:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761868309; x=
	1761954709; bh=pKL7W4u1jPzIVfVZmIG62c8b5FGLfZ7RhVpTnvhBm2A=; b=p
	EF9HLgVPNMXYXHTN+xYZX4T5/vz3AKDuszIL+VunMdjZQ2XaUtb05bKD7iXvtl2d
	MqKg0t9jqy6i5SLbl3rRZWCw94WfeD/5M8ae9j2uRZs9Gn51WdVb3wI/dN7aFMoe
	WDtcTZtSHlesnVgA+s2j1ebNX0gO1I5kYE8KCYvX2CHV/EerHAyJsDJZonfTGxkU
	Df5Kf9Y6KewUA3Gr5kyNBtT+wNpn+k1SWaVgXGXQFLM/VbsMp33/uF/66BO9iUGr
	7zblaxp9jP+KmSZH6eQOBMhbMI/YnuDtdWb0IF/OBpgVDWM6C8nWxq3mfuPVRhls
	R34pUew10YXY4bZYJuY+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761868309; x=1761954709; bh=pKL7W4u1jPzIVfVZmIG62c8b5FGLfZ7RhVp
	TnvhBm2A=; b=JzmvbtLyjeFVYsONSw+eDOvtT7cz+LMvnba3N4OCCupkRnyQSQw
	ikVuhIyEu6+EMRULQ7c4bu8wmlfYRIey1Lfyn/ofIQ/pyFB/uZcoH/GTxLXPABfd
	WboAkLSjR88p1zumlWDEegJzSUW1hfb0BrnLhTscA7T3VBj5znf8Nr08pOFFlCc1
	uiFWfn3hf640zk8dPXBm0Q9ufbsik9y9phCxMBw0G23rIDmhxfL6bHaZrqF2dhDw
	HXudm7HsY+sNG8o9BN7VQ8q7K7VOZ1qhqm2AZnBxmLgXGUe8GJSyOT5kXzWhlLK+
	dDFhLih4LX1Xt/iBXwqQWup6z/4itT16zdA==
X-ME-Sender: <xms:FPoDaXIuzXHECg-p-4U-dCP7kYn1z-IBwbPOn8qbD3kw4DDKbuIaQA>
    <xme:FPoDaSLzXdyOLaLXIn_8NvFKVdqHtnIkIpnbXly5Fpm_LGH7GDft2YXbRfOijyfgl
    7SI_tXT_QKEKwy6oSNDD2-BCejVFOlJ0eepNl3QUVUlq8YUxUkD6Q>
X-ME-Received: <xmr:FPoDaUsfs0n8NEbdozMx3r6h8jV57-D20QgjSt9OSVaDKegI4Youj8dFw7md>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluh
    hmsggvrhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvth
    drtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FPoDafTCpQtAEh5-xNBW7R3RDYGwVZEjd6fP6u14W3pyKCNf3l2Ykw>
    <xmx:FPoDaaNv7OCT4HjSO_OdUAYC2-3UnP04MK694z16rKpBo0J2yRUzIw>
    <xmx:FPoDaUZI0sPGV4k_R6ML8u_OB-qTPMt7EZJ1EF1VGcVR3a4aGs1s1A>
    <xmx:FPoDaUy96imdN2dps1bpbcwNc1mnbi4bws6kZYAOIaIF7i7BTTOfLA>
    <xmx:FfoDad600T15q6_xrwRyfprK75UNBDnor1tCpOzM74O0jOoy8_5zvtpM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:51:48 -0400 (EDT)
Date: Fri, 31 Oct 2025 00:51:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Message-ID: <aQP6Ev_21Z45JuG9@krikkit>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <20251030090615.28552eeb@phoenix>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030090615.28552eeb@phoenix>

2025-10-30, 09:06:15 -0700, Stephen Hemminger wrote:
> On Wed, 29 Oct 2025 12:06:16 +0100
> Sabrina Dubroca <sd@queasysnail.net> wrote:
> 
> > diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
> > index b15cc0002e5b..586d24fb8594 100644
> > --- a/ip/ipxfrm.c
> > +++ b/ip/ipxfrm.c
> > @@ -919,6 +919,12 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
> >  			fprintf(fp, "other (%d)", dir);
> >  		fprintf(fp, "%s", _SL_);
> >  	}
> > +	if (tb[XFRMA_SA_PCPU]) {
> > +		__u32 pcpu_num = rta_getattr_u32(tb[XFRMA_SA_PCPU]);
> > +
> > +		fprintf(fp, "\tpcpu-num %u", pcpu_num);
> > +		fprintf(fp, "%s", _SL_);
> > +	}
> >  }
> >  
> Reminds me that xfrm is overdue for conversion to JSON output.

Right. It's been on my todo list for years but I've never gotten to
it. :(

With the netlink specs project, it's also maybe less attractive?
(netlink spec for ipsec is also on my todo list and I've given
it a look, ipxfrm conversion is probably easier)

-- 
Sabrina

