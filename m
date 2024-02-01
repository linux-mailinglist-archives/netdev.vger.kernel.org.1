Return-Path: <netdev+bounces-67872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02392845294
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938B31F2B11F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6FD15A480;
	Thu,  1 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDu50QIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCD159571
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775632; cv=none; b=BeqKOdLFRWBuEIXhGKYca6arZgxbPAb6euMZc4pEZdzeU9h2P6hlylaBhEnBuJxnuvvsDpvnkD/1Vfn/Wgc4u3CXT5v6Nt0i1MvXypOUWKz5aPIyNsWqTJ+lhx1p9ODDJ7Mr5IUTZMDiVkFOa5XJdY71PWaOE/kyImjwpcwhbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775632; c=relaxed/simple;
	bh=HpVbHkeOqkF/1RYJWf7zKLBWQVQE639n56ds1nqcRNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpE3yHkoqA7vO/mdo9z5x3RXrmYKBVmN8h/IMm6dLCSMkqWVGhr1zCZ/DgM+9wU67Yl8n1bolmgPC9UBzqwZw41BOr6V0GRsmgL/yWwh+7WIEsRWrLIrnEbat7YolPeWKc3M24fF3I3rAW1NfHPdFNcZ8JO9c5XNNx8S12x+d4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDu50QIB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6041ddaa729so2980137b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775630; x=1707380430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmiXWwm1UAq4DNGfUdAw4+QPa0CLlToqX+zE/vJCLA0=;
        b=EDu50QIBIGS7qTv3yth91S21N0sPfLCcXvyMOJRC63H0yPljFSqwx2G0My9es9ZZYS
         l1eJn92it5gzBnqqbwcXgETWHSQnj55+9AiJe8KnY1wFxCV48swowj8Ruh3sQkROpeh1
         rFc4VRT/uKL0bSmpVQU4SctFSFzJR3ysG0iYTdnDH6TSvQ0zjwbhq/EawJPidUdu1zFG
         ExYTr3pMSddXM6XRvzpKBsqz9oWbQJ51xHa+ejsl0kj2C7pd/Oeg+lBJ//29/3zIUkiL
         j0is6OKgYQsZM3JE+kLrEnY4noSWVYzxi7wqRBBU6l1d8UEQ3cRfjUaSkaw7st1PtfYF
         jvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775630; x=1707380430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmiXWwm1UAq4DNGfUdAw4+QPa0CLlToqX+zE/vJCLA0=;
        b=aqPQHkdvs/6LgpgGyDsJye0jNbQ+KWVw6i1He26ZCtLEMvrYIW8GlrPYzmCGtHw67T
         3/SBx0y5Qqx6Npjew6iuoW4cnDmZOSRx2FQulIXrpQRQCvQ+WBm27Zlr83emJ9z/tAyq
         cjKQB525BfHp69cGc1Tzlm4UBmhXoAlTZ4+3WG1x+Ucvtq8DUtix+AAaclCBxUj4jPMd
         fxl2Z39UlT/gNYlTY1UK4CerR8dioK9lbCIEt9OSeIupX1Ec0/ZbmZd+ZVKFZa37j4M3
         gUoHRSXOdCXok2eeCtHkObgzvFxD5+0rJ0GFVFeFrX+tyZPUAIbqAsjUUN2BKp1mJUbB
         N60Q==
X-Gm-Message-State: AOJu0YztgUYKypo2ZpfBXN6dffGTg/yFXF5/igRC8y7u+3RBkssolCaW
	MZfgXlGh88j5Z9mreBDhkSB2vk0/pBEOCbeK7+0csO/hSi+EMaiHBjRlHZOnQpk=
X-Google-Smtp-Source: AGHT+IEv4ezhZn7fQc6akmyy1ZyIac6nMT3H2WBZdoAKSRIj3lAH8hKA8UsS52HfYxXkpvRUe67mug==
X-Received: by 2002:a81:77d6:0:b0:5ff:604e:2bf with SMTP id s205-20020a8177d6000000b005ff604e02bfmr4064811ywc.18.1706775629851;
        Thu, 01 Feb 2024 00:20:29 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b616:d09e:9171:5ef4])
        by smtp.gmail.com with ESMTPSA id w186-20020a0dd4c3000000b006041ca620f4sm209090ywd.81.2024.02.01.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:20:29 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v2 2/5] net/ipv6: Remove unnecessary clean.
Date: Thu,  1 Feb 2024 00:20:21 -0800
Message-Id: <20240201082024.1018011-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201082024.1018011-1-thinker.li@gmail.com>
References: <20240201082024.1018011-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The route here is newly created. It is unnecessary to call
fib6_clean_expires() on it.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 98abba8f15cd..dd6ff5b20918 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
 				clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


