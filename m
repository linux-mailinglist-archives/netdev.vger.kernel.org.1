Return-Path: <netdev+bounces-297560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1FbE/MuKWpSSAMAu9opvQ
	(envelope-from <netdev+bounces-297560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED5667DCD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CqSPReaq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CB132DA7EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18063A83AC;
	Wed, 10 Jun 2026 09:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38A3A75A8
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:13:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082837; cv=none; b=FmYJkI0pkPHSu36s7GWLJwOHjlkHS53zlTb2N0YQPfFk5LDjSyI4zty9CzUvlFIVJqWoWmUmhLytxGckRYHUpF2kqMGsrAdfdfYGYgxNrAiwYBvnD/GS2OBxa66SE7A5kaSR1QdJmII7qMulnOOmEjagaNwnDCPvuVuYFpIVvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082837; c=relaxed/simple;
	bh=n9Pb7a3axFjzxDMjrZkjjorf1UU1SU9m+G1T7dF5YAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU5EPFgIV4OKv9ytefhxT4pVfWpgz0YIg/xyyzLxlvgvA89Sqbo38kmzPRBoHtUCz9OFCDiAdnt2gVQHeRuJG62P512vFXy0gnVzn9rUOGz2fTNcDF+Y12PWdCep1xdJwQdTYmsgi7bUYG+ILharUJ1iP8HAbI7wO+oV/PC8WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqSPReaq; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so4100627a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082836; x=1781687636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xujE92v9Fhi27fvUp8TSHkV9oiEzGhWhlzdRW6++/1E=;
        b=CqSPReaqTlrfTkU3309mjkoe6t1uFo2AYuf6EU87t6I0yH1r1hoNrRhX8Lc3DnqZYo
         3YWQ6HohlktoBpZkGZNAzkW7SxG1kTP7kqfiDh9IrBcrxqbP7JG8R1NPqCDlHvlAzO1c
         YLWciKAZVUsr0mmpKcIMYjNfpglrtviH2EwY064LY67dUOETaKuWdarF4q8/7EmeHqt9
         Lfjo4VFEnGLhvM9EeZteDNrAWla9sG3i8znSsZgvx3WA4tqWYFSoT5oTeiRBZJJDT0BZ
         cEu+0U4vJz8ckNz5IGD0OM1rPMcYpmIukpw7X8FC8s7GpwvWptIImrA0FONc8yPQC4zU
         eGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082836; x=1781687636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xujE92v9Fhi27fvUp8TSHkV9oiEzGhWhlzdRW6++/1E=;
        b=ajhGt/zA4+hJaSHwdIXk7TBhFSZCiIMz/TmTQm7n7ezy21cGtMZOm66bHidEvH02wH
         Bem4XNmMf/tjH0OTqEKq+ekX10lT2Axh9BDxAD/svWiBPlc10Sd/NnU7JmAS4hDHnn51
         1Rux8v1oaSdOSEStSr3GdDhOkls12gZgD/l2r2ZWe4Ds/iNELdvc2ByqvfRdNCydMFBL
         Kd81pUAbHVCIeH7L53fcGO7Xdy+lEjOiPN8Jy2WEDoVCwnL6VSr7baEGstP/l1/T+5Y0
         QVj1aob9qUmfCGq5sJuc8D+sfIJ5bOH5mB+8ZBNVmVfLlBq/4L1nZyXj4dC6m/lmS4v/
         EYSA==
X-Gm-Message-State: AOJu0Yy6BnWM64C+AnwXAkfhseS3e0p4tgTpNRxiRQVJqVuQSLq1gbKb
	Oog4IeE6m1jn2kSWnWtrnQJZD5I1OUjrNxb6sxJlv4XEIoqKskyFn3zSBOyKJk7c9Q==
X-Gm-Gg: Acq92OEW1G3SwgZELUVfgIiAyJSMYk45VT2+V+P0hsrpjruFRyHzZJmHlseTvTMwXFM
	vGYWctLPZYP0thAshWTpeUpIiKqGYNU1+Yk7b9HiltMsYTEpIXZQPv7hudmHIUvlPQDFgL+gy6p
	Unb7hMIv3HeJI74YUvLprp0IN9dbZqaeSOQnyg8O6drTjp3eeR5igJIq+aNO3r3+jbUft1Qp95v
	aqun97kX0+FmR9kENMswKsrSc5rSuTXgERgsvuzaFaNXlRhw8McPsbaoqH4T9tbnsFJA+8/PET9
	nn28xgCftbqLvv3gPDo8NCzgDqIV6nhvorbDkh8LzedjuGMh0WkwqZtW5edZC7jqexRm05HUvFt
	UUcL/+IxiJd8hNODglm5sWpDdK0Or427rXYEp9MHPdxPgMijLpSKG4nq7oDw4hsZmvbXzu8Td/P
	8SvnnCzqCgmAISlx0Q1bIKN/Z+BvcPzY0USf5gEY8MiSHXdmI69450nieLzmU13NHsmZmxZiPIO
	FE84A==
X-Received: by 2002:a17:902:c401:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2c2cf200450mr7795645ad.29.1781082835600;
        Wed, 10 Jun 2026 02:13:55 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:55 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Wed, 10 Jun 2026 09:11:21 +0000
Message-ID: <20260610091121.213324-3-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610091121.213324-1-rafdog35@gmail.com>
References: <20260610091121.213324-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297560-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CED5667DCD

Callers of vsock_remove_pending() must also call sk_acceptq_removed()
to keep sk_ack_backlog consistent. Move the call into
vsock_remove_pending() itself to make it automatic and prevent future
callers from forgetting it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 3 +--
 net/vmw_vsock/vmci_transport.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 73e6416ee9..b9772a0205 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -493,6 +493,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 	list_del_init(&vpending->pending_links);
 	sock_put(listener);
 	sock_put(pending);
+	sk_acceptq_removed(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
@@ -761,8 +762,6 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-
-		sk_acceptq_removed(listener);
 	} else if (!vsk->rejected) {
 		/* We are not on the pending list and accept() did not reject
 		 * us, so we must have been accepted by our user process.  We
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4ce6660c11..356bebca7c 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,11 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0) {
+		if (err < 0)
 			vsock_remove_pending(sk, pending);
-			sk_acceptq_removed(sk);
-		}
-
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
 
-- 
2.54.0


