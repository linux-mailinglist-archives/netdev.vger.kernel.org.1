Return-Path: <netdev+bounces-226793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C3BA536A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048BB1C05B03
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC9299ABF;
	Fri, 26 Sep 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCEJA1su"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76530DD16
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922190; cv=none; b=f5kNRG3MzqxE5oPM9cC4R1C0FF2hP1+piuHWW+w5kd+hZ45LZQ6iTJrTyAhpjqtBtPRhIKd716XtDAzp1UuvQvxrsfIkQESmHxlubPMIuJ9YwRzjRF1c5spEGwpxcVJJQrGzFgeuxOm/0qyweIaS2mOxMxVFBVhezqq75FSjOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922190; c=relaxed/simple;
	bh=Y3UC5mO09PjS1vpAQKhuOl/l4+6rPYkAKF7uWRGAzyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6Cbi5whdrZPDEQANRtmEVcKiEPQaVm+aQK10RkQk8SJV0K14XEIdm3AEZkswyrN56X2Ch7LxBRr0rgqoMs2N6l4cYG8KxWzjFJFGSPTow8KKNj7RqIbIfNTDUZobhXpF/NZGFahhXrpiax8S24YF+voEXBtdVpJmM1lyMDPiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCEJA1su; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7811e063dceso730691b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922187; x=1759526987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIITuj72YOmnz2hu/W2qTxJiVbUDnDzb6G9tSPPQWQY=;
        b=NCEJA1suXKH7KOKXVAXOj3ZQ0TGILG+P33enQhEStdSlpZLqUuN/lm2DOvvQzsQpH5
         eykvaQGsAzmFuTxFmQhDBCYSjydjPxbTMccKHs8EqD0vwd6YI/m6I5qaram8WqKwU6Se
         xHvMHEoD0ZMouXy/K5EFOYZ057YBDZEcgLDYjojmcVWct6/f2cTzC4r3jhxftRBS+HNS
         8iFGxYJT8dYY48C2IrPyrCF3v2pIqY2jRD12Rz4P4Zvk1gv+gqf1yyT+LKR+PsC94xeC
         gmuLpfVfGQNJu89kWZLs7YznE6lk5HIctfQtN6mVrMPhYCXvdGHko4q3uVPiRlwMaaH5
         o0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922187; x=1759526987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIITuj72YOmnz2hu/W2qTxJiVbUDnDzb6G9tSPPQWQY=;
        b=JNALTddI7sKuw61hyNKZmqHycuqtEfcwGTr96JDWU88RL4CEnR+NZsAJbczHmPjrUl
         IzbOHoh5IspsqKAr/OXYzva0rus68Af0T4Aq/vbElhJFV9U/JbDv2cTMIrlfmE/0U6bm
         w/AQW9painuMwY2J8b1IY65m1uxJRO/ZJUvlQ5loiZ7AKBSiBc8H45XbeSJeudyROAPB
         gOgwfTGdm/oseEueUSCopRKliZJJInXSvmWS0TfQ0qmNMxF1zU/XqfCC1Y1gpYw4ymWd
         pVGxGSI7y8zDzlyuDzeY58jv4DfLEH2kr1INNE1Cr02H04fCPHbAPI312VbCJbxzC6ps
         3Ijg==
X-Forwarded-Encrypted: i=1; AJvYcCWu4+7PUCM56wCT+2t+kHuQOVZXzqnymS8PqK0U6K7l4lwx+wjLGWc3nNfHnLA2fz40YW1Ixbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bp8RVKmgaQbETsvKmyki4c738QPgXWwpBzURGGJWncI8hCal
	GMd1nCqiHh1kVarkRNpDCrZi6uHot+aMnpZ3BonZPelIGlwSP8pAXn/+VmhKJkQYwSbSNgUXx/o
	7dnVtAg==
X-Google-Smtp-Source: AGHT+IFYdKAxBvRoF+2zzZhHW5Mp/C5wSlrspUp3d7FbBQkdcFE3Cw1DocCI3f3yi9/s1GOB17R4dGHZBFQ=
X-Received: from pfbeb24.prod.google.com ([2002:a05:6a00:4c98:b0:77e:59ac:a03])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e098:b0:250:f80d:b355
 with SMTP id adf61e73a8af0-2e7cdd9ffe1mr11288001637.33.1758922187171; Fri, 26
 Sep 2025 14:29:47 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:03 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/12] selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports the non-experimental version of opt34/*-trigger-rst.pkt.

                                     | accept() | SYN data |
  -----------------------------------+----------+----------+
  listener-closed-trigger-rst.pkt    |    no    |  unread  |
  unread-data-closed-trigger-rst.pkt |   yes    |  unread  |

Both files test that close()ing a SYN_RECV socket with unread SYN data
triggers RST.

The files are renamed to have the common prefix, trigger-rst.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...pen_server_trigger-rst-listener-closed.pkt | 21 +++++++++++++++++
 ..._server_trigger-rst-unread-data-closed.pkt | 23 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
new file mode 100644
index 000000000000..e82e06da44c9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Close a listener socket with pending TFO child.
+// This will trigger RST pkt to go out.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+// RST pkt is generated for each not-yet-accepted TFO child.
+// inet_csk_listen_stop() -> inet_child_forget() -> tcp_disconnect()
+// -> tcp_need_reset() is true for SYN_RECV
+   +0 close(3) = 0
+   +0 > R. 1:1(0) ack 11
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt
new file mode 100644
index 000000000000..09fb63f78a0e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Close a TFO socket with unread data.
+// This will trigger a RST pkt.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
+
+// data_was_unread == true in __tcp_close()
+   +0 close(4) = 0
+   +0 > R. 1:1(0) ack 11
-- 
2.51.0.536.g15c5d4f767-goog


