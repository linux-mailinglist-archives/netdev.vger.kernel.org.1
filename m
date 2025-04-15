Return-Path: <netdev+bounces-182934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64AA8A600
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3917B1899CAF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A201221D82;
	Tue, 15 Apr 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AfGja+uv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA122068B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739339; cv=none; b=pX64vg9oaNehvIzU1INtJCjlNl5g3Jk0KhWo79d5HeQ/yGiSi7ZxMAjrhEu4GJ+9oEQaHdZLl/P2pC4Rz99j/fbcBjP92q3/ioTlK3xXqPVWjF6pSUPQaj1Pj0niipfA7BdOfLp7YMfkeeGuPvYNLAeFJaL2AI7XoL0y4VaH3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739339; c=relaxed/simple;
	bh=xR1fVkn1wNqkaw3ORky7nMlg669ti+csesnvz1DWjcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEc2+GWstbLNfPdkCZIwO3nz4qzQKEliaHOVpw67/r2CFaPfmaqxeGWuBdXkzMlVaTgUcG5eTVdk9YEQ6idVPnNM2I1cbwD3vhU4837/AVHc6Hp9vMqfPs/ilzCLY6o1nUkOFhnQaHHtFQ90+id6KtJZiVfwPPsIv2f3RupRArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AfGja+uv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-603f54a6cb5so2656962eaf.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744739337; x=1745344137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKkupBbuDOJKK8+xfemEK/+fkXeDRge9t/ewMfGoknk=;
        b=AfGja+uvcq32znKX8gHVO3exCz49IYvcnDZtjx9Av0SNin+o68Mt2a7Q8qMRl03Rk0
         YkqMQdwopugBhUrvFXyJ6w1TQb/Bt768YkDpukdesYAeLghd5wuKdZXx5i0/4zA2K9DE
         /1JKuqsvd0yPJ72PVtK6AcBUuCd1JrIJxU8yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739337; x=1745344137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKkupBbuDOJKK8+xfemEK/+fkXeDRge9t/ewMfGoknk=;
        b=iNdFmov3pfV/+3jX5ncTTeWhtTasRJT6khwDzFRzEnSu/qITDLS6FhmB9JdEoPNni4
         ZiRCY+vT6eJkB6+oa4AliO99AWiIZ/g0ywvBrLVE1Vq6yKc6FVg/AqxewuFmSMd0lvvL
         x4km+fR7lRG02bF03wvFWJBnbtDUbH1RbdDxrFdRceuJfN15b/5UnmqcVdB7kAnlGARJ
         rvnp5emNqqvOT1z2091qA0OMstZKEOxyJ3w7JlhPHqlux/PJXoAIR3SbAZDtku+LlCyf
         ehxyrhwZOLkuj/3JRopkreWuE7eLMDeqrDkVihYzYvHHhTQ2Uq6zw0iXC1QxVVKF/rhm
         CBog==
X-Gm-Message-State: AOJu0YyuO8A3YYSSswFLHmmCWKYE3AW5dIxBxhKhAJhgPFppR6R34tRy
	7hod6+6l9Sy7B2wxpjCr4zhlvqpx2ixI5UPhw6UyWQzVNngOJX/Mzn1PpP4OJw==
X-Gm-Gg: ASbGnctF8Fj0aX7Ibw/EqMMply1krM2Ax6T+XXCekAfUhH3jyQA7DeUjXiN1RE/ftHc
	raV8R4Tv5EnQJMwkVXKOfHGXsMqxjszqwPnpv9+bTlpA7pl6VEKUGKsQCA4lpb0RZN+l3BzJDND
	h8bWkfaP3QAoax61wHysc0FQROPRYBHQN9Ye1vBUsRNcFX0OPCS5MxKyTsIGenz6hQUy5lZfp7Y
	V6ShJDKZKA3OLW8l7zPbQ95AytD1JwJkNTd20skITWDYZ/10gjgCP4/fBnTDfOgkxTledEUxhpe
	Ya/q5/XAAp4S3dvS0aJfq8Qj/isrqwGij7cFmZDjhS4ZDYyOQXhvsIFCYiGcAFOm1dVGH6Kca3n
	0CWeT498QNE3HWAFehlRFl5U+r+8=
X-Google-Smtp-Source: AGHT+IEPHzUGZah0t1K1gUDxskdOTdRdcEbGrXOPTMcmpQ1E5uRHXWBDjwtCrFHW4+wozsVQLTmLWg==
X-Received: by 2002:a05:6820:3087:b0:602:2bd5:121c with SMTP id 006d021491bc7-6046f584f01mr10279931eaf.3.1744739336868;
        Tue, 15 Apr 2025 10:48:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f50ee87sm2457073eaf.7.2025.04.15.10.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:48:56 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 1/4] bnxt_en: Change FW message timeout warning
Date: Tue, 15 Apr 2025 10:48:15 -0700
Message-ID: <20250415174818.1088646-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250415174818.1088646-1-michael.chan@broadcom.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware advertises a "hwrm_cmd_max_timeout" value to the driver
for NVRAM and coredump related functions that can take tens of seconds
to complete.  The driver polls for the operation to complete under
mutex and may trigger hung task watchdog warning if the wait is too long.
To warn the user about this, the driver currently prints a warning if
this advertised value exceeds 40 seconds:

Device requests max timeout of %d seconds, may trigger hung task watchdog

The original hope was that newer FW would be able to reduce this timeout
below 40 seconds.  But 60 seconds is the timeout on most production FW
and cannot be reduced further.  Change the driver's warning threshold to
60 seconds to avoid triggering this warning on all production devices.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
index 15ca51b5d204..fb5f5b063c3d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
@@ -58,7 +58,7 @@ void hwrm_update_token(struct bnxt *bp, u16 seq, enum bnxt_hwrm_wait_state s);
 
 #define BNXT_HWRM_MAX_REQ_LEN		(bp->hwrm_max_req_len)
 #define BNXT_HWRM_SHORT_REQ_LEN		sizeof(struct hwrm_short_input)
-#define HWRM_CMD_MAX_TIMEOUT		40000U
+#define HWRM_CMD_MAX_TIMEOUT		60000U
 #define SHORT_HWRM_CMD_TIMEOUT		20
 #define HWRM_CMD_TIMEOUT		(bp->hwrm_cmd_timeout)
 #define HWRM_RESET_TIMEOUT		((HWRM_CMD_TIMEOUT) * 4)
-- 
2.30.1


