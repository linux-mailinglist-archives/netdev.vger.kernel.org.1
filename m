Return-Path: <netdev+bounces-206132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8AB01AE0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0971CC0754
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9902DE6F0;
	Fri, 11 Jul 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0GZ4iV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757B2DECBA
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234024; cv=none; b=q+tl3GTTVVenntGeFBFdk/jo+KUBDp/LPLo/YFTmutxJjmZiLHFzstpIu/GadEs63Z3IKsixHyZ8SHp6H7u2xlB3sCmfufy1dj1DleMGUQzj/tScN4r4vhpSNnSC5rO1WLOGzhWmjjGk94UY+XCD5IAAJ+1ZM4c6d//r6Rk/vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234024; c=relaxed/simple;
	bh=hcPUQA2gIjox/hV4Xw4sVDp/RdRoHWbC7gUCLo97hsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dmusy1LFVAEQWhMS43C440QxGdgac9YklsdENeJfG2cxmaA9Qy0VuMa+5OIEnb1rw2bbHBctvBlgDs9YKKbBIyh/tAGMlBotwecorMrEk6eO5PLVK4YlBbb9pG2dxrHAO+INM/vVzMlutQHkyiuysKOHuBCmwvU3F+9NkVifML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0GZ4iV/; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a442d07c5fso36709351cf.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234022; x=1752838822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BoQKBiVr3qfdiIVr4vktlJH39LphAXbdQKmkO4D0fo=;
        b=w0GZ4iV/fqbl5HyKHadceNxJkovMLDO1AHadk78bZYpVvQS4kZOkJRxVKu5QR8ijp7
         /VNgycDWDRUoSNlc4yCN78y813TnJX+GseHMj38Xi7MjulOMqi1N7MhpsUD1O/0rm3cO
         usdb3e/Ufz6v4MYbfy9+hou/+F5ar52+Wrr+2VzSnzVx/UIrJ/Vvi/eyKrQIsSswjLb1
         Ym+EHNdbeD6zExLqpSugge5ieqaFuXXlwx1mNN2mwkLOVzrUQ+GayLHPLhgBAVCAX8+H
         vFxG2f6reanze3rg+MQbKDiLO3iZ7vwJChvi6PySRQfZcpN9qlc9Xj0wqSOlr2MD+j6h
         +sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234022; x=1752838822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BoQKBiVr3qfdiIVr4vktlJH39LphAXbdQKmkO4D0fo=;
        b=g9lVR+h3DdzHfN21PaiJOcAnqS2b5zA1BV/qbURU4RVjV7je27UVNDuAIoJ3EWE8Sc
         ybd73NUI5W9MmF69uEcUW9Va0JRNwhoem7cwfiLyg21nldCyBSfMAf66TCrfbyL30J09
         vO7hvxBS8J1pu+AkYnjig9P8gu0CCEcowL4KSofiXJe/GpOUne3cIKBSaIUQ6ilxWjxV
         Cf2YUhyjBzfCxvhSYREN/2G/eTxZHvkzfyINbE/4zIAB9ciyYCDSMh/K7nYPU7B+kjxq
         e9yw8184bMK++D23Fv9bKh4z9y5h22EKqQ/mX/kSA9eXTvN09jykNj0gixyWBCVIfIiR
         PCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqkd0c2drEelRUIWcVBZtXWTPvgtb6C6tc16uoSAapG9av0Vy3yh4ZWiVc814LCHX1WRORPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxQLtPcCOTFIKgJH2/hxKONWdKYBN8MRr4CEdN1gW67nSgGis
	Po+O25qp2KTACo4V41oLamUUD8aU7g0Z/P1tN0N74a0DE2BNurfp+dlhmXWJ7Y7/f5t2HclPpP4
	kfjcjPg3hFtuQkA==
X-Google-Smtp-Source: AGHT+IEiZSJcTJIinqqfiL1OD+D1dtRoQufHfoURXOBfZQ0KAj0rDxIkdorvO0kZQcoBN47B+YKhH25SbPw9HA==
X-Received: from qtbew6.prod.google.com ([2002:a05:622a:5146:b0:494:57b3:465])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:790f:b0:4a6:cee6:9743 with SMTP id d75a77b69052e-4a9fbfca78dmr28047711cf.5.1752234021746;
 Fri, 11 Jul 2025 04:40:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:06 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] selftests/net: packetdrill: add tcp_rcv_toobig.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Check that TCP receiver behavior after "tcp: stronger sk_rcvbuf checks"

Too fat packet is dropped unless receive queue is empty.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/packetdrill/tcp_rcv_toobig.pkt        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..f575c0ff89da3c856208b315358c1c4a4c331d12
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:20001(20000) ack 1 win 257
+ +.04 > .  1:1(0) ack 20001 win 18000
+
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [12000], 4) = 0
+   +0 < P. 20001:80001(60000) ack 1 win 257
+   +0 > .  1:1(0) ack 20001 win 18000
+
+   +0 read(4, ..., 20000) = 20000
+// A too big packet is accepted if the receive queue is empty
+   +0 < P. 20001:80001(60000) ack 1 win 257
+   +0 > .  1:1(0) ack 80001 win 0
+
-- 
2.50.0.727.gbf7dc18ff4-goog


