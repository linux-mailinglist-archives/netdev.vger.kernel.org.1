Return-Path: <netdev+bounces-239090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7450C63A57
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0634DA21
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E630C343;
	Mon, 17 Nov 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YKClv337"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F52F6594
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377034; cv=none; b=qGFBICOpRC74Q38/vMHFAWYIb8XtjLatQTb7GEGnWQVGoE3iwMPr/viQJ9J4TkFPQaY9O8+/yMH3X2n7lqxavC2ADUlmHNsZ5SO9MvvG1grIhv2dRFcjtPc0wFXzx6kvhpiC35oKXIFcl+d6Q1g/0RdApqE0hAuflb+3SQZ2TuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377034; c=relaxed/simple;
	bh=a020GFpebQ9slhFNGbIKTEFIb9q4C2X6KG7L06H9LC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIHMh78T4G23KH9ipwjeEm4jkNO9Tp4thlBMAzhCLqBRoTDtTcl0wJvvCRK2TJkzRkxd+fDtR3szCHH5GOdAhq4FtUY5ChM4TZ9Ll+TCEZ2O102O8jrC93Sh4piYmBShivOer6KQjuhTZphCIbkJA0bM6NM3usG8cS/0s5JZv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YKClv337; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d45c9so30251055e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763377031; x=1763981831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fuVdr2wrnUFrjPZZSiE7Vws6zrzmOc95SvbCenW0Au0=;
        b=YKClv337OaNIZ2TFiu0dlBYQSKxXs2HvqIW9zmtbkqum74t5dOH/1dcQMNE6N/pyad
         rWVsCwXDDun2QKGC1lnNye91/S+ENokJyh2XWCIHQf3YlkFqv4pAnbgIKShArtCLFzqM
         dCn2oKCZALwCXyxNCRXWECzuqs+54D40M9jPHeBKL2Ch72oRvKgygaWeKfeyj/6AhsYh
         SN17NWzKswrxet4MrZDxF0uR1CLGTJ+B4TAnxQ4+x+0SbWHeMtXXq0yG5sneniYOAsKQ
         u31ikqPSlnY1KQtwWXPjzBnazAOqQRf0qRfvrZIymc6ewg+AkQn0xfJNJog2ygkpyGWP
         Tl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763377031; x=1763981831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuVdr2wrnUFrjPZZSiE7Vws6zrzmOc95SvbCenW0Au0=;
        b=GlNlxh6apSUOFtYaqQIBZM7sOfsTVEtt6R7McuTXIEo/k/PT/trpm08Cz4WX9Va/m2
         1Dd0G/OM3UHLs/tTKO+idDIvKJbOS2K57jS2ejZvb4eBbxsPts0X0AwxY0A11nhdSErZ
         LQOkf/nKHMRPVfxo4ga5PpdcUvZ7VAEvSt/wKbYf8LsS6kFj0I+ygerVALKvZjS2BpBO
         b30WURoDgg8zvkadjSrFczlFql94Nc0ZEsZ0nLJshaR/YlIT7rFW2ybNSHnjdB6TVY/2
         xb1LjAcGPwJYE4ZsFBtc3h48f+tHWSrRUUAPdjDFJQ+iU6YsHcP0ZqZ7vhwLXYV72KzH
         12mg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqr+IWzomqEM28AAa3zaZDNtF5Qa94yqr6RQ5vrPo4wnegLKKVXdS3dDpaacmvaJefAUnU8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/VQU8kwXXckMmA2AgO2F16Wed5V4Zv1ZUnjJMb+7r8EeBq7R
	3vneK5HDcI6MMwzvCS/we956H4usn+HY300bc0JAJyn+5jdeTwmYiL/5
X-Gm-Gg: ASbGncs91VdOzrfUueGPHv3nsBXka+Mr1xCkperdfp4JrYkPiykae3cxdZ5K3Am5mW7
	ciBnNLRyK73tSaBYn6p0JmoomqSLR7bYJ/I2Jcd39WDsAxjEtNVi1WxML/W/ARQJsFIsReyRdjp
	q2Z20GyVfoA5lm7c4HJW3sas/cApWY6G9DfJLrR730OSbs/8FwHVFkeIEhcT6MqxNZ45KHWU0sX
	9zmmLpr3Lob8PDDJsbXq9WPM8PgiFnMZcOMbbclTi6nZw/W7TXGOYGZoXfJN6+zI1DHrwGrLrGK
	/KGcVEeKi66XX1+c7CWhxMexVgLExZ2K9eU2LuMFvlVnpL3eHn0npLq4hU+uBs/orVzb5tVAxc7
	+W6PMjmQu3xIzrW62ondS+524KihiL7FnOB198C4hCdo9YLgIMZVJrrpc1IzXyFIKH+iMtnhtqF
	r5wlfLTyA1QjcFYGBXeGZGmqmuI7+r82RJPGC13Mx2rW9kfW2duQRGHC+ayKobhEM=
X-Google-Smtp-Source: AGHT+IHV8KRCQZ+cF6f7oEHRIICHa7Gadbd7BZbChnydg6Ei6/veObuIYO8RBod7zWVxSuw9/azumQ==
X-Received: by 2002:a05:600c:3b94:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-4778fe49cc8mr115674205e9.14.1763377030933;
        Mon, 17 Nov 2025 02:57:10 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b617sm25397802f8f.31.2025.11.17.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:57:10 -0800 (PST)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH v3 0/1] add tc filter example
Date: Mon, 17 Nov 2025 11:57:07 +0100
Message-ID: <20251117105708.133020-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch in this series introduces an example tool that
creates, shows and deletes flower filter with two VLAN actions.
The example inserts a dummy action at index 0 to work around the
tc actions array oddity.

---
v3:
- Dropped the patch that ignored index zero for indexed arrays.
- Extended the example to work around tc action array indexing oddity.
- Move to the example CFLAGS to samples/Makefile.
- Enhanced attribute dumping.

v2: https://lore.kernel.org/netdev/20251106151529.453026-1-zahari.doychev@linux.com/
- extend the sampe tool to show and delete the filter
- drop fix for ynl_attr_put_str as already fixed by:
  Link: https://lore.kernel.org/netdev/20251024132438.351290-1-poros@redhat.com/
- make indexed-arrays to start from index 1.
  Link: https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/

v1: https://lore.kernel.org/netdev/20251018151737.365485-1-zahari.doychev@linux.com/

Zahari Doychev (1):
  ynl: samples: add tc filter example

 tools/net/ynl/samples/.gitignore      |   1 +
 tools/net/ynl/samples/Makefile        |   1 +
 tools/net/ynl/samples/tc-filter-add.c | 327 ++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

-- 
2.51.2


