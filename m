Return-Path: <netdev+bounces-243047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA0C98CA1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A94643453AF
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB29239E9B;
	Mon,  1 Dec 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZWJFnwje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD924677D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615597; cv=none; b=Q2wQcqBQqdtfAZ7oJQf/bSF9wYJ5UJxiYKZ5u20FU32wkILnHCI9/jp47SLenoVsSXINh9/MauW/+meD20wwdFe29V4CMg6fvfnNROKy6qjIVucOT+6/rxodkaS0FY4fmdWKtmB+KXbWn0EGF7NG69nj4QWBKYpU6c7v8LsAmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615597; c=relaxed/simple;
	bh=N92YPaj7o7GNabX4ghSuaH+u8KSbRHDRHEzpQW5LD1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCYjaDBGothuYlYOZbCpQoNAkOFGYt/5YJ5y9lk8P9mYLYPs8j5arccRtQkLgrWBfQTsLd7PWKcKhq830aHQtMU1A/ru5t1yMiKwsO4lxkZDBPpk128Y4Li9i7DSkZZHxFnq/KsMMSLuvzR6KHP0Cv+pdHfrTXOx7+8MyGqJlhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZWJFnwje; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so5776049b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615595; x=1765220395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/hmcvHY1zb6BM0ItbDrHOl91BPNEPPwb+1fauDZ6JE=;
        b=ZWJFnwjexeR39dsEUj07oX6St8kjGoR3qhRCllqBCifl36+ZUINN7GCDav5kQHzDM5
         QpNq6WZBLi+Dby2HOu05wIWyUI+dKyMLot/3NYwhp9aRWIQA9fCA5JHfGusMv7HM5Pli
         MycALGOgH3ea7iprf09BS1X2orWD8xVUytDS4SqhAF9XsMgmRyvlkTTjqdh+sGdW3Wjr
         ojeAg2n7zmAR/0pznVjH2Brf70LcE7xbhPM9X/m+FgF4y2GRmT4Jyh+3nbfO9KKd4YhT
         wCmGjw3pI51I9/0smSoA/8UvIsSYO4Dc7kIXG8SYhPh1zZ+w9KHdzdcHmDb6Yme/BArI
         wpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615595; x=1765220395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/hmcvHY1zb6BM0ItbDrHOl91BPNEPPwb+1fauDZ6JE=;
        b=T7SMGkN1NFfgbhWEEFjdehIM4GqcZA1uUOM644ThGcDZhLUdjb0JpYjMGps7oehUlM
         aYmKVSNXDd9huGOvlxQ00F/o4Jy3agB6D13wHNli9L8Q2uQXqjHwBL1XhbFa5gBX91t4
         /vVT8mvgZS4DtSFiGXw0i9vpVUXnraHofhmWTpkVIQc4UwNCg0slRwUfebsCLBkweS5f
         tM0JorMRGQ5oTf5YgTOviXc3LlkMHuOe9wKo1pDHaOaBgNvFyzG52RnzqVB3OpLXAqMO
         FRChq3TUSCi/9k5LFnkc/5eRUbFJA/5W9/QEd1ItyQGakQuKz+wc4AIE9lglD2zj//Us
         CvZA==
X-Forwarded-Encrypted: i=1; AJvYcCVWV/mpU//SsZp4W7CD/+iuwhiu3wE0VCRfYtdpIjFAuiVBF4pkhdzPWBgp3YtkgEyAStLxXMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv817RsyeDEGpKFII+3g5SgQ5s0DjZ3EkTtDfsxQkGfmsxJDCz
	gKr0bXXX9Z4ZRRjCbL9VHv3VaNT5Qy+DYxmpCC6R1eQHdoEFR4YG4gWuzbW3E4Fbng==
X-Gm-Gg: ASbGnct/LP6ZC1mmftzz3Tk0gzMDNuQ7mAyt80AKrrpCfxxOrTauCes0SsxlM5Cs5on
	bcbmjilAlj6iPSu3OyybvnPY1gMVuYIRmG1SuXuhfMilmzEFjCk06O7nzqQJmZ4klq4HAa7tj1v
	/IzyOW+rDlq6XwsA9JujJQbqHCNVc5CHtxF8HEIsKpqtE5gN+qnzCPA1MCvFb9qoEp8mMvyS61e
	yM/AKSRwSIdz/UbKYh3Nl4IABz881njtOqUCKD0WM4E6H2e4HfhsilMsjw/H8LH0K2+BYmkdDj0
	GtQ5CsOjVuk73AEI00UPCRioWE2Xm2Wp4rtS9JmI3HExpMpQhslh7sCVgPMWP8u8l/1ZoCxcCQy
	lp8r3TmfO9KamvA08JFTDSzJ1QZ2h5snLME4P407JWpnieHfLOFoeqXLnyiWeJ1SM+lUAu0p2dL
	+/lk0OgcYypF/sGvzwFIQGhUjF6fOioiG6sic6R2cQbcRPsLEFLgGf4WlA
X-Google-Smtp-Source: AGHT+IHBvcPSMRgy2sxnuIzMNNaRhwcxl90iD1Bt5mo79Q9GbJYhhMzKORihE2fWVevSsObir6CPXQ==
X-Received: by 2002:a05:6a21:3392:b0:35d:8881:e6ba with SMTP id adf61e73a8af0-3614ee3889dmr46121361637.49.1764615595238;
        Mon, 01 Dec 2025 10:59:55 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:59:54 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 5/5] ipv6: Document default of one for max_hbh_opts_number
Date: Mon,  1 Dec 2025 10:55:34 -0800
Message-ID: <20251201185817.1003392-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changge documentation that the default limit for number of
Hop-by-Hop options is one
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7ccfdc74dc91..de078f7f6a17 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2503,7 +2503,7 @@ max_hbh_opts_number - INTEGER
         and the number of known TLVs allowed is the absolute value of this
         number.
 
-        Default: 8
+        Default: 1
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


