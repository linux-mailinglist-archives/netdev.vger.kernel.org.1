Return-Path: <netdev+bounces-252633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGpUJHsEc2kFrwAAu9opvQ
	(envelope-from <netdev+bounces-252633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:17:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1370669
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2EB300D44D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A1396D33;
	Fri, 23 Jan 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avd5wCx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDF399012;
	Fri, 23 Jan 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769145461; cv=none; b=qhDVwTIP8dMxUlTqqAmha7r8YUtB1C8PXHllk2qSAEVXXF9lSFvLsen9KaOxm503nHJhzhrW0KzmbulSVTE48HWokw4hxmDYnvyE1BuNkcdH6sRBaW7a1HAy7shaxBkW1+bsOCjoQICAKAAs9rvSv+W/5BmtYgqlcXW/nBxo9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769145461; c=relaxed/simple;
	bh=XnNCLFEKiCy82EsJ9tvO7zc+f/yjXC+Ge8lpJ9mtb5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCBMxTddE8vQ25dMkUbST8XVwX5xD+ZBS3swZgpEOe0qFV7ZmjMkM/o1Nd0BwXCgVhFtVa6EBqiydNLTDtXagVw0XasL4DVCxNa/sEtLC5CEaXEaj6lDfCAkqBEif9T4uZgl2OVQFUExWKDN6+Be9HS2ajQafiWx+AEerFZt6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avd5wCx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7271C4CEF1;
	Fri, 23 Jan 2026 05:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769145460;
	bh=XnNCLFEKiCy82EsJ9tvO7zc+f/yjXC+Ge8lpJ9mtb5E=;
	h=From:To:Cc:Subject:Date:From;
	b=Avd5wCx/0hYxsszoNp4BGSI5l29TCjbJgOPdtau6qgl9XtuWVk8ckYEmZt54W0eAf
	 H/Qb3oMIcW752w5sitEG2lm3XeM8gE0nfzv5NCbjjEpMwsEXy+fEzgZJGPq2k0Zqak
	 qH6jeULU1g+dW3frXJPcsMAiTR7t8cEaFRzx1OJqxkXpi6vfotv44mdgvNzRIWTRwg
	 aDRtBM/Qyw6sOiC59U+vBYtULdRbWohRypZo9Yr4YA/GXtAYH5I9rAlkFBdcxWMET4
	 +7IiLiUdBmldkHaTSO42frvjX//9wwMurhCc9cVZ1xeRD38gPNImNMfLfnZXMKAjzJ
	 pcPRzxdYPyFCA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 0/2] Remove low-level SHA-1 functions
Date: Thu, 22 Jan 2026 21:16:54 -0800
Message-ID: <20260123051656.396371-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252633-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15C1370669
X-Rspamd-Action: no action

This series updates net/ipv6/addrconf.c to use the regular SHA-1
functions, then removes sha1_init_raw() and sha1_transform().

Please consider these for net-next.

(These were originally patches 25-26 of the series
https://lore.kernel.org/linux-crypto/20250712232329.818226-1-ebiggers@kernel.org/ )

Eric Biggers (2):
  ipv6: Switch to higher-level SHA-1 functions
  lib/crypto: sha1: Remove low-level functions from API

 include/crypto/sha1.h | 10 -------
 lib/crypto/sha1.c     | 63 ++++++++++++-------------------------------
 net/ipv6/addrconf.c   | 21 +++++++++------
 3 files changed, 30 insertions(+), 64 deletions(-)


base-commit: 31d44a37820f00de8156d1c1960dbf1bf04263c2
-- 
2.52.0


