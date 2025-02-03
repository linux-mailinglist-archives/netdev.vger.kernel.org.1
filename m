Return-Path: <netdev+bounces-162057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97AA25834
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE423A984E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD32010E8;
	Mon,  3 Feb 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6xWojiP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E51D63F5;
	Mon,  3 Feb 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582242; cv=none; b=sfUkhctlneSqIkEjRkyy+L+6c5WlN28UH3L2APXz5TEu6Z6hUcyf1XfGllMpwmD4a+hXjVaXJYPqFN+DbWuUjSL58KMkTqqw6OrWJALOpNV+IcLgxBsiPmLvDr56Ct0TsDZDV7sr1O0hIyaosHS5vH2OlYotrXEi6JqtiX81M0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582242; c=relaxed/simple;
	bh=pDuRPkoKfqw6nq0A2p8YOlo6PxxkTi/ik44ZtSf4kRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFQl3/xO3uk9+IEUOAwmXTiYj2QhlvN4Ay/v4DAs2i9pmnOjTEYRediiRDczgWWuW7KF8YjFxRAy+PG2zw4rxbkPCl3vawdXRWDB2zjfovxnhPVjfZyWZWcmSl+HGTyLftyR5R83jSspHHrQMg4lzrJGWOGIZpoibBVSAcE1B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6xWojiP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385deda28b3so2201153f8f.0;
        Mon, 03 Feb 2025 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738582238; x=1739187038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xnI/TsHAocOuYHAYr9if7jEUms/tx4tWKMg4pTajBM=;
        b=P6xWojiPQQxthc752Bk6ncGuyQpHQ/+OzvuVNCkLRW/JjcQP0Gnw43iUacqQOb10AH
         R/7C+NM7PdL8GiroOC9NtqPJ1AQL9prFbchOzhap6AcApknI13I7q1dwvfnV1x+lO9Yd
         suLP14WH0w/Jg4bi7+EvNc0LEILWr7vPWt5AHw8L3DtKBejeupzGfKjqAp+sc+hYihhQ
         RwHxnbqD76EsaVj1/Z0B+PTrRPRtjlzu4efJfq0AkzaIwWO008a4EuF9kvgZTg313rib
         NpSXwpwyf1l65jIukbg41kM1qgTo6cjlppfIZgii3gaHYpY49XqSGI1nVqma8fAF9ZIb
         Kzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738582238; x=1739187038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xnI/TsHAocOuYHAYr9if7jEUms/tx4tWKMg4pTajBM=;
        b=s3+TqwVbTPfurvKUGjKXA5OIiC++iWuddIzBObcL8Jw9KaErEEV4pqTlTG1PzRpdBb
         SxfVe3zQlXec8so1mTF/ich7pc8uh0VWvJbhyEVfuaJCYxCb2aBESgtUutnx9o7SsWhP
         QTleeEVTuUCl/31TZc9I56/1mi6erBMZhy9aOnQ07QTJN97DfcXkkmGkWzWobA9bkPdZ
         k74mMj22KxfnCKgF7KAFRMgqzoEfPsvkFKbG4/v/TcXMKLGzNApJlcgdawOAT2ReDet6
         jXiHG82OSAv69o358GH9jefPVHaMU9oii4DXk87GyQB6likh0t0ENIzB6TrBQ9v47fG3
         ysvg==
X-Forwarded-Encrypted: i=1; AJvYcCUTJwMaGZlzIaj1XAfL69mla2BbZuY++pbfNL3JHBfjKNW9Uc+JpKvaDd5DEPdzjD4CnjN0ZaX2@vger.kernel.org, AJvYcCXk26cthmR9p/r4gpi5Ta2rJQxfd3dXorb3+PpTrhaJWo2pJ/xY8oO2TvMzZCnuAOXzpkggSDP6d002kkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyqlNDJgvYbRYuGkPgL0eMcVp0tsPq2BX/u66BWvopvoWtdlM
	SrbL84JG1QAxuIrWI0gT5xrVFHiL9qkbmR6KZtMtoiyxHwqVz7E0rkZFqSVC
X-Gm-Gg: ASbGncsH2zE/yb2f9fOeB6Pl45rF54wrSH/OQNMhWJfxRTcH80bJ1/ALpcq0UqsLBW6
	YEhJZWGY479Q9JyD8ClGPs/Act7+Jyxsq/SzdTKra1fsezWfhi/ySgilxbUh8lYLEOKDuTF4y2V
	YHiFuR3WXQs7CjvU3Uog+gjKGR5bXs7zq8B93m7WSdGlKqekEXioFyfRlYXXF8vPdD9Sb235mtV
	c5QyKcDWbP7ihv5Sv4006zElJ0U+xCNHV3TaPmmAUwR7KnKuOoOnYyqGc4AwN6kXeCIsuD4aPEl
	+bNnI7h04ndmKyB9yqLjm/lkxSw=
X-Google-Smtp-Source: AGHT+IEM2TgIFGGxtjZAzXPWgmjVsyAHG+HJRhpojwX5+mPNVmuMuoGnOU6WD/ikBik+NuNeGyCcjw==
X-Received: by 2002:a5d:6c6e:0:b0:38c:5bc1:1ef5 with SMTP id ffacd0b85a97d-38c5bc120a4mr13657329f8f.3.1738582237856;
        Mon, 03 Feb 2025 03:30:37 -0800 (PST)
Received: from workstation.redhat.com ([90.168.92.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b5136sm12770210f8f.65.2025.02.03.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 03:30:37 -0800 (PST)
From: Andreas Karis <ak.karis@gmail.com>
To: linux-doc@vger.kernel.org
Cc: ak.karis@gmail.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	corbet@lwn.net,
	pshelar@ovn.org,
	dev@openvswitch.org,
	mirq-linux@rere.qmqm.pl,
	i.maximets@ovn.org,
	edumazet@google.com,
	ovs-dev@openvswitch.org,
	pabeni@redhat.com,
	kuba@kernel.org
Subject: [PATCH REPOST] docs: networking: Remove VLAN_TAG_PRESENT from openvswitch doc
Date: Mon,  3 Feb 2025 12:30:12 +0100
Message-ID: <20250203113012.14943-1-ak.karis@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c4b2d370514 ("net: remove VLAN_TAG_PRESENT"), the kernel
no longer uses VLAN_TAG_PRESENT.
Update the openvswitch documentation which still contained an outdated
reference to VLAN_TAG_PRESENT.

Signed-off-by: Andreas Karis <ak.karis@gmail.com>
---
 Documentation/networking/openvswitch.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/openvswitch.rst b/Documentation/networking/openvswitch.rst
index 1a8353dbf1b6..8d2bbcb92286 100644
--- a/Documentation/networking/openvswitch.rst
+++ b/Documentation/networking/openvswitch.rst
@@ -230,9 +230,8 @@ an all-zero-bits vlan and an empty encap attribute, like this::
     eth(...), eth_type(0x8100), vlan(0), encap()
 
 Unlike a TCP packet with source and destination ports 0, an
-all-zero-bits VLAN TCI is not that rare, so the CFI bit (aka
-VLAN_TAG_PRESENT inside the kernel) is ordinarily set in a vlan
-attribute expressly to allow this situation to be distinguished.
+all-zero-bits VLAN TCI is not that rare, so the CFI bit is ordinarily set
+in a vlan attribute expressly to allow this situation to be distinguished.
 Thus, the flow key in this second example unambiguously indicates a
 missing or malformed VLAN TCI.
 
-- 
2.48.1


