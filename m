Return-Path: <netdev+bounces-64933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36451837F13
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E1AB28295
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B181649A2;
	Tue, 23 Jan 2024 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqm0YraK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB4163AA8
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970771; cv=none; b=G9ydOd9J9qGAkF0q6m+lI0nqMWfjnz+qHdSUtxI9dAd7jTmt4zaIL5Ii1tpgQiEwApT9wWFLT0PPxIlRm433yk+77zdN7C+EhSrP2A6mj3YSMsuqGMv1PWoMIYkAnO11pKBnNzpi0lRdwRY4GzQpm8SsZNL2qRyXOT1lAjbawOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970771; c=relaxed/simple;
	bh=4HPvynPR3Ko1dXfNMJBApuVlt9+5UyaMefuvQ347bXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imcK4SF6P6FgjtxlR212J1VjQ9qYnuJRVg9wSTSQyxWetUzypmsPLgFUD+lwJJSgH3L8a25H1FQ2l1MgRUF8kK5khIoEWR5NI6pRrSZqCWjWG0qOU0IXl/9+xkjI9pSMMkdf3ixHYneGpOo7PDbckz2z8I1bIHAUnNaN8yKYR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kqm0YraK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dac225bf42so2005511b3a.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970769; x=1706575569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy3Mn0T2j/xVq+cywviUlH77t9Sq4eXs+6SMvLbadC8=;
        b=kqm0YraKJjzpYJ0YwLvcUV9muskZYih0/OWTiUjwU0iTPpX4+z/HD1HqdE0ll8XXQo
         3alVEQPZs49egUMpsaZItiIygz+MgfGy/mQ5mVJQ0Kopo82IFuX0A3Y47OOL/n4iAo5u
         opxu+BKRp50NVXte6m2zV2mcumq2XjSUDKdBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970769; x=1706575569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy3Mn0T2j/xVq+cywviUlH77t9Sq4eXs+6SMvLbadC8=;
        b=b5yqZe2WqfjQMyANz970VLOgT+ZYH26KOM83E4Z8g4HGVnXzjSzzpsa2uOUu9yezUo
         /tU9y9FiQFW8QJs3OLmpSW2VFzvt5gHw+7sfFbfowexmAORxHq8BbOEmrA52tDfQkWzL
         2JB/9/XlSxaBfyYbvVDwfRMDDXrJ4YJXJKS4XN/jJmtYZg8m4QyVvmz2NTDcCwym5Qdk
         5UVeYCfGuUsRRILGoz+rZ8HAecFnyb/iAkrS5dmTKKK2Yw/PFEvg/huJ/1YhhWFCVZu7
         2InbqLi675hvR68w1P2L7/zkqVyJ+ficFCfHVqra09cplcVSzkWxb6WbTqEtW/KwNi0T
         StqA==
X-Gm-Message-State: AOJu0Yz/+oFb4Fk9HX4oCnupUaR3wAp7aTgy1K+ahY5RZ+FroceBtJJC
	eEKvj2n4qWDXnwi01K9jwWCGoMFBxFFismBVdHYfSJoVq3F9l6gam4fMRdSFcw==
X-Google-Smtp-Source: AGHT+IEUqe5dx8QwlTdc0Hf1S1rf52LAuqKi2r9NnTuHQLNKc8Ev2tu0ODkf4nLiv9kWyuVYwBzGmw==
X-Received: by 2002:a62:d444:0:b0:6da:63a5:3f32 with SMTP id u4-20020a62d444000000b006da63a53f32mr2087437pfl.66.1705970768640;
        Mon, 22 Jan 2024 16:46:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020a62ce04000000b006dbd9fd2bebsm3352305pfg.163.2024.01.22.16.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Du Cheng <ducheng2@gmail.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 28/82] niu: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:03 -0800
Message-Id: <20240123002814.1396804-28-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=keescook@chromium.org;
 h=from:subject; bh=4HPvynPR3Ko1dXfNMJBApuVlt9+5UyaMefuvQ347bXs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGajy61mavJLiiKlUcTrC+GpKwlQS32yLps
 eqkOZGrbz6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JjxnD/wLi8HDy6bvcWJHrheHwblvygg/rt1qDMgmueTdsD10P2P5hSQT9cDWcxBgYmPx3QSgkoN
 DI0zgPvjfV2y+4HKJvovXZDLUygnMhtUsoRYA/UNHeRo3fxPyLYLjfrT2mt9AgGEuctdamOfJfN
 Nyhy8b3RuJcDOH2afROIUlXeKQW8YrioLMJjJ0wJ/IcOJ96RyjCKSL3bkl5xvm5M44pX1p1msMI
 VeP+/9xS/uFDWzWbIxGAMyJmSE3mvm/7oqHlESxAcrq95OyuSOQELRAZh8vKFCW/rqedozh4HdH
 sVJlLxUPr3Yn2lJrlHD6tPKkVqGzcoeWyHjT+l5gX7BV+4bdXdkPJWwtqzIqi2rDJbgdC0K3nel
 nWwtV2xdyauZ1lhOAg26PgxW9+keBeEYI+M5ce14tRu5NjyjSKkqzT1oC3bjhXpmHDTXuyC5ncX
 z1CeOGSLxClD7kcLVWxPWNO37GNJpnVjy8Pbb0Ee7csz9cJOwmCKgjZeyqwkLvq5RHTlC4u0veZ
 DTaVGQArMh2rZAOiKSyag3NbemYIb6c2JHe451VJ8Pt0UjaPUxF3vXUs5NGPRXIcDYxNemUTxCv
 2Lsl/k243rDBq1Z/j3U8smcznTLGYwtCbkuYBOQGSX52s6/i5Xih21gZ/wq1SKE9OyNhm+9EgFl xjTJBfyCGFJiWDA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/sun/niu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 21431f43e4c2..a4de07c6e618 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6877,15 +6877,16 @@ static int niu_get_eeprom(struct net_device *dev,
 {
 	struct niu *np = netdev_priv(dev);
 	u32 offset, len, val;
+	u32 sum;
 
 	offset = eeprom->offset;
 	len = eeprom->len;
 
-	if (offset + len < offset)
+	if (check_add_overflow(offset, len, &sum))
 		return -EINVAL;
 	if (offset >= np->eeprom_len)
 		return -EINVAL;
-	if (offset + len > np->eeprom_len)
+	if (sum > np->eeprom_len)
 		len = eeprom->len = np->eeprom_len - offset;
 
 	if (offset & 3) {
-- 
2.34.1


