Return-Path: <netdev+bounces-268352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH/2NV6cuGkzggEAu9opvQ
	(envelope-from <netdev+bounces-268352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:12:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803972A22F1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5DDB300A3A6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B49433AD;
	Tue, 17 Mar 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZrcneah"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5644C81;
	Tue, 17 Mar 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706322; cv=none; b=ibgn1sjksTPFPNKHl8Hs81s12eybEzlv7UL3rz4TNX1QnBcbtIpxWvqci1exqwZ3suFIpqJQ5yyokFYlASAPMWkfls+f1afcUODXWLZO2/tFgyDMT5faFsyuzwBEWVAUxVAqQms7AFVQyZOhwLcQLvVwZ5CSykhyzvctRP1try4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706322; c=relaxed/simple;
	bh=DJ9RjG5UhddWGguy/GOk4PvceX8EgZeJFZoa6ynxLe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NS3vi6ttiBa6RHbTlnaYmqy0yEwsr2ctT4cDn4PDXP2d4c7kXjWWkHo+T8jxr9wZVGjSMpyvStK8RJVBCkGuW9Z/GQ1QJGKZlkL2jI5sGxrSwHoqnlvwhtH+toPWli9HDpAgm6ovCwLv2QnuCX66B85PmnCfMxU9zrhK1YcUtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZrcneah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B0C19421;
	Tue, 17 Mar 2026 00:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706321;
	bh=DJ9RjG5UhddWGguy/GOk4PvceX8EgZeJFZoa6ynxLe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZrcneahdGijQ7SSQyDiAMbnA/d7mXX3m2OO7JyXAQFnz4mB1gYH4tMY0aSibeo4J
	 1XdPnd1W0ASu1icr/wD45LP90NBwuO62kf0Z95n6iBc3dj7KlJFhSGlyU10Ow8JRMa
	 g7imzi/ONduuMRwZjDyiDGnEZoFhhnpMAUPLC0DHwyyQO8+CCPKkBu9MnqzjR5T2vd
	 AcfFUedixC9IEtnk5KMpsRiWPNxy/vfkpmtjBh7lax9EZ9mDDGJgDAo5/J/Unlljrj
	 4IjxJ7Vwm92zzPU3GIwsZuN9Ym+VCJADQY0HLbS2zl+KDg59sJ7xHfDPOgHG9rI4Ee
	 31pjYXF4S+hWg==
Date: Mon, 16 Mar 2026 17:12:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <20260316171200.4b8a96a0@kernel.org>
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-268352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 803972A22F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.

Acked-by: Jakub Kicinski <kuba@kernel.org>

