Return-Path: <netdev+bounces-187586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BBFAA7E6B
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79544A47F5
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD915573A;
	Sat,  3 May 2025 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="N8xwrW5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56246B8
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246656; cv=none; b=tffZe9V/JzOkg/F1YA8vD8fyIIZA3s0AXTbubq1AeaAbDGo0XpqOdAOJ6BArn/cWP0WrOj2dw8kt3Fs5DyuVkByKWWPUSkv9oG4r1Z1+OLvN4qYoQe9umW0/6pPuLSqEYvWMT+P+Ui7m7ZNoPBEdji+z+vbbtwOfTo4sxusTry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246656; c=relaxed/simple;
	bh=tK6sqp5IX8UPrZJnAqXViMwDwhL2/8sqXAdWXsC1kos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szhiXEPCmDFMKrTQf93hMWCcXP7nTA8EprnaXPGyksrSCc+7YalTuX3HLnCt8f8/mBSLMugRLIdr5b9+EOASp073cBCKEV3Tt/DmQoIQ8BJpxtowINWo2VGLihurhR0y3h1bHFxO4MGtesqNoHJ8ycsQcegDEOurB2WIifqT4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=N8xwrW5j; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af51596da56so2192939a12.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746246654; x=1746851454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+f18GgeWP3bF+TlxBMdab8Cp7U+xxHJNURE3i6Ge1U=;
        b=N8xwrW5jvuFSV5uFExM15Lw+DGSJREXhTsxPpV4uzEy27bd3krRKy3+ENaDbO30aXU
         lumoe9uT/SblOYtG+ar363A2ltL3MAIhFF6emZu4RMhnkhxMlxFQOe7i7fBA0jylgqej
         +ZmSHPcFcjWEECMzc5oVg0nvVvmfqVc1JkZoqsmZDUJvwzdnxEppffLIap/XEw0ZHoIB
         X4eda5cyr33tLqUsvHHjgegiydgG779AiNezW1+9EX2UmiuxxDURthORzKAjtA+LsGO9
         yhU5MdA5kfuJUXKUgfqoRbvVWtH/cfljCzWGmXCueEu1+z2fgEGQdxeXF0hKh+/KrQqX
         Hijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246654; x=1746851454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+f18GgeWP3bF+TlxBMdab8Cp7U+xxHJNURE3i6Ge1U=;
        b=nTR2kgjN3NWJGZCQVNsWsRSlBLRZRc7B21msPpaPNxEd3sndHDWUJUFFHN39c8bRr5
         z6FIlb0yemu6qiJvC6VbpL+yjq9sBcqvFZ4dhZ9Ep1lXuZh/lkmoC6zBdI1xTkF29ptx
         u50GlO+e5cdlU4p9hs7bx14PC2QFzsHcJLWVcswlqV5aYmqe+Mu3KchO1Qe8pCNJW7tW
         ZmQZ2+BAWEE8txbENUZiPSjVul1FjlpqGbP8oSZvQ/j5Are66VgMrq1w/hK8XIGnHydk
         sBq6RWsFuvtvL5zBbFMs8TCxzGl51SDjcJXHWl/OjagpxddFfIerXLqX/Kf5gkuhWGdE
         6vfA==
X-Gm-Message-State: AOJu0YyZ8m15HZjmbMlL6QEqy14oCy2crVLUY1TMM60eC4Bxesr+Zh2k
	v71Ls0ArV0EvHbF6v7nCi2SYTmQybeuPscZVlUZH9U5LQxOsrZpoKQmZxIx+zTlB1NTTY1DilyX
	7
X-Gm-Gg: ASbGncvLoDX7hvBLgiB2crGOQ0byrT+NEzLyg8YF00RPcJqwKVRfhhBtdZmhLFlmXf9
	x7WuVTVhNN8Rr0zo/thc7sB5PlXQCS4y1HtoXvvu6NiVRODExCvy2uJbMNYlf/H1CcF3Z6e1RJ8
	EY14pYmYFw/rd6mrVXUcRDRnOVV7PPgHi+X6smUquw8Lu5mnHn9TihokiSmsdDH8aEJGf/jPUpV
	9jL3C21PW+Ml47H1NUiaBFDcwenMLjKfOikN6WLYQFK2nvZHJTFyoJUTFufXMAGkXMgC+nYiJ71
	6JoVHAu2h+cFuMZgZTp9QyqC0zF+CbzgCSM/hA==
X-Google-Smtp-Source: AGHT+IElr87daY0HGdRNz2eiGqMz9KFGg8WbnGbFLM826DvJ7NsaHvHa/xN+JW26reCwoxMxDddCjA==
X-Received: by 2002:a17:90b:2709:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-30a4e43f1e6mr9718059a91.0.1746246654041;
        Fri, 02 May 2025 21:30:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522a3desm16103055ad.198.2025.05.02.21.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 21:30:53 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v1] tools: ynl-gen: validate 0 len strings from kernel
Date: Fri,  2 May 2025 21:30:50 -0700
Message-ID: <20250503043050.861238-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strings from the kernel are guaranteed to be null terminated and
ynl_attr_validate() checks for this. But it doesn't check if the string
has a len of 0, which would cause problems when trying to access
data[len - 1]. Fix this by checking that len is positive.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index d263f6f40ad5..a0b54ad4c073 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -364,7 +364,7 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 		     "Invalid attribute (binary %s)", policy->name);
 		return -1;
 	case YNL_PT_NUL_STR:
-		if ((!policy->len || len <= policy->len) && !data[len - 1])
+		if (len && (!policy->len || len <= policy->len) && !data[len - 1])
 			break;
 		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
 		     "Invalid attribute (string %s)", policy->name);
-- 
2.47.1


