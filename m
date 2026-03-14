Return-Path: <netdev+bounces-267805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gINJJsOgtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98228E3F3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18475306C7CA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B593382F3;
	Sat, 14 Mar 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="AWb6/fI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61E33689F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510710; cv=none; b=QPGOzdsOFLlEUADwOP+dfVoWcAqRvQ1z71OohNebRS76uhMYx28kSH/0KwnoCCUxLPcgpXsrhElUnx7b2/d7C0jDqEVK4/ZS9e3PppGIZktdpxSyJ/lqvYN609wAruguTXMuOfyi7pBxlKGx50V2UtLJlZdSnMvmdrLKuNcAJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510710; c=relaxed/simple;
	bh=S5qAqtFvZAdkkrMDPYkhYIvhLOH9ZuzJlUBDlh0yo/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP6kIpSxYnZw6k4t5PXvP7C6ivXHytVJt2IogJwmlTc2MFiL7t7nE0BbgIePxFx88ir9BR4scbXbToz6/343CfpCBvbtEsPhorhAJEg3isFvzMguZXXqFJYitjILlCUS7WD7sJObjXsocWoGfdg0zmEuHksS/X4g+h37I7Kgkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=AWb6/fI7; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so1516988c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510708; x=1774115508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQmM15HU1N9eX9SmJK/guM3rlDbIP5lPwWHKKhRPx70=;
        b=AWb6/fI7mbBF/T61GHBHLBdT0+8ZtADbREwcxc3mAwhLCVbr05XaVl8ujdOsLUkOTT
         rAuSkkXyJ+usSN5yy2Mykopa8tq4xs2yaMO0SqYOCX3EalbmJn40XYdfQKPOlGXR4F/q
         h115DtUDQtQskpS7ytOGCc8lw9J0DqQ91FQqVa1un3HgdCXHM7saas4bA9dagt61BnRs
         UuddP5n8xYk273MI/n5PTOCwL4AQXLsK8ryLh0E8Xn2+61l1+nOE6t8NYL2axGD1B3oU
         Rq51WFJO9duMrXlxcUghk8aHaUqsHGqeQl9TlJPr3DWo+VX5W66cFYNRuU2f8ViqI76s
         x4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510708; x=1774115508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQmM15HU1N9eX9SmJK/guM3rlDbIP5lPwWHKKhRPx70=;
        b=s2gx3rja/IYD6QHLHiHXlKWyCxy9hQcuja1EzLJdxnuFHklVkDQ54ouLFzHEeW7hfn
         l94TKMvMq5J4W228w98M8q57M/0tK/BAB1cQocli2bISUYJ2e28hJ93cgaBk7MTWwh3O
         RKu4SElvBVw/g2mXYY3d5MuXixkh/Y3FUYNY1I1TMhq+3aHU5ozAw3SXo2cd3FeJlwFv
         t9IGCqc602cwPH60a63XDGBnA9eiKtvUhBcEvcJqLV5Y09Ba9vaK1hyCGhjf+KBSc4q1
         46OZ+Zyr4TXEk9YefvsA5HkeK6WGPha/cdGkZc4NiU6Pe80rKi12zxdfymGnuQTdV7H+
         lnLg==
X-Forwarded-Encrypted: i=1; AJvYcCWOHuGkcyqqPGSI67XFMm32NStEaVKgXYwgXWmCZa7ciDkbASjYbHHF13pu4Q0TDO4aCJiVqE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3d/HOIt+uT2k9bvgI2NnlV9aAra5oWV6BU0XSyc9p+hwb1y9l
	6x0zDU1eLoWJfpz7v3HrpE4b2lY+FXVAUd06Uocnw4jUN4BtMbGSUlRxBQ5o3rS1uNHrGBCfD5i
	yoh8=
X-Gm-Gg: ATEYQzwgPA8xxGEprVjsglbvC8Gyi0+t/7NAukGRJF69FGw1b0Cj3XxBzFci876bsLe
	4xEag2kSipuCOhvTwYYFTTXqJ0rGHfW7XrWZwJ6opyQm59AqiYocod49CbYxW3yw6uhbCI6FZoz
	1opoL7BOotjodEp4WlaKItamp5lvvaEMi+PpI1vaFYEMnM/aoxfIKRLvg3NolOpUna4egktWbyo
	jFAcXVRY1mO1TSERCCDb5oV2hE2DNZqsHDKq0Y0lL2Lafys2MGF+yHVU94pj9CRV9/c5GXjty/3
	I1TSWvbmbKcc2cHNsERQO2/o9oH99o1dRExXRzyxH15TACX2WNVat8JS2GThhjTV4UwR67Bil5n
	/Ob+Z8CLWrLTMb8YELU9kwwjxdpuCh0hg3vYcC5EWXsYE1YApD38GAouVYv7Pzlkb4GprmC3Hen
	azc1Hjq2fdVDTiKSPZfqz5KGmy8IittQYAbiH2XVTLllhoaaCFGNHyUIjGFSLX94X5Q0teow==
X-Received: by 2002:a05:7022:f89:b0:128:d4be:743d with SMTP id a92af1059eb24-128f3dfe37bmr3710357c88.21.1773510707726;
        Sat, 14 Mar 2026 10:51:47 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:47 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v9 04/10] ipv6: Set HBH and DestOpt limits to 2
Date: Sat, 14 Mar 2026 10:51:18 -0700
Message-ID: <20260314175124.47010-5-tom@herbertland.com>
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
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267805-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D98228E3F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more than two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimentation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0958cc5c6ec3..1b9819ad0c34 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -84,9 +84,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documentation)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


