Return-Path: <netdev+bounces-299045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AGVfAmbALWrgjQQAu9opvQ
	(envelope-from <netdev+bounces-299045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2467FADA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:41:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=ZZU1Vs6W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299045-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299045-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85A35300253D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F013A3E77;
	Sat, 13 Jun 2026 20:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E33A3835;
	Sat, 13 Jun 2026 20:41:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383262; cv=none; b=XCnVfHZcqHgoBDMBh0dKXDdKlR333M4XqRNf8S8kxFGkjGAeFXAgSeonz4j/0vrPJWIP/ou6dzxIjd60tLFSOMk/wMgu2+KUsvKCJ0fzMr4QMwqM/Q866J4yo7wSii4Gm59pnkKdYlpUhtKFJwpC9OyTZOHDpwVmCDZYn4SVdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383262; c=relaxed/simple;
	bh=LGjMpl24hv4sSycw3BeisDB+ryaNa8HgiEpDupNNaO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiSgaqT0vkD4W9OLVDdxTOIIrGurYPP/yKsUZfIU7izdBrmtrYA1kA5Fh3z5z8gzheoe6PODNfAnHnVabUVTSEOvjlUnRQEaxRvan6wM+cz3ORjqUG14AkQQ6PKhrqoNU9B0CbT+Mzn3Oz1pv7ilkZdcjgnmAEg0z3ywASg/yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZU1Vs6W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9601F000E9;
	Sat, 13 Jun 2026 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781383260;
	bh=7KvCpdXomycTSlNZCr6JrFjKv4URbtC8VTq1VyYP0YE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZZU1Vs6Wq2VR+A+giCsV4fvBNE98FEYmqEOamQGIwgpPERz0TMofOQerE/OuCuKnh
	 xpfqEZ9Cz77qb55Z5sPYA3I6vslXBt5hGTse1aiX5GN+E5yTLFPMSCAaggpqZxHwKE
	 JEsD96247qq7K45+qtHvVCOpI9Yjf9vsfjR06HmT8dt8U9k/ESR8KlcTMfS/N2HtWS
	 DDgpWaV1dDUuSj/Oqc+aU9ovSU8P7YSQ5FDttiabSWux/YVR+Kagn3rA2iDCNjwoyQ
	 7sNFrdb9zlbm2LYvPXd+vnun4YcbAYcz9IZ2KnVxRBxF0Sk6SdG2r6Xxn0GFXyzdiz
	 YVaBWpmB9zLdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F83A54A32;
	Sat, 13 Jun 2026 20:40:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v14 net-next 00/13] dpll/ice: Add generic DPLL type and
 full
 TX reference clock control for E825
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138325589.1587607.11012960354687352250.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 20:40:55 +0000
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
To: Nitka@codeaurora.org, Grzegorz <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, Prathosh.Satish@microchip.com,
 ivecera@redhat.com, jiri@resnulli.us, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-299045-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Nitka@codeaurora.org,m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03B2467FADA

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 20:30:32 +0200 you wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].
> 
> This series adds TX reference clock support for E825 devices and exposes
> TX clock selection and synchronization status via the Linux DPLL
> subsystem.
> 
> [...]

Here is the summary with links:
  - [v14,net-next,01/13] dpll: add generic DPLL type
    https://git.kernel.org/netdev/net-next/c/9375487c0c78
  - [v14,net-next,02/13] dpll: allow registering FW-identified pin with a different DPLL
    https://git.kernel.org/netdev/net-next/c/c191b319f208
  - [v14,net-next,03/13] dpll: fix stale iteration in dpll_pin_on_pin_unregister()
    https://git.kernel.org/netdev/net-next/c/32239d600236
  - [v14,net-next,04/13] dpll: send delete notification before unregister in on-pin rollback
    https://git.kernel.org/netdev/net-next/c/e83b403eb142
  - [v14,net-next,05/13] dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
    https://git.kernel.org/netdev/net-next/c/df0ba51ccf87
  - [v14,net-next,06/13] dpll: guard sync-pair removal on full pin unregister
    https://git.kernel.org/netdev/net-next/c/0a5c720a7d57
  - [v14,net-next,07/13] dpll: balance create/delete notifications in __dpll_pin_(un)register
    https://git.kernel.org/netdev/net-next/c/1a2292101c0d
  - [v14,net-next,08/13] dpll: extend pin notifier with notification source ID
    https://git.kernel.org/netdev/net-next/c/0bf47f722fa9
  - [v14,net-next,09/13] dpll: allow fwnode pins to attempt state change without capability bit
    https://git.kernel.org/netdev/net-next/c/521b6d5de08d
  - [v14,net-next,10/13] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
    https://git.kernel.org/netdev/net-next/c/5db36ee62849
  - [v14,net-next,11/13] ice: implement CPI support for E825C
    https://git.kernel.org/netdev/net-next/c/fff4ed70ca9b
  - [v14,net-next,12/13] ice: add Tx reference clock index handling to AN restart command
    https://git.kernel.org/netdev/net-next/c/4128bda8fc1d
  - [v14,net-next,13/13] ice: implement E825 TX ref clock control and TXC hardware sync status
    https://git.kernel.org/netdev/net-next/c/e075d7768386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



