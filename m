Return-Path: <netdev+bounces-68816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D4848676
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AED21C20DCB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3E5D90C;
	Sat,  3 Feb 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjpkSFrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE65D72F
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966177; cv=none; b=gCIikLGlbCmhGUcRSB0CE73svWZ3rIcS7ERcvyZZK2KvT5MQWDx1sQH9C99/Uz6DJWHPIvSS1cXqlyseQlt0lzZZM/KFmNj5pszoagP50/DPI+kj+W/Xk//lj/paaHH3qpUQ8rf55PCF6h60nvP4eb0slo42A/eojBzIEL4godo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966177; c=relaxed/simple;
	bh=q1VfIyh7r7+MD4cr7Svyd+HjENDCjukI0tOGzzk4XSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxBcTsRTF8P56qtMvJKr5gKAudhf2yhiykgXI7nRByzOVXOIVpGpbWQAViMFuewaiaJqVnvYNioHhVbfOuwEE2eVaypf2kDoiSLgdD1RTHaW0Nmodm8FkR5EZ7r2iyWt0AjfEywlSO5+3SkNz17mRAz9KwqswfbrJSve4nszzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjpkSFrb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc65783aeso13542215e9.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706966174; x=1707570974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w40yUWxDjUscjW0n4ZOrqPO0/XOzhBMxz2Id2+l7x2Y=;
        b=hjpkSFrbQSkiKrj84EWs+2TWBYhwlD6d5NwoAG7+w0XXoWchI4qge0+2lITCKXj/Tl
         wlosV3vB73/3TEqZGcIfPdWpBWVfqirgWqJvBY1z7VKEPM7WUXprqP0uYZtIgrTGEeyV
         Re9ur8RpanX52oRXj0y+rkktfqGGliCofwKJZ/lMvr3olXbrSW9b4C0zUBC+U/JYS+Ut
         3zgZ4qqAHwcCZ3NHnGf8rF1Z+uffzmkDz6TR/2B8vlqtrvQ9ML46X5+qoo3GvEtTAnXu
         ePzLBM0yjYhR3A3vU5bGx9Ti+4exg3APG9/7XoRLVYH2HBAeEuK9jpyPJy+++5uEa+9n
         qqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966174; x=1707570974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w40yUWxDjUscjW0n4ZOrqPO0/XOzhBMxz2Id2+l7x2Y=;
        b=JbEb7vzgKg4sUFHKcfbppoFhz+N+ePY3gmS42+cN5JGl2kW6O6skSkjzGM0lVBMsVQ
         kBHIRPp5mMbCV01dHVmGcn9wlhj+yqBb7TmYmZz2WAf8UnOfXqPMIZXSIVAc3iSTFqSM
         LaLCR1EQq9Jcp3BwYhxWG+SSgOfV9nbHta5tmqjnYSSVdB6waevAmM6FyBBLR8f2VUH2
         FK7Sg7mivQYgLKlv1gM2jBVap8VTxY15JN1uXsrxUwL8WSr4SZ+6RzX/DqKICQ9dbuHx
         GKHC+A0S1BGIK+sw6ycjEcjsKpU91U0OgVbtcmP89eyxaG0RmxHdyh2rHWBOqhP8/i/v
         /WHw==
X-Gm-Message-State: AOJu0YzlnZ60gsqO0URLQ1fOn0ykcQT0D0vb7J73K5aBKyqdwW05xja/
	kJ/X0mm6pDfiYPh7U00HMp02XWnCLU4rflNHBuxdo7UAl4+zq3Dx6ROpMCcoLfIB6Q==
X-Google-Smtp-Source: AGHT+IGL6UQGS8E32VWptNT2zeY8V1sSJuJOtMPt0O9Tvgktq35IRLl7w6iE5VM2bWOFbaHcpKpDLQ==
X-Received: by 2002:a05:6000:d2:b0:33b:159d:6bdf with SMTP id q18-20020a05600000d200b0033b159d6bdfmr5331185wrx.52.1706966173731;
        Sat, 03 Feb 2024 05:16:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEoZvXFtpI2lb+l33Y+0HzZ6fLHz5UkLap99qvRhf2p0gWX1Olz5dQnJVa3yEanOedEnQlo5ssjDwk5YTDr4kwoV271snRg0hNyX/drmEqpl6fvWQppL3Hw+pzGcsikT06kUD8rOspZixTR17Od7CLD+0RsgQRD4UGJDY4rdxLQWtOhxVXq6XXhAm8w4BE9fywDXUWsFKjI30WsdmSN+7P0a2uDmOtzCFhIHHkEnbjdKLtZIPByAigQD27klo6kDd02L7b9K2YcUoVCd0/OCWcB7EJiA8mmJ+DqWMPx1pe/S4YtWFbJYRtDipaY6VXbefBjY5xI2WnsnnCFzge2elMwV/LB6drPr7l
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b0033ad47d7b86sm4036456wrw.27.2024.02.03.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:16:13 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v4 net-next 1/3] tools: ynl: correct typo and docstring
Date: Sat,  3 Feb 2024 14:16:51 +0100
Message-ID: <6ab1dea7fb1f635c0d8b237f03a49eaa448c2bf4.1706962013.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706962013.git.alessandromarcolini99@gmail.com>
References: <cover.1706962013.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct typo in SpecAttr docstring. Changed SpecSubMessageFormat
docstring.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/nlspec.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 5d197a12ab8d..fbce52395b3b 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -144,7 +144,7 @@ class SpecEnumSet(SpecElement):
 
 
 class SpecAttr(SpecElement):
-    """ Single Netlink atttribute type
+    """ Single Netlink attribute type
 
     Represents a single attribute type within an attr space.
 
@@ -308,10 +308,9 @@ class SpecSubMessage(SpecElement):
 
 
 class SpecSubMessageFormat(SpecElement):
-    """ Netlink sub-message definition
+    """ Netlink sub-message format definition
 
-    Represents a set of sub-message formats for polymorphic nlattrs
-    that contain type-specific sub messages.
+    Represents a single format for a sub-message.
 
     Attributes:
         value         attribute value to match against type selector
-- 
2.43.0


