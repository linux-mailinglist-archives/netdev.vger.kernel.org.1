Return-Path: <netdev+bounces-252062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA+4FSdNcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:03:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F03025E71A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DF5C4ADA46
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C773A8FE0;
	Wed, 21 Jan 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aBv7p/p0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421893D6495
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032196; cv=none; b=Xvbk3xGUxh2tHRHZ2iOK4rBqcI2GEDEGdhNriYNVg8XgDHc0wqFftlvupfJCLUhRZc1U0duU6PXesk9ls44heZfbeLQ4i+d6TYudTqm1X5EKNAvpjKo1tbrB1gy8JKFrcmB8VnWpO02u1IEysOdF2Md0bZxQSM8Y+bvSaibtME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032196; c=relaxed/simple;
	bh=PmV5YAPEpQOqqVDfWDBRqjD2thilw2MpMdy0q5knJbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4lgt/+98bfxrHizhRJcumfqBRT2aWrsyoJYYP00siamsldIzF/6sYorroC9cNfBYtiDi6xvhqqwmCqast8zeVd0PKnvq8DRv7VbsYNOMjZkDqKkfa8VxZWejnMk0JIsbAgHu7A+JKGtYvhI1aEJAO9AQfTYcmNP1tC7ojNc/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aBv7p/p0; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6f85470b6so577652eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032194; x=1769636994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMyq9AmwzRJXnI07jLCpkE9ql0RrgO+3qgk2M4bUPqY=;
        b=aBv7p/p02KvLvnIqoJl/sy51SH9OlpsHEEDHO9gQIPq4B/BdTXc2/nEgunUp2B3FCm
         ofwwTvIS7OPiDoykdz2d7+Qpimo9sUBqyPDCsQF221Ovbo65f2ExBmFJdaaE8y/4z66W
         rsxNafsWuDMdWmq4TWd8if2tGbHr+Z4RqelDXZeh3XaRGXMyS+F2RvWIYiPiJ+veDY1p
         PYuDzFTnm4+HVq3l6bXtcbdTXvGWb0jGeWN3RNlQYd587h1bQnnU1yqDKZTDHsXBTRDm
         WOvzJUjTAa5LfHbnzCyXiuh3M/qHgXHHmunDpw5ED5rPlFskVyw/FzxvZ7VBKyuZvUr5
         NyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032194; x=1769636994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMyq9AmwzRJXnI07jLCpkE9ql0RrgO+3qgk2M4bUPqY=;
        b=Iw3Q5eZqVCqkw8SL9qxeCHyRastDHPN8JlJ+bWMFjZMRwk+t7sQ621G1uRoMcNDJwL
         Fw9/OULmiZpSX71mzi+MTqtQDfXAvhrImFd8pQMbm9UQoEp1TW+gL/W4kZ1C42URUxL/
         I5C4UQMnK/VjMBVdo4PnDe4fJY53H4bcpIRJBApdxURRC7jBuxDQON1K8X43C/46IQnK
         7qF1k06dVnDte8S8/fLVB1NTQEDdmakSHmMC5npRxni6kzNT9zISeIEv+NlTmz2Le48c
         P6ypMDMCD20JZJy7/DwZ6vUg8HmUi0fD9id70eBuiM/zAzm0XYxFLbc7f1CWrMadR5iM
         vZSw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmdBd4CGz7/f5AdAcW2yUxzbg+60UC97kkmspHf85oZay0wDwKGXJWNVB3FUAYkZxMbk/x0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYO+uNd/w4PoR0lrA+IuYe/IAv5XxPWovH2qPbuNfN2qICPEkK
	Gcry4yDQC8Z3RMQZ2gz2WohDMt/k3a82gR1wi+3+6jM/V2TL+45HnHDy86/fuG50pQ==
X-Gm-Gg: AZuq6aJXGDTVh/RaevfKtLQe/DjVXhedmFuL2pBzf1p5zxX0lV3kICANRbZfQAMlVnQ
	MNBWdZTgtEuRQZHWVRLHij9Kyxs3cs5X8jIzttKvb2NLrZ/VsBpJW+o7/1KCPFFIuVKnExTqgbi
	/4QqnH/FVwhCXbeMu7Wf+svILLwv3POptnt0w6jYR9YGEETmrKCFS5ePkLH2HZEDUT3vU5ERY/2
	iICtee7H0Q6f38sp52oC8zfFKr5lbfjNJQuyddT4A9BYzaU2aFf4fjvcYw5nLAS6iMe1TvrNBge
	hiQAwBmTYcDRAgNyhKmQTgqth6sq2QIcoGyw6BSYogTedbVhIQN8p9c8GF8FfSX2dfVnwKYspdb
	JKVzDFL/YpmX4t0yXzfF1jXmgBCog9+c32TzxcS+Vr0tizf2i9+5/b9DlOEKp3llUsu2Lvb/WCj
	DYXdmDeT6H3aW7xfKgzLop+X/gORjMDcJaa1QrcxU1s1AWKJ9xdbZ9yn+k
X-Received: by 2002:a05:7300:a498:b0:2ae:5b01:bfa5 with SMTP id 5a478bee46e88-2b6fdc9c839mr4673058eec.32.1769032193859;
        Wed, 21 Jan 2026 13:49:53 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:53 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 3/7] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Wed, 21 Jan 2026 13:49:21 -0800
Message-ID: <20260121214925.112604-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[herbertland.com,reject];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252062-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F03025E71A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 45bbad76f5de..394e3397e4d4 100644
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


