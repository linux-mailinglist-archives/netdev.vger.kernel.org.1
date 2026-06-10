Return-Path: <netdev+bounces-297578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ey7NOw2KWrdSQMAu9opvQ
	(envelope-from <netdev+bounces-297578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01F6681A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=FZUEeeIt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297578-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F612309EF0D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF63EB0F1;
	Wed, 10 Jun 2026 09:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546363E451F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:47:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084824; cv=none; b=fgraTd8fY9EjM+LhbB/4DcmzqsmbPmPTilPtb/PQE9ythFVl1gsM3W2Vz4Tp97A94VVmEQf+5f9eNjsJ+HR0RZDZacyvIpAWYPpOqjRjnC5qkNRwopeDccbOtwfSHx+3xBn6V1P06JKCtcX+8Z6Q+1odrXDXiwL64L2vUCxB44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084824; c=relaxed/simple;
	bh=gCmJFbhKv3A+285qnLQez3gGFUnvAD+Bwbz5WSkrKl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rri0dT81d5IOvyiFdnefFuCtsxxc9JALoawAbt0ikVz5ricY2YzNUJmn0UcjMukA8+ixt8RIQreb+SkbKfF81Xfg88XWmOdP0xvvLFZ5ZeBznbD8ub1TNYxeKkEKFzVQhnJMDKtEi3Hp1Ly+DxWmaY2ZWB9iUGlKQ+U+AG+MPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FZUEeeIt; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso51261915e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781084820; x=1781689620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jki41EppFisXGMhg9bwkucZtLVS+PePEZuHeAkEWL80=;
        b=FZUEeeItafnyGAeQjP1CYGBAKFeElN4JjN2MSS/qYW73eDRnQdrfqQ6GsgO8LUQlhd
         y3R5wRMBUz7ZvEUJj26EBCMcemveST7oMd/BR6x3tNRGGPLDdc/NzEibfwLwuImqleOg
         cR0d1OMA6USEoPEKfHQMdFjHlNln8nG1BeSi8SbXDwWlBzcbKBMxAA5r2Sl7qlJuWctr
         cuR04m+VYpV8V4coS5WIju0kvYpjXFOef4vBT3hdijhpW3JXTSV4uXr2nxhkenE6k4PD
         lIMZMLB0Q/RNhCuwBOTg0vdlIjOPeS/gfTBC5+qAT7kXxjgQW4QHeC90yvvKczolE+QD
         fk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084820; x=1781689620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jki41EppFisXGMhg9bwkucZtLVS+PePEZuHeAkEWL80=;
        b=dkKOm7E/Mu/U7gbprUyr5o8L/7gCUeKzhYCaIwJ8j20iBmU3yezGPpESXLkeLM+p27
         8xIXEYA9I8nPn3YVkGXhd2z3pferyvTWzPlL17JB5xCJTf2Vlchco9n5iUQkX5iiSFU5
         xwVpKqV0DKQEHXOS7qwTueum8M87to8F2QEZG3PDWfM0W1puHQ6nPafGqaGQQuSM/4zS
         +9xWC6gk24FbUyuxMacv0ZHXbtG5D+FaVn4NjGz2+xRh/dyhQvW+sXwiUVeVS2YCGY/0
         042E8XgEUJ4vnM/rpcFw60WRTUdLbOFGbCg/t1Ze35HKkVQEBedCnkB/sd/dekMk+aGP
         Lk1A==
X-Forwarded-Encrypted: i=1; AFNElJ9oK2hR86HBPi+iVmFhxkB5SLkRWS/PDUUeZzaX8IcQ4HXnG8NA/rUnwsrimqwqTMPGVPG8kbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iegtMpCOIcwK+yaSxrGf4PfILtAcwxPBwKrFk3y8gUHqZoYB
	LdfoQYT8jH11wsXsucZrHfLkJBAW+IVGZfQch8SBu4vl2kLcjZZNF5Ky+qJKy+EPQxLR4M2o2p4
	bqQns
X-Gm-Gg: Acq92OE2wcRyx6WR66gCD55DMOZAmK6H5ywRVteYku1OyyAUYW7RbbaSbgoidFRxGTC
	1lGKOe7QL74fDRIkSz/iqE9MkeP5jdSeH7AqN/OgL0Pkg6KJT//kW0IpkGzPuSE9PPTg3hlvAgy
	74HqT14vO8OnXKPpwFNt5KRG4CZuiiOqaFFBzJ2ZvH7wZ1dANyOQCte/OrozJkS3uyC59JNmrZ/
	6evi0dk/m9kYeSw3hVzPp/QAAAFzx+f8a9Q1cNzQ4cbAaqMHGHa5s4GX29trZWQra/pg/r0kHST
	M2KhwyZ/iuW+d+7z7YQvJ4T1S6CgRXOJj0r+BcC+KlxMH1cOtgcAiZjlfPYtldjYa4bu2DOMKrt
	GzY9Yblw8qYSIWXkFZve39/3KH+DR4cwdJhzROaMZPRRM9IPYpYfvj+Jnvy1sBUQmT7+vLifJS0
	nznj1LDymcpk8KxnGOpANNAd3NsNTlLus9NkBezGg=
X-Received: by 2002:a05:600c:8208:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-490c2cf6718mr282882895e9.9.1781084819273;
        Wed, 10 Jun 2026 02:46:59 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc39e024sm735528315e9.4.2026.06.10.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:46:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] ethernet: 3c509: Improve style of pnp_device_id array terminator
Date: Wed, 10 Jun 2026 11:46:53 +0200
Message-ID:  <a0cd057e6a24b9d355b5e4bdfcdb812cdd1e4652.1781082923.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gCmJFbhKv3A+285qnLQez3gGFUnvAD+Bwbz5WSkrKl0=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBqKTKMJwgLwWBaoKYGAYaI3/ZDT53fVv64vOqym U8GB85nCVqJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaikyjAAKCRCPgPtYfRL+ TibMB/ieyQAIb//vhdOKqE3FBysZx6nmro1WHJ9nW5msQbtBAtAYdxxqi4Md3a3+8MoNRkDa95B YFrYqR6IqBb4Jz915sXkyoHaog2WirIyGT2dHGhkpRk2g89s6EyVli1HSU9AjOstbBmsXbgwxrK kAWZPYIAT6GI776oqVrkopu5rnED5dgbYaZRTo30ZV4MEE9lnGqsPMOIR/95DVoeKmWhis2c8mt B/SDq5L0GD1jgfoC+gPPKvmPlGx0YpAg77Ib4Rli7kSWgbJf3skiN0GZdVKYSNIOhPVgDDDt2Pt aP+hsWUQ/BKkp49rhwcynjaft3LWPfrqB6j9xe9A5UTyecY=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297578-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:macro@orcam.me.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,baylibre.com:dkim,baylibre.com:email,baylibre.com:mid,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF01F6681A7

To match how device-id array terminators look like for other device
types drop `.id = ""` from it and let the compiler care for zeroing the
entry.

There are no changes in the compiled drivers, only the source looks
nicer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I'm currently working on changing various *_device_id definitions.
This patch is irrelevant for this quest and a pure style update for
consistency reasons without further dependencies on it. I just stumbled
over this while working on that quest.

So if you don't like this patch, I won't insist.

Best regards
Uwe

 drivers/net/ethernet/3com/3c509.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c509.c b/drivers/net/ethernet/3com/3c509.c
index f23be7425daf..3438168befa6 100644
--- a/drivers/net/ethernet/3com/3c509.c
+++ b/drivers/net/ethernet/3com/3c509.c
@@ -438,7 +438,7 @@ static const struct pnp_device_id el3_pnp_ids[] = {
 	{ .id = "TCM5098" }, /* 3Com Etherlink III (TPC) */
 	{ .id = "PNP80f7" }, /* 3Com Etherlink III compatible */
 	{ .id = "PNP80f8" }, /* 3Com Etherlink III compatible */
-	{ .id = "" }
+	{ }
 };
 MODULE_DEVICE_TABLE(pnp, el3_pnp_ids);
 

base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.47.3


