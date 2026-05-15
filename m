Return-Path: <netdev+bounces-288406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCzVAgNdB2pa0QIAu9opvQ
	(envelope-from <netdev+bounces-288406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F181F5559E5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 415353010629
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346783F99E6;
	Fri, 15 May 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0uefKaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E83F927B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867379; cv=none; b=ClXDcZ6NYoWxAHgeK+q97gXHoGV4XteLCCmtaPG4OVuhbln6852oeqlcKSR6jr0xlcrxyQSpxryPcxW8nxp4Cw+n2El5yJJnsmz4BKBAust9bpCDp9mQD5ib09lwvjiHVbfCIf+O45QsC7IfIavmTJ8Cq9hZvxNTFbv7W6ru54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867379; c=relaxed/simple;
	bh=n8hKA9fd50zwkFyvAUCn9W6bPFhlF0gqW0JyBAOKqLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDIAeI9rUaCMn1UApdGlQPlRbr+VR8wYmc71OxlVSNDeZiYrCU/z1Cwi0Io7sTiZDXuxFp9HDB+5yj9JMALpRCN6j2E7Oblle0bKfpTm9M4VTDxrWpAOMXeAqisqAxE8iWvEaR3MJVmVrhr+8sJgCYfXEZa7gPEyGkQqZ3Qy81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0uefKaQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36627a0ea23so29238a91.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778867372; x=1779472172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2CJVztQXwsHUVVggJXbRvkco3+hfSWRzHs07/SAV6U=;
        b=X0uefKaQS8noWuflWqio0JvxdTC1AQPPr9Hu9BU9NhBjgGIXe5/4CSiJxVev6/ukx3
         u0LyahZ4cw67DceG8lv38d7HJboEA51+rZ3JlwuWPCOabSlConGCK1V3q8jVHHgtoI7I
         teSpcHSJmlZ8H4cL8hthxjMqqcvHVdgEMAXdWg5qWXGKroAXFwJUMrZCG8sut1tMm425
         6rh3r6wVjSwhKRKkyy1PNfF1ecNOs35+NQG5p3IPhpHINMb6IQceSYOwZASN2mh+87H7
         h3EJ/e1WIvuIRCX9Ia6WtS1N+fn3ppJluo+4V/y5/Dh3YQ5Y9Co/75gPw807gU18wqyZ
         qQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778867372; x=1779472172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2CJVztQXwsHUVVggJXbRvkco3+hfSWRzHs07/SAV6U=;
        b=TIP08UR9RjI88R46Dv7oNrxfNDvIF3G627G8pNkmRY8MUp3MdecntA6Logz+9y1Ybk
         MSvkFJ56olD0kWnxkBFddstsPnv/uCi0Np+BZ0pmxIAQ3zrXuhPtgrRzckIh6sPVXtz5
         ebgp4HhNazJjCq3E/bIJsaP4XpMRoCSwozgqvOdxzENq0ludaviPPO2C1qW+AlwvnC5i
         naKE5Mb16k+gnN7Ii7RWoGgu6I1YK5XJLxSySxjL91KEMOwyvFR18iO8d8M4OqUFlxvX
         04EHQO42FgY8cRZzagJPGslrYUw/phD9lJrQcl9Mpoh21CtjMI8dCCDVTDORB4Id2Vou
         2ZzA==
X-Forwarded-Encrypted: i=1; AFNElJ91ETab9vkRTn1fhELzjy9jx7K1+3x4d7Qq26OdxC8omhGGwVcY2QQoUyJ3wWTKTHxD0bB41hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNZUxxLSWNSnJ2lRyunUjFemV9ipolU97sz3dbmdE/Evhlfj7
	O2VKM9p2vTC0lln5Ztc+GjwG4w2BjNB/3vNjGd/ytmGNrCXWOW59BfFV
X-Gm-Gg: Acq92OF4VP7s49Uzcn0dWaSfrMZ+w7wMAA84To0kquU7365RbSuXykCvqB0l4+Bg+/m
	GkGYn2le6xBlfpMFpnrTH5AX+l+qVilOqqyfh6IwtfFxQ1ZcLcvm6y11fehigus6YD+FHpRX0FD
	mopYVM/EuZt35tJDNl2EHDPUqNnr47p6ixr13nfX4tNawR+C2AT2twvCccWA3d1K/1tIaULT6hd
	rsJoQREkb5b0CI/coehwKjB7Az8d1fv4QwHHACzNzEClTZAah13HobmtFIbEiGOLu24q+sYbjno
	bc+Jj6j15hOCPFV6gpALxEU4rGjWxrpABBx7KaZ5dfaPosAAl7lJzDwXwpHI1YSPKG+5IBQfifQ
	zffr83BiU/AQGyVuMt18cr6Z1TpRi/5xUVbovEK57EXoLOy4eAIQtO3oK4ox5vRAwMLCI87R7UX
	kbxLNiCcae86s1/gPEJ44eet9AsiH1yvCMD0dpEv9Julz1Xzc62/02jPZZpIlcJSuBsXA=
X-Received: by 2002:a17:90b:314a:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-3695173c0cfmr4880885a91.0.1778867372370;
        Fri, 15 May 2026 10:49:32 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157d963sm3193664a91.6.2026.05.15.10.49.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 10:49:32 -0700 (PDT)
From: Kartik Nair <contact.kartikn@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com,
	Kartik Nair <contact.kartikn@gmail.com>
Subject: [PATCH] net/llc: fix UBSAN array-index-out-of-bounds in llc_conn_state_process
Date: Fri, 15 May 2026 23:19:04 +0530
Message-Id: <20260515174904.28575-1-contact.kartikn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F181F5559E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288406-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contactkartikn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,628f93722c08dc5aabe0];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

When a timer fires while the socket is owned by a user, the timer event
is deferred to the backlog via __sk_add_backlog(). By the time the
backlog drains, llc->state may have been set to LLC_CONN_OUT_OF_SVC (0)
by socket teardown. llc_conn_state_process() then calls llc_conn_service()
which computes llc_offset_table[state - 1] = llc_offset_table[-1],
triggering UBSAN array-index-out-of-bounds.

llc_process_tmr_ev() already guards against LLC_CONN_OUT_OF_SVC for the
direct path, but this guard is bypassed when sock_owned_by_user() is true
and the event is queued to the backlog. By the time the backlog drains,
teardown may have set state to 0.

The direct path already handles this case, so the same check belongs
in the consumer too.

Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
Signed-off-by: Kartik Nair <contact.kartikn@gmail.com>
---
 net/llc/llc_conn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 1bd6c5f56c52..1fe666b7ec1f 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -65,6 +65,11 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(skb->sk);
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
 
+	if (unlikely(llc->state == LLC_CONN_OUT_OF_SVC)) {
+		kfree_skb(skb);
+		return -ENOTCONN;
+	}
+
 	ev->ind_prim = ev->cfm_prim = 0;
 	/*
 	 * Send event to state machine
-- 
2.39.5 (Apple Git-154)


