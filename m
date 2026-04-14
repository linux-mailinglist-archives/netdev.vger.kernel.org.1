Return-Path: <netdev+bounces-278247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO8JJYiI3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C923F4679
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86BDA303F2BA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB81A3029;
	Tue, 14 Apr 2026 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwFSzB+u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A08460;
	Tue, 14 Apr 2026 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126085; cv=none; b=bQl0YJNzqKtQq50xdO3uKi/u90JXCRwcwufJ9FOFNUy0FoGHhV/qrgwR/7h7xx9WffLVP1OT+WAQcEU9lN2WiFYa9xVTbmpyFuE+o1GaLJeNcy1gs4U3dC5eHMG3iAzuMjqfH2fT6S7d3iIQQL335IJzx/EzuUIeC0K6ABeJia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126085; c=relaxed/simple;
	bh=jMcHKHC72qNDtmmUm45/07berwsI0MCWzZ6AkHq8Pcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYrGgw6rfKwt0A1jlsHsKz9Q3kbZCJoeNI/uRBx1RIuUCsRmfxEEwari3s4jpNKvceGLaVAzXfWedWw5DwwkIaBryTky9tpVmL0RBwvOvn0i1U8c3NJcNARPyTvegdgQWUkewqmtRq7v1QpSqBqKkvoffv+JtB5BZEjHTb6yDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwFSzB+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FC1C2BCAF;
	Tue, 14 Apr 2026 00:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126085;
	bh=jMcHKHC72qNDtmmUm45/07berwsI0MCWzZ6AkHq8Pcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwFSzB+udoPO/zTA6uZWp6FnjWWmdSN7TJ4r5/OhPX3YMk6sF+iVVJbmIRz/tcs2b
	 HA1dh2aU0V3gioGXpidtFFjawoCSupSRXIAF9KSCae61s6YRGOBF8uS1ZA7Fn1ABXZ
	 niwIx0Z9tnhVWvHIaMX2UKei9Jg2S6BnthoPe4ohqurGyC3x+9D4vZGkhWjur88yGN
	 4JsO2apx+UhVrk+MPRbRjZB5NwZ3iQq5SrWfcR5bWgFtIrwR2E1qXXGG3W11QOL81G
	 qCWpPWsGrO+vgQPHk8kgO3JH9Q1ifCZXuKU+Nx4rQiR4z7PQxUDQEzHUC3FWNE+QfL
	 y6GZsGch8WiWg==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 02/10] enic: add admin channel open and close for SR-IOV
Date: Mon, 13 Apr 2026 17:21:22 -0700
Message-ID: <20260414002122.3734230-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-2-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-2-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278247-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C923F4679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add admin channel open and close for SR-IOV

Introduce enic_admin_channel_open() and enic_admin_channel_close() to allocate
and initialize the admin WQ, RQ, two CQs, and one SR-IOV interrupt for the V2
SR-IOV PF-VF mailbox communication.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> new file mode 100644
> index 0000000000000..d1abe6a50095d
> --- /dev/null
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> +	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[0], 0,
> +				      ENIC_ADMIN_DESC_COUNT,
> +				      sizeof(struct cq_desc),
> +				      RES_TYPE_ADMIN_CQ);
> +	if (err)
> +		goto free_rq;
> +
> +	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[1], 1,
> +				      ENIC_ADMIN_DESC_COUNT,
> +				      16 << enic->ext_cq,
                                      ^^^^^^^^^^^^^^^^^^

Does this code use the wrong descriptor size for the admin RQ's completion
queue?

The admin WQ's completion queue (admin_cq[0]) uses sizeof(struct cq_desc),
which is 16 bytes. If the admin channel handles PF-VF mailbox messages rather
than data packets with extended metadata, will firmware still write standard
16-byte completions here?

If so, won't allocating the ring with an extended size cause the host polling
loop to look for the color bit at the wrong offset (e.g., byte 31 instead of
byte 15), causing it to silently miss incoming admin messages?

> +				      RES_TYPE_ADMIN_CQ);
> +	if (err)
> +		goto free_cq0;
-- 
pw-bot: cr

