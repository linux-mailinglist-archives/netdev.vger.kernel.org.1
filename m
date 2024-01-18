Return-Path: <netdev+bounces-64105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9386F831186
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 03:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1B11C20CD8
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 02:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DE28F5;
	Thu, 18 Jan 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PHPfExvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889A53B5
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546306; cv=none; b=a1/SnyNqhI1fEoHJs2XQ2m2axGe/MWt4i0s3Ynbos/E3SIhWmmVEHoo8nfi3tbplts8oFN+clRdAiNKvbjHAGtrSKcCRQBjuAFs7ai4FMlnWvfpYOe36J55W3cD0UpS9ti9rCseHKpPPVuedTgLEqU/xygiGq6EeSSJWvafKZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546306; c=relaxed/simple;
	bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=FEWtufvE27t+HmV79tetgDCLOY/0JoGzX7pc3VSi9b8wJsQMyRjnbxmYLUnoplJpcA0MdEBNcOIabUBvzxoQb4wmduySiiWwOiMSd6nVMo9mxXpPAHbQ1DFy5KPJBnE8PqqWr9+tlDkHjZ10mZ+0Z/utHnlXvXbHV1Vgbdnn4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PHPfExvq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337b38d6568so2513302f8f.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546303; x=1706151103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=PHPfExvqFP9dNkw/o1LSkVNxh6G6osL4+UztZaPS6M0NUeISe5flKcZVRQz+UKZbVW
         oARqCfAPr6CwtY7/naIvTKlrEGSe8pfSmeWSIEE40dcrWIQbuERvvrGEBd1jlGLA+XBA
         0iEMeDvqlD9WrkZtuA5HFhzlH+OyYaXe+sBgWo0aNsrdHQTjjfUJkJpgaPJxvcuViza3
         U4d122bRIWi8OtteFp87ekFHFOkw2nCY5vDX2LAiDrHT/Jeg03xaLA5S4Zh4SZ+hOsOL
         EWB1sxcXlXH1cGAIGs2DeOW9Aa8a8sTZaWoN5S89l9kmZ7NUYqgz5ZxXrAFT3gun6z0G
         qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546303; x=1706151103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=jPszeTLw8vS4g2ewuVq7PSyInu2TkjrtLcePUL23Daabb3P7xon/BId9oR6SV5Radx
         ELL+WrI2STvRutJLJv5W5lRXL/Y+tWzMCj2eujnwRHdppK5AdfG1Ngt7Wfny9dN6MOUB
         xJVvog5v/9kySyYwd0SsRqw7S+bcHLiT2L76mHWXyzXv70jjd5QL4/c1GHw9EGdr553i
         JkuLMClJVHbIUzQ+P6lZpnIortm2l+g0Jn5T1B2LeNWEF2wqRho2PwCaPcBLEFlhElUQ
         ecg1rVIEOrK9CQSAHUNEV/3Ah7sVVkEE5MMaefMA6jHjty8CDTpDQQoHroGL0LHl31Ya
         7YwQ==
X-Gm-Message-State: AOJu0YwfBwlfXFqB9FmIlM3wSvRhAXv4ig1POBbVZJ5apm9T+6i+Rw36
	P5SPbAx+MZ/7RVyjjnz02n3xfBSuvCmd/P/8KmYr1ErGMx2zRLBxhHThMUpEuA==
X-Google-Smtp-Source: AGHT+IGuu+Qi2Tx2cCYMGpPYN+O0khIiJHE3lWN6J6IrC2aFuK1G0SyFIM92LO01t3+UwG9sk29NlA==
X-Received: by 2002:a5d:400b:0:b0:333:44e2:16b7 with SMTP id n11-20020a5d400b000000b0033344e216b7mr79098wrp.49.1705546303326;
        Wed, 17 Jan 2024 18:51:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:42 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] selftests/net: A couple of typos fixes in key-management test
Date: Thu, 18 Jan 2024 02:51:33 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=736; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=; b=E1xkCdz0M9XB7LOyp1foBBxJnUvlo7QXSIQqLpKlLQB377ZXUXuwOvQUCG4cuseiQQNIU4E6N RodDkay3j8aAB5yco4ZxHozCAOJCI4dCrc0vyqgUf83CsOC7UR+yKr3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Two typo fixes, noticed by Mohammad's review.
And a fix for an issue that got uncovered.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Clean-up double assignment

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

 .../testing/selftests/net/tcp_ao/key-management.c  | 46 ++++++++++++----------
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  1 -
 2 files changed, 26 insertions(+), 21 deletions(-)
---
base-commit: 296455ade1fdcf5f8f8c033201633b60946c589a
change-id: 20240118-tcp-ao-test-key-mgmt-bb51a5fe15a2

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


