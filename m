Return-Path: <netdev+bounces-68894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93E848C36
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640C71F23D6B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FDC13FFA;
	Sun,  4 Feb 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCe1yWVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811814271
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035931; cv=none; b=mhUr5VHaAcAUqJJW1Zxdqb3IHsQAfNPcVBGhKk1G9/+olwOu0kAb74nXEaPSrFZTI5ajXtR5cKAC82Nb3m0c3PkNzpmogn1I+m2KBM+Xcl0Kgm2itvRMjkPcb3qTHN5g+BbFuDDAmLSScA/etl+XpZmKFnStqRf6Ahdtk38yTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035931; c=relaxed/simple;
	bh=Y8dqkXPEInx7VCRZ+pdLI+LsnqMHl36UBCSOUnBLmLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLS3VliG5Vinf9XDuJXBD1hOMabNHfa7toqtWzCbXEeSHBxFwgCr7qRqWzzPJU31moa36Jqk5zLTxxtZLVTFkdFhtdCTzkea9e6fWIo3IH0fi8k65gOrtbFeiRo7PYaWd6jAmrLt5S+hzEVh/3910cvS8XsYwl2e9lWEIMvcibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCe1yWVB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-295f95ac74aso2637837a91.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707035929; x=1707640729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9e/oSMvpylu/poG2Xw6sQezu4EkNH1gOHg0lL37fpwo=;
        b=ZCe1yWVBmhop+ibflQG43Dl6n1LQdikLRnpjdp4irTuY8GvQNc4Q4MRVAtJRN9Oeuy
         t6KXyLfls2kqIWijhpsNIK34qp8bReTk+tiZ+qsMQRa6s83r1l0A94kIAjK+W129b4rC
         K9JeWpaCQ3s8EpKseuw8oPdgBobBgwVqpmvUDdKpaeLQGvjkIx+Vyrvc3f++R3EwbyXt
         g4n28Vdu/RowSIidrhE1lo6mUg6ee71jd4C2xUa806gU3FnUhhT0lvtGfRJxvwfnKwCF
         o4QaaUsNrY8/HZDuAeQ91zpcvklFOVs/mJtkULX7mwY+OxvilX/zcmn4mdU9nI6RxGEg
         aqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707035929; x=1707640729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9e/oSMvpylu/poG2Xw6sQezu4EkNH1gOHg0lL37fpwo=;
        b=iBh1e1Z6/xTLL5U3+6WyKkLrLhIfKTEeUewwodjzx8wReWtpCqQr8IUowR3sz7xRud
         lHyXDFOfjH4iyoRn4Q5bh+HslCTI4PAAkpatgtTtXe7AV0vIidXHT/qzfWjHfsRb56TT
         hQgriTylFh58aeZFqNDJGkj5ql+r6fzz4/yXsCBglsZkqizbYcyi5nCx31m+rsFLeLzd
         v4fjkGFABvj7qpSrY5uL+/eMs9PRa4kb9Rumj1PuilFfe2tKUxOYCbjtsT7pgm8jBII8
         fF9mW1LIak1Kvo0WYyfP/uSVwVVvV9mxBpWgD7TyUrLNHMt6yxcWBGOfcUB2QDyV0CNv
         SvIQ==
X-Gm-Message-State: AOJu0YzAXOHZ+zKqiboQ3MICiQ4+MilEmpwHtNxmBiy0NqwJN6T/zyjM
	1Yfzg1RmBwCX1M3emG9dArinJ19fToFiFmTGWAZ8uH9OmC8q1nqMUMFCbtaKbSo83w==
X-Google-Smtp-Source: AGHT+IGh+R102SVL64gRbzbKuAfiWTVh7nmmIKLX/UbULKMY3J+0E+TOSDEYnOvIBXxdCQfVw2WrLQ==
X-Received: by 2002:a17:90a:7527:b0:296:8384:7c3e with SMTP id q36-20020a17090a752700b0029683847c3emr492051pjk.26.1707035928796;
        Sun, 04 Feb 2024 00:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWLqTzNQRs4b6pc9ijw5Raqy1dos/mXkAbRSxwjGj8Jvtf9egizKmXER0aDoBsFaIga1/ijH/lfmYCUHHTYU9WXNyOTrGuAbedwkNitd/5yg6Sp+HQ5lFnbYyf4XHBUqIZ8mOQPab76wq4B/07qp8zYVOQjMVP/NraNIUh+ECcxpaWh2w+IpFFAKVNk6MD6ARfaYA4sP6PVuinJKHK70X7626Z3kjQNGVT/eV/yRkvAjEITbCaUZAaBWmcL/qvPOUqICg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id rs15-20020a17090b2b8f00b00290cfffee0asm2920525pjb.1.2024.02.04.00.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:38:48 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: bonding: fix macvlan2's namespace name
Date: Sun,  4 Feb 2024 16:38:28 +0800
Message-ID: <20240204083828.1511334-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The m2's ns name should be m2-xxxxxx, not m1.

Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
index dc99e4ac262e..969bf9af1b94 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
@@ -7,7 +7,7 @@ lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_2d1c.sh
 
 m1_ns="m1-$(mktemp -u XXXXXX)"
-m2_ns="m1-$(mktemp -u XXXXXX)"
+m2_ns="m2-$(mktemp -u XXXXXX)"
 m1_ip4="192.0.2.11"
 m1_ip6="2001:db8::11"
 m2_ip4="192.0.2.12"
-- 
2.43.0


