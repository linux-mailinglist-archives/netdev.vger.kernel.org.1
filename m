Return-Path: <netdev+bounces-282561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLp3I3ql8mk0tQEAu9opvQ
	(envelope-from <netdev+bounces-282561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0549BCFF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DEA9301F16D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFF185B48;
	Thu, 30 Apr 2026 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nppr0a+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D47EAC7
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509687; cv=none; b=faoKcUzNcbVmvEv8U7Fr2fjiJ6+2KWui5sOgTDgwk5569G6AvqWbHVlUWuLA9fFF/57q7Xnww3WViNeXTu8DoW3+BTJTrfchsBhEg8dyVOeObfjbCJFiKv//S7W5Oj1Sz1PVKN2MlU3CiJoUbDHYN66jonzD97d1K6IYlaGW1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509687; c=relaxed/simple;
	bh=wFIiLGQF6E5Fhq1gNmXeRevf25HC3Iq/ZjJOiXDh6D8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1+2IBumdfWgi0joYiWHqQnvwvWaLzZg3f1tI+OT8nZyDC3W38tFzUrwDXr3GXnYfgL3HpJ+Ipk69wsfjG8p4gwuxLGjQVXVoLArrIHsooDK5ENcyuMpXDpIYLMEs7SDBLs0uyl2pffY8tDgmAVZZdENJ4NvAiIrvoUuYZPRYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nppr0a+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F13C19425;
	Thu, 30 Apr 2026 00:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509687;
	bh=wFIiLGQF6E5Fhq1gNmXeRevf25HC3Iq/ZjJOiXDh6D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nppr0a+/F+t2es8NbgXM8iYuJjJIH5Q/agFP236BMeNdVOIKzCIWWYspPFba6fXG3
	 lGOVCSZ3gj26mwBZfp5z9EOrzInjwwgDiaGK7Xr9diW77kyHmaiuAfuTxcUajBLr0r
	 LQRehnW5konXGEmDXKFsiUclyiOIMPYd3O25MzB0af7FYIa3WSfdBaZ6vk0D8gliTv
	 NHZIG4/4jdnPlQwuPZ69yYfX354nGvmrZRrf9INrkalsY06l84fOKs4FlsHEmxjVsW
	 VZC6iCZXgxgFRVcDHdFynzhjFv8b41hFhlvzZxnjo/5qEM7ZfDHVSWa3V8Q9JMAWqE
	 TM0R95j5ou+xg==
Date: Wed, 29 Apr 2026 17:41:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Aleksandr Loktionov"
 <aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, Petr Oros
 <poros@redhat.com>, Alexander Nowlin <alexander.nowlin@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH net 11/11] ice: add dpll peer notification for paired
 SMA and U.FL pins
Message-ID: <20260429174125.191f9e70@kernel.org>
In-Reply-To: <3c1f1894-e969-4dc2-914f-9e15db35dab5@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
	<20260427-jk-iwl-net-petr-oros-fixes-v1-11-cdcb48303fd8@intel.com>
	<3c1f1894-e969-4dc2-914f-9e15db35dab5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48E0549BCFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282561-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 16:28:48 -0700 Jacob Keller wrote:
> Either way, to my eyes this looks like a pre-existing issue that may
> need some attention but I don't feel like it should block these fixes.

Yes, I think "fail to notify" is / should be handled by setting
an error on all listener sockets. It's very much not the job
for this series.

Looks like the series did not get ingested by Sashiko fully,
I kicked off another run locally, so probably won't get to
apply this today.

I don't have any "organic" comments :)

