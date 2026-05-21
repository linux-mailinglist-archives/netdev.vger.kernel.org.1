Return-Path: <netdev+bounces-290497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFyJEgAuD2r+HQYAu9opvQ
	(envelope-from <netdev+bounces-290497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:08:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44D5A8E74
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C22034D9F12
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A72402BA1;
	Thu, 21 May 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qiN4WNsM"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EA3DA5D9;
	Thu, 21 May 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374029; cv=none; b=vBXVTEcQRk9T8egzQdP1gKzYS3MHQMNIpP64y4F/HfFV6btpi2EZsDBM01PMwWmvI1hhcXn9WntYd1B6DQGZXOL5DtwUhmrZDAkGgAD2XUx2BZsvRF6uIBieS309yE4gHQwW9JARqJaIdC2UnOjIYsr0/5UTbqqSVKV+KjmbRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374029; c=relaxed/simple;
	bh=0f0JcxPSMeZgDLB8kRDPnqGxviBR5km7oxybzD3GN9g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gWIKdycTfBHlyDN7v9mL7ow+QM3oExHjSbjl2K5Dkns5gvwYnWZ+LadVu8rO81yNGl/h0BDKbyEIbO5NEWt9t9PAr6cwTfauUA6+3O0ANsyy8BVquLGkYmhfHApF2F+en8A7XzDduuxvL1/C/Gg9xJr9FZg6ICIAT+WJDIqk27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qiN4WNsM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XtLHiW1Hy34yQSEJx/APJIZCCKJAzzXN1hrjcEjhY2I=; b=qiN4WNsMBjHyc0h9nLuTe/WusE
	xFB2dcNQeGuYBD/4Tu+g3ao2VQSZjyt2wcpeKus6HrjcEjy0zhUVDWQyhJ6c7CXwuoLCYnK1l0q38
	epWhfczn7J/VT0BYM27jf3JmIHXVaXnbriiBH4NF/vReuX2mkArTve8Bl1CbiueiGCMm6zNO0PVh2
	+EpynK8sjfvAgIEQ+7/hCaiaf4HBXRUyKYd8o5PTdJhuOeCTT727wpTECKzquOc1DwXU9hQadZLkl
	zFXBv3epLtpAbtQzqOd16lmsx+Wyi06FGxR0lBYvKEou8tPwQBRL+JEZkwKH2N7zmvGe4ni0IqUQI
	DlcImYqA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ4Sj-003wwy-2e;
	Thu, 21 May 2026 14:33:26 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v2 0/2] nfc: llcp: two fixes for nfc_llcp_getsockopt()
Date: Thu, 21 May 2026 07:32:08 -0700
Message-Id: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGgXD2oC/2XNQQqDMBCF4auEWZtikiZaV71HkaJxolMkSmLFI
 t69mC67ffx8b4eIgTBCxXYIuFKkyUPFZMbADo3vkVMHFQOZS5Nrobij7TmOlsvCXUulTSmUhoz
 BHNDRlqQHeFyg/o3x3b7QLqdxZgPFZQqf9LeKFP/Rq+CCK2UL425KOGfuHbbU+MsUeqiP4/gCJ
 rkU37YAAAA=
X-Change-ID: 20260513-fix_llc-27f483568135
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Heidelberg <david+nfc@ixit.cz>, 
 Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=leitao@debian.org;
 h=from:subject:message-id; bh=0f0JcxPSMeZgDLB8kRDPnqGxviBR5km7oxybzD3GN9g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDxex3+o5dACgpZfaTA1duJ7LARDnjXI3wTfza
 x/DgZ+u01CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag8XsQAKCRA1o5Of/Hh3
 bbC9D/90dmmzwrhVUlBQUjsTiCfv78Tn6nJ3evWXaQaYB7Y7mGQoSy/NKmmakXachDOaGd3rkwK
 H6hpyVJ2wHF2HWkk5M+ZFqvjbDGGGWn28ETJgThjqpFdHnHAMHAvM+SYQgVYMNPmzPMHDNqj7GP
 ET3IcbPa7fUksNxaD1MXBq0bwtQjsJ7XtUTTgPFXUmCOxCd9qQuJLzWLJy7ilYEmWcATe1rrDL2
 p4+NISh68mF6Ze4bRLDhpT2guix/jJrw0rmDGRqM/9TDVEVkwoA430MiNANoy1w7L/JxQAaCoEZ
 ovrgyz7IsytTCOUtNVZdtTCWGMO1Zb/ByJCjhhpgQqelJUCo+PO3okxdbEyTc6Ct/BHZ8rPJg6T
 w4hyE1wwHHvZc+dUj/NkmbsexENqG6kt3WvX6aMC8KkIdUIRkggFFUPwsvKTNQLbhGEGflzFynr
 U/jZzxNhFqepT9LC3eVE4E0Z50GVPU+aC33zGXn3ARcUWlP1S3LU183Wl1NDKPAnv0cu+x2BwLb
 l/U/rejB/JuBaIiLah71rSVYeoIS2nUliMH+SbBTayj6FrJ78f0NfADX2l/VeVZ/HGdlrQLqqaf
 E4lP3/tepZKGFTX02cCvCerZKJpGczX7Ryj61cMOttficTwMipuqfTGgK346IguqUbU2Xw4/qK9
 F0CUiEjK2gGDrpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290497-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,ixit.cz:email]
X-Rspamd-Queue-Id: AE44D5A8E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While converting the NFC LLCP socket layer to the new getsockopt_iter()
API, I noticed that nfc_llcp_getsockopt() unconditionally stores four
bytes through a (u32 __user *) cast regardless of the caller-supplied
optlen, overflowing the user buffer when optlen < 4. Patch 1 adds an
explicit length check (with a signed-int guard so a negative optlen
cannot slip past it) and is what I originally sent as v1.

While reviewing v1, Simon/sashiko[1] pointed out that llcp_sock->local
is read outside lock_sock(sk) and can be freed by a concurrent
llcp_sock_bind() error path before getsockopt() dereferences it. Patch
2 moves the load and the NULL check inside the lock. Both fixes target
the same original commit, so they are now sent together as a two-patch
series.

Note: These fixes were compile-tested.

[1] https://lore.kernel.org/all/20260513-fix_llc-v1-1-33c76f931ff6@debian.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Guard the length check against negative optlen (Simon Horman / sashiko).
- Add patch 2: move llcp_sock->local read inside lock_sock(sk) to close
  a UAF race with llcp_sock_bind() (Simon Horman / sashiko).
- Link to v1: https://patch.msgid.link/20260513-fix_llc-v1-1-33c76f931ff6@debian.org

To: David Heidelberg <david+nfc@ixit.cz>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: oe-linux-nfc@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Breno Leitao (2):
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

 net/nfc/llcp_sock.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260513-fix_llc-27f483568135

Best regards,
--  
Breno Leitao <leitao@debian.org>


