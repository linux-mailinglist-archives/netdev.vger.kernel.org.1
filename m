Return-Path: <netdev+bounces-89034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF888A9429
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB101C217F4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDFA73199;
	Thu, 18 Apr 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDmpRVVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5C26AF0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425779; cv=none; b=BHOcYI7aA1vUjyRKT2swCtDL+TxTFJ72aEpbU3VU+ftEIkDHhKKl3tPdY4JFymK254rDCIOAvmjgzgPBa3p4Gi2ito5+P8BZFgTEFuEwirM4ixb+Cjt+EFD0SJKjizM/T2kFwgFCks2NQWV763UWpi+M5TuFg77LeaaiDmLgtBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425779; c=relaxed/simple;
	bh=xXJa5M0q+Z8yeg9D7zkV1EikixOTeNXOom2Kh+v86rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOBVdGEQMj6VsVF6KlnmYEZxqOSgi1/hGPmJB/fXi2OE9iKbqhMtWUONGCwocjNhogftoW2UW2kgr8mn+CL9ZsFuIy+HevEMbIvweNi8T5xrETNyWzWNJUkXsLDIcCquaWb2eprU4flxUQMNSn1h7Hl6BljNScx+m843wpeUONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDmpRVVi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so397382a12.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713425777; x=1714030577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tAlmVA7VN5CM2a6UW3jGyKbjIgNEcqj7ynoi9wUhLY=;
        b=iDmpRVVinTtZkY2+7mlRapF3uCWw+xb1D5pFjN9ihs95+c+Z9UXHVy0TjM/raJTbcq
         qGeCw6lBkBGNgWnQC56f50WeJllLQojev8+07vRgnlW8Eo8J+L3f0AAOGe/0WKXORjqE
         sEmgOqvMiCakDIK+uq0M+Mw7pEjXzmYbCWBV+mTelvGNWj/2a1wuql5OC2HIiYPZhJi/
         DezKm9ghkB8vhOZal6o9t6bVhYgk0KnW52MY4ZFbZN2WtJV88qO0vRPgfyjvGymfJ6xl
         2krwl5YR3iSa8ppGmK3jfq31EH43wULMW7rNwF1TlwthwW9wzRMEpM2HKdLEpGiJTcwU
         UOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425777; x=1714030577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tAlmVA7VN5CM2a6UW3jGyKbjIgNEcqj7ynoi9wUhLY=;
        b=WPUGTZ5a6XSOH5rJ+L6IgBfzRuO3wLI/TOPUva2wOl+AJaxOdo1Ogsr/UuWxzz2MAe
         07NkuVpgmlDM12+gUltvr9rjmsbrYGNLkApJPWwv99IHIB1a43dI3rx2E/rpBrTG96Z6
         8xNwSC4K/VBa58r9J9ef/usv+6zEKqSisBZzF4riAc+vBhGku8Ya38Q+elvPkz3NRYGF
         ZuT6tD1lgbFs0DIEd4W3CihgWa4ilQiQT6353c+b2uB2C6n6a6QiFOgS8zNIvG2ca4mN
         Y45UA/I08VgIdHibopCwiz9PJYP5U+0TRBBPM3A/1V7JoWX5g60icPbpPucVEwIbjxsO
         IlbQ==
X-Gm-Message-State: AOJu0YxvPvltQK77oNlRmGjgcWiDux2dGfw7oS4qx6LjpONT89ZO7NdV
	lZ7/CVPNCcpCBoA2TBVbx6TBNhgFwBPwvZRFEkq3znbnflj0eAe3IVrsLYnw
X-Google-Smtp-Source: AGHT+IF/pPT+0TIoAcGwVxp1AjLR29aL6r8bCpu2lhhptazOzLSH5c3pibF7vyk2yY/8ZRuJxOtqcw==
X-Received: by 2002:a05:6a20:551f:b0:1a3:dc33:2e47 with SMTP id ko31-20020a056a20551f00b001a3dc332e47mr2276971pzb.4.1713425777114;
        Thu, 18 Apr 2024 00:36:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm841756plt.287.2024.04.18.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:36:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/3] net: rps: locklessly access rflow->cpu
Date: Thu, 18 Apr 2024 15:36:03 +0800
Message-Id: <20240418073603.99336-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418073603.99336-1-kerneljasonxing@gmail.com>
References: <20240418073603.99336-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is the last member in struct rps_dev_flow which should be
protected locklessly. So finish it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ed6efef01582..8010036c07b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4533,7 +4533,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		rps_input_queue_tail_save(&rflow->last_qtail, head);
 	}
 
-	rflow->cpu = next_cpu;
+	WRITE_ONCE(rflow->cpu, next_cpu);
 	return rflow;
 }
 
-- 
2.37.3


