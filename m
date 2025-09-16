Return-Path: <netdev+bounces-223575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B1B59A26
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59D83AF7D9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532D32A822;
	Tue, 16 Sep 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+5t/qJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A631E0FD
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032813; cv=none; b=TL9y6MPGS4Vg6EQsRQ0GmiscXyo8QtHmHrWpwEnIXMD8Hx1i4R22V3X6HpeQ8awnS4PZIB6Xn1pZc1yF81jIGWROgFVsAcinSBKT6eGK3BXPW3ldBW+DVO91siDhJayLn/JK7L+BnSIILrJRBruZ5xfmj+s6Oge9F5EW7AWjFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032813; c=relaxed/simple;
	bh=8kXZ8mustuOts6fjWYk4d+cBP0Antdmx6EdQY14uoc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGqQttX3MxVhL4nBnJ+qJ33lql2IK6sY5oTy2hV6Grfm3cAUqIiENDFEK7dDS9TbdndQXFPiXm75Dafyp8OOWfeLjH2oHsjLTXZfuswp1ckL1QnR0D3ANCsp/N8yfMcOozwkaxyNzt3jqO5V/Lm/qBk/vl5M/rcsao6ZY2pI2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+5t/qJm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so2497478f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032810; x=1758637610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWyjAQAw6oOR0hQA+TLJZa+oJDeTMkDdqD6GFlMZ74A=;
        b=J+5t/qJmndB5aSrHhKdeLYotFK/Ivb+QzXDO77ePMtV6c5U9AGjzMUuKqr9j8mWKNM
         uqq3LM27tsVBsvwftk6LGhBpU4yW/gdhcRt2anJzVuwUG3PEPkQgymDTgRQdepC2PuOB
         UAHYACGBysxVGnQcif+l/DPhVGWws7wNuQpP4cjEQFUnNXh5Omkp1dXrdlw+hIK36KkH
         DrhIEaNAR3j8B16KQL4RTAP1CWZY55uHk2tPSw4wIiAwoD9/3ZUUlnDsPVOJvAqUjs28
         JfjdCYmoT87SKuFD/k6ssNkoHtxTKT4a5zw1OXb8U4HCm+JP0k5U/cgNDitxc3zcGypG
         HYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032810; x=1758637610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWyjAQAw6oOR0hQA+TLJZa+oJDeTMkDdqD6GFlMZ74A=;
        b=SH3aBELRi0asDJ3XlW8uNjWlaKp44qC2BTf6xgw2w9dyDm8RnXTEtpGb6uuTMVI1U2
         BlC13TPFpjFFD8dvWOJWG/A7qSeLF6GxB6nE9t9+nyl/fpVT99oeadiPFAUcHP6IkuLe
         kZ5K4H2e4gwpjXx9sOcKQ1VvO82nEGzSRTIHDCwYmbH1EhO34IZkoweGKZjbrqHLX7A2
         F6zUtEPt14kG5d7q5HHFFfZpbOJX04rGlKBfTn2SGsZP4MP6fc4ZeFgy4rwyDHhrGdiN
         vLo63iqSHPUccchrA7yAX2+CH8U4clChkq8qXRguhnaFSjg50t8KcccGlWBkA3bd5eqV
         GdHA==
X-Forwarded-Encrypted: i=1; AJvYcCVacRLVoFHR8vK0nrSVOTVCCK5Q14QixPfpPjIy0ONqG1RN/QTcKqnZnNBcZnNRwRgB8hzcpq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4BM0PAsTCXTb/RIURmJCM1dhwxcEDdm95PLece32COMyaL1c
	tOFxu4MFR++zFG+fPrqwkJR8qd8rVK+VFGvhW94c0vZBA66gzmD1LnFP
X-Gm-Gg: ASbGncvIwv222qSSfD0NUdj05HL4hyQ3bETXrMrwqUtbnpMQbhCRrgXXOpjBBlDsx2H
	/5zRypwFi3N81AXIT05926sVDF8NUqbra31HO6r8IknhPUFBBRCueiDQbXP8oPvo55Hf/MkQlh0
	g7Xd8N1amLvrX7GfMfXiYJh8OE/3PpfobIVpBfpoV4kEFDZ2XWQ8RjlWkcWyFKmB01Ik0GidEYj
	NQAZelNWnuAiu7sDHBv7SROrChIBvv0cKAkH99sEXb1A8kRELzoofbDjn6oRbZAyo+ootFCb9wb
	DLrS+82Hr2m6WWia4hi4w5ACiLoUWbP8JLEJEO1odHpVZu1lCHfZRgsfyFsVXj/oHFEDIApYfud
	WH0Ix31JNT7y0eguK
X-Google-Smtp-Source: AGHT+IHU3hfW06HfZ4bVkA+LwufnCWKFWTyfWtrSce2tsCNJo1ucNKPVnm/IBbCLweCaWzu3mzRnuw==
X-Received: by 2002:a05:6000:4287:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-3ea80ec89f6mr6940248f8f.19.1758032809733;
        Tue, 16 Sep 2025 07:26:49 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 03/20] io_uring/zcrx: use page_pool_unref_and_test()
Date: Tue, 16 Sep 2025 15:27:46 +0100
Message-ID: <5d7e0f7c0dd6da6df218b5ac249fa0e1a053f4c4.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_unref_and_test() tries to better follow usuall refcount
semantics, use it instead of page_pool_unref_netmem().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a4a0560e8269..bd2fb3688432 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -787,7 +787,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 			continue;
 
 		netmem = net_iov_to_netmem(niov);
-		if (page_pool_unref_netmem(netmem, 1) != 0)
+		if (!page_pool_unref_and_test(netmem))
 			continue;
 
 		if (unlikely(niov->pp != pp)) {
-- 
2.49.0


