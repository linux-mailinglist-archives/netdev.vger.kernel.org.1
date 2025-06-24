Return-Path: <netdev+bounces-200810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C73AE6F99
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEEF1BC130E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC222E7F24;
	Tue, 24 Jun 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="a6EUyojw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5623C51F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793472; cv=none; b=V9xTqUBhkdAc6lX0mPgh13QX9UvwoISDRtKu7tgomOvb1mJaM2gb2nW6sN8ZEZADcHcjlhAU98zRnLmqTUs7Y52tFqSaFTYjyIIc9If/IgieFJHqNCZeOgF8OgxvRXnrSjChuW8/vIrlA1fnm4M3p1UuY4QSCnks5SWnZr2+/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793472; c=relaxed/simple;
	bh=/unps/Zj+Fo5fjYrblFijTt7uQ/0xgDzX3gU/IlPovE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mQAITR+fgjCe7Rus29X/pFG0/eRt19bgPhk7UCLl1zv3MW6wZTxndHfHw/GTGgs8tmMCrnYpmtlYZZ2synHPz+B/NwvLlIq6nZK5YJL2583+IQiB+sVbcoZvGbu44ZLVnpxC1bfSCIwoiwA+c6uF3i+9MQWEgGCMXvFNQjUaE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=a6EUyojw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2e9fd208so144415466b.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750793469; x=1751398269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUUktOVf8Mcbc6vJVhkswLwRwVDucF8ZH8DrIAMKlHE=;
        b=a6EUyojw+/uMOt//RbCowJDGdxeuOvCF9SDuEnBEdTMV+smcuvMk0bJh1Nt6bLsKen
         Sry9KPj5ntuYYxKEfR+Tx3mfyJ77BvPCFTeOATibvJs7SlMlSnmPflFpIYsw56q3TAlC
         9kck/I+fEniv6xyfJz5ebwIvwlA2AfL32A8BxkF8bMMANY9B1MhHzxyIYcZmAfKJptG5
         OT7TfQewP6bM/mRtO/juscBtKnAHDdqtTBnc4RBksbu8wMyX7p2qMIzJ3St9XNmcBmqI
         QyIVxFKojwtSr65jue33xs/05UMCNHKbflujMreJR+shW41p1bCek5I6EZeLyuNbVesJ
         l5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793469; x=1751398269;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUUktOVf8Mcbc6vJVhkswLwRwVDucF8ZH8DrIAMKlHE=;
        b=FsuD6Av3/Zsv67D7LM9DXx9KaaHkWpgurdrohQCfBRl5Cy5Gz6cMhhQM2ZYo0BY2JL
         J8yVzYgTaQ2XJgBx8fAn20hQP76eY5/HgQxU7hp+Jm2BEoNAtF5uKxeqETj66iOwf/7h
         shNcPNZQRRwtgPVhTy3ytVI/gl7xWJcxepIWHxGihRDHx2Jw0C4xru0nyJwQMBtdb6i/
         G0UMaFEyCm7T+jdWZLfAgougBUCNCTGNn7KiX67w4IM1GAi2MnpzoYr248Jh1dhWyIaE
         bIEz+mhj/l77SqFAY9kkArgNLfh7IGBwlj291YiiR6ctEcjMH7EbtpvRKe+SSdrxZVNp
         GT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5WabcxVGnkP5EutVk60kGr5EtaWaOOJkOlx6GdXr2Hd3RqKKyZN9h+5WnSE1SQ4nscLXlaG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkID/qt60ZwODFES2945EUi2DVr/2/c/Ddal8+gUlnCX++o8oq
	tAC3Zs8gdAGefjrsCmCCTJuMS8FjfJtLAZk6ZuOicqaEhsJ3tS8rSHGA5vwVA18T8Q==
X-Gm-Gg: ASbGnctXCCvO0OoxGuqAupmWfWkBZ27EaUPJgAmWtejyFYMWCG5C3dJB6Lo8QpK18aT
	8QDsD8otROZ29fCoSdfseLSj3XCSagLN+zx9S1GxYmYJqVO5gplODSa3MpFUjGoa71pJinId3c2
	wwU9zPmnioO0sLdJLXvXaqvJCtAiN8JCxs5tJRph6QhNgAkGUNDYHFe78/zoQdTTXF/CY5ctaRX
	MggdYyglwwnsxOMUO+pGLEJB2tJqVMEw1a2YWS11CwuSB0PPy/KzYcmfhnR6BTRFYZT/Qemo6fZ
	q01oU6LRQKttkcYrWtLtwhBxH4oiQMptmcJF+4z0yXu8LOahPuHqVhVyqv90RJLk
X-Google-Smtp-Source: AGHT+IGLQgQrFQXmzCZ57AkjARniUBs6D5iqeQVWxWnIx//eINokE70nU4ML3YSxsa95lxOmkG/l4Q==
X-Received: by 2002:a17:906:cada:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-ae0bf21d078mr38361966b.57.1750793469403;
        Tue, 24 Jun 2025 12:31:09 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a0aa1ceesm243467366b.70.2025.06.24.12.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:31:09 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <5589e73f-2f18-4c08-8d10-0498555dd6be@jacekk.info>
Date: Tue, 24 Jun 2025 21:31:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] igc: drop checksum constant cast to u16 in comparisons
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
 drivers/net/ethernet/intel/igc/igc_nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index efd121c03967..c4fb35071636 100644
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
-- 
2.47.2


