Return-Path: <netdev+bounces-219486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4738B41901
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006663B94A6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970A2ECD2E;
	Wed,  3 Sep 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2IKOvYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157F2EC540
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889248; cv=none; b=uhLpF8qqXyDcCv2zyrrRND7ycwCFoIihPvcWmuKuH5XCjsIflHiqUsBorj/KbFqesSt48AUeyVvRfWeCixI5kWzcJEmQSXU/nRBA8At77aXIBqSygInWebqMiHZzfI7JDL4o3MNVccw8vShwKuFwca6R+iEfrvrTWwNFW8NrIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889248; c=relaxed/simple;
	bh=YEqg/fNE5XF2sUUr9jmVCqU0FDMx9aR2Z1lLUlaPx28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O01ZaWzQA9m2fWk0z1pKlikAC0Mxib3nIweDX8MpWy7tKy2fOEeE8UI6hsGUF4MnxTPT8UbT5A8euiuW0jT+30QH5SZi/97jmw5cjncugXsaobrG9Yn5oMLvIIESYjBv1qhpQJjjolJn32W6NlU4TlVwgZ9qIn/euk5t642ktfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2IKOvYJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b32b721a23so61253811cf.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756889245; x=1757494045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvWW/PKki/9qieVi0Y2AxxKzPQhiiO2QZoxgdHXWaMA=;
        b=o2IKOvYJHOxxscxxYku268b/33qvQKemgpLq1gDG/VPi8HgvU/sIaUYvlylflKgW6j
         dr3vfUwKDPfkTvpT2ngd0Wp2s40sJpKReQPIu448D1iNfH03s6GppdxgpzKqsXNIEepf
         6hiTStCKNwN9jsdRAo71TGtWaQs1QLujk2PdZEEOKxrQluTXtQchWXPSzFi88ubkdy/5
         jayftVbZQnr8IamSwXT1H3MoxZBE0U0gPow8fhfvWGtDDkYqr+KrAj6n3+uXKqV4LqzI
         hK5/1oTQXoOXhwvPIaRhA2bRyeIY3CcpZvB4IOMVgOQ1ItXkqcwDUahQUsdnIH7rOUQ2
         nTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889245; x=1757494045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvWW/PKki/9qieVi0Y2AxxKzPQhiiO2QZoxgdHXWaMA=;
        b=v+O/FJBifnCyzGehDEsV0Fv+TQYLCuWYRg0ejPGI7tpTbM/qefs6mF+vhibY2JH4so
         tcfF0txYcjAueJsGININ/Io+83ur43PT3ysiPtRaMo0CMJEidzwSKBK37W/cs1UCrSmj
         vIkWSsXn3dwuB3et16/3Jbir/VhHp9b0cctcu51xqShdJUhCqY9h+HS2O6Sw0Gh4r/YE
         ptCCusaQ6uOsiQOtDD1WF7l/6m6y9q0vJvHRAwsMALtOML7PoQH11u3KlP0YX1iAHfA4
         MhEi2+EexqluWk+Mh5f6/P6jaq0jvEGUzp3pGZuVCSGB0/GXCsxwaRPq5hf3FMsWCHw+
         ex8g==
X-Forwarded-Encrypted: i=1; AJvYcCUze0m/fSRAKZAnw7aZXScRoA8GZJqW/5iN8c+n7H3SBjuHm+6yjHu2F2lF4oIeYIrBnbXloZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIOXH46ziBqI9q+fqwzx25uCAVKw4o7l0uO9or1joggW7He5K
	VK8zzBiQMCw3Hw5oUsa++tgiXQJhOI9ZTO5jft97psX0wjiGWQJUYqE98brvF7DL1XFog8o9hWn
	s3hKZyek3YyK6Bg==
X-Google-Smtp-Source: AGHT+IFqOrqLfokEKYHVRPlUG7DSHDfPES5EEtEkrcQuODCLciGgfD7YLRxnViEb+1VTl1oorCFbnVLTB1VOYg==
X-Received: from qtxy13.prod.google.com ([2002:a05:622a:120d:b0:4b3:4718:504c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5144:b0:4b4:8f9f:7469 with SMTP id d75a77b69052e-4b48f9f8a35mr18808051cf.18.1756889245135;
 Wed, 03 Sep 2025 01:47:25 -0700 (PDT)
Date: Wed,  3 Sep 2025 08:47:19 +0000
In-Reply-To: <20250903084720.1168904-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903084720.1168904-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] selftests/net: packetdrill: add tcp_close_no_rst.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This test makes sure we do send a FIN on close()
if the receive queue contains data that was consumed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/packetdrill/tcp_close_no_rst.pkt      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt b/tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt
new file mode 100644
index 000000000000..eef01d5f1118
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+  +.1 < . 1:1(0) ack 1 win 32792
+
+
+   +0 accept(3, ..., ...) = 4
+   +0 < . 1:1001(1000) ack 1 win 32792
+   +0 > . 1:1(0) ack 1001
+   +0 read(4, ..., 1000) = 1000
+
+// resend the payload + a FIN
+   +0 < F. 1:1001(1000) ack 1 win 32792
+// Why do we have a delay and no dsack ?
+   +0~+.04 > . 1:1(0) ack 1002
+
+   +0 close(4) = 0
+
+// According to RFC 2525, section 2.17
+// we should _not_ send an RST here, because there was no data to consume.
+   +0 > F. 1:1(0) ack 1002
-- 
2.51.0.338.gd7d06c2dae-goog


