Return-Path: <netdev+bounces-265379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFjBACdhrmlbCwIAu9opvQ
	(envelope-from <netdev+bounces-265379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:56:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935723409A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7322A304D266
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAB34D397;
	Mon,  9 Mar 2026 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npuQ0r9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075634CFD3
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035694; cv=none; b=A24Oaoe7Rva4QUKqEccPvJRlzXcUIOm+M0wakncvV7rOTivHztL5+U5L1vfLbdevJG+i/3xLC3KtgNyreISCNfaqmJpOXuPkyNE8OkGomZM7B3vRObw7lrtN3otXWN11TnNjpUAMjqrVnIhuJx/5T+HOqH2iD1hIU6oDVscrcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035694; c=relaxed/simple;
	bh=XCl+gIHDKVKF3BHAFazsPTr3zJzg68KTuSoHcRwyrs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGX++W5DnZs7qvomxV4CZm3fr+lBezYKKsKEqkw1uOIJZ5vobspUS/ePJFyF2tQjbf6shMZ/eWgxFPadmGcfq/Nk32qrXfwpph/Has/Xz2zDGPGtmxRD9nMkrB6/fxFHPUUNw7DpYmLrlpKBL35EZGuqk4WAv3Gh6LRehSjmBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npuQ0r9Z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7388fb61adso1456226a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 22:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035692; x=1773640492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32NNtnzDRxNT0zlaCXiiZQWhn0QJ3pzIuoI+2GweKqc=;
        b=npuQ0r9Z0ZQPOcBIPtFip/X+1du3ag+nP2jFJjm5c66ui8rviukW/tQ7rSgYDVRK4x
         BO/iSQbKDICI8WgjqBQLvCaukjC0IehGoMCnt1dPVsuzh5vTHXAEAePa9N1Vx9HJLC54
         cBogATwH5/mwLWKFk7XxFFZa9gzj9iN+ZR8OttfaseIkDnSLvCBN1L1jQginitnTRdYW
         hQilOGIMTEDrqd7R9oEOdOrzzN03f4jRjXJtpU9sWvKKKCdaqgZQonbwglg9XiIv/0bA
         7HAJXpJLAOCI4cQOBez9lnRhyjl5D2qsiKRBDEpiXZ8Po+yoiA5WOy43xHy/lVdT4pww
         aO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035692; x=1773640492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32NNtnzDRxNT0zlaCXiiZQWhn0QJ3pzIuoI+2GweKqc=;
        b=sEkKOzCrDmArYiUplEPtCf406ttEFkJ0J9vAC8YGI4LPE6hYyAJPD2FmwVLi2OMTbw
         MxJEcCj+nIOBaWxEB8Z+likpciaap/HOSwoARa0m4DeA0+6aAxv1mYnH+l+hCajR03P+
         AtV6em+67KAvLZdIv6CdO7+bCSiAjMDCJlv/9GZCkZ7i9EnMlSWxAPUH3aO68zaK/mlB
         XMrxbEI/Mr4KuWZ2h+TJfi8O4k9qoQgBwXlHIRKc+UwKZdYFvLxPJQ/SnG9+ZX1NpH3a
         XPwsbBgRSFYK9Ruvu6dCVBVejXfMxP+/ur6/8I8CFpP8yFnbVPxoK5iruI0XWmPb0wdA
         YKxw==
X-Gm-Message-State: AOJu0YysJsPx7apo4Gytw2+NGQ+ifjWobykDIb18QPXg4fbcbHO3F2W+
	O0zYGDjSf31ZprZutKhgDEp6nBm5O1zcffbmG5LroFfEQd8YnALv6uPn
X-Gm-Gg: ATEYQzzH2Tcxvj/tVSQ+BwSPyNGrS1foSqpGvMYHOm3Q7jXOc6Hjf4CK0eJgk8UicjN
	Zz0x4ZlAfGjOefSTlDJioazoHNGTLX7kvVAPGgUm87M7DVlKTJ74Xq9JZV7oxL5f1CbpvadfCZ7
	TGoY8DvA2t/4Btd6MwvSzi6SwEsJVGQooEyNoBK5fnkjcrtzN0p4Gm0nTwb8yzlgCbaJrzwlixG
	TL8Svqb8N1DEpQhO+Itzsly+u33DOa7nsQTkFY4tubRSsRW//cea7c1ww+UR0I45P1tsYms5FWx
	kLAo4fWjhPxRtpoyL77L7oj8xi6FnAHWzNjLVCBPCVOOlDbQ6QbsQZ2UjGFGEvEeWiR5xdcz4SI
	HpvVoQPNX5GATBQvs9+/XDYOToMANjAUdx3J4kcbr1scCuIVZfWV1hBNmMyflJXHY09iCpoxyX5
	6lu0kwC/76uJL9zSWaEXUSNXJw2mFtPEYez//0adSLid0xA5w9pIz2IE9QPPJV
X-Received: by 2002:a05:6a20:1449:b0:35b:b508:b99f with SMTP id adf61e73a8af0-39858fb2c45mr8981210637.1.1773035692584;
        Sun, 08 Mar 2026 22:54:52 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170923sm7933716a12.17.2026.03.08.22.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:54:52 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC net-next 3/3] selftest: tls: add tls record zero pad test
Date: Mon,  9 Mar 2026 15:48:38 +1000
Message-ID: <20260309054837.2299732-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5935723409A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:email]
X-Rspamd-Action: no action

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Enable record zero padding using the TLS_TX_RANDOM_PAD socket option for
a TLS1.3 connection. This only tests the setsockopt()/getsockopt()
invocations as padding is processed in the kernel.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 tools/testing/selftests/net/tls.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..a72ba8607ead 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2997,6 +2997,51 @@ TEST(tls_12_tx_max_payload_len_open_rec)
 	close(fd);
 }
 
+TEST(tls_13_tx_record_zero_padding)
+{
+	struct tls_crypto_info_keys tls13;
+	char const *tx = "how much wood could a woodchuck chuck";
+	int tx_len = strlen(tx) + 1;
+	__u8 rx[4096];
+	__u16 opt, zpad = 2048;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+	int ret, tx_fd, rx_fd;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls13, 1);
+
+	ulp_sock_pair(_metadata, &rx_fd, &tx_fd, &notls);
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Setup Keys */
+	ret = setsockopt(tx_fd, SOL_TLS, TLS_TX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(rx_fd, SOL_TLS, TLS_RX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(tx_fd, SOL_TLS, TLS_TX_RANDOM_PAD, &zpad,
+			 sizeof(zpad));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(tx_fd, SOL_TLS, TLS_TX_RANDOM_PAD, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(zpad, opt);
+	EXPECT_EQ(optlen, sizeof(zpad));
+
+	ASSERT_EQ(send(tx_fd, tx, tx_len, MSG_EOR), tx_len);
+	close(tx_fd);
+
+	ret = recv(rx_fd, rx, sizeof(rx), 0);
+	ASSERT_GE(ret, 0);
+	ASSERT_LE(tx_len, ret);
+	EXPECT_EQ(memcmp(rx, tx, tx_len), 0);
+
+	close(rx_fd);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.53.0


