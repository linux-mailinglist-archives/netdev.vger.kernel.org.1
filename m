Return-Path: <netdev+bounces-139316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315D9B1774
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E841C20EC9
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E81D416A;
	Sat, 26 Oct 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PksaT4l0"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A3217F20
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942260; cv=none; b=NlJMq/f+0KAUi7XZGDmC9LrvKjjKqSe4XefgTR53GoLvg9kNmmFerFeVsz3AVqu13kC7PWDanw3oZ3ig/98AvQXDaMxMuIH/ZwYW1nlPNJE9A9Q3h4XwH9zSYfhdK6zUsbRqDrXWA28qLjzeaKotvyXKtaLkQ731sx4N+k1hjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942260; c=relaxed/simple;
	bh=xC6PrGtrgAKzLltvzDON86jMvYcR5du8ycWNRS54Zak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXKpg9dPlzqKBIRXlv0ssbn8jYR0V18GfpRgEmYFrY42xMJUcDH1g0WC83uN/uN8utUvjHrYnWV4zfdAT+t+Jg1/4/VPfH5/8jv9FC4aqsIX+yg2hcEN01ZlK4+DwcXxdaEtChpY6qlTYo4b94RjfX044gdXDbxDz9ADzVuUcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PksaT4l0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729942256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wR/ncGcZhqyqZFMMVHrG36CI8RFvjBeFNxRle9Z3euw=;
	b=PksaT4l0C6oKCLz60vl8hyhpnI6Qq1UPZGyog+hQgmvX6u2rx761hwAt5DfKqLlCmv/xbb
	Bjz5lqUr9XM8cqOJ1McbnTWgOfRTElOSNJgaf/QnVdW5b9v4Q1JX6IOKG0QL00SMn68WzG
	rJZGFkhmNTw5OIybb1JYnkEm7raeadI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Gou Hao <gouhao@uniontech.com>,
	Mina Almasry <almasrymina@google.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: Use str_yes_no() and str_no_yes() helper functions
Date: Sat, 26 Oct 2024 13:29:44 +0200
Message-ID: <20241026112946.129310-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() and str_no_yes()
helper functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..132c8d2cda26 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4140,7 +4140,7 @@ static long sock_prot_memory_allocated(struct proto *proto)
 static const char *sock_prot_memory_pressure(struct proto *proto)
 {
 	return proto->memory_pressure != NULL ?
-	proto_memory_pressure(proto) ? "yes" : "no" : "NI";
+		str_yes_no(proto_memory_pressure(proto)) : "NI";
 }
 
 static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
@@ -4154,7 +4154,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 		   sock_prot_memory_allocated(proto),
 		   sock_prot_memory_pressure(proto),
 		   proto->max_header,
-		   proto->slab == NULL ? "no" : "yes",
+		   str_no_yes(proto->slab == NULL),
 		   module_name(proto->owner),
 		   proto_method_implemented(proto->close),
 		   proto_method_implemented(proto->connect),
-- 
2.47.0


