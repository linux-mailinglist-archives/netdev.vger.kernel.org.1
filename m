Return-Path: <netdev+bounces-281542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD17CwPw72nYMgEAu9opvQ
	(envelope-from <netdev+bounces-281542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F647BCAD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 364EE3014C2E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05B370D5C;
	Mon, 27 Apr 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si/cEtvf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B358221FBB;
	Mon, 27 Apr 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332197; cv=none; b=PhDW4qCjutnXEV/k4To1x2hwYCCZ9/gXYlAUcEh25g+ey47lJbFcGXpdcP+2wF5SfSE5m5zfeJg8TNuaGcOVEkKMcxsieo0+UAgOKCObs3QPFP2dhXlB4/nBwWYmR9EjlzpD1sSRSTtMdturliA1l0Iu3iKAo4R0MYBv1ERRMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332197; c=relaxed/simple;
	bh=Ddrs/UQbLpt69ZO8G25NpUQNwuWYdy//XwqSK0PvFH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWaWaFPOurhWp6JmaSQJS6O1Q2S4tm9ZgpBu+mnssHncTzJrk61cIPEZWQtN2PvaccdE9JnTWZrX65jR0UKf593X3nmxP9ekdSbm7XWB1m/CPIieCEUetw7ayRWcxi3xVMKMZWNLjv3uL410USiYY6DXmTP7suGXyehu+97go3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si/cEtvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B84C19425;
	Mon, 27 Apr 2026 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332197;
	bh=Ddrs/UQbLpt69ZO8G25NpUQNwuWYdy//XwqSK0PvFH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=si/cEtvfB4SzbR/leFNjGog8+/prnFuAFeZvSX2AiA5N/KP52kEUvw2kJJfWQNwh7
	 WoRbKOnPkH240C7O2qevmYc8K8atQqi1B3Fjd0x5jTlAnSncQk1vJbqYvAmqf86jbp
	 NVIRmenNkaWyen793uuSoURlfW8rsR4DlVnXNYRqEsYaBqYfSNl0PLYZqHNStd/Pg5
	 RbMfrrFKUlU7jYLof+bvia7HeIUW0MBA5ruGx2tt52Bnq5cLgcfJkU/1FxLkhmU31u
	 k32aI27PmqFMCTI8HzdnJX/f6p+oDlUEbbEodGxCBrmYwft+U7TIvpnBtmAdIfe+jM
	 Epx7EAc2eEx1Q==
Date: Mon, 27 Apr 2026 16:23:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 dev@openvswitch.org (open list:OPENVSWITCH), linux-kernel@vger.kernel.org
 (open list), Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/2] Decouple flow operations from RTNL
Message-ID: <20260427162316.63eb2725@kernel.org>
In-Reply-To: <20260427091153.3210301-1-amorenoz@redhat.com>
References: <20260427091153.3210301-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB7F647BCAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281542-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 11:11:46 +0200 Adrian Moreno wrote:
> When RTNL is contended, network-related control-plane operations can be
> delayed.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer

