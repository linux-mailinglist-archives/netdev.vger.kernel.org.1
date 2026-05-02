Return-Path: <netdev+bounces-283422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xCqjIAsI9mk3RwIAu9opvQ
	(envelope-from <netdev+bounces-283422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:19:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28204B2488
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C83B53009B05
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C72C11D7;
	Sat,  2 May 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2HU+sIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB52820AC
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731591; cv=none; b=JzmMJPMz5YZRFca0AVAK1PtThulernOj471eEqyvvYEKEXrunbyyk6UxGeQAo0rH9b660QkRawRTvpPNg29tOzwYoMiCpf9wG6req1a9cUe4PJMJV1ko7m2LKTsUoq8m/b/1OxwqWaF6IVrIfy7X/MXuJOGGsXjAMKJGJmcuU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731591; c=relaxed/simple;
	bh=k+AkJcSPR6GWTz3BEXN8/5jElc3fjNG4wrYl2Mb984o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HivWzXxi+8/CQPQB6cRX0hQMX2NhmMCUgHx87yy9cXL4OjAVmWVNZ/X4SlrOt7t55Uj31wFwLVxVocjW77M5/BS4ttUFoXytUbSRHBIQTKOOeJSIR/cjJUtDs6MQSwV90f6Tvlkcqh/YEE6JWgOBMsCr4kmJ5SeESRRN1F44lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2HU+sIs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1512761f8f.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731589; x=1778336389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Xccp0tlIqEgZ2YXrZ9jc4pOkvj1KBEkw6Ll1vuHko=;
        b=d2HU+sIsZoZg9npnGPacoaM+MoqmTPfMdI/nO/UijPBT4o9RSvdUn/x4YiLD6aV/Fq
         0Bx7iCgNNJ+wubn5i8Ke/nYn9YuWVJ//EYkzzqvsoUIxJ5bVrxGycTwuraGetBNBQT1+
         Bios4ooy1v0FDnFqUpRtQGckt3E87eKeOAHpF9bo9FzHQpQylhdQTsqNSKABjOZpY17k
         8oY6nL5AuX79v417fPKY+Y/kdS2qP6BGWNfH5cu5hjUZ21UU062GwSWQYB1o9b9Q9n0i
         BJZXYi3BnBWDABtGn+SQfLLiXtHeMXrwDvjWzKoLuBBXD5Bym05PyQBRZXrpgvl0XBPZ
         osWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731589; x=1778336389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Xccp0tlIqEgZ2YXrZ9jc4pOkvj1KBEkw6Ll1vuHko=;
        b=OAduj90gXDnUAiSrJZ6tyn9x496rPVilnydN0cJNRNZWLarOf60qJ8odr2E0uqzIPq
         OtkR2HiHTUyK1ZlG9lR9VzcmUl8YE5XTfVMrxJSwEpoU5hAAQyGTZrHyvhfKxW7Ts6hz
         AYgjMgrwA+ZGlye4a5VsfSh6KSJYN4sEzyt+GwDn4XqGJAdlRmE2tb5/3uyUc2b3iuoZ
         0mFByWNBUf1byjF1AvrQixA0CEFFNHObTZrAKRHu3QNMwPH8Yvec9Wqr/YhtlXS4JNZp
         gvSN8Wp4bgFxm3b+qC2CsNukT910nXtQhg4Mt4s6wqNkv9ObDfvEdxLY25oOZHebp31/
         SKxA==
X-Forwarded-Encrypted: i=1; AFNElJ/mvqXJ/Lc6Kh/3+YaA/v9PVM++gK149Gj0LgGOZi+63OLKVd/4Y642T8kunzsPlbOd0/ivhy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfV1042k1yMq72117OrxP93EzIS5HqlbJXcf2s7fzszSRzYqE
	RKTS7tFq69ieBbkmqgAnlyi+FJkA2mXh0I4PtspS8oyTx6dwf+ZhcTwu
X-Gm-Gg: AeBDieu2zK59vL32EGCBEMj6OrKCey+u3948NyFce/FsNut3FtyR3nI3TKBWK6ihECv
	tLLfgg7TD0nXRbIGdLlu4jp3g0jNjh1G2z4QtbOFshukWKFzea9ktF5woMlBNT1KxGGmI14yHed
	ODRh6NpOoEXxDHodAtk7QuGW2CFSQr91jFfSKcBMxnitknP2v39Ti/DnepldyGJwsFlLfB1sqz0
	zZICp/XgZJ4jZrodH9c3mhjkK1aeSjaDx9IZNT8rxHbJmTKePASg2blTkBc6td0oP/S4I+IIDD9
	DbrI3QJbH8ozbgxAA033bvxi63a3bRi/hTAoJrVhr8HTfpqei3Vn6Yy45Q7VwY99844hC+DfL5A
	oV+VmLwpAN7F/zPfnlDqB0v09m4eddMabM/JoDJHMGm3hGNpPFMPauZcsVbI7fiXA/Wec0696do
	HSHaVZnUQ0vCNnwUnjMmABPI531NZ/At13v//QoF7h9roGHSIsYqPGnKu77cNaBH1YZ3mdDyxrH
	DG5CMzOT8E0f3znJ5U51g==
X-Received: by 2002:a05:6000:61e:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-44bb65df7c8mr5021767f8f.29.1777731588443;
        Sat, 02 May 2026 07:19:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44b638ac434sm8272788f8f.36.2026.05.02.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:19:48 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	raeds@nvidia.com,
	kees@kernel.org,
	cratiu@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] psp: strip variable-length PSP header in psp_dev_rcv()
Date: Sat,  2 May 2026 15:19:45 +0100
Message-ID: <20260502141945.14484-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C28204B2488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
when psph->hdrlen indicates that the PSP header carries optional
fields. A frame whose PSP header advertises a non-zero VC or any
extension would therefore be silently mis-decapsulated: option bytes
would spill into the inner packet head and downstream parsing would
fail on a corrupted skb.

Compute the full PSP header length from psph->hdrlen, pull the
optional bytes into the linear region, and strip the whole header
when decapsulating. Optional fields (VC, ...) are still ignored,
just discarded with the rest of the header instead of leaking.
crypt_offset and the VIRT flag are intentionally not validated here
- callers know their device's PSP implementation and can decide.

Both in-tree callers gate on hardware-validated PSP, so this is a
correctness fix rather than a reachable corruption path under
current configurations.

Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2 -> v3 (per Daniel Zahka):
  - drop Suggested-by trailer
  - rename psp_hdr_len -> psp_hlen, retype to int, fold onto the
    existing int declaration line to keep the reverse christmas tree
  - drop the (u32) cast on psph->hdrlen
  - no functional change; carry forward Reviewed-by tags from v2

 net/psp/psp_main.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..e45549f08eef 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -263,15 +263,16 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
 
 /* Receive handler for PSP packets.
  *
- * Presently it accepts only already-authenticated packets and does not
- * support optional fields, such as virtualization cookies. The caller should
- * ensure that skb->data is pointing to the mac header, and that skb->mac_len
- * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
- * is not supported).
+ * Accepts only already-authenticated packets. The full PSP header is
+ * stripped according to psph->hdrlen; any optional fields it advertises
+ * (virtualization cookies, etc.) are ignored and discarded along with the
+ * rest of the header. The caller should ensure that skb->data is pointing
+ * to the mac header, and that skb->mac_len is set. This function does not
+ * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
  */
 int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 {
-	int l2_hlen = 0, l3_hlen, encap;
+	int l2_hlen = 0, l3_hlen, encap, psp_hlen;
 	struct psp_skb_ext *pse;
 	struct psphdr *psph;
 	struct ethhdr *eth;
@@ -312,18 +313,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
 		return -EINVAL;
 
-	pse = skb_ext_add(skb, SKB_EXT_PSP);
-	if (!pse)
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+
+	/* Strip the full PSP header per psph->hdrlen; VC/options are pulled
+	 * into the linear region only so they can be discarded with the
+	 * rest of the header.
+	 */
+	psp_hlen = (psph->hdrlen + 1) * 8;
+
+	if (unlikely(psp_hlen < sizeof(struct psphdr)))
+		return -EINVAL;
+
+	if (psp_hlen > sizeof(struct psphdr) &&
+	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
+				sizeof(struct udphdr) + psp_hlen))
 		return -EINVAL;
 
 	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
 				 sizeof(struct udphdr));
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
 	pse->spi = psph->spi;
 	pse->dev_id = dev_id;
 	pse->generation = generation;
 	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
 
-	encap = PSP_ENCAP_HLEN;
+	encap = sizeof(struct udphdr) + psp_hlen;
 	encap += strip_icv ? PSP_TRL_SIZE : 0;
 
 	if (proto == htons(ETH_P_IP)) {
@@ -340,8 +359,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
 	}
 
-	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
-	skb_pull(skb, PSP_ENCAP_HLEN);
+	memmove(skb->data + sizeof(struct udphdr) + psp_hlen,
+		skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, sizeof(struct udphdr) + psp_hlen);
 
 	if (strip_icv)
 		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
-- 
2.53.0


