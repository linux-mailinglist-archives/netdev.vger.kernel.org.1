Return-Path: <netdev+bounces-204868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6607AFC544
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565E13A99CB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D37220F38;
	Tue,  8 Jul 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="JailAMKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5A298261
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962695; cv=none; b=MTnKMGTbgbRqk4l8aK1XPcvByD3CTjJQ0GdXJl6PbrDhfyktTzq1Pony/XYyOkybbZ0VjR2mB0JGLNi/ewaGFKyFxffm4MW4V/9enRfMNJz2rZ0zCEYDvUXif+V7hcmSzvD12cAPHCTjg8MeF+BTqCYAIb6wkYz57aE0PUPAdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962695; c=relaxed/simple;
	bh=4tRBDxMtruDyjx4h9FeUGhCFEb8lNysnBN5KjVruqcg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fwEbQNVeZlBnQnrIa7SbS6ecNPeW8zzLRZXfQW9Rk8Q9n2KKimyOSGLnBfHP4cHSUhclHJdrEIBjSDYIwJRf8Z6zL+gcJ5LhnMINOUaHUIGTMfC5hlW4ajAYfzcHn74RvoE0MdAagkbAF748c9FSqI6iyPjMvgdm46tTTjW6zX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=JailAMKu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so5734253a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962692; x=1752567492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECt+dIdgaw3umoEGmjzQgPet8hBsCkTrNh5MzSehM/M=;
        b=JailAMKuFHarC56HXIWsNsKi9b/mRu+AruWRpEYrOv98Xbh3irEL6UnRE9OnGGoi1h
         ujqjdkOyivBsjbn6VE+ivmCvu9xV6cXk9qz31CKpEAt1asj7qD4XN1bMH4p9LKd6iygj
         48G37e6GDTrWOHAp2qrvoiVoYrGtL++u/0C9IJ3rC4R6ASN+attz6QJ9eDok7aQE7oND
         nh7r5jpVR3MPYOX2WCFR+e16mDdWCDkKZPjZnPBgp1hL1OR9EZ130UzvRimJlbqDpzjF
         eC9tKS+TxZKEtfy/gkrdc+ztmkuL7sE5ibTw3a1rlQHPTrEP/qgRsLoMYEu32jt/ei5v
         P0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962692; x=1752567492;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECt+dIdgaw3umoEGmjzQgPet8hBsCkTrNh5MzSehM/M=;
        b=aSGQ6EQR65ccCFLNMHcV8oGIpE6x+HGFlaD5xQvvKUBlx7aFobRg/Xh5ap8CSu7pJ9
         pfEQP0xYjru/cBZK5RGeOwQGNUPR081Vz1H9NW9y8WJnh4wqK2cnZyG0aAM0Vhul8r0V
         5Tsf4zZs4pHK9H+0bTwmNBhA6PKu4Neu7HAZrHYIUnMZtRvCCOLmBHv/JMjsKEHubT3w
         RtKecjKGIJCoeqR3G7OSJZGVmFwdhGvvzWPGUof/QpCI5unXeUEaBHN9vsuRj+DW2k3i
         i4/3JTue6WJkWMRhkGG6UIg0Ki6CBrg4a484xsg/RZUA9Akp5lEpoMHHlqb2VWdBlv8j
         WPhw==
X-Forwarded-Encrypted: i=1; AJvYcCWcLNNOIZ/MTTDR7mLZv33B7d+hz5d2/XhN+J/a1HKwrt/243rE5RNio5tP08jTIbHxyloz+E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWedsa1FnZSBGF1aYiod15RGhtDBHz+MyKpoeEkVh+8ADSvqqQ
	dyzqMuppD0orTONOQs8mjOTp7tZqWqTvCI5pxGkllFw99Zpkdq4A4UQ1xqmu1a2aZA==
X-Gm-Gg: ASbGncsnQ/ZMty2DDPWE2XeqGW65cgObwLkbRqWdHtKH3YqGE/y+JVk5aOvDp2ZdZpO
	cF5Fw7JH3jiP7+3ibiYEz7ATZfO4Copd5UX0uc0HNYrSRuTCepQGHXw2MBgFF1w85r9Cz+OUsIL
	i18j1zFdcu2mgUYZ77LnlG9PkWmfJmXlaZwXesVZ+DqEoPJ5SVkM/WsWR0nnNPIRi70kk1JAllN
	UodYWMTPUnVK0t83QyFfGUWqjZiF/R/D0JcCCx8z7B907N8PmNg9QGjmljJmMs1pQ9GYqpf4d1S
	AniK+AvIIuSAy1clZMfhcmiejFcBJwyUgRU7I5vNzrJ33pa8QrWdEGqTpn1M9/+y
X-Google-Smtp-Source: AGHT+IH8qs65vRzOkiBv7Armbc4ZYw+Y95kPHGW+aoYsxCldr30MbvH4UbgdZEYl/QTOe4GB0PCvEQ==
X-Received: by 2002:a17:907:e916:b0:add:ed3a:e792 with SMTP id a640c23a62f3a-ae3fbd6160emr1558661666b.47.1751962691879;
        Tue, 08 Jul 2025 01:18:11 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93f2sm852055566b.19.2025.07.08.01.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:18:11 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <42811fde-9b80-44a5-bc0e-74d204e05fe7@jacekk.info>
Date: Tue, 8 Jul 2025 10:18:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 4/5] igc: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Language: en-US
In-Reply-To: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
Let the C type system do it's job.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 0dd61719f1ed..5226d10cc95b 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -435,7 +435,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 				     &checksum);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index efd121c03967..a47b8d39238c 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -123,7 +123,7 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
@@ -155,7 +155,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.2


