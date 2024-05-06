Return-Path: <netdev+bounces-93703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFF8BCD6B
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EFFB23EFF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5794143884;
	Mon,  6 May 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q26G14eu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05C84FB3;
	Mon,  6 May 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997145; cv=none; b=OGh0PI1AIqw81VdrG9Re/RsVrW9qeJL19t7UMsTCAwLgGr5usVqNsWxCUAJLmg0adbXnPMarfh58fjmqwQul9TVKwoRDiW9U+4NhgbliSmm6DvAFltptg0te2vO618clS2v4MEM1zMObBfZJDfmnhRlR2p+90VL7kpIh9QKBD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997145; c=relaxed/simple;
	bh=tPtIMSYtvJlI3KCesPbnvQQSLgAMs0nQrBIGqvYwocg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t8C/DEAtQwRI9qxQ9mLCaUGZuvdA/0gpgWL9pXgvXEWBHrgMyMq7UDfKzgtbgGRCGOggaMByNJlQhONZ68GmI4UEH34fzeFQG3vVjGrGIxW/hUTufQGgUjtoaMFJWHJlGNFN0poAv6PFKEQgmiN2YYU/tOf5BzEMrq4dGUSrGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q26G14eu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714997144; x=1746533144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tPtIMSYtvJlI3KCesPbnvQQSLgAMs0nQrBIGqvYwocg=;
  b=Q26G14eubxaDdHe5j2UZrkZYEptcINuk6N8Lc970D9LkyqYiSHaAYe71
   drbTI8DRtEtOnE0QmeOKSRpncNVAqK6bTogTn8WFV3xCDyhQlnn9G65t/
   /+iYuOmGh5wEB79jB+9UZ4PqeXC177IHoflxGinT8zZcmTPgHD5PPdJxD
   mBos4xCRaZnNcV4vRCk4wD0x2YVZjiMh9jWuMRc2YvN7giqbKX4gwvuuH
   yf8i/6t5fueXFhdrHyjiFAHCh7m2Uln+jra9mITRLiGdTVAAxIgFO6taK
   7FIj1FL7jHnhX3jvIspl+lz0z2cbBhc5M3lyytbBCRAnkcUDFtRaSI8E9
   Q==;
X-CSE-ConnectionGUID: kN6KKmyNRByQD9q6jb3SFQ==
X-CSE-MsgGUID: LpDE4Ui2Ts2HuYBuwHW/hw==
X-IronPort-AV: E=Sophos;i="6.07,258,1708412400"; 
   d="scan'208";a="254630400"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2024 05:04:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:04:30 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 05:04:28 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <soheil@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: tcp: Update the type of scaling_ratio
Date: Mon, 6 May 2024 14:04:00 +0200
Message-ID: <20240506120400.712629-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It was noticed the following issue that sometimes the scaling_ratio was
getting a value of 0, meaning that window space was having a value of 0,
so then the tcp connection was stopping.
The reason why the scaling_ratio was getting a value of 0 is because
when it was calculated, it was truncated from a u64 to a u8. So for
example if it scaling_ratio was supposed to be 256 it was getting a
value of 0.
The fix consists in chaning the type of scaling_ratio from u8 to u16.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/tcp.h | 2 +-
 include/net/tcp.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b31..cc4fd1cbe6c12 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -221,7 +221,7 @@ struct tcp_sock {
 	u32	lost_out;	/* Lost packets			*/
 	u32	sacked_out;	/* SACK'd packets			*/
 	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
-	u8	scaling_ratio;	/* see tcp_win_from_space() */
+	u16	scaling_ratio;	/* see tcp_win_from_space() */
 	u8	chrono_type : 2,	/* current chronograph type */
 		repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0a51e6a45bce9..252ae24b0f1c7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1510,7 +1510,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space,
 			       __u32 *window_clamp, int wscale_ok,
 			       __u8 *rcv_wscale, __u32 init_rcv_wnd);
 
-static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
+static inline int __tcp_win_from_space(u16 scaling_ratio, int space)
 {
 	s64 scaled_space = (s64)space * scaling_ratio;
 
@@ -1523,7 +1523,7 @@ static inline int tcp_win_from_space(const struct sock *sk, int space)
 }
 
 /* inverse of __tcp_win_from_space() */
-static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
+static inline int __tcp_space_from_win(u16 scaling_ratio, int win)
 {
 	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
 
-- 
2.34.1


