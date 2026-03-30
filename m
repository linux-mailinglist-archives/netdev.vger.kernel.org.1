Return-Path: <netdev+bounces-273217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEVoHnKPymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724335D4AA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5107F3194118
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEE30F523;
	Mon, 30 Mar 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7PakSWL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60E3064A3;
	Mon, 30 Mar 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881407; cv=none; b=pVMa/TN1Uj2TTAcbY+ULOd6a+WgKE0F2PVCKyvZZh+2RZmvUA1PLx7tgepFjiRkgAkkLtUvTbjPU9pOU1lt8x01YqmJQDtrP+6n/aemvBSbr8VtAlgei72+vAd2aSmY4FvG0IZ6I7bs2lWoH0tL5VfDXpLY6PoUgJ43wknlNxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881407; c=relaxed/simple;
	bh=oHxTxG2Nh5IuTVNHul4winSqHGDUCAQCu25ksvmIBVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NHWox4FYB2pGHy5LJRZnuEut2XSBhVs/FpdiayiVEKYdLt0MZ8/TnXRN7s1Jdx9lMJXmdLJ0IzxPmhUeQDLx7ByzU66J80SLRi6JkaxvTd2j2ChRCmJgtVzeqX/GDOPIzPz/R/4wlIaAycMPTDAC67gOPhHkWbbPjIVT7/N+nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7PakSWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E5C4CEF7;
	Mon, 30 Mar 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881407;
	bh=oHxTxG2Nh5IuTVNHul4winSqHGDUCAQCu25ksvmIBVM=;
	h=From:Subject:Date:To:Cc:From;
	b=j7PakSWLOFyQ9f13rZmL3pOGcETVRjYYKiEVAgy8v78aYsDD8H+CxaoGROn3MayUx
	 doXXPzdnOb1bZuw3w+WaEH/YhIySAdLjOssUVEQ3DSC6fVdlqK9P8JlRvXYXx8qGTU
	 h/I7MTARSMPI1b8W02tplyKm7KrS2D3h6ecBm9+H3AvMG2fLWdUCXxTzqbvPeitohq
	 eBdCr8ca2nquBUQCRb+toYcSM7YR51lSvAkp2c0Vv0ICP9cjC6LSeAH5muW310GOpn
	 DuRjYusnqDKJRm23r43UCdNG0VJbQDKH/82usAWx6sVsdPrt3t+twwn4InRwcnkgal
	 GRnf5Gbmi30IQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v2 0/2] Bypass usercopy hardening for kernel-only iterators
Date: Mon, 30 Mar 2026 10:36:29 -0400
Message-Id: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2KymkC/yWMQQrCMBBFr1Jm7WCaQEWvIi6ScWxHMAmZViyld
 zfR5fv89zZQLsIKl26Dwm9RSbGCPXRAk48jo9wrgzV2MM4OGNbsVXGpHlLKKzo+uX7oic4mQNV
 y4Yd8fsnr7c+6hCfT3DrtEbwyhuIjTW1KRUaJx5fXmQvs+xe5Jh4IlAAAAA==
X-Change-ID: 20260326-bypass-user-copy-3e73161cc90b
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=oHxTxG2Nh5IuTVNHul4winSqHGDUCAQCu25ksvmIBVM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpyop1Jk/zlwbCvkynME26o1jUl+31D3JmnYXkj
 RD9wDp9nhmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacqKdQAKCRAzarMzb2Z/
 lw1QD/9kD5ulEQARWAHavD0+hXtMU0Ng5VqMewVWz7E7mSSOEoGmlLwwlE22m+JOzl5D299UJac
 QqtZnRnLv7pCt8c7TdVpxHb8EliZS39Thlm7xJggrIo4zu3SdLbAI3frihW+Pp52k3KrQ50yBka
 tHh1gOnzD6bH+T+vR2KiFXuZs+Cixd5f1VsaMF7PylVYX6jXPim2shkNr5CVLatOsUateABBfe1
 xG6QRAFwph7eseyV3G71KQuDhdEdhkBQX9r76UFPdLvG73DtA1BUzkApFE1pJWtDGougMnye5qL
 mKnxAe9hGenFNz/Z+B6R/PJyv7SOS1jfc+1LWpJpPldb1Z19y01nRvLc6hNJodVLEqGpoIKz0kx
 ieMwFUm3fCiVHakyzTtZFRU9BMioiQfwx5RwZ4aJTe72WqSTyr/InpNio8hZYompQNQnsi7mYDY
 c3cks8TRfdqIuoxnYp3whvcjXqKsNbR43GiRhxP+S9GOfMolUdmjgO5pOzs8YffKTYmwGjue64N
 MdMzfEaUCn5nhRWO4VuqhhhEx5l35mwIp610M8365zxW5uJqqZI/jREYqhKP5x+sO65HdhEwtis
 6rgM8HJmx80zct0jVo2YYcQ+BmW+PhLwua7NMc5IAy59bTTMAUNwDKssNNNRvPGpCsNersJtROY
 V8qS+Be9A/xaGAA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid]
X-Rspamd-Queue-Id: 1724335D4AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Profiling NFSD under an iozone workload showed that hardened
usercopy checks consume roughly 1.3% of CPU in the TCP receive
path. The runtime check in check_object_size() validates that
copy buffers reside in expected slab regions, which is
meaningful when data crosses the user/kernel boundary but adds
no value when both source and destination are kernel addresses.

The fix splits check_copy_size() into two variants: the
existing full check, and a new __compiletime_check_copy_size()
that retains the compile-time object size assertion and the
runtime overflow check but omits check_object_size(). A
user_backed_iter() test at each call site selects between
them, so user-backed iterators continue to receive the full
validation.

Patch 1 applies this to copy_to_iter(). Patch 2 applies the
same change to copy_from_iter(). copy_from_iter_nocache() is
left unchanged because all current callers pass user-space
addresses; the bypass there is deferred until that changes.

---
Changes since v1:
- Updated commit message for clarity and completeness
- Rename the check_copy_size() function (Kees)
- Added __compiletime_check_copy_size() stub to
  tools/virtio/linux/ucopysize.h
- Add second patch to convert copy_from_iter()

---
Chuck Lever (2):
      iov: Bypass usercopy hardening for copy_to_iter()
      iov: Bypass usercopy hardening for copy_from_iter()

 include/linux/ucopysize.h      | 16 +++++++++++++++-
 include/linux/uio.h            | 18 ++++++++++++++----
 tools/virtio/linux/ucopysize.h |  6 ++++++
 3 files changed, 35 insertions(+), 5 deletions(-)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260326-bypass-user-copy-3e73161cc90b

Best regards,
--  
Chuck Lever


