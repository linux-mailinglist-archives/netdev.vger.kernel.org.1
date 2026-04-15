Return-Path: <netdev+bounces-278819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLvhLGSq32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE7405B70
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 135AA302AF3B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B53DA7D6;
	Wed, 15 Apr 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVNMVtsd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJUuVLMS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B783D9048
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265788; cv=none; b=HqfgBcmEXsfrS+HE2xRYRqIzvp0DPwvEeQaACLo4ixuMCx4kQhDHKAPIHRP+T0nr9ovUVdLQbhLA9ua/9co3DS4fwlQU0NwsLL6hosFxb39RTIKLjiG2BkDo9Tv+wOU0iEYoi/9oeE/FLitf4Vcq535mJ6hBnVG1HI4hnBjpHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265788; c=relaxed/simple;
	bh=/iCPhgiq7mE33glA4s7a0f83jNJCKI2MOCQ/JRlKmDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lk0iWiIl8n4V2dLOdRUOXcG002HjIiMoFnzmOEWSbTcLwcrKilAb8NxU2GjVgp0DQm/YAiUiLtG7fiemIs4ErSzTauruUP9IG9Bv24OlaD5wbUN1SF38Af/fga0Fblj3IdeWOY+VbGNxFV2q8uPrjVe566loMLhjxc7jYhicKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVNMVtsd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJUuVLMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA7f9IhhC8d9N5AuSbx4NBgDg1Ch+I8A/gLFTYNnbg8=;
	b=aVNMVtsdJkVtdBymnUCADBGIJCYp0p+Rw5bvrnwZWLdF5/ozoGynwR0ycC4XXzEL8lNDaX
	2Haa8KeoX0U5hZFjuDQeEuoIFU+LmF4HSX53WoDLAqWZfXP5MyJqdCZZ/lWSg9A+YJf3Ss
	bG4pZvOICfk0ALOuMVhIe5jB3awUaiM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-1xQmcWBoMamGDuKiMRs8eA-1; Wed, 15 Apr 2026 11:09:45 -0400
X-MC-Unique: 1xQmcWBoMamGDuKiMRs8eA-1
X-Mimecast-MFC-AGG-ID: 1xQmcWBoMamGDuKiMRs8eA_1776265784
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso30809935e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265783; x=1776870583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA7f9IhhC8d9N5AuSbx4NBgDg1Ch+I8A/gLFTYNnbg8=;
        b=YJUuVLMSO5A/q/PIDYvowfJC25Z6ilDU/3Pposk4drOAKbIGD9mMybwBSqmXg6fEq6
         gEgaBAlVTJRbrmtEnZ4F1jWZWbi/2LwY215fDZtCr69u5fQclQNKwor/OCztn6Ldsz5I
         zNgJi6Eh89Pw/KkDoCQZO1NsEch1avLqrqmIJ/zfc3dhGtY54GZC+uQ9N6tXsXJCe4o7
         SenYJdFwwLZLlpOyhgzct59DhPT6eWh8VkIJsYIxfSa7tWK3ZgkE/v7deUL0VdTNvnxc
         /nNh5JmJaEXFSPlseajrYljqM9ij4hr/BbTY9kpwEiQedNyQ/M4q4RvgkcOLPVKZooQe
         YVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265783; x=1776870583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FA7f9IhhC8d9N5AuSbx4NBgDg1Ch+I8A/gLFTYNnbg8=;
        b=ZMjKFwPZjulXUivkutHclbDVIAt8LNvbrzJh2QTg5P2zC2GkNCQfd+3EfKuyZ0zTZi
         RpahNRHO3mPWQ4TpPSvoqpRtgsj/p8GWk0SI2phkan6D1lrPJBBjjM0UMLZW5cZG8c51
         RTZWK+Qa0lfLZ/A4vt/XuZudJP/yQ/y9syrPIaTIpXuY47psz50PqAZRwaMqGLebVPfN
         qMhRc4SpvzCYCyZFTkOMr9Omn+G3uxRyGEIZ/KCpjRi6bxfzk1MFxuzPBfDJSGr9/ub9
         RRaXCACyTO8aT3Q22F+pc4fQSxXprv15cwS3PAJSg2ZwBsuEzSvLSNvkMr195WHpmtkx
         Z1Ww==
X-Forwarded-Encrypted: i=1; AFNElJ+d/8xRjSnL+N0375EjQKy7qxMlUcEyqH5aLpBkjP6uD439+ecUTB3YDngEBjwuEZDsY3imXlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSn+jupT4P2XhaXjisghyyO7t699Qr5soz0M0BXSQuvI1ZMZX
	1GHiuZy4gndVDEeB0S8XJaf0XkVVKDoATAMP7nkvK09JBh0H9o0NyRX/PEdiT/dayvFsYA2GDLt
	VmA/UKEpnx6h6YuIkiPZ87J6pASCEVWFW25q2dGCmT/DA8tFszYO70+IW6u3ptlJY4A==
X-Gm-Gg: AeBDieu5p94i5M0SZdM7yZQeizMfsHJTGKsAyUJuNEh4D2/q2RAKbWXSm66jo71kKeS
	Hjeh/EQAQDfUpwksiA9qibUfVLFI6iOh8aWHXJRC/JodBhXbSlENL/DXlNBClAnnUpQdgF2q4q+
	V8iHTiFQSOARaiuhrhXVklNru50R7nxJj13bBMD1kAzgFmBnosbPTXRGHUz9Apa+JsJg0hUVwKn
	7e0JAj9eNWBDqeme1qHbfN9rECmrUMLo7Wqh1GpxIPFvs/cJyzU2wOqJ6/rk/46sEqMeVAFmwB0
	Z9WhtmT5gIUuLx9va+FDo+ube+AxKrTxh6S8cYBLQGmLdYzxl29JrTzPudxVaCMJj0+QFCqsux6
	INfGfntfnqrVJjYU+6F4FUa9VGJz4fEdsp9xieuC0H2XBrp/kRfjE8CixxM/l
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr230392025e9.11.1776265783241;
        Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr230391525e9.11.1776265782768;
        Wed, 15 Apr 2026 08:09:42 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:42 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:29 +0200
Subject: [PATCH net v4 2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278819-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FEE7405B70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the number of bytes read: MSG_PEEK
doesn't consume any bytes and will re-read the same bytes from the buffer
head, so summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if more
bytes are requested than are available, the loop will never terminate,
because `recv` will never return EOF. For this reason, we need to compare
the number of bytes read with the number of bytes expected.

Add a check: if the MSG_PEEK flag is present, update the byte counter and
break out of the loop only after at least the expected number of bytes
have been received; otherwise, retry after a short delay to avoid
consuming too many CPU cycles.

This allows us to simplify the `test_stream_credit_update_test` by
reusing `recv_buf`, like some other tests already do.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       | 15 +++++++++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1fe1338c79cd..fe316b02a590 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 	}
 }
 
+#define RECV_PEEK_RETRY_USEC (10 * 1000)
+
 /* Receive bytes in a buffer and check the return value.
+ *
+ * When MSG_PEEK is set, recv() is retried until it returns at least
+ * expected_ret bytes. The function returns on error, EOF, or timeout
+ * as usual.
  *
  * expected_ret:
  *  <0 Negative errno (for testing errors)
@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret <= 0)
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret >= expected_ret) {
+				nread = ret;
+				break;
+			}
+			timeout_usleep(RECV_PEEK_RETRY_USEC);
+			continue;
+		}
+
 		nread += ret;
 	} while (nread < len);
 	timeout_end();
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335..bdb0754965df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	}
 
 	/* Wait until there will be 128KB of data in rx queue. */
-	while (1) {
-		ssize_t res;
-
-		res = recv(fd, buf, buf_size, MSG_PEEK);
-		if (res == buf_size)
-			break;
-
-		if (res <= 0) {
-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
-			exit(EXIT_FAILURE);
-		}
-	}
+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
 
 	/* There is 128KB of data in the socket's rx queue, dequeue first
 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.

-- 
2.53.0


