Return-Path: <netdev+bounces-252089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBLtGGxPcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B845E93C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29412649C34
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954F43E4AF;
	Wed, 21 Jan 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y99EiGsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0823D1CA5
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033527; cv=none; b=dhWrpgJfw3OGFFXgEOLPKWPwVigCo7lCrfifaido7hfOTLzel2ewebC1aDM+vAcav1XnIHZj/itWdwAFcUX9yVLS2E6MRt84AGEn+UH+V6LU9KB79x40P4pDxypOUIaXra6hMH1HIAT5oiI6p7IN7kh9+kNjtc0rrbccq4Vmt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033527; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzbraqgCQer1UUj6AscPUoVyTv+fxHnYHlv4EQmZpk9hU/gX8OsZsHlnUnqlk+nVeGIeHWjKHlEqTM4UX9vCtDalp6lzajruMw6+4wciwDKctGzq1YYxgvBQxmbHbDCdbyh1glrNeaCFVgW4GshAUGfllp2oWW1QB+B5Mo4I6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y99EiGsF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-790b7b3e594so3514787b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033521; x=1769638321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=Y99EiGsF9tk6R+Itkzxd0coovOKy9u52A1TXP4htixp2HgvCl6iJKdLzALNJZbVNzj
         aJZcvkUY/XMAR+yvEorllUkeZVJ7k7WC6zO1pZIcx8Ql8QQB95xchErZ6Ky0QukvGaAn
         ZStdmxheSgLVJkjkLAxtRJFmIGaW7mqAe9npBxjYaYz7YYCGdaWdz4TfWJEPTEuDt4UH
         zYBc5LesM3ZKR4CSql4qIdUQkNDkGMYmFXAom1jQ7ovREkwAMjGx4hSmomH2LVdtKYdD
         F4WQ0B9Ix79eBtf5yFI6ozINVYcYe1yQk6QNiFgjkMm/M1/ynQOIsw44A/3Sr/regoPl
         No/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033521; x=1769638321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=LHFzHORZo609ZUF7GxT+N3MFDe3qCk/8hao0IfKfZtjdl7Ac1aDQldIDBu8459Qet6
         WFDaJn8kPzp1Uy9aRV4xZ99cPpcofo3N/iHKfZc4PF2mBWJQ6GmVEq6XqkJu14JlwGzU
         U3DhsRQD3CqGEjFjCl4oAO0Vp+5YOY40m4aSa66ToqB3W0m7rBS9vANTKFQ3BoYxF9Y0
         9rXxzKrJY7hUDvO2mXq0x8ftxLdBTS95DNeXg1361qEcNVUC8dizMHfWN469IvRPa1ZB
         fRczFjM9Ct2IR4gvTLlDkhHipFYm81qxjLq6NTdfYtvHGZLr6PayQVcy/3kp2oi5VXBA
         aUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVoiOSHPtToe1QJpUBbP8QbD0O30/FKwvi39EXT2tvMaFsDh3DpswIe2FbrwcL2OKmLjVNtdPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzaMW5uMNzAHh1p5s5yGK2z6UdeRgAuzhpiGIWTo6CIVYyOEu
	SOAgwZRaZ+TgkqgmzeXGyrUWN3XFjfoMHGXGvCfuOTAJZouW+9GHDKDI
X-Gm-Gg: AZuq6aJqL05JxrZKGVhn8DWvun8o3qSo4DMozANQUtRMk/FvK22l4TZLayFEcs/A9+T
	bMgQqaW+KCEKOJk2xISWSLiBXnUfZ3hUCwYyUWJCzDDZjltaW3PTr7P2gGzIUWfRjmXEJZdu8/Y
	+ujyH1hBTBLAWGuWWOQ3uHKtT22kQ4OekeB01LVj44VGOxrb5UjGWdavbb3UiEnL2tqCUBCOUiy
	xb+8rIgWnxfkpAj+Tbyfgh6li0jG4bkIhqqRRKcs12SNy3d4xLVG8IfVTIesFvc0hdgn6PYw2l+
	Y2uG7QrPpBRpM88Mwir2z9pAanZTwRrnOVRj8m0J76jANvzvPQXq7jTAKasdEf+aBCvaMG/NYhx
	cA5Kh4/f++c1hm39XlRhFRoZ9aCAmTgnfbUkhswdU0NGXyUqm+rvKWmmwy0tQXNTbqtgvIPD1TU
	zfL+si4RKd
X-Received: by 2002:a05:690c:4990:b0:794:2ef:a445 with SMTP id 00721157ae682-79402efa762mr75302437b3.15.1769033520799;
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794295ec411sm5665437b3.15.2026.01.21.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:42 -0800
Subject: [PATCH net-next v16 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-2-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[142.0.200.124:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B845E93C
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fdb8f5b3fa60..718be9f33274 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


