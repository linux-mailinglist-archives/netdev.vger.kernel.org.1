Return-Path: <netdev+bounces-249532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513B7D1A894
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1E0301FC3C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A834D90D;
	Tue, 13 Jan 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxhl/Cgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0C2D5C86
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324232; cv=none; b=MBOZEa9O5T+IG2qTJe7hUMNnu6ui/4+BUgd48NhqIl4tVoHz6jdgPpTvEoIVeCV/NpRhZv5GbrUdwl4JkoFYjDPZVsuGw4H02gHlWtq5/WW3tPg6gVXPoJfC1PeZM7nstNos7xUxsQ9h1U4z6yTQdk87QOBwRD+3saHsLQd6nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324232; c=relaxed/simple;
	bh=s9GLKMja2Fy99G8J8FP4C9B69+dV2cdS2sZsFGiO6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAn6JhHkKYQlOhHmq73OpHqkGKjsd+d03ssfCkVXGbSUcLyIo4LdoxJv9913fvq88YV+lRmtn3vtIIBm2bdQogTk0oB0dw1NLmhWaknPdfdgfC624cB39DI0stPM3j0LxTXdtEihnwa1cUL9AHyS2bQEfzMNrBB6eW6b+ykCfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxhl/Cgs; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b1bfd4b3deso689477085a.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768324229; x=1768929029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrXGZ1DMbIgC2clANmGoPNjpFNGYeb4SbcEZ9RK3BLQ=;
        b=mxhl/CgsJ3MXA53RDZmZ/nv4O51thVbeJy7l+czn3alNoe8pPSPSXzitZdEzIBeOYz
         UBXdGII7HP6VD1uqbZnQZUK8LEHx2RuYrzDvu5g+gQEMpeBDhqjBUiMFdFqUAF2FgX+W
         US1C+41cJOX3wAuFCfRLrd9XksFWPPDHC2akDhs6hPU+wOR6sNG4O4oGRge3acqp5u4p
         culBXDEaW9GP5tBKb8YCcsgVcYXdMVeeDStuo1c/+hs9tuxNoHwKtJrlJLq8TaYHriKe
         GlVKXL8clSZKHTC0iktoPPwoOsEaf8neF5Gs1y9hZMMRGlt1WKPQvi4nwgmVcHbVPVCu
         pCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324229; x=1768929029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrXGZ1DMbIgC2clANmGoPNjpFNGYeb4SbcEZ9RK3BLQ=;
        b=wFSjaF+ntTteQO/vIS3ggjSCqcYxJJ24Y418d4naNKQjNmb/3WSMghh9D9+8ecJ2WX
         Vdbm5A37Mjyt/8/N6Nzo47wHeV797IxJ4eJdl5tbht3HY3MMEhvPadnivtlYqRNffyk4
         RZYXaAKpSwu7A0DM2feJ0CBQcbwI0D4SHrZAxf/z8spHk59iqAPmYjft+aF+62W1uF+F
         E8K9eNrM8vWsytaYfwNV5jkIpV1duCrMG8g7m/7wqNBxiHsfQIMlPonDxfUIdH3Ot7sx
         E4vQZIHPfzYcTwN4j6G4Yd4RzOtk7GGyDg28hb4jwPoqIoqrl6MF3nS12b49bEbM0Vm3
         9wjA==
X-Gm-Message-State: AOJu0YxhvYke5o2SvU/Bo6vZRQO46w+2Co08eE1S9l3i7zWkbyq/W4En
	+WO/4hXg54zyyYw4P6T99t7f7/X0fHgKCdrQEnDjW6DZKix/Hs53QDx63I7pXGz5zeM=
X-Gm-Gg: AY/fxX5F2bXI/y0JHLZGroDhylgwB4odS6LS5P+9sT2USHh9XAkuYw30ErZVe6P5XWH
	UnzQOCiRxHIQ+j1eDwVPlIBt9OLQcRRoJFiJ3volgjyJ8yQlhoYbLUMyJfgjhjKTvcIKEkwXrXt
	V30Dhwk7IokEO9WGFxQbaIvnrwg+5BKrxNioEhHn7ODvG7MFWR2DDY+alDPCKiIoijU2CwIo/A7
	JkSGOdXrfxAc6UWNnm9RzaoUPY7tVf1HfVI5dHbsPhyPn79v1CL9xzKTHhTt133c8c/yTz+nEWp
	rMA6vNZhKRwW+VAnb7d1p8VIMFzJHaUCVMSTy/2HbRO29W26xEHU4HJnulWwConWOzVW+EB1PI8
	F1ZEXsOJT5LN5DP5rMjjczVEuNWChOVTvz+wo2M/Lz/ky2lw8aSqMIzoJAlSMc8HlE3pnhwRuNC
	tLAEKeCDFTYnYKBiOynIXTFIWYUAXcOUpqxRBoEdJf9nCL0wUew38=
X-Google-Smtp-Source: AGHT+IGqh4/UAR4oVXOwSRlhzxaXAft0b57DXpVe0H0Ph+lJu8HDpm9mVmoeISXiuN1DsF3WTZANQA==
X-Received: by 2002:a05:620a:2a01:b0:89e:f83c:ee0c with SMTP id af79cd13be357-8c389417b88mr3161605985a.74.1768324229084;
        Tue, 13 Jan 2026 09:10:29 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1723280985a.32.2026.01.13.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:10:28 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Zhen Chen <chenzhen126@huawei.com>
Subject: [PATCH net] sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
Date: Tue, 13 Jan 2026 12:10:26 -0500
Message-ID: <44881224b375aa8853f5e19b4055a1a56d895813.1768324226.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A null-ptr-deref was reported in the SCTP transmit path when SCTP-AUTH key
initialization fails:

  ==================================================================
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G W 6.6.0 #2
  RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
  RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
  Call Trace:

  sctp_packet_transmit_chunk+0x31/0x250 net/sctp/output.c:189
  sctp_outq_flush_data+0xa29/0x26d0 net/sctp/outqueue.c:1111
  sctp_outq_flush+0xc80/0x1240 net/sctp/outqueue.c:1217
  sctp_cmd_interpreter.isra.0+0x19a5/0x62c0 net/sctp/sm_sideeffect.c:1787
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x1a3/0x670 net/sctp/sm_sideeffect.c:1169
  sctp_assoc_bh_rcv+0x33e/0x640 net/sctp/associola.c:1052
  sctp_inq_push+0x1dd/0x280 net/sctp/inqueue.c:88
  sctp_rcv+0x11ae/0x3100 net/sctp/input.c:243
  sctp6_rcv+0x3d/0x60 net/sctp/ipv6.c:1127

The issue is triggered when sctp_auth_asoc_init_active_key() fails in
sctp_sf_do_5_1C_ack() while processing an INIT_ACK. In this case, the
command sequence is currently:

- SCTP_CMD_PEER_INIT
- SCTP_CMD_TIMER_STOP (T1_INIT)
- SCTP_CMD_TIMER_START (T1_COOKIE)
- SCTP_CMD_NEW_STATE (COOKIE_ECHOED)
- SCTP_CMD_ASSOC_SHKEY
- SCTP_CMD_GEN_COOKIE_ECHO

If SCTP_CMD_ASSOC_SHKEY fails, asoc->shkey remains NULL, while
asoc->peer.auth_capable and asoc->peer.peer_chunks have already been set by
SCTP_CMD_PEER_INIT. This allows a DATA chunk with auth = 1 and shkey = NULL
to be queued by sctp_datamsg_from_user().

Since command interpretation stops on failure, no COOKIE_ECHO should been
sent via SCTP_CMD_GEN_COOKIE_ECHO. However, the T1_COOKIE timer has already
been started, and it may enqueue a COOKIE_ECHO into the outqueue later. As
a result, the DATA chunk can be transmitted together with the COOKIE_ECHO
in sctp_outq_flush_data(), leading to the observed issue.

Similar to the other places where it calls sctp_auth_asoc_init_active_key()
right after sctp_process_init(), this patch moves the SCTP_CMD_ASSOC_SHKEY
immediately after SCTP_CMD_PEER_INIT, before stopping T1_INIT and starting
T1_COOKIE. This ensures that if shared key generation fails, authenticated
DATA cannot be sent. It also allows the T1_INIT timer to retransmit INIT,
giving the client another chance to process INIT_ACK and retry key setup.

Fixes: 730fc3d05cd4 ("[SCTP]: Implete SCTP-AUTH parameter processing")
Reported-by: Zhen Chen <chenzhen126@huawei.com>
Tested-by: Zhen Chen <chenzhen126@huawei.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 3755ba079d07..7b823d759141 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -603,6 +603,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	sctp_add_cmd_sf(commands, SCTP_CMD_PEER_INIT,
 			SCTP_PEER_INIT(initchunk));
 
+	/* SCTP-AUTH: generate the association shared keys so that
+	 * we can potentially sign the COOKIE-ECHO.
+	 */
+	sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
+
 	/* Reset init error count upon receipt of INIT-ACK.  */
 	sctp_add_cmd_sf(commands, SCTP_CMD_INIT_COUNTER_RESET, SCTP_NULL());
 
@@ -617,11 +622,6 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
 			SCTP_STATE(SCTP_STATE_COOKIE_ECHOED));
 
-	/* SCTP-AUTH: generate the association shared keys so that
-	 * we can potentially sign the COOKIE-ECHO.
-	 */
-	sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
-
 	/* 5.1 C) "A" shall then send the State Cookie received in the
 	 * INIT ACK chunk in a COOKIE ECHO chunk, ...
 	 */
-- 
2.47.1


