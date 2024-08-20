Return-Path: <netdev+bounces-120184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42816958821
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4931B21F51
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181F19049A;
	Tue, 20 Aug 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRLTn5dt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945A18FC80
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161433; cv=none; b=Qb8vWcm3wCS1l3a9RrWCPOYrX9XxdNlhd2K7FJIsCUgGZ1xz4wKExTmnhhtetAEzfqsyAx5W/9k8a0zYxTRVR6c66UdEilcf5/EPvcQchYe4TCf3kjm9IsXx7JmPA5F65llTuUSW4jULzY2EH1W9I224VH5s03TJbdSEvLwqCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161433; c=relaxed/simple;
	bh=CRbyTO4VHkSm+ayF0Ti8oPicH/UIR4BZeHQJvPd6J8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ogGR025nYQ3E2rtI/cA0MThKI5V2DmaN4mvQdOvAw3RYpyTmNzUgaSbz01Uwkny3oMB4ZguNUqugvPxmRt65cI9P1803N8djKxDg10RLWkH2DFPjItXJle7JeLdWn0ziJ/FH+KOukkryigjZ9hrCr5JSGUZGDtRuBhO859Loxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iRLTn5dt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso60723605e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724161430; x=1724766230; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1XMeyDmodCe7KZthl+BnWSu3Nbgczd7OGGhn6K/W/g=;
        b=iRLTn5dtQdtXI31/3LFx53DVMcS/VumZOATKoqMSzh4uNBXIHm8wxTJDUxg+mTzjZj
         ZnBFhCby7lYCU17ePQzat6t2+u3bfmFpLz/4zUqD3mfpsP3bPnElKz9kXXx7j8cKGmZk
         BQkDmrLMX7/DXqhNX7x/SpsrMka7pBV5nEWGBJebTmJe9J1OyTwgWyQIpZ1wHh+I42gj
         rXmuhReE/kWdguEhx+r7Kf7W8j+XITnWzz8X3QjtFPwn0mm0pJ4PZM4FZtON5VphJy1P
         3H1fwO0QMBRL2wckbkRkxXjr570x8AVcTg7ysJYjbFvKTGQCj3AVLECwnSxuVBAXCbKj
         f9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161430; x=1724766230;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1XMeyDmodCe7KZthl+BnWSu3Nbgczd7OGGhn6K/W/g=;
        b=T9no8ET/MxrBwCxW8V3ka4RiuZITjkuWqpwVA4PvENTYxRfxKiV5YLzKMrC+hmyFWK
         1DSWHv3KCcX56erRUvoeJGP1I43mR1r9AaxGuQUYGFzKugwNGPaK8pGD8BacaiXsHpZF
         KlqIVfJZXn5oR4SL4OMBRqUCORYsrq6/fFagfeX4nYwZSOmcdaJPy5AyUDN+/TNw44tJ
         YmrCBrIUJbG4/OKzwlnZn9u09iM3r/G92821i820/t5X03oTXb3kA+93holJUtWybJGl
         PjwnCAtAza4AHzH+uoxHTo7DW3zZ9LTYJ6ppjrFG+EabdjtqEZHbfPwuY3AnSexINQg3
         9Oew==
X-Forwarded-Encrypted: i=1; AJvYcCXmnqBsq80+gCHwmBFMEa/MEZzsBvdYZYN51zNdWZJlGuwsXBs7YIbpkSr0lD2AffdqKOOlsvl1DykOBVVqajj/xMTFnmyb
X-Gm-Message-State: AOJu0YzoYyFeNu8uyRLwixwh7rv6/14C44L2PadzUNPFoTx3p5eEqdui
	dLD1UuSLwU45rDawioVQqtuBmCxwRuU42ciYW6g2hiRoXHMc1GdrYly8wXdgZBc=
X-Google-Smtp-Source: AGHT+IHBWCmam+ulMm2FM1FGLnrPJ/iowdO3I8ObDwrPHCtP4njXnNaxIQIGXyL+mmo/wO6NYs+ySQ==
X-Received: by 2002:a5d:55cd:0:b0:371:8bce:7a7c with SMTP id ffacd0b85a97d-371943155f6mr11277051f8f.13.1724161430386;
        Tue, 20 Aug 2024 06:43:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6a42sm762670166b.44.2024.08.20.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:43:50 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:43:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ice: Fix a 32bit bug
Message-ID: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

BIT() is unsigned long but ->pu.flg_msk and ->pu.flg_val are u64 type.
On 32 bit systems, unsigned long is a u32 and the mismatch between u32
and u64 will break things for the high 32 bits.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index d5bcc266b01e..dedf5e854e4b 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -377,11 +377,11 @@ static void ice_pg_exe(struct ice_parser_rt *rt)
 
 static void ice_flg_add(struct ice_parser_rt *rt, int idx, bool val)
 {
-	rt->pu.flg_msk |= BIT(idx);
+	rt->pu.flg_msk |= BIT_ULL(idx);
 	if (val)
-		rt->pu.flg_val |= BIT(idx);
+		rt->pu.flg_val |= BIT_ULL(idx);
 	else
-		rt->pu.flg_val &= ~BIT(idx);
+		rt->pu.flg_val &= ~BIT_ULL(idx);
 
 	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Pending update for flag %d value %d\n",
 		  idx, val);
-- 
2.43.0


