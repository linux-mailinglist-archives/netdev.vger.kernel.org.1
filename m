Return-Path: <netdev+bounces-277920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7gtjO5YY3GmeMgkAu9opvQ
	(envelope-from <netdev+bounces-277920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB23E63F7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EC15300A7E1
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561C31AA92;
	Sun, 12 Apr 2026 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c5ysPO4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC481D130E
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031890; cv=none; b=OtZzYn1pxeMDtJU4OuAYEmC5Y7gWRjxOsl+sTGF/iggxnMFOgaNha1NgLKB/O81VGP4JTItN6nMxvJTIWBenHK2FDdbnKrYKN/RJEH6IVZRaHIKQVFVJA6HHsviTvJGB3f/gT1Jf3bRD0lhdif02qBpEzFVJ4fzu4r3+RY8jJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031890; c=relaxed/simple;
	bh=TsoWesV+XYcbf6PVIikwTYKcUYUBrEw35/kUG36yDOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JShnjMrsdv4DluVqqRJpMJuFKhHAEnt31VsGjBGQiW4ooWJxbB3G9WcKhsFZqgxk2AZ2cT0cPoOW8bw0zmecw0bGcXx0RXA/j/Ev5qt9ph5w3IvYxBcB7tG7aJTOCvPvl+FUlEP3cOK73aA9ZnLC5VrU9cIouBk9TuRxiAH9QnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c5ysPO4l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so47500465e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031886; x=1776636686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eb6bdveDsQ8jb+GIMFX1WImru/i9Vh1ql29M3C5VZwg=;
        b=c5ysPO4lW/9XtXmoD24YJWD35ILiiEvQMwBACO7b/ogsKYSHpVRyyXW6Nn2TbsJNTY
         6BC4VtBXRtXhMP2O9yJSg11gw8Zzz1PiepXHJo2o+Md0nbN9K9VyZxBW/YSft1gOt83K
         eLXTK9gE3ZKwEC8KmTkB8HEz8esJloCDp1g8z0fCdrMPuGF3sBjeLSXGZ0B4AUAYzGvi
         6eKrGEM5+EBM/cC/Tc+TUsnBo+1M/uAT8wS/jtxpnVvLvrHMXuYc/p6aTQxSDufEC5jF
         Y+rRd0eRWKV7lqaun8CRu7leZjk4MI2dW03uIoFvZWsbI94pjVt3JBTlWmcncTK7I1SX
         4JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031886; x=1776636686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb6bdveDsQ8jb+GIMFX1WImru/i9Vh1ql29M3C5VZwg=;
        b=qUnr8e/bJPbgpqul0mWGKzc/XUkOphEZN73w8Ml3EZom0/6JdtTxkQXW/P/GLFwEMK
         r3Pl61Fx6yTKoDH4Np38scXHPGmZB609aVX80fN6vFpxHIq2rtte8iEPvLWj8f2J2BqK
         Mk8QPBVfoYFZ1Kjn+BLeAjwr5iGRxmmLNNQo2OYhfMC7uMto1pA+yOm0e0LnnJLik/YM
         yaEEIwc/xhJm9LmUlcEf7ItNfe1AvQBdnQtdDezpbxANyYsGllL0uDQ2YkZlf4v6AReR
         PLdRdq3MBn2uW90ezMVGcEhviHScQzGaemNQYokclQR+TWOPsAnPQXf7D9jnhNW+0PAp
         h5zQ==
X-Gm-Message-State: AOJu0Yw32poY8ccaLBcC251/gEV2CLwt6+1LN1UHuqf7HRtToL8WCnmf
	PTGGWki20YVad+lWpOcVEI48Ri6LvMjIMOgaZuGGWS6oazWzJS+m9bFSIKglCr3Dm5q4xR/83wM
	/OVDZwMqT15CZDZXPXC9kZVfafxpt+GO8hZc0CbE5XJ2vA4lNfs1x0togyUx/9cgt
X-Gm-Gg: AeBDieu1FIn6U9vawAOI/kj9ln1L7q16KOULLTIjchThW4ywJiEG9wwgpb8CTAmfQBA
	nGRXVKQtTOqNxP5M4aDA9MeEtSrB7CJSCGQPsOVRXG+yV3AZs7Sg+PvSIRURb166+RXXzAggZ1o
	7hXX3qkAGf6mugdOffQaT7IjS1U0u5qvwth1+Wgnb4jzTUWmdZaT8opi/YoDQLvHuotkeTNPNi4
	XII8bIzB+G9Abopk9ZBC0gZ9O7+fCpD75rlD2DQSBMp8DSPc6wfZeUPP/7sYq3/lxO+58yo+bBk
	UpBp8I+Bs/12hM4NEnk4GCie0xI9yh59T6voZeOWb1YpEbdeINaNl0clgfaHu8RIhXr8K6gWoBu
	lWdhzb8PaAIPNXQs8wP/8m1DEH+s96uRp651FwWwNxBBHVJj19pUuxztZHmjMvbREM9bB7TVrU5
	6t69i5g5hP0Nl1TUy5GRIAWnwb8pRCICY4kF5J
X-Received: by 2002:a05:600c:1391:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-488d67e6a48mr166546855e9.9.1776031886153;
        Sun, 12 Apr 2026 15:11:26 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/5] pull request: ovpn 2026-04-13
Date: Mon, 13 Apr 2026 00:11:16 +0200
Message-ID: <20260412221121.410365-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277920-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: 61DB23E63F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

I know I am on the edge of the merge window, but I still wanted to send
this batch of improvements for the ovpn kselftest because, as you
pointed out after my last PR, there were still some pending issues with
the latest changes I sent.

This PR is entirely about improving selftests to avoid hangs and ensure
they better cope with the kernel CI.

See the tag content for a more detailed summary.

Sorry for being late :/ I hope this can still go in.
There is no change outside of the selftest folder.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio


The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:

  tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20260412

for you to fetch changes up to dc76eb924963f6d48980b6113888c6103f16b8f8:

  selftests: ovpn: align command flow with TAP (2026-04-13 00:08:43 +0200)

----------------------------------------------------------------
This batch includes only improvements to the selftest harness:
* switch to TAP test orchestration
* parse slurped notifications as returned by jq -s
* add ovpn_ prefix to helpers and global variables
* fail test in case of netlink notification mismatch
* add missing kernel config dependencies

----------------------------------------------------------------
Ralf Lici (5):
      selftests: ovpn: add nftables config dependencies for test-mark
      selftests: ovpn: fail notification check on mismatch
      selftests: ovpn: flatten slurped notification JSON before filtering
      selftests: ovpn: add namespace to helpers and shared variables
      selftests: ovpn: align command flow with TAP

 tools/testing/selftests/net/ovpn/common.sh         | 282 ++++++++++----
 tools/testing/selftests/net/ovpn/config            |   3 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |   2 +-
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |   2 +-
 .../selftests/net/ovpn/test-close-socket.sh        |  83 ++--
 tools/testing/selftests/net/ovpn/test-float.sh     |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      | 223 +++++++----
 .../selftests/net/ovpn/test-symmetric-id-float.sh  |   4 +-
 .../selftests/net/ovpn/test-symmetric-id-tcp.sh    |   4 +-
 .../selftests/net/ovpn/test-symmetric-id.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-tcp.sh       |   2 +-
 tools/testing/selftests/net/ovpn/test.sh           | 423 ++++++++++++++-------
 12 files changed, 706 insertions(+), 326 deletions(-)

