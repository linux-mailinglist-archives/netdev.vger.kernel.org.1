Return-Path: <netdev+bounces-296136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oj7/MLRxJGqz6gEAu9opvQ
	(envelope-from <netdev+bounces-296136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD764E197
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J6A4CyUy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296136-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD97302B771
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4F3AEF47;
	Sat,  6 Jun 2026 19:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCC3BB4A
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:14:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773270; cv=none; b=i1ZTthxBFL4TLGNPLZn03AAbkajfReqtgIZqh6PnG82UvLT687w5YvffWPyUhz2Nqpgo3J7BB8gySvprFcvejjcUUVzgvbA/3BciG5qSU/M3Wfum4p49w2pOQk9eE3vpQS+xhNQ27vQk2xuRb+0v2lYHxg/dh+3uldGJ8WprpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773270; c=relaxed/simple;
	bh=zbxDd2fSSMbWNrrHr2w5nmZ9TgC5bQrbH1CWRzoEtJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2lax1z0slUgZt5PjvVBfygRZVupVtC3C7zD4W/2XWRorsKO2DoG7/bzwMvEXy6OgPb3mNGcLKiAdJYli/grPyDQtmhIFqhCk9QPb6a3y8yiOud8gh54VdAQzGAhUFpIGaf71cUsEJpWHPD2DaJxQoWpu9B/pipgry4WCngCTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6A4CyUy; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccf18ef922so43278506d6.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773268; x=1781378068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T7YMHG1P2X6CbLgyAdfZNnGyycwtC+2WHfMvNyBlpQ=;
        b=J6A4CyUynWBJHEpHjdADENApYDs6w/kd7rvR3tFXjO8pM3RSsTMDkqqYqpreIEt0wg
         ZhaQPuS7Yz5Gfw60G973yu8yw7kX9JneXjd01+2BXS+Yoasxtaso52YlgvY25nY53Jhb
         3D2NFVor5H9cYP8zznoCfWPyXITL9Llib52aiybysWDsPw+Y4vUIDJncbnh1XRl7P/3D
         PCIy1a+8ILNLcyGgb+RUCsVPIWywlGZCHPkz0R9wRwleZ4FSYHSLM6HBXNogiJHslK3v
         FBtDDqbmP8f+mCSDqV1KaZfgYjiLF1/UvAJPTgy+sjdm+Ti6A6/qXyWUJLSk93pP0htZ
         9RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773268; x=1781378068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T7YMHG1P2X6CbLgyAdfZNnGyycwtC+2WHfMvNyBlpQ=;
        b=rUy0QXRvOBhi2JiOcq0GkZFInjgVS35ApdmjjaWfFG7GLUDhG5SPQnevScyL7jsRkL
         Jxkyi4CX4j7wbtvhpOqJTv4mrQzu4W6IRjCerM6xdxye0o6Y2Q+pu6yiGRGNNJuEzrY/
         NPH7fr3tn6oNZqa8SfF23YUHXL1xZGx00SLhQo8Vi1INubWypxaxQ65RdaES1aBn4su0
         30SdbxyBPb7DxsWuzZ4KHd0LTvevRlPGsdlhuYWFSIbEz+0yxDsNd2SuEVZb6TySIPwM
         yEvIgMabGaT9I7peEZEW3c5Z4zDbccieSx25GdVr7Dax8WBYVTZiyTBLkgAs+5eLXFPH
         EMFw==
X-Forwarded-Encrypted: i=1; AFNElJ8NNC5mD3xi1ur5NMyImv008f9K4L5zaKAK52bzcWPq05lI+vxYqIe8SZk+6VkVqLhk9iGpncM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5gO5PEpNHraE4yhAx/iiPTWFa0jxZg9XOQmPefz2Nr5bwCky
	WoBzljBG0GDDvlaKjgtAxlocHC5yVOFdbNDcr4Yb65rtyDaf5zv9gYLV
X-Gm-Gg: Acq92OGxoeL4lOmSsu5VbRPWnUp3VuudwqBgc/Pd1KqyAUZrR2FsYDYIrz9w2wJIAKg
	VxEXA/VPQ7Y+Gxmf/nxgAEmEPrHDwnd71uiGStP/x93Gp/wIa7LEC3akfasDmnmfyL+ovI1B8E8
	d7pd5Mc1r6BsPLbiIRF5DBXR8iHSo5baiE9j2Scb9AMrV9cp28+75ePaCXQ1pNMzHP56etEC+vJ
	sraMmMc0wsomgtW1lMY5TYRW0du9UqDMEEXwLgySX1dnQO4EU4o+7e+IITLQ7AOS0Jy7CeNCbci
	T3trrMd6RZN2fSx9x+wOxJIm9zXuHgLgLv/hujTHFhgV5alioyhHW9sJFsI0MuryfJTxdVEQv4N
	WqGo+xiBu9q/ghMH9W4q5lSFnC01cqwm58cvClllahsAW6kpplKXC+//KeW9rGcCr37qwWgpqEI
	EgvldgNluUIAD2lLqN/1zysIFurZexZJy2aTetihv+GOSIb0pZIWLI+QfOCBd1wOA7xYOFF7ePL
	HPeBDS5eZ/FnNb5BttpGMqxrwQhdpJLkiDKWrx4ag==
X-Received: by 2002:a05:620a:bc5:b0:915:5215:d90c with SMTP id af79cd13be357-915a9ddb310mr1602454085a.51.1780773267902;
        Sat, 06 Jun 2026 12:14:27 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm1311699285a.3.2026.06.06.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:14:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/4] tipc: fix netlink gate and receive-path bugs
Date: Sat,  6 Jun 2026 15:14:09 -0400
Message-ID: <cover.1780766454.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24FD764E197

This is v2 of the public TIPC series. Patches 1 and 2 are the same fixes
as before, with patch 1 updated to use GENL_ADMIN_PERM for
TIPC_NL_MEDIA_SET after the duplicate public patch pointed out that the
media defaults are global rather than per-netns state. Patches 3 and 4
address Tung's review feedback.

Changes in v2:

  - Patch 1 uses GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET and
    GENL_UNS_ADMIN_PERM for the netns-scoped mutators.
  - Patch 3 validates msg_conn_ack() at the start of the CONN_ACK block
    and drops invalid messages instead of capping the value.
  - Patch 4 reorders the new u32 declarations in reverse-Xmas-tree order.

Michael Bommarito (4):
  tipc: require net admin for TIPCv2 netlink mutators
  tipc: validate discovery message length before reading media address
  tipc: prevent snt_unacked underflow on CONN_ACK
  tipc: reject inverted service ranges from peer bindings

 net/tipc/discover.c   | 14 ++++++++++++++
 net/tipc/name_distr.c | 11 ++++++++++-
 net/tipc/netlink.c    | 12 ++++++++++++
 net/tipc/socket.c     |  7 ++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.53.0

