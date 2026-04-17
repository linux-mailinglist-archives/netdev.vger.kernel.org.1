Return-Path: <netdev+bounces-279269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEx4BdX44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:09:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEC4191A2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60603155234
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F93A3812;
	Fri, 17 Apr 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YtgOMOb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69D35F5F2
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416612; cv=none; b=F2hLJgxy+k1E6z31Y2Tz3p7XVYykXHOGxU491DmnY8p9bKkcPJxWOA6yelJFubTrbUIgipOXeDxDaiYYEJ95I20VN+sx/bTeRlmogyWV9+8Fd2D9Gp8Kl4QWBz+cD7nTq4Ic9cqW6TxoCD+6MLUDxIi20bCYy4raow9d0u6LApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416612; c=relaxed/simple;
	bh=tI09vVk4zDbd6e0CUDiQV36XUhz4ozf8KmS3qXsASLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+LY+TzM/HCXvDI4W2eWT+S5+8CXkbp1bn0OoehUJsH1Lh5knGce4xZfdcliRo5gLStxf+2Zu/snYKnAWs1TuBIoDVV5lkOjHr8SUEC4q50gQu+b2NZK7qf5lyMYR5lVhZQAy98jhVkzCp1hYaHIvA9OBJt8ilIDgNq5m/tsCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YtgOMOb6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso270159f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416608; x=1777021408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+3SXDNKP2Af/Yl7LUpMg9kvHs9dI3gKze2VfcR6oZk=;
        b=YtgOMOb6GxAktLoDzeccgRCO3Y7H6h2/y+Uvxxh9Ogw2EHYzP6H2+2BXxnN/cmvJDU
         jSHLnuwp2P4swGfs0j9sot7ea8ac7eMkKLZ3BFZF0q83Nkck3CbiJHuf21Xcrg3+DUMU
         z4dob5b55lzskhFWhKGrbH+jE9h02z4zV/roMEeNW24MCQDMhjXISKnvm6qBSoBOCWxx
         Vt1D4l7O+8yI0c+W9Pge6uUp3zDMT8Z2U62Qy/BCcAFqa03LA0l+8aDPudGH9oU4ttJS
         ER31KdIX0CFtu6gYZVGUNdivlFTKAARSEzOjapebg9OSMccleq683q7Xm6LOI7DwLlE5
         8z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416608; x=1777021408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+3SXDNKP2Af/Yl7LUpMg9kvHs9dI3gKze2VfcR6oZk=;
        b=B9z/oyVQ9whQVZeJwYGB/TJsCdB1S63oA/mrUm6D4ekQHSUOwVVTsclAZ7CGHtmNVA
         yb+t4qK7JRikwx0TQrVYSHuwovDyrxtFw/j7djyr8gMlyfLVsYBeAgVOXaxZ3bczc4hq
         vFhyeGNU4fn7qVoBjc7WKIUXDFl0muHbv+Ph5BZubBHibNCgQsjJpFyWQzamRbYLcydI
         eCLlU/tPLY1DK+cLPd4vkHc54q9qZ7C8lOy11WO0AG0XviUBT2ncpDwUJltwoFMqoXjM
         otDLE6yDfDYktF+aVndeNmuOC5cAgtdG9j5Qy37giQGxyaFtd4/cTvNjwvqXl95VDHQG
         iEjg==
X-Gm-Message-State: AOJu0YwV6WqYwow68+RjPbdXiNh/UvF8v7uxQ4dZpbw8lW/gkHXaPwn3
	w/9fFNxWUnokpk+tEW60zUhEtFSMPATsKKv/zyob6iTlNCOZ8TDpoax1t2l3qE4Jx5Y6TeLqkTY
	tTqVBE8hOhawzLYrKDPEqLJvVOjUxgOdL70Rxqy1x4NY+ZaebVrvZ2XKP6bJQ6VlS
X-Gm-Gg: AeBDieusNKb9/k6Yx5POvDygdw9wRs0sxu5uSsn6kv+uF+n/nxgcBq9JEngU+HGheKh
	Le73NDWSp3mS1NKgKtc6+xYmTiTfAURnzjURp8tq7xhnSe3eqdLaGUwjjxOQLcvEhNJomeQVaz8
	gvWRxUnJL0h8TWlMN0x7M0GVgOQqhdp/W7vzwxpjSvmyCnxcI2nwkWUckn78uhNO23Y3pw2jYSB
	zQCpzzmtOsA88MXSWBdig/P+B+nW4nDhUujOrpN3WJXBIywl0MEEH4oQbiv4/jTDlvGiXEdY4Vw
	PJswTc0ogIH1v38EkiS+kIR/6KHUzB+YmqfK1XYZU14a4yDTp60WDbp9/2u6cC4duSeFMXD9fOB
	6Q/7Yipz3y3jHB0CmiNH4LZWNjIVmnTyqftMfDPeBpPyGGi7aid4D5YNhkhFKAHBvV2YiPLEEXc
	TrNJ/toL7ury9b0mNNGQmAgXXo2HdUGGNQXfRBglBZjn0lYO8=
X-Received: by 2002:a05:6000:110a:b0:43f:e452:f137 with SMTP id ffacd0b85a97d-43fe452f182mr1821273f8f.2.1776416608342;
        Fri, 17 Apr 2026 02:03:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/6] pull request: fixes for ovpn 2026-04-17
Date: Fri, 17 Apr 2026 11:02:59 +0200
Message-ID: <20260417090305.2775723-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279269-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95EEC4191A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

This is a respin of the PR I originally sent against net-next + an extra
fix (patch 6).

Please note that this patch:
https://lore.kernel.org/all/20260225010833.11301-1-liuhangbin@gmail.com/
broke the selftests entirely due to the switch from sh to bash.

There are new commits in the kselftest tree which take care of this:
https://lore.kernel.org/all/20260416-selftest-fix-readlink-e-v1-0-94e4cabbdec4@kernel.org/
but they are not in net yet, therefore you won't be able to test/run
our kselftests for now.

This being said...

TCP tests are still failing every now and then.
It seems that sometimes a single ping over a TCP tunnel is lost,
thus making the selftest fail.

We believe this is a bug in ovpn which we are currently hunting down.
So it's nothing wrong about the tests (they are actually doing their
job!).

Test hangs you reported on slow kernels are fixed.

See the tag content for a more detailed summary.
Please pull or let me know of any issue!

Thanks a lot,
	Antonio


The following changes since commit 82c21069028c5db3463f851ae8ac9cc2e38a3827:

  selftests: net: add missing CMAC to tcp_ao config (2026-04-16 19:35:43 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260417

for you to fetch changes up to 6c9b1dc218fea8b15893953f5299b209f11fa0a8:

  selftests: ovpn: serialize YNL listener startup (2026-04-17 10:54:04 +0200)

----------------------------------------------------------------
This batch includes only fixes to the selftest harness:
* switch to TAP test orchestration
* parse slurped notifications as returned by jq -s
* add ovpn_ prefix to helpers and global variables to avoid clashes
* fail test in case of netlink notification mismatch
* add missing kernel config dependencies
* add delay when launching multiple ynl/cli.py listeners

----------------------------------------------------------------
Ralf Lici (6):
      selftests: ovpn: add nftables config dependencies for test-mark
      selftests: ovpn: fail notification check on mismatch
      selftests: ovpn: flatten slurped notification JSON before filtering
      selftests: ovpn: add prefix to helpers and shared variables
      selftests: ovpn: align command flow with TAP
      selftests: ovpn: serialize YNL listener startup

 tools/testing/selftests/net/ovpn/common.sh         | 355 ++++++++++++----
 tools/testing/selftests/net/ovpn/config            |   3 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |   2 +-
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |   2 +-
 .../selftests/net/ovpn/test-close-socket.sh        |  90 +++--
 tools/testing/selftests/net/ovpn/test-float.sh     |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      | 237 +++++++----
 .../selftests/net/ovpn/test-symmetric-id-float.sh  |   4 +-
 .../selftests/net/ovpn/test-symmetric-id-tcp.sh    |   4 +-
 .../selftests/net/ovpn/test-symmetric-id.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-tcp.sh       |   2 +-
 tools/testing/selftests/net/ovpn/test.sh           | 449 ++++++++++++++-------
 12 files changed, 803 insertions(+), 349 deletions(-)

