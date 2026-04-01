Return-Path: <netdev+bounces-273858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPKPC2qGzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:43:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F545373F9E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D803090929
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C735364EB8;
	Wed,  1 Apr 2026 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1kSCNin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57551331222;
	Wed,  1 Apr 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011080; cv=none; b=CfmJn0y/T2daGyM1h720bOc83tcx16wHAhIwWrUqFjHQ+822/kcKF3ETBKVO1eFaO73LuLw0ayJnB4hmN/YMOVwVkPe0FpG7IWkLyc1UK0sVMScyBxk0UAT5rgir/rTsCBI+Gd+B+pqGUqfjreRNVZuY+cTdVb90u5jCQ3aSB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011080; c=relaxed/simple;
	bh=A+RB6JGUeAEBCg4Z/JBgdEUQk3yuJJc+YKKQ5mG0VL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUjLe7eagKZGh3gP4sX0zlSeGeLyYzSx53mA3TV2L3inObi05D2oYlXR7makw5KdtDHqkmDOnEXtHo7yE95QJVjDB/6+jrexN1lPBQ8tuvXpNQ/EtYVUQdPVA+GDea4UMw04x5tQFxzG+OkJhBa+LIpCpZGWhUsWGUAtd55dK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1kSCNin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47162C19424;
	Wed,  1 Apr 2026 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775011079;
	bh=A+RB6JGUeAEBCg4Z/JBgdEUQk3yuJJc+YKKQ5mG0VL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1kSCNin6Ld1by/IDHyUNGG2uTJaD8EA2WloLn3jzSNk1/ysX6SvAhnGhpH8Mf/kH
	 LioZ40bIG+ZBFkLm08vfxl2Nf2943xVxHMO5mcVSKhn9RYXldWnFRkJLpAQuZZzhfo
	 qoAruyvNP9m64AgK4paCiBP3tuVcAibUdMo85lYXt9E8b2PSJtTtzNOB313bv4wKR0
	 L4L1fSqPmNFWpw08geE5EoqeyzVMYl1pfhhcDbkOQkNUQ+4Gn2v0Aq6FjwOJBN79Pw
	 YxF6XgVWZ7taJx1GilkLs/l0GpZuN2890ERz4oMMD/1rI5yM5qzbWwLmEx4gAJcgJ1
	 8Fy4ZqE590HHA==
Date: Tue, 31 Mar 2026 19:37:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, fmaurer@redhat.com,
 liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] net: hsr: address functional and
 concurrency bugs
Message-ID: <20260331193758.5dd027f6@kernel.org>
In-Reply-To: <20260329112313.17164-1-luka.gejak@linux.dev>
References: <20260329112313.17164-1-luka.gejak@linux.dev>
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273858-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F545373F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 13:23:09 +0200 luka.gejak@linux.dev wrote:
> This series addresses four logic bugs in the HSR/PRP implementation 
> identified during a protocol audit.
> 
> The primary change resolves a race condition in the node merging path by
> implementing address-based lock ordering. This ensures that concurrent
> mutations of sequence blocks do not lead to state corruption or  
> deadlocks.
> 
> Additional fixes include correcting asymmetric VLAN error unwinding,
> enforcing strict supervision frame TLV validation, and improving Netlink
> error reporting for invalid interlink attributes.

I think that patches 1 and 2 need to go to net with a Fixes tag.
They look like run of the mill bug fixes. 3 and 4 are logical
fixes and change behavior so net-next makes sense.

FWIW AI has something to say about patch 3, I did not investigate:
https://sashiko.dev/#/patchset/20260329112313.17164-2-luka.gejak@linux.dev
-- 
pw-bot: cr

