Return-Path: <netdev+bounces-234279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28549C1E8F8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A74E6B60
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD02F7AC6;
	Thu, 30 Oct 2025 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/Mp5lez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD338F9C
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805703; cv=none; b=BhTGChbLRujWeRAOTrZAzzr5LIAFxN6uMaaeLlx5DU1rh9s+hXr7O7z3YdoEjAo9yBcIQU/lQ1cpW56TImxC7fy6L80NrdpStqvCR+/VH8paf9bdFRVb9u8QBs+aEl6GFascuXbi0M4nX89ZDX+1hg9vxpOctb4xQH4GK2gZWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805703; c=relaxed/simple;
	bh=w9pAGQBGY7bDuDgrALtMYeoQxNqNgWsWQJTjTdn1pqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PTA/AdI+DHCl7HZXXD6OKG2jhQR+QesxY3HN+lgy7ufnInRld006zid6nfZbSrPRjwt8B30uxT+ZvZu/hW/8BCJkAaR/+kHUsf5jqNPmkUk5r0C02fZhop9dKhm+6OlOZcetdsXGXICz/VQd9/V6xw+JDHqcXpjP3mM4ikrrszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/Mp5lez; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso9539575ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761805701; x=1762410501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c42RsXulX4Oh2sCjD2xD9TyQJyCv4HdIm7+NPJkF2uA=;
        b=g/Mp5lezuHo7/ajD+dJ/yb0f/rMGuw20tec40T3uyT7bi2KEQcQN7GeLzUm7YjGNjJ
         VPGu3s7+nogcyLZ+6Fqen4cm5mHExzMFDyR8ALMoss0C5vQo8uppo0UzN+HVySkAKHhS
         XNz9q+4gk405/968GdVpy6hs8u8rdFgE3WAV5YusUqa+kiwd4jkKK+dnGYyloqmpc1+Z
         NR3QXqFXEKdNJVTEz/Fm9SmEIiLM7x48SMyr0VAe0CIFWw4H5jcA7diapKE0OtgZgLog
         0LbkV0YOxgb8vo963yG7/vON5h67RMrYvPxTO5xYsa1GVDfiEHpFSJaMumBya0T4z8FC
         s42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761805701; x=1762410501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c42RsXulX4Oh2sCjD2xD9TyQJyCv4HdIm7+NPJkF2uA=;
        b=Cl0FerHCnj1xnn4VaC7EKpegea7MLSldj9JmhjQCyDOXOIMZOMmbFQ/5UYASEyeL+2
         ng4AGEsnfgE6B0iwK6Qgo6pvup9EaVk83lZhM1heTtGIYlc3/AIBD2JLi1/Rr7PsR1YM
         jFd0hDdVyMuFyckF7hg/GgOgsR1Nyv7eowe6QlAjVmnhyw7Vo/JGUShV/YqvGpKyh+Cv
         8DjmotBwkKfKtET91BdJt/iuigVgxOR2rZ9RScMXGLWBOjsK6Plv5I9llXijO7QnmP8z
         dDRF6UbSBNVZEzXTYaL1gVyvaHZ312/FnqlUNsypEJs0k+8UCg1YJcjTlq+NLLh1s/1v
         hsbw==
X-Gm-Message-State: AOJu0Yw7I1xtfhshFpl5PENwtXxf+D/zvtDXbK6rzhAIjG5WXmcI6hom
	eCeyJXc0HhG4Vti8pqj1AUBErahiHQ98nLH7MkH6UKBA86s//7IiRS3v+25SQzr75UattbrmKIO
	qts8NcKOuSYHg74ZLo2i8/OfYcXWULpUykzQi2w7HdZ5dPJOVas2cepaozFU/rtF0/VWv7oyfaS
	YVb4oAuCk25O2i4mypozz6nHzJbpsMI4Wfi4QUsNgDMLeA7EqOYYsy7ncExiCyk+ErVtPBu9nKk
	Q==
X-Google-Smtp-Source: AGHT+IFwc4uonwhtA9YhR90vK8g5koHgC6wlS3wtKbUjCIBAMIWM++wEGdvivtVXrmSQSHlMRC20hnhQs68mLl7dH3BI
X-Received: from plry14.prod.google.com ([2002:a17:902:b48e:b0:290:b0eb:f853])
 (user=anubhavsinggh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11c4:b0:280:fe18:8479 with SMTP id d9443c01a7336-294def36c4emr64176565ad.51.1761805701448;
 Wed, 29 Oct 2025 23:28:21 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:28:18 +0000
In-Reply-To: <20251030055714.1553346-1-anubhavsinggh@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030055714.1553346-1-anubhavsinggh@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030062818.1562228-1-anubhavsinggh@google.com>
Subject: [PATCH net v2] selftests/net: fix out-of-order delivery of FIN in
 gro:tcp test
From: Anubhav Singh <anubhavsinggh@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>, 
	Anubhav Singh <anubhavsinggh@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to the gro_sender sending data packets and FIN packets
in very quick succession, these are received almost simultaneously
by the gro_receiver. FIN packets are sometimes processed before the
data packets leading to intermittent (~1/100) test failures.

This change adds a delay of 100ms before sending FIN packets
in gro:tcp test to avoid the out-of-order delivery. The same
mitigation already exists for the gro:ip test.

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anubhav Singh <anubhavsinggh@google.com>
---
Changes in v2:
 - Add 'Shuah Khan <shuah@kernel.org>' to the CC list.

 tools/testing/selftests/net/gro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 2b1d9f2b3e9e..3fa63bd85dea 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -989,6 +989,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 
 static void gro_sender(void)
 {
+	const int fin_delay_us = 100 * 1000;
 	static char fin_pkt[MAX_HDR_LEN];
 	struct sockaddr_ll daddr = {};
 	int txfd = -1;
@@ -1032,15 +1033,22 @@ static void gro_sender(void)
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "tcp") == 0) {
 		send_changed_checksum(txfd, &daddr);
+		/* Adding sleep before sending FIN so that it is not
+		 * received prior to other packets.
+		 */
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_changed_seq(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_changed_ts(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_diff_opt(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "ip") == 0) {
 		send_changed_ECN(txfd, &daddr);
-- 
2.51.1.851.g4ebd6896fd-goog


