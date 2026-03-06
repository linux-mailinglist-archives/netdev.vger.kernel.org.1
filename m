Return-Path: <netdev+bounces-264818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBfFGZLlqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB672222B99
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298293055106
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6278372671;
	Fri,  6 Mar 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji1Zod4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF81A6821
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807360; cv=none; b=omXDoQ/iEAri60nVQ27Qr1hehzdjOdaEU78sNIROM6Vx1aYE9lel9aHBrDf4RXsK3vWjBI7saUArqxmw5oZdZC/3daKphtuS8dVODi/82AUqxOK+H2q7Z0D2ZkitqzJydkcFMuMAe6WaqLJfu1NvrBw4UuHRSqRMb/hk83FG6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807360; c=relaxed/simple;
	bh=Z/Na2LnjKYCj7sCOYrXH+UVA6nRhWD9h3+/0rNzTWNA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=R6Cx6ofswdFFKTBQQxKuGw2zqui5WjthOUolI3fq9l0diRoL84LPBlEsMPauoiEYf4wMnqvetY2N3YQRdH3CfnYmicvOEWCU6YvtmPkUGQ7fmvbTrXFSOh4dtipiFslUl6kFb6XHMUqiWM4PTOzoJV3ocjkJ18aBOLWkizG2Xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji1Zod4X; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b790af67so3498104f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807358; x=1773412158; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/Na2LnjKYCj7sCOYrXH+UVA6nRhWD9h3+/0rNzTWNA=;
        b=Ji1Zod4XgUk+HuUW8BIuOImcebnZbeycffJQGJI2pjE40xY0RtuJH1+cFWnFXE9uve
         SCdUCtZPB1REtbW65n1Nn9YB51qfblLnIpzv/ASNUTNFzu2F91HPxQ7AAkGojLf2AAxX
         acZBM4adzrLFk1eeAgmJE/ybwWqob3kNybQoAOjNNAWbeEsrUm3K/sBJ8Ee0ap4czNQR
         bw6IKAukJH+YH+gosN/rSaK2zXhRYx9q8fFseC0Sr1GvyVcjeR579W2PSZhkSz/UJmg4
         7dIivlsnDbEa29onIFGMXRRCZImLQ69RNbZ8xbUWm3iJJixZnK6NRtpg6W1rHR+A9Jo8
         1hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807358; x=1773412158;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/Na2LnjKYCj7sCOYrXH+UVA6nRhWD9h3+/0rNzTWNA=;
        b=RIW/L3px20gNUCWqx3X+MQxDKlNwtSiWvgUOPzkmNUXqNDCKGSARvzU88DvfQj38FJ
         wF034/BKsXjo6t+VCnxTfGB063xfGTdxrk7Vx+hsMB9M0J29f2s5vDfejnTGSMIpm2jX
         D5QfsauQb+5JLobd2hkxZvukTOxJFSRhftRUVZGDJQrnX9IamLCD7d/SzomjzXPe4/im
         jwnjOjTSLoZ9z5XIx+PwaZAGcukssA7Zz64hqHGpIpcrexWqqS0UKGnfUlAU2iKqoeDB
         O1slkZSnrGsm3SsxqBSrLN7oRfFiZCe0z4EIDBYByDH7I0gwzX0ULeA64vGUY4LseEcy
         E+bA==
X-Forwarded-Encrypted: i=1; AJvYcCXxmQt4kEpIcMS1bdoCvNOJ3zNtd8PQCzN3tb8n8zkrJZGh3bRRG6ws3dCfW4m9at5Rd/VKxUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAZXojhn/M4E3Fujci2wX7eTlEI2mNauYgDY6j9ZxKbm9evSH
	96MlRhkenAyM3lrYniiVfCAKoC0WsZq8uT5QLJTp8MHl04GS5J6sOGfYa6vGkQ==
X-Gm-Gg: ATEYQzwnzgkSKixwcWlmQToa1W1Qf/IC+JL3ozvbwNES296SRPZEB+O7pgW840ydAtJ
	NBEuFbJiGW42VVYJdgyiVbQAU59qKdLchx/BOHdHYlt8I2Y7gA1Msb6lSNByJ+zUbBuT2OjjINd
	NWKtIlHXMbSWnov9KutHctz9iJFiFt9lsF5ljj4k40vZP+2EjHgUl5RJhRUBvtVm2gI41Yf3V7a
	41/PirxDXlfiTuA4teLNdBZ0LMC3xvcAeESxks7LO/byZHlgx/lvZ23vEqgf+NJArFvwUj1a4bE
	RL4u0vDE7r8h82wAzOuPTKcaK/Cilm3hiZso4tzpfR4xFp17P8RNSSUhGEaGdS9yO3gmn9Bpgkk
	bPKLKJtDd+xbsuTv4vRc3Jex7GIb5Diq6ZZcQ8+/rHGAgUbauGgwZbDcrnqigVND8qMinw+6t0K
	B5xIVCpHi8c2zSLtGxwkHkOvpWGQ==
X-Received: by 2002:a05:6000:184a:b0:439:b775:fca2 with SMTP id ffacd0b85a97d-439da657033mr4329482f8f.24.1772807357597;
        Fri, 06 Mar 2026 06:29:17 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4150464f8f.0.2026.03.06.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:29:16 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 07/10] tools: ynl: convert devlink sample to
 selftest
In-Reply-To: <20260306020901.524105-8-kuba@kernel.org>
Date: Fri, 06 Mar 2026 11:53:11 +0000
Message-ID: <m2ikb9i388.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: BB672222B99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264818-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rt-addr.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rt-route.sh:url]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> diff --git a/tools/net/ynl/tests/devlink.sh b/tools/net/ynl/tests/devlink.sh
> new file mode 100755
> index 000000000000..55da00c985f4
> --- /dev/null
> +++ b/tools/net/ynl/tests/devlink.sh
> @@ -0,0 +1,5 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
> +nsim_setup
> +exec "$(dirname "$(realpath "$0")")/devlink"

exec is defeating the netdevsim cleanup in the exit handler.

.../ynl_nsim_lib.sh: line 22: echo: write error: No space left on device
Error: ipv4: Address already assigned.
Error: ipv6: address already assigned.

Same for ethtool.sh, rt-addr.sh and rt-route.sh

