Return-Path: <netdev+bounces-252063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCyABVFKcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:51:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 727565E4C3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008787C43E2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C83A4ACD;
	Wed, 21 Jan 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="V7Q4cA6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCD3F23B1
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032199; cv=none; b=mWxwXpZdv0++xug2lD9eG0CBO6kyHyriLYPymyOXYfV9D6O4TjLJWn5+kdbTDR/wRoG9wVSHWii0PsvYHnx98YkC+IVb36NpFfntcUrPO/KDNErQaaNTPaoQIZYcaZbg6yGG4JcRH6Er+lH5KwqReoIMFZ/5/F+y+K3F8xDm09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032199; c=relaxed/simple;
	bh=C8OZ95/WAU5Mgc4JqBFq9iwhhE8rNCstGFD15StYgfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRJcKN+6ns7gr6dBdg7/P2jlIlB8AR0dkR6/Ft5dRrNGrTMb8UDuTSworiPGCqVHyKuNyoO0OwHzyFz9hW8c+4A11q8CPOdS0Iwi3woy5jLW71Y3JeOBK6td5DEFKuzvvZ57CyOejkVVT8tBGHuURe+WLiJAkoWLJLo3L+6Cp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=V7Q4cA6s; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b71557299dso411751eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032197; x=1769636997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=V7Q4cA6smr2ISuuMLHMz0qRupOfC+iSLxH9VRsI6r0+Ia7sLfZkSVYfrW03IQfwR4b
         1CCyh9zVmCASvaQVHWLMBY64dh0cvqImS6AVJLIUAoI01sjtPzBO8up60WdyhOUt6Fdv
         j30HjDokJn2f2Wm/kGQ9/bTvUOBswZCM8MDRpUOX72wHlmo90CNWAoG03DB2G0MXo2sk
         NbOW7XKGwia0rosRr9DgZIBpSkJR4i2VOPIYVm7hs6QeUwlBfBzEGquwC7V642utBZA4
         5wwpJlKpUI3kqI16Jd5IPxJeDcqc5u/Kfzpb1jpngvDCTjkAiNgpngQKijY+X9icJlfu
         xBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032197; x=1769636997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=Bju0gOS8b9TnQCp0U4KXAT3mfqUhvgAqZU+Cq7/WP07tCu2KNOct77E+h7lasWZkzp
         JV3UJvNyYjTbSfsV1hNhBJugWdwsUoc8HS8LNYttQB7N/PBps00Y7wLhEltqXErA/A1A
         b3IBd/d00zm7aexKltshfmcNl1Ph0+/pWJtou+FnLvbzhpBTyX+qTn0pfE9Khno320dg
         rrhWPi6FB1jHLDkWHwv82Fy1Hf1vGi0H0A+0bdmqhnukgHy+2Qci75PsCX3MPHZTk9ps
         PsrOd415QXRKtI/KybzhoJTwhEOrMGlb47Tjdcl5265oQElbVP/vj+iEoO3KXHMEDf0+
         Eo5w==
X-Forwarded-Encrypted: i=1; AJvYcCW7lZPGS5LOVvkw9lEMtBkEYu1rDKOopHykzkvlvYJpNNqjoYlwqJjPfvqKC5uSywZ6/5tJyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpqIDIkmy/PbHncu8JmngZ5qSouxhPmqnNPNgVM3KIpW6O4O4
	rZKSrt9QiqYLHTROOT3JioUVUP7eVTJb0ly7BSGc6n0Ybe62xr/RQM1ZCyztpySAIg==
X-Gm-Gg: AZuq6aK/fedOUdcp8Fxpaevx5psXCb/hOF9Wj7e4zFGreu2rgEQH1xd7JFj/SZdSTRu
	V0hExAkEqU0CEHxgVmwTAuEzTd0cRt1oJP6Xt7tKJIgdYJg6rA39eiuk10FqhFnUrfol+wKxcLU
	k/0JVFq6XLEPRBzWHHQsXNK4XfGCfdtFfnYKhoUYXLun07wPLWzxu2du9ffTUO3+57yyG5Q1LxY
	GSC2msACefvIio0aQRXSj4FGvlt1rbTDWVEpxIjNHlabr0FZMWw1pk2bd1XpzyjRxZdfd7+ef/M
	mHRnlVlrwKrnQcRtteennD+AiLZT60V5hA4djaZoRSEbRJqgDWJhSLNXTOon7Hvo0lO1r4wRngZ
	LybVHPHT8opJld+Igs4ePDHJ+We6GiNv7Wl0dqK1nasweX/Rhx2dU+ig6vLtJpeKaF8HTmd7EdJ
	z+2mtSMVheND7F+XFX+kc5w7CEgTeYGR7k3XXFP2gQ/UFmcz6mJsLKexq5
X-Received: by 2002:a05:7300:8b85:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2b6b4eb4c13mr14683158eec.42.1769032196400;
        Wed, 21 Jan 2026 13:49:56 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:56 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 4/7] ipv6: Set HBH and DestOpt limits to 2
Date: Wed, 21 Jan 2026 13:49:22 -0800
Message-ID: <20260121214925.112604-5-tom@herbertland.com>
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
	TAGGED_FROM(0.00)[bounces-252063-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: 727565E4C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more then two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimenation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c7f597da01cd..31d270c8c2e4 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,9 +86,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


