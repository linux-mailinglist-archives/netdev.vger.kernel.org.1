Return-Path: <netdev+bounces-202346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B209AED765
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E5E174C52
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04D21B191;
	Mon, 30 Jun 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="CLaFk7Cq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405B17A2FC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272424; cv=none; b=rYvjVDJOxDjMK3mm+iwtAAB21jj+awXX+LJZtujw47bNQJC5LkGhJcmt7hGljRG/yU/2onoHjb2Qde7jauO+n3UBh3ctodhx7Au7PRffsqzeIF2ULR36Br0cut0swbbgtqDImgEOWacQiiz8hqjwKx7lx8v9nZWvWYR2GgxhpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272424; c=relaxed/simple;
	bh=vDVOQW7uZqypTNvIPaVLyTlNUdJHZkKd4NOmTYHJQ5M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IONpdZqty9jDreN5n8Lp0vjwGDx8A5DQeiyazHRl8o7SQhTTBWh/D8jpOZbHcSzovhkoVU5hgi7lPS98tpim26z6h90i4jLQuxCVNQfEQ1Xysgw28FFb/0HmWJTnFL/8Ii7M8+emS6w8GpmhCfmzFvqd21aD4rd55WtarvxUBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=CLaFk7Cq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae223591067so328895866b.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751272420; x=1751877220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Drc4Qe3hbpt+SG8bFeu7KngruDo/DuOVb2Yac0bZ/A4=;
        b=CLaFk7CqVzG0bVp0MhQPnNGQerSBKSln/3oMprozERe42c6RZaPQygz9sE1NOddaHD
         ekTW7l40QIn6I2OIQHj/EFj9QpymYp8XLkdMTuODL7CvjEBO/D9qqRG+GjoBCfjqLR8z
         uKDsU2bbf9VRX6nb5C8sr4JLaOeX/KVNl9fjahQBllKTVX7Ve95ANfAD4cwkUWpe3IcZ
         FWYkz8VN3Qe3Ra4QZuRT0VFEQ6ZkGLBFtF0aRpB+V8KfRfQDGxNC31gQZ1gAjyTH8bNF
         i6umVm0IbbQLJnQyfvFEKyLhKaxscPcrn4loZ2vj6W69+gvYHabqD0iRNdRgR+FihvLw
         7EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272420; x=1751877220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Drc4Qe3hbpt+SG8bFeu7KngruDo/DuOVb2Yac0bZ/A4=;
        b=Uy4c2bcvw4pHfuIptNjP+UNXfNLxSEg9Io0iU9mzmIiVjslHHGQ3+D6PNIE3ag3v+c
         irjefxEKglfgjJsdPoE6fSmTWLRD5YeC9Ko1qoOOqY3z+SY2/JGHdB6T/QitgD/Tbh/a
         Nq4Xoaq30twoTEbVXvb2m9c06idGy7hhg6bokU82n3Fqj911j/PeejdTObXzIqXtlrLp
         3zKGGnYa77KGoNZtPJq2ZI2t7eNK4Aehe8Hm1qWg6LREtL43yjSyLsX8Rw2u8GNTWhFQ
         aXyK7XVuHp/+kmCyS892hC3gL8Qoi6g0hDjRIMI2iqwX10dWpJXSF1eNbE62yl+sdd+6
         m87w==
X-Forwarded-Encrypted: i=1; AJvYcCVEUGBrlRIZAnjAMXBRKQd+cElknSjax/a2bHhbhfpYsS0e9109wVss2bYEROvn1X7lS1ZMLuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDe2c+hbeT78J3EhelwUiv154qNkXQYxMrnJhTNfGsnP9fLcY
	mVgXRCZRB6YwVO3VddgbBmDFQmuiDYmjR/C2gUEJDU2TWBhlIe6TUJ+xgmLxxQiItev+nWi/uLP
	wvhX7OQ==
X-Gm-Gg: ASbGncu7J4iSuqQnIG/eBygDUASAxM78Kgz+sh/sQqPQKtsl/zZHG+77xFup5k/NYg9
	9CVhxIBQQXbbKL7QoH9OfTFN9MXsdzKr83TnYiSeXAhmIlzRyaCIOdmiS16vv89tT/wedJe2VuO
	IyHC191idZKFz4vNth21FJzxeRSyviEGZ6nrRu/O4gNdxZWpCXd8q9WOUauGyu1HG59CEjfGdbG
	n7uRX8+cHoukQqHj1IVjf4l/Cx1ZNNjT37j4C2er1/5PYIBgF4tqT0SjHBRRi93Pabhhio7MBJr
	SPogt39B1LdOBLDAe15wRKWsd++CgmlDEM/PfXQhVSPGK5FPcbaJgzb8YDgPcVo0
X-Google-Smtp-Source: AGHT+IGwm3ndH7OSPtLkOyMh/AJI+AUHO3JsvxtRCreFKAELFj8qzZOpNXh25nN/NupdaRysl6JEZg==
X-Received: by 2002:a17:907:1c27:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-ae37b53e38fmr511138966b.28.1751272420214;
        Mon, 30 Jun 2025 01:33:40 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b24fsm629609066b.34.2025.06.30.01.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:33:39 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <22c8ffce-a0f4-4780-b722-492487d58b88@jacekk.info>
Date: Mon, 30 Jun 2025 10:33:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/2] e1000e: disregard NVM checksum on tgp when valid
 checksum bit is not set
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
Content-Language: en-US
In-Reply-To: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set. Since Tiger Lake devices were the first to have
> this lock, some systems in the field did not meet this requirement.
> Therefore, for these transitional devices we skip checksum update and
> verification, if the valid bit is not set.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 
-- 
2.47.2


