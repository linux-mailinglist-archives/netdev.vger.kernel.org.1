Return-Path: <netdev+bounces-275834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIwyD59o1GnptgcAu9opvQ
	(envelope-from <netdev+bounces-275834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:14:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C23A8F0A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF57130DE5E1
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DB27CCF0;
	Tue,  7 Apr 2026 02:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5022F77B;
	Tue,  7 Apr 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527838; cv=none; b=jlQK8GrYIBBCshgPrgznOcNr6WrFd9DzHyBB9aQAdph2I6BpGY71ARnM5d6jVqhtCwa7OCB45wONb8jBrZlTgA74k2qSpSFChz9Em22ofygQKDsOpca2z9bbDqhr5L7UyTDGIdldh+MFkeg1er/WaLjJs8Zcd8//318Ege4XCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527838; c=relaxed/simple;
	bh=2gk/j8ec/luBQmUu0MPxwUnwBOnlSZLezzRCV4elKDM=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=l+n/BCzrvCGGNrTRxCCQhTK48l9Z1HgB8tGhd1kNEJ0hhJ5JuTL+bO4PF9kJNFrTldo/n9wAiTC3OVBFBNFAAp4u7zviNPzv9pbClOOGusaMuLZ+/M1yNX/HglApqr2MmXawuzBH1rnZorZnCJgjisa3ffVCSi1+dgaK1SqOwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0004-nfc-sensf-v2.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADHM2+SZ9RpzrR2DA--.49618S2;
	Tue, 07 Apr 2026 10:10:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 09:57:36 +0800
Message-ID: <20260407120004.4-nfc-sensf-v2-pengpeng@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
References: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
Subject: [PATCH net v2] NFC: digital: bound SENSF response copy into
 nfc_target
X-CM-TRANSID:qwCowADHM2+SZ9RpzrR2DA--.49618S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kJFy3WFW5uryrXryrJFb_yoW8ZF18pF
	yfC3W5A3y3XFW7tFWkAF40krsYvF1vkFZrurWxA34IywsxJFW7JF48Gr1aqF1UJFWxGw1x
	WF4DAFyUGa1UXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-275834-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 922C23A8F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_in_recv_sensf_res() copies the received SENSF response into
struct nfc_target without bounding the copy to target.sensf_res. A full
on-wire digital_sensf_res is 19 bytes long, while nfc_target stores 18
bytes, so oversized or full-length frames can overwrite adjacent stack
fields before digital_target_found() sees the target.

Reject payloads larger than struct digital_sensf_res and clamp the copy
into target.sensf_res so valid 19-byte responses keep working while the
fixed destination buffer stays bounded.

Fixes: 8c0695e4998dd268ff2a05951961247b7e015651 ("NFC Digital: Add NFC-F technology support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- target the net tree and use the NFC: digital: prefix
- add the missing Fixes tag
- preserve valid 19-byte SENSF responses by clamping the copy into
  struct nfc_target
- reject only payloads larger than struct digital_sensf_res

net/nfc/digital_technology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..abf544d917f3 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -767,13 +767,18 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 	}
 
 	skb_pull(resp, 1);
+	if (resp->len > sizeof(struct digital_sensf_res)) {
+		rc = -EIO;
+		goto exit;
+	}
 
 	memset(&target, 0, sizeof(struct nfc_target));
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
-	memcpy(target.sensf_res, sensf_res, resp->len);
-	target.sensf_res_len = resp->len;
+	target.sensf_res_len = min_t(unsigned int, resp->len,
+				     sizeof(target.sensf_res));
+	memcpy(target.sensf_res, sensf_res, target.sensf_res_len);
 
 	memcpy(target.nfcid2, sensf_res->nfcid2, NFC_NFCID2_MAXSIZE);
 	target.nfcid2_len = NFC_NFCID2_MAXSIZE;
-- 
2.50.1 (Apple Git-155)


