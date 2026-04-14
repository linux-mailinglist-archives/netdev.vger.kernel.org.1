Return-Path: <netdev+bounces-278254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GoiAuqJ3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BB3F4757
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCB7306A40B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2822FE0E;
	Tue, 14 Apr 2026 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYSXayNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1C2264AA;
	Tue, 14 Apr 2026 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126154; cv=none; b=M/cq+J8wno2Qi3FZj3Ag936nW7cfy5uRoQahSgCpHUeRBfnFDciwSfPdRvA59kty9MEx/1QASrW/fXu+G5cAhkSaPUpr3sMQSvTMXntLYwnSiZiyRzEWW67H2JC/Cy9MgfaJwDgD1/b++T8VBSnOmws8k8p67rcJpshCJ6cSpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126154; c=relaxed/simple;
	bh=XOfgEJYjqma+BzsGYWlqFoscE+Gml6sFy3kxIYJhuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdRs88t53K4ZcUrn6v+HVqe+xd8l6wrYjMuEv3d+bUcEZJ7o9IEuvZZtIGyqnRq5nMxbzXm4C8KdRYjqP7ZpTSjfzJAmiXTxXjwnaXrhybxKhcvzXGAdcqrcfGzyVqnmGI4BWs9D7ifBybJ8EkssxA73/kSiF+Nwx+OkSW2MDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYSXayNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B2EC2BCB4;
	Tue, 14 Apr 2026 00:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126153;
	bh=XOfgEJYjqma+BzsGYWlqFoscE+Gml6sFy3kxIYJhuk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYSXayNJMURvZBdO7gN8uQBW90L6WaHRwIKQ4MuJoyDz5ISj/l61qe1P0FXe4B5JY
	 ccrJmHfQjyXNGjh17Fpb1EJK/3N1HHQPip5+yFAYAPth+citCyfhH7BE3ag7Weolev
	 KOH0FnszsZKv2XiTzCZBCyJui/2IKea8E0V0AhcYUcQL3PfIeZdfs+ep3bcKIQuOOi
	 xQWGmS336fpdiVzTvtDeZj9zb8DQUx1ZlN4k1uv2tLJnOgCBc0YZf8ZxwEvd2t9P75
	 5hOvN475xE/DAY7i/ytJzFCN2x7u1ZbRcM4pWaIjIwGOb79AwCaUBOkghFb4X7zZWl
	 hNXnO9TaDmUYQ==
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
Subject: Re: [PATCH net-next v4 09/10] enic: wire V2 SR-IOV enable with admin channel and MBOX
Date: Mon, 13 Apr 2026 17:22:32 -0700
Message-ID: <20260414002232.3735295-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-9-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-9-f052326c2a57@cisco.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278254-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 652BB3F4757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: wire V2 SR-IOV enable with admin channel and MBOX

This commit extends enic_sriov_configure() to handle V2 SR-IOV VFs,
allocating per-VF MBOX state and opening the admin channel before calling
pci_enable_sriov(). It also reverses the order in the disable path.

Note: The format of this report is altered due to recitation restrictions.
The original patch code is not quoted, and a free-form summary of the
observations is provided instead.

In enic_sriov_v2_enable(), enic->num_vfs is set and ENIC_SRIOV_ENABLED is
asserted, but is the enic->pp array reallocated to accommodate the VFs?

If enic->pp remains a 1-element array, could subsequent network device
operations bypass the vf < enic->num_vfs check and calculate an
out-of-bounds pointer for vf > 0 using the ENIC_PP_BY_INDEX macro,
corrupting the heap?

Is enic_sriov_configure() actually registered as the .sriov_configure
callback in the enic_driver structure?

Because the function is marked __maybe_unused, does this leave the sysfs
interface unable to invoke it, making the V2 VF dynamic enablement
unreachable?

When enic_sriov_configure() is called via sysfs, it mutates enic->pp and
enic->num_vfs. Does this happen without holding the rtnl_lock?

If concurrent network device operations running under rtnl_lock validate
the VF index and resolve enic->pp right before the sysfs path calls
kfree(enic->pp), can this result in a use-after-free when the stale pointer
is dereferenced?

In the SR-IOV disable path inside enic_sriov_configure(), the code frees
the existing port profiles array and reallocates a single element with
kzalloc_obj().

If this allocation fails and returns -ENOMEM, enic->pp is left as NULL.
Could a subsequent NDO call targeting the PF pass the enic_is_valid_pp_vf()
check and crash when dereferencing the NULL enic->pp?

When V2 SR-IOV is enabled, enic_sriov_v2_enable() calls enic_mbox_init(),
which unconditionally executes mutex_init(&enic->mbox_lock) and
init_completion(&enic->mbox_comp).

If SR-IOV is disabled and later re-enabled, will re-initializing these
active synchronization primitives over their existing state violate locking
rules?

The commit message states:
"The existing V1/USNIC SR-IOV paths are unchanged."

However, in enic_remove(), the calls to enic_dev_deinit(enic) and
vnic_dev_close(enic->vdev) were moved to execute after pci_disable_sriov().
Additionally, the enic->priv_flags &= ~ENIC_SRIOV_ENABLED cleanup was
dropped.

Could the commit message be updated to reflect this behavioral change to the
hardware teardown sequence, or was this change unintended?

