Return-Path: <netdev+bounces-118312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B259513A6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CAD1C2143B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803744D8BA;
	Wed, 14 Aug 2024 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5i3UmOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D0365
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611368; cv=none; b=mPr45GqYj1U6BdN9W+batVRBfvYA7FFF42vAPS3hGNwKEgAUe0updcG2c1/EA39+Ic/hXYT4/ZPwgK11d9N2/02tqZFCEPK4EMVBVhm6T4cxx1s3xGQb/SLbszQBuzgGTnV931GY+l7oe1ERD1c+SW9tJgeDxPmNHlbi5UxgHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611368; c=relaxed/simple;
	bh=fQ+4wQjUSOIMUBzoFT+7LRlptZG/eGNKq3eM0Uk2564=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T5MHbDqYCOJsl7dxDydOMeg8cUf5f4mBNlUtgHlqVadRUNowvne78kkfKEu6o1nyOCPzk4Ww8sG/OKZKu/o39Hk7Veto+yH4Z+D0DYb5qAHY6PtoN07dvRmsbjpuCW5JV/9nB5s970vPTpHfHRYPhvcmOV0r4JoLEpwXeJPBFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5i3UmOL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so131101707b3.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723611366; x=1724216166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
        b=N5i3UmOLC0p2KSg28h3iiRhV/p+aNeqtrCXY/GO2g+0lftx6s5VmIDf2SB+dtczuTV
         Qt40UZkYrXLpgtP9nGT7oaApSqjrR51PNZVJZ4v2Z7NEce+JX+z8sRZHtdatrbuY95fC
         j+wnwjAwmPOy5J9bF6grb4X5w1DgzSPg4z43RYcsCFHWffo14DqMzBxaow/BSfP1U0Zd
         MZ3kNZK+9G5BMAnHpbGPx4OtuW8r/AgZZOZ2oPODoelEkQuBBpEoKMdySYnGR9VQy1zs
         Rlaf+Z4ugArdCWqMos5BLLnC1XqcGlgs2/lp+AxGcpQWsgYmA7l1fKxpu4IZQ5bdyIAr
         rrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723611366; x=1724216166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
        b=iBCATZfQoGXLgqnALkQ6sOu1mvT4jraDv0wbfTJoGpCwsbihaiC/G4B84ZelpmihCj
         4JfdfT2Lj0l73KE49VFRepgzGrnQr2bOTpJrU8DOdXH7DTpSBN2k+2Wo0tu+GFdw5ykl
         vO6V7DS4DJ7PPr80hAiViQxptR6ts0gu7GcPPmJJ1s5by/MblCCUOko8XWY0zI65OeHF
         giDqJuKwUAOWKg1fj6jQfRpKS1pZRvJnehe5yCJGQvITGsIGBOcWL3oceItWRNeq68z+
         3GJq9XtkKJ1dZaPrRfINJDnZDc5vTFuTfAHi5JnRhfy2f9dsxHbStT2FBtQCDvRTG6FL
         qiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLoYbk8w0hhsRsnE9mPAWV1zn60lkmp8eANLJSa/VwBFB2JK5MmRRmdOYHB/OhF7A2/lLPXb1Vokya8YRhPJ4a1G4DLFE0
X-Gm-Message-State: AOJu0YzEMXUeFanHujw8WDkLQPMf8rcQAXdk5Svmodti5aXW/B81hrSp
	9AHO6I0V1o3DZhZ1InAju85FnL3omE3lLCliIF9g9hHGqoOkf8gTm4HRk5TnocNBpOuT8Ul5ANy
	+yuOK4qEn
X-Google-Smtp-Source: AGHT+IG49Fx2xiRVWQlRuoz0zvxLK+LtnKos04NNqOiwZh05DlnfFBZtQGQFWYfG84ZKnZq//Q5fW+6FXooL0w==
X-Received: from ditto.mtv.corp.google.com ([2a00:79e0:2e0b:7:febd:a120:fb9c:be25])
 (user=daiweili job=sendgmr) by 2002:a25:d6d1:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e1155bca773mr2220276.10.1723611365685; Tue, 13 Aug 2024 21:56:05
 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:55:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814045553.947331-1-daiweili@google.com>
Subject: [PATCH iwl-net v3] igb: Fix not clearing TimeSync interrupts for 82580
From: Daiwei Li <daiweili@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: vinicius.gomes@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kurt@linutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, richardcochran@gmail.com, 
	sasha.neftin@intel.com, Daiwei Li <daiweili@google.com>
Content-Type: text/plain; charset="UTF-8"

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

Without this change, when running ptp4l with an Intel 82580 card,
I get the following output:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

This goes away with this change.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ada42ba63549..69d7e8b16437 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6984,9 +6984,19 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
-- 
2.46.0.76.ge559c4bf1a-goog


