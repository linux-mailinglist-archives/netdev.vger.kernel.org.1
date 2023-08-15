Return-Path: <netdev+bounces-27789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627F877D349
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937541C20C03
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D801BEE6;
	Tue, 15 Aug 2023 19:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3121ADC4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:15:36 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5079D1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:15:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso57440575e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1692126933; x=1692731733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PptJC8HnsVehgFMOHfEd3dK6jYdc+oOKBr6EQXBoEWk=;
        b=YNU3Z6jg9cpRSUJZ/KEq/qT//ehinXdRWIykMO9tlmkI1QaGzYd6S/k+kzhCjwITYo
         qRCDXkphqvXGEaYvJZiIbpjnRra9cWlcIjczkb5fZ7voN6+qziVINHF97cFoDi6Y9CCy
         z00aOkCFYldqjuwiddHPs6ekFeSkWGW1N+DK29OT1Q4mZGGhPlUYWkgbTH6gtajMJTMZ
         NOdruAF96LOr8NeG+C8Z8ULGDrNxaY4+B97jo2luWjdNE2mt/6LM+ceXCMXtAuudMstE
         ZjJb4JLsB3xgeWtkQOti+TmdoUXPrK0prh9JcXPskfMk3s9b/TyDLvFIPxi7qaOoe0wA
         L4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692126933; x=1692731733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PptJC8HnsVehgFMOHfEd3dK6jYdc+oOKBr6EQXBoEWk=;
        b=ZK63xDiut4pEi+klFEvExkL7KENcZ/S7fguAtZl4lOI0izXtBofNTWPYFTwh7Rzc/F
         ShIPxkWHfHD3gngJNeOJdhDDEorCMnlulQH2LTRXWZz1tuCshNpCU01zL6focoJ92QST
         oUtw1AiNIIaPZ46q/jEU7EL6RKSpevuy4m61UByGAdvz5WFLORdPH6wawcLCjWLctBMI
         iLc0t04qA6b7GU2T3J75/SzWxYmFiWltGpd9YFBoTkd23AX83xgMAnRIGrtjZovz+aKU
         WHENK3MLZRwd8RLZMkgJL4qhOkzqLsDDcY5a26kyNv/kuFwtr9xPUaQ15MXj/wVyD+Er
         LHPQ==
X-Gm-Message-State: AOJu0YysYCdlb0yZupe4QMyieerHdi2S+VyDptohWSKhCaBCKr0IkVnA
	hhZ1/ss5JFJgdel8YTjqf5GT4Q==
X-Google-Smtp-Source: AGHT+IEemXbg8bowQ1LZyBMyLl2MIxu41KDDUMqDu9beYVftDqv1WcdGX3VbMNMTWf8vBmAIAepE2w==
X-Received: by 2002:a05:600c:290a:b0:3fe:1deb:86 with SMTP id i10-20020a05600c290a00b003fe1deb0086mr11469001wmd.28.1692126933458;
        Tue, 15 Aug 2023 12:15:33 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm18779737wmc.10.2023.08.15.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:15:33 -0700 (PDT)
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
Subject: [PATCH v10 net-next 17/23] net/tcp: Add option for TCP-AO to (not) hash header
Date: Tue, 15 Aug 2023 20:14:46 +0100
Message-ID: <20230815191455.1872316-18-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815191455.1872316-1-dima@arista.com>
References: <20230815191455.1872316-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
index ca7ed18ce67b..3275ade3293a 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -354,6 +354,11 @@ struct tcp_diag_md5sig {
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
index 3c8bdd830d96..ecd9b1e0f646 100644
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
@@ -1404,7 +1406,7 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 
 static struct tcp_ao_key *tcp_ao_key_alloc(struct sock *sk,
 					   struct tcp_ao_add *cmd)
-- 
2.41.0


