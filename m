Return-Path: <netdev+bounces-209271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B1B0EDC5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1D73BF70C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418028032F;
	Wed, 23 Jul 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="Vju/iCGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8928000C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260943; cv=none; b=snGh8qdnn7ps4oL/FD5QVU6hcmI5pMGR58YEcqcax+ln6Yd6K7bCgpIogn89G0LoLAYNDsvb9Md3ft4AzSeXJHFWgs0XSunNSPwHgw/vyVDGh9/gNQA2j+fSIT+XmZQLbVHL/ILVU0hrP6hdXw3oOnm4+qSpN0S9c0pPY9oD/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260943; c=relaxed/simple;
	bh=eo4bF0B+j1uSHHh/7KG94zzYJFd6UoheQwNXP9rsFDA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TjutZFJQLu2DvhJNRNJX5dK4vfZLBdhFgCCjc1L2DjaVy89WZcV2yvMy7Eti74vQEa9Ggs2xguUiOXSUBATOnLpBOE23qUxtuLiiV/N+AOmYp94Z/Y2lm/Zbv6NKSVv1voe3mrBsEXu48D4FbICVyuDK0FpTyfjpK/5Zyyn8cVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=Vju/iCGw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so1500791a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260940; x=1753865740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ugmq4lvRdEc1sG9XRhYE3BwB+7EDXuXGL4BxqjZaIU0=;
        b=Vju/iCGwg+job6So8mSPmxGMa1VpakTpX9ln+zQhT3NVyZN1XUVwDEoim+Usee/JMw
         suTTY59ckVNKejV8QShcoLy80fnAUrgvnGu/BcN7hPDPuru3faMO6hV7XNxrMrn+pjZ+
         dNo51Blkwul33QJpOy2Uok1M5XRGlRXZQnYDwIwps1P0Z5SYpYJiaTR4VJAMwSMS2jST
         sW+sOr8WEWHIXLcey7YaK8RhzfBpdKLHDpqBYGE5fElxIJb+l2Y7eugyHoE/N5xBLuR3
         eAIiOijoT8/JYpL0/MT76cu4Aytyw7V1R2gBWgksLdG4PbAphMNtN2MJE7TfWb5gUoUi
         +1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260940; x=1753865740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugmq4lvRdEc1sG9XRhYE3BwB+7EDXuXGL4BxqjZaIU0=;
        b=FNq/NtNcIZ9VY+qNrqzcw98jUxyS9QmNi7NCl7nMQbV+Cb4tQQgofMx5WRpJYK35pB
         7th7xvMrBJm4gvrBEYmal1DIrgyVVoEge4qZhYMPe9K/ogqd09L/mjCAtWWtPFcCzq6i
         qU7t4q4SbmqebPFTWuh0nF3MODQMdFUMyMjnOOtlK3KqUL/oWibKHt/AHpLdUhC7s9si
         Wk4ciWzb0iOpUc2r0dYWD8PwgnNdeMOCwr3hGFZdIOTSL7U78cQlNEg63q0BAwV//FEJ
         /IY/b2yd7G3AnBDKOIpDSoY96+lQVPZENBkFV/JVqDrNR5IluWowFbMbkVVyUQTzOHRS
         jWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiypvZlwDUdu+bNbeOgJDLj6AWjg+E30TULOuShaiZVRWNiBN3I9pQzhVW8D2cNqMOe3cyqSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YTLG++R+cY6d2OL4/0qOnMw9fhhQYoMPvfV1QGIFRWdiXcQa
	YDUE+cijtS/aCiUc0FlRathz3I1YKpyxxZgdDmobezRDHZLrmQQcYugWzyA91SO/Qw==
X-Gm-Gg: ASbGncvZ6lScEF+jNjn2Poijkbei0AIny2gilO6DwvRiLaObNyuhwl0mz7scagfDeiH
	M9l+tsI7hndQBVJpbX8suuAYKUl0euQUejuNjQGedKW7MUUAJlqePVP5Yj4QlVDSREVvcFcv0AZ
	alG5SFFmR1lKHjsFBWmRnA3hfuvy8Db3k7FQZBfHoqyukgCplsTMziVx2jrLRvdYB4Pu/BHPKqf
	INwkR/bgFG9lUN41nGbhykYrA3izAMMihTaX7omcef5fwlB6Y6whD5deIt9rDGozXRBtW9GdlLr
	0/Ef3OzgfI4jJBvENsm0vdtmphAkUdsX6x64+7EM/1j683er6hWpvW76f76oWQAvy9u4cvf8tHg
	KGXq9infWWN6rd1+5zQet23qm
X-Google-Smtp-Source: AGHT+IFr//0fitN3glsKj9I2v7mcguCK3I5eSA/Kd/X79BOmkVy8sFxPK0cii8eiTLSIlLO2zEi80g==
X-Received: by 2002:a05:6402:3482:b0:612:e841:5630 with SMTP id 4fb4d7f45d1cf-61346c8bb0fmr6021277a12.6.1753260939602;
        Wed, 23 Jul 2025 01:55:39 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90d55cesm8158991a12.72.2025.07.23.01.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:55:39 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <9e21249d-b5a7-4949-b724-e29d7b7ea417@jacekk.info>
Date: Wed, 23 Jul 2025 10:55:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 5/5] ixgbe: drop unnecessary casts to u16 / int
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Language: en-US
In-Reply-To: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Additionally drop cast from u16 to int in return statements.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4ff19426ab74..3ea6765f9c5d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1739,9 +1739,9 @@ int ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index c2353aed0120..e67e2feb045b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -373,9 +373,9 @@ static int ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index bfa647086c70..650c3e522c3e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1060,9 +1060,9 @@ static int ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 			return status;
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /** ixgbe_calc_eeprom_checksum_X550 - Calculates and returns the checksum
-- 
2.47.2


