Return-Path: <netdev+bounces-126596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B8971F8B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA84F1C208EB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8601E45014;
	Mon,  9 Sep 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="H5hYbi8u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC91758F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900679; cv=none; b=aOnJCa6uQTBk0CtCAGCkwXyAmrXQlPHOQ8lr84EQDEalDYm6rjPrYQINuL6m00GCVi8yHnATuAakW6Kc8Y/Rb49pzhDL0Ahn99jo6rgMvTVGnw3pXCGisyqo1sH/wJ7jwliLb1A/p6LRk3+dC1ljuTwI5iX+w0SHJ78bDf6Muh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900679; c=relaxed/simple;
	bh=Ec3k502b/pBA3pfyE0JcoIRFFuPECVHmX+YxEkHUY7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bnqmghupw16DcbxMcRKJI4zQtLF7Pwsfmv5zdjw6weFK7vADT20vw7o6LQKC+7V8KedPfi43iu2gohEkyg8GoVrSxXqzRalWV/9U0MK/Gvk+QvoOVKjM4dth1jOQ9TuKuN2eBnq0lfEQAMUKfablU5ez9B3OGWCgQrmIIhIkBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=H5hYbi8u; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 489Cq5pk001415;
	Mon, 9 Sep 2024 09:51:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=eN9
	29uDga2DEL9XMtywKNIsjOtXrdDKFh19D+8uU1wM=; b=H5hYbi8uYOYYrgnnvnm
	tLTlcQg+153TY/nYZFQwzrDjq1WLwi7960PIUQdleBP1hpYdXATw/UrFPozboqUQ
	YnFl6T6xqzPKTHN4dsBmqlySOiSENutQhBZN0zm65A13aFiJXw4s3mg6MFbfwmKv
	ipGh6Ams4AXTFEXYkHs5Us4I4LAnW56G3zDIHWP6T9EjY92tlMQEcHuRpeb3jBii
	sbKvByTEVWZRgaK379J4DoJGl5t5MhZQH18jwe/36FU/51wsiirr6CGNVJFT21Ij
	EhOqXQg4O8FEbwAl1nD09oXnmk/96tUbwlTy9MJIQeoNis8RzQnYUQRPGdpH5zmj
	z2w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41hssfkktf-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Sep 2024 09:51:07 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 9 Sep 2024 16:51:01 +0000
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
Subject: [PATCH net-next v4 0/3] Add option to provide OPT_ID value via cmsg
Date: Mon, 9 Sep 2024 09:50:43 -0700
Message-ID: <20240909165046.644417-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dNQ2iKH3DiL1UW8LBQM5i3owQspnh-oV
X-Proofpoint-ORIG-GUID: dNQ2iKH3DiL1UW8LBQM5i3owQspnh-oV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_08,2024-09-09_01,2024-09-02_01

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

Patch 2/3 adds support for RAW sockets. It's a bit tricky because
sock_tx_timestamp functions has to be refactored to receive full socket
cookie information to fill in ID. The commit b534dc46c8ae ("net_tstamp:
add SOF_TIMESTAMPING_OPT_ID_TCP") did the conversion of sk_tsflags to
u32 but sock_tx_timestamp functions were not converted and still receive
16b flags. It wasn't a problem because SOF_TIMESTAMPING_OPT_ID_TCP was
not checked in these functions, that's why no backporting is needed.

Patch 3/3 adds selftests for new feature.

Changelog:
v3 -> v4:
- remove static_assert from UAPI header
- add BUILD_BUG_ON_MSG with some explanation
- use SOF_TIMESTAMPING_OPT_ID flag in ipv4/ipv6 UDP case
- remove implementation for TCP sockets because there is no easy way to
  keep constant tskey in case of TCP packets
- move ts_opt_id initialization under flag check to avoid extra
  assignment in the hot path
- adjust selftests to cover RAW sockets
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
 include/net/sock.h                         | 34 +++++++++++----
 include/uapi/asm-generic/socket.h          |  2 +
 net/can/raw.c                              |  2 +-
 net/core/sock.c                            | 14 +++++++
 net/ipv4/ip_output.c                       | 21 +++++++---
 net/ipv4/raw.c                             |  2 +-
 net/ipv4/tcp.c                             |  2 +-
 net/ipv6/ip6_output.c                      | 22 ++++++----
 net/ipv6/raw.c                             |  2 +-
 net/packet/af_packet.c                     |  6 +--
 net/socket.c                               |  2 +-
 tools/include/uapi/asm-generic/socket.h    |  2 +
 tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
 tools/testing/selftests/net/txtimestamp.sh | 12 +++---
 20 files changed, 151 insertions(+), 46 deletions(-)

-- 
2.43.5

