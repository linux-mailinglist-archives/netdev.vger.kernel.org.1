Return-Path: <netdev+bounces-278536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIXeKSJo3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:15:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217953FC6DA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6944930A5D52
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089393EDAB9;
	Tue, 14 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrxdQ8zd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJJ2T3f2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC213ED5DD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183036; cv=none; b=o3YVaNJ8+Vu+/kprZCH4DBOBr8wBUXg3eM+SsA4o+RCH9iHJMIwx0mxL4tW4lHnvSRXHkMDa1W3aw/SQDrxUNirQmWWTX4JhR3HJ54peIoYCflRFED/1Sf7lq5eKZPH/FB8+qaF/lhJmhBCR+9B7VJC/OAUN+RV/1oXmHZfnFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183036; c=relaxed/simple;
	bh=jtcpbJn9RIdJlr0hVO963zpJX/82bBkk/hi4mZSImLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4Lzh5hqWHzUUoIeRWLbhpwy9ZU41QR6rEjUE1ZJ7wVD91DXDZhbupOPX9JTxte6Nh0+Y3C4W96gIxYXhozYpe9CB0KQd3AOVhFDTzkw1NdFbGoZkdk3kkLG/5X+Lsek/DX57YhkeQldPja/bzoHHO8LPMCVl2/Jywwo6e6fBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrxdQ8zd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJJ2T3f2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
	b=WrxdQ8zdlZQkxM35azZWPSGWn1S2Q98Voe9tLapSHEPemlHPk4Tc66U5kkmYSZnsKUG2vU
	4DSVOItTCpBp9loDVFhaa0OiEnAHrmMF8qmp2E6dm7yp7VDjFaID5Rg0hu3VbZ+40wTRGs
	Wm9EMAIa+mfJYFzdXIr3qGj4Am5Rt2U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-GBjeMP75N6yy4MFjrOTa-w-1; Tue, 14 Apr 2026 12:10:30 -0400
X-MC-Unique: GBjeMP75N6yy4MFjrOTa-w-1
X-Mimecast-MFC-AGG-ID: GBjeMP75N6yy4MFjrOTa-w_1776183030
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so4238766f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183029; x=1776787829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
        b=hJJ2T3f2Zam6T20AAqDBmgX8BWH53DXbJXAdHDKMrpfSERy0VwfHy4aRieMjFiDBOb
         VARpsmbc3fiaExISRehlrqqePwAyo5xDCzX2Eh1Yoof2DgxzYxXv2BkHl5hsbG5cGBO1
         U3lc5FanUERYTTk5yfn7fmK+/xBYvaFx02jZ6A1poTVCtIds+I+lK0Vc3PMCxpBYB8kE
         V/Gppu8z/7+wbLVUPSHeVjU0UgFFH6BoR6jLUFXJjn7fYY39cAuzOp7LpAGWyYVRWAS6
         52i3c30YqC/KYrollK3KsqopkbXtIl8XEvA3GwJ98DKIwOg4ZvcZi1SD2goMSu7ZeAeG
         ScHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183029; x=1776787829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
        b=XV2JYV9IFUBKmjgdWIIs3lOoBDu7LF/t6AduGSurzzGKJiahhOr+dpnjyLug4NGIGO
         ko626BTAZxS7bQYA2gqEGrtFZyR8KZ2z9k7qvnHPp0YY82Js2J8L7jF/CcdpAC8M/Vs3
         m0FX6K8oIolBFpLtpq5OuNVmTYwn1/JFtn3QlkKZFqapXZND2mhijGQhtAOke6VJkPE2
         zrs9xOJhsDR7XS5et9DRiPz1qpX+soNRl2hcD/lNFX4tMEJM1ztu4CJVqb3E6arTRXpb
         CeGxWzIWKmDhDOTi7QfYYIR1t1m5S3HxC6sKNbINoVPZC61ZuvVlSOxx2Vf12Ye7pQul
         aH3A==
X-Forwarded-Encrypted: i=1; AFNElJ+QTSCRA2vmzBBEjXj5m4FA4040jrTavC7bxtmycQ0JkgQEk2irfinrjxru5WwqyHFTisPaHak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJh1AM+d60FM+BF2hJF6qo10VASMYVegc7ksedoKZXOa/ig87L
	xpA5OqdVYMrgfVb8Kt9gLM8UCL6mjgEhQVzt7udFd7XkOxh+DK+69K+NVH0Uf37dPrsvfJaHX8p
	Y6Kzo4BgPrqPknIhthIPY5MnL33yp5hGPRT8OGbzxjOANma05Zge4SC9YDA==
X-Gm-Gg: AeBDietFKeVoKq07dYN4toj2bewlG1wcEyL+gs1CDzx5EP8a6b9v9udC2wc95zXINTX
	ibC6e/Q4qoSGU/PBuhEoU3RjV6Kcv4DFrMt/F4xjDBKhFvgW2PJCSOzQie6FWXppswMOMZE6BjV
	srcV7/e+1g10auMEu7o1HsfhDn1axFlv61Khp9lBv+wzTV8i4g/7aU79p0v52dptX1eiXgwNRjE
	Qj0U8E4f+qC83SSH/fHyIzCKbu478v8LNw1/CQ0ut1VU+LX2TYeNojRObqhQNs37f9BodCjSy6Y
	SNfK/c9tdnE2n9Ii8kbL7pt3R5EBtVGd3gaFCuX2x+Kqz8HFQffuw7tUjKy/I7I6hLHEONBBdQ+
	xXYIKwFMtFc+Tvn19fgat+QF5BAO60JIU8qiYVPGIVmV6X32yOKWu7Af/c5G7
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847322f8f.22.1776183029388;
        Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847250f8f.22.1776183028882;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:23 +0200
Subject: [PATCH net v3 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278536-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 217953FC6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..ab387a13f0ae 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("SRVREADY");
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf_normal, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Recv rest of the data */
+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
+
+	/* Compare full peek and normal read. */
+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
+		fprintf(stderr, "Full peek data mismatch\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_msg_peek_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0


