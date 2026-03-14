Return-Path: <netdev+bounces-267788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFxSBpaetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085428E2D6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8772E3035000
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CA30F932;
	Sat, 14 Mar 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="P/90aMXN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCA175A79
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510256; cv=none; b=a80xbsLFYFu3hmXjNKOKpODrw8+gODK7uEJEPp8BArAwvgnoM2xpObedzxaJjAbAH9AZoJQDJKZZXwWuR+sB1jy3O0MLeJ7sNf2SpGWYvFk24bp8DVGXJ4gWx5C2F9f5yuX0iI3PgfuU72rqh3QCOn1R/4Tg+RdXlw+//n8J+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510256; c=relaxed/simple;
	bh=klvZP/40lxt5y+UXET4CuAE7+juOWbIR9nJ0dt62MGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmmOmvWGdlja5cKEC9xmONSwxOh7q31iXgFWULUK/ECnSrAJ1cI9wXKUEZgLBoUyf3uQAl+VtyhMr87NJfph/ZHL+/16H5m4gx7KulYTtOEHIVL7y0TXY+hdZGcYGhjgKreINdu+30Zu391Y0cs91NkASznuVseZbCe8eWYPWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=P/90aMXN; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so4770439c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510254; x=1774115054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QegOAViTxtS33SKXmCA6KrdOEhc+r5S58UzkPIWvA4=;
        b=P/90aMXN2VdECbmHWE8F3CRrRHk228GzoLXaH05ojNa8G6+jc/ij7JtkPhYnl/2F1G
         qpI8+vazKLhLbfjIV39aG1X59l9ByCa3rqsyuTsPiOuK42YIQ9rzTbw3Om+tn3+ZS51E
         KdwanPTCwvLu/g2KI8Cshr7DwgLOPN6XcLNOgRXtUm7Ouyq79Wb/DycQEUDtVGn54eIG
         Zhy3vrscUhO+q1srrZj6TwOO3ydMvKQ2HPAJs5pYwBaq2olawjQQ/nUi76jOlnaVal3/
         u7TUAdP/mQnVSG5GHGbFU4EtncwrNX/DTFW96y3bd531bn01wnvP4LSjouEl/3sTpsbq
         wJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510254; x=1774115054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QegOAViTxtS33SKXmCA6KrdOEhc+r5S58UzkPIWvA4=;
        b=Drys8GfgqecqCVYR9JvkEMEqyFYel3+hcGtx0hUc64Nbsois92D3bIhiD/508f/sEc
         AQ1di6pisLA7TpHKHL2ZEeWwe894Zb2auWJ3DXFDLAl46yANK93+dGZ8UkcNeDIRR3Rf
         c067y76kn2A2y6iXo5Kv5uSz8n/srjqWtW2t8qyMCrYCOFn932AMGNA4KdWHvWKhI39P
         8cOn2zCLeJWSEENzozqgWXpnRep08FCnlWif4pAXfr2rlRxMNkB+hD3tPHl5qp0rqu4D
         +5WylBiGlkZB9daWZcvLkHHpv9FS3iiSkIYOpKJp87dKg6J1xFb8eQ9RJlAdSRB/Z0UG
         UiTg==
X-Forwarded-Encrypted: i=1; AJvYcCXHphveuGExPfVXe/dDPLav3KJsGOMbTvW96idJ2FcOOUQqPQXCHQ+qMI+/lySmaInphaDwyCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LgaRoDiOx8we8g9g3LNydbh8B8Q53yR1Lnd4xCzhbp4DFmhH
	WqXriY2eQQ0HCr2lW0Uxw43OwjU3hQYReIq8MePsgneq1Wdwu38T6bMUaYQx4zL2nw==
X-Gm-Gg: ATEYQzwvjJgoGRq9vLYO01l10dXkokvlo8ozOQ73gUVVRtmHQKkywOhhD0kndv54+Vt
	NQ7fwGe7k9nGcvOqqpkmfipY/duHP1+xgnQFJTlE8j7iu1LKeDuqXjFbNhSIBgJpa6qPZhUR8rB
	YS/FFbGbK6KZ89GY+5cDVu5TV27k1GSRL+R75qErvuJ5761D00HPiGT/YqC3ujZggc9CR8qKiFr
	DWim1V0URujzmCDD9mDiWrzvGbOSqVoIvDrxUT9edErHn6B/SVnygenaRQNzXTNz22mfvQcgjjy
	C2uDkIXAAPPwiBLicvfQ97VyI2LMu40dl96ZrNbtIbOaFm9WtDDUUObL3QIqBL8dUNRRNzFfxrk
	sVssj9Q+yzBBx3qj4fVL8x+GniLI6JSDZvYQdX1HL14fQjBensZ0GL+TBHX1GQ/E5UsaBwpLMCp
	A2ekdAcQ+/aTcPioEMkyDMllDbZyfJsdY6Gs50nKwApFucjAU3yop4scuHGgs0kyy/kwiQaQ==
X-Received: by 2002:a05:7022:6b9a:b0:128:cda8:39fa with SMTP id a92af1059eb24-128f3c5add4mr3548839c88.0.1773510254127;
        Sat, 14 Mar 2026 10:44:14 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:13 -0700 (PDT)
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
Subject: [net-next v8 03/10] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Sat, 14 Mar 2026 10:43:26 -0700
Message-ID: <20260314174333.46406-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
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
	TAGGED_FROM(0.00)[bounces-267788-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9085428E2D6
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


