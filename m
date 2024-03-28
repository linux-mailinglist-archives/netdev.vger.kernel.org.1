Return-Path: <netdev+bounces-83019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD38906C9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BA6B225F9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED313280B;
	Thu, 28 Mar 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mo8XnrxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C31327FF
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645409; cv=none; b=sit2Fg+dKO1h63+DVDAKBUFfCqpPHvJYvKwHsxKlOYX4FFMyNP5MJYa888F9QNAr6ZEB80GVtGEYs7GZ3nlHgUO6ePzy95LLKYDzmOmHC5lAG4mZYA+PPOk62LKJIIaYvsQQgz+eohmjTwkza1pg7ZDfoCd+W2ptxT/LmtilPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645409; c=relaxed/simple;
	bh=cDQ06vC2AO2hdTXvL2nVcFw/pVw+7ML0rIty1NNvoeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHT+kbe63y9StQwflP3rycBTrMv5NdZdqWaJWEOJLRJ+A5dnZkYRGHuUSjKgjdeCiJ4IrE00t9Mqu2r5EDQiXQacOZNIKW5FfNzrRSBP8J0kf7fJMlAoOP4qrBg41gwZh2Lst/VbZvfxZtvR1CJpQ1W+hyozJ96qQ2lna8bcDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mo8XnrxT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso1644776276.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645406; x=1712250206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Rf3n0ThGg2QZAaciZ/MGFx+ZUjVEIBegGBLhJw3P8=;
        b=Mo8XnrxTutPEuyDHw4HvrkJUF2u9wCB0LNXSY7HxVn+FWo68kkKav6TVCqVL0hTe9l
         ntkqnP1Gg7biSlYp4N6mV7+2ArhObXI37aO++GvTPjVyKT/SkGThsS2gtFnmcQspj6zF
         ADri6GzHQ5scSFCfB8znRSRRLHyyeallr009GQXPHW3xS18nxIRCvCwAwYap+HcQsTZC
         YGclO2DuRWBmPFS95AM7yaVSpCs3LN49Imki5FaUZN6909kl7a/q01yy17Lo2VMk+33Q
         kg5dNn0786of2u34dfteFZx/MHXxBkX2afrtGmWZdGIOd2Sk8T32gL9O+2w54ylL45C6
         SlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645406; x=1712250206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Rf3n0ThGg2QZAaciZ/MGFx+ZUjVEIBegGBLhJw3P8=;
        b=LE6z0XK97LrhxNm+hxPjcbVDfTCmYML0aMKnYi2+tHVxs3gAkdv3MtWw089yJEMelL
         1H+GWIGoJNvWhJGFYQ/RXjL0DvuAErndnYXRiNCqUmmS+46yGM4khfRSkSuiXM/3kHSG
         i1JxqeHiyMyWgPqNeRsJdqa3t9z4D/F8X3smgwbYvOj2pabuGGS4fyLe0EqbYIVkf/uK
         6uiE6TWrFZsVCBtj8hPdT43zxp6z3Csm2FwCooZ9DFxJdxIyEhO2QUXlUF1ONt2XMcKA
         D1hU6ZJJt1Q8ekArcnacJ6xHyQWJBvfygknQu1tV1z702wqMx1kUsRdDNo5KQdIfQi1n
         IHUQ==
X-Gm-Message-State: AOJu0YwwJ6q/7uWKOwKx5Zj6xKudoCQImzy4q/tgpXGFwuzLcVaQU98e
	Bq98SYyIfRxxvs6gGztQPIERFZXoAoSwd9ceiK47CuUX6jds6N0T3d7QE/1TSAiRgQTb3GzqFiy
	1RmwPuvQclw==
X-Google-Smtp-Source: AGHT+IE8RUsLi5NEWaCQpBxCzHAtR+Tt/Xs83paI2PEaSb0MWJvXoJgJAFNVO+Mxu01+BA4dDmGcfec5aB2qRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2413:b0:dc2:5273:53f9 with SMTP
 id dr19-20020a056902241300b00dc2527353f9mr249416ybb.1.1711645406759; Thu, 28
 Mar 2024 10:03:26 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:09 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] net: rps: move received_rps field to a better location
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 14d898f3c1b3 ("dev: Move received_rps counter next
to RPS members in softnet data") was unfortunate:

received_rps is dirtied by a cpu and never read by other
cpus in fast path.

Its presence in the hot RPS cache line (shared by many cpus)
is hurting RPS/RFS performance.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 14f19cc2616452d7e6afbbaa52f8ad3e61a419e9..274d8db48b4858c70b43ea4628544e924ba6a263 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3203,6 +3203,7 @@ struct softnet_data {
 	struct softnet_data	*rps_ipi_list;
 #endif
 
+	unsigned int		received_rps;
 	bool			in_net_rx_action;
 	bool			in_napi_threaded_poll;
 
@@ -3235,7 +3236,6 @@ struct softnet_data {
 	unsigned int		cpu;
 	unsigned int		input_queue_tail;
 #endif
-	unsigned int		received_rps;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
 
-- 
2.44.0.478.gd926399ef9-goog


