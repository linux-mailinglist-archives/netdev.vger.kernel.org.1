Return-Path: <netdev+bounces-82464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7988E4A7
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83CB1F21DB5
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0F1272C4;
	Wed, 27 Mar 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh8PHilz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981431EF0D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542707; cv=none; b=iurxLVGC2XDhG8B0UMyEgPSfUU+mmu/oVfH0qaxEsVEdG29pYykqoQNUwEBDCn7sUKGUyypq4jOb/VwaizSkAXKpeRCTYmU5AwhzR6Q0vxJmteQB7tZubmSmgRQu+eYLIBFaQkfyh9j80mucEkAPnPx0SSIbWxelUl4OooXuRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542707; c=relaxed/simple;
	bh=VUbVM+M/356SfvAPGqmazZHtmxdmJwAxcwXrlIoUEok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1b7yyYPAWrp9k1tCYBKWKS8SMqSQMjgAJrVAljQKKkfm3/KmeFbjxPlqMDs38opc9dJd6ZlxRO9MGF9/GuJKkQe8QfkvwxQGvALkOm11piyFv9kSG5Uf1tojAJQvTBPmOr1K5xDgYCoOMVoqwEH0E2rl6ffMKZxknrEbYYKil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh8PHilz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0fa980d55so14759115ad.3
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711542705; x=1712147505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1qnP2I8xCsfPUR7bxFs1jTB4j3kU40LHJqThhM5Ztk=;
        b=Hh8PHilzd4cIRjtiuSoEP2UyDOOTsdixse/+XjlGCTlzkgWLT6BR3QrN1l1bd1mE3K
         Oa5jOmF05ATylOW7dPbu89hpiNhmbkmev4nbqzTstSymlp8RjRMcIldOBw0upbN2/PoY
         y/hs5ciDU65eEXvTHZBxvrlolPsS3vwEfSXmTU6lJ0PvWaWa8X5E55W8qrHJfCEIR5Hg
         yVyD/iScaR8ue3Q7Ffv1EpAyrr+kSsV5uo1RgxzgOTqrVSJUqaDcjVBmeUoRrXouLFZN
         6mO58fYS4y7NrZ/O+Tc6BVxOq0Vm7R/SHXNUCCjO++R/2CAewaGcJTYYN+wqhzzhiwnB
         mIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711542705; x=1712147505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1qnP2I8xCsfPUR7bxFs1jTB4j3kU40LHJqThhM5Ztk=;
        b=LIbTFaNKm4nyN9i663yDk1qjgCK0PlAniSwLl//SLlHDk/UYXfP7d+7eDnjcRL/ryF
         blL5fvY1g4yMOhfY4K2UUMvRFTgUtq60vDcbsjzDsj6lSMcDCS7pVacKMPzq+OZAGNcA
         /AJcTHnmg5wT2X5vLhEjoxhSfpz4hQmparJqQz8SwbSCyViQxbweF/kbbU3lxLuNB6d1
         sbz/LyoimX9lpON9VsQGX/bGz57jAegQmIQ0M0zisbSjCnt7YtRMioB2c1/BpixLzBVN
         Ar6Axdqo/VcuvoHNUkQ/CnL0TsOn1AF4bWyjx79eXp7Y3ReOi4LqdziLWbPPQNQCMuP5
         RyJg==
X-Gm-Message-State: AOJu0YyElNIPHoeDw4VB2dQByYpXbhLTUa9dtSXnZt6yg/Ia/spFqVjs
	h3ZycJRGx5vh8CuiQrdYFiumjm6lWiW6xxzJgiAQQoh2W6FJ4jY8v9hTE5NO8oKwh6AH
X-Google-Smtp-Source: AGHT+IFBN9bnhgVG2V3q52YpoAo7HacQUBnG8a82XIhg+GFxlpGYReZoEyY29+hzjTOLw1CUsP9H5A==
X-Received: by 2002:a17:902:ecc5:b0:1e0:342b:af6f with SMTP id a5-20020a170902ecc500b001e0342baf6fmr4506955plh.16.1711542704768;
        Wed, 27 Mar 2024 05:31:44 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709027c1100b001e197cfe08fsm1356771pll.59.2024.03.27.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:31:44 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 1/2] ynl: support hex display_hint for integer
Date: Wed, 27 Mar 2024 20:31:28 +0800
Message-ID: <20240327123130.1322921-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327123130.1322921-1-liuhangbin@gmail.com>
References: <20240327123130.1322921-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some times it would be convenient to read the integer as hex, like
mask values.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5fa7957f6e0f..e73b027c5624 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -819,7 +819,10 @@ class YnlFamily(SpecFamily):
         if display_hint == 'mac':
             formatted = ':'.join('%02x' % b for b in raw)
         elif display_hint == 'hex':
-            formatted = bytes.hex(raw, ' ')
+            if isinstance(raw, int):
+                formatted = hex(raw)
+            else:
+                formatted = bytes.hex(raw, ' ')
         elif display_hint in [ 'ipv4', 'ipv6' ]:
             formatted = format(ipaddress.ip_address(raw))
         elif display_hint == 'uuid':
-- 
2.43.0


