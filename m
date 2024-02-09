Return-Path: <netdev+bounces-70693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CD8500EA
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F282815D1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CC38F94;
	Fri,  9 Feb 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="y3frgEwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399638F91
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522984; cv=none; b=ckb8E0oL+JVJsitDHUKKYSjIKFfftAGJuguLqSNMOyhOiHzE1oKGD6OhIvy0R11UC7q165xDK4aOtlUQzNovSbsAnPRoISV9eZ9BOo64YQtLpJitn71lXlXhYZSUxcvVQPq1UexNjQnMebZh426MHgRLy7XPRCvZHP7oX8oTF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522984; c=relaxed/simple;
	bh=m0KmTMod/IfitqNv82GKiI7Nwj3IgwgUsghwVe63ilU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raiq8NDIBfW66yQj87s57ifzkyndtV9NNeVSw48vEO3HSIyFk86EkA6hpje7vZvfyc0il7PSMQ6KGd2qMcSIDbW/HgquPUi4+uU6pUoPRVUZnua9swoZXsdwzwNeoDKNRvdgp6oqTWi60/9grR9Z78xu+oanLqcWPRObTsTl/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=y3frgEwf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93ddd76adso11982155ad.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 15:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707522982; x=1708127782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4SqyzWBJTEFulWwag6urEQadom2GFrdZ/DrmTbyVoI=;
        b=y3frgEwfB2ajlCEDaO5bmzYj+gyvwptusrDeVtMCpOPA940WlscvJC3GwcW/rgmvvZ
         ydxjdhKKQMx8wzewjRWhiNZUx4jYQ1jlUH1dOtLFjzKrhq0aSjuMfHToCduAipvCJxqz
         H1KXQc7G4yW/7ojCVG2/awUHrGOdQmDjMba4B/k7wJnNN+vNZ0w23jA24kJAQK6t1qQP
         0tMJ3co4XRK1P4/21rW9rnPuR4hRdLRXWbXapzczmnRzrXd3yBlLz8OhkL7s2lsAm8JB
         5KZicqLEvKXI8JQ51ERkbd+STKmLt28Bgw0J1LO26tFZpO5JDsoN8AYFdBcA4PAJlLce
         t6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522982; x=1708127782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4SqyzWBJTEFulWwag6urEQadom2GFrdZ/DrmTbyVoI=;
        b=Nz0z1CZtuVHqbMOVEMV5MdLdgB6TAqevjCzofO/Y5XiGmg3O+SEwK3vsInJtiNtOEr
         49hKESv9HGl+HLNDU+VU46jheCzEm7kQIa2B+e7C9FIY8Ep04Uma01T6EJox8XAhqJ94
         QY6Hnl7w/hC8prPdeQ4RXy2mm7dccBYe0Mx6mLxTcjr8IjXLb0gxF0OOyGTwLsCuR53M
         jcLx8pWSx989xS3NBD3rbTwTxWs393JQyKLxS0G6aHLhxsJ2Etirlt8NdAlQKeA6aht7
         Eu/PNBX9SW59XKqOYmuZvV/k92YY3jcQmntPVCLTiK4WEnirYqgFwQpjUQ6VStc6kGak
         r0wQ==
X-Gm-Message-State: AOJu0YznHBeEWvAmgYrVHuTFkNFTjAiNJ0T45od7rpEGk9sfgJK4c1hD
	+xRN32WflcW4yiSOaa+hXGK8SkymBdO/eM2lXEGvF52i19937xsxllPvKppTetLV/0JkG76Xm9K
	2
X-Google-Smtp-Source: AGHT+IFC65Ln/doLcnJMCUejPg/rsqXH/Z2fJIdeGVSmRnIM+9WDhDbYlCdXMXx+QTexgmkE4m26eQ==
X-Received: by 2002:a17:903:1ca:b0:1d6:fcc3:c98f with SMTP id e10-20020a17090301ca00b001d6fcc3c98fmr689645plh.29.1707522981853;
        Fri, 09 Feb 2024 15:56:21 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001d9a1d7a525sm2018420plh.273.2024.02.09.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:56:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/2] tc: bpf: fix extra newline in JSON output
Date: Fri,  9 Feb 2024 15:55:56 -0800
Message-ID: <20240209235612.404888-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't print newline at end of bpf if in JSON mode.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index 4eadcb6daac4..da50c05e1529 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -204,7 +204,7 @@ static int bpf_print_opt(struct action_util *au, FILE *f, struct rtattr *arg)
 		}
 	}
 
-	fprintf(f, "\n ");
+	print_string(PRINT_FP, NULL, "%s", "\n ");
 	return 0;
 }
 
-- 
2.43.0


