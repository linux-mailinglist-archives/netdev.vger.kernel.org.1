Return-Path: <netdev+bounces-278535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GYcA75n3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69333FC6AC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C35308DBA0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D483ED13B;
	Tue, 14 Apr 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkQYOFrW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gklIhUcD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA13E5EF8
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183033; cv=none; b=PI+XO1KAKlpzkQAlmu4Ntl1Tm7/dIut319GxrKTNKUMMzkHMlMNmAIPiCY8JrIf1Co4fpqfLJKMo16yoxur+z7fz7G9Fw/45C2IP1wR5rt6r9SSHjonUj9npcLFNn3VkG6BtuxZV7C0opY6db3Lvs0rZc6cmSJzx32Jts3NoOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183033; c=relaxed/simple;
	bh=1yv4GGA0ycfjwtZCUCLrwar6tO3xyrHnQ4nzsY0/Lv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UD0dvW+6lmd17RKRl8Q78TSx+8URazjyBySJdPa1e5hHk0nXM4k98Vt8QNCsfea/NDWnYLqiUk6KwNixWAcEuublHPH1i5icXoOikjALgbZC5yRde+z5Rkt100QQCikI5bEkt1WoMqYACUxV0hFXdV7AAvtLpQscwCepHfgZ4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkQYOFrW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gklIhUcD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
	b=HkQYOFrWZQbILVb7lsKtFGd1G59+WMOrJldUsRmucxh3yW+uRWPTRMI+jtdNUqBaAq+WJn
	6jbbSa4c72K/R88TD0s/egxN4sZBTgJbW4xxOORhYFu1NSIkDiKkOUvqhtuGL9gwpBZ7mf
	OSnpedpZM6dAUHb/ma16i34iiWBlqRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-1c06c9EfPfeEJCeAz9OqGA-1; Tue, 14 Apr 2026 12:10:29 -0400
X-MC-Unique: 1c06c9EfPfeEJCeAz9OqGA-1
X-Mimecast-MFC-AGG-ID: 1c06c9EfPfeEJCeAz9OqGA_1776183029
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea8161c3aso599171f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183028; x=1776787828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
        b=gklIhUcD95701TnT0CVyujEbb46wOi7dd8UxHMB4UtOYjpCqQFOlRxUpb9kZfUKGfx
         VZhZaF8aDLt4d6bXlnT3EA6JQMsV1pyV3VoIg90QsbHcDB/3mIKxSVwXx9YipxrvwmRP
         FQfqzIf9mG2k/B+DVkc9NuPfE3uhKKfOi+L5e74b128Kb+y25Te9Hp64KCRM3aTZA4eo
         ZjTpNiMm1qt3Uh3hAvi+em6mzGTznPU/1knmvt15cpYqBRZ6IOsm0cRgmE1vjg9GdMCh
         oQPGMoyUb+FC55EZOCYAs8ALXkzmjhDoKNdK5kKLtAHiMycHv9V0PT1pq+rf07cAXl9M
         oX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183028; x=1776787828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
        b=HldimUrIU3SJva/efPKCiAGdjvhKzIgTlqvDBxUkWreWK8J3HCB/48Fno9ekPML6vQ
         8sINMnZPr9SVGLRV8jUhPhQm/j3ZdoZHDOnEhE3c/DhCD89Kh3wkgSMRcrx06HsPrX5U
         tVnKDh52bBeEizjaAWNcT93lrnNsztP7fkW+tilfWQ/pnD8aEY03U4iVQnyViNwapbz4
         0iR2Q0jybvA3rV/31F4aJ258EmQP7a44h7y7aBhp1fjzAGQv6UrSLoWXVP8Q37TQRr+8
         /Y0mEWKbowxG4TlWmIM9nZbE8WdnF9mZA/IGO0m6HmH4FaHwCpS4j4BPdRWJpk+kqJAx
         twOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nC8bCX7qENAZ2fc5k5cYKxJwP8atUDDW8GkVQ/o6ESMR76eaVf3DxIu74yBP6600U/9dM9F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPixZ/tEPk1sxEhXUbmyYr1zsExiYRyuaxnKcKq3SRDV7sGZNd
	UZSC3dFyn66Glrb3k0QfWY7V44Nj1W8tzDZkzD9lLnV3YbglemeTmCVyZIUJ9WeD6hj+zYWl1I/
	5MbUi3TqDnl1L4Nx/msu37dgVmKHBdtvI25VPPtKLd4wrsN8mWdlMlTdRxw==
X-Gm-Gg: AeBDievq3bkg3p4DV0gxqZxAyTNFp9+7yLz8V2CeNl2QF3OkN5RqHiCpuSUK+VStINe
	8wmW6CONpc6ib2mynn4MbENlpKpXhamJKwMQ+F8BYtz3jYVQFRuHr62zQQr860h0PlecP+jpWjT
	enHH4kgJd7QNLEXJ8p0A86FBlRU/aAcaAtCvl/w2CZY75AxMqZlmrOlp6BRtuQQ40bFFjfj9fNF
	5aLgWAPpDqMLleJvZIFphImDfaQ5VMB+88ZOTNhmeyeDiAM/vU1eGYq0EiaX9YxJq3jOA7CdFv+
	bQcTcleM05lXoo0XI3RPbt2VEJ4wqYxgknflGk4+JUoNo21QyBhWy9OZXYykQsNmI791rB3+POl
	1m+71C4g1YKbbipiVFChMsvJejNbFpbfog5GRuAYasBm9y52wuVXGvT4ygtFV
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748891f8f.23.1776183028067;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748793f8f.23.1776183027431;
        Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:22 +0200
Subject: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-278535-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A69333FC6AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the amount of bytes read: MSG_PEEK
doesn't consume any bytes, will re-read the same bytes from the buffer
head, so, summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
requested amount is more than the bytes available, the loop will never
terminate, because `recv` will never return EOF. For this reason we need
to compare the amount of read bytes with the number of bytes expected.

Add a check, and if the MSG_PEEK flag is present, update the counter of
read bytes differently, and break if we read the expected amount.

This allows us to simplify the `test_stream_credit_update_test`, by
reusing `recv_buf`, like some other tests already do.

This also fixes callers that pass MSG_PEEK to recv_buf().

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       | 15 +++++++++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1fe1338c79cd..2c9ee3210090 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 	}
 }
 
+#define RECV_PEEK_RETRY_USEC 10
+
 /* Receive bytes in a buffer and check the return value.
+ *
+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
+ * reads cannot be summed. Instead, the function retries until recv() returns
+ * exactly expected_ret bytes in a single call.
  *
  * expected_ret:
  *  <0 Negative errno (for testing errors)
@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret <= 0)
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
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


