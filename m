Return-Path: <netdev+bounces-70253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982F84E2D7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E6B1F26710
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04177F33;
	Thu,  8 Feb 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tk6dBonR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B178B54
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401539; cv=none; b=QZqxci5XACy1xj3dFXGRmWjwVq08suPV64ZVdHTk2VHprzc5hJCWcqMLExmWwZZVVS5c7IJ8BR7k9ahpI4/HXlFY+QMR8U6hAoyqdkMxpFEvFot67amt4lYML0oIOz1n36FM3sY1oBNpFIQU33RoMYA7X5zX+FKAhel1K0ajih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401539; c=relaxed/simple;
	bh=rjPZS37myAMVLcm5QTyyj0gwsDFQ/NzT5JabszGNCeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7kGTUXTtW2qvGeKKqYc/yOHVu2gppJHKU/W+k8wm86cAG2VTVs2X/HOAG8BC1IjwLVtVYcFwu/s4lLLk029CDACd2xUvHzfJdGcAkLusU6AXuUHWj8NzUUO8PLR3YmYzoNZIdtyrzkFw8aVFPGzTZ19+WcFX0HWgL8tQzRRoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tk6dBonR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so14038427b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401536; x=1708006336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvc1bc4onOJD+myVGtsrNWF6tYGSfb8pdE7XzbX6nKY=;
        b=tk6dBonRJkM2Kip+wwVfN/nXV/jJ7wsk+IvCltLg3n9TiixFcDUHxljWV0y1xdBsZD
         g1f94dK0XAtUjChr1ypLthkWD4tmK6RbzoMV0ZTCushfni9fF7SNoMxaE6tbFTvi6o+m
         cMI0uuSr8k1dQl/hfpg6ug0UkKxEJ6zB1+kTQmdGjIeppVOr8DAg2Ak740R7QiKOWySi
         vjk6OKbr1wPZa8ixGTZWLLJYi93ocitsOzg5Os5yMrvXkMf1+WAewgBxN2QPH8JHHq0g
         R27iZ3Ef3X6jS9EK22PJG9bv3cBnMWUV4LrEwgO1kzB0NCPuw8R9PMmr2cLY7Tr5fWfd
         LElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401536; x=1708006336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvc1bc4onOJD+myVGtsrNWF6tYGSfb8pdE7XzbX6nKY=;
        b=mSngwB/TC5GiNm9ZdkOUwOMbVsC4B/3LDpMwO/BebXYFegclLLT19C00kDIV2O+k3I
         X/NqK23lckwlnZUbFHAGG0sSITgzQLaPvuXr6dr/+fGTgdbt5NGxGF2qgtwM0s4+I/HJ
         3uCdRFo5NkPMoF7hRylk09eqIx+SeTOhEVvFLfKZ60czPsbUZtUDcjeLWcsQbU11HvKl
         +WVItSuwHXTyy/fquaXFQ8YVH8r9MDwstGzKhabdI2FHz8IfohSeXoa1Lvds/MCRW3n7
         86gm8EMYqfMbWRvC+QJ9KVcuWuPOrBSVNvBi++5P4Kmrc3kKFkcZpsAPdD+1SRNvOPh7
         Ob/Q==
X-Gm-Message-State: AOJu0YzFiW3CyikAZL5qYR7Tlw+6wRoPRk7Le4ZeRsrmfgLo3ByXlT1o
	wLIcJw7O8Ir9QF4RChM0fAz+EWu7tpzdyEyxQiIEMqc0zb/OrA5XPHkTgH4CvuhGCfLYGzXt07q
	7D0y6nTOMPQ==
X-Google-Smtp-Source: AGHT+IEqvvl5IDZrkq+erdrvALAtnjgQ+gbMikXEztvmVio1kj4d5QsiU1yKxBJ7fBGv+DDrQWDNiGmb4OlG6w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d495:0:b0:604:125:f0cf with SMTP id
 w143-20020a0dd495000000b006040125f0cfmr545286ywd.2.1707401536474; Thu, 08 Feb
 2024 06:12:16 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:44 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/13] dev: annotate accesses to dev->link
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch will read dev->link locklessly,
annotate the write from do_setlink().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8dc953bcb65cc0469f7df962314b87..8d95e0863534f80cecceb2dd4a7b2a16f7f4bca3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2974,7 +2974,7 @@ static int do_setlink(const struct sk_buff *skb,
 		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
-		dev->link_mode = value;
+		WRITE_ONCE(dev->link_mode, value);
 		write_unlock(&dev_base_lock);
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


