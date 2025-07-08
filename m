Return-Path: <netdev+bounces-205022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C8AFCE25
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878F0580FC8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418E21ADA2;
	Tue,  8 Jul 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuHI/M5P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061E21C190
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986026; cv=none; b=X/trNP9hABhvlFPcylleEHWlGLlsKqgrAsx7DFOcwoyJdlZQ4nDdd/AIi0U0YAIvmO5EG6LB9gzkSKULdvuFVLYXGQ3gSyfsRzJ2hOpCgNcUOUYUjdSTkVyEEhjzPVroomvUI3Lu744dPl+x1T/5DKhb5m9k+kFGZpCBoLCeRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986026; c=relaxed/simple;
	bh=oshc0GkOoxFaM3DFinbe3ODvwx+enDezGjCCpE32B7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMXRk6NkqT8PurxBXKuWK0TStwgXqBTEgfPg89tyARMa5xYYcEiTdFOAz5VjWtukPoX878vmMYbsJcnWinCOc0zsxWBqthmlRA/kdCPk1/YKUPSErk+KNtpooaNdaVQAyAPGFGeELUl3XBF/XjHwevCTCya2ZkM10DLBSulCwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuHI/M5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6175C4CEED;
	Tue,  8 Jul 2025 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986026;
	bh=oshc0GkOoxFaM3DFinbe3ODvwx+enDezGjCCpE32B7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kuHI/M5Pjwh61WH/0mdUYBiievu5iSA570v0n9Tuji+E+i2o7TtT/GBqi+Zyfd6XU
	 Ke4U4efAy6dGVnCSrNMkVYi9AJhDj9XT1eb6VoYyWhAgegxMYT7Abm8C8RDOqPdaFB
	 +R58CYcQBNajIw/gTRW39cY587uqaOLFa5BWyZ5oKfeGwnej0yPGm1YRXQYJ/sDvOQ
	 gqvm7kYIYrF7l9cpTrMvisGAWx9jlzjLQ/MG9pGTgxkoFGkp7w7ZvzvZypPFAOihv8
	 q5QgYAHQvYoLS6buRtroldnCre4HlVZzyeEOECv+6Yy5zvQNwqEv2TAhvNmt+FbcbE
	 umn4ci0L/mKlw==
Date: Tue, 8 Jul 2025 07:47:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Antonio Quartulli
 <antonio@openvpn.net>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <20250708074704.5084ccb8@kernel.org>
In-Reply-To: <aGzw2RqUP-yMaVFh@krikkit>
References: <20250703114513.18071-1-antonio@openvpn.net>
	<20250703114513.18071-3-antonio@openvpn.net>
	<aGaApy-muPmgfGtR@krikkit>
	<20250707144828.75f33945@kernel.org>
	<aGzw2RqUP-yMaVFh@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 12:20:09 +0200 Sabrina Dubroca wrote:
> Ok, I see. It's a bit verbose, especially with the nest, but adding a
> reject here and there as I was suggesting wouldn't work for per-op
> policies.

Right, it's a tricky problem to solve :(
Really, the best time to address it is when family is designed.
Even folks quite familiar with netlink make the mistake of treating
nesting as a cute way of grouping related attributes.
It is really, really counter productive to use it like that, nesting
has major drawbacks.
ethtool nesting may seem "inverted", but it's a good example of nesting
used _correctly_.

> In ovpn we should also reject attributes from GET and DEL that aren't
> currently used to match the peer we want to get/delete (ie everything
> except PEER_ID), while still being able to parse all possible peer
> attributes from the kernel's reply (only for GET). So I guess we'd
> want a different variant of the nested attribute "peer" for the
> request and reply here:

Yes, that's hard to the point of probably not being worth fixing 
at the spec level? :( We could so something like:

--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -265,6 +265,11 @@ doc: Netlink protocol to control OpenVPN network devices
         type: nest
         doc: Peer specific cipher configuration
         nested-attributes: keyconf
+      -
+        name: peer-input
+        type: nest
+        nested-attributes: peer-input
+        value: 2
   -
     name: ovpn-peer-input
     subset-of: ovpn

but the codegen today will output this "fake" attribute into the uAPI
which we don't need.

In any case. I think what I suggested is slightly better than
opencoding, even if verbose :) So I set the patches to Changes
Requested..

