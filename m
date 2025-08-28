Return-Path: <netdev+bounces-217643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208FB39691
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342BB1886598
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7212D97A6;
	Thu, 28 Aug 2025 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnwr0CcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4F29ACD1;
	Thu, 28 Aug 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368908; cv=none; b=gUqzuB4O2pv3XidDz4bAPWfJpbw1JdNovKMWiIWs6QQsglOnB62rHLiD/j7lETPsXp8IwLQdL4oBh+/8F7ZIVe9x+TdyrSeamX9O8SgWS+9ZpTlWbk1ZxqX1aDJGmmQ0nMeR0jKzNnXQybXybKwGlnjK/I812np4ZGMNnNSQ5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368908; c=relaxed/simple;
	bh=ftxvw7nkrouhuxNLXWlJ5iqNXxZaopoYAL6tujyJOYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUTRDNgUa5wB+8KKOuXUGjtVrd0SiPWYGULTnz/1ohr+WozFITCJz2WL6N9HDDJ19nucyR/8DaKCKrEk7c8qclhm1/6unL2YzATOcRSWMJ470EX6N2uae+V/u4ANP+JPe+8z80Dbh54FM3qdeLK6Iruaymd9jrFwF6IGKnZknbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnwr0CcC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-771eecebb09so987532b3a.3;
        Thu, 28 Aug 2025 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756368906; x=1756973706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ia5R0sYryNlESVObLXR0gMWB492r2avec7eAXa6fF2Y=;
        b=hnwr0CcCFx0OyWaiT/ACEPnz7+GKtDQRZ8FFeKzU/jHeNyjBBdyX02u3QAMzHHzdVW
         wLD2XDWIefk+LF0SR+Dvu7VU7XvwECiIO4KkqO+02QSfBRilBENmNpiMjD2dq7nHqJP2
         77QXSIOyXCAmyI6D8HIeQeVn1hwVLZXpsoxEyL5L6dFRPM9rL9qLkaq4+ZVwCvnh6JdC
         ppZa9/gsGmyAmPDs2yR7Vnc3dFAN6cjh6uaHpu0CUObdGB/ucSfIhDwiIZAGCYLXPHZH
         TemNSkFlX8yggiwQURjtTDbfTnoCXbvKXKFqzIcnKflcQ5Tu6ZJBStfgkJX7ifWeQr6m
         lz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756368906; x=1756973706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia5R0sYryNlESVObLXR0gMWB492r2avec7eAXa6fF2Y=;
        b=B56U2QAOrytAewrfswpd32zI8agr3fTfzQWgCJHnklcIiNmxvR5BkfCuGGRXC9baoc
         jJERNDmddYf85KR51Qs0HY2zLcSPXeHKhIOK9n7asR9XYgxldNreb0Slan6sRXxH8OAm
         tSkGJnJLL9flG+sF/nTlX53GUOk5CrxHYZXw2rg6KP4gkBoqMvcznyqr6m6G6xHRW735
         SiknSMXrtWvu+3yMec6TgzWE17Y9vzqultvvKuxqfj4TCTLI3sIsC+GnTiRAMz0OAZYW
         Pwjo22qJkkyaBi+x3sCQ+YHnwDrG4ZNlyCDtLCRdFAhS6y1I6AExX4oDEXZDcyh642oH
         aqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH4wPPMJQi7+zW71tU/ReQarDjikWf9eMYda3EIR7zqs7mtebTN/gZZqtorClqxDXPKmhpKJmr@vger.kernel.org, AJvYcCWf5fcl/NlD3NNysVn3kytwPLHBT08WhY0Z1e+8oBPOlRsEx1GauhABpleZOW7J58djHDzrGoJvCvOJrAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5r85MHxwTwmbwwfKpj0Zaaju9535SpiSWaol9fH9KIzMvBhKV
	OY6GiHBQx1rKLuFyUq6s0LzdDHL7fqUVehiu/Bv2jbrraw2wv+Q4XPDJZPfsOZMQxpU=
X-Gm-Gg: ASbGncudtAOR8Apv4Tb6z+gKxDU0TVzqJoPI+dEvFJwSDxnIQItQGtrpiU1BbWLngbu
	fEg57jzwKH1axas13Qt70cId38zUNwhVJct1edR9Y9x3wSjEr+DuFcKJ++o3nbbKJsOGeShkfpJ
	5ktYWoetmsrGV8f+CLFVYnmR4P9cNREhzAmD87e01U026U2FZEYLhOZ/UsMyJwEaFM15NjRNI0S
	xEHkRoQqZa1aknJ0uX9YA72fgooYpVHiIVwPBrBS5paYqQWb4TAFCjJQ3HnkanZBbR6kHTuOuVG
	2pJMZCfqv1rTvlCR1X1plHnhgGiKC4Zy9TAhtys7D3Tba7+fjCLQVh3qP+wrjJyCSyfgkQR1D+b
	3LAov4igd1Luuz06m0Gw2LlNx6d5NPB56V1N9JDFJ8f1k5TipK3LoMW18eFM1fqztY6rxvuMsT7
	pCOWR3XqJ39PE=
X-Google-Smtp-Source: AGHT+IEJbUNzADncN9xMb+Wu278ojcMnqcWdgYtjUsEoXle0Hm2TpMNvN9/nvDN5+Orv6CWHu3BjDA==
X-Received: by 2002:a05:6a21:6d86:b0:240:8d5:6271 with SMTP id adf61e73a8af0-24340e1a51cmr32947085637.39.1756368906129;
        Thu, 28 Aug 2025 01:15:06 -0700 (PDT)
Received: from localhost.localdomain ([112.97.57.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b49cb8b4b98sm13376672a12.19.2025.08.28.01.15.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 01:15:05 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Karsten Keil <isdn@linux-pingi.de>,
	Laura Abbott <labbott@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] mISDN: Fix memory leak in dsp_hwec_enable()
Date: Thu, 28 Aug 2025 16:14:57 +0800
Message-Id: <20250828081457.36061-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsp_hwec_enable() allocates dup pointer by kstrdup(arg),
but then it updates dup variable by strsep(&dup, ",").
As a result when it calls kfree(dup), the dup variable may be
a modified pointer that no longer points to the original allocated
memory, causing a memory leak.

The issue is the same pattern as fixed in commit c6a502c22999
("mISDN: Fix memory leak in dsp_pipeline_build()").

Fixes: 9a4381618262 ("mISDN: Remove VLAs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/isdn/mISDN/dsp_hwec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/mISDN/dsp_hwec.c b/drivers/isdn/mISDN/dsp_hwec.c
index 0b3f29195330..0cd216e28f00 100644
--- a/drivers/isdn/mISDN/dsp_hwec.c
+++ b/drivers/isdn/mISDN/dsp_hwec.c
@@ -51,14 +51,14 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 		goto _do;
 
 	{
-		char *dup, *tok, *name, *val;
+		char *dup, *next, *tok, *name, *val;
 		int tmp;
 
-		dup = kstrdup(arg, GFP_ATOMIC);
+		dup = next = kstrdup(arg, GFP_ATOMIC);
 		if (!dup)
 			return;
 
-		while ((tok = strsep(&dup, ","))) {
+		while ((tok = strsep(&next, ","))) {
 			if (!strlen(tok))
 				continue;
 			name = strsep(&tok, "=");
-- 
2.39.5 (Apple Git-154)


