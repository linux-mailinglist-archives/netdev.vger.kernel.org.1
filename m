Return-Path: <netdev+bounces-272297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJszErTUxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:52:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130433DA02
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47E3302337B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF04281368;
	Fri, 27 Mar 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o62RvCUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B8282F11
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572652; cv=none; b=GYMhAMm5aVreyjyC5a8NAcL9m0OdhbVF4d4bRr26ld7NhgmduEj5wl9FTnccjFXTVvdeHsatpCcU0lqTqPHfvqwLNcNaOgIuyFuMBv+hojw6qprYkyCOeW3ftTsOoejUem9OOt2R9d+GKhkWI2mT7C4VyBEZwSOvlbF0s8RHBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572652; c=relaxed/simple;
	bh=E8z9xsiZJnyDXAvMSIm4/D6VjQNc8xajnju24fxixLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8+e3HWDJYUvP2MRmKemmsMrLh4w/sf2iWW4nH+YVcUzTBJiVa7pqWGrj3ELNXicMfarRKlu4yGXPJc8qO2ItOuk/XFMbOX7Hd9zTh7p5PHUt/kyzC7hsHBlrvaGzWsxvJdVobryqPaum7+jKhf2RokA33qCfePDB204qCbju8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o62RvCUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C50C116C6;
	Fri, 27 Mar 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774572652;
	bh=E8z9xsiZJnyDXAvMSIm4/D6VjQNc8xajnju24fxixLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o62RvCUdaElvZvNdXI4uwGymAu3gdVtSXkaPEE9S1tCXCFLWKKE/GhHzbCuLNIU2K
	 Y9U9y0bljpe4Q/+bRPeXon/Z3CRZhSyO23GuXplBWmnpMKSXZAr0jZjDLOx6AcuaGD
	 W6OMOYIvgPctH404rVjPjGTLU0idA1OrO3y30h1BfcXLgqEtYz7hIereu4q+vjgxYW
	 4PR8oR0bXRj+DsisbuEbCif9obgp1eKBjAWJyYOtsOOTMFQPEeCE+faaoFhnkQA2p1
	 6MZUsfGbUZ/47RuW/Q3IHFX+x82i55j5kGogtoJ1HoqTg3vTmyYtgL1BAnm3Zo4r6p
	 4r/ldqyBie3UQ==
Date: Thu, 26 Mar 2026 17:50:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
Message-ID: <20260326175051.31828b64@kernel.org>
In-Reply-To: <CAPpSM+Sz_z2LpJwJrc9g+A+vRb=dRyMaDnBdZPP7TT952bgjpg@mail.gmail.com>
References: <20260326075851.3967598-1-xmei5@asu.edu>
	<g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
	<20260326122137.4aae1d46@kernel.org>
	<CAPpSM+Sz_z2LpJwJrc9g+A+vRb=dRyMaDnBdZPP7TT952bgjpg@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0130433DA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 13:44:37 -0700 Xiang Mei wrote:
> Thanks for the suggestion. A TDC selftest was added to v3.

Excellent, thanks!

