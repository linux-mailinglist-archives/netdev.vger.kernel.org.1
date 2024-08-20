Return-Path: <netdev+bounces-119962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8C957AC4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBDF1C20F0D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DF15AC4;
	Tue, 20 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9G/ayjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726812E5B;
	Tue, 20 Aug 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116237; cv=none; b=PgR95BHHynk/Td0KUY/lxRbwsOmQVFNjoeiDe0qSjVRnl6/qcLEtgbWTaWvYRRKXyuqUAxoMdI+g0G8hygfto7BQ4TNHgog5qNbqDWuuNXON8PFRnQ3XwL6+O5+RqgoBJl6equkfkMMIapSIHib8M+1lzRS+5xym45GfKaOFejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116237; c=relaxed/simple;
	bh=OmmGg1dHF0tSEhbhEXNU0bo5BvA9neSkTTk/VgZdTH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IH+Co96zpUIhYK3i3KCJ73PUkm2TWfoeBcwDBa2m/Cy2IcLRwfBlHft/JuXNQFhO43VCT2m9kiF1vjKJ6RtzkZqu3XpxCd/pf0VRUMQ5Ok+5d/I+O4TNCh7UPzZkADzgsFPM8SPROnf09fGAID4CF48HkKsW6KJSS2CQYi55KQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9G/ayjO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso4103942b3a.0;
        Mon, 19 Aug 2024 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116235; x=1724721035; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hd7i1iYLnvF1vPFcpAzXEodIK1n1br5eMVwIyVFZc/Y=;
        b=e9G/ayjOy1xNZaC/uFX7AGSQAjifWC2YGsSwyDxD+LrUosdvMbMielLGtIa7mptiHH
         JAF5AYPHX+KCreqDCFyIXWgFKKIA5ms0cpPw3lF0/A6k/Tw034RGXgjqMpvthVXbP0G3
         +m+RfTgOeozYiJGRtxRGJVMirqhLSmWAnCUWr4v6v7EWkvDB/a46YFop4zQ6HbwXiGeP
         RbwdSXJMzMVwm5cIK0TzTfDe70ufO7fFZt6u1I+S0ctTUaEezQ3xqzuPCAIJrNEC4LkK
         qqxxUY8NI1qsen6XuLYk3Kk0wEAZWoAci1c9FTbJKIGzCl5ZjDn8W5Y5NfQg5Vhm0Qrc
         nE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116235; x=1724721035;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd7i1iYLnvF1vPFcpAzXEodIK1n1br5eMVwIyVFZc/Y=;
        b=a+q3axuDoyEYlbgueDOIi1FUJJiB1WJI6KEhqgRKHNHEmtdN55e9xUAUrJB3SXAuz/
         7nlF6JXn+D6SxHMljGdmHNRTSaAraYCNGhxBsFHZ75GcG8NNn2iCNqwE03e9YBxP2gRh
         XG4KQg3/FjDvVFVpEIU/tHSoafAUzNuypa1pXexV6as94wfxjc9kZpBfzdU2lq1uBVW0
         1/xG192h8dlAJoo6NhZj7b62/bCLyCFMlUfoux5l5MMqY3S3QZ9BQa8yzcQaFIMcwntf
         RX4f3HEwkEH1f3I6mKbuVl1dW0Xd7sB5+3irQrcBUfEFRdqbygOhl5CfGpshBcuWuL2G
         z6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX708v9dHHHMQYOTDypiwnawN7tRzFNrLtTquCgY+ZjbOk2P/upLflCz9n9nLfsZoIOso0IDtQhsNxhU89i+msJsUUyi7svSSqxiNSV
X-Gm-Message-State: AOJu0YzMk3uQrxkw3RFK0k8Y2uZRPcVVpif4VfNy7CXiKWpiATaofH0U
	4QgUYc3jU0hF50Ga8Of7KZJZ8IN6O29BbkC7WGHFcXofkZub/keH
X-Google-Smtp-Source: AGHT+IEi4Uppu09sTO5kDGLyeJZlPd56PACOJVfhiMn33QJ4HGXJOsLd2X7gN6C3v0/+6ATgUGEo1g==
X-Received: by 2002:a05:6a00:9454:b0:70d:34aa:6d57 with SMTP id d2e1a72fcca58-713c4dd32d6mr14830466b3a.4.1724116234934;
        Mon, 19 Aug 2024 18:10:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f80c:1483:bced:7f88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add4403sm7169564b3a.30.2024.08.19.18.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:10:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 18:10:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] nfc: st95hf: switch to using sleeping variants of
 gpiod API
Message-ID: <ZsPtCPwnXAyHG2Jq@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver does not not use gpiod API calls in an atomic context. Switch
to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
controllers that might need process context to operate.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/nfc/st95hf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index ffe5b4eab457..5b3451fc4491 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -450,19 +450,19 @@ static int st95hf_select_protocol(struct st95hf_context *stcontext, int type)
 static void st95hf_send_st95enable_negativepulse(struct st95hf_context *st95con)
 {
 	/* First make irq_in pin high */
-	gpiod_set_value(st95con->enable_gpiod, HIGH);
+	gpiod_set_value_cansleep(st95con->enable_gpiod, HIGH);
 
 	/* wait for 1 milisecond */
 	usleep_range(1000, 2000);
 
 	/* Make irq_in pin low */
-	gpiod_set_value(st95con->enable_gpiod, LOW);
+	gpiod_set_value_cansleep(st95con->enable_gpiod, LOW);
 
 	/* wait for minimum interrupt pulse to make st95 active */
 	usleep_range(1000, 2000);
 
 	/* At end make it high */
-	gpiod_set_value(st95con->enable_gpiod, HIGH);
+	gpiod_set_value_cansleep(st95con->enable_gpiod, HIGH);
 }
 
 /*
-- 
2.46.0.184.g6999bdac58-goog


-- 
Dmitry

