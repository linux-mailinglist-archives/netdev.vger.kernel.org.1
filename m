Return-Path: <netdev+bounces-279460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NxsIwMG42koBgEAu9opvQ
	(envelope-from <netdev+bounces-279460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE6841FEB1
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D1B43078D33
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C330F535;
	Sat, 18 Apr 2026 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h91FiJXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B02C08D4
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485849; cv=none; b=IMvYRKsYswtiKxqYFG5EsvEPKud0Xbj+oJikKELSm+mLVHiAyKrA3z9bL4x5O4PHLHtHg5hmZATT5cct2ahM/hc5RjZAErNvcdVLfCXKMnW99ycC8u6LN3sflqiNzY9WvxeEYa/VdEta4ylm9u8YtiNOcf3xNK5ZMKPeIWfOTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485849; c=relaxed/simple;
	bh=DNeuuui43Z7WUckyxw1/kPzB8/wmhhyPAn6t/FTVdRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0C/YZ7OkhluAs5LC0Tw3FgpSHFTY7knZCYnt3GGCfqOAWp33+9sglM7HylbHuY72XP0sNpEruy3Kd+O5L2be2RPdC44PcgGAtkymT5tafN033HjIQ4vmGab3+JPiXvXod6nfY670c2l5JCIFmpBeVsE9s9lUHEhp/JXT4j+i9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h91FiJXa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so638637b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776485846; x=1777090646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LhJmNKzbi8lgBR/6qaGu+UXTmOuN+KpkyQcs/Gar+k=;
        b=h91FiJXaMX1ycer1et/ZVCtRWpbDAi0Skejbc3gg4os6SkRZX07Nx/qQJCQ1QA68+b
         MHMD6XO2+PBE+NXpTtLhWd1NmjL90rt/dfL04DFXmH3EzJuX1QCHUfhlZ+zO+5krrr1m
         zbyn4Rp8sqaa19KAxIw0/u/gk7mIjUd3yiJv+fsrk8vNf7KbZakohizxTaetfc8Y0FeQ
         02Z30XdRBSvIGNIcAH6dmpMVQ59DOrIbSr3irbo7cHoMdWLRlwKuJbaQFjAaessqOy9e
         SBy2I2GvxZoVffKmh8S8WgX6AaAxmAcodBDQedv/JbG8rhKhOoOg5A17qNB6p41li29M
         5otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485846; x=1777090646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9LhJmNKzbi8lgBR/6qaGu+UXTmOuN+KpkyQcs/Gar+k=;
        b=EXhi2ifR1xYQOqilmp8bzJ8LQKhSdsHqkG1YTrYUM+HBMvpgC/3OJ2Yo7YUFwtzquY
         c6F7kdJ3fif52fszYwHcJsCccs7zIzEHNHTtX2fCmsSSb70Y9+VnGONaXLvz1PXVYixp
         t+muplSm84ond10agQCP6eZtBVPlpzy+LgaDDB2VrKvx2FRsRdcKae4SAtQHCDvcAlh7
         CWO3HkCqB3aJ7zv8KHVqMBhfCUjNSHhE23VImSmpcqWza+/4FJEk0tXM0ZcwcE1+6P04
         MT3aesV4rjaWsEnWWEp0GAZL9XJ60aM3PtnYCcBjTNviyhbcSV/zqFlMRCMD7G++Rc4N
         QfBQ==
X-Gm-Message-State: AOJu0YxQTj1O1YtxLDu7Rstx4DpXQqNGr2l8y3CJn4T5vx/kWNPk3bGG
	m6c+YR5I4HpgpSLExWdyZtLyYcWsQQ4LzeK5EGcWw48rIxtJrPGq26WEDwf/6GdHtgTsc56h
X-Gm-Gg: AeBDiesRRAOoR/U65Q7OuZ7CZitoUZIIvtF2UJ7pfSdxx3YU4RyJXueGoNIU4mLcpY1
	AlxPHmjgnVfS3KK4x7L0aReJDiKcQxIWCdNaYfmWRptiocSBbdbIzUJf71kmbT+G88NcUEMfL+U
	hF63bqk8AmzikHLcFLneHKu+qpnOtJB1NoQKMaIhQy7raUqncG8rbOE3rOenhEI9gGuKJhNHhfM
	Cp6B/+nlMJf55xXcGGl+74JasG/c5c7iTie7Uj970pYGeGSzcorUsD348n35LHxtlJLk+Luv7/o
	lDia0xk77VR1nmsDaA5XnMwwLXIpw7Pb8yq7Z92pGZT0Xxnug1BIsfMJvrjaI28o+H0BQPpM/Uh
	JS/5Zz2eStX+mhy0Jn6wMH0oZAezqn2S4nvlhgleXiiplkiX0Bb8K4iAcDlRbBv1z1Tl5KccUT/
	AHgp5rBtEqFJ2rnGvdyXZx+oE/jMX8I7XofONBRBCgs5hfDP1qkyFjNsLr9rinIA==
X-Received: by 2002:a05:6a00:3028:b0:82f:6640:7229 with SMTP id d2e1a72fcca58-82f8c91c9femr5819948b3a.23.1776485845707;
        Fri, 17 Apr 2026 21:17:25 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981992sm4356787b3a.7.2026.04.17.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:17:25 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] tcp: call sk_data_ready() after listener migration
Date: Sat, 18 Apr 2026 12:16:32 +0800
Message-ID: <20260418041633.691435-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418041633.691435-1-jt26wzz@gmail.com>
References: <20260418041633.691435-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279460-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCE6841FEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters.

As a result, a nonblocking accept() still succeeds because it checks
the accept queue directly, but waiters that sleep for listener
readiness can remain asleep until another connection generates a
wakeup. This affects poll()/epoll_wait()-based waiters, and can also
leave a blocking accept() asleep after migration even though the
child is already in the target listener's accept queue.

This was observed in a local test where listener A completed the
handshake, queued the child, and was closed before userspace called
accept(). The child was migrated to listener B, but listener B never
received a wakeup for the migrated accept-queue entry.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

The reqsk_timer_handler() path does not need the same change:
half-open requests only become readable to userspace when the final
ACK completes the handshake, and tcp_child_process() already wakes
the listener in that case.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ac3ae1bc..da1ce082f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1483,6 +1483,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
-- 
2.43.0


