Return-Path: <netdev+bounces-263593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NQcHvHEp2mYjgAAu9opvQ
	(envelope-from <netdev+bounces-263593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:36:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DC1FAE39
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A4A3055635
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562E37F74B;
	Wed,  4 Mar 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuTlsCCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017C30E84D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602589; cv=none; b=JvUAY39aqHN2sQpWF7uVhd7knVL4bca2Rwl9GqAWmzuOqrJB9Auka/JOWazXXH45HRME64l7CSjz2BbR1HRUiuFFNZezFh9Cj3HHmfkDNIYTmGKOay5SHtMw/AYYM1/EYt+XnZNpWGGhDqo3Vqf7mAUvT+MKthdx4toBnpLh2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602589; c=relaxed/simple;
	bh=DdGnEi2MIzcNo3q2Zph5X3WR+wOdcO1pfRapVm1aFa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdxMcKDXOBJIC544sFUNNuKs1j1aAcjwb7m1H5qxhdyyHdsxyTnekqjxh7OXsYtENc+j0DA+JtbreP6Zh9gtoNyTO2aJirxs0QtRw81s8VMLc7xLxQQV7jHUxGIKSOfdtQCSRLnsWwv+/qjcqeACff9MLT70UPo+WkV4pUk5E54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuTlsCCG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3599126be32so1572672a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 21:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602587; x=1773207387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=OuTlsCCGosBzUauHhHv5Nr7SBeMDsCXXi/oaeAz4l/KEd7iFMpPBEJqJt7TcTTKxK8
         8bgrhiFB+b/UTAMcuxQeBoSACq+7yzePEhALqejpcZBMoqOndRG4fy+qqqf4VqKdg3N0
         DLy9URN+ZQxO3oiDhjabuDFyfSTFTcqttQwibmZVH3nfZqC6y18Js3EO1IjpyLkPVgat
         c/eio31GNapjWF1nNIsDCajiAmzky0aU01VIp4LMWYdRVwsJX0cGSfpJmRf+1easyKDr
         WdLdQzVlIJm91LxptvPCU7qzjKnesnqfjJ6o2lIVlvVfrjW0eOs6TA2P+uF+k7noTs/v
         Yy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602587; x=1773207387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=g5uAYvuvnKweLal8ku21emzUdBQ1ZgdS904GEt8pCVw1MjKYHyEDyQeQq4vdK/xROG
         0tfH2NkzuO0y5tKwfIHr6hpUSA6PcDrLPhGTEn9xfVf2sHXFpWcbMLIu+fyzwtlrTb0r
         /DRIDk/e50yN66VtUGK4UjSqYP1KaB8LGhmrTySLUbf2PSF+MvdM+tePLHhu1kODL/wq
         rqSpSyhfPNthKUn1fkwu7pnOEqwIQbK5CQziU5seOpSzzcLO7228S/YWHzBhnTU0ksGf
         u1P4OiOl/8tA/u9u1N3z0afEsWffdYPfhYeLG6BvhRrn/JDhW+xHYzDIt/+6LJ6DDkRm
         iJkA==
X-Forwarded-Encrypted: i=1; AJvYcCU2X3tJSYqLe37fzBGf0cf29KpFmbcOmorGciUYOSrL3Uh+Lwdbjc2VTGEFM68ie90Omw2xC1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6qjdOSXDd/2gfPbn1KM4YC2zV+aHsLeEEYI9OyLl4JvdfGAs
	/ZdxRu1fxDgwBmJ5szW1L1t2ks+pTNfgtCzob3stHlpm2GqtlhgWZMge
X-Gm-Gg: ATEYQzxMcrQZZRM4LOaq1cEX/H9auIv4QzoRLPapmY/Rre5r5LLB9xcPYRDKSftXihH
	6nQhn3n+1HuDCs9vhbEqSO+uIDLL7AhXS9lqn+SYsztXL+g/7s7INsrkW0JuVarcwRs/bLrX7HT
	GsWG81tKOQuP6NiQB1Fv/ZPd44/0hCLdLne/UxXYu8fxyO0HaFPuw3DflwtC+FXa+7hnnIDxUbV
	c7+qDNi8b7g4/8Sj1Psh+7voLPpud41/rAcXts/42FJqxLDjjcfTRHhmWWpJwPPCh7z6A+DCGQW
	xCXioeDpvWM7EPD3i1OKPlpOyAUl8r5TE3MnSzuRXKzqlYWEI4MVHaj28fLmN/2ARzm5T0cWqL0
	5Y+05GtjjgOlh0n32AuOKFtpljB2MUwdZ4Z6Kmw6TbxqS1M96AZTNEz2R7ZZ+PHLQhMXOUef45E
	dEy/JAdbJA3uhd2po3ofFDap7sgtc6IJ0JfvmMi+VKow==
X-Received: by 2002:a17:90b:3952:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-359a69aec32mr1042348a91.6.1772602586933;
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 0/5] nvme-tcp: Support receiving KeyUpdate requests
Date: Wed,  4 Mar 2026 15:34:55 +1000
Message-ID: <20260304053500.590630-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC4DC1FAE39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263593-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:url,ietf.org:url,wdc.com:mid,wdc.com:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

The TLS 1.3 specification allows the TLS client or server to send a
KeyUpdate. This is generally used when the sequence is about to
overflow or after a certain amount of bytes have been encrypted.

The TLS spec doesn't mandate the conditions though, so a KeyUpdate
can be sent by the TLS client or server at any time. This includes
when running NVMe-OF over a TLS 1.3 connection.

As such Linux should be able to handle a KeyUpdate event, as the
other NVMe side could initiate a KeyUpdate.

Upcoming WD NVMe-TCP hardware controllers implement TLS support
and send KeyUpdate requests.

This series builds on top of the existing TLS EKEYEXPIRED work,
which already detects a KeyUpdate request. We can now pass that
information up to the NVMe layer (target and host) and then pass
it up to userspace.

Userspace (ktls-utils) will need to save the connection state
in the keyring during the initial handshake. The kernel then
provides the key serial back to userspace when handling a
KeyUpdate. Userspace can use this to restore the connection
information and then update the keys, this final process
is similar to the initial handshake.

This series depends on the read_sock_cmsg() kernel patch:
https://lore.kernel.org/kernel-tls-handshake/20260217222033.1929211-1-cel@kernel.org

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 20260217222033.1929211-1-cel@kernel.org

v7:
 - Don't use recvmsg() (see [1]) instead use read_sock_cmsg()
 - Remove reviews from patch 4, as it changed a bit to support read_sock_cmsg()
v6:
 - Don't free handshake request on completion (handshake_sk_destruct_req())
 - Add handshake_req_keyupdate() which reuses existing handshake request
   for a KeyUpdate
 - Other small improvements and tidyups
v5:
 - Cleanup code flow for nvme-tcp
 - When using recvmsg in the host code first check for MSG_CTRUNC
   in the msg_flags returned from recvmsg() and use that to determine
   if it's a control message
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
v4:
 - Don't stop the keep-alive timer
 - Remove any support for sending a KeyUpdate
 - Add tls_client_keyupdate_psk()' and 'tls_server_keyupdate_psk()'
 - Code cleanups
 - Change order of patches
v3:
 - Rebase on the recvmsg() workflow patch
 - Add debugfs support for the host
 - Don't cancel an ongoing request
 - Ensure a request is destructed on completion
v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

1: https://lists.infradead.org/pipermail/linux-nvme/2026-February/061252.html

Alistair Francis (5):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_req_keyupdate
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    |  80 +++++++-
 drivers/nvme/target/tcp.c                  | 213 ++++++++++++++-------
 include/net/handshake.h                    |  11 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   2 +
 net/handshake/request.c                    |  97 ++++++++++
 net/handshake/tlshd.c                      |  97 +++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 467 insertions(+), 79 deletions(-)

-- 
2.53.0


