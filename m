Return-Path: <netdev+bounces-78802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D63876972
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B6281934
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BA288B6;
	Fri,  8 Mar 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="W7uZAZpt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D53282EB
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918229; cv=none; b=nFXQzgmJ/G7BgoQKMD6LictJD+2zg5QceMIwx/V/cHveUQF8+H6o+kkHyksLpiteH5t9FcLUE11+MXfE4e9dYTC3jOm2awLGHmm0t82gNAgrs0xxSFfhKlPMLHntfmeIvVCrWUVuntxUVLYH4+wdceAvheyhhlYxcIUMjYGDL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918229; c=relaxed/simple;
	bh=T0w0PlsudigSGGLTkEbWrg42Atbxixzn7hpTdqoOvLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klCCmgk8SKlgvYxh0TLbfpD07h9tFLr0nZPnyvo9lcgO5T4NhMDnADACSRRj14M9wubhY49iKtwbUnGF2oRwBCnLKSGn2itRcZaTOR5VPS0g6v8aWoX21r/BiwzBVLL3edqljdxQ5HWgfRFHtEFEIzOu23vveU33rN95jr8NdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=W7uZAZpt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e61851dbaeso1430384b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709918226; x=1710523026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apMa0xe9W9HjRM8pDuHbm+GtS736Cy0jrUR5s8n0mT4=;
        b=W7uZAZptm+cKadG8xrrN2kGH7hsYOABvXvCNXnhGzKlWT1cspoHi6nGj4AEPeQbp3C
         qw2HPG7Q5/28VmtBqnp6r34ljilAJqe0sENXFicUKukKgKa1WOUcimwvTKBVZ5ZmOmCV
         9+OLyFWbw8pQ97n+VnUSZOxL1B2daojpSP0AfVWK+sM/L3vLIK5IHP4L/iagXeJ9ED5P
         n+BnjJW01/Y7vQ0suhRMzCTdEsxSLgx16+pkPTjAFtBBgfuxkezviLcY8rB3QR3L1skP
         q+UQAAuosECZLa37vG53CKoklE+SaGv85/xOYim45+8xq+lS7X4wFcg/DIzD/s69z5+A
         35tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918226; x=1710523026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apMa0xe9W9HjRM8pDuHbm+GtS736Cy0jrUR5s8n0mT4=;
        b=X0NM1+QhYAxQA27c9ujnqfkv6o8xv4SYMZo0KnTSSUR66eoD8HhbAKWhlJajhhmZxi
         jkwd9oji/CdYYkBH3mUELRrF18I1dYY2yJCwhUK6HozIn2fkczj2d9lCXVM59YcvxXzk
         3EZ2s1g9auvzjsTeFrAP2YAyoCi9EfjxAmqNIRbNow/VC1VmTm8QACWY+SyOkxw1/1Ym
         TxPQmr6vMex3D9vlNljtHH4LfW5xedCcdiU/YSr/w1ywp5HytSmNb/yNL4iSQbgOyNJI
         kgTVxjlbCZxsAETCrX9gpnd5F6UV8pccp/L8KhhRr+svZe5LH2pEQFHs2vbK8rVvSsaR
         yG9A==
X-Gm-Message-State: AOJu0YzjqGLp5h+UYgJJSx9tudULrOkEjp1nvDVw23mRBXqzu5V/JrSr
	1HYnCSaddh+M0j9Tkz6ixt22hGUccz1qGT7CLVkYFIGVyq8jd3hJbv7MT4Xi4i/Bk6e41E+Kzs8
	iluA=
X-Google-Smtp-Source: AGHT+IHAuBW0grVykvujiiy6Q3ydzKY8ylwApPRPqTfAHRxpOOG/dRRQh9teUy2nS9YM+I7bn9A2sw==
X-Received: by 2002:a05:6a20:94c8:b0:1a1:7874:624b with SMTP id ht8-20020a056a2094c800b001a17874624bmr5515440pzb.44.1709918226549;
        Fri, 08 Mar 2024 09:17:06 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm14771413pfq.16.2024.03.08.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:17:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 1/3] README: add note about kernel version compatibility
Date: Fri,  8 Mar 2024 09:15:59 -0800
Message-ID: <20240308171656.9034-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since next netem changes will break some usages of out of support kernels,
add an explicit policy about range of kernel versions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 README | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/README b/README
index 4eb9390a3ffa..a7d283cb809d 100644
--- a/README
+++ b/README
@@ -12,6 +12,19 @@ Stable version repository:
 Development repository:
     git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
 
+Compatibility
+-------------
+A new release of iproute2 is done with each kernel version, but
+there is a wide range of compatibility. Newer versions of iproute2
+will still work with older kernels, but there are some limitations.
+
+If an iproute2 command with a new feature is used with an older
+kernel, the kernel may report an error or silently ignore the new
+attribute. Likewise if older iproute2 is used with an newer kernel,
+it is not possible to use or see new features. The range of
+compatibility extends back as far as the oldest supported Long Term
+Support (LTS) kernel version.
+
 How to compile this.
 --------------------
 1. libdbm
-- 
2.43.0


