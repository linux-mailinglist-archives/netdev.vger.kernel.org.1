Return-Path: <netdev+bounces-257697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO+8HIWjhmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC9104A72
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C4130A7FAF
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D408331A44;
	Sat,  7 Feb 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbkYn5P9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808B33120A;
	Sat,  7 Feb 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431106; cv=none; b=VctW3EAYVDySCg3qnN4yDOdwgpUeZHeEUueOi+Kp8hGBblxyqi6DRugODqmVuIp/Yi2DrkMlUG/ezd9CqStuMmQlHvD9SjJTfJVqPgjXpbJGo50anu7UsXlBb3McRR3HpGWHF7e31rry34GwCpdz7N3AvvQDGJ58ukgulBsA1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431106; c=relaxed/simple;
	bh=IsMKmXYzTOKmVflLmNT4pE9uOPrGGOHzyzZ34Tsd6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI8rQu9DSjzci05mQkv4uIdIRSyO9/IIR4DaSiQae3Z81kdLubMfACvW4WVyLCb9C9p3cPax6PB7bcve2RWbWxGVGCUOL4SoxY4/oR1vcUCI0hxDJF2IYUJX4PasYqByYegBguktv+WPtnQBaVH+fSsH3E5iazankjHxO2NFQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbkYn5P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12126C16AAE;
	Sat,  7 Feb 2026 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431103;
	bh=IsMKmXYzTOKmVflLmNT4pE9uOPrGGOHzyzZ34Tsd6zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbkYn5P9HKDsqPL/c1Mc7DK48ygC6RctAlwW5dmcxJQghpXMjmYaD230MNzBEyLN1
	 cVm8nRqmuAsTz0BFkqr/Dn+aqEyu8bUBJizEiEiVdIH698BD/CXQy5WRxErOR67DLK
	 MdpmmpZtQ8bFCFTMjVa4+XJEqvMR6Rj6uHyrWutpi0AOYnbOSKbwt3qwk2rXOH2i5M
	 JBSffJsIpeATQjFBGmU+6f9A6absgEVnTfPBmL8Q7Dv6bapQrranogWHruXecD0qEL
	 nKiM2cHDNExqQscx2XgGNwtAC7uxTc+V+LtYOgWg0/Q1whQQiFDp+Hstf5SsLMRGyc
	 VCOieLCpEFmPw==
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
Subject: Re: [v4,net-next,10/11] net/nebula-matrix: add common/ctrl dev init/reinit operation
Date: Fri,  6 Feb 2026 18:25:01 -0800
Message-ID: <20260207022501.4017995-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-11-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-11-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257697-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 0CBC9104A72
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add common/ctrl dev init/reinit operation

This commit adds initialization and teardown operations for common and
control devices, including mailbox queue setup, cleanup task
registration, and chip module initialization.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index fd7c97f3b0fe..9927dd3a1791 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -6,6 +6,164 @@
>
>  #include "nbl_dev.h"
>
> +static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +
> +	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
> +}

This isn't a bug, but the commit message states "registers cleanup
tasks, and requests IRQs." The function nbl_dev_register_common_irq()
only sets msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1, which is
MSI-X configuration, not IRQ registration. No request_irq(),
devm_request_irq(), or similar calls appear in the patch. The function
name is also misleading as it suggests IRQ registration but only
performs counter initialization.

[ ... ]

