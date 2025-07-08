Return-Path: <netdev+bounces-204915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6DAFC834
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AB57B22A2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC926B0BE;
	Tue,  8 Jul 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="H+b90jCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5EyIeBS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C37269885
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970015; cv=none; b=eQx8rcGrP1OWm9PrmGhGZCy1TFs2b7/8ruw0uKWgGFwqr3HEArADJQP4x0j33aefvhdcs1PRqigzili9IY4zgBCAt1adMXuCCXKY6GFLgMU/31fAR22QayDHwJqriX0a+VVUnn9Q0NHXf52IPXnBLalyFHQepAUHizJpk7gbXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970015; c=relaxed/simple;
	bh=vFfzSjvh2eH6o0tp99/1qQ6Gv9iExXFSn+qdZqvJZG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1rWTzhOYMUIkgvIOUHvz9nrH3LzWltcElAmuaFUwbmtUFRHL6OZWgOrWAjVi0k16Apg6EjjgfZ2wJLiiRI5W0yY/16yjQE4d/qtmozLwi+u05MGEf/neZKVliSak4eUMGK/RyuZfzC4Cq4aG911Hmz6hzmB9SbgKSTAOH7I0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=H+b90jCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T5EyIeBS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BEFD7A029E;
	Tue,  8 Jul 2025 06:20:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 06:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751970011; x=
	1752056411; bh=wGKat92IYxEQR6OqZKHWsVRPZ0slbjTDGnbVk7+0VHA=; b=H
	+b90jCrHT2bx+RYj26ykNwjrDmxkcN7y58t3HWz2yDpJGfpHFdj+d0X0aKJn5r/4
	JvCHrX156Ml/5ZjZ0tJ5DWLVbr+9C3Swrd1VP9uqzdeP1889Y4BdBSmLA1Ib32KO
	kOLwUXATPtaRY+6nx0KAHggklYJgTEUtZT/Uw/KUp43jErYIkmNoIhiOYHHduU/L
	CH7J/LEQIsEuJMy7TUdTll8VkwgOLhcROeaBe2OpdrBWZvU/ODriU5bXi3+U8HWu
	ljvi26vEHLdfvBxNKexMdLhcdnUVsevXUAI3H+u8uWz9ZRooTPBEx8ce3Ny8gxCl
	fTRABZMygHD8Ygksx9qlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751970011; x=1752056411; bh=wGKat92IYxEQR6OqZKHWsVRPZ0slbjTDGnb
	Vk7+0VHA=; b=T5EyIeBSNF5oa198+t6xbTWhkLbl3dP18zSx0O+aTYT3/exAj8T
	SSkZnoSKCA49tcU/WZAMhJQ4WpnWfSHMbQjJBYA7IB31kaxRtuSmP8LJaU9pAj2C
	82KgPfK2f4KIi6ZafBNAABGUrbLIB+YNJoIdASFDzqwcopGaMt8SEXclqSqXA49r
	LYxpcdXGr7yE2YIn/lic0K/UwpIZlPcJoixq+SpvCXkQ9K7SZErzKJ8bIaV02Zry
	zJGpbzalNxaZr6dZ/k8p6645pILI39CCIBOLlL2JDEX7szaoTAcZU2iH5HEfKVkE
	f9pbQ8gUa/wQKZ1UO3GSjgcNHxrelO3pTMg==
X-ME-Sender: <xms:2_BsaBdTreQIX65heIGLzxrfyHBCXjxoelyRHpxP3hu-1rCkm0X7Wg>
    <xme:2_BsaMLIMzW8pWFNWtaPndLatlQRYmcaKGOvhaUbIFHNsymGFQ4XPnM2p8JsJfXC0
    l8KtZ5QJAQ8CG4CStw>
X-ME-Received: <xmr:2_BsaGLkK_Hh2T5OHkkZSbHb3qvcrciys1e7ODcmER_Ir669kIh32ivlRweN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    rghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgrlhhf
    sehmrghnuggvlhgsihhtrdgtohhm
X-ME-Proxy: <xmx:2_BsaDXYds3eO7FvQpljkarqU1Qdk34nCLOxxRuUQX9Eg4qSkD-50g>
    <xmx:2_BsaHmqbWl7ZUX0GQcwwAtNGkuKp-QDcjj2-HomgmtDQ-ujb82RZg>
    <xmx:2_BsaBmcKQPiNSE61Kkz4axsI4L64-Q1yKzX60Y0YFE_q8ujsAgW5g>
    <xmx:2_BsaPbMtYLYgsyTwkQ4FmqZmfHxx8hWox0H03N6a-rO3WbRMvNWAQ>
    <xmx:2_BsaPVCZMU0Zv1UbvI4qG_CMN6D4bw-CngQ89KV6Y0whxydy3iIHcAG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 06:20:10 -0400 (EDT)
Date: Tue, 8 Jul 2025 12:20:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <aGzw2RqUP-yMaVFh@krikkit>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-3-antonio@openvpn.net>
 <aGaApy-muPmgfGtR@krikkit>
 <20250707144828.75f33945@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707144828.75f33945@kernel.org>

2025-07-07, 14:48:28 -0700, Jakub Kicinski wrote:
> On Thu, 3 Jul 2025 15:07:51 +0200 Sabrina Dubroca wrote:
> > > The OVPN_A_PEER_LOCAL_PORT is designed to be a read-only attribute
> > > that ovpn sends back to userspace to show the local port being used
> > > to talk to that specific peer.  
> > 
> > Seems like we'd want NLA_REJECT in the nla_policy instead of
> > NLA_POLICY_MIN, but my quick grepping in ynl and specs doesn't show
> > anything like that. Donald/Jakub, does it already exist? If not, does
> > it seem possible to extend the specs and ynl with something like:
> > 
> > name: local-port
> > type: reject(u16)
> > 
> > or maybe:
> > 
> > name: local-port
> > type: u16
> > checks:
> >   reject: true
> 
> There's no way to explicitly reject, because we expect that only what's
> needed will be listed (IOW we depend on NLA_UNSPEC rather than
> NLA_REJECT). It gets complicated at times but I think it should work
> here. Key mechanism is to define subsets of the nests:

Ok, I see. It's a bit verbose, especially with the nest, but adding a
reject here and there as I was suggesting wouldn't work for per-op
policies.


In ovpn we should also reject attributes from GET and DEL that aren't
currently used to match the peer we want to get/delete (ie everything
except PEER_ID), while still being able to parse all possible peer
attributes from the kernel's reply (only for GET). So I guess we'd
want a different variant of the nested attribute "peer" for the
request and reply here:

    -
      name: peer-get
      attribute-set: ovpn
      flags: [admin-perm]
      doc: Retrieve data about existing remote peers (or a specific one)
      do:
        pre: ovpn-nl-pre-doit
        post: ovpn-nl-post-doit
        request:
          attributes:
            - ifindex
            - peer
        reply:
          attributes:
            - peer
      dump:
        request:
          attributes:
            - ifindex
        reply:
          attributes:
            - peer


-- 
Sabrina

