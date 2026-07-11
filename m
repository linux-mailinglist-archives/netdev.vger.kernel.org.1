Return-Path: <netdev+bounces-306850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tGKqLf44UmpTNQMAu9opvQ
	(envelope-from <netdev+bounces-306850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:37:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9C74188C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=oD4I3hle;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306850-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306850-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4384302BFD2
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6133C3C0E;
	Sat, 11 Jul 2026 12:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11F3BD642
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 12:36:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773416; cv=none; b=ZBm+XIkLNLatMKYrllM1YQMla1mjC+tsUUm+3dM6ooO2YaHHUWdOAYHMQWFyYo2tsjAgFBndajXeJ4XL+gmJ9yh7nDC5LnVFAcGxL97xqatPD6HGWiZoeqZ/uinkyo7wvdtEw9CjDc4psSKBPR5gound7i+TdBxevqmhL1HLor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773416; c=relaxed/simple;
	bh=yuIVmBPzTzrv2Dm30aECT2hNK8SzBGa9AOom3Qlk6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI138VR/9N47t0iroFQhfQtyPp1Kt8TjMj6iTkVYQmG2ksYQzog3YPv43hND3b1Rp37gFi4Y7ptMFQMuZQqee+XNEZraFIC5U8mkRZGCkO8mdTGMR/IOMbWIA4cR1JaSJGeVZ4mw1Dg5/l1zPuvHr9Viw6Dp4FTzjcLExnRvMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=oD4I3hle; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1678873f8f.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783773413; x=1784378213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKxklP1jarkRVxjcZK6OwpDBv6NsE5WBXhYoYNX2yBM=;
        b=oD4I3hleSwky7wC8lEMH0NoEXAcjtj/ecd+gaCHQmDFZQ/l2HkgeypDZDIlX5AgGUC
         UrEDyWXqxXe4Z6PNVPoYN/uBfiZe8uWMSRP82yNLZJ6uH7OWc1/sKmDIziM3mkEgaI2E
         OchUdmz2JKAkSGwMa+BIxar+zICyEUvXml9PG1aWHQKzVeT/9vsGZd/YzFxy2TNRNrn8
         SmGURwjDiD86+zb2FRfaC4WCJGq6GYIhq0mI+m3U33rRrfnk8YFthPSpA87xcrLQRtbt
         ZPxF//Q59i3kKhDpFnj9M13sqZ/+8n5TIHxEtxXotnaTsntiYkrFq1964VVoYKjHKzug
         Ptwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773413; x=1784378213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKxklP1jarkRVxjcZK6OwpDBv6NsE5WBXhYoYNX2yBM=;
        b=OXZ7aj91xNyqtiH1FPnSoezFOP1ygdKTdYt8SNdwSP73sBMFvi0Jo2MuMhYYK5Xro4
         z4CkUUzfoP3HXgET/D8DtXXk5xBMNbllazol805sJ8y6b/Ad9U4ZoPIy8OLgFa7P0fGs
         M0ml51nkoIXmoRQ4qljfwu+GLSAmqq4kvxRCyWm5IQaDYz8cUcwLNSl9RCPknDmPJVvH
         B3nCi7pLh2TLtiBKmLqvZ8d4K2ZuiPF5LL8CWT1lZL4fK1dis6cTLPNAAY95qiqOQtUt
         4wQPq5siqxhKj4zYsUxUhZ6vkkaBscRFRQppupZr1+uctW0Hg0zuJ/JAvnc4cWtdciHe
         sT6w==
X-Forwarded-Encrypted: i=1; AHgh+RrKhL4w5OQNMeGuqE8shOXanapZS2XwpnAgUwCoIvc58O++iHJH6lkcZR4vqDHSL74CwaKBvH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5QhPDbN7pzrePpmXvtcwHBbSYUc/PGzTCUVpGmv60JLpl5u0
	tmhgBXKiE+dO1voqrqAM8E/rhiZhGgbhroMHmePpu2Ojp8QgTm/pelQzopl9vWZpRif0
X-Gm-Gg: AfdE7cmgcBwxYdfaWZACCw/Oik+BYzFHebLWYAdeYtHI+YHA4yf3iH09Lfu3HFGxDtk
	Bl5gU1nVO0rFgfNxrSxJf7acKahny7iuKlssqalDRaZhTmkphXcgMQI2pjClJZkQhvYyK2o8cSo
	iutzhuSXc1qSCh0bXoUbxaAgz2jnimTfkJiDhaFv+G2uyAclR5JbAQhptvg4I4DGEE+VhUHZNNi
	H94CyYvi2KKakMcSc8q70CBGcTo++vNaFtBLnOI2QYuW7mo155pAp9leq8QYHtLx46agZGwnpHV
	HHqI5haK3O5qh70zuPrfh5ePYuCn49/Z0Ta+38YDtOMLGep+zriE5+8mEJa+OC0UuUwDBIRMnc7
	2Qfl+D+Byr9uVxGVVX2jEb1mO5RQrNA1VJGbg//1/haItSD1xEAcCW/dGtO0moyuZHt7FqGI9AP
	fdM4FNZpEEgP+5p6gLJUl6oMVJEKeUPqQ8pH5hxdPg4y9IbLHCJnUfXM8XF/mfBL+/FnhjWPNuJ
	7c0Y6uxR+paO3AmgYor0dMPkccFKWTlPj8=
X-Received: by 2002:a05:6000:2387:b0:476:7036:f854 with SMTP id ffacd0b85a97d-47f2dce9662mr2553907f8f.21.1783773413232;
        Sat, 11 Jul 2026 05:36:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm67690276f8f.13.2026.07.11.05.36.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 05:36:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: port100: reject frames whose declared length exceeds the received data
Date: Sat, 11 Jul 2026 14:36:51 +0200
Message-ID: <20260711123651.32595-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306850-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0sec.ai:dkim,0sec.ai:mid,0sec.ai:from_mime,0sec.ai:url,0sec.ai:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40A9C74188C

port100_recv_response() passes the URB transfer buffer to
port100_rx_frame_is_valid(), which checksums le16_to_cpu(frame->datalen)
bytes of frame->data. datalen is a 16-bit field supplied by the device
and is never checked against the number of bytes actually received
(urb->actual_length), so a device reporting a datalen larger than the
received frame makes port100_data_checksum() read out of bounds past the
transfer buffer.

Reject a response whose declared frame size does not fit the received
length before validating it.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: 562d4d59b8a1 ("NFC: Sony Port-100 Series driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/port100.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 5ae61d7ebcfe..30a4e09875d3 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -636,6 +636,13 @@ static void port100_recv_response(struct urb *urb)
 
 	in_frame = dev->in_urb->transfer_buffer;
 
+	if (urb->actual_length < PORT100_FRAME_HEADER_LEN ||
+	    urb->actual_length < port100_rx_frame_size(in_frame)) {
+		nfc_err(&dev->interface->dev, "Received a truncated frame\n");
+		cmd->status = -EIO;
+		goto sched_wq;
+	}
+
 	if (!port100_rx_frame_is_valid(in_frame)) {
 		nfc_err(&dev->interface->dev, "Received an invalid frame\n");
 		cmd->status = -EIO;
-- 
2.43.0


