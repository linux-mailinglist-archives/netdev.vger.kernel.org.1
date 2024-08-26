Return-Path: <netdev+bounces-122030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADE95F9F2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5A1F232A0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AB130ADA;
	Mon, 26 Aug 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHNOJGGu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A578C93
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701784; cv=none; b=LEcBPq2G46SAvguMq7QsD7hTzzlnlqUFwqUSEuW+0mYrTEgDXlQ9YMrWCPCPU8L1d/hfLK4QcC7lan+5YRfuWPADAOwv0uLNS8L6vLVbhmJkq/8oGta6hAbifE83Ncbt6vr08ffAN6wTf7FiDlb3gv0wICEPm3en2TmGiFWhcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701784; c=relaxed/simple;
	bh=upmIj4iHs1oz/RTNFDujiq18Ts1JOuIWbpA2ZtO2IoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cC/XkVN532lP5NbqXUGmI8yegbDN2bOP8PKI1FYiVp3LD55N2SLhWl/yKXX2zU/X82WrVj1T0jTCQXO4T+3h+9oA4NF6ePzDpqlZ1EytKLXwmOuBWUnP2lGubDzW8JBQhV/gDMNqC2viNzzGlc3AMxT4aN01HbcI/lvJC/+s0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHNOJGGu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724701781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYe2pwW4VxuxSk/smNvvbWzaedo3jmVmKOyaCpUpHEY=;
	b=RHNOJGGuSzaCPX5o2WDC/jVv5oyimURCCPn01bcQ3vSEG1CDliYy57Y2xAwKB3fW1cjT3J
	925ta+J0LjS9y6rmP2n/8XGgkr01QkIEVjVNBRjTZUcTw/CXyDUB5G6Qjl4p8TITFTacAB
	UD5aVQLLGWTfN592g0/yBjJr7HlG9Tw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-odcqeoLuOQSagcInKSMbFQ-1; Mon,
 26 Aug 2024 15:49:38 -0400
X-MC-Unique: odcqeoLuOQSagcInKSMbFQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA4D01955D4E;
	Mon, 26 Aug 2024 19:49:36 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A03E19560AA;
	Mon, 26 Aug 2024 19:49:33 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next, v2 0/2] Adding SO_PEEK_OFF for TCPv6
Date: Mon, 26 Aug 2024 15:49:30 -0400
Message-ID: <20240826194932.420992-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Jon Maloy <jmaloy@redhat.com>

Adding SO_PEEK_OFF for TCPv6 and selftest for it.

Jon Maloy (2):
  tcp: add SO_PEEK_OFF socket option tor TCPv6
  selftests: add selftest for tcp SO_PEEK_OFF support

 net/ipv6/af_inet6.c                           |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/tcp_so_peek_off.c | 184 ++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c

-- 
2.45.2


