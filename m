Return-Path: <netdev+bounces-206129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FEB01ADF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CF76515B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05062DCF79;
	Fri, 11 Jul 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyHfghXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033C2DCF6D
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234021; cv=none; b=QbsRfEfX6hzXCe7FmF1LGQZnBf6EftO9qZoM0lycDuYsxujvlYgWf4ayNDlUtBXaLcTAsQRLNrBjmKPnEaI4UYdx43+9trIJb7AB1kig2iQONlCnpYhXkbxx1ystMSIigQ8rE1BEKa9g/5mToP9YwxSQLg4fY2zpw2sq755Qn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234021; c=relaxed/simple;
	bh=cGwr7AOF2OfPGDqIfWTchKkx/nCUVKPIdflDAWf1jPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDGAv9U7w9rc98e5bElAkM7w+BtC+fRAUsNeO3WmMvu3YQhQYm0vYDPH/OGI/CKK4fhJV0w0F6JOk+inYhFp5Ee/FuelepdV341cULzoWGkPbkTOajsyXz3IW/3VwQZh3NRB0EVlWVK3TSU2Pg3sscZsdBaagdrq+LhCyUj8AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyHfghXG; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a9e1de6f5cso41268251cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234017; x=1752838817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTYOxIGU83Qw4b7c6K9nbgzusanQANriBo0D0TDK2OA=;
        b=TyHfghXGnk9nKrEMPkZGeu6EnAhFSng9sjWj+jKBj0gYSohW3tlimV36JZnuKuXWWD
         RB6y/XjgurGBeBpAksrL9KUZH/YDPGMmJjrPOJd6tn3y/RZXVGYzXx9QxBQW3vDxyebg
         IKXQNKEyuOvReBGMmwZkgIa6ohEQHbcf3oVfLL8nRy1/gPdAAK5Uvr1ASZQzkMK/oYHu
         zxTn3fZUzQJR5iDeluddDoBj/19CPMqsFn08STKdcko52IMcVgGRlri8NR2ZZf4N6b2r
         2R7yCGoV9Br3vi0yT9Qm+iWbHvf9OPHYoB2jQ4xKMaofQcBR/+A9KdG7t7D91liaQacX
         XdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234017; x=1752838817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTYOxIGU83Qw4b7c6K9nbgzusanQANriBo0D0TDK2OA=;
        b=EUNBVhhBYYyz+MYkkf71KwVHzwGXJrVvVxriTDamCbagPUlrxciSXsHV1Uk0AKIEOu
         2ujo7X0rV2t25r8kPgwa4SuLI1rzPwSm5VMh4vj8TabtS90aVbvxm29Wesv3HnrqCa6t
         Wq27qcWk5OUS42+9QEBYw/8jf2cuI5D+A1Zhvv/+NIqTc17twcMobyQ1DXEWTiCFtrrZ
         +vHYoqiSrcbwEL0uYbXbSl5MEUL/y8aLDDfXjutbaQzS2bzziC2ywn8MNe9i5VF1F/ns
         YQcdY8BzOZbsbDYAJ8DH8iifNiMCiP/ARCv0b4QRz49b+f4/k8HdymBh4Q5ruGAfpZR5
         q9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrjLKP0VsT89W3n1d+m/U7NlIQUsjjGq87rQg0Nz8G4tEgE7Vy8kiILnwPKFNtiZ0Is5WFyZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbV6nf4+ts3ae/Ct4shPDZXppoBBsO0S3BmQqSymfuSC24U+M
	JpJ2J7A1vFDpMncVHg64OvfwQApFOcVZJ9vWWPq7DaRTVPF6EGfP4jyTFP0Ont3FjMd2dlt+Tvk
	RSEFdLneouDbBtg==
X-Google-Smtp-Source: AGHT+IGkRlw2HHvICt8KFtzqKqRkgID85mZZFu/h/PSRtThtb9T6RHpPsp+jJR/rrLUSRWfJgblkPRaunk5dsw==
X-Received: from qtbjb6.prod.google.com ([2002:a05:622a:7106:b0:476:90e7:6480])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d4c:b0:4a3:647b:bac5 with SMTP id d75a77b69052e-4a9fb9592f7mr42115731cf.38.1752234016702;
 Fri, 11 Jul 2025 04:40:16 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:03 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] selftests/net: packetdrill: add tcp_ooo_rcv_mss.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We make sure tcpi_rcv_mss and tp->scaling_ratio
are correctly updated if no in-order packet has been received yet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/packetdrill/tcp_ooo_rcv_mss.pkt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..7e6bc5fb0c8d78f36dc3d18842ff11d938c4e41b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
+
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 10>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < . 2001:11001(9000) ack 1 win 257
+   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:11001>
+
+// check that ooo packet properly updates tcpi_rcv_mss
+   +0 %{ assert tcpi_rcv_mss == 1000, tcpi_rcv_mss }%
+
+   +0 < . 11001:21001(10000) ack 1 win 257
+   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:21001>
+
-- 
2.50.0.727.gbf7dc18ff4-goog


