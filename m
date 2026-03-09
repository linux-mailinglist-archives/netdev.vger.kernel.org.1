Return-Path: <netdev+bounces-265376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHKNNJ9grmlbCwIAu9opvQ
	(envelope-from <netdev+bounces-265376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:54:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D519234027
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656E9301980C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970526E709;
	Mon,  9 Mar 2026 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6Zl/kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943734CFB8
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035676; cv=none; b=Q3K4AjkaZPSURX/W3KNOl8MiBpn7EqIfznCb1xfndBDVtdRIxOjbVSUKWxYsy+Pap1u+FqhLuQ+N0RPDtc4Cjcr06kVbDSsP3gmqxp6LcOyk3/bnngqbi9tvXnuJ0f30FsoCpxd2K3dmuW9ePm67wszKkhAtg9/rkocH8SYk7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035676; c=relaxed/simple;
	bh=yhRXDuYeW+cftAqeXj832wG18URrEw+/ciyn8otv1bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I78UcatEX+QtEwosQBi9kb+VT1r1ChXCQA0ekfKrSH4F4lNjLXLdEVVX3EvH25L1xLw/roT4TOGGp2sDONRDVVlUh5Jd6270yagqwo+dyqR8g8eEJPqT0dlppV6CLKXxoum1Mo9GW/bDAciLnYDm71ioPbcFWUG05apZA9kos6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV6Zl/kq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so4344426a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 22:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035674; x=1773640474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQy7F8PJ6uvy5F2yRW0mdhvL40ZL+dX8MEO00CpDqi0=;
        b=cV6Zl/kqBNxv607ftvljCrRKjOqcbnx0iTV0DaBN+eXRUoTGEGfoAT3LlezY2XsY13
         RisOZV4Kn7yZqBC8sxM9rcXjoY/18AtzqBboyHhQ1Rv0x/mTfVpuNj72cLMw+gdGamv2
         unI+FZ3nF+Ls0H53ywqXupejOUsIDfxUSi5epsMQ6pXIWGy7cZaY0/pB6Q13I9DTy+Pm
         6fYz0ORxpJOZjrYX7ywp0QFEwwWnsQQGdbBvrrvv4cMw4gAdIHbE4yVy1DHASb02oS65
         mc/EbhJGwDPyhDnLwvTltSf6Ew0cHf1qkF9WQJYZ+Y9eaSSRkP2+yyJl9RBBopo49QrD
         lRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035674; x=1773640474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQy7F8PJ6uvy5F2yRW0mdhvL40ZL+dX8MEO00CpDqi0=;
        b=srTNyZS1ocJQ4AHn97nQoZOwTIlnZt5Z/X6e4SzDWPMFsYHNDCSamjyWExkUyHqqsK
         LuOcuGJVbavlSHB9kwdHP+5eQigZTRn60JWPXZG4a0o0wcjdV4CLtWLFhBdelYFo5V5W
         oXLa9pe6NWIMVM76GuRhOX+XtqB6nn52lpRoKcuTM3If/zpJigjjuA42qCMRQU553C+p
         7JEcjxB0Fnw4XE7NtFLO/3g36ROBDd5IJ65+sENw6y6jo0IL4Cnzvs3qQMugxF8TEpKd
         XK4v3dajYYV1WPFe3TBv3mKpFR52ntxqXkRXN61WvAp4iZsnj92arCbBTLyXMEzrN0VX
         AELQ==
X-Gm-Message-State: AOJu0Yxx4+l2pMcA2TwswhO3UeQKt/+bb2j4uXJN4ihh6LotqnhSfrRy
	W7XzQETRF3KZyOkgR3ReAoJaKEDKgPnwdUqNWXkRboBZ07uLQBzPTnkA
X-Gm-Gg: ATEYQzy+FfGqc/b6mC0+KOCh/c2i8NyL5b/ZfqLNVRD0st/0WOh37h9NuexrUAGuJ+6
	wmGG7C2Y8OChEcgLZxKsm+dcqvKd9vtiqbcbm9RK6PqkGA9nvvdcwtuljboyF/ibvRYyJotbM5w
	dOumwHUD8GLGc0yXVLF8rI4jAN+97ue7lzAlGmARcgRYSVbPskk9PhRieJ2YPQFXhNbXl3mr3iO
	yCC5oOWJTNGMTI4fD9NujxuH+ZeZ6AX+9kbf63rEpMgody7sHUpoOQHK/xahk6KQjkeurXgFclm
	QVQnb20RsB78ySc5Y9AzVElcX4l3DPbLSwQmzydJXClFOufad9ESoHuHHlcVodranIkTh27iIOh
	fEz08AbiGmtLyLUItp32Qgtd4xh7tkgIvXiN13QV8p5UvsDshnuaxvHAQNQ3T/Gy4S5f8tmFyNu
	HYaRKRz3jSVyJFWDdCSpyejDLPWrqLDIhlUis4uhS5ZYPjXjzwEqV0nX+IIMN1
X-Received: by 2002:a05:6a20:d527:b0:395:b6ff:fe57 with SMTP id adf61e73a8af0-398590d3b1dmr9399688637.63.1773035673636;
        Sun, 08 Mar 2026 22:54:33 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170923sm7933716a12.17.2026.03.08.22.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:54:33 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC net-next 0/3] tls_sw: add tx record zero padding
Date: Mon,  9 Mar 2026 15:48:35 +1000
Message-ID: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D519234027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, for TLS 1.3, ktls does not support record zero padding [1].
Record zero padding is used to allow the sender to hide the size of the
traffic patterns from an observer. TLS is susceptible to a variety of traffic
analysis attacks based on observing the length and timing of encrypted
packets [2]. Upcoming Western Digital NVMe-TCP hardware controllers
implement TLS 1.3. Which from a security perspective, can benefit from having
record zero padding enabled to mitigate against traffic analysis attacks [2].

Thus, for TX, this series adds support to adding randomized number of zero
padding bytes to end-of-record (EOR) records that are not full. This
feature is disabled by default and can be enabled by the new
TLS_TX_RANDOM_PAD socket option. TLS_TX_RANDOM_PAD allows users to set an upper
bound for the number of bytes to be used in zero padding, and can be set
back to 0 to disable zero padding altogher. The number of zero padding bytes
to append is determined by the remaining record room and the user specified
upper bound (minimum of the two). That is
rand([0, min(record_room, upper_bound)]).

Also a selftest is added to test the usage of TLS_TX_RANDOM_PAD.
However, it does not test for zero padding bytes as that is stripped in
the ktls RX path. Additional testing done on a linux NVMe Target with
TLS by issuing an FIO workload to the target and asserting that the target
kernel sees and strips the zero padding attached.

[1] https://datatracker.ietf.org/doc/html/rfc8446#section-5.4l
[2] https://datatracker.ietf.org/doc/html/rfc8446#appendix-E.3

Wilfred Mallawa (3):
  net/tls_sw: support randomized zero padding
  net/tls: add randomized zero padding socket option
  selftest: tls: add tls record zero pad test

 Documentation/networking/tls.rst  | 21 +++++++++
 include/net/tls.h                 |  1 +
 include/uapi/linux/tls.h          |  2 +
 net/tls/tls.h                     |  6 ++-
 net/tls/tls_main.c                | 72 +++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                  | 58 ++++++++++++++++++++-----
 tools/testing/selftests/net/tls.c | 45 +++++++++++++++++++
 7 files changed, 194 insertions(+), 11 deletions(-)

-- 
2.53.0


