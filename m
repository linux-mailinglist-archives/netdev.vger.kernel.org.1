Return-Path: <netdev+bounces-200809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFDCAE6F96
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5ED16B771
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0E2E7F2D;
	Tue, 24 Jun 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="HEKnNKEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868A24169B
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793449; cv=none; b=vDfn8Ndpo2QAktjeE2wFiZaXSTX4XpW8lAnOxajJT0rIuNeAvtpoiQNnWHgBCkZYPWTYItRpMzFcXvQFcD+Gmch6dXqEumssNKGh+cNkgeTIoP/ZYzDh0ctISCthgVV3QU8p/27Oaomi3+TkZ5c0i12njFkf0FZq4OUzyh9p/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793449; c=relaxed/simple;
	bh=X3F+dLhp/1RYHB0JV2VsEO0q97YdigXYU0mSHzIlmR0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HNJuUFFqTn1R/lqlkryOS6YSESJ4WIguvFQtod/WMrLEo7qNokXHSloDyf1LQefMMBYpx1aDzdKy1X0gRPhS7ghu6Z4AYkYsHl4Is5mOBGMvgDh2b2ScmWwdOfdjoTcSWPwt/cOcxh2zOb+RXJEQwc3NRm7xqCQQKG82NrmNXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=HEKnNKEx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so384104a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750793445; x=1751398245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Or7Q25AbhPUIuP5FJogLrAq14LkOMcW8AbOwVQUU4U0=;
        b=HEKnNKExPG8INrU9oN/XkKfL6UpbeYXzQfKL+Xi7TbrwZLU15XbWVUGuQ7oqQeRHA9
         XLuMgiYE0vaueEyaGIIg28pm6E8p8q8TYhcM6amDkAsyZlx3wsP3TRB/T744EKeBQuMr
         lGML4DlORL1Mcbw6Nhcg+1woxRNZIypONuu/QSmScOO5eS1gqyOQX8H5SqwXqQQs4HXl
         gltj18OGhFu5ix/j5BDxJDL/b+BGtaUZ26V5Bh7keOhWwWcekwSdvEqYMHd20m2NiuZg
         YO+v4nWYE/uYbqcscE+UcKGAQqsO8maRh9BLXORYN5fg6McYsg73CVERsgWK8umTKwd6
         Apew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793445; x=1751398245;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Or7Q25AbhPUIuP5FJogLrAq14LkOMcW8AbOwVQUU4U0=;
        b=eNdH3sxSbD+EA4UP9LJJtuzo24paWhekYvOHGjhLGqqfdcJf6RyX3Y9LFxgW9LRuO4
         ZGIr8bV9NT1wbOwwyOOQkcKNG316Xm5+9UaGRdJTG9fIQ2eZdcBzJ/Lf2aHEbdZLlAuo
         KQsSI5/rZ2iYt1XC1pGFKDGzaXpgGX//lLpg43IhiD/j0BY5qCDn7BJ0BW45nNSC/v0E
         CZDDyZ5re80/DI+1p7fx+yBAY4lIPDL/38ZMD+kZyJ9KZK/6gQVGUNmWXlAoluHm/doh
         k56V3heXd3gSNEIGB16NRoW5hJdWg2gZxxfAPPCugsMbKK95mUvidC0f9kS65WwIFrLT
         3cnw==
X-Forwarded-Encrypted: i=1; AJvYcCXW6E5wvPIDwJqbrX12dnvv/1kafAdTFMYQmsBY4xoakK1Fv1IRYTRi48/DERR1KU6mHPJ5CxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUNODUDep0E8jR/4WqAxRRtU1ircYxzQSKGBw5TyiO00YslzT
	g/0dihvZy4xMlA+K+Efvrk8+L56bIhWmRzsjhKjgHZWNcysOF/V5b+hHyTp9X0HkEA==
X-Gm-Gg: ASbGncuO2p4rsKuGR7ofQE5xoc1/yqXcxdVwMMKE6JlBXOHktRAORtkzF/bSMO0Vieq
	mLh1rVwYcxVwdVoV6flbRaR1FEnjzdQ20qUbL4AxI8YzgJMe58mYt4JeD/X9KW37mLtQxFkXdOk
	e9w4D1eH/MJ4qD2WY/Q87ldZYsVJ9whJfm+xWdniQM+9SQcWIV82RtkI6NfQ9CCOXSI9tfCG2qL
	CUPmPDpsxaflGIzQT5NDidhjHc+e+xr0OSe6xyGru6ksmgSTrjaUp92ort3NRBmkAeTikrim2XX
	KesByjxYOvbOxIa1+Nxm/qjhDodwnOAZw7Dzmv3u39Wq3y9xZlyGt2DIvWSRHjMEe3qkF6d67Us
	=
X-Google-Smtp-Source: AGHT+IFWrSuPUZPjo4e14unGnQ8k0U6yS6NVsT08IObwRPjCJ/u8xTjt4ObSkbxqTVOZE0pmb+ZVIQ==
X-Received: by 2002:a05:6402:42d3:b0:604:efcc:bf5c with SMTP id 4fb4d7f45d1cf-60c18a0dc03mr4931792a12.1.1750793445164;
        Tue, 24 Jun 2025 12:30:45 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054080a54sm928625866b.102.2025.06.24.12.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:30:44 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <96d55057-28f3-4f77-b5ac-6f2b6769aeb5@jacekk.info>
Date: Tue, 24 Jun 2025 21:30:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] igb: drop checksum constant cast to u16 in comparisons
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Content-Language: en-US
In-Reply-To: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 64dfc362d1dc..12ad1dc90169 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2372,7 +2372,7 @@ static s32 igb_validate_nvm_checksum_with_offset(struct e1000_hw *hw,
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index 2dcd64d6dec3..e654310b1161 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -636,7 +636,7 @@ s32 igb_validate_nvm_checksum(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
-- 
2.47.2


