Return-Path: <netdev+bounces-257690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA9nMnSihmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:24:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E31049D2
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2367A300A522
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8A33120A;
	Sat,  7 Feb 2026 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDMRDLpo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFED298CB2;
	Sat,  7 Feb 2026 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431087; cv=none; b=Ine7ZuEg0rv7DdnYmwa6AYy7Y6WL7xSM2JuU+hK7fjLuEdH4bkMhGmGGliGOepjjwWAs3lHHIXgp4Y2OgVV1lFXiBYl7INZThYEL5qabXZFh2fsYHVYD+yzYkSCFIw+MgjyAPA2IW6G/lNQy8blD8a+bloC96n6KOMu7zyngaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431087; c=relaxed/simple;
	bh=i3bOYBdQFPCc/TY7AUpC0Q1tMiNiIYiZsvg/WzewqK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7HV0RlKrpzMKoxJw6I7Aa7V9bI30Cu59l/bWYALWCrYJDiRunk0n3TvjbqVT7Yiwvsgbm0fbR95c/MzQeJEtjbTS1niRgY22+kfF+xnBx8GI/Jlve6BI/5NbCcJv2+JX3OMZBJbW4lMqVTSjxRg/PKLv3Xqdl0sRHyuRFehwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDMRDLpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1148C116C6;
	Sat,  7 Feb 2026 02:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431087;
	bh=i3bOYBdQFPCc/TY7AUpC0Q1tMiNiIYiZsvg/WzewqK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDMRDLpo0BKky/mbMIlx/dxm5g4JfXEfmE2093DjLbouz4MuPUJxfUHdB7YplHj8M
	 HbnLM1XE6TcrYda8zUbegDoaq97jdpnz+XvZRShjv0q7rZrJEusJMeXoYS95XRovkW
	 z36uXmxEorZ8/Hn2Auxm3T3F5uaBVhx9eyxBYU2eI39s9GqpfkA9Gni25G0ppQNnL1
	 m/u3lDR0w3ZPqABW4jLppom3O2REkht0D6Hj1ovZN1HDaLm3Go1r8AMIRFKF8uFvNC
	 VMAiAdXqBZfsGSe+ChivP232qpRlfqf+QxbZyBNZEmQVcJCUYL/4KwFPS+lv2ku54c
	 YanTf7D/vILKw==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,01/11] net/nebula-matrix: add minimum nbl build framework
Date: Fri,  6 Feb 2026 18:24:34 -0800
Message-ID: <20260207022434.4017684-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-2-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 467E31049D2
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add minimum nbl build framework

This commit adds the minimal build infrastructure for the Nebula-Matrix
M18100-NIC family driver, including Kconfig, Makefiles, documentation,
and stub PCI driver functions.

> diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -48,6 +48,7 @@
>    meta/fbnic
>    microsoft/netvsc
>    mucse/rnpgbe
> +   nebula-matrix/nbl
>    netronome/nfp

The documentation index references 'nebula-matrix/nbl' but the actual file
created is 'nebula-matrix/m18100.rst'. This will cause 'make htmldocs' to fail
with a broken reference.

Simon Horman flagged this in v3 review:
https://lore.kernel.org/netdev/aXj_f3hsMmvKxC26@horms.kernel.org/

Should this be 'nebula-matrix/m18100' instead?

> diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/Kconfig

[ ... ]

> +config NBL_CORE
> +	tristate "Nebula-matrix Ethernet Controller m18100 Family support"

Andrew Lunn raised concerns about the NBL_CORE naming in multiple versions of
this patch series. The "_CORE" suffix is typically reserved for libraries shared
by multiple drivers that use 'select' rather than having a tristate prompt.

If this module provides Ethernet functionality directly, the naming convention
would be to call it an Ethernet driver rather than "core".

See v1 and v3 review comments:
https://lore.kernel.org/netdev/88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch/

Is there a reason to keep the _CORE suffix, or could this follow standard driver
naming conventions?

