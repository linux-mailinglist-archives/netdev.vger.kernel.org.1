Return-Path: <netdev+bounces-130870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CEB98BCE9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A481C22103
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1121C2458;
	Tue,  1 Oct 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XfUqXJmb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A90019CC3F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787457; cv=none; b=jcpKq0+XhFsCKmYeUpoePBXTp9xsFOSbuEwvhqtiFifl9G5qUL+q5tXWc19Q4qEPS95/yrckYtHbPX+9Ktd4gT1eE2wvwZgmextbAgLqwBEqBY/ETN81x7igEKLF8cpoXvK5oyJOBoXpT73XzmzhqRY8IxNpX2L2A5VyQmLt+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787457; c=relaxed/simple;
	bh=plt9+wvkYbN2eVikxyQIiIyUFTXedgvD5XW1fMn/RU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m7KzjrUk2dKGHmoOPZxCqEMexnXAYIYkR5O1tL6mRyIT57KT+qQjVccDdBsAkgvfXZro0olRKxU7GBAT/4ZDsnd8Zu1x4kld0yeIbgawsxH818Q7c7wHUJKDdAd3pvFXNC5wtf0Fx13lKl6dJ4btwIZaNV77YMtV7xDObT9VEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XfUqXJmb; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491BoTHf011929;
	Tue, 1 Oct 2024 05:57:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=il/
	QMy+fnyI5GJtes329IN5i+DK4/9A7q1FeLOuVtTw=; b=XfUqXJmbW0YCoaWqF81
	C6wTU97v4TcGUXXdfpxNINI6Uk91ic9L/v9A6jqa8sgZHxjBl0wuTLItW4ppMBZ/
	asEkV+4ro+2bT6NQBoln3vfoKR2iXgA3jVHpDkxvrdwDCqjy4XK5pqYUiPOAzg6G
	R+fwwNHiUAJo/qWoA2XHYbb1yqP/xIV7LqTjK21gMde+e2l87ejJTZUJaGHmRsCG
	zAG39PH2CFHn3rLYoO75vRkg9n+39QzXSK2mWCpQInVkL8+2tlx9y2FZmTAz7JSu
	YuRmqZX/1Y0InOQrpNbDEa/NjSFwzpWZR8uMrxneVrUP3U8rqPdsfwrtEn6nn25G
	FBA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41yrw5rqj9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 01 Oct 2024 05:57:24 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 1 Oct 2024 12:57:23 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>,
        Simon Horman <horms@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v6 0/3] Add option to provide OPT_ID value via cmsg
Date: Tue, 1 Oct 2024 05:57:13 -0700
Message-ID: <20241001125716.2832769-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9TkiOimOGD-OxJrUdSvH-2TK5NoKEYNw
X-Proofpoint-GUID: 9TkiOimOGD-OxJrUdSvH-2TK5NoKEYNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01

SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
timestamps and packets sent via socket. Unfortunately, there is no way
to reliably predict socket timestamp ID value in case of error returned
by sendmsg. For UDP sockets it's impossible because of lockless
nature of UDP transmit, several threads may send packets in parallel. In
case of RAW sockets MSG_MORE option makes things complicated. More
details are in the conversation [1].
This patch adds new control message type to give user-space
software an opportunity to control the mapping between packets and
values by providing ID with each sendmsg.

The first patch in the series adds all needed definitions and implements
the function for UDP sockets. The explicit check of socket's type is not
added because subsequent patches in the series will add support for other
types of sockets. The documentation is also included into the first
patch.

Patch 2/4 adds support for TCP sockets. This part is simple and straight
forward.

Patch 3/4 adds support for RAW sockets. It's a bit tricky because
sock_tx_timestamp functions has to be refactored to receive full socket
cookie information to fill in ID. The commit b534dc46c8ae ("net_tstamp:
add SOF_TIMESTAMPING_OPT_ID_TCP") did the conversion of sk_tsflags to
u32 but sock_tx_timestamp functions were not converted and still receive
16b flags. It wasn't a problem because SOF_TIMESTAMPING_OPT_ID_TCP was
not checked in these functions, that's why no backporting is needed.

Patch 4/4 adds selftests for new feature.

Changelog:
v5 -> v6:
- rebase on top of net-next
v4 -> v5:
- replace BUILD_BUG_ON_MSG with simple BUILD_BUG_ON
- adjust comment about added flag and check
- remove redefinition of flag from selftests
- adjust tcp_tx_timestamp() to use sock cookie 
v3 -> v4:
- remove static_assert from UAPI header
- add BUILD_BUG_ON_MSG with some explanation
- use SOF_TIMESTAMPING_OPT_ID flag in ipv4/ipv6 UDP case
- move ts_opt_id initialization under flag check to avoid extra
  assignment in the hot path
v2 -> v3:
- remove SOF_TIMESTAMPING_OPT_ID_CMSG UAPI value and use kernel-internal
  SOCKCM_FLAG_TS_OPT_ID which uses the highest bit of tsflags.
- add support for TCP and RAW sockets
v1 -> v2:
- add more selftests
- add documentation for the feature
- refactor UDP send function
RFC -> v1:
- add selftests
- add SOF_TIMESTAMPING_OPT_ID_CMSG to signal of custom ID provided by
	user-space instead of reserving value of 0 for this.

[1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/

Vadim Fedorenko (3):
  net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
  net_tstamp: add SCM_TS_OPT_ID for RAW sockets
  selftests: txtimestamp: add SCM_TS_OPT_ID test

 Documentation/networking/timestamping.rst  | 14 +++++++
 arch/alpha/include/uapi/asm/socket.h       |  2 +
 arch/mips/include/uapi/asm/socket.h        |  2 +
 arch/parisc/include/uapi/asm/socket.h      |  2 +
 arch/sparc/include/uapi/asm/socket.h       |  2 +
 include/net/inet_sock.h                    |  4 +-
 include/net/sock.h                         | 34 ++++++++++++-----
 include/uapi/asm-generic/socket.h          |  2 +
 net/can/raw.c                              |  2 +-
 net/core/sock.c                            | 13 +++++++
 net/ipv4/ip_output.c                       | 21 ++++++++---
 net/ipv4/raw.c                             |  2 +-
 net/ipv4/tcp.c                             |  7 ++--
 net/ipv6/ip6_output.c                      | 22 +++++++----
 net/ipv6/raw.c                             |  2 +-
 net/packet/af_packet.c                     |  6 +--
 net/socket.c                               |  2 +-
 tools/include/uapi/asm-generic/socket.h    |  2 +
 tools/testing/selftests/net/txtimestamp.c  | 44 +++++++++++++++++-----
 tools/testing/selftests/net/txtimestamp.sh | 12 +++---
 20 files changed, 149 insertions(+), 48 deletions(-)

-- 
2.43.5

