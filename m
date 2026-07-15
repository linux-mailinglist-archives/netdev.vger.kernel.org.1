Return-Path: <netdev+bounces-307699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PCL9KfVCV2ofIQEAu9opvQ
	(envelope-from <netdev+bounces-307699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 231C375BD0C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b="cl9vi/Cl";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307699-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F4E9304B9BD
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06453CB918;
	Wed, 15 Jul 2026 08:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90152931C1
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103628; cv=none; b=Z4li9H5asIv8vzYZQ0zWkAoHN6D1jF7TxdHbEmqGSK2kh77GRmLUTHfBNIfbOMZMUrJjFEfWv4udAo2zQZRnIS2ByHdNn/NokM6rHwitKhBCHISTw3u6i6bDukHM+4kBh/xs3LKCxFG9k70WRLBpysqBH8qYCbkY8YOYfVLkYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103628; c=relaxed/simple;
	bh=bvwwW4R0N6grdlPYNqdz9MLWc+DG/FhVQKqmEhPbqUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/eguq9pOWCoqYsu8ynzTZvjBGSLH0g9K3PUcEn8UXByN1HZZlG0z78AqMp5Wcf4PvBYuqhNOFWWS6hhaQg95stFVXjnsQwQdUkWEN8m4FTIWFICmXHIinNI/vJPYpEcEowG1U/bJy25p4fq61tyFo9EskT2o1M2atjydLI0uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=cl9vi/Cl; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so4695169f8f.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784103625; x=1784708425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JeyNa5yOVyOyuTQrDgjtAmBz1VuJ3FD4iF0lMD/jV2Q=;
        b=cl9vi/ClfyCuMOKE3Jw6Kvyq29f+9yHOd8WOdO2r75f8OFRWrnZFMP5ESYzh21edb9
         R8pYEPa+2r9ZbLnsCTKhVzXM6ljL3l9JQZ1H3Gi7LlbsxN9588RHyARxb6uQmhmcV1gr
         KHeVwIbggH2+R4dj6DH+47GDKb4yjqAicmTWXus16ShTospouJpshqkoychLuRgwvY/h
         6pMv59sC92f6QCAnt0XekJSorrGX78FSjo2LOOD4/54ZxIaHIcSjYvcMZPJSi1scik1K
         Ef+loQkAcdk3h2gy6m8I7fC0fvqQwgEdurPOZLszE1E7OasSXiUS1qE+d/F8beIy22FK
         0VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784103625; x=1784708425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeyNa5yOVyOyuTQrDgjtAmBz1VuJ3FD4iF0lMD/jV2Q=;
        b=ABxPBoG69OOSRrdWIUlNasRQyDuRXUY2zLxlweSMBDtK9zRhvYhVQ7g2H9X9mRF0ns
         yflBofriK8a38WZMbZeEJh1NnZZhdOeQsOTF3zUAIeCKLyJw3TwltnjcfnGDgjuGQ3he
         fzaQuehU8fsTWcbPn23/8Ai9/vFV5FWsBwEs3OXOJ2vbzVKNkdZW0f9mgAYURbSHWA1p
         tHQ1OEPVPJ3EpZ0CXxKHi3B5SDZACEetIZcqU+mGf1y8l2HdlIEy03h/NvfW9b1hcQwZ
         ecsqmqFYVYop7V+mNRwGjbSD0Xidk07wCSTsZGWC0xnEjfofQYQvFHorEzSNDyPRXucf
         VPEQ==
X-Gm-Message-State: AOJu0YzR5/ms/De/ozdc9SB+qZMBqOHw4EGlysMQFVVy0NinItKEbXDJ
	1q9Z+Uov+//DOTI/7mOjXeuAUZbdmrY0EiCIgQeZeollsPifqLcFW3ncLirEmWVS6VLa
X-Gm-Gg: AfdE7ck7YcCJtS1w53hUZMB+4MzDemC9d9O9r1EXIQiNKtWb4ZckqVRMu7/rObkpBvv
	KL7teODmgD92wObw4fCMx56o/WlyU5wz86nKSUnc6yA7xJPUaiRwCtKJB9N5xE+xIUyMCW8KrIO
	XX7mc92Aftl2ggWkZO4LM0BduaSil+aOecvt0I6xou2tUQqbI6stKNoJA33cjfU20tVyZN41zbi
	i4dKYmWEowPN5bD1O205vhCNMN+yJP1/9ZMfDHej5LSIyS2PZ6nylCCjx9293nm1bLfgEQaxo7G
	TlYidL5orRqNxqvJjCxtVDDt4u39pQsnRXXshbHaQA8A9IazooofYyxcHYV17NNN3KZJX9rE116
	muih7mgp6G8IuIhRgKkf79d9UhK4nGWhhzk+bSLQwrhLDXk76WbyO89AAG+KPk38sZIRAMX5pN2
	H1sGCN3f7exheU0FFUThym4Kr7Hss9aq5cc79Vm4mdrk4ICVIKVnMyUiSgGATOhbFT/IJ9xfyPJ
	RAKJwys5Zf9XwsldJ7KMKYZfQkXeiFcTdo=
X-Received: by 2002:a05:6000:4201:b0:478:65a8:6305 with SMTP id ffacd0b85a97d-47f488a9beemr6540145f8f.49.1784103624560;
        Wed, 15 Jul 2026 01:20:24 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm16390049f8f.18.2026.07.15.01.20.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 01:20:24 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mctp: serial: handle zero-length frames to prevent rx buffer overflow
Date: Wed, 15 Jul 2026 10:20:21 +0200
Message-ID: <20260715082021.46315-1-doruk@0sec.ai>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	TAGGED_FROM(0.00)[bounces-307699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 231C375BD0C

The MCTP serial receive state machine reads a frame length byte in
mctp_serial_push_header() case 2 and validates it upper-bound-only:

	if (c > MCTP_SERIAL_FRAME_MTU) {
		dev->rxstate = STATE_ERR;
	} else {
		dev->rxlen = c;
		dev->rxpos = 0;
		dev->rxstate = STATE_DATA;
		...
	}

A length of zero passes this check, so rxlen is set to 0 and the state
machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
incoming byte is stored and rxpos incremented before the terminator is
tested:

	dev->rxbuf[dev->rxpos] = c;
	dev->rxpos++;
	dev->rxstate = STATE_DATA;
	if (dev->rxpos == dev->rxlen) {
		dev->rxpos = 0;
		dev->rxstate = STATE_TRAILER;
	}

With rxlen == 0 the "rxpos == rxlen" terminator can never fire (rxpos is
already 1 on the first data byte), so subsequent bytes are written past
the end of the fixed 74-byte rxbuf, which is the last member of the
netdev private area. Every following data byte is an attacker-controlled
1-byte out-of-bounds heap write, and the overflow continues until a
frame (0x7e) or escape byte resets the parser -- effectively unbounded.

Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
discipline and bring the resulting mctpserialN netdev up, after which
the bytes arrive via the tty receive path.

Route a zero-length frame straight to STATE_TRAILER instead of
STATE_DATA. The trailer/framing bytes are still consumed, and the frame
resolves to a zero-length skb that the MCTP core rejects; the parser
never enters STATE_DATA with rxlen == 0, so the out-of-bounds write can
no longer occur.

KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes (before this
change):

  UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c:370
  index 74 is out of range for type 'u8 [74]'
  BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
  Write of size 1 at addr ... by task kworker/u16:0
   mctp_serial_tty_receive_buf
   tty_ldisc_receive_buf
   flush_to_ldisc
  Allocated by task 152:
   alloc_netdev_mqs
   mctp_serial_open

v2: route zero-length frames to STATE_TRAILER instead of STATE_ERR so
    the trailer/framing bytes are still consumed (Jeremy Kerr).

Found by 0sec automated security-research tooling (https://0sec.ai).
Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
Cc: stable@vger.kernel.org
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/mctp/mctp-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..a5070ffa9a95 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -318,7 +318,7 @@ static void mctp_serial_push_header(struct mctp_serial *dev, u8 c)
 		} else {
 			dev->rxlen = c;
 			dev->rxpos = 0;
-			dev->rxstate = STATE_DATA;
+			dev->rxstate = c > 0 ? STATE_DATA : STATE_TRAILER;
 			dev->rxfcs = crc_ccitt_byte(dev->rxfcs, c);
 		}
 		break;
-- 
2.43.0


