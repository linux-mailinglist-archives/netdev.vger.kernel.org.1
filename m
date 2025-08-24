Return-Path: <netdev+bounces-216259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C22B32CE4
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 03:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC4E3BF038
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F7128816;
	Sun, 24 Aug 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIK3YDZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C25C96;
	Sun, 24 Aug 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755999051; cv=none; b=Zs2J/LQTtVV6EKr9eeq+G/INDMsMs2PGbAvfXpRP7IszyyiumbMiVb5v/35tj5DDHpvq5wI7J3j9hxyEWVX47xA0nJB6XF6UdWP30gSvnoUe1EmvKgd2VIQPjPwBd/dKuHW23swFotr6T2DdXDuvPIi2q+Vilb1uV6IFCqqC3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755999051; c=relaxed/simple;
	bh=+sdc3xNv832iC8EdxMtXnKBHxlqOje9a8mDMzW2PzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSQZ/QuyfRUAeqD8MPOZh9V5qrO22QhG1vsDgBroA+cP+8Gc/ExJV6LaJgBIBBxPl9NZJdlfRR7QZ+HhsUV1laU2bKFxGvzosDa9BpebAVv7HcfVi7HlBcuBxCZi6qTdODTHECJiRACQJD9omW9ozlhVz5q4s4Zn+IhIp9ZjTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIK3YDZL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717543ed9so2199156a12.3;
        Sat, 23 Aug 2025 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755999049; x=1756603849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OenbBBxBjUd5ddJh8x9yAvuiKz9EKNKjOuL7+opaP8=;
        b=NIK3YDZL5V+XwrzjzCau0uS9iogq7zi3OWj/jcDaCEqVaTcJq1xfC+rcy3WBgfjl1o
         GD9nfBYdyywfuCXSk6R0Og6HpbQUJ+e03bFQrRFuakYGGk8IJ7hJ/z9LnkTq8ezIOpTA
         R5CNl1AOKSQUlGO3NnSkhOe9EtrNIczp05WS519eG8vHwZc0uLnbubzz3n5uxF9kh4RQ
         Kcq6X9jkkWv4dX/YSQcnDmYun0liuBH3blFO6HjDMOnWDU48O3aBXt2RHdy71Kk4mcM5
         Pmc4fJXWCXuiwQJjwNgKIElB0lLTeKaYDsY9bzUGWozfi1o1aRw3EMR0WjmCdvL8mz5b
         QTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755999049; x=1756603849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OenbBBxBjUd5ddJh8x9yAvuiKz9EKNKjOuL7+opaP8=;
        b=VXOJXQfpm6fZxTAAfPwQftOPNLuNiZ/0yQWwjNuTz8BlIJPHULeFXqL5/VHoXld9dg
         upHGB1PMYA8uJ4F4lyw00VVPmi5rTu+oDgfnY9YJap3xCqsgDyN716yphi817yZLN/xe
         VFpRqBRFZUElq7/FeA5eLwEctDtwpdWBMslJkw3yuf+hG4uKjDakVX06SEqOlGlpNBHb
         ZxLzuw2vcT1AQhHMa4jOg+UuqDJqxwHvCRPIy7WxCPRxF4vW6EximRF/qv4csU3R9m5T
         YC3rLnjeOnFti7g74i4RdSc9XIYJyN8/2da+oAn8uGvkWaCE8t9vY3v+VTUYV/S+DmYe
         ks5g==
X-Forwarded-Encrypted: i=1; AJvYcCWObuWzNCQoAwzKhcGBENYZsJs95/N1f/7bu5FYwXDdmya/H2WdkNBggJqnzqhWtVBxtQqsoa5ytNBEjjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTRmOOZeSjfMEAkJLzcfi6el4u35rctDlRWa19HsN6DLjDgI0
	gsb+y3ilZMF/E76Uv57/NiZwduYYm+6AqPzTqQ6l7+f4vseFRGxpMw3MwiSmYRPi
X-Gm-Gg: ASbGnctB6tWKBqOLOLRk2SDbvuuJNX3jaZwtST+Lq3woC87JEOyLttfYNlBN709+UYq
	rguP3xHW7bz/6eFjrswcc/VkB4WENBWJwkmYmnxGlpzg7MxuOgZw1egqX0Uz5L29M+orMrFmirz
	LaJN+Q83MNNnnfVFsMHfPe11l/LSt5ajrgUZ0BZPVhyFA04Gb1ndVsXkAFSXt9GcnAn50LTDVVF
	s8SH/cEdC7kJhkPGwYM/TT+o3yqqMn0HUaNM8VFomvF/xKUWDhikBmgW9aJP0xOd97KQMzAqpRT
	7qOEopnN/Sv2ZxssqoV+OC+AiPWGbc3zIY95BNidDO+shOX8xacPJcsAP9vYAbDwqNBSqLeC+C0
	arzF+DsNEm15XmhQ9RguRa7gZsvy3EA==
X-Google-Smtp-Source: AGHT+IEPRKNV1sNaVjRbSLbFx605j7fjHRAPZ3wDmRv3IsG6v/OjwZRNJo9dE+/8pPwAjEaj+OF0Eg==
X-Received: by 2002:a17:902:c410:b0:240:3f0d:f470 with SMTP id d9443c01a7336-2462ee50129mr113637985ad.20.1755999048877;
        Sat, 23 Aug 2025 18:30:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.247.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885f2d1sm31947135ad.77.2025.08.23.18.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 18:30:48 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phylink: remove stale an_enabled from doc
Date: Sun, 24 Aug 2025 09:30:03 +0800
Message-ID: <20250824013009.2443580-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

state->an_enabled was removed before, but is left in mac_config() doc,
so clean it.

Fixes: 4ee9b0dcf09f ("net: phylink: remove an_enabled")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/phylink.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 30659b615fca..9af0411761d7 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -320,9 +320,8 @@ int mac_prepare(struct phylink_config *config, unsigned int mode,
  *   If in 802.3z mode, the link speed is fixed, dependent on the
  *   @state->interface. Duplex and pause modes are negotiated via
  *   the in-band configuration word. Advertised pause modes are set
- *   according to the @state->an_enabled and @state->advertising
- *   flags. Beware of MACs which only support full duplex at gigabit
- *   and higher speeds.
+ *   according to @state->advertising. Beware of MACs which only
+ *   support full duplex at gigabit and higher speeds.
  *
  *   If in Cisco SGMII mode, the link speed and duplex mode are passed
  *   in the serial bitstream 16-bit configuration word, and the MAC
@@ -331,7 +330,7 @@ int mac_prepare(struct phylink_config *config, unsigned int mode,
  *   responsible for reading the configuration word and configuring
  *   itself accordingly.
  *
- *   Valid state members: interface, an_enabled, pause, advertising.
+ *   Valid state members: interface, pause, advertising.
  *
  * Implementations are expected to update the MAC to reflect the
  * requested settings - i.o.w., if nothing has changed between two
-- 
2.50.1


