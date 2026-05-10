Return-Path: <netdev+bounces-286226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJv+OBPe/2lP/gAAu9opvQ
	(envelope-from <netdev+bounces-286226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A95021AB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9D33022FBE
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A211E260C;
	Sun, 10 May 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5GErs3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB1194A6C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376207; cv=none; b=LXKlzuLVepGEOD+wLjMAedbSApe4xSv3enrFiX+6tDnyMDXPvbEhCjSPGSHWvSpvWsCfR4Es9hBPIb+yr1dSSAyBmNp47VUMwb2nrBry27L0g7oLyeE0qq+1xrKXJiXT1bqfLp4M5NYiYbyg82atoRtPwi4mC3fQo0fWgcy0V6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376207; c=relaxed/simple;
	bh=FFPjyzw+RuI0OtLjHzbIuafeyUusmLvjLTnZyj+4y5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5gjWWXsAks2TMoO/huU4i+b0bT0ghbA8lHYAaVCq9zjIFSGIQdugZXXvHXf/CI0nTvYTorWXC9fI36n2WH9PktUyJnLI0HWAOb8UXvuHwvb7YKxDNofRBnxtitEnI8SD2rd1JmI0HtH03ASotbejsonbqAhgimN9MZVS8LlEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5GErs3m; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c26471f5so739973a91.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376205; x=1778981005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4I0UKgKu/0EBuCqC1bvuc341Yrim8Vb0KgR6RbKLp4=;
        b=G5GErs3makVCj0ajKpGGlIMJKRbBfG4fWuN2dtq3JdFIWhnpbNP83wTMU1ifSOr3Aj
         B45U/cYkbWnsF78wvOTj0S+r0fpFsP/vAyD3R9BqsHnYB1V/WV6m2fkwmDh1z886tcZe
         L0sp5qopfsEUoqsZH9bIG7ClFcULs9coS+uonCnVye2rBWH/rXn5/WcR27LnBfswA1s7
         DbMk1YX6tmwsEDQ3LiwtN7TwvKuRCFtXil7q6nI57EOQhSKfDegbub6x3fN0FUZ7vp6I
         I86oEREXhNcQG9EqByBMZ961kitIorq6m1T670utZhdO6SxGk3ixEoF0toLErIpmscNl
         899w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376205; x=1778981005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4I0UKgKu/0EBuCqC1bvuc341Yrim8Vb0KgR6RbKLp4=;
        b=L1v8qGV7EQ2siWsIRFO/jXnjHGSR1GVlZ4akqWK95lfdY9evEzfs4bo8fMok7r9zRG
         wS0JdSMgvSqOtroqZ+tRcYR0ETXSduNtNAr6q8URghvyN8XZlqv8n5JBAD9LPQrV1P4H
         BnrA1hvs31tMzmvv2X5D5XBn9Q528eL5boAoiMEhucyigVet2PcnVdaQVBO8A4oN2WE0
         UKnPtI+KlSc+HlMaPVo4shOaPbtKitiTn7T/JCttlq3lFdGkWkYBLEuROzlXJU363bmF
         DdpTNfoWufgAQ3Fmz/tmZGGhsoXx0DZFJzdsLF3jzu2Pb8UtM6ALEqOet8AuXCewif+m
         Ixug==
X-Forwarded-Encrypted: i=1; AFNElJ/NUBNYSzMIW4Pqw4cdHvKwt/WtPS1GatYEZ2RdgGqxI8HoJ1Q13ScbepajdENXbJbSCPnPG3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgXO8b+zcUocF4Yf8WK3X7OHOlJ5L4dhTAP7e/ai7f2nleobA
	6oLtbR8WuTZTE3it6x3cfnzeCf4OCO/eW1RF5UQf8/HpDGPWMubd3AA2
X-Gm-Gg: Acq92OFWZfhYjXFLl8hK16uBuKoj2dfce6bdHs5C/GqZZ4/nybo4dD64hIwGqx0K9O0
	QqKjU78lk0Z7ZMGQrf3qxFSHX+O7QXh2kLKPZyWeRyYVS4itphNm7Cg1Ye9CcD/nYFeOe0OBFp/
	d9+fVD9K3I9/zNdUAlg6zH2rekqA5Fb9eaBVNmiHGpw1owUdFQXzk8PiGonETo6pAn10Sqib7mM
	hp3B/gEvbJKFfStzFOm7t9aRSHAtPnT34CM+GHgWf0SWD+44svr/W/euGv5ey/IqukusgCFqrIa
	znHUH3HInOucPJYk6yYaAYIgn9rQEYYL/OvBKhZHNPJ5En4+6ENOojS6cSw7ykV7rPIOQ4C7CM3
	I8yEIDpmwsT+ynoseNPEnMydwIObm6mIQX9VNGA2HkdcdG7spcasrfJEOk660PbdJNecEHT8Bj1
	UxYkJuCsb5twyL/hhOwB/b5I2Lq9Ogd/2zsWns2zheEUb0LpOZf8BGRHDdqBQEvEzvPvVYuXHZk
	EW2ltet4QueJiZu0r5p0bqOa2hz83BxF2ujfhFEcw==
X-Received: by 2002:a17:903:289:b0:2bc:7eee:200d with SMTP id d9443c01a7336-2bc7eee20c3mr39290125ad.33.1778376205093;
        Sat, 09 May 2026 18:23:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 0/4] xsk: fix meta and publish of cq issues
Date: Sun, 10 May 2026 09:23:06 +0800
Message-Id: <20260510012310.88570-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 404A95021AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.888];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

Jason Xing (4):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()

 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 48 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.41.3


