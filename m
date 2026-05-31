Return-Path: <netdev+bounces-293408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hg/BsMvHGqDLQkAu9opvQ
	(envelope-from <netdev+bounces-293408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CC6162DD
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CFB301F98D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FF344DB9;
	Sun, 31 May 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efJ8OV15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E5215075
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780232083; cv=none; b=lpR8NV+bNE60B4qAN6t4thcVYEZPVuzQHHB26NArFXcD918WO60VD04zOHbKq4tsq3oZRa5e/cl9uKS3Bxq/nUY0QNdBMYiE7Gi9PSx39RaIJ5lr35y2RIVeeIe4RGzuMC0dnrZ0A4+q5RslWMoVal4cigb3FJX5d/7wpb3Y+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780232083; c=relaxed/simple;
	bh=91dAAKwKNToHslYj0nEZb0ypxjDjiWcPAE0+mi0F7l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SEjg6GHDOU7HVknlk+Z0TmDyfJqOx2UOncJiSxv+cv1+vg6NEvmN5IkeNCAYyQNx1O4hE471zoR1QIIU7+i4T6L1l/lBzdTdI1rFG/YIEWBH1h30R9AjYjoJCHoQPW3wlRz4Qkp2tGUyZNDA7/7JwyMsXhM9imbxgtmut2j+6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efJ8OV15; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so278102a91.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780232081; x=1780836881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7PC0ftFSwZs0M7V53XHcTVYt3t+DFZQ2Iz/r+Z4hRs=;
        b=efJ8OV15IEhXMpMYP/P7pjtvasj6jVDfMrYE+mZxed9d0zq5AmzmsBjX5fKTwY+ZG8
         /WMmJ5A8/NDn6315MnmYioC7Tp61ZrlXKPvDLngKXW0YhobhCghzJp0qOLO3XeElONCa
         ly1jRWCWG6Gl9v2PUvM32vmH/e05bfWn+pZjGwyVvQiz312rddwmBmhwRCuSeT95suzo
         aaAW0adqX0eXZKUgAv7CMvG7BfVba9uQb+Xy88mpxeiISu2jT8EZ7CJObMisPB01tsjb
         tibSgMEKytAMujkCjKCC1dHfInVP3nOd3eZbe0mwxHbs+3rmUKOn0Z01SrL6uchP8LjM
         vPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780232081; x=1780836881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7PC0ftFSwZs0M7V53XHcTVYt3t+DFZQ2Iz/r+Z4hRs=;
        b=nmyLLok/TMVNw/i8VEC09m33fXmoldueb5EKWs5q/o+XMTeKHRPBcwxlVd1J1DZGyR
         Jbuk7LbP6yYgzb0hzt/TtRAKXCItNsa+9tCImjkiZfBKf3OieGo35HKD+lMtshtu4DEj
         asC8MMpPvx+ikHxI/ME/sptv8bDn3dAyqVUiD+XuLNH+icf4Z3iHylfKlwObtTHyIgRL
         9Kt/HumD/GvA0Wba3th3lqTsfys2vB2UqnTWkV491Zv6JkcDlqMTVUErXCNPb4pViQha
         hx+KGLp6NRaDDDd/yZ6lSxOKZ45shVCtQzt7mVa+y4TLIQsES1tkRFVJ4IGMGz1qgXpo
         sh1Q==
X-Gm-Message-State: AOJu0Yxqj0bCM77dVjZaxKv4pRNh1RnbIDeTwvLZ0S7VUOWuYWgG5Y8r
	kjV2hlqLRmN2SZpTMt+NnNwm/ySIGn3lDI5A5MRRPxVhSIa7nJUTqCkqIKE+55O2B9k=
X-Gm-Gg: Acq92OFmQLz3pnj1Vbj3nj+XzoSzwAQmmUBdzfi6HkOo5rswYcAwr/EtCU/MpEl868G
	CnBHpB66r10d2CHPPo7sNt58UICb1bWMPJx00/d+uJlLmn7rD2L+LyltrZDAzMSGzs8xqx8TK70
	vAG+mfyQcg10BsNqO4wX5ivIc5/c7u6RNuAEZe/z2aBIVzrxudFr3Zc6QdiYEGTBkOQyrKLt0Z2
	guSC89I9H0hss4eS2dF0haaogJTg/P8jAGlpqLvXQr8Jmgm6f4MAsPWpdRP+4CJXKkqUbCcAhyp
	35WUBpCS0ney1zNDOLXol7rbdkNl5AIJdvQ0TDMdfgstHrbRjgih/2kz8TyqTSSMzkkCY0LgK1H
	TLTnrzqdgyujwhI8a+eU0b1agNLLv0oZdHgd9GqgiJ0aGXE0UjhpHGN6EmkTlIUJleRn1nLaaCM
	k2Wai9XJodNEyg1HkmdTGQF6JqFIcNlpe72IAALcd+takNdbwIcQ==
X-Received: by 2002:a17:90b:5184:b0:369:971:4888 with SMTP id 98e67ed59e1d1-36c501c74edmr5952856a91.15.1780232081284;
        Sun, 31 May 2026 05:54:41 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:7f12:602a:a4c6:2b38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfec391bsm7766670a91.2.2026.05.31.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:54:40 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next 0/2] net/sched: sch_fq_pie: add per-flow class statistics
Date: Sun, 31 May 2026 18:23:12 +0530
Message-Id: <20260531125314.22492-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-293408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B66CC6162DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 FQ-PIE runs an independent PIE controller per flow but exposes no
 per-flow statistics. This series wires up fq_pie_class_ops to expose
 per-flow AQM state (prob, delay, deficit, avg_dq_rate) 
 via 'tc -s class show', following the same pattern as FQ-CoDel.

Hemendra M. Naik (2):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test

 include/uapi/linux/pkt_sched.h                |  29 +++-
 net/sched/sch_fq_pie.c                        | 131 ++++++++++++++++--
 tools/include/uapi/linux/pkt_sched.h          |   4 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |  22 +++
 4 files changed, 168 insertions(+), 18 deletions(-)

-- 
2.34.1


