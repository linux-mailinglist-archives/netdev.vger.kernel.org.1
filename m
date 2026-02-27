Return-Path: <netdev+bounces-261894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBWgMlO4oWkYwAQAu9opvQ
	(envelope-from <netdev+bounces-261894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:29:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E59981B9C80
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFFE9301CAA5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78420426D15;
	Fri, 27 Feb 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBoadKQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865541C2FB
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206017; cv=none; b=tiwhh7Us3RrbvASIlYwveTH8isNP+R8rSeXl420UK/Kx4J2B0hTAYh8zf5fkDI9A3V4pEcNMQ1OnAW1Uz25xmjdX6uOjjDWkRhFeBsHcFKEQa+kreX3kdK2D+4LIHKmUlpXv28c99HBlnPsYmaKzAdR7HN3Ug2IVGANMY5bezfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206017; c=relaxed/simple;
	bh=KH38vAbUG91j18z6rOjdMD2fAX3Mmj2nRTot2I1wbL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpQIi9jw8KxjH2vH3llJbv2bZDvhw+AcF/JZAKrretN5+X08/OpbV7mbM+qYeDRGpoFDyCsv1Vz4RM73DzMNumpeB/tSehvLW6GvpcVTPgyaksDypiWS3fn7pYiVydYfLjVnJ1WmuoNHnEtLnBzWmjlL8hufVHT7PSLkfMp8elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBoadKQC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed90bcefso1208202a91.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206016; x=1772810816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0tbDXBeKezMjzIv1CEH1zzav2roQ8v1QT6xHrnaf4M=;
        b=ZBoadKQCHwlbLAEiJjqxPNtgQKLj8iczlHlVZ/Hiadfpe5qW3/VranHjhAW7b+MvSA
         dHaD0XgIBxekREJqlDmgCws08oh2zala6YmnKs+3pfsC607sBtIskXoXTUenv3b9TrRO
         WCWSahn2Yenj5GkrUCY62jkk+hU/sUSXEBKufNvfBll5RBMUm4wZPnd5GsBtorO3N4Xl
         cyCca3Sc79YkRtMCcv63o6epF9VEs/dASl96m+zg7Rn2L/Tp9VZ2qECRis30YBO8tQHA
         jv4J5YL1oDayDq8izT2M+hYmDN21HrG/3q79P3Qfe+rb7rFu4GSb98wDCtT8fIH2Zgv+
         rqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206016; x=1772810816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0tbDXBeKezMjzIv1CEH1zzav2roQ8v1QT6xHrnaf4M=;
        b=b3O0NWTT7k8mWq2TPCSOIS7+PuWLouGKJCZWfBJscruHf3ID+E5nyLg6B5JC6heb2k
         cwJSTwtEvrvTuCL1JGCd3JHzkjeCfWNoXtnRkiXoMo0dx7sWxYO154YLKRaamWMpvN7s
         fd5kXinD1Yc+c04ERkZouEfTu1HSfOSgUQiw0FYhqd5NvcoQTpd+Tz4HFBoXFIMLJUpR
         a/6b4gSCnMTwo5skU2Ruq5pW0UUIeryAWiEvRESLb6uy23SZZqrr10OaDGd8bSxRznFY
         iBxaprUNf5ux33kKvl0Ju5yQ+GhJlJPiKj8Yr2cIEsgkMrMh0rw4bz+RmDammauEXi9K
         VVQQ==
X-Gm-Message-State: AOJu0YyxyDXzjxqHQ0kvq3HhoGwDXPpq6qJypIc/tTcfCECsWBW6JcsK
	+9ckQEfpNVHMbVcqqqUQtYioyONshwhpSlcFTABT8y8eglNcn41//tio
X-Gm-Gg: ATEYQzx6Q955kUl59bPr/uj2kSCPSm44GINH/6hXrxy6SkSPTQkDMzj6bwQDZLrOF1M
	6rtQfQHUcSRiy1ldAnaX+QbbicfrlDR48rcLCbRp6ySo/SsFot/UdnATGARLXV5EDnIyupyWFXa
	Zbm8ReR4tTay5t4IUgstIF1Pqa32RdTtu5RdJTI93oX+iZitu2dmCvgftL2LaRlL+T4GZGPpPKu
	F2ogkKCbStM7ZaKAk6xhYQ8GMfEqH20GVN0zptHW+2WdnLYgkqAQdekezAgALkY28ScNuf5hSn0
	6t8jxPMqNNQPpFHoY7rX8inj9klUuvd8/o4ZRr+TF59LkI7bC33QF7jPh8xCDbsxWyjVMMLtUeQ
	xBnU5wQ/v3JNDQ6x6STTrnTxCg00TBvEBhD2JnrPptOLD+0LStDoQyt+SU4u/DfyLJTbZAkqHQ2
	F68HwM5vU+ulKmpeDRxRc6V9r1DBfBv/HKi+SOIragjepHkOk37NPZ2og2Z4KhJtOoaxGt
X-Received: by 2002:a17:90b:4b8f:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-35965ccf181mr2879013a91.20.1772206015655;
        Fri, 27 Feb 2026 07:26:55 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:55 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
Date: Fri, 27 Feb 2026 23:26:23 +0800
Message-Id: <20260227152624.164964-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227152624.164964-1-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261894-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E59981B9C80
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
expand to empty do-while loops. This causes variables used solely
within these calls to appear unused, triggering -Wunused-variable
warnings.

Instead of marking every affected variable with __maybe_unused,
update the dfprintk and dfprintk_rcu stubs to use no_printk().
This allows the compiler to see the variables and perform type
checking without emitting any code, thus silencing the warnings
globally for these macros.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 include/linux/sunrpc/debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index eb4bd62df319..55c54df8bc7d 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -52,8 +52,8 @@ do {									\
 # define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
+# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 # define RPC_IFDEBUG(x)
 #endif
 
-- 
2.34.1


