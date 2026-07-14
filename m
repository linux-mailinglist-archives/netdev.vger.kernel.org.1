Return-Path: <netdev+bounces-307527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oxo5OxBoVmre4wAAu9opvQ
	(envelope-from <netdev+bounces-307527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D77570D7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=gZJjtv9+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307527-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B772306782B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB564D98FE;
	Tue, 14 Jul 2026 16:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861544D8DBC
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:46:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047598; cv=none; b=n/aXhTLHnzNljbL+RD0AJnz1zwBOrrXss/xpD9xvtbUqdEKYQP8OVg+1AfHAjSWYYsX9Q9+joJxXdszEy6Ja/d+VNc3eYtDR8MCXDLTbpHg+jZqZydCPI5ex/kNARFoKIx9dt7IISYz0w2glg77jObmIOL7p9NivJsB6YzEBaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047598; c=relaxed/simple;
	bh=Frw282+aHQ3ZxDrx8czE2RBlkQDSjmruTH68jMfrBuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiS4wkx+LK3dSm0xR22jdiRP8kyLCK8MZO3wYgQsH/oWou5HpqLYN9IBjAZDgG4DHdKxtv9rTh4xbRxhJsI/IWLLHHO3krSBsM5cPk0mWzuFzL7n44SwdG2GV/kw4t7w80F7+S/FonHi0yKqu3bC9n6N4O+66WcOkTHMoZWGcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=gZJjtv9+; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so38398455e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047594; x=1784652394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPpnQyB5O61CilIt8FpW4+VW+Z5EVEM70y97AViA5k0=;
        b=gZJjtv9+zCN/TMoODAONigwPSGtmTgORTQPIlXR4OH3i1L/obinSsCdEsi1PveoLJ/
         xEUAsTMCOarpKmmIBpdGaj7YErRkE73YilWbQP1q0dp3UQPfsKaqVxDTe/LOT8cEw1P3
         Vr+AeBM1qsl9EiruBIdMyBnN/OoGVzAP3bHWMor5ymJQTjTy2kkZAGVANp/6OtdA3pua
         On6iXBXPYu++903kHSBEvOIxbrGUPguwZxzgOosdJkRFdhi4cTa2JattnPE/WE+47FJ1
         7TYfVlGFdI4cHUzazAH5R4PipMB7eFZXOCIJSz5GfpUS4YkH2U078HoeMsO4sXRzzzD+
         Co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047594; x=1784652394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPpnQyB5O61CilIt8FpW4+VW+Z5EVEM70y97AViA5k0=;
        b=MrG7R7ecUUaHZv2awvDUBQhgwKjigTsxeISJpNGPpaCkmh1bYrQyNAyWFxGJJmMYii
         R+UNhugtAkeUpUMdXby0ATaQeZMH13bbAOR8mEoEy4b7p/gvyUHAzVceQEedM37Hye+W
         UDU8mUzJk2eIz0j45qloZArGz4tGkViSSj5AQMRW16LTl7LYwxw7VORkMKLmPawJ2guE
         ILXaXE2cdP4QUP901sLjzckC+gh0/KT9lndYGqWXFZq46XlLbFePJGQ/fvOAeLx0AatY
         GczywXVyYF8l5YQV/dvKPjnES5+WJ9OGgR/GkfXqwLOpTWVVDOB+wm9ATwKqMFHq6OfX
         5xkg==
X-Forwarded-Encrypted: i=1; AHgh+RqE4uqDFucSn+3UqCANICrgeTVlZ15TZgYM5WhHXaP4b2W5y73mBuwjqCe3OE7NXAwUY81BWE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTY64+/6kXA6Ic7PZEK9SFQM03MagHPRIueFqI2FWyegnon+VT
	u/LHA6UhPNYlFZSZIsn3E+zXSr+Hkv/hvGK7huDHYQIlf2B4Uhlb8975JNtHFu1Zl5TU
X-Gm-Gg: AfdE7clnajTYxOGq+loFEUi5+Yn+42bpY/BBkzKDmI/q/rsbIY32p6iZrOuRWuDQUgp
	iYKQt2/nDcDm/GorIWREdLUKJ6ZY0qwBNRJ55DmncCCuZjJN1jsODJRn0nCrjbHHdZGKq3/TTrk
	6cs5kmc5zPdewwIYJlVHmEarnAMEHbzUD/0em8LtLf/3KKYjY7EVjcPSAytTNj/ySvbfv2QE6zK
	UxEarTbvWBpzVyLdIa09+IKlLi/Yk2ga41ya0vql55UDnm9ChnGfmkrAyf32tYb0Crq09v1vVKo
	DvvkxWBUv8jzbB/fptv5jZ9EbKY+Up+GoQ8z0CzGIceEuhlmZ7C5e2GEgj5bR6oGdMBYVLTeFex
	jnjueG8uBJkUYlCA+uDrQoNwsTbfcSu6NEpinoEoAWM3WxxEaGigf06wFnzXegKYCExbmppWUko
	39MphaFvX+JGO7kbPZ2YuzGr/yw22CKJB3nd7f+Zn3a9cLzWKmx0O//C+DZuY4EH1/yDaVjChsD
	LWxXJKZpqrcPmkeCIvEW/WKy91bksbJ18k=
X-Received: by 2002:a05:600c:34d6:b0:492:58d6:2565 with SMTP id 5b1f17b1804b1-495389c5f8cmr36811105e9.25.1784047593529;
        Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b8d0f9dsm1989895e9.0.2026.07.14.09.46.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: vadim.fedorenko@linux.dev,
	horms@kernel.org,
	david.laight.linux@gmail.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Tue, 14 Jul 2026 18:46:31 +0200
Message-ID: <20260714164631.75068-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,lists.linux.dev,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:david.laight.linux@gmail.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A82D77570D7

Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
before parsing it.

nfc_llcp_rx_skb() reads the header via nfc_llcp_ptype()/nfc_llcp_dsap()/
nfc_llcp_ssap(), which dereference pdu->data[0] and pdu->data[1], and a
CONNECT or CC PDU then computes

	tlv_array_len = skb->len - LLCP_HEADER_SIZE;

as a size_t and hands it to the TLV walk. When the frame is shorter than
the header the subtraction wraps to a huge value and the walk runs far
past the buffer, an out-of-bounds read.

A nearby NFC device can reach this without authentication; LLCP link
activation happens automatically after NFC-DEP.

Guard the common receive choke point __nfc_llcp_recv(), shared by both the
target (nfc_llcp_data_received()) and initiator (nfc_llcp_recv()) paths, so
a short skb is dropped before the rx_work worker parses it. Use
pskb_may_pull() rather than a skb->len test so the two header bytes are
guaranteed to sit in the skb linear area even for a non-linear skb,
matching how the sibling NCI and HCI receive paths validate their headers.

Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
linux-next.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3: use pskb_may_pull() so the guard also covers non-linear skbs and
    guarantees the header bytes are in the linear area (David Laight).
v2: move the guard into __nfc_llcp_recv() so both the target and
    initiator receive paths are covered by a single check.

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..e3b2627cb089 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	timer_delete(&local->link_timer);
 	schedule_work(&local->rx_work);
-- 
2.43.0

