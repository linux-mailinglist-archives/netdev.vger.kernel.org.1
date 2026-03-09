Return-Path: <netdev+bounces-265537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCZoAiLBrmmRIgIAu9opvQ
	(envelope-from <netdev+bounces-265537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:46:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD272391D7
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 505D8302512C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD03BD65D;
	Mon,  9 Mar 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxA47OZn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411803BE166
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060352; cv=none; b=R5Y6SKrlhcjTIyUJ18IDzdMYZm0LnU5qls2MhStFcOSa4wkdfGQL35Oi7iCZK47L77yCZP0/rjaTZsarX0uVWpR+7HZgr1QR1PwHZS14u2Wywzxttqin2kvnuweV8W8R3PjRq5rDzXTgdyn68UzRpfGwyfxvfpG3zhHSvksLJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060352; c=relaxed/simple;
	bh=tC/vnqhpyr5u7JUYEaBg+0egv5ZlzByVSdGqiOYaWxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML2CpkKeQ6GUEBteHd1tONorWZgtjwNnyrJSjvQABnogXXvDyVokXQDb+j2aQKlzbeJ+22TYZJQVBJNSXFBXIgTkvafqRERg6xd9e8NilKBax8PdCX08Fp36cVoVEy7NMCikeP5X9HQyBXEfAD0cUBGURPZ5m6oZjQ/Nt8aOXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxA47OZn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso7238835a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060350; x=1773665150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a80maZyNKc4ouURWN2d+H67wXFOguPB/alLVdRyxTyY=;
        b=mxA47OZnovcrdhYuZHUc9eAqPCKWiZU94Vuruij/dANKbefVWCGrARq3hvQzZ/CLQf
         FfUElz41O6/SFvUAordAGqd/01Str+AmA1EfyFs2o7+3aRNpvxOkNAQ/kP/p2Ye5fsw7
         vNgPEHLwoouBxagSn2mbW4a3NSVpQQsNO9ChHqhWERk/4rvw0vwmuGiFobPqHhwNiOti
         dZ6rpwzOp6Uklis9I5WcEYfs/toDF5FVNLnQ+JNp9Rs1FWGg0sHWzyh/ybemcHqGeEDz
         XgEAE6CIFxDcl2/5IVVmZ9btLM7tjkZG48qxvbNhJOsBZ8kUGPoMs3cvJxVNe7dwPml8
         QGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060350; x=1773665150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a80maZyNKc4ouURWN2d+H67wXFOguPB/alLVdRyxTyY=;
        b=IBkaGMm/Yabi1hHJ1ktCzTHeLIzISqc9LaUnvVsdpzB1AnEIKqov8mh2UIG5/hYiB3
         fJQER1XxISqsm/bGO4UOhFu8H+DMYdPb/7ANODyfnqM4IElJBC/VXSD/Xug24LJ/P+fm
         vfgmOKdXdiV4YURE4Yhv0rwZjO1WQOR7loix4T7r3njBz1e/4z7qiQbVY2Kw6Ue4LxUe
         exRJ9Awj2W0DolqK2h3k6lZhDpVriW3/ZaGSw2hQJIzlSf51kGPyDQX+ff9WQs7dATTS
         RqNTL7ZeBj+D44L9J2NN8P0TkG/ExACOI4NTGvZdQNqBWMbcfe75HblSVfFJGWnMG1xs
         JMvg==
X-Forwarded-Encrypted: i=1; AJvYcCWmdxqWVVtekGGoG8/AfTSUrWLYt2qtsMbxfZuINbVvpik9k6lZfwSj9XdlgoJSi8kfd44Ahl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VYYXSquqHPbHJYHe7e+MttjYi0pyIY4lXxd7ayewhhC0z4N4
	WyLnCd0XU3D681Cpt+T7jH4Qw/pKPGaPIO7T95SoWqvWSZjcPXhWwoiq
X-Gm-Gg: ATEYQzytsI6BqVOWlyBVV1mAM9wXd0M/NdvN0uzyrh3Iq14vP5UhVHgWNUXXhgmEZZD
	wCBwjhSEi2JUoYTwjvjlcDyciXjah3NGzLgtPKmm6iRXipeiRn6/z7sOaRVh/BYb0yhc6f6TOiO
	04dyFtclQFPVTJgp/X3Qc/BopKrRuC0HKhbbSe9CAgmnLY7TXI0e1kzvZ3eDcvhx+MV9Kq7VxjJ
	7hX5MlSgmqwFnLz21xrBD+aAZXkb0EKP7GetEK3BDInMTrLpsSSjn5dNxegpCxZjSmKZS8LqTJs
	jTZ90trp+pF6b+XRVlrS35ayXOMG56WUltaMcEc36a1Y1PJLMXZDju+M0102wt5mehBIsloGUdy
	gdlWt7te1VtiBiPWr/M/ljHW5Hyx+KLS/IDwk3D+8RcjlDVoS1J+4QMdxoxEIZqUbpTWbFcGeKF
	K0dSBNpkTrfyDIVneEtIrTgfV+gZj+VqjDn6thWMO4BUDqYf6fNVvclw9vqPTRR90gJGTBvIY=
X-Received: by 2002:a17:90b:51:b0:359:7b9a:2cf4 with SMTP id 98e67ed59e1d1-359be12f79amr10744481a91.0.1773060349682;
        Mon, 09 Mar 2026 05:45:49 -0700 (PDT)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e183596sm9178830a12.27.2026.03.09.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:45:49 -0700 (PDT)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 net-next 1/2] net/smc: fix indentation in smcr_buf_type section
Date: Mon,  9 Mar 2026 21:45:39 +0900
Message-ID: <20260309124541.22723-2-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309124541.22723-1-sawara04.o@gmail.com>
References: <20260309124541.22723-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBD272391D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265537-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kyoji Ogasawara <sawara04.o@gmail.com>

smcr_buf_type section used inconsistent indentation compared
with the rest of this document.

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 Documentation/networking/smc-sysctl.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 904a910f198e..17b8314c0e5e 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -23,17 +23,17 @@ autocorking_size - INTEGER
 	Default: 64K
 
 smcr_buf_type - INTEGER
-        Controls which type of sndbufs and RMBs to use in later newly created
-        SMC-R link group. Only for SMC-R.
+	Controls which type of sndbufs and RMBs to use in later newly created
+	SMC-R link group. Only for SMC-R.
 
-        Default: 0 (physically contiguous sndbufs and RMBs)
+	Default: 0 (physically contiguous sndbufs and RMBs)
 
-        Possible values:
+	Possible values:
 
-        - 0 - Use physically contiguous buffers
-        - 1 - Use virtually contiguous buffers
-        - 2 - Mixed use of the two types. Try physically contiguous buffers first.
-          If not available, use virtually contiguous buffers then.
+	- 0 - Use physically contiguous buffers
+	- 1 - Use virtually contiguous buffers
+	- 2 - Mixed use of the two types. Try physically contiguous buffers first.
+	  If not available, use virtually contiguous buffers then.
 
 smcr_testlink_time - INTEGER
 	How frequently SMC-R link sends out TEST_LINK LLC messages to confirm
-- 
2.43.0


