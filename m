Return-Path: <netdev+bounces-291601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPD4LAZmFWqCUwcAu9opvQ
	(envelope-from <netdev+bounces-291601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 972965D32EA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E26B93049700
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2E27B340;
	Tue, 26 May 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g074q6Qm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92A3D25DD
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786604; cv=none; b=aR4KC1QRxGrN8IOCMVHGIsNPOmSggEvzQI4dlhnQZBhEqSFbOH96EVRNw8hHo19yr988uFZb3OM+fV7dDVql7qdHd79VdMhs40NdSnQYgZ5Itc1SzTSnsdgMQAq00qQ6kw2bfQsQIo1CIakMyaIGi1iYRXlAlPLl4lqBK+0VmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786604; c=relaxed/simple;
	bh=4r45IpUTkQU6ppfwvidID+GIdmdylbQJFuTJtHpXdXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4UNn0vR0wKzdIoATfnLZruohJij8vUPH80Igwzyo5Nx2A32CaKggkdvwZlcCgfcUlhhafu5FaktwI/L1amBgEOxTK0Bo9pFfzK/uk4X6sbuLvIeFiF9ceYDrIooJXr+edH1XyRQIJPq1207iTeOHz2mAeS0LN29JuEBcUd2MfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g074q6Qm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916251F000E9;
	Tue, 26 May 2026 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779786599;
	bh=xBCmqxQTqp877RfEb5hRgUgKGwbKYOy8z+7EBJz+mmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g074q6Qm84mDwxkjhxk5pTo6u9dN7WUsQbpxAHVhbti79duJCiHEbi6gP3LI3C02i
	 HvGzTaMAP4rrF/OZeQDC9gLQG/VdsOtHv8JKKrHlPlIK4ZowHJRquoTGmxlT9AYOsX
	 eIT/rK+9HIn1icUjxiHuN4eFZolGba8I14+xvrjoGEUvN+zTHx/MoCH0FxfzVPdOXG
	 K4qpIQ0VD7yXJCWvIDXtzPGCrJBVggmZvMHKrY9Hg2Zp/GuZzYt7EeCWG6kdim+uwY
	 2198ogdB4McVvl1cJSpl7LQ9M1JI3qPkm09HrIiH6obcVBab5rTc/EiPf725wTilgk
	 dbyi+cboUTxEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 04D3A380CECE;
	Tue, 26 May 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: team: fix NULL pointer dereference in
 team_xmit
 during mode change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177978660586.3278044.973815356097374235.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 09:10:05 +0000
References: <20260521081159.1491563-3-bestswngs@gmail.com>
In-Reply-To: <20260521081159.1491563-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, xmei5@asu.edu
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291601-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 972965D32EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 May 2026 01:12:01 -0700 you wrote:
> __team_change_mode() clears team->ops with memset() before restoring
> safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
> running under RCU on another CPU can read team->ops.transmit during
> this window and call a NULL function pointer, crashing the kernel.
> 
> The race requires a mode change (CAP_NET_ADMIN) concurrent with
> transmit on the team device.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: team: fix NULL pointer dereference in team_xmit during mode change
    https://git.kernel.org/netdev/net/c/25fe708bbc59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



