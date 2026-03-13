Return-Path: <netdev+bounces-267242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOXhCOJbs2nfVQAAu9opvQ
	(envelope-from <netdev+bounces-267242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:35:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE427BA65
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE2B30B9B4D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF2213E9C;
	Fri, 13 Mar 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHxgBBXC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FD1F4C8C;
	Fri, 13 Mar 2026 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362030; cv=none; b=YaL3NgW/ZsmgRQRBzKmNckmmlCN8GEIdHMVZ4Kb/mQToq7URkk6af9c/dNyNIQ4o1ND7fisWkaqAqu1YnJvKgJZLO50qLFlvEUNRkTUWJJmhKzgFZqTMGkYTCJ0bwW50L1sAoWW/oD6XZEVzPWs1Mfg6QVpzt9vD87Yjbdt9jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362030; c=relaxed/simple;
	bh=WZE3A5bMCdIsmSSV8Gu15uOE9e48iXTGvQrAbHKmUMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IldiFiNLIbOkwMNDTLPyBqETjiDaQN8EjqtqrjnPK/0+MoKF7LF8jD5soicD2Q0/JS0BYRrvE2L0Z8/uIXEMJFndoMb+wrcCOah0/0o4cdWNUYM9N/lyMsbdqXX0m7zqXyyxHhr1gaJ8X2qeM/ukWS4njD8ijnK9yhQDPSU/hAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHxgBBXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A41C4CEF7;
	Fri, 13 Mar 2026 00:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773362029;
	bh=WZE3A5bMCdIsmSSV8Gu15uOE9e48iXTGvQrAbHKmUMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHxgBBXCeqb11zNHvhv4W9wsZNcgFOOi8M3cjfFSehbZoli9d1nnA7BWnv30+O4xF
	 nIMJHTE94tkuvbEstxctjalPe2Nc2EVYmdixuXyq2gWNLWy4ffNSTt3Ar6NBvlsM0y
	 AeGV4JM9T/rxdqB7i1p1XDBNJhNvTLGP1j4RWhyvtdVwxnbxXcPa3MGQH0E0vEUXGq
	 Gc2Xa58Q8JQ/K2LUK+CZFdjjcA+ABJbPEZX3rlmq5MwC/FTB7FU7FAHOo2wb1IbYu/
	 rwBtn7tw46UIqNUgKHE0u3XjZ4NzTRUHDR8m2pV5Hof6M65hlZBIV/uiWManenahIg
	 msK4JP2Q4dV2g==
Date: Thu, 12 Mar 2026 17:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <20260312173348.4e70cdec@kernel.org>
In-Reply-To: <abCUMtO8Trtzs23d@mini-arch>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
	<abCUMtO8Trtzs23d@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8FE427BA65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 14:59:14 -0700 Stanislav Fomichev wrote:
> (build bot seems to be confused because f620af11c27b went via bpf-next?)

The pre-req is in both trees now. Please repost?

