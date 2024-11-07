Return-Path: <netdev+bounces-142886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE89C0A88
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53361C22212
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC092144C6;
	Thu,  7 Nov 2024 15:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB11F130F;
	Thu,  7 Nov 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995038; cv=none; b=cvscqjsV0GSxr5W7zVEbzyYqvZhYM3ECfd6trl7Dzj8L3uC2ncARUA5PYl9+T/0OGYl4YSXSOQnwFwi8Jb74wtYQ7v9HmDSOucOju8TkFTm6BMq0edA//jCxVlimT8a3nHDVkW0USSpDR+FQlt5ArrCxHrfEN63SiDVK9lUa10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995038; c=relaxed/simple;
	bh=plb9JFmTBN0FNIGQmiAwC2U22FibctbGipsxBzn321g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mYFrZ4/qB6v2QpcDk/37Ad7i9jiedNFLAxk3F+FBDw+aLSizRFjLdyBOWhUF0Ksm+q8s6EXWrFEmOC3/UjZa/Xy8S8hrVb1jSBDKyb9JGoyNJPqF+/03EhiVBe9cJubo48zXRSyP2SlEYObe8765iszSROm9B7/3U9AFXJYY/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso187121366b.1;
        Thu, 07 Nov 2024 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995035; x=1731599835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB+1Lk1KYrovURjiEsZ02zjxNmeuUgpK4DPxqDkDrXo=;
        b=Vi55YXH82gOR77NGgvkJ8hfh+sJ72ntYmioqTa59s1TQSNnxXTbMKYC7W28foCQ2+6
         vfoXioDpf8RufubNGyIgLjoXzLlGyNtlmRy0Ivhn8eS3CkxidlYILkEpVB8e54GQ9MD/
         6v6TazGuquxhRR/eXva1EXkR91kgpD7x+DBQmXP1EwRJipYp+j0YKdjSzZK8l1re6MFt
         IVmhtYwudckteK/06Gzjfi0fkGGCdmDwPKtYLVBvQk5tukrTzTfzLgHUn/WvnU+Mqtym
         LfP/Y1Xqzfdcjhmns+07jTGvgbAdvpwN4XJlXBRdsVARyBXNwVsZfOjD+R2TY/1NqKbF
         HmDA==
X-Forwarded-Encrypted: i=1; AJvYcCWEUWNV2Py7+jkVjoVCZsgQ6fkxJhkb3en2SuKK2V5cKTfyUqnSBJ1pFHXRxBrdpnI8BzWG8cRzDAAQfFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu55fQuvqsn+8Xf80F0oUgbUy0XFy2lDeOS7gDJVcosjV0oR1B
	al/vHNsRG9Qy8Pc6KDS0lJkiZ6rOYwUYUXn7tVVWJiLGmCiFWP4f64p68Q==
X-Google-Smtp-Source: AGHT+IEvbvtaCI80kOHhLO0mNkfA6GUvJ6891C5LTf6pozIKtgBi+2akhp64+LMaoiIrzwBXIhfv1Q==
X-Received: by 2002:a17:907:7207:b0:a99:e619:260e with SMTP id a640c23a62f3a-a9e655aa3d5mr2140112166b.28.1730995034894;
        Thu, 07 Nov 2024 07:57:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abe6e3sm108695866b.84.2024.11.07.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:57:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/2] net: netpoll: Improve SKB pool management
Date: Thu, 07 Nov 2024 07:57:05 -0800
Message-Id: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLjLGcC/x3MUQrCMBAFwKss77uBZJUKuYpIae2LLkKUbC2F0
 rsLzgFmh7MZHVl2NK7m9q7Iop3g/hzrg8FmZIFGPacUL8Ff0zB9S2HzYdVQTuy1TzFyHtEJPo3
 Ftn94ReUSKrcFt+P4ARWkuEVqAAAA
X-Change-ID: 20241107-skb_buffers_v2-f3e626100eda
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=leitao@debian.org;
 h=from:subject:message-id; bh=plb9JFmTBN0FNIGQmiAwC2U22FibctbGipsxBzn321g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLONZoG1tga8yWCYjThrOp+DfUl846XJqotG/3
 rBIkf6lQiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyzjWQAKCRA1o5Of/Hh3
 bV7GEACtqW//lg7CKeIU4EBoA0eI0p7URu4ztvwVGIARqsEIHQ6+unYfZ3mDJURA0GBzTeqPSGZ
 Z9TrRLB8nFoeGeLchnz2jfpjM/Ez2OUTiPm/ld33b9a9TglEx2CcLipIzz68F78Ei/oh0LteVUV
 uLWG/R9u+vmZGaOeCw2ujiqeJ03qMVTfAV9udWP48eTtRjtPHsqYSAFs1g4j+/gOEEJcqkUmXjC
 9EqmmYUFX2vnv2VQ6CIrOPWfltlevDMHpUlrz2SeWPazBl6/O4NWYqdyvo38UubYWZr91e844pK
 JTj3chMbnLFJWfZ7iBX6cCo0sfDJS8DyjY2EO6E86sqkqx3e09IQqImRT+raWFJdfEt9RzTUiN2
 XDsJ34DdYjsoyeppaX2AwB9WAjVM2pAfb1d2to2dHSz94Hvfwd0004diaCeaQ1MZwtlcMsqpoA/
 mmXgoJ9CPSPmP+FWktKJeisVEHQr/JGKTnxsUPOPWftAnfml4ZYShn1J2md8nZlrSUAiMmNgf2h
 BeWpjlNbhyA+PeCMskW6WJH+Hjf0Mp0vflaDl3O6b4dm2Q2BpUanTE2RBzNbnTDraROKdBqGVDL
 uITPKbloVuflnnNrIB229VLh3taitJLM7PzrJ4MQYipwRrCjq/RWAim6h6JbwtgPKcVCVN9G4C2
 DAjPYGSj2jifmLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll subsystem pre-allocates 32 SKBs in a pool for emergency use
during out-of-memory conditions. However, the current implementation has
several inefficiencies:

 * The SKB pool, once allocated, is never freed:
	 * Resources remain allocated even after netpoll users are removed
	 * Failed initialization can leave pool populated forever
 * The global pool design makes resource tracking difficult

This series addresses these issues through three patches:

Patch 1 ("net: netpoll: Individualize the skb pool"):
 - Replace global pool with per-user pools in netpoll struct

Patch 2 ("net: netpoll: flush skb pool during cleanup"):
- Properly free pool resources during netconsole cleanup

These changes improve resource management and make the code more
maintainable.  As a side benefit, the improved structure would allow
netpoll to be modularized if desired in the future.

What is coming next?

Once this patch is integrated, I am planning to have the SKBs being
refilled outside of hot (send) path, in a work thread.

Changelog:

v2:
 * Drop the very first patch from v1 ("net: netpoll: Defer skb_pool
   population until setup success") (Jakub)
 * Move skb_queue_head_init() to the first patch, where it belongs to
   (Jakub)

v1:
 * https://lore.kernel.org/all/20241025142025.3558051-1-leitao@debian.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      net: netpoll: Individualize the skb pool
      net: netpoll: flush skb pool during cleanup

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 53 +++++++++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 19 deletions(-)
---
base-commit: 2575897640328d218e4451d2c6f2741ae894ed27
change-id: 20241107-skb_buffers_v2-f3e626100eda

Best regards,
-- 
Breno Leitao <leitao@debian.org>


