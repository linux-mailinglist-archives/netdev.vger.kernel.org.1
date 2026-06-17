Return-Path: <netdev+bounces-300016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AtyiE7UjMmrzvQUAu9opvQ
	(envelope-from <netdev+bounces-300016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86E6966BD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:33:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=S3UZCDM5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300016-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F9123015625
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7931A807;
	Wed, 17 Jun 2026 04:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E8319871;
	Wed, 17 Jun 2026 04:33:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670815; cv=none; b=qI9lC2LUyKEs6IeQWV4VYbgvaIKsSqDc43OgKVPovEC12/AI7tcDrL/lRwgfkwwrzVaygFoP/Nfgf6sqDD+ehTJ/Y0dk7UJ5SB/YQAs7DtgJ9kgnly9orLwxgRpQEoVuG/+xlDx2FY2wRf2hR8+9IDxaUEhTUo8xGmuqIKuASv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670815; c=relaxed/simple;
	bh=Dnv0aO0qqcorbhccnmNV73vhn5FIP9XHAwEcOs6jwvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SSxmFdOnigKTDtXmN0JKNSDJQym2FYuOsK6rUfGEfGe5nRd3qq7izAotqNORmCgOhf2HYULn+A6esYc23ykrb45kmjwujE78BvvwhVblPBwfk6Drja71t6desu+2ZyK3q1joSJ3BXWWIYbdYAkbjHvNrTXeJIBTrggjvyzORcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3UZCDM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3234CC2BCB4;
	Wed, 17 Jun 2026 04:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781670815;
	bh=Dnv0aO0qqcorbhccnmNV73vhn5FIP9XHAwEcOs6jwvg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=S3UZCDM5N6FQ/+WFkF/UiKW5Jj2uQivNcXwXI87ws7y02pX3i4j1hcl/4YuiW7Czl
	 7vChzuIeBd4Pl9MJPvgORpXbYgjxDnHtdWKc7W61nMLPE5a+6eDFXmO2MJ4g4QAcru
	 2+Wk11yq7eyegZEGteyiWeax7B0Lc13q0CCpxrAuHhvm0z3mIrkqc0u35YMxGBLDDA
	 gA/nJdT84paaiYcUz9uaH5TbOrHSB1PRcBUN0m9+7nW/QtMFA3xNSO2e/AfAXgBfOs
	 WZ/e+9hJRl8aegtHzV3sJn1tFFkZlF/BDKr5W0OG6JollOOX4dBAgSYw8jvtg0RKbs
	 AFdmtZuYEX51w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24158CD98EE;
	Wed, 17 Jun 2026 04:33:35 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 16 Jun 2026 23:33:35 -0500
Subject: [PATCH v2] nfc: fdp: bound the device-reported read length and fix
 an skb leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-disp-b1f8ab4c-v2-1-2d1fe5955325@proton.me>
X-B4-Tracking: v=1; b=H4sIAJ4jMmoC/x3MQQqAIBBA0avErBtQM6muEi0cnWo2FgoRRHdPW
 r7F/w8UzsIFpuaBzJcUOVKFaRsIu08bo8RqMMo45bRDshilnEh6HTzZgKScj7YLI3EPNTszr3L
 /y3l53w8naI0vYgAAAA==
To: David Heidelberg <david@ixit.cz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Samuel Ortiz <sameo@linux.intel.com>, Robert Dolca <robert.dolca@intel.com>, 
 oe-linux-nfc@lists.linux.dev, Simon Horman <horms@kernel.org>, 
 Kang Chen <void0red@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781670814; l=4528;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=MJuqCnhzytqlSp6Nzkc5/KxX8KYvdaafo6GYDnOie4I=;
 b=Oe/hrs7OrsMVxdRMKHDOLnQHeX/SimIa5jMdsjZi28UPFGe35RBn4uRK4q6KWGlh++RfuRAaN
 5cRDormZrrKAu8jxRtIHS6LRURzAh3qJuYdjTpolzrt4NBn76Qm+E/+
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300016-lists,netdev=lfdr.de,hexlabsecurity.proton.me];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sameo@linux.intel.com,m:robert.dolca@intel.com,m:oe-linux-nfc@lists.linux.dev,m:horms@kernel.org,m:void0red@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,intel.com,lists.linux.dev,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:replyto,proton.me:email,proton.me:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A86E6966BD

From: Bryam Vargas <hexlabsecurity@proton.me>

fdp_nci_i2c_read() takes the next packet length from two device-supplied
bytes and never validates it. The value is a u16 used as the
i2c_master_recv() count into a 261-byte on-stack buffer: a malicious,
counterfeit or malfunctioning controller (or an i2c bus interposer) can
drive it far past the buffer for a stack out-of-bounds write that
clobbers the canary and return address, or below the minimum frame size
(directly, or by truncating the computed sum) so the header/LRC strip
and the next length read run past a short receive. Reject a length
outside [FDP_NCI_I2C_MIN_PAYLOAD, FDP_NCI_I2C_MAX_PAYLOAD], as a
corrupted packet already is, and force resynchronization.

The same loop allocates one data skb per iteration and assumes a length
packet followed by a data packet; a device that sends two data packets
in one call leaks the first skb when the second allocation overwrites
it. Free a previously allocated skb before allocating the next.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Cc: stable@vger.kernel.org
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2:
 - Also reject next_read_size < FDP_NCI_I2C_MIN_PAYLOAD, not just
   > FDP_NCI_I2C_MAX_PAYLOAD (Simon Horman). The small value is reachable
   both directly (tmp[2] == 0 && tmp[3] < 2) and through the u16
   truncation of the computed sum (e.g. 0xff,0xff -> 65538 -> 2); a single
   range check on the stored value covers both, and also keeps the next
   length-field read from running on stale buffer bytes.
 - Fold in a fix for an skb leak in the same function (two data packets
   in one call overwrite and leak the first skb).
 v1: https://lore.kernel.org/all/20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me

Reproduced in-kernel on x86-64 (Linux 7.1.0-rc5, CONFIG_KASAN_STACK=y)
with a faithful port of the read loop, and at full device magnitude with
a userspace AddressSanitizer model:

  Stack OOB write
    A  no bound, next_read_size 281 -> 20 B past tmp[261]:
         BUG: KASAN: stack-out-of-bounds in i2c_master_recv...
         Write of size 281 ... This frame has 1 object: [48, 309) 'tmp'
    B  bounded to <= FDP_NCI_I2C_MAX_PAYLOAD:   no KASAN report
    C  well-formed (len 5):                     no KASAN report
    ASan model, full u16 next_read_size = 65535 -> 65274-byte
    stack-buffer-overflow WRITE on both -m32 and -m64; bounded build clean.

skb leak (slabinfo active-object delta over 20000 reads, two data
  packets each, measured after a slab shrink)
    without the fix:  skbuff_head_cache +20047, skbuff_small_head +20057
                      (one orphaned skb per call, unreclaimable)
    with the fix:     ~0
---
 drivers/nfc/fdp/i2c.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..f292e7f37456 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,9 +166,36 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count for the next packet
+			 * and as the data skb size. A value above the receive
+			 * buffer overflows tmp[]; one below the minimum frame
+			 * size runs the header/LRC strip and the length-field
+			 * read past a short receive. Either way the packet is
+			 * corrupt: drop it and force resynchronization.
+			 */
+			if (phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD ||
+			    phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
+			/*
+			 * Only one data packet is delivered per call; if the
+			 * device sends another, do not overwrite and leak the
+			 * skb allocated for the previous one.
+			 */
+			if (*skb) {
+				kfree_skb(*skb);
+				*skb = NULL;
+			}
+
 			*skb = alloc_skb(len, GFP_KERNEL);
 			if (*skb == NULL) {
 				r = -ENOMEM;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260616-b4-disp-b1f8ab4c-b06ad43c9be5

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



