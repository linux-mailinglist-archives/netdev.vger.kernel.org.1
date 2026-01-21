Return-Path: <netdev+bounces-251716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOOFGSE9cGmgXAAAu9opvQ
	(envelope-from <netdev+bounces-251716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:42:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DABD4FF74
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAA8D40276A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4489347BB5;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br7uP+FX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33E346FC4;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963220; cv=none; b=sfMiiy0aanQmt9dMOJoBYhy+mOnBvXDbbEfQvgSiheq/QIeCSCkAjA0fNpemNbnm5pXo4c/pUmxW2rq1oTS3WwjfuxPe3ovp1ICCioTgKnSbLgZCjjQVDzICihpeT3WvFQZan8kgjfArEn3YoXEAYttjTbTbNfxlkRpwslWJxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963220; c=relaxed/simple;
	bh=hSiKA5SNj4F1zAh+ap48O5K+GSmIzww7tovpuDUUam8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XitYa870kt50VRQcAVFR/HZdYLJO6Yj6kkpHyx1Y2V5+i8v9KipkhxPYdZU4TE9b+Iakr+tzsCu9+mZpoEMq0n1W/uH//EkcTn9Ii9OJUQTCofDWu3E4ocI8jMltSv1CWh460GKCjOkwTDHZADGQzfIQrAHDO+tKB7X1aD4q8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br7uP+FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38564C16AAE;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963220;
	bh=hSiKA5SNj4F1zAh+ap48O5K+GSmIzww7tovpuDUUam8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=br7uP+FXlcnZ2t/3aP2i/nhaXYcvI75aWgAuWQ69G+fFw4Wj2WQe2ilkgOj5YThY7
	 xheUP0Q2fOxOnws7glNjLN/U8AK5kjBsnrrdEYok7/LgVgg9XEKbwjavYrBHi7PLTa
	 dh2uzmEntzK0ddn2RthQXoXiLCq7rZFQNNHUwoHqlpuf4dvlbGKhzzQ/bV2ryPh13b
	 1vIui2ZEAwots09gMpJ3kwRq6+6kW/plogWZJdrxuMQSUmJyIpCRk3mBzRVJet3T8K
	 k6xayhDUvwa20nYSMp59+R37cguBMn+J5px+XawE5HGAkCdbsZ++Iip8xviG+BwtOg
	 ug4iGDajbn6lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CBB380820D;
	Wed, 21 Jan 2026 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] be2net: fix data race in be_get_new_eqd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896321735.699622.10561550138317146229.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:17 +0000
References: <20260119153440.1440578-1-mmyangfl@gmail.com>
In-Reply-To: <20260119153440.1440578-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sathya.perla@avagotech.com,
 padmanabh.ratnakar@avagotech.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251716-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0DABD4FF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 23:34:36 +0800 you wrote:
> In be_get_new_eqd(), statistics of pkts, protected by u64_stats_sync, are
> read and accumulated in ignorance of possible u64_stats_fetch_retry()
> events. Before the commit in question, these statistics were retrieved
> one by one directly from queues. Fix this by reading them into temporary
> variables first.
> 
> Fixes: 209477704187 ("be2net: set interrupt moderation for Skyhawk-R using EQ-DB")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] be2net: fix data race in be_get_new_eqd
    https://git.kernel.org/netdev/net/c/302e5b481caa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



