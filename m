Return-Path: <netdev+bounces-184504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C635FA95FB7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A61681FB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E41EB5CF;
	Tue, 22 Apr 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="BSqItFQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625421EB1AA
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307787; cv=none; b=E8IxbsX78leodzveKbCVc3MzLXA3TSrwlV273RmamScxclGJcnFcu5SkjfjFvJdeoJOFN/vj/Ho1RYmOeCVXBYH7KkKzp7mRlhvgREf18zewAI5uKmVnh/tfQftYIRKQpacNsA+cPEJiPIlovAjJMnRgpM81t+9GCDou1j38knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307787; c=relaxed/simple;
	bh=O9JdbRWaeCBz+RHOzJxD4pGeS7rOOvKN9vc4OCnEDKw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=NZ5V7O98i+Sa8dvz3X+XBfxipGT/B2rvnYO3UxkQDmojSmmJCgc/bvvWleiJF1l2Y5g5ML1ewDQna1xXP+22Evl0U0SwovCEvF8dsEqoBN4uOQOjZlM2cn0UN9Ma52x57jk2KzcKn61PTI/+nQ9+PbSresgLukvNDG7pAithoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=BSqItFQJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2963dc379so708808566b.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1745307782; x=1745912582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvtvMwkTmpPueoBszMdXY/zEz71N9wRSKLK+XNFELU0=;
        b=BSqItFQJaahgrs+pggrd9qENAnwBj7LLeiDUS605X2c9JWiExb/MEQlC8faHbLdvzJ
         qyAROUx66zaTF/ri4S8ffYx9qQPUwWbSnRl+IEbbQ191+bquLYUvC9QA4g8GnLdxw2sP
         i4zREDxEcxhxlh9KoGIlZRNmmFqo8Ok9cY4A0HeSV00NTd4AKCIKIBY0dR+4YtVxDXm7
         EQE16fZ1fZiMd71Uk1kUpm0fi1d4B7NA4GsN9lqv+g5xwkfwaHmtlU74hklxbZU4vIjj
         +mZzE2+eY9iQIE2ajOah7CYz84b2M5uQSQPcuGot2kZ3+pc7Om+T+he5wxXK1zXeYtGu
         9oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745307782; x=1745912582;
        h=content-transfer-encoding:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvtvMwkTmpPueoBszMdXY/zEz71N9wRSKLK+XNFELU0=;
        b=leWX1sICCf416IUbMgdeUlcIQuyMLpKYoeYbFh5vilgV3IHMUBlhVkcVSPTItd6jTG
         zNOGXsHNG6gAYV2cXMASUyncM/4jLHkEggAJUwYTFwMhCTkJkziHtuD6SpPR2HB1qv/C
         FpR7z/+YdHxtGJFL0AjLTEUXC8t/W3JLnp2kCIpDAo0DISs3VLn7MZRZ/snHcY4tw/8M
         DhLNlNBRw+p10MX2wbg6ZBnn3ooc4PwpFi1yaW6auDPjVCxO/dp+G35HVn5GSPyD29sM
         cEro4bN65f9CuMpNPcL2PcpoUHK3odudBQtCBV4xQo71H9fe5at+KjLhoL1hyBEknoL9
         6i0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdiRtp4h9ZNGCsJ96vAILYFjfQLwMJc5D/X4gI+xndTxa0EKQzZOGVWKB7l7mvh9ivBGq9Lcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AWc11k2TrjAhOCuIKxEi6MFIWZWU10e72xMtomIw/cNvYVM1
	dxUREw146Ny06n56hdYOSwhoGCQnX5db9OODxWJapFc6Q84oKSnhNHpxiLdleQ==
X-Gm-Gg: ASbGnctkWtlVB2600NswuyxddhvXb21q2tk8jtxY55JBGuRWRoSqSfNwBPtUt4BCPLb
	oK9gY8Ar/jW4d+cVx/bxr8tEiyEmWWhyl/fSehL3AFyEOfysbMLeUHgfAWn3bQpMbU4PYtIjebm
	XjBDtqDAI8pw+A5IQ7xzZC7Dcr9QbO+uwT9DCdLAZtxJQegWUzh4aClvljY5eToOcu/PnvWindm
	se27O3afTjGYJR7Y/6upkk/whwqjKzUJLd5TFc4Kf2ZrD/IkPGkwB4ZWeNl7mpABggwhAiu4naD
	l8y1AHeta/6OQ2hnx4k70j2SrR7adYyZ7YRR08U=
X-Google-Smtp-Source: AGHT+IGeWOF7rvAQVW49ssEllGvauDTfczcnSBjqrSKrwBLr+txCO9/Ai5Axu/MLfDHRRPf7+rlXcg==
X-Received: by 2002:a17:907:d7cb:b0:ac8:17a1:e42 with SMTP id a640c23a62f3a-acb74b1ddbamr1344361966b.22.1745307782452;
        Tue, 22 Apr 2025 00:43:02 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4235asm615437066b.39.2025.04.22.00.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:43:02 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
Date: Tue, 22 Apr 2025 09:43:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] e1000e: disregard NVM checksum on tgp when valid checksum
 mask is not set
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some Dell Tiger Lake systems have incorrect NVM checksum. These also
have a bitmask that indicates correct checksum set to "invalid".

Because it is impossible to determine whether the NVM write would finish
correctly or hang (see https://bugzilla.kernel.org/show_bug.cgi?id=213667)
it makes sense to skip the validation completely under these conditions.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
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
2.39.5

