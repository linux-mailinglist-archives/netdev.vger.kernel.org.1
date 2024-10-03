Return-Path: <netdev+bounces-131512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA198EB80
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A03D1C21F91
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3812F588;
	Thu,  3 Oct 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB/+KqDB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD783CD2;
	Thu,  3 Oct 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943805; cv=none; b=AREsEZiAWXi9dQva2MCz7Dz5PmMevWtbnaE420O3ainAHdefOKCRlp4F81E+OM0gAclUZqaoxpTaaFpi/xI7g/Byo5UnAylc1TfbDxIQHfovGBfM7YNhWDjvV/Y86vPBabJoIej9zNGVlGfnUHkGiSSYd4LHZ20PSQrq4jVBMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943805; c=relaxed/simple;
	bh=2z0S7E21AyVGKQDVo1QW+CLgvuosWzK0JAHqhlIclW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tycLDU+yj7vj5zV0ubF4P8kRCXHQ1OxG/qLXiMjbB6c2SUzDoz+DSoCcIvNiwAbCp9QvugL0iV0Xfm31j05DRehp+lwhP4djZ4NHgQuq+gNuHX4zj7Hj4mpsg7ZE4SivcrUZadhUKSCp53lTwjl0NE+izLTuI5JXnaio1I26ZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB/+KqDB; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20b93887decso5151855ad.3;
        Thu, 03 Oct 2024 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727943803; x=1728548603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSGp2VSXxnUzGxTrwOCc7pDQc+VHBQXhJ2TxrbatiiU=;
        b=bB/+KqDBIP/ezRSCu18HyIPTSun6dmSx2Rg6KUGaj2pSRKIyeDyJaeP9NfuN5PmKZ0
         FhR8oCOAmfMK+axwq0ZiPSe8OWxpCQ890HK5OaHP8ynWMfEGTRVm4g02iLshKEr2hwhS
         YB1B2bAYOhkk0k2mtmrjswBjqZd/lVhatbpTv0KoNb52EjXX1OJQrkI6mWDfyzXD4hlL
         jfwtnQicnOntQYPvfryb0jUCDENphmNHnyeDTWzu8C0J8lMKv8p3vbIqiL2EVtg7eNvU
         mXJSHG0CFdPrsAnkDU4GFGzhtp0bpF6AIFSKrEQoTzhrpmnNIjOYs760FYi1srhGUTdp
         SneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943803; x=1728548603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSGp2VSXxnUzGxTrwOCc7pDQc+VHBQXhJ2TxrbatiiU=;
        b=OXQDP/+pD87v4oVe4DrYeRuhIOUmckQWWcRnkn+yWDLA/8OXdMGhPEybtohu8F+V6u
         Ps47xA63HfnOYXFyij/CaJ9tioSTU6nqKfJ3waWdU7UZ0AuWoksOcfIuKmUhnyjfe+LC
         TM23XEu8uAWAcvf7n4MclwtCEbbdUrBVyjthS8/tetybk5pYPG01WrQHz2/S813QFw3f
         YoFX2K+5HobGdnXSaMbPwoclc/jhiSEyfkaUfiwTTf0y5yB/M22ayPIxcNlWtSXbSgpK
         Nf76e49xwd+puN9JhgH31MkjiQ54w9gxzu0DFRMbP9gPkTaWXM1LMvHbyZx7w5Uem3Vj
         5JgA==
X-Forwarded-Encrypted: i=1; AJvYcCU89wrrAePw8NpeOnp5fj+bKOjMkalhl4YHSuOwPvb+ZCQaiFlgFUfDKn0A9d91qRETD9L5Z78i@vger.kernel.org, AJvYcCWlwwIEPL3leDVUrrZ9pyc05wCF/EQX2xs5ykxUq8l5BJdF9BsBqpaY22woBH5jJdx0ziNXi6LgoPeJexQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXljgSsan+CVM1ecGcO8xKRDo29inNqSxHTLbrrTAu6cGSUUGd
	iaTfmHPHyhnMn5FRo0jwMF0O0VlGYrW4dojdNO6ki9IR0rHCBUFw
X-Google-Smtp-Source: AGHT+IEEW7UYGBuzMpq+iIO6Ao+2bFU0poJ+0skRAw3zHIXE2+Mft5dJwHuD0mc6nV+0WDKjd0E+ew==
X-Received: by 2002:a17:903:2451:b0:20b:983c:f0a0 with SMTP id d9443c01a7336-20bc59fc2f7mr76532755ad.31.1727943803388;
        Thu, 03 Oct 2024 01:23:23 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ecaasm4546725ad.139.2024.10.03.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:23:22 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH net-next] net: tcp: refresh tcp_mstamp for compressed ack in timer
Date: Thu,  3 Oct 2024 16:22:31 +0800
Message-Id: <20241003082231.759759-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we refresh the tcp_mstamp for delayed acks and keepalives, but
not for the compressed ack in tcp_compressed_ack_kick().

I have not found out the effact of the tcp_mstamp when sending ack, but
we can still refresh it for the compressed ack to keep consistent.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/tcp_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 79064580c8c0..1f37a37f9c82 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -851,6 +851,7 @@ static enum hrtimer_restart tcp_compressed_ack_kick(struct hrtimer *timer)
 			 * LINUX_MIB_TCPACKCOMPRESSED accurate.
 			 */
 			tp->compressed_ack--;
+			tcp_mstamp_refresh(tp);
 			tcp_send_ack(sk);
 		}
 	} else {
-- 
2.39.5


