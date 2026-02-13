Return-Path: <netdev+bounces-258548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEH6IvOUjmmhDAEAu9opvQ
	(envelope-from <netdev+bounces-258548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:05:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDC1328A8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBEE30D1437
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECC8405C;
	Fri, 13 Feb 2026 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0TYAR1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5822F767;
	Fri, 13 Feb 2026 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951857; cv=none; b=LKg6Yt3VJkbY/umckozT3WAyI6scG5yM6IDWXq0MXq980qyiX8yfZbwJ0KqMSmqc/ZMYupuwG7jsr+xb3CEVJwS+dVx0jwRNhEeX34HCZ7wf8Koocvc/3lH7kq0TCt8bRM4GSrYn/VwntcbKhV9PNHgJTyY8/WQV56qUndhYpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951857; c=relaxed/simple;
	bh=BX1vEvJ79H/cZ+Ka6sjVSB7ELGI+KoPTx5pSnLZmajw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWYplSHVNFcZoUEFOV0LsUGgr1osJIK1cGIJjQxSEW/qKe6QKxakhL+2bEXbq1XzvSicZLa2krc5UZryCGSriuHWtGcWiskzCqeNHk1Jzy7+CmK5OwhYQiGfqeOgfWG226Rx0P4OB9F3AXI1eOLXUFm7PcEKNuwwEq7AhSPP70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0TYAR1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4523CC19422;
	Fri, 13 Feb 2026 03:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951856;
	bh=BX1vEvJ79H/cZ+Ka6sjVSB7ELGI+KoPTx5pSnLZmajw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0TYAR1adlK03UOD0n8Yu+Ac63dye3kePshwLumrdtm9R0WUfVQnC7a+gGurYsKMc
	 7DdRDadHVSsFx4guG7jCyhynaMJb1nioce2+S/VRniFL13/A63Gwy7gY0GhatBrHdJ
	 l84O4VeLQ/vqDQqVPOqs5Y6ZbGnoDgsv2AMjqmAvI5YXxtZlZoOB+aFcyNDB9N7HBc
	 w9FAAPBHm3/H3V0mzBP6UhCXF3sCQV+DAbbLqgh7ZqgjlDQ7T7sPqKfq5aN5CeWk8T
	 Mq31/K9wmZKqufQb5K/1t5u70nKStqgf98zMaHWhikQ5edM79dX3ISYfJSoTu4tUgo
	 Y08bPQnvKqWlw==
From: Jakub Kicinski <kuba@kernel.org>
To: nikolay@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	idosch@nvidia.com
Subject: Re: [net,2/2] selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning
Date: Thu, 12 Feb 2026 19:04:12 -0800
Message-ID: <20260213030412.1483679-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210144812.1056554-3-nikolay@nvidia.com>
References: <20260210144812.1056554-3-nikolay@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d5d1b7343531d17bd3c5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: DBFDC1328A8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning

This commit adds tests to exercise different ways which used to trigger a
warning in the mdb_n_entries counting code.

> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> index 3da9d93ab36f..59d2fa3953ea 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh

[ ... ]

> @@ -106,6 +105,7 @@ switch_create_8021q()
>
>  switch_create_8021qvs()
>  {
> +	log_info "802.1q mcast_vlan_snoopping 1 tests"
                                     ^^^^^^^^

There's a typo: 'snoopping' should be 'snooping'.

>  	switch_create_8021q "mcast_vlan_snooping 1"
>  	bridge vlan global set dev br0 vid 10 mcast_igmp_version 3
>  	bridge vlan global set dev br0 vid 10 mcast_mld_version 2

[ ... ]

> @@ -1334,6 +1405,21 @@ test_8021qvs()
>  	switch_destroy
>  }
>
> +test_mdb_count_warning()
> +{
> +	# Tests for mdb_n_count warning

Should this comment say 'mdb_n_entries' instead of 'mdb_n_count' to match the
terminology used in the commit message?

> +
> +	log_info "MDB count warning tests"
> +	switch_create_8021q
> +	setup_wait
> +
> +	test_mdb_count_mcast_vlan_snooping_flush
> +	test_mdb_count_mcast_snooping_flush
> +	test_mdb_count_vlan_state_flush
> +
> +	switch_destroy
> +}
> +

[ ... ]
-- 
pw-bot: cr

