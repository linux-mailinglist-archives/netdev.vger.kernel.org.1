Return-Path: <netdev+bounces-292926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCBnB7zqGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66B5FBFF0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D29730DD612
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C435E1B1;
	Fri, 29 May 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbd4O6b2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDE356748;
	Fri, 29 May 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017615; cv=none; b=JHzTwgu7Wt75zWfThBN5fcCIHUPqFDLUxzpfnrqcR55r5boZQQ67oG5ckUiTuzifa+xBNsJx7rD65Sdblo2ubOAt8N2ZnhUIRpyDd87aO4SLRpBfynRVVsldCKrYGw/DXYezWbag90nSfquLBOG2zTl/1Ck/uILks6JMBeYFJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017615; c=relaxed/simple;
	bh=kc6nYMTZ15ADkL2c3/owXt8ybjc/HA+x3q8GPHZ/JeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mucuf1T2o9rilYt+0LtS6V6ute9g9KomgYHn9y+eKl1AZv3hICeLqetoqN+A/AgcusmNhH5DROAK0YINnpN2d6QoSIZvnQx4DtJwjMiaaxrL/2GCIVuWEks8rSHr1i42xpAthnpZsispuok87erNQ555BE9XCXhSBmRhPNsxIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbd4O6b2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48BB1F00A3A;
	Fri, 29 May 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780017613;
	bh=daVD7h+JJCInltDYMlUpsr01UGPhOz1107R+/8g1GTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cbd4O6b25jNSiwHzC9tH6sPaVqcHXPLvjJ47C9KcyfA6pUwKpLaiRsnTbXEF0UZKr
	 NrkjKXHLp0yRDGS9Rc1RvUVmTSicK8iip/MbWWcx6I0cixnzJ1gCYmHHNKPKI27pME
	 O0BKTzvxvD+MnDvZteCkF9w2MHTxsW2nY7xuTrv0/KIjy+te1K+T4hf4Zf9H8fY8v6
	 FNBLyqcQmGOA1a1fls+y+g9MyxD80XFJKCok+8FtEF2/TwRLzQpDdujoVR6UycPPDL
	 LKYxReBnDyG81Fi54bLu+NuYxzFiyCrpY1Sj6s2rxY2Vky1JRbKF4eTOGouic2eG/+
	 7hd0dj5MCeAYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BC1392FFFE;
	Fri, 29 May 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001761763.1584301.12785828078106314359.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 01:20:17 +0000
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: geert@linux-m68k.org, dlemoal@kernel.org, cassel@kernel.org,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org, mingo@kernel.org,
 max@enpas.org, andi.shyti@kernel.org, deller@gmx.de,
 linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 christian.ehrhardt@codasip.com, lk@c--e.de
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[linux-m68k.org,kernel.org,HansenPartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de,vger.kernel.org,lists.linux-m68k.org,lists.freedesktop.org,codasip.com,c--e.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292926-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E66B5FBFF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 16:17:26 +0200 you wrote:
> Hello,
> 
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
> 
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,3/8] net: Use named initializer for zorro_device_id arrays
    https://git.kernel.org/netdev/net-next/c/4933a658369a
  - [v1,6/8] zorro: Simplify storing pointers in device id struct
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



