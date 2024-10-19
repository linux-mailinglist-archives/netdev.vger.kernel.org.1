Return-Path: <netdev+bounces-137188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CB9A4B51
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 07:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC711C212BC
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDC187848;
	Sat, 19 Oct 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="Cb1qTBbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A8EEB9
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729316220; cv=none; b=i2aRr3BM25AthC2Bhcy+6VTBFFoWTBGVLSl3xo0rDLpAiV+fDr5e2S6Mvobeprc4FY9cDTV6z+ALpHX1GoxxeDQCkt81OvlK3yfkRB/H8IBljYM3UQbu8tupYW95VL6ytWFZvK1mizw9pKbSvEzckz/OUcueXUkXkZawY9Atc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729316220; c=relaxed/simple;
	bh=S1PxwZrn7qHGDRfhZS3BcE39HVJJf/8ayElZRXlYghc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QKb7bOUsDl/LHsz8Pn/nw1oKYPjKBpplckGkG3tSN64ROf0JTidBRbIVwbin+ekLyQaYLWdXwlL45uPEUECBY25YfMLT58Hr60Dj6IFxzsX2303+QH4leRLbmplWBBUqv/JYc3gfFDTZqN/twZISyZgyFf7wcX5eI5fixI8icRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=Cb1qTBbq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso1974493a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 22:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1729316218; x=1729921018; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvyeG0sMGLIPDJGO5fTlUoNdyS3Nb/+jzs6l/Ql3K1U=;
        b=Cb1qTBbqH/+9XOpmMgLL02WuOQo9Bm9/9ITcBRDoE1LD/5twSfVO1r4M/ei8MD0cpS
         6YSlndXLXysp0nDVKkEIsm/ygIA142wniM2286hLQv82YWBIpIsDPcNhftWO19f7BEaG
         sp1+8/6yw9HMjcW5hUlpowOcOK7PNQFzkv5zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729316218; x=1729921018;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvyeG0sMGLIPDJGO5fTlUoNdyS3Nb/+jzs6l/Ql3K1U=;
        b=cwoqnhVYQPwgaS6jSZtgCge7IbBRLfswrY6J/qO55ymM0mBujwTtnOX9s+Qc33Za1C
         zV6qKXgKStO3aL8AN0P4Fq96piQHXhd5rX+Vo6vW43ev/4QfS+nYiILlZHbH9etCf5JR
         Aw9xuKeyhLNZs5K22kOTE5O3Zo0NrTqm0wXpBON9CN+b34QmYifQYMzQmTbQLQlNefTg
         D9SAZ/A6NGHj7mX3NDngi/lkUabc2mlDvdbooDxjUwxlfyYieF+xxaK1VVFfdnq2Zcn8
         R+92yYNefzFGL59SONg9JwhJV9cP6g7Z0LQEOwMWn/QgbrxPl9o+Kur27sjTeZywsOOd
         IHig==
X-Gm-Message-State: AOJu0YxfDFBU4fEkI+X0V2fqI5MTBuzqHjZ/uL9i5VwwvEYUOwU8Z2o2
	PeaOCMtcYaKLOS71dYeftqVIMi7+9lcLtm1x5GNs3rNhzw5bYnjxXqiRsVoGrT4=
X-Google-Smtp-Source: AGHT+IEt5HjmxdM79D9u6pDGmB8BmmjITVgsn3cTA5mvnMfSA50vSYGZj4YkEv3qeaDep5emWIB4bg==
X-Received: by 2002:a05:6300:668c:b0:1d9:dc8:b80d with SMTP id adf61e73a8af0-1d92cb56801mr6034991637.20.1729316218163;
        Fri, 18 Oct 2024 22:36:58 -0700 (PDT)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm2395825b3a.36.2024.10.18.22.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2024 22:36:57 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Sat, 19 Oct 2024 11:06:40 +0530
Message-Id: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index be5d02c..bcbbb9f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -351,7 +351,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -361,34 +362,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.7.4


