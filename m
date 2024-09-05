Return-Path: <netdev+bounces-125526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4F96D863
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A006289FA6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04719B59C;
	Thu,  5 Sep 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFCAPGHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2291A0AF5;
	Thu,  5 Sep 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538849; cv=none; b=MKKsUMaP0WqrRvl4OEEbGpzaZgrNmY4ynuZ0da1SJiVl67gnkjQ919ODSmXqh/jIO8/5qT1M4UfI1p9errJ/lx2ilNiusTrahJzISH5TMIAuHr02UBrs1nf2gLuz3lHfhv6T8qWHxP6UjeHH18qsFr7YgC+8AbsADcVGpPzUnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538849; c=relaxed/simple;
	bh=e1Czxq6ov4XgtcPb1btJSuKnmUVjreL32+Dx255BoAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9K9OqJy8IRYsd5DN7/098Irhnlrxeg43hcw7fl2kM6yytdoMV9etV1UIy0SMzCGqmHXjzUTe0l9BmK62Qijb6KYwzP3ILji0bOagaX0vNibT8KeCA+k55UdkJh6SO+wPA8GxYzxpD1A0qkur0+ZpaT8IfBzpY3BuP7nuJvOlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFCAPGHq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c7d14191so997919f8f.0;
        Thu, 05 Sep 2024 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538846; x=1726143646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQVjaXvMLQ/kqPRfYyI9JmOS+KxArnedzPC9bPV4amc=;
        b=hFCAPGHqcN5T6fgicoXKQU77+BFUD7bjLOZwu3jxM6yLzK+7Ywjv/u2BupbPRspJS1
         xM+B48iPkcD+B88AamLqCm+czyW00mXZn4f2dvs3t2KQRuhk0TRcVqKed18rMn9VX2LA
         VRbdJE/klu/hqS8b8jWrszR9tGoIviJv3rz1dun9mOWz1y8pX4gTifU1VEZ+BA4+r1LJ
         YdMBcAWBgwwbzBmvu8kUiYTFI4XCMMRg8E2r8UUjTARpf6fua2XPebbsdKvDAU6axKNP
         3WfB4W92AnE5Q3NMrEE5zb3ke1JlmJUUBycseOor1jE7W/NN4kJkw6GBvZr9g59iKr3o
         mxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538846; x=1726143646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQVjaXvMLQ/kqPRfYyI9JmOS+KxArnedzPC9bPV4amc=;
        b=MQ304+awlBNavaXPgqN1iTFfTEvsDOpTBprRQIsm/pSU146qIm1kjsxYdmmYBJUIm6
         nlgCtiVEozIK7IlBC9as3His0SHblaDsKoOyj7OL81KGwllrmv24aVD1SHvSzJNx9Evf
         9mJEEgBeReVzUBTsbIVXNVq7Q7QaV1pBiLPx7JwkopfkJhpJ09bse9vIPyLYQU9VZvng
         tUO7eHOJ8PMqxILMejXCXtExIzR7/llhccFOQOABozDTYa01dqY3NeF393d9h67PWsAf
         ItEeO81sZlDcAECXWH5kIqitZDzlY95FN+Tj/1Kh49kPN4Hkk1962tkEPHF8XzSGyfFq
         38+A==
X-Forwarded-Encrypted: i=1; AJvYcCUhGl/c/S6ZXh6IDlrtFHch0LMY6jiXTnsRSqlBsikGTk2F9Y/4lsv83GdSnsWzukVAu84UA7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbupBxc8BNK5F5o4afHpEoRCi0OQuj7JZz9qjN1jQHUGwQk1vN
	nxjt9PYN4+Mm5GRQ1LsllZMxulrCUUBapIxJJZtdS9P/a7/6E8bixKgyIYgGeWA=
X-Google-Smtp-Source: AGHT+IEojilhnQcmMuA2eFcSfPaI+YUv2hNUrJXyT4LbaKP+Vg0CsIEDzLxsPO2M6sLYmhXQ+2Ew/A==
X-Received: by 2002:a5d:64c2:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-3779bd18639mr4880342f8f.24.1725538846228;
        Thu, 05 Sep 2024 05:20:46 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:45 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 16/18] netem: Include <linux/prandom.h> in sch_netem.c
Date: Thu,  5 Sep 2024 14:17:24 +0200
Message-ID: <20240905122020.872466-17-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0f8d581438c3..2d919f590772 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
+#include <linux/prandom.h>
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
-- 
2.46.0


