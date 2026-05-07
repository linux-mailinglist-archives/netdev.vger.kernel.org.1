Return-Path: <netdev+bounces-285248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPbDJ09w/Gm8QAAAu9opvQ
	(envelope-from <netdev+bounces-285248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6064E71EE
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD20F301066A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22D3EDAA0;
	Thu,  7 May 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TRPQwHEb"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10C3EF0DC;
	Thu,  7 May 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151494; cv=none; b=EMIQ4vdT4uLmnHcDiWvoojQf1As5iE40cHFmCq2sK5caSrsrhDslzCOkXf0LP8mrp1ArwNGexLzC/HG5gXHiv1VrHGgunMmaOmrp5uRHk4GdJMbOChU7A6HaBH+5F8a08eiAwlPnoGO7PNd7RKimYx09RecH4i0KfbdILnWRuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151494; c=relaxed/simple;
	bh=9OUTdGAhrGO7HPSBpW+FABM8Uhcs8lMyfb3Gcx7O1yM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rFVytJ2FCxgwMGHGNRaldWLBwr/QnBbeiYrsxFEl7SZZELlItHKWvX2MtS8D+zirrwC530Wpfw0ZumLAngM3VtDIhlZ8qKYgZB68MECmLyutcW/swf69lAhES4oMB9GFEoIupZcCYJAFCQlkq/rJ+SklTzeaAKFD3H+6i2hZBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TRPQwHEb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jR+Qe4bynPS3peoy/mcVrEPP6Gm0C/vr5e+MmwGl5ho=; b=TRPQwHEbcN8UjRFWdupJhNdPKi
	LO4iQm5CuuDWxfhkH43OR453aUjRm5wEN8FtYcKsIO1Zv0sBW8Ro3fzRlLD6HLqHplxP4d/StAbJL
	/L3mCyNRBAid/5L3ULi/Le1mXyisNeQJodfCKi8cMVSper0vFv8uwLJTRCQTYEmG65b2mxjMdoTzQ
	1v5+aOuxEmYe7PgvTQqafFJbZMcGpQ/gF0EtMgQC/A0osOHsAWKCgMu8Tu9stI3FLB3Aes40N6Zlp
	l7WBqG+FE9KfuIDlLYMWE0/5MZg+9bticy0Vu1hncydHkKi3njRmIQHZZ0jmJ3Bb1pzMMnDwnGGyY
	aIUi8OGQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQX-004Jne-2Y;
	Thu, 07 May 2026 10:57:58 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/5] net: convert four more protocols to
 getsockopt_iter
Date: Thu, 07 May 2026 03:57:49 -0700
Message-Id: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5w/GkC/22NQQ6CMBBFr9LMmpqBAgor72GIacsIo0lr2ooYw
 t0NuHX9339vgUiBKUIrFgg0cWTvoBVFJsCO2g0kuYdWQIFFjRVWcqAUvX1c09tLbXSfN3WplKo
 hE/AMdON5t13AUZKO5gTdb4kvcyebNtnGjhyTD589POX7429jyiXK0ho8qlNTIeG5J8PaHXwYo
 FvX9Qth+enQwwAAAA==
X-Change-ID: 20260505-getsock_two-abad19643336
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=leitao@debian.org;
 h=from:subject:message-id; bh=9OUTdGAhrGO7HPSBpW+FABM8Uhcs8lMyfb3Gcx7O1yM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAwmiaQEBXEHCXbpgGdD/hq0K6qRUISkzQSJ
 lYB/g1Fz1WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bbNBEACVeSN/aZEWHrjkqWMXYmo/akAK6yqqHSNbyH4wZyFvAC9uA/mzXfsfS1Ve6CVTOSnj6GS
 IHgcbcmlBDcpTZybO6fnRcO1lx3n/zpc/aWTz7/osUTtjvjrTeOrp7usfJcbyDHIADEY/nhnLsS
 yfAtbVzaSogHCxcbsDzgDOd9RlU0RxHzdOtinhlDlfqnjPliVmwc/FBnWauvewb6xjIImjdHa+e
 Nc/QujUfUDERzSvjrj3EGfzGcPg9JHPkn+p1W5nm6ExLnfhikqRkN7EMxWisUJ8vS+Q7TnfW3kS
 7MF08fzSz/ZM54fSyBrXpigY5MNgl+nVfyRLrnUiLy37NNs+Qs6j8QKb4FuvrvlvsyVIEy9+0uW
 ZWMvH+DU+QyvvHrlx9fBhkPFFpkV45KjJEyZ5I+hzBi5JKhco/n6BTd4P0X0aHP6iWWs0bFPK8B
 SeeTAVJ6lD67m0OKMQSM1TVJluqezZpo4aIaetwcr9CsZuxP9EPRNwK1D0BJ5P3Yhy1FrchH8vi
 cnz+2thpz8E2JO8StSrQp7N/KlcFT4N0yVhziX80zXhovpiZUlwJ7BdrIrpXCFF+J1EF8S2ehCL
 vFTwejuG3Z8qKMQExhNDy9LYurNVdiPtS5v4WSr/Mc7xCi7TzVHCfPe2mUniS872p0NxuAY2RSv
 8vYAOswmuKiaQTA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 4C6064E71EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285248-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

Continue the work to convert protocols to the new getsockopt_iter API.

Convert four additional getsockopt implementations to the new
sockopt_t/getsockopt_iter callback:

  - MCTP
  - LLC
  - X.25
  - KCM

These are mechanical, ABI-preserving conversions following the same
pattern as the previously converted protocols (af_packet, can/raw,
af_netlink, af_vsock): the (char __user *optval, int __user *optlen)
pair is replaced with a single sockopt_t *opt that carries the buffer
length on input and the returned size on output, and exposes an iov_iter
for the copy-out path. put_user()/copy_to_user() pairs are replaced with
a single copy_to_iter() per option, and the wrapper in
do_sock_getsockopt() handles writing optlen back to userspace.

I picked these four because each is small and self-contained.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Fix kdoc as suggested by Jakub.
- Drop the CAN patches; they will be sent separately through the
  linux-can tree.
- Add X.25 and KCM conversions, keeping the series at four protocols.
- Link to v1: https://patch.msgid.link/20260505-getsock_two-v1-0-4cb0738950e0@debian.org

---
Breno Leitao (5):
      mctp: convert to getsockopt_iter
      llc: convert to getsockopt_iter
      x25: convert to getsockopt_iter
      kcm: convert to getsockopt_iter
      selftests: net: getsockopt_iter: cleanup

 net/kcm/kcmsock.c                             |  16 ++--
 net/llc/af_llc.c                              |  18 ++---
 net/mctp/af_mctp.c                            |  10 +--
 net/x25/af_x25.c                              |  16 ++--
 tools/testing/selftests/net/getsockopt_iter.c | 109 +++++++++++++++++++++++---
 5 files changed, 124 insertions(+), 45 deletions(-)
---
base-commit: c1e5127b577c6b88fa48e532616932ae978528d5
change-id: 20260505-getsock_two-abad19643336

Best regards,
--  
Breno Leitao <leitao@debian.org>


