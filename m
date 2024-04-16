Return-Path: <netdev+bounces-88406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF788A70ED
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E91F2159A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3B131737;
	Tue, 16 Apr 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vln4qJUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EA12BE9F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283876; cv=none; b=JE5/b9086otSsYPoLtm9QbzpwWKQgzUf9j96n7okm3oOWJusjYATRulMJ2eS3FYou41MvtWM9p8SRu5Kt6QzZkuxhRypriUna5iyRcFMLR43x4ALYIq5jb4lgtP2b/XPbK4aB6rZejkpLBD1hhwhiTPqCJtZGHr6DYpM9+GUl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283876; c=relaxed/simple;
	bh=WyRoh4sl70M498CJ9tMGz81P+g1RM+DndqovavljXoE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GuX2agmtCg7UucARv8wnDvAUUYQFjKnMPuJO97IDnV05nFsT6E4geYBH4OpQFcVzjfrBDZIWLbhStqc1di7J7j/vgea26loX3wMujIk/23Hg/bhLmYJ6l82AuZ5BllShLI+7Poj1hkuJr9l5RUQvx51UWx3Go58XzRiCrTIbJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vln4qJUS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7519421276.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713283874; x=1713888674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+0WDqN//fwjWBrfsDezWmZtt2VX6qDIy0gtOaLPAeo=;
        b=Vln4qJUSJwroOhnIcxFWdZdboSwyHAx4vOWZQqmyJu5FvMv1VYHEioEp8TgXtRddb3
         TWCKruHrYwAwHhVMBzCK610R32NsJ3p/5n5DfHeg4p6A7UdBjl0J/jUKkWJzIfUZ1UZ8
         YCblI5uoNkIh89aQm/ojPEkDRDISxkvFVlNCGBYsWgkYlMisoNEDPUaELWtGh/A0bcX/
         0wGbhlHO9fpeIjJkLo/c3QqIvGqsBLCoyPgz11E8VFZjKa36Ch5T5zjLPtEDdLa3INXS
         rwzTajqnAdDBMDcQ/SOp+rPaGtfD9+VSSnqxQXivb7LuMOyn10mTwoIgJrryp1LMAA/Q
         +/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283874; x=1713888674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+0WDqN//fwjWBrfsDezWmZtt2VX6qDIy0gtOaLPAeo=;
        b=rne2aDDnbGJJJJqKHVQJBRaUNHl8Aym5uodfSOGmyXfwCaXS5Y/Ty31ef8sATx4xjf
         z3Sq9kyTaxWFDxuplsVfZBqPRc+5P1X9LrI8qbg0/2fzwyDj98Xz+G+AbqDOtJ0wHCde
         +wdOJLjnOT7+wk80Trzol22H0pXDLKzTkmm8QogC7F0GytsaciMkbeKlX4OIrTAJVkEp
         QB/1uQNFQPVOgSyz0H4ddFhBcn1KSyafsBu1J53cDNzEXDMr9umbqHl8GyN/ojM/dqAj
         kIy/h3BApcvx0MkJgpV/BaG5lSglWqPIoOPgW6q0BQM48a5oe+IyOSzvZX9e65MnIwlr
         rVXA==
X-Gm-Message-State: AOJu0YyIMJGHIn8XLtxAZQA+DUK9YVE4UNou2Q6b7TGASIB2RCR/lBY0
	sJF5nfBGQ+/LzKNH4ap1VNTemFNWZXm8DlTwYCyp+uyGm8qNetUL3kB8moqBsRbZt1VIFuNCqwT
	BjxcHZTcTNg==
X-Google-Smtp-Source: AGHT+IHfx2rR/09nr1b8hOQj+LluEX581cmYwszZqiOhHKPul6Pmnfs7duE6aTMCFkJilDKi0V5NtEfwjoN4iQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:120a:b0:dc7:68b5:4f21 with SMTP
 id s10-20020a056902120a00b00dc768b54f21mr4186483ybu.9.1713283873721; Tue, 16
 Apr 2024 09:11:13 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:11:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416161112.1199265-1-edumazet@google.com>
Subject: [PATCH net-next] tcp_metrics: fix tcp_metrics_nl_dump() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change tcp_metrics_nl_dump() to return 0 at the end
of a dump so that NLMSG_DONE can be appended
to the current skb, saving one recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index c2a925538542b5d787596b7d76705dda86cf48d8..301881eb23f376339d59a62bebf150b4b1cae3fb 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -766,6 +766,7 @@ static int tcp_metrics_nl_dump(struct sk_buff *skb,
 	unsigned int max_rows = 1U << tcp_metrics_hash_log;
 	unsigned int row, s_row = cb->args[0];
 	int s_col = cb->args[1], col = s_col;
+	int res = 0;
 
 	for (row = s_row; row < max_rows; row++, s_col = 0) {
 		struct tcp_metrics_block *tm;
@@ -778,7 +779,8 @@ static int tcp_metrics_nl_dump(struct sk_buff *skb,
 				continue;
 			if (col < s_col)
 				continue;
-			if (tcp_metrics_dump_info(skb, cb, tm) < 0) {
+			res = tcp_metrics_dump_info(skb, cb, tm);
+			if (res < 0) {
 				rcu_read_unlock();
 				goto done;
 			}
@@ -789,7 +791,7 @@ static int tcp_metrics_nl_dump(struct sk_buff *skb,
 done:
 	cb->args[0] = row;
 	cb->args[1] = col;
-	return skb->len;
+	return res;
 }
 
 static int __parse_nl_addr(struct genl_info *info, struct inetpeer_addr *addr,
-- 
2.44.0.683.g7961c838ac-goog


