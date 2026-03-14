Return-Path: <netdev+bounces-267804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEJ4EYGgtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B392E28E3C5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2517F304D673
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389A333725;
	Sat, 14 Mar 2026 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="QVkqjw8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612932E121
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510707; cv=none; b=rhJ4TBps/9pUcMplnCzj08rjmBTqFFe6ssO3cxPNL/EV1oDhxTRtZ3yCqCZBcuBOZYyzhKdrq93w5ok08ma7Lk/2sVLvxSVXc5FkzgT2syMVCRqrprYfdlndApptXj7T2EfntE6NdADgMH4JNQaPXTgx4x6bGYQebTtQHDWvvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510707; c=relaxed/simple;
	bh=klvZP/40lxt5y+UXET4CuAE7+juOWbIR9nJ0dt62MGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdW6V5v1Rwp9oyOegYNCwq3AYwQxboL+5FDk8zjGsc7A8IrDdZ5Wb/WOkGqZ85GyE/bPX51lQqTjfH3u0ojc/H3TH4u+6PbZw+JVYfjSZFX3QyJkvSM334QiA2p1you/XEQBYQqgcd0nL/v42ntT8aaqthDp77ngEAGeJ+GwXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=QVkqjw8+; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127380532eeso2854207c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510705; x=1774115505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QegOAViTxtS33SKXmCA6KrdOEhc+r5S58UzkPIWvA4=;
        b=QVkqjw8+v5ihMp73dt7Vl74nOIRTzYOGbmI7FKekaJcNiW22emh+obviiM7uLbfPZj
         EdURCddcc0/G/Iv8BQVQPIe8WuoqSNJosYJhZCPhqg2olzkTTMr7zWBShMnvPPSXNY0c
         EL08I56nzEcJuY1XeSUSjYLEDaGX4PzHAaeXI1xzgm7+NtkLwVPy1Bna1X7ZMFonB2iI
         esMtft/wRjwbbSlzTN4yz9zzGoPMVrHa0jHb8dntbpLQuiyhas9MCwKTGIkvFzq8ARpi
         hg6LakyB9LMSF9wZuzKYjL56p9eU4v0BZ5vlSdl1abfOZIMxlJn5/DT7FxMooQbzJoEb
         Jt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510705; x=1774115505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QegOAViTxtS33SKXmCA6KrdOEhc+r5S58UzkPIWvA4=;
        b=Ws5J0c9vl10iC4KVJuSfe8mQyN0I7FjjCv0bftRcPihtf7YtpI+trMW/tEJawMr22o
         ihGqdE0mhh6RY5MZfpCAGyseS6jTk/0QyCLEVjoLshZ96llkEaEq9WqBlJsDYZ9NunTA
         fTcahkJHrDX2fgNY1jRfEabGUF7l75DVXL8cHWd4LnxpIwM5b2ngqwjv0YmWc7UXdCDx
         VOlEoES8jXiqzTS/sIk3OFPwjlMho5ToOXxsvCHXXuhLJX1qNsCPGmzTvHzoucQpFbcV
         5EMNw0NG9B3RjQUNMZLDCCkHUqJqpr7IMPZIN3/19i0UbIiVpcJNqQ0dLw4X9OKTwCFp
         OxEA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTpVb2ss1w3zlLRqA+4rMii7pFFod/SyG0ppmqwRI0mW/O1wrAeeSl1DKcYB+ROjZQ2wg2sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjFIzIPHAyc62La9uu9+g77jATXWXxaw7Dj08rzNDbMSeyJYp
	FaVcZyCi+Tbz4+iF1NWmUQ4/l4YEHBkGVhuvZuDqb5NF/KeDCLW/bCnNlOgeCTanjA==
X-Gm-Gg: ATEYQzxWXuiqubf3oa5qVIWev1Fb07wa11Q7tO1rtQ4NmJxqMLNxxjYtNsh9BHuJWvC
	unp8q/P2oaZccYE/CJJXKeqmIon+TtmpILS/vsDMY+NkR4a9UF98Eum7PPZ97awb9udi39qjkAb
	GSk7SnDYo5CpfiKFo8vmv3OtJzT25Q4Z9oz/h9Hd+8LbZ7RlnP36/Qtk/gqyTTCHKGUl77lvGP4
	gwvi0kCApf0EHSGssTxsNYraFsHGC9YVWUkNdHfl19seqHWJBaj2lKDKig4H1L8SICDLB1m9Kr3
	72GoDAS+WY80pKlovDh24TRuUfd0AzPDQULoy8rsJsKN7gOd0dWkvcpu8jtXkS246C+laFyx6Mz
	7NSoCtSkZ9z2dZOf3FAWNLZ4KN/jgWJPdNUghIqzLafIx6HysVW8svKAn6c2m6SeVw4LPQtVVV5
	aJ1z4c1EHQnGuf7xdccoJbNrHG/BERbIrWzgKEFPFQKy9yha6UCF3MpukB6JwrvWIpHu+tbw==
X-Received: by 2002:a05:7022:6283:b0:122:153:d161 with SMTP id a92af1059eb24-128f3d7b662mr4111936c88.17.1773510704875;
        Sat, 14 Mar 2026 10:51:44 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:44 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 03/10] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Sat, 14 Mar 2026 10:51:17 -0700
Message-ID: <20260314175124.47010-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267804-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B392E28E3C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip6_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 113efbc19abe..e61d97621108 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


