Return-Path: <netdev+bounces-117909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7AB94FC4B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CF528305A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D851BC44;
	Tue, 13 Aug 2024 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeUTW85U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A2156E4
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520114; cv=none; b=O7koHvzRM8ShS4FYdcdZR23i2p09ajT8jequ5TaRCXnJX/In0HxuwDQMTf3FCkEsOTsbbIxSCa9NtUJbEXpxvC4lhwWK0VTZUmk8I0n/97WCDI+J6GnYwDzR3wUoCH5LDZWMAJ9RRdkppzWYgt28EBoSZkstukWL8/gRslO0qME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520114; c=relaxed/simple;
	bh=sJKQoy6+oE4WtBPTTEDx58P7wilM7l9S2XXEzzSv4Dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=THlN0Ith6dVW+alb3jMsVmtGxumw9N0k9aeY4k2NqhoBar71OcUu59PfK8KVot6pH68kPncqjNeR888bwqA0u1gRAlyycr+P6evJikETEh3otKiWhDGEWfWEikOVjl6WlJRf6uNwWoh/+OYzUdBq7EwcBwqJPiK2Lk6Y5IvTXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeUTW85U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68d1d966ef7so110884297b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723520111; x=1724124911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZVaP6xD9yddT4PoUP0YnuaDHtRnkLTyw5E4hivsr/A=;
        b=NeUTW85UcKoum5MnhdzCQdWg5B+Ov5XNpRbgRX1WoQIMs75iNHHwhQEC3Hq3SCfSQK
         rBQx89Q9ZaD0YvLsjmAlF727UeTkcaaEeF+0SfNSJozk8bkUK/LMWJ6oQlJ8Y6MQx8O5
         6eDJqYqW6ZlG3LqlHBd1OcY6Zy2ibsZJVsPQ4TrARk8tH4kMpxWcEe4opWfN5jZNLsJY
         9gGYXE/LbCyxby6z8DZJ7XztszrVoW3fMaxhOC33JdXyK1NIlrJrNl0V9Z+oAugHlEHU
         PvHThcs9NY7TYVF7O8q0ocjSWv+5qrkc6g9MvUtaYVhk+5omaTaGW/hNRkIC/lYS/ZB3
         HT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520111; x=1724124911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZVaP6xD9yddT4PoUP0YnuaDHtRnkLTyw5E4hivsr/A=;
        b=I5As87nAYFCn5m3EP7jdTvujbJGPHTxAhYZBMquB7eoYmg/ZVVALmV2BTuRxalytl1
         vqqNqdh7+Hiuw5C7MLjd1YuukKzkUz9joKMo7V4xEdrrrIrWlaOYAWZYu6O+sB4rZ+iU
         xNOSQXBKPvIn1ejIzlEkGN99XvIH5ajeqOXdDn2C0Hu8zUIFkuSiXpO1GoHZ82DWki0u
         FDF4j+fiHPBkWobxFjRU8h0eAzRcD9gPfBgESp3EZEoW2skKu2yobmZFEFFfJ0JWpfvF
         BW3GnKO1E2fGM92ZN4t3MnjpytXC+7WQvLR16jhoMQIh/HIIIpeFjr8xntchh81fTdrx
         5LVA==
X-Forwarded-Encrypted: i=1; AJvYcCWWzkMoXnhXii9P3+FXItCGYaRwP6O8Jxg7p9ysYfp+37Moni7HWmncWnZyrzbwTTAXpJ1o3IKLB21WpPNK7Jvt6julXADC
X-Gm-Message-State: AOJu0YylJWoHBAW8na5cFZzNTk5DLn1D3cDkGMAG9Zvw22MNyVpCs35/
	a3MfyQb6Wv9CrC07pmpiXOz0fGSFcAWPvYs3PUPBdTIuDcTqqwAOvoolgrF96LkaTelqTNa0Ct9
	yQGKNMkpn
X-Google-Smtp-Source: AGHT+IHxkUa+9SMc3hwNSyjhqBHKPSQp13kF3e6VpggMYCi3j/CkeLGl9oz9abeUs2u7xtYnKjPHlvcAceQqkA==
X-Received: from ditto.mtv.corp.google.com ([2a00:79e0:2e0b:7:5c55:770f:5507:76eb])
 (user=daiweili job=sendgmr) by 2002:a81:6ed6:0:b0:62c:f976:a763 with SMTP id
 00721157ae682-6a971611b87mr887707b3.1.1723520111556; Mon, 12 Aug 2024
 20:35:11 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:35:08 -0700
In-Reply-To: <87sev9wrkj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87sev9wrkj.fsf@intel.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813033508.781022-1-daiweili@google.com>
Subject: [PATCH iwl-net v2] igb: Fix not clearing TimeSync interrupts for 82580
From: Daiwei Li <daiweili@google.com>
To: vinicius.gomes@intel.com
Cc: anthony.l.nguyen@intel.com, daiweili@gmail.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	kurt@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, przemyslaw.kitszel@intel.com, richardcochran@gmail.com, 
	sasha.neftin@intel.com, Daiwei Li <daiweili@google.com>
Content-Type: text/plain; charset="UTF-8"

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
---

@Vinicius Gomes, this is my first time submitting a Linux kernel patch,
so apologies if I missed any part of the procedure (e.g. this is
currently on top of 6.7.12, the kernel I am running; should I be
rebasing on inline?). Also, is there any way to annotate the patch
to give you credit for the original change?

 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ada42ba63549..1210ddc5d81e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6986,6 +6986,16 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
+
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires a explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
 
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
-- 
2.46.0.76.ge559c4bf1a-goog


