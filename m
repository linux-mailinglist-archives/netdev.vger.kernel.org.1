Return-Path: <netdev+bounces-226943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17FBA63B2
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58525162821
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692123B605;
	Sat, 27 Sep 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwnCN62O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445024468A
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008655; cv=none; b=F9xyX9oMBVL+V2QMCR2COz6571+JUyPLAN/A9Phs13aMwKhfKJFvVyat7gSp1bS/qmbgs9zPrrsvTDmcva0D1m81maqq4yxyKoFpDD46OCkDQLHDbfq9Y2e5T3To91PMBuHIZVybxIcZqAyeiV2VlkzdaKp9IHF+Okj1tsQJSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008655; c=relaxed/simple;
	bh=piWlLpwO9Ecg2j7tYnnA3tdd3StgU3j6d7VNZt+vG0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ahCjR2TT0jzvaTdchZyHwtR40XgjQAWzzIUIjyJxKErDJcoEXkpDPKr7dNI/veTsL4wPZIxsEfnmHTu1VsidHhzYFnvamZlBOe2TxGhYN0hNGiUripvTEMunU/H6+NmxNukQBEqHk/gk68c2X5URk4G1JR9O7lwyuHWpnq+vMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwnCN62O; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so5236520a91.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008653; x=1759613453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Imnla0NbF3GhaZkYLNjn6iOEVgJ8EDOR0L5uzt5OnBI=;
        b=XwnCN62Orh+/g9GSuDYOAHPtQlBfXHgvKzKfFV6oEAZU1LT4bc/HbsnMWg8+askgq6
         kPXkjBedHh6O6gofGgX5yJ5UuxVr6Sri96H3TOyooeJgvo2qYwbVbrm+TM418T1q6g2t
         5b3eJYhFuxzDdSXhtc7S9TCi1BsiA5BE/a4LaT4umKgR0GFZgpL9P8e1ZF9SnaaMEZPO
         EgnpUkWVc1Zn4oke5Z2znADU4AhBK+bjIjfD3sSLsaoC0I+zQvBLHe/qotLC/R52t5Gz
         whBQI/rn2DaVFXbm+LSK5LE7gaxdBz201MpY5P0aRDdobfHMPAwsqQa+J4w1IlRqww5K
         lwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008653; x=1759613453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imnla0NbF3GhaZkYLNjn6iOEVgJ8EDOR0L5uzt5OnBI=;
        b=R1ueMqfog3ptHFrPo7g8nDotuDa6rd7r2P3+NP/AvCHo9fNPZyAzr4Fw0abLDkjL8B
         nqGmE7ZcOpm/pbp3feYJbOE/m3digrcBprZ7XdUzWhSvSGFzXiZqDR9S67dxko4mNPKQ
         kLlIxO5H5KGVhGSBLoytkeSmG/FF8CuTBa8QGy4kPmx3pumLAqKI3X3CeDHC7x0SjXMp
         mgDrrw1QhmJsuYrwwIUxjXIRyy/okUD2aTfTy8gFkJiKryXzkF3IbETMfpxEnoG1IpmJ
         IKsXzor2a1oMKY/giYbMSqO4xfZ4zhQlVFUo9fT4pRxuFJxC87QSC6syIBLfKNYpgrwV
         HiWw==
X-Forwarded-Encrypted: i=1; AJvYcCW4/BQfKgKN4swjjQGn4uHRoOy2IAKmilmHBpLK+xR6fBwV70XjTr2UfYOGz/jVAV1ZKUGqIJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDT6WnP07t7y/lhBHVb3WU7UHcIvOKPEuQAaxBbOKdFsp8nDof
	1VTvm2Gz2zfR/uRj7MRWxKvjvcEqgPWqTpubv1124H6F7mX8WN3tWjfOpRAkUNiAZtKOKCexsfV
	tVzHLtQ==
X-Google-Smtp-Source: AGHT+IHVgjiyXb6p80HhIpiKDq9+c0d2um30AysJKJeunlWn2S2D3E7G9GBVATkR3S9HkyfkjXJ+3cFCbjk=
X-Received: from pjtl10.prod.google.com ([2002:a17:90a:c58a:b0:332:2785:5691])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f86:b0:31e:cc6b:320f
 with SMTP id 98e67ed59e1d1-3342a2574b0mr12359190a91.5.1759008653348; Sat, 27
 Sep 2025 14:30:53 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:51 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/13] selftest: packetdrill: Import client-ack-dropped-then-recovery-ms-timestamps.pkt
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This also does not have the non-experimental version, so converted to FO.

The comment in .pkt explains the detailed scenario.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...ck-dropped-then-recovery-ms-timestamps.pkt | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
new file mode 100644
index 000000000000..f75efd51ed0c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// A reproducer case for a TFO SYNACK RTO undo bug in:
+//   794200d66273 ("tcp: undo cwnd on Fast Open spurious SYNACK retransmit")
+// This sequence that tickles this bug is:
+//  - Fast Open server receives TFO SYN with data, sends SYNACK
+//  - (client receives SYNACK and sends ACK, but ACK is lost)
+//  - server app sends some data packets
+//  - (N of the first data packets are lost)
+//  - server receives client ACK that has a TS ECR matching first SYNACK,
+//    and also SACKs suggesting the first N data packets were lost
+//     - server performs undo of SYNACK RTO, then immediately enters recovery
+//     - buggy behavior in 794200d66273 then performed an undo that caused
+//       the connection to be in a bad state, in CA_Open with retrans_out != 0
+
+// Check that outbound TS Val ticks are as we would expect with 1000 usec per
+// timestamp tick:
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:1000(1000) win 65535 <mss 1012,sackOK,TS val 1000 ecr 0,wscale 7,nop,nop,nop,FO TFO_COOKIE>
+   +0 > S. 0:0(0) ack 1001 <mss 1460,sackOK,TS val 2000 ecr 1000,nop,wscale 8>
+   +0 accept(3, ..., ...) = 4
+
+// Application writes more data
+   +.010 write(4, ..., 10000) = 10000
+   +0 > P. 1:5001(5000) ack 1001 <nop,nop,TS val 2010 ecr 1000>
+   +0 > P. 5001:10001(5000) ack 1001 <nop,nop,TS val 2010 ecr 1000>
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+   +0 < . 1001:1001(0) ack 1 win 257 <TS val 1010 ecr 2000,sack 2001:5001>
+   +0 > P. 1:2001(2000) ack 1001 <nop,nop,TS val 2010 ecr 1010>
+   +0 %{ assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state }%
+   +0 %{ assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd }%
+
+   +0 < . 1001:1001(0) ack 1 win 257 <TS val 1011 ecr 2000,sack 2001:6001>
+   +0 %{ assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state }%
+   +0 %{ assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd }%
-- 
2.51.0.536.g15c5d4f767-goog


