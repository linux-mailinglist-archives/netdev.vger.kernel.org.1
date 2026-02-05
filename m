Return-Path: <netdev+bounces-257261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCFsOhjShGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFCF5DD2
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44CC0300158D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3843CEFE;
	Thu,  5 Feb 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZW++YAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB43A0B15
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312210; cv=none; b=GDkOwxICu2MRBIU7YOryizhS4hkNLxi3F6CvPlK2SmtTpDfUGYNVut2MhTTOh/tuFYAOiZhSc8S4Va+s1ArFBprpMi7ojo2hiyQWNaw74AsTHgmeS6V97A8K7N2mc7mOLFfpiKBD2NM0HY7h5JmEakuWUcJjyMrvy6QfNLLU61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312210; c=relaxed/simple;
	bh=IIn3uaeCxcPp/5+0kpXP9/e64YESCdwAQ/3PXIdDHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOeFS8WPw9Fv/cteQVHwuqidJ52mR9Ls3EhKtQ3dyVFXZoypa/uX3cqZDY3hU6ry7gtgjVS0EB2TaEcjsYhIqZQd6m6o8hQ/Mgh145jAWi4oEQhaNUvQrVa3F9+oWLCHy+EWz//fC1f/4mMVwnMHwqt20TxT4bt5jzjUk0aKYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZW++YAA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4e36512aso1383982b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312210; x=1770917010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=KZW++YAAXx6E539ie9dkvNUAl3uHnAxxJNsEpUkKn2hxl8hBGdGxnEel7lwl2cTk6J
         oBlC/zfpKHRVll7cOr4RGDCF1lRfI92zfSt6Ytyx53qutste+NIDltqzbDPTcNRRDTeR
         OdNfRIHrvwocg9qzjhgiRsBaj/S1l96Yhpeu6s8m4P3+IiCQh+R2fLwNb0ivdm2metS/
         IPGP8OBiboGZHTtvaPUq+BzXf0UrHKMa+/P0u2KzGaGyMpqgSIM2osmsf2Ui7tMcQOsK
         jwS2fbCmPZ7qkQjJM7i/aDaY8XTOMI6m2UREIfcSYJjr/ngLv62z6Qva9VMRK087qgS1
         Gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312210; x=1770917010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=t+Ao5esfALLMDguasmRj0VJgach/pmFhwXNQ7ZBKzoyTbceuvh82MPdwG8U12c/oMv
         jPXaMeYEWlL5JHyqVH5yO7mz3J0FPPF2VQqJ6987uuN9o9LPCVVhSkVz/p71snPR/srk
         89Nywh+UhCCSQjEZghn89dozxdlpdkyOFcHnvYXq8ipF4O7kmgmfDpuQfvtjj+YjI6jD
         9iKgB6IPx42gpOtFzKLNXNLYtrDX0hJa74SMhpx9+awNrd2ACJ06bX+7p3hcPGecnhXt
         I3BK4svMJH8679S+1NWFVKdjxJv63qzqTbX4eHl3KhKyN1lHoF4g5Dhnhp0L+7wi0XK9
         /ndg==
X-Forwarded-Encrypted: i=1; AJvYcCUSg67ewEjUpV7qSt5C2netxAAusIv6KIyqBVmHvOMem5L2SE0amcs9BAD0EHaNS8YShqmc3N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLhPDNPrqhaJ6jtezrHi+Q3xmPEUb2OSOeXWmdVmoO43HLykC
	xS1ufXUUz2VKibDavw/vKq0/7QckpDNdiPVw17jIS4a7SeCYHMD+FduVlpCQEQ==
X-Gm-Gg: AZuq6aJRP/opIvznGEf9L1o2QWop3V4aJQ3yXPivIPsfU89ud8zaOYaxRPTfx46MDNp
	pOzB/CSTmQbv+TvEpTed04QFtSpoL1o5AYGN6pOVW5BbR7jxbrfH4C8+XZ82WrgcBcw4TGR2L4V
	w0n1aDyUfWYcAlPwVMeIl22Jf/FcD4w/Ab2HPYWXPup4CjHCqHYWDc7cus4BXW2zEiyr2VWmjXO
	l/LGSBuMIOcsgE7xgAXCqYZKchR997Yjwb+Jsjih5bIBAE0oFczQAC67b2Ekjg5UPwmmmHGllLP
	Nj87/LWZBAMwn89TrCs89b3TsTHljM4TxavEjYXYkNmFgqARsWV7V2JY7RyPqD3lN8izyA1TLYQ
	CIN4kvrHPCOzxMjEB1sIFu4kDHF9jGZTTli2M7WtYuDljR1t/t+izGCK2p55QZWIdRwT0Y+zuDI
	xnYi1VijrV2eWbuqfVhSuxsQ==
X-Received: by 2002:a05:6a21:a8d:b0:38e:9cc5:217e with SMTP id adf61e73a8af0-393ad005985mr117777637.32.1770312210076;
        Thu, 05 Feb 2026 09:23:30 -0800 (PST)
Received: from mint.. ([106.205.245.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e5f98sm29117a12.17.2026.02.05.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:23:29 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH v3 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 22:53:12 +0530
Message-ID: <20260205172313.16652-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BFCF5DD2
X-Rspamd-Action: no action

From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


