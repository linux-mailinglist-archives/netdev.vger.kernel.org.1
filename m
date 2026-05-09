Return-Path: <netdev+bounces-286062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OMWKVCK/mlasgAAu9opvQ
	(envelope-from <netdev+bounces-286062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:13:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC84FD33A
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EE4C3008686
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2251A6823;
	Sat,  9 May 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvXiK3Qn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A9E573
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289228; cv=none; b=XpuK46XEz/m8imPcPvmPa8XoTYEFdbQs49jeG2pyNyGCITalFEBuRbRzSJS72OOdOUJawKp/5S0p2bmY+gJOyNOn+JE3EiPliLdVVOln5/G50E8+XcqJJrFzz8j/EIxXJUaSQGQalpRQUcFacH5sdXqqE+HD3kRh6On/BuCWJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289228; c=relaxed/simple;
	bh=HVAtBmoHiU4ExaGz8ypCjMiRtjwNgoDHdTGHLX9ZgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wf4XPUGSuhYUHrjbUt1RjKHlnb7unXW1htD9qhDgVieM3cCxj9yJ+e6FCbTeH74S14wGasMHCKnCmyieKmKva/ByQhdXKzeXbpDW6PdNDo0PfIU4gCiQBeKKb5ZOk6lFMu1PD9t8Haen3S0+/goYdiYI2LRm7EQc7lo+HUXlTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvXiK3Qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9DDC2BCB0;
	Sat,  9 May 2026 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289227;
	bh=HVAtBmoHiU4ExaGz8ypCjMiRtjwNgoDHdTGHLX9ZgNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvXiK3QnjOVo7zWzcXaMuhRKqsNhz8EaMq5Y+zR5bLCmC0zzVJZPCSh34vYMz+UDh
	 PDL621GQM8877eDScw/S1OTWTRr1ag3b2s+nmAfdEQ7kDVOAmtCAvaiElLCHWudcPR
	 PGjwRJzMxUd8yqVrqsad1eNubQZRYHLcWhvg+L4L7GHAP11i4QkB282viHCuoBM5Bi
	 DJi+9H6OHGTVZo0Vke/AJrFqQXT2/1JnCycXZW2p0ILUQX7LZnH9jmdKAOxLbuyyk+
	 PPRHmdZm/kE7DXXOwgd2vE9e6c5WDWcT9iAGoqG3cmBzRbbJGtC4QjXTo10oMFqVs2
	 we8NXRFA3d4ZA==
Date: Fri, 8 May 2026 18:13:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260508181346.692554a3@kernel.org>
In-Reply-To: <20260506101107.1174136-2-bestswngs@gmail.com>
References: <20260506101107.1174136-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0ABC84FD33A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286062-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed,  6 May 2026 03:11:08 -0700 Weiming Shi wrote:
> __team_change_mode() clears team->ops with memset() before restoring
> safe dummy handlers via team_adjust_ops().

Can we make it not do that? Perhaps split the memset() into two and
write team_dummy_transmit to transmit? We usually try to move the
complexity from the fast path to configuration paths.

> A concurrent team_xmit()
> running under RCU on another CPU can read team->ops.transmit during
> this window and call a NULL function pointer, crashing the kernel.
-- 
pw-bot: cr

