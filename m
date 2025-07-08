Return-Path: <netdev+bounces-204866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0914AFC540
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F342016CB52
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913029B8E8;
	Tue,  8 Jul 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="yaUh9fXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7D18024
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962647; cv=none; b=WQPojW34zG/sJTSaJzj8iU4gNTHgh+qzdbGAahRMNqrPaC5Ir5ZK+flME665zRoqO9UqlvfYrJTNTN4bEgWuy2ANmrlVmAPupq0i9QUv4QwlLx3YZUcpixBsJJ8d3oheeoRKln1VK5+uVAyJUxhWaX3jS500S+bEzAIO6g4xBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962647; c=relaxed/simple;
	bh=YSSGeixcEDsqQUi6KpQbc/x396vhf+wvU9JvmpkCEyI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ue4NXkpxfcE7N3MC9DBtuj9RRkPogOoCXMN6KGsbnVdXUE3SsKsGK9BQ1grvU/qlZk/DZjRv1GytHIXyn8OCKOrRAwpI0GlOmu8MQ0F3BsuscMzuTHSc1VzDcpaG1TBd/ZzKP8igNBu7w3UzZy4wE1KMnY0GR9ziHjk7ApUJhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=yaUh9fXj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7328874a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962644; x=1752567444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVpaJcnbnoIEODWV6i1mADak6czrX9HvszE+3IuKkMg=;
        b=yaUh9fXjZecZ789LiPnduZJ4l9yNf/45MKRMErlK76nV55tDxOyZUMYKAcYVCDn/wM
         WysvD4Cz6D88n2d9ju/YLBKTehmrjiugF+cQ1hfy+VmDo1qvG8+MV/OWlowWbrUUVtOT
         pumrkiQIGGIRh8ZCdvBGgRhNtzTjOTK472a16kXNDMk/TbBArR4zotliGlmws/K0JMD7
         9Oj/NrzhpjfR++NV6//2CiLqBTLeRL0k1gPfN83mbw0M0Ia3lquHyyRG/eb4z6jzmOzz
         xhd6Ez4Z6Tsm28XBscaCVU32QxN1SS4noPA/Zl/UcszhSg51nSapLaRdNlVCR0UOmHaL
         hh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962644; x=1752567444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVpaJcnbnoIEODWV6i1mADak6czrX9HvszE+3IuKkMg=;
        b=lhf3NZareGp8Juc5i/w0Z26ebtVyeIbTueg5QU5+XEkdxlAzLzocXqhJeN+YnOldGi
         /yjsMVOZhgNlyGpo73pJP+SbB4vcx+XmscZq8rN84kF+fpuqSC7eMaZB66MniMV/ZGG9
         y+nu7ehPlUcQgu2b/5PTMsf3HZmjkhDL77dkvN5TcnaLeOfhWFYTsIEijGr3I+K+Q3rQ
         fcG1U6jG+cprQtoboELiBKvhiaIgxW/herkK3wbkmPYnwUIR62cjr4nweGLu+doy+HwJ
         dlKSIO0LY5L/spX3ogMjw7+MQ1PKqiaMfFZb+ZsJSWybZPbCzTWKGA5+XgiNPaARtswp
         wPvw==
X-Forwarded-Encrypted: i=1; AJvYcCXk775SFHmTHMan6ho15YDWuFAbh8pzLaUhKxbG/wylyN+tGPfp8kvXcy7qiEpzu0v4Wwyftys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7bPR00qYYTQ1RpkYGE4/eiM8ntyVHN+COuzcItwO/bA1t9t6
	VAWt3EQOBRpGipgm/CNL3YSIZSii+F7Xh3u1jRmuLBVd2lhMeX2p8DbYdqS4X+oMhA==
X-Gm-Gg: ASbGncun8/nNpuZWUX5E8vYw7sIdwcWe3iZ5K//GMQXwel2at0tV6p2QYJKcjezhj3k
	4G+lweCuv4yX9ZqrCW08I/JvoqPiqz4Uxb0XEbj2+d8pwq8jcVZ1/SnUbkTbdphZCaZkMP1kkpD
	ZOlTsnugil3uj/DgsZSUKMhM0YgsrHu+Daod6E1pL0EV1wSACoarn8KLyJa8saT0JF0UYmf5P4V
	7q5xcQH2HSngFcQvifhjDWpoOUSDoBmF9GsT9q+tYdyxXHSuB3mE5Lxhzd2wU4JQizZsIMNw1Xc
	oXCDr2m2pfAOY0zGKIAq+32KUmsYWX8R0nESdy0zw+Y6oW8FYsGQ4dROOLyNU2tB
X-Google-Smtp-Source: AGHT+IHSomL4kUwS4v66NKFo0e0QgQflYbBjsYqQWaLJxPqYuMz2uNeLF9DuJgr5kGRilvNA+9EKTg==
X-Received: by 2002:a05:6402:348a:b0:609:7b40:4e8e with SMTP id 4fb4d7f45d1cf-60fd2fc2ceemr13979357a12.10.1751962643551;
        Tue, 08 Jul 2025 01:17:23 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c798dsm6717800a12.50.2025.07.08.01.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:17:23 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <faa67583-4981-4c99-8eed-56e60140c28f@jacekk.info>
Date: Tue, 8 Jul 2025 10:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 2/5] e1000e: drop unnecessary constant casts to
 u16
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
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000e/nvm.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index c0bbb12eed2e..5d8c66253779 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -959,7 +959,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)NVM_SUM) && !(*data))
+	if ((checksum != NVM_SUM) && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 16369e6d245a..4bde1c9de1b9 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -564,7 +564,7 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		return 0;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
 	}
@@ -594,7 +594,7 @@ s32 e1000e_update_nvm_checksum_generic(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = e1000_write_nvm(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		e_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.2


