Return-Path: <netdev+bounces-187340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A62AA6771
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB11750F6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C142263C73;
	Thu,  1 May 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLn2M6h6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0F264A90
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142227; cv=none; b=nSktQ8cwlIoFeaDe32/lxdRRRRN/MK0hd6+0X1ECg8GYusX/CZ4SziaFVR38SazqK5gDabp+W92C5H93jFIaUl4/GGI152s8MuISVPoZFInHZHHyOIolw2wRWsQYMzWZPGOVK0JhZQvWP7xZtf/+iXfHbyxlJj8qzaLUS5zt1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142227; c=relaxed/simple;
	bh=G75I0cxvs4HkQDCsvPtUoWLeak41XZVFeQZLiUExNWg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvjDfSPIIi06Zr7wUl2MbCKDnnzFdrU0DMgJ6iMFBDSTptSAEBwm7aArV1bgD8NWj6Zdc7qXQ3VHsID4VgMO+skgQE+myLOEShM64M5UHkLZuVBrngcGTiEAkryD60/swznSzBuBeEsy0aEznfjRtsUrQC18Bg+dt3Ha7heXWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLn2M6h6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso23139345ad.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142225; x=1746747025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRDOYGtfkTG5fBwslvcLzhcA2F/QzUO3CinWUE7wfgQ=;
        b=VLn2M6h6jmmbcNfH64SkmnJ41hyvWsbLbBE5IgoO1VnrDnqsHdie/DdvKyKpwlI1Bt
         SkJPD5XUYJIHJGQGQt+3JvWnL27erhb3lOd6u2IpgmAFa/QubvZ0PQUz/EWgPyVe9zm+
         oJQc+QZM2Qk5Hmd1K+Z7lyrHv0Ci/kDUvDlpbasUhFxnOfoB3DcTBw/Z9sO8UkDSUE9s
         dBwH77R4Z/KhMbIJixXzqt0zwpWjWARYu/8Z5ScBbTlsu71f0I/wNt4Vkv+ueufI7TtF
         ZGAi9l1LlK+TaYLaDTJGo52jhQB1Gvr735z8L7qWFsEo4xNUBiqTbTz6Y/7Zk7YjTq/8
         a/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142225; x=1746747025;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRDOYGtfkTG5fBwslvcLzhcA2F/QzUO3CinWUE7wfgQ=;
        b=d6xlwEkauSX/HKLg6vmZ/mWa8MWALMCmBudS/VU8N1v3wNn2iYgaxkYBb7ydlA53P3
         Itz3PyWexIaKAIXjppBmJtPIDmGRSr8urLdAwHgDSqNTeZN86lglIAUskRRPlcZYP2k+
         nPxH2J8IGKUMNVVG2U5yxK6vyUdPnthCjDFwvuYMicc/GhvUQ448aquHfwK/sWP8SGRf
         KaX/FPfnLHvEcH6PTWx+XXLVnWWy/0pd0RFTspy//XVg4GY6Byo6VwU1OUGpSRCSn4m8
         wgxZXlYxRZ7QdoGSG92/7uAmj6OVaWmPpxeZrVwtuDyfGu9cqfIhDrf269LLGInKMTKE
         Mqaw==
X-Gm-Message-State: AOJu0YyI8vz6Ivqy5LZCMV53gOEPf6z+4U+oT0cu7u2I31RZiPZ+Smma
	ymDBXzcMKT7Ck09w8rd1rkXyOEKazpqnW+K6dt9Nl2whBtrSyzMK
X-Gm-Gg: ASbGnct0QA+U9JQ1ntGR4wZjvQQGeluzsocanPeoI4aH9/CetVrEEQjQSrqZ/V53z/3
	kBwTaoCCV1nsKBvsve2fC2zyqmU7WI2zklzhVDehbrtOHw7qybohLk2mYk/jpAZOqOxjsY3lSiG
	beducr0YJXN/rLxqGLoGhX+Y1bVb/BuBVSyyUrM8KQBwuLmURmRD3J+57kjqlsHK5K7iVEtvHN6
	1v0W/ga/Iqmt6WiiqGaMF568VlGNKsbglf1GJAKYvh8y8i5o+S1JFnGyIdclMfwPmt9yk3/xckA
	rjwrhTcQ3ohUCVozkDTr8PkFEajm+5bE7cd4XM0D1wMLLGIMccceME7ukpGRs7FtnCsMORz97jE
	=
X-Google-Smtp-Source: AGHT+IHg3x+Msxph35/sl+xXqKWSOCAzmRyIziozRjS0ZDBSKFE4VzDsRS3cz04aiIx7ll+OgPe0fg==
X-Received: by 2002:a17:903:198c:b0:224:b60:3ce0 with SMTP id d9443c01a7336-22e1031141dmr13260555ad.5.1746142224970;
        Thu, 01 May 2025 16:30:24 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094063bsm1917605ad.248.2025.05.01.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:30:24 -0700 (PDT)
Subject: [net PATCH 5/6] fbnic: Cleanup handling of completions
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:30:22 -0700
Message-ID: 
 <174614222289.126317.15583861344398410489.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

There was an issue in that if we were to shutdown we could be left with
a completion in flight as the mailbox went away. To address that I have
added an fbnic_mbx_evict_all_cmpl function that is meant to essentially
create a "broken pipe" type response so that all callers will receive an
error indicating that the connection has been broken as a result of us
shutting down the mailbox.

In addition the naming was inconsistent between the creation and clearing
of completions. Since the cmpl seems to be the common suffix to use for the
handling of cmpl_data I went through and renamed fbnic_fw_clear_compl to
fbnic_fw_clear_cmpl.

Fixes: 378e5cc1c6c6 ("eth: fbnic: hwmon: Add completion infrastructure for firmware requests")

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   22 +++++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |    2 +-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d019191d6ae9..efc0176f1a9a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -928,6 +928,23 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	return attempts ? 0 : -ETIMEDOUT;
 }
 
+static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)
+{
+	cmpl_data->result = -EPIPE;
+	complete(&cmpl_data->done);
+}
+
+static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_completion *cmpl_data;
+
+	cmpl_data = fbd->cmpl_data;
+	if (cmpl_data)
+		__fbnic_fw_evict_cmpl(cmpl_data);
+
+	memset(&fbd->cmpl_data, 0, sizeof(fbd->cmpl_data));
+}
+
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 {
 	unsigned long timeout = jiffies + 10 * HZ + 1;
@@ -945,6 +962,9 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 	/* Read tail to determine the last tail state for the ring */
 	tail = tx_mbx->tail;
 
+	/* Flush any completions as we are no longer processing Rx */
+	fbnic_mbx_evict_all_cmpl(fbd);
+
 	spin_unlock_irq(&fbd->fw_tx_lock);
 
 	/* Give firmware time to process packet,
@@ -983,7 +1003,7 @@ void fbnic_fw_init_cmpl(struct fbnic_fw_completion *fw_cmpl,
 	kref_init(&fw_cmpl->ref_count);
 }
 
-void fbnic_fw_clear_compl(struct fbnic_dev *fbd)
+void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd)
 {
 	unsigned long flags;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index a3618e7826c2..2d5e0ff1982c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -69,7 +69,7 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
 			u32 msg_type);
-void fbnic_fw_clear_compl(struct fbnic_dev *fbd);
+void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index dde4a37116e2..7e54f82535f6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -744,7 +744,7 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 
 	*val = *sensor;
 exit_cleanup:
-	fbnic_fw_clear_compl(fbd);
+	fbnic_fw_clear_cmpl(fbd);
 exit_free:
 	fbnic_fw_put_cmpl(fw_cmpl);
 



