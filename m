Return-Path: <netdev+bounces-267789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMMZHoWetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECB28E2C8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13AD8301022A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312112FE07D;
	Sat, 14 Mar 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="e2BvwlHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174518DB35
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510259; cv=none; b=hd0nykZAJsRaSv633Q4y+kjwko03hc71u7A7GwUKqFC56hXI/YQuts2i4kl7SFBIr/mbkPbyXoK7MID1IUiB37N0S27uMklbzLyqWYbVuFeoKjzkV5SqphzHv6yDHoEkjfsVg0png6Cj2Dmj7hEKuRbnP0K/sq8/KlY0P61+wPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510259; c=relaxed/simple;
	bh=S5qAqtFvZAdkkrMDPYkhYIvhLOH9ZuzJlUBDlh0yo/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjaMGMVJOswNU1UNozO2sZ1q2SHLL4Mko49HAI1kI5jpxJOR/U6AeW8kelwa7KGQxTG6GmL2tNPImDEq9DFG+hGajf92vKItTbmzIHCtPDZHjzyy4twH4U8poSR8OHM3XHy3CO2kNeirzdjgC+0d2MrSsAstWGvI6/hSy88KeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=e2BvwlHM; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128d2e3074fso4364659c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510257; x=1774115057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQmM15HU1N9eX9SmJK/guM3rlDbIP5lPwWHKKhRPx70=;
        b=e2BvwlHMds+Ac/TK6emi+31Lf5ccJ3Y1CkwICtw6DbO4zFRvwzJpYIrZjeJSFX1oJm
         tJblNmENAClkYuqKXP5lrisAtSGhp1aMj4JMOI0DUEgdEDF+kt9VJ8WubcBhmCvAjNjY
         8rYH4vBc35qKbwbI/fFCUEy6IIKuD4t0NGI5fE29XG+DWRou4m8wXIV8FLNuByllGvT5
         4wIM51/JXwpon7T3A3h90A/Y9ngD5lQqkESTWqUgVxvuAVs82oIrmpyPpuvzaZOxkp5U
         2IiEGviGeftKOOgw3WByPuNp+3SpjqlO2yfQ1TELHvEE1f8uv5vu0Fhu/z5oJSyp9EiR
         I8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510257; x=1774115057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQmM15HU1N9eX9SmJK/guM3rlDbIP5lPwWHKKhRPx70=;
        b=ox8FpCukBN1PzWFtQUKJCZo407NhnguH3cmIPOpbylPdAMjkzTcK3xRXhTmu7Qt/uR
         MLHkHP1VfKGCylMikVbkxD8uSX5D7u8rF0TLQcapo5LsMFjdNBV6QtWaMiBOtke2UyiJ
         0HngRZ7e6HbLS0PJC+z8dimNScQwVks4EaoJhlOsnXB4fnH4CDbOqLmcRkMxLz8wUOSJ
         bUuobo5nY5lCxG+Ohr9p45Kkh7CHCjuFgObICp0kXmZenSUGieKvHuTp8hzVLaKl41GY
         J4oj2sLJ/lYcvlJXyEHGXKUvr0jGzX/yolJHK6QhaDdsmFBe0dudkahO/f0dISEmeiU9
         vBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZvhI6WrUisnsHiWf3DjUOagcGtpyJEtK+YOD5k8zUe8NjxKzMQlUo98Uz4uYilHgHxcLk64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmzO8WuAs4yslgO/NrR+o6ZZLRNNBA9+sejZ11Rplt34+ENyE
	g8b5Tiz8ny/dzeu9/Ry4UL28YRwzoNEwttbDesoP4oLRJDyNaIMODN4VMc8vgI437wATwwfwiz/
	cOB0=
X-Gm-Gg: ATEYQzwoB7H0Y4FGNQ2Kpes6+8sdxPyah5nrWmCJqOE9bv9jhVOYZUV4vOdIbpj6FRF
	Znn26K5ku0xnm0zBYBst3ydUO/7Hrh/laKZCJheNw5rJNhhN0qlWW3wRwr2WjLIasB+10Bs3Fr6
	SuIEgUQ3VLGWCWUhTfix+seFJtV+vtoQJC01KkdSNwjma5XpK7+8rrL+stew7y7AncyOBZsSMfV
	eYfkx71sqjezkVykjdQqo6ZCIcI3yrJ8p0AXF+DZi3NNVKaDoEQZsoDTCqQcZtkNbTQIdW0+hvc
	Jd9thHKjG8eAdYHFB3dQ1UkEhlMZYoOYu5Dk1eQJP3MScmrE8Op7QzCJe5HLx7QkobqtHmIHMiX
	wA+IRdOW1u8zicON9z7NOtqzos3ZjxDVmj6yqTDC8iV6OnLlpVhVGkgBataGepfBTMThL8qIWso
	ij5+VorI42lp4B2iPWYWrytheWW/X2I1ajmVSL7q0spRh4NzsKlLY8D5rW/B2vtIjYYGLAtg==
X-Received: by 2002:a05:7022:68e:b0:128:d396:f2e2 with SMTP id a92af1059eb24-128f3d17f4bmr3482318c88.8.1773510257097;
        Sat, 14 Mar 2026 10:44:17 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:16 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [net-next v8 04/10] ipv6: Set HBH and DestOpt limits to 2
Date: Sat, 14 Mar 2026 10:43:27 -0700
Message-ID: <20260314174333.46406-5-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267789-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: 71ECB28E2C8
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


