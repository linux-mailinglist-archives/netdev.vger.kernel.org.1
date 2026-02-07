Return-Path: <netdev+bounces-257708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKSoIEurhmlUPwQAu9opvQ
	(envelope-from <netdev+bounces-257708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:02:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA1104BC8
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EF39300B46A
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F533064C;
	Sat,  7 Feb 2026 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcCFcFOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C61D88AC
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433352; cv=none; b=QT3+aGoE4XwGqctBqb6Vzw4vksdvH8Tcw1+41S6GYg9RoacMq05+V/rchzQH5XXpkEBZgr6kXNLn7AZpUVQe6G2FN2DZj64I9sSIWFUgHSVLRAaSefNl71zxxzjxoHxZMSP7byN0i2qwJTaeb/N5i0YnyF/SPq9LD4qRMEGr70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433352; c=relaxed/simple;
	bh=qx1Jl8fKbXVfQo+2LlM1C8vtQEmuPtK1SLpDqKvAMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHUd0Or7QthSpcAjkV5SeIxVbSgbxLj+9ebIOjIg5k8H5s+tjp0Y6B/rQrdACNY78Bx27zkZ5eUjsmgirYBScXW4DgeeIQXRR1Nc0LPC0rwxu8k1Ld7V04Eso2mnvOQTe7YHjbEqMU3aTrRWaZFZl19yCPog6uNr+NlZ3huavTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcCFcFOt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2405133a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 19:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770433350; x=1771038150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=bcCFcFOtGamqQqH0ky/ClWlR4GMp5nXNkrYPTwFGv8ZzzEOBP8e/uIPazdVquf4EPG
         3nTY4pEbvGHz+8OV4dXIqV+JKyHXeIiRjaey17BcLSDg4bbKwvUo9WkTqVX2cblAU6nZ
         Ekgt6C9aJEXldCoC9//vS5mqENbCGGHSUTVQg247ZhZQ50xOjFTiHxknl8UQ9HXy/AbW
         Ohl76PAFUNzULbx/soYfIRxvmhvbzblVEtw/EAz/vgsH9WntDunyE4DL9ZarhIlGlcIZ
         HkIy8/bMutviLdICz+OiW35G3AMbZNd4idrhqvdxWJZ9hYDII4cD/EIZEcK7KoC+NycI
         7GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770433350; x=1771038150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=D2RxBDmxOB0GIicWSaLN1NIK7/zQePlhV6mXx4NcCmDa+ZDEz3FpMn44CzQJZ19Upj
         7giaXf2IY8ORSviIu6KSdvQBqV6s5w/E0IJbwasAnibF8ub2U7kzcUfvn+DqiXHhtb77
         VRnYUijx5qEXX2zBOo22b0nHYCMUaDd3naqemBFxtdZ68BHBx2vJ8MLMYbT/s1TudzBv
         YP69vquIIz9jJjPiwRTRm6qB9e8C2i0sTE1RoPRblfTVL3qMhnhttk11F1nwSts1NYyH
         juHYTq5cijXWuDYQHFL4ulPzbgpOfrWvYnqJ1ObkaIhICZuuBfc/W3wBv11umLNFw5GZ
         C+0Q==
X-Gm-Message-State: AOJu0YyoHoeB14t9M6bLOz1hYnGAbOIN0hyUiY08Yo1RGzXgdlKRaaUi
	dd3phmm5fO+8lzjE+ryhx5BNq1aLbaGrQeuOUohKbndkOJ4sjlI09YVKvrdUvt1/
X-Gm-Gg: AZuq6aJMEEeAazRaHmlgPEgvspQzR+EuF2t6U5SXhjhmrgTHijNrH4n3VNa6ddQ+aD1
	LNMx78qEwxPhQlnmLcpYME63TWFrIiQr5OHw8D9d/OedI1D+kJTZ5nYWCwPpjf6FSVKMZOBgSxK
	D3060DdsybUBAuniU5u0dzVBeaS+6ov1jzAiJ3/kCLl+H0rHFmG1M5QHY99Yqmso6F34X2f1h6Z
	r3mB+WJ0CklkOrfnf9NMpMxynZmRq7YjiarwEnBhE1MZL+nV0RSxav8xvAkyogs9TishImuYMn7
	lXsmyHVMbf8tCdVYwgWa0ey4/DZ3lUyyYwv7KzfXQ1Icug+EYhZFiR6AI8LvePxqVR5OoToMfjt
	j9Lgcov4wqIf0yuH6Ih7VmEEpe88WsEI6qKzVl8JaRwSnptcis55MnZkn+9E4PnC5PLRz/Icmgc
	Kkt+hGyk49
X-Received: by 2002:a05:6000:603:b0:436:19b1:c15a with SMTP id ffacd0b85a97d-4362933faadmr7048305f8f.21.1770428309770;
        Fri, 06 Feb 2026 17:38:29 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b34d2sm10351343f8f.1.2026.02.06.17.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:38:29 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 2/5] net: ethtool: Update doc for tunable
Date: Fri,  6 Feb 2026 17:38:26 -0800
Message-ID: <20260207013826.4030161-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAAA1104BC8
X-Rspamd-Action: no action

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3


