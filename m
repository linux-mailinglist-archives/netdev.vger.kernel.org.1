Return-Path: <netdev+bounces-125031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9AE96BAC6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991632828D1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF631D0179;
	Wed,  4 Sep 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EgzwUoY1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845211D095C
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449555; cv=none; b=CHnqCbiUJEc4c78pYmGDD+YiPg8J2a9SWRiPoOwis3VnD68YAjbfc/SF63MroDhI+3HttnAXox9WyGcI6rUqtZbW9GLO72eMxA+LwtGP0Lv/CfJqU6Fb24jtAq+Dl3hn5PnjRl9o06prefxATqzelPmImX0Zk72a+XmU9BzJG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449555; c=relaxed/simple;
	bh=L/6QMo56MUnlwYEd3xtekQHf3TaOg6YPUMA7nf2EBM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkZW0WIQzvLq9z79/Xb2WVbBjXrMqrKTQ54ajiS4VhPbrCsEoMxdXdBS1ThLM5O99H6SnXfkydf2mhCHkFlY7pM0AtmFURQDAP6B0bhSLLadZEOuQJAYCCVc0o8CVWamBNzl5tyIFbQsoF4OOTTIVPOF2hXTwTHZS2JTA2rNpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EgzwUoY1; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NmC18010232;
	Wed, 4 Sep 2024 04:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=8oO
	yQL2IGIQfcDvmNZqpkifDZsg9jEVKOGtBaM8HQlU=; b=EgzwUoY18N0KwYc/YAx
	cGPDQ6KwClsFKS8SK9Y4d6M5NZykVSZV5Euu1PnpxDD7b42BkyQaKGMplrQUtrFo
	w7KCh5C5TCJZjMwI1n8Fi4ZW4P3e9iQkKGqO+j9Rbv1GyN+hAVhfFa7TW9FaieC7
	p4gfDY57wFur0897/LU4pojRQHSsrnXxTyylHFmwPtDD/k8R/JgOD1UHavpEZrXz
	nGmUpBko9loYxeLn30aCAr4dJ3tiF8JECCw17ghBTkjczktieVtK+zmgZX5jgWhc
	iG1GVj5PjwoRAQ9a8Sn9gHFlE0bXY5tvvb3oScD4CRp2wo+dbwkmjiazY1sIdcXA
	57g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e8fvc8bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 04 Sep 2024 04:32:19 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 4 Sep 2024 11:32:16 +0000
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
Subject: [PATCH net-next v3 0/4] Add option to provide OPT_ID value via cmsg
Date: Wed, 4 Sep 2024 04:31:47 -0700
Message-ID: <20240904113153.2196238-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wpDVLFzCPegdhqpT9OLM2PSUQemlK_oR
X-Proofpoint-GUID: wpDVLFzCPegdhqpT9OLM2PSUQemlK_oR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01

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

Vadim Fedorenko (4):
  net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
  net_tstamp: add SCM_TS_OPT_ID for TCP sockets
  net_tstamp: add SCM_TS_OPT_ID for RAW sockets
  selftests: txtimestamp: add SCM_TS_OPT_ID test

 Documentation/networking/timestamping.rst  | 13 ++++++
 arch/alpha/include/uapi/asm/socket.h       |  2 +
 arch/mips/include/uapi/asm/socket.h        |  2 +
 arch/parisc/include/uapi/asm/socket.h      |  2 +
 arch/sparc/include/uapi/asm/socket.h       |  2 +
 include/net/inet_sock.h                    |  4 +-
 include/net/sock.h                         | 29 +++++++++----
 include/uapi/asm-generic/socket.h          |  2 +
 include/uapi/linux/net_tstamp.h            |  7 ++++
 net/can/raw.c                              |  2 +-
 net/core/sock.c                            |  9 ++++
 net/ipv4/ip_output.c                       | 20 ++++++---
 net/ipv4/raw.c                             |  2 +-
 net/ipv4/tcp.c                             | 15 ++++---
 net/ipv6/ip6_output.c                      | 20 ++++++---
 net/ipv6/raw.c                             |  2 +-
 net/packet/af_packet.c                     |  6 +--
 net/socket.c                               |  2 +-
 tools/include/uapi/asm-generic/socket.h    |  2 +
 tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
 tools/testing/selftests/net/txtimestamp.sh | 12 +++---
 21 files changed, 154 insertions(+), 49 deletions(-)

-- 
2.43.5


