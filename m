Return-Path: <netdev+bounces-139301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6779B158C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 08:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0B1F22820
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAC178384;
	Sat, 26 Oct 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1PVDEBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0329CE5;
	Sat, 26 Oct 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925678; cv=none; b=Yd8Cwv8gy4+xz9nDc4PT6vxUd6GrtoI0/zCk0QZtm1nf6/R3NUe/oEKxrlTsyy8zhFKsqF/Gz2NPdMtcqCvkEfiP0vGVP5elUA+wqMXU/tkAQ5D8dISRQApLQZq2I7v9M8/EfLdkqBdxCHLQK7dF8DFzXdZI1RFLx5ju3YC3GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925678; c=relaxed/simple;
	bh=TuQA7dPpS8bAGcKBW+pbPNP714DcJshUvyM1zp01fAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQVVG+wyFSrHUcGkKKweiD6L4s0ZDgeKtf0oUWoAu4LSdK2QuvaCx+jkor0ECixC3S9NhGIqJ3TDHOdOnfn8Gqigiya0MMINyOlz2zzJyHMOqCeHM1BMJH5RFPMMj3fxKQlxJluNUOtb9trNkgDNE28RDmEOInAGwdEi+nsAtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1PVDEBH; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e5ae69880so1965156b3a.2;
        Fri, 25 Oct 2024 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729925675; x=1730530475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2pAE1nQgw4jbrmDxYeWEQDTLjgIt/Rez86CyuKC0C0=;
        b=S1PVDEBH6UP4XisgmL+4/E16WGkP3D7bLFsRG/Ge9lP54uMcDc+zIdq54lKmHXTJja
         iI4WX2f2WatX5IJYJTd8VIiZ9W5U85SYQ1Fjm67opD9cA8/eLJROuwcdqlx3EHKIJ+yI
         AVOVDltFwEwnF7/DMrEH/Bn2LzpYvbiHB6JE4i39hwPrQ6KZewvPlKDxov2RY9dJtuKO
         sQshNXcJtt+XGqXDkfLUGnGFhvAOatlycWVEqaOHz+z2MhRv8+6fGVl/QckWQOSnu2tS
         D3/mO/LxAhQZSobExIQem31mfwjk8kLQqMvtDvT0T3y2E2/Im26U+xYXQk22nCCeFm6G
         7TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729925675; x=1730530475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2pAE1nQgw4jbrmDxYeWEQDTLjgIt/Rez86CyuKC0C0=;
        b=TxvDw8TEeXDAGt7E8oaJR8pu+yQ6nXg1yk3W6cds9xY0wJpE9sAUWJgKkao+MWrsu8
         O6GhAAX12icIzGSc9vaF37ZQ0OdIXDTm6YQ1mOdW3WKLM/3Xio+/otUqBUdh3FN5pbcP
         p6HIY8B/eEJ0CDas0v8hWQLWMmB2MoftRTiW6cEJ+83EFj6AHoKRA5tNZaKfWVMchxAf
         gtdA8xE1riaM6LdheINbqJUyawP6ycg6UrRLFokX3uxl28Ajhb1xQIQFeMUEEc2C3w0H
         uNaUkauYySm+knwm12kBx1j33sY/zDO36OLW6qXa6peFenQuWIKRnv1/KkBwWK3A0Ei6
         1AcA==
X-Forwarded-Encrypted: i=1; AJvYcCUidP1XKFPKuXoNRBwtxE6m7MK9sEIegCPagCOdgp0xJYg9WNYqRKPsxifFblIeUT/NRvVzvp4S@vger.kernel.org, AJvYcCXjLDHWM26WUz602QxODYPEDpPGnxYLCF3vGThe6d2iZyrXqOlWsrW+SUt2Erom9HWUhtgN5ritUC4BRAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxW7ZRYlRwnChW1heLrUF4An/VvF33nn1Li7fyJWK9d3ZGLSQz
	HCCjb6SOXFnzTIhPjLeJAnLa/sRNjP+vzR3eOZU7lII0TRQR+J+J
X-Google-Smtp-Source: AGHT+IEl5l0jSV5gXZw1tFhxSHW7frVVE5nruCu12o7EQzDV3Eq4x2GY8dcedHW06478MetBe/k4wA==
X-Received: by 2002:a05:6a00:80c:b0:71e:5b0e:a5e4 with SMTP id d2e1a72fcca58-72063098020mr3311582b3a.27.1729925674664;
        Fri, 25 Oct 2024 23:54:34 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931785sm2142139b3a.50.2024.10.25.23.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 23:54:34 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	lixiaoyan@google.com
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next] net: tcp: replace the document for "lsndtime" in tcp_sock
Date: Sat, 26 Oct 2024 14:54:22 +0800
Message-Id: <20241026065422.2820134-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The document for "lsndtime" in struct tcp_sock is placed in the wrong
place, so let's replace it in the proper place.

Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/tcp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..f88daaa76d83 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -200,7 +200,6 @@ struct tcp_sock {
 
 	/* TX read-mostly hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_read_tx);
-	/* timestamp of last sent data packet (for restart window) */
 	u32	max_window;	/* Maximal window ever seen from peer	*/
 	u32	rcv_ssthresh;	/* Current window clamp			*/
 	u32	reordering;	/* Packet reordering metric.		*/
@@ -263,7 +262,7 @@ struct tcp_sock {
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
-	u32	lsndtime;
+	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-- 
2.39.5


