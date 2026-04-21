Return-Path: <netdev+bounces-280160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIr1L0KN52m89wEAu9opvQ
	(envelope-from <netdev+bounces-280160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BD43C3B6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 832FA303DAD4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578E3D5259;
	Tue, 21 Apr 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZt8Tgz9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526E3D47B8;
	Tue, 21 Apr 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782368; cv=none; b=K164KwSMDrcUtaFIyobjM3WpCxICtlehBsjBtc2sB98o6b7tHtEjsPb4bl+nGMNHpRQ6X2z0MvHySi4X5uJHcHPm9xpGyguCt2WWuE81VDHGP7/Uk8pU3JOHQTUXGg4u5cJZ63ugsm1FbfrTvbWPdNP7K0nKcV3awlQfEWeIhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782368; c=relaxed/simple;
	bh=HYjmBPeIZEg9RL5c4Z8vm0+nz3k35xzKZji1TAsk+KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcQfl9YhTH30KTRk2MatQbRk3FHwyyA9k9xH41vu6RWK8TutoDzh4IpE+xAZn4acMlbXpQbO9YADzBUk/Sj44uKNYGSlP5++ilitTow48QZ7nM8LO8kcDFA9KnntW6e3iPhxBHye1uuKT58Dsp7qLBLZYlV0CpLpxjbzMyJdvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZt8Tgz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F4C2BCB0;
	Tue, 21 Apr 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782368;
	bh=HYjmBPeIZEg9RL5c4Z8vm0+nz3k35xzKZji1TAsk+KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZt8Tgz9RjVToafPHzLD5KOk58HkXZ3nAIv/4haHZ9B++rQ7NB01rlqtCTpSrMC2q
	 4aUDz2Wdb0K4yjcfgN5KOaa8a5lMg+XNnrdRDFkMTnB87dMWSMtVc5+Q8apU/Bbnrx
	 N3Rca/WzJJuDb6cbVBI/qrKNgYR9TN45/6d39uUZ6PGvGxyCbkmpi0ij0jZnlSX6Nz
	 zqGPNMXCrAZ/5XWAj7WroQJznA+3AF9gV0Or2I/6IfeS23iEeIVnW8z0MydcHzmBm0
	 OZmvwsbphOOoSjlOfdU1jadWSUWcJiNBT/IBGoQnuFPOyXoGzAFQtjfZaxouthu480
	 r2XmatsoiXZSQ==
Date: Tue, 21 Apr 2026 07:39:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH net v2] ipv6: rpl: reserve mac_len headroom when
 recompressed SRH grows
Message-ID: <20260421073927.368efbde@kernel.org>
In-Reply-To: <2026042142-vanquish-unhealthy-7a85@gregkh>
References: <2026042158-sediment-elliptic-a954@gregkh>
	<2026042142-vanquish-unhealthy-7a85@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-280160-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 459BD43C3B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 15:11:57 +0200 Greg Kroah-Hartman wrote:
> Crap, nope, this is wrong, let me go fix this...

Please honor the 24h between reposts rule on netdev.
Also known as "look at the patch before you send it not on the list" rule.

