Return-Path: <netdev+bounces-129454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B6983FE0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3458DB22703
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59614D2A0;
	Tue, 24 Sep 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWm9uYnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8314B976;
	Tue, 24 Sep 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165151; cv=none; b=XNIXc9HKepF2fF3IgwWG+87LIPAIBcFW4PPYeIxaP40K4X2t0iW8LXyXX8AC7woRf3M7yHBfHhBV7LPC6BhL7pnMIfzLHD7fs1kQOmmHzlwWehq0HthXm4mgdL/LLWw+U+p2rcuw95wl86SBNOckN5ZbBQDpNhLGEhy+YpTszWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165151; c=relaxed/simple;
	bh=5zsObshMpMfoJLP7jECD2dauQjS0zZ4Y8OlE5VP8hS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JWF3EpGAgkI5rOEa4NpmHnf5iiqC5rOASEF3b4NqyK6KqlExgC6pHk8sELYlcMfnJ+w+gnnUfQ3ik7+IDuBmtTsvp1FSy04/AbMs9i2RVbU4X/5R/CNn+KkVIoAqfRJCnB7DFBhya8+zKgmVbPrI9nd8jRRZPVS1eNTgdyeOGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWm9uYnB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so5517610e87.2;
        Tue, 24 Sep 2024 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727165148; x=1727769948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFEgdy5x1Q+gNOoht1LGV0PYNn7MEyvwRB+P2Wr5bAU=;
        b=kWm9uYnBkTpQ+2jzl5BYYRLjNQO94xDIBNE/FlxQPZOB2B5DG3dS0GTcgE04GPB4m/
         S0HYVH52AAESGxtc0QKHkPhbcOIfwT8nC11nMKzZv0+ze+2+7MT1/CHPjYW5UBX4l7iq
         vPcyLv4rk1LFdb1LHfGcxEibupFhtzT2Q9WGyOAFX3WDtChWFBOAXw4VmoSehDyszah3
         +BlDyn1Qb3Y6pCjUQaiA7kxfqVHKBKhrsL+8fjBgz2v0CaXhLMUQODUGolhw/QZ4ojOy
         Fzy5obpdzdMD1CJD+OyZYZO/5W8xTY5L+Oh42zdwPEBD1vFtUbiL5LBu0DOZiIlD6UvO
         TbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165148; x=1727769948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFEgdy5x1Q+gNOoht1LGV0PYNn7MEyvwRB+P2Wr5bAU=;
        b=VPQ0p0mpYMc6jN/iHvPWfiwMOvf9F3JDwV1LZ3KU7/Fqxpzv0qF//9V1qNQJVTH+Kq
         fcc8kZm9SsPYAb/77h4O+oIhxQCe7jZAt5LcdGP/KTDBnv8X9voEUD6yLxeEEiKyt5CQ
         +veXOxkYRzfeDUofYvY+hyGIwqSfQh4VTXFEXejx21MDP0YGyyZ0tN4SVVoARXy95/li
         akUqPPXYD8DnfL736j+nQ5LC3qx/61K37c6hb/pju4kcUg5nkhdjqZDPyLq8VrJc+aZZ
         xvNLgCl5KX5dbSF85O/WTo/UFPga/srPrOJCZaPDZO9r8cmhP2CZ45veFXHRWKbvtLCj
         NR+g==
X-Forwarded-Encrypted: i=1; AJvYcCU7IePTPQnS1+v4ECeDoe3Rgx3yu+VFMqSIo7m6WxmYSn5Grj3kUJgpM6Vi6fewYMEYK7kFxvcY@vger.kernel.org, AJvYcCVpT5a8f2bmvDVjLC9FEU32zsniSSnTYtcXU+4ie4uNA6t1o/IdbgvKEfl4WH9lERoLEdyHzjh04L3v5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFPkhwIfLLzFthqQommtaZZDtjp/qsCYLaQFv5J1YVrMbfOTW
	THHCbrnfiBdTO4RC7L4LZcjZ0VHC22WNTFGnHtBFxEMASFDXFnw4
X-Google-Smtp-Source: AGHT+IHaaffPihesHXDDIhPOCmnuPxUs7ZPQJR7bmJwvOeL6xQDUhJ+/EaOmhuWY9aQ+2kWy4Le35A==
X-Received: by 2002:a05:6512:124e:b0:530:b76c:65df with SMTP id 2adb3069b0e04-536ac2f4e55mr7752421e87.35.1727165147853;
        Tue, 24 Sep 2024 01:05:47 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48bfddsm505740a12.12.2024.09.24.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:05:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tcp: Fix spelling mistake "emtpy" -> "empty"
Date: Tue, 24 Sep 2024 09:05:45 +0100
Message-Id: <20240924080545.1324962-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a WARN_ONCE message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 include/net/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d1948d357dad..739a9fb83d0c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2442,7 +2442,7 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
 	} else {
 		WARN_ONCE(1,
-			"rtx queue emtpy: "
+			"rtx queue empty: "
 			"out:%u sacked:%u lost:%u retrans:%u "
 			"tlp_high_seq:%u sk_state:%u ca_state:%u "
 			"advmss:%u mss_cache:%u pmtu:%u\n",
-- 
2.39.2


