Return-Path: <netdev+bounces-286168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YILIJ8Qn/2nK2wAAu9opvQ
	(envelope-from <netdev+bounces-286168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAE4FF969
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE06300EF44
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B434A79D;
	Sat,  9 May 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T2eSd+wz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3231E826;
	Sat,  9 May 2026 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329537; cv=none; b=A4S70DOaJILDG9xH9qoWH5inGCZBS9/JtjuUfYwxj1p12fz88WOL7dm7oHRHqg/hYg77EljFQmpAjeRXaNvY7CRhiCt+/80HstHyw/pzl6rW3tWOPJ6/cuhdcQVy53mGKnhtFNRTaRubVO67oLf+4ub63iU0PjMGcKX8Ihb3l+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329537; c=relaxed/simple;
	bh=SZzgKhru9GjGOWN+5OHlyXNBAsMahYKqH36gc5+DQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNChEtZxx3h+HELntHuOR2hg5e0va40kJ4gKapykI5BU0BUsbbeOR3wrKZWw2urcALy2FHf317O3/ZbxTigewNne7kN96wMsO92WtwhJvzU97Iv2U06ZuZZkPoUDCIe+RDIaLeyozfpdtADYSnCxcKi59rYeS9HE6e/Ej44h6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T2eSd+wz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fk
	g6lQ4GJs9udxWaNzC8LJuS4vQnXLrNAT5MiyCXhPU=; b=T2eSd+wzsdcOCHqlYG
	VQR95q68JBfX7qGJJ3FpFYZ3Evck1QYSejkNGH1taLYtk7ILgs1YIrIis0llP70D
	XFPZlGpiLz7tsBJvmav7AkP4+sJHpkEeIHrNMsMk69Ygxqm6fiis9Iv6R1QICwLK
	mnY+Tspn8BkZECJA6dSPazTkk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXMmqCJ_9pzPqMAQ--.11251S2;
	Sat, 09 May 2026 20:24:35 +0800 (CST)
From: albin_yang@163.com
To: 3chas3@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	albinwyang@tencent.com
Subject: [PATCH] net: atm: fix skb leak in sigd_send() default branch
Date: Sat,  9 May 2026 20:23:58 +0800
Message-ID: <20260509122358.1102997-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXMmqCJ_9pzPqMAQ--.11251S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr45Xw17Kr13XrWrKF4DArb_yoW3tFX_Wa
	48trsagrW8Xr4fCws3Jr45JrWfKw4rur1rXrWxKFWUJa42yr1UKr9YkrykJ34UKw48tFy5
	uws5ur95K3WYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8I_M3UUUUU==
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbCzgNE5mn-J4P4OQAA3c
X-Rspamd-Queue-Id: E4BAE4FF969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286168-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[albin_yang@163.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Wei Yang <albinwyang@tencent.com>

The default branch in sigd_send() calls sock_put() and returns -EINVAL
without freeing the skb, while all other exit paths do so. Add the
missing dev_kfree_skb() before sock_put() to fix the leak.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wei Yang <albinwyang@tencent.com>
---
 net/atm/signaling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index ae88a5d2f29b..0000000000000 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -179,6 +179,7 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	default:
 		pr_alert("bad message type %d\n", (int)msg->type);
+		dev_kfree_skb(skb);
 		/* Paired with find_get_vcc(msg->vcc) above */
 		sock_put(sk);
 		return -EINVAL;
 	}


