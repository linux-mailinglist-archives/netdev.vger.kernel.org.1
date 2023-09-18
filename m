Return-Path: <netdev+bounces-34684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572397A52AF
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124FB281A3A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069E27EE2;
	Mon, 18 Sep 2023 19:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AC28687
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:01:29 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C76FE57
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:01:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so52797815e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063667; x=1695668467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAvLANZVcBxI8K7JhIBl+yn9RfzdE+WIR2gbxPUGz7U=;
        b=PY/NwegljIPPgGmpG69G8kQNZeFLZdLpyYq3ld/uJTtKHVMFoaFZSfBFOvmtasUOrn
         H2mcsJQNMeAel7y9spv0/tgLOHnpVT+vppkNMt1SEAQ21gTxDKbK09ouHbXekbJPCWX2
         Wo9eNsDR+tBBcoZhmXKIeEwwYBhwuxS+z+WU14X7NAsgR/s4giP67XyNmmS9AbfPQgxH
         C3CC7wCdu1plnOg3fZ8kj1SwPrygMQ5ma4rY4H4GlGjEK+mpg8MQPOsmEuKiHkCOldOo
         jcWoqNahUFRGgyzTefTyHdU8yNcYG3Wvj4/2OQK8hsdaWBElVuFYQplMjJpikMRB0Ta9
         yIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063667; x=1695668467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAvLANZVcBxI8K7JhIBl+yn9RfzdE+WIR2gbxPUGz7U=;
        b=AKlqDFZCC9lsSYHSfien8DY9Qv3mlOuXcgv0aAupUxH600eAWZaIY0nqtHLXxfQMPj
         M+fEYWK9YKjjVBwXZVW3U0sXcQGYE3xOWwpFwx9oy8tECj6yENC6lN7obxU9MjOF1lNJ
         2P3qGDcuZvkhJerXcnmQg53nUTE9F5l2VDdPi+uM9M7x7FDZU0+8URgL8IJ7orUs59CT
         V6i6rI31ycPFX0ebdPawNEQRzZSbdNZVC88xEkye0aq+RWAKG0746VXWpC+SV88e7Oh9
         z5bD1ultF+X16gHOPkDVUiXMFh0zBrO3mElEASCJDHUZaLdkJFaPktnnO8SOfeSi1Ucm
         dKug==
X-Gm-Message-State: AOJu0Yw2DieSOBDFZ1gKLmbiBLdxYRrsGICIfp7/Sas3w1quYyvapYTJ
	Xd6gEnePA02u9paIEz13R01dow==
X-Google-Smtp-Source: AGHT+IHcFBhooJGfyqYBhjueOxTjWpjPGkOWXYuhypIeelonUjkcwzPshX1nctXSMtLm6cgBkkFzUQ==
X-Received: by 2002:a7b:cd06:0:b0:3fe:22a9:907 with SMTP id f6-20020a7bcd06000000b003fe22a90907mr8388960wmj.20.1695063667313;
        Mon, 18 Sep 2023 12:01:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:01:06 -0700 (PDT)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org
Subject: [PATCH v12 net-next 17/23] net/tcp: Add option for TCP-AO to (not) hash header
Date: Mon, 18 Sep 2023 20:00:15 +0100
Message-ID: <20230918190027.613430-18-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide setsockopt() key flag that makes TCP-AO exclude hashing TCP
header for peers that match the key. This is needed for interraction
with middleboxes that may change TCP options, see RFC5925 (9.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/tcp.h | 5 +++++
 net/ipv4/tcp_ao.c        | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index e4ddca6178ca..7b9762ab4df8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -366,6 +366,11 @@ struct tcp_diag_md5sig {
 #define TCP_AO_MAXKEYLEN	80
 
 #define TCP_AO_KEYF_IFINDEX	(1 << 0)	/* L3 ifindex for VRF */
+#define TCP_AO_KEYF_EXCLUDE_OPT	(1 << 1)	/* "Indicates whether TCP
+						 *  options other than TCP-AO
+						 *  are included in the MAC
+						 *  calculation"
+						 */
 
 struct tcp_ao_add { /* setsockopt(TCP_AO_ADD_KEY) */
 	struct __kernel_sockaddr_storage addr;	/* peer's address for the key */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index a8af93972ee5..ecbf2e217f29 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -562,7 +562,8 @@ int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
 		WARN_ON_ONCE(1);
 		goto clear_hash;
 	}
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
@@ -610,7 +611,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		goto clear_hash;
 	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
 		goto clear_hash;
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
@@ -1403,7 +1405,7 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 
 static struct tcp_ao_key *tcp_ao_key_alloc(struct sock *sk,
 					   struct tcp_ao_add *cmd)
-- 
2.41.0


