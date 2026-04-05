Return-Path: <netdev+bounces-275492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lYiXJyfg0mnPbwcAu9opvQ
	(envelope-from <netdev+bounces-275492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 00:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B039FF78
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 00:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DCB3006B34
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD83612C7;
	Sun,  5 Apr 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvE6F74a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881726ED37
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775427619; cv=none; b=qJXs1yb4z41wKCkefigmTGXT++EcrqGDCL7/21zmL5xMjS4C6xSMI/jKlL1ZYCh45K6HgwFs+OePrAfwDWs33SJraUHgGctyqT1ZAxP45h03mvev6ONuQPTjQiq34Od23pPn+i8B0ZxOPMHliuKGWMG9F3zsW5lGBL2GqQNDilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775427619; c=relaxed/simple;
	bh=6r99neyde3b0isfHa5GQwCkPtLceRO7kB6KTmuQSUL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5+NV1qDbz05oM/PpjjAZBVtkc5fmUF1BY1sB7KVTC9X5CymHP/EgfTWJs0YPVT0LnvvN260lhxLUDARW4WXDu0cIaVGMVD27/hAKbyA0hBTwJQ68R9kzsxUIi+88sauUnL7fBKY63KGLqZJBUx/TsWVLbfGcDcHenlCF3G29+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvE6F74a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so13809165e9.2
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775427617; x=1776032417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYtvotg7WC0VoukV+5DSJczX5Hfpm/Wf8rZ92IGGmqM=;
        b=GvE6F74aXbCJmrkEbq0ZwuAj8jigxOq4W305hjGyqAuwzgTVoOOK0G28jRrqzVwbRS
         20UnR0jTgPwOv0rajBVFT1W13MHmsukSk4NnFFuLr6bpuRCPDu/jtOZTfG1yRcNFCESr
         R08VGZ9LuegZlZqEsjgjtDBzMXOVye8cn0q1z9VTgSVVXhCydpxixdxGiQl4PsxEEnvH
         oNB4k67fyjUId7H/Jf2bJxVx6ADWmNkYYpcEPmCIFzEtRfKSorv4bgPoPqscq2KQJOdd
         h5hbkDjpLyYkhhiMARsECfBD8gqBGNFSYpVKI6SHumFpOhiUSgaa6+UZgh+kHbqJ0lXE
         1a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775427617; x=1776032417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYtvotg7WC0VoukV+5DSJczX5Hfpm/Wf8rZ92IGGmqM=;
        b=cTUh27NYISQEokdZejgosPIiGNosnFIZXonsbvAK8znTOdZzZF38COAF7CX2HMz6CJ
         Lu9ebxGKREpD8moMM56ixQ1LTnCChpNhzPTCMRcPihM7DP3CpzSNdkdAYwF85x2XPWnp
         zNAEuS/oQ1j+CzOvIkQ+11Tyz4UxVlIVeTAp9wb0BjbCo+6Prp9C3Jzw4cU4EyfZPEAy
         NhmSubXgYpZbGPFecq3Inlc6R0pMXIoG02QtVBXIpjmcXQkEsfjY8VeLleOj0czC+kiG
         suSPXK3+JHw1+5/FDcPZI1G7b3St7tnQuXlO0u9ZJdAvr+aF1f+4jA8r4akIj5j4TOdq
         7Xtg==
X-Forwarded-Encrypted: i=1; AJvYcCWTytZvUmZJeStLhhd61WeepGqd7MrTmAb2UhX6qAbC9GtaGDAJpO9ZIPTKU6ofZAfkuiqRxdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygjfUDqFz+j2qIMv2ScMdnnI6TpJANRkF0rcYfe0VZT7duZZsm
	njbQdPdV4od9Lmh3SiXKQ4LKpcjSubE7tu78bYS/HnKXZ5Ar37txdjOj
X-Gm-Gg: AeBDietwUED95PqPMge1ZDzn6ut7Pq8FRZKfctYQgtiO5+TzeW/vqQzwD5PImDF6+40
	OLPuKnzHkDxElVC+JSMclS+jC/+Lv4iLm93Adae+PblVxMNiY1ExC2p4MFeLNwUU/db1+Xe35Xy
	/NT+E+xLouqIx30aTTukFdMFNzvPxBuPR2hTvPurKfVP79BnK4TVrNmaH/vP+afCntTH79ae9YN
	GIx8pRrYHTPPAqM9Pqjrdwh1uxXaLKtFmDvi2qIo9TeHQqIKPBHqduiZ0ax4BToWbre9xhBZcPq
	2b53Nl94cUMZJIyianBPw33JA0AmjUyw7BpfezGuxmGmimfFJkvbggtFaSnyPy5DwgtlVEbGqXd
	06YHm6RqmXIROYwCs8pHCckkSXXu4si0g5XhCt4A8LinznXtPOyov3YJCFOgpmLxBlvNVSzN0W/
	hdc2j5tUlxbGP53CBPvnYMPQD9
X-Received: by 2002:a05:600c:4ec7:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-488997ebfbamr136868985e9.28.1775427616390;
        Sun, 05 Apr 2026 15:20:16 -0700 (PDT)
Received: from rpi5.lan ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm413182325e9.5.2026.04.05.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 15:20:15 -0700 (PDT)
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: txgbe: leave space for null terminators on property_entry
Date: Sun,  5 Apr 2026 23:20:13 +0100
Message-ID: <20260405222013.5347-1-fabio.baltieri@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275492-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabiobaltieri@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB4B039FF78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lists of struct property_entry are supposed to be terminated with an
empty property, this driver currently seems to be allocating exactly the
amount of entry used.

Change the struct definition to leave an extra element for all
property_entry.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---

Hi, bumped into this while studying the code, looks like the struct has
been allocated without space for terminators, guess the top ones just
end up using the bottom props as well but I'm surprised this does not
crash at some point. Build test only, don't have any hardware for this,
let me know if I'm missing something here.

Cheers,
Fabio

 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 82433e9cb0e3..6b05f32b4a01 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -424,10 +424,10 @@ struct txgbe_nodes {
 	char i2c_name[32];
 	char sfp_name[32];
 	char phylink_name[32];
-	struct property_entry gpio_props[1];
-	struct property_entry i2c_props[3];
-	struct property_entry sfp_props[8];
-	struct property_entry phylink_props[2];
+	struct property_entry gpio_props[2];
+	struct property_entry i2c_props[4];
+	struct property_entry sfp_props[9];
+	struct property_entry phylink_props[3];
 	struct software_node_ref_args i2c_ref[1];
 	struct software_node_ref_args gpio0_ref[1];
 	struct software_node_ref_args gpio1_ref[1];
-- 
2.47.3


