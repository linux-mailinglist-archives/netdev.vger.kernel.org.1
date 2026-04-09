Return-Path: <netdev+bounces-277064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICAYID7V12lZTggAu9opvQ
	(envelope-from <netdev+bounces-277064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB73CDB29
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D891301DCC2
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9523E1228;
	Thu,  9 Apr 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="aH6o9YBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5253B0AD0
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752468; cv=none; b=gWg8hstQMljHuxx+CNz5cIhIQS+Co1q/3gpZAzEJmUzYRRZsvJNKWuFyXKQLri3raBHmoToLewnCI/f0EoaKogrh1YhV2ecJHAQoLFxqzL9kOytt/Xmdbl9fmiT+1bI7r7v8RHIsgmCKaeJezrUTumfl9SPZrv7Zbkbm4Wqu9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752468; c=relaxed/simple;
	bh=5HPjyCGIUcS+XZxwOq7su4bREXkMRa1byoy+Frp53Po=;
	h=From:Content-Type:Mime-Version:Date:Subject:Cc:To:Message-Id; b=UBmyvMG3uHgZPS1IM7fRvi8eNNsHVpTohMy+AapXRZ12CJf81jm9PGK3h4sz8hS8OhzCyDHBQyczVi/bcEjvRmbKrzrAm7hDO9n0uT2IraWidH9/1iLNOg0BelMm6wK+2NN0w0w6o9sxZRIfeo9WhorpcdgBhBNXqvD4XrAGi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=aH6o9YBl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66feeb8ff41so1967185a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1775752465; x=1776357265; darn=vger.kernel.org;
        h=message-id:to:cc:subject:date:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvD6iQG1O/I+/j+ks+GogJBSWRhUCp/c6DPnLqjhUYs=;
        b=aH6o9YBltKABjgEBzu/nAhJP6F+ofom9cYSXrXN4aaDfOUPGiaZrCKPx64PfJ/GcvU
         zUE8AKS3H2E3OetHTZPleDT130VdpSpbGC9gRiC6/QKayxa30X+ePVnaxKI+05kMXeS2
         hj3QQG7FQQCtq/mekkWUN4lFdWqr5IlEQ7tBC4WBNUdO08rzgS816SlSNVJ54iKmhjVj
         /qcLjovbuvRO864kRgMiFxf4tfi+QlhF7IJeTNRXG/7z7tutOH1zXpvq3qbfb8NvuAQu
         iYi7KTChBm8nLQC9Jt1jMn9O2ezdAjgEQzjGrHOe6fKCZwKbovd5KhswuT6GZaeFjeGs
         Hrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752465; x=1776357265;
        h=message-id:to:cc:subject:date:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvD6iQG1O/I+/j+ks+GogJBSWRhUCp/c6DPnLqjhUYs=;
        b=lgdT7cgmhZ4KDsPB1LBMDgYbZgm2PVA8B8M/07WcU62Z0D5kxFljvTE3ixEBpV7xLM
         QDcEa6rFyEs5bChLQCY9ciSVMysPNL3OXkviu9W6pwdfmrL+RPDtiu88tDuiL97L+Inx
         GVBv2Vj3oQiBxuQhK7UaM1b0Nu/Ska1k9kS7foLdq4N7zSlDiLoRE08cyukNA9E5R5M4
         +ThuVZtVorJTU4uwrAtUEjxzu6nFaTQPpCAA1bNDJ/JzHAJe/oIB9nfyhA2UyX6pT2zl
         fW4We9Vqq1jkit9y9yn4ELs2Fg3Li+Jd4oToc905IQT/cs5Pp82F3jt7ZqsOFwZiBtXW
         ssAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1igsf0e3E81kNUKdYEcfGRU7Uarv9Eh3xSEqoui0ui1uFNKHd+ocOc0+XbESY6dKUMMcug44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+aAUbGLF4TFTZ5bXJp2troWTv3feLtRIcoAB+3+JJG4wrgfy
	lNG8zwjr8zjq3c/q2CmfmvmpoYh+OepKtIN4p4Gr3IKZrv+T3qZuBlE6OPymqW8LvpjyBNIW/H7
	RXpxbv0EWNA==
X-Gm-Gg: AeBDietCy5iBpJU50oRIiPx94NKlk3RT09VzObMoRTb6N3wHo2lnsi06YT9vqDuSkI0
	tv2oYMACKvSdwDoDqM31dadHqAxywjjL2kUZNJjYtH/mb3Auh6sygxMFUB2cHm68f1EO8CsTTx7
	Lx4DFXY+gZswh7nX3jtConW/D01eSa2nBHkNL11U629BR/cCFaapEvboyS0NzPcOs+8U3SiqRv7
	Q3jXz74Z8KCe4/WE7YKHJCIoc5ZKSUuqDZgXjr1CnhrEBMwBudG32BUpgTG6oCA/dqTSJmDwnFe
	a9TJi2DdweAFdozo8QaDj9H3NN0fMeLZhBYq2fw/nitoBR9SVCKPVgggxulRd7q3q7LLIzupiI/
	KE9PyxZDQh1IMf8UqdeZVz3xlAuImCE6ErSC53rpsRbUFDfqjoY9/z8ln4ffIo0SUGO1Mii3wB9
	w+wyh+vMlL+qDkqgE7u17XzQeqRgmQ/JKTlcBZCfC4ef07dAx8IHjtjbe5ovihDuLN7Xcvf9Dy9
	VqS
X-Received: by 2002:a05:6402:504a:b0:66e:df52:7ce0 with SMTP id 4fb4d7f45d1cf-66edf527d86mr8235560a12.17.1775752465513;
        Thu, 09 Apr 2026 09:34:25 -0700 (PDT)
Received: from smtpclient.apple (83.10.27.44.ipv4.supernova.orange.pl. [83.10.27.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a787fsm5984074a12.14.2026.04.09.09.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 09:34:24 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Date: Thu, 9 Apr 2026 18:34:12 +0200
Subject: [PATCH v3 net] vsock: fix buffer size clamping order
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[doyensec.com:+];
	TAGGED_FROM(0.00)[bounces-277064-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,doyensec.com:dkim,doyensec.com:email,doyensec.com:mid]
X-Rspamd-Queue-Id: EEEB73CDB29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In vsock_update_buffer_size(), the buffer size was being clamped to the
maximum first, and then to the minimum. If a user sets a minimum buffer
size larger than the maximum, the minimum check overrides the maximum
check, inverting the constraint.

This breaks the intended socket memory boundaries by allowing the
vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.

Fix this by checking the minimum first, and then the maximum. This
ensures the buffer size never exceeds the buffer_max_size.

Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v3:=20
 - Added Fixes and Suggested-by tags.

 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d912ed2f012a..08f4dfb9782c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct =
vsock_sock *vsk,
 				     const struct vsock_transport =
*transport,
 				     u64 val)
 {
-	if (val > vsk->buffer_max_size)
-		val =3D vsk->buffer_max_size;
-
 	if (val < vsk->buffer_min_size)
 		val =3D vsk->buffer_min_size;
=20
+	if (val > vsk->buffer_max_size)
+		val =3D vsk->buffer_max_size;
+
 	if (val !=3D vsk->buffer_size &&
 	    transport && transport->notify_buffer_size)
 		transport->notify_buffer_size(vsk, &val);
--=20
2.53.0


