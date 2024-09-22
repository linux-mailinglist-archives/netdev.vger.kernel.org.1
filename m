Return-Path: <netdev+bounces-129175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBB97E211
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F8D1C20E5E
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1979BA27;
	Sun, 22 Sep 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ge+6er3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6DDC153
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016624; cv=none; b=Wh1DAmscmiZrgbY8e7D/lhcF1d/jDnuTngdR8U0nhmqX4rovZ3/n0+VRdmB8G/WNMppZJwFJO7dArYDWgQuYlJHOZAB3TFbwM253ZljR9BRbY8/6PS5YJN9X6exsftOHN7VoD9MqM9fMAJEx05kGG26dR3A+7l8SJ1Vi6QVWr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016624; c=relaxed/simple;
	bh=rfP49NcdbwsNzXUNp5f7ISbizkdes0QZurAgqujz4Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hda/Uf1C8WkYXwY40sRPi4BHWBJoJmjwjcSXbSlxjeo4yq1FTzHZLa3geLPKmJD3pnRwPihZhfibJrqMNFlgfAUc/TktITJvtsJn7hM6lLgPGZcZj1Ch0vPSEcqZfb1zqjG7jZ5b+MrzDDh8lF+sfzpqZSGeP4/LEbFrr5eYfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ge+6er3b; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4363155a12.0
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727016621; x=1727621421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyVWc66giTUBEyVXjUY3pvJmuDFaMPkAt+mawlB1FXM=;
        b=ge+6er3bXEI4ZTFnF+NRgqeIpmx/DyJA/x9rpWVC+dMgu1LY5XNgYgOdXKrQra4F7t
         TMHIok/QgGfukAIaMBoIWPz3KocWYiG+pdKTy5DebnsElQc549PQjpqxQEB3U5iX2pNZ
         mM3HauOc8odaoBnz8+Dv1QGb8bS18FCzxvJE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016621; x=1727621421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyVWc66giTUBEyVXjUY3pvJmuDFaMPkAt+mawlB1FXM=;
        b=i0pySa8c//yAwSRrawtqIvrJ+fTCCyrFnUodljb/qjbslC+S6kUqTYSmDSXJ8QXdDh
         kZN3pfmIevsoMijLpRr0sMcz7hO5wvmU+dHXuA1zbJkyepbDDnNy2th/YCY+ulD0jsTC
         I2KHyKuqaS/oJNYQHNGevjAli/yhRuz95oI7vUdUBK+9NGMn4DJXhG60l4W5Ya8PRh/g
         /UBOWFN4Ee1OXsr0gnM+z1cG+r0LZnDOWe5B5I5VAyKF3GLw3PY/3P1l97vJ+efjcqJl
         rbiQ22j/tNk3igwWFnVLH2MRh9BEPvWLWk2N9yVg0iaNmvRTwXV/aP9ddGmhV4XRhQXj
         dVYw==
X-Gm-Message-State: AOJu0YxVhAkyKX0j853ZKSgpUEPecfn8UwpQi+CLwdjATBHCZDSsh21d
	b7FeIVH1tbTuxYbocX2tWjyA7vTcKfistCp7HhGKn5FrTe410oWEquhHE0enIND1gyq4H6iRhlw
	JI4M=
X-Google-Smtp-Source: AGHT+IH6wZ2kWh88EkVDKUU3Pr1sgIiLgXuT9kPyugC/ite5w1ds8/R0pet+TxhAt+ofuWHmbzirOA==
X-Received: by 2002:a05:6402:40d3:b0:5c5:bad0:df3f with SMTP id 4fb4d7f45d1cf-5c5bad0dfdfmr2721261a12.22.1727016620977;
        Sun, 22 Sep 2024 07:50:20 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-102-52.retail.telecomitalia.it. [79.20.102.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8907asm9724838a12.85.2024.09.22.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:50:19 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, PATCH 2/2] bridge: mst: fix a further musl build issue
Date: Sun, 22 Sep 2024 16:50:11 +0200
Message-ID: <20240922145011.2104040-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922145011.2104040-1-dario.binacchi@amarulasolutions.com>
References: <20240922145011.2104040-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following build errors:

In file included from mst.c:11:
../include/json_print.h:80:30: warning: 'struct timeval' declared inside parameter list will not be visible outside of this definition or declaration
   80 | _PRINT_FUNC(tv, const struct timeval *)
      |                              ^~~~~~~
../include/json_print.h:50:37: note: in definition of macro '_PRINT_FUNC'
   50 |                                     type value);                        \
      |                                     ^~~~
../include/json_print.h:80:30: warning: 'struct timeval' declared inside parameter list will not be visible outside of this definition or declaration
   80 | _PRINT_FUNC(tv, const struct timeval *)
      |                              ^~~~~~~
../include/json_print.h:55:45: note: in definition of macro '_PRINT_FUNC'
   55 |                                             type value)                 \
      |                                             ^~~~
../include/json_print.h: In function 'print_tv':
../include/json_print.h:58:48: error: passing argument 5 of 'print_color_tv' from incompatible pointer type [-Wincompatible-pointer-types]
   58 |                                                value);                  \
      |                                                ^~~~~
      |                                                |
      |                                                const struct timeval *
../include/json_print.h:80:1: note: in expansion of macro '_PRINT_FUNC'
   80 | _PRINT_FUNC(tv, const struct timeval *)
      | ^~~~~~~~~~~
../include/json_print.h:50:42: note: expected 'const struct timeval *' but argument is of type 'const struct timeval *'
   50 |                                     type value);                        \
      |                                          ^
../include/json_print.h:80:1: note: in expansion of macro '_PRINT_FUNC'
   80 | _PRINT_FUNC(tv, const struct timeval *)

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 bridge/mst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bridge/mst.c b/bridge/mst.c
index c8f7e6606c3c..fccb7fd68140 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <sys/time.h>
 #include <netinet/in.h>
 #include <linux/if_bridge.h>
 #include <net/if.h>
-- 
2.43.0


