Return-Path: <netdev+bounces-182585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93691A89363
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958CF166C2B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E913D531;
	Tue, 15 Apr 2025 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3+TAmiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1992DFA32;
	Tue, 15 Apr 2025 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695099; cv=none; b=ZmBsMcO7p1L30WK/gTHhjITSBgbJ+y6shIliDmf655BX30FJNMFxrhwDMUJY9AB5aXdcYRipQJH09BPLp13CS43SzucHr6LpRAbIYprdYvHlEOPsZ0jaPhnfXMTzItoCYVH5qWXUgZ7zc/+1qr2pmcldDLvTMw+SAU8cuxU4xzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695099; c=relaxed/simple;
	bh=mU8tEkEpWaZa7vYG4/gYEjgm+u/ZuXTgrn+S1XZe69Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8ErcEqIg9V4v6jh4UfmcgoEZ++S3XtXdXRn6Kh/DSqgHq+2l15YrcJV1j9k8QU6J79QrNMlwYzySSYZAskPEBUkm62m3u+txLsSyeols3ew4iclgbywOmPNihpHJ8Wi6p7Ui/L5vhVCnrA2k43s/foK1hbHCYiYEBRrH1tbHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3+TAmiT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so42915235e9.3;
        Mon, 14 Apr 2025 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744695096; x=1745299896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9M+v1EGKlFCDikiYC58nVqAak+GOw8ShTXJQm6dS7VA=;
        b=i3+TAmiT/5SvSHLLJgwdt2njOEBIOm27OYQSgg0DlX2uagtADI7N5JE6dsSxSUgrlB
         evAWoyyOmLry9xk0kmhgwsSBEDtPb9rTh+n+6nnWaevArWvReU1VCGeVYDm9tCHFeHD5
         Dx0BsPZn1J+JaktjmxzRis++HXr6jMI0NZPuCwdkrBQUc/giNLy/M4y3bDatb3vzJWBR
         RFQ6YMnHz3xHKo2W0kOSosBsCcorqlYv8EjUDztqwc70Nh4mXNbwiG6yIct3oW5UkMTs
         ud5rEOzs8O89ai20VO3Mh5tM7sltK280iq4sdoGfWOIeu4PSE6RM4CgGqJ1BoVnFhv6Z
         0QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744695096; x=1745299896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9M+v1EGKlFCDikiYC58nVqAak+GOw8ShTXJQm6dS7VA=;
        b=ZvDQcQ+EdHBNAZlzK+ECSoeZ33b6dbyyHMJGKTKRBM7i+tcWuh5VKfyrgusBoeTva4
         nUD/gHcz+tPazA+Tmv98tZ/bySMYeowikZqXWRviV+disCVaswIc6usEHaWsz5Fi2F8o
         fsODsrenmRjb0tU2oWjJloQKdU3fTe7667uPCeMier82Ey82CMe5NEBZ0d03aSfEcZGQ
         bNjRXTLFeyCVm5Pk6Ckncut3vwpaKzpMRvW8K8BKewYIW0QEq6P5v1G8rTjh1Qy5TuEr
         AYj0Pwi9IMd+h3xWGSLeNLyY9na+MpiB+9tnMx8ue72JpJH3K5wseAvrkxNwhmaLgn29
         dgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCSPsXaAexZjXqlqBWG14d0NLBOysFvX/y8mafs1I19li2Wm2R5xVcm0v6NQD5dbatJ7Invcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Yogd7AYb00RwFj+vw3tLc1ycLNkpJUiWOWKybagtD/1vAFKK
	JTYWNG9t+d60w+Y2FsqsvQpeV4Y0Zy0RmSM67mdftUTq90ghXtwV
X-Gm-Gg: ASbGncsQ+sTtstJPpJ2Mpo1+YCf6KK9urvz7KUtB1Nk7JisyTiM1YHMWJ6v2LsmAwdx
	oHn275giS+yEoEfCEqthijm5qz2rlMwdoeck8NZnymZLPL5GVTldZWinIcB8LKUdH0PuOV8ZIs/
	EO4TrOzlzocedJ1gNvj+70Dl5wYlvNxw3pSEp6Fp0FN5nfPEG8MnaPh2oZed2e6gY3LIRjoKs6z
	QmnBp7tFGks1Fs2Zn1VbNeDqbxooHBY8wac81aHS4sOoBJdUYQRpw4Ig2qBLr9CVAfPoi8X69q6
	NaX+7Kg+BsNmeAWMrtXNXMeqQZySu2o4ldS0lPITopT8AuTbWdz9a1eSK1ElsN5khRjOLhGG9cv
	UCg==
X-Google-Smtp-Source: AGHT+IGZA8gr82xkStwj7eSmw3w4yA3nQWOZt97NHlzBDxJB9lTgMCzH8u1x1iv6j+zfDJQHVMlvvg==
X-Received: by 2002:a05:600c:5026:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43f3a9aee21mr150186955e9.30.1744695095767;
        Mon, 14 Apr 2025 22:31:35 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44572csm13466655f8f.90.2025.04.14.22.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 22:31:35 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v2] ptp: ocp: fix start time alignment in ptp_ocp_signal_set
Date: Tue, 15 Apr 2025 08:31:31 +0300
Message-ID: <20250415053131.129413-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ptp_ocp_signal_set, the start time for periodic signals is not
aligned to the next period boundary. The current code rounds up the
start time and divides by the period but fails to multiply back by
the period, causing misaligned signal starts. Fix this by multiplying
the rounded-up value by the period to ensure the start time is the
closest next period.

Fixes: 4bd46bb037f8e ("ptp: ocp: Use DIV64_U64_ROUND_UP for rounding.")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Addressed comments from Vadim Fedorenko:
 - https://www.spinics.net/lists/netdev/msg1083572.html
 Changes since version 1:
 - Simplified multiplication in expression by removing unnecessary parentheses
   and using compound assignment operator, as suggested by the maintainer.
---
 drivers/ptp/ptp_ocp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..faf6e027f89a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2067,6 +2067,7 @@ ptp_ocp_signal_set(struct ptp_ocp *bp, int gen, struct ptp_ocp_signal *s)
 	if (!s->start) {
 		/* roundup() does not work on 32-bit systems */
 		s->start = DIV64_U64_ROUND_UP(start_ns, s->period);
+		s->start *= s->period;
 		s->start = ktime_add(s->start, s->phase);
 	}
 
-- 
2.47.0


