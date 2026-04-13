Return-Path: <netdev+bounces-278238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIlOF+GE3WnIfAkAu9opvQ
	(envelope-from <netdev+bounces-278238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35863F4591
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96E203014FE6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430AF39DBE6;
	Mon, 13 Apr 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6wRdvaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204151C68F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124607; cv=none; b=sBtj2zxBXxAMkF1/VOumK3vLW8WxUpVTmIE7KRKW7Z0oToocGvolrsTdBslJTdA0LrNOo3hgNoLkVIZx9qJPQy5HPrSOGu3CCLVOTScyeuKlKzSDhOklPtwtDaL6IyWBHL2KL7s0A+fhPqZBbX0LquceyJAZNP7qDM/II337iAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124607; c=relaxed/simple;
	bh=CFGeTAKPaBGwZeDreIhtB8J0ZiI+bc0wBTpH0lEB41k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu4o2+VeGWuV9EEy9OOCKk9vr6ghQol0wcCfoEwAXyAdtmZ/fAzfEUW+4YfCslpjsahAf9XcsIdSNI22SmU2D2MgH4pgBOyunotqdGtFQ5NSv+BsPLNVa8mcdrCYMpE/Qs2jkjF1Gmv38jdu1VqmVZCFDUQ0sSREC2yjkvVNpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6wRdvaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A364C2BCAF;
	Mon, 13 Apr 2026 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776124607;
	bh=CFGeTAKPaBGwZeDreIhtB8J0ZiI+bc0wBTpH0lEB41k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6wRdvaPfkxlcXKnNkpYKNjX8ZIX6Yn2Klow5bv/EwPS9Oi9JxH9rLLJgFpFDVnYM
	 gb+IlnqfHVVSAbnBrVnucQ5mwu97F7Ck7FWzX80x6ZLO+U2Rsjdb2ziI8b+YCjus5n
	 orlGqzaHTx7GrfzbzBgzHrOUIzuqXvIb9Xwdptabx6LHnQXe7O9PX38AVFtU+tSovL
	 EagKZCA1Z89henFYvMQ8zGju3Ezr3Cs9NkUDAZlo1STClEYRFxYHK1QwMpKhqqpcrW
	 7sBLMwa6B5Iey2PizmqllAu8H8SmHGNtLHuvMJZJnJ5HSHVJbMG2TV9MD+6GrBrxTd
	 oNSphCFCi4Igw==
From: Jakub Kicinski <kuba@kernel.org>
To: antonio@openvpn.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ralf@mandelbit.com,
	sd@queasysnail.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [PATCH net-next 5/5] selftests: ovpn: align command flow with TAP
Date: Mon, 13 Apr 2026 16:56:08 -0700
Message-ID: <20260413235608.3699773-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412221121.410365-6-antonio@openvpn.net>
References: <20260412221121.410365-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[common.sh:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278238-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.061];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test-close-socket.sh:url]
X-Rspamd-Queue-Id: E35863F4591
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

This is an AI-generated review of your patch. The human sending this
email says: "The second one looks legit, would you prefer to follow
up or respin?"
---
selftests: ovpn: align command flow with TAP

This commit restructures the ovpn selftests to use the TAP infrastructure,
splitting each test into stages with KTAP output, adding command wrappers,
and centralizing behavior control in common.sh.

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 2b3f2e5c8cc9d..ec6fea37ceb39 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh

[ ... ]

> @@ -152,8 +263,8 @@ ovpn_compare_ntfs() {
>  		received="${OVPN_TMP_JSONS[$1]}"
>  		diff_file=$(mktemp)
>  
> -		kill -TERM ${OVPN_LISTENER_PIDS[$1]} || true
> -		wait ${OVPN_LISTENER_PIDS[$1]} || true
> +		kill -TERM ${OVPN_LISTENER_PIDS[$1]} 2>/dev/null || true
> +		wait ${OVPN_LISTENER_PIDS[$1]} 2>/dev/null || true
>  		printf "Checking notifications for peer ${1}... "

Does this leave the reaped PID in OVPN_LISTENER_PIDS?

Later, ovpn_cleanup() calls ovpn_stop_listener() which iterates over the
array and issues another kill -TERM on the same PID. Since the process was
already reaped by the wait here, could the OS recycle the PID, potentially
causing the second kill to terminate an unrelated system process?

[ ... ]

> +ovpn_cleanup_peer_ns() {
> +	local peer="$1"
> +
> +	if ! ip netns list | grep -qx "${peer}"; then
> +		return 0
> +	fi

Can this fail to match and permanently leak network namespaces?

When virtual interfaces are moved into namespaces during setup, ip netns list
often includes an internal ID in its output, such as:
peer0 (id: 0)

Because grep is using the -x flag to enforce an exact whole-line match,
it appears this will fail to match peer0 and return early, skipping the
subsequent namespace deletion.

[ ... ]

> diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
> index 4f0367c60fdaf..e97affe727383 100755
> --- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
> +++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
> @@ -9,37 +9,72 @@ set -e
>  
>  source ./common.sh

Is test-close-socket.sh missing the set -eE flag and the ovpn_stage_err
ERR trap?

The other test scripts were updated to use set -eE and register the trap,
which handles emitting the KTAP failure directive. If a command fails here,
will set -e cause the script to exit immediately and bypass the KTAP
failure reporting entirely?

