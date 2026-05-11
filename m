Return-Path: <netdev+bounces-286594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE47GXmzAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1054C50C24C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98857304A6CE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5263D9058;
	Mon, 11 May 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VEY+2+d9"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F13D8117;
	Mon, 11 May 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496124; cv=none; b=JYdHckSKmWBH191MgyQFsg044O0/UwA1vvmKkPw+xQRbAjW/FpWA3dySzYCpee9jy8t805b1equ70C4Y7oApFJQ8b/H8pGBqKeGbc/2XoTckWgVZ2EA0dfz0lFu0FSvla56ext7oDNcsY8XC1VVEidMO3sYaj83uw6hhba2+/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496124; c=relaxed/simple;
	bh=ur2AM21uHvjmgCXYpQ2Mhi2ou6EArrAZhyooSzu7ogM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WaeGaoUXcowMlAGdd9WJSgFsktEEp5ySEUI1tRPnIm3zSV7sQ7CmCjl+ayQBMfZrmUopQ5nVuDcpcv3uRtsN7Ov9bmjv9D3ggg+lbC4rRuEvLGe50vHlZH68zkqCtUfeNjxI/6aaNCPY6ppTzHRHw2cMWwXCUe2HTdCa0YeiItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VEY+2+d9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GaY0abhHUNwWVuOBMJPQjxjm7bptzPzWqBMgVcyHz8k=; b=VEY+2+d9+mtcpPWOetfXK435j2
	O1ViASPdn+Ux9+b2xyuCV2uvr6UGqGuwpBAQjcDhFpiEBleCdyebPyEjLO728jz1WtZZUe8mu5FrH
	sP0FlCCmuk4fms5iB3jiq3YTCtFaEW7Aa56gOHFGC+lIHY18HLpSzivPh3RoJq+dvCIr46yf98etT
	2qTnbA/bYYok2kfzR0D73dqfOFXB2W4xONT25RZoN4zMQhG3v4o1+706XZnVsC9LYubc4H+tPcez2
	Ta9NyMbZtlpRAXVxkFqt9JoyGNV5MI/uvMfvTf9/9+7dSSn7tAmyPaKRsbk6myvBT09B+ZHfb8oqE
	95M/F2iA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5E-001XeD-02;
	Mon, 11 May 2026 10:41:56 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] net: convert remaining bluetooth socket
 families to getsockopt_iter
Date: Mon, 11 May 2026 03:41:45 -0700
Message-Id: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmyAWoC/yXMUQrCMBQEwKuE/W4gCVgxVxERm2zbp5BK8pRC6
 d1F/R6YDY1V2BDNhsq3NFkKovGdQZpvZaKVjGgQXOjdwXs7UduSHledK2mzy8fRD6EPJ6IzeFa
 Osv6+MwrVFq6Ky1/aa7gz6bfDvn8Acuq9r3sAAAA=
X-Change-ID: 20260511-getsock_three-d0d7f1b2629e
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=leitao@debian.org;
 h=from:subject:message-id; bh=ur2AM21uHvjmgCXYpQ2Mhi2ou6EArrAZhyooSzu7ogM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvoVc37F7r5mYXMPaDELPOoe7I/xCeHx4YE
 64CyusqUAOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bca7D/9wzfdmyx/YlgxswocH4Z+MaM1YJEA2pR+i2Jw6CmO+r/cuFoD1VGCbSYLvcte8zJNRj0Q
 4FgG6onecjOB9FAvpiWwvck94W/qfOurqwzwPX4H+KTDig1Y+OP3JFVH755v+lZYoWNh2BIepfL
 lbhpc95VTNIo1Vb/lDeP/bPrwEWwoT3o6NwanVPc4RrxnDBEkDOUNNol4cRLR5a2V7pcDrqKJK7
 xWapWzRst429kb4zEuM2UHg/Yb5Qr1v5rNQpXj7VoxWBNyJyfjMfxDcldBce9k0mNY9jFf5TigB
 M4dviiDPTWlGw5UjLRO9Qr+mNF54QGBJu7LLiQOPZkd3pQqSWU6Yl+AjO1LDIDndQgZz5G00MRN
 iuZKXUIGseSvjRGNj2p6NqrLKl8AgzQt2KfAXf05tLHnuxm26fERAkP5xcuwpFtK4jp1nkdN7uc
 03H9oiCOliJLzABP3FDEmEHRjeUNU3bHeFJaySROGwJWvQQwC5P8UkasyrZdR3A/dLicRKScgkL
 NclNrU4V3jkXPbecJLkTzfU7h03ph8bY1uclxv3FBFfzEjXK8kRPizOxnj4k6c/mjAJ+M+vAZF2
 pA4xJ8SoT0mjeCzCLF6K70EFLlagrpR1IAEA4LzAjkkNlJmF9bE68bzlpQf8On1krsJoNpY9q/F
 5rlt6oAso5QmbVA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 1054C50C24C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286594-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Continue the conversion to .getsockopt_iter for the Bluetooth socket
families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
small precursor that fixes a long-standing 1-byte put_user write in
hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.

The riskiest change in this series is the SCO BT_CODEC conversion: it
is the only one that drops an open-coded ptr cursor in favour of
relying on iter_out advancing naturally on every copy_to_iter() call.
Every other socket option is a near-mechanical s/copy_to_user/
copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
codecs + capabilities and previously tracked its own write offset by
hand. Getting the cursor semantics wrong here would silently truncate
or misalign user-visible codec data.

To guard against regressions in that specific path, a patch (previous to
the change) extends tools/testing/selftests/net/getsockopt_iter.c with
a focused BT_CODEC test that pre-fills the user buffer with a sentinel
and asserts:

  - the buffer is unchanged on the early error returns (-EBADFD /
    -EOPNOTSUPP, the common case in CI without a controller exposing
    HCI_OFFLOAD_CODECS_ENABLED + a get_data_path_id op), and
  - at least one byte changed on the success path (when a capable
    controller is present), proving the converted copy_to_iter() walk
    actually wrote into user memory.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (7):
      Bluetooth: hci_sock: write the full optval for getsockopt
      Bluetooth: hci_sock: convert to getsockopt_iter
      Bluetooth: ISO: convert to getsockopt_iter
      Bluetooth: RFCOMM: convert to getsockopt_iter
      Bluetooth: L2CAP: convert to getsockopt_iter
      selftests: net: getsockopt_iter: cover SCO BT_CODEC conversion
      Bluetooth: SCO: convert to getsockopt_iter

 net/bluetooth/hci_sock.c                      | 26 ++++++-----
 net/bluetooth/iso.c                           | 27 +++++------
 net/bluetooth/l2cap_sock.c                    | 61 +++++++++++++++----------
 net/bluetooth/rfcomm/sock.c                   | 30 +++++++------
 net/bluetooth/sco.c                           | 59 ++++++++++++------------
 tools/testing/selftests/net/getsockopt_iter.c | 65 +++++++++++++++++++++++++++
 6 files changed, 179 insertions(+), 89 deletions(-)
---
base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
change-id: 20260511-getsock_three-d0d7f1b2629e

Best regards,
--  
Breno Leitao <leitao@debian.org>


