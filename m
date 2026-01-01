Return-Path: <netdev+bounces-246486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4599DCED0F8
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2C5300FFBC
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B920257423;
	Thu,  1 Jan 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IZrjkdej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DD4D8CE
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767275784; cv=none; b=S/U0tFvvP8S1f9fNAqwlsblntY1On3P8nEgaw+sYS31uUol8ywr/okgacBv7RQn457b8Ma2V5ryWQ6B8Sw/TXi5Uf31pSClA/okZQdqGpJB1pmtGpKEU8JqILJhj/gm4qGA8WLwLpszuq5F2G8V/KpVBb/qAcGEy9A0c/emhePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767275784; c=relaxed/simple;
	bh=JotSL/QFJnFaAxIYYq/d6XEk0h7qGiazPCkEB5JrHVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YlAf1bUeeDfREiS3HWkWUmVkRhM2SRml4XXQZ7da74/uvGNi+uoSeeGziJkQNOounY1ot871+o4I5+Z/nVepr42PpqkbPpZCt8n7KDg/DYNAf30WDgjmwMIOD9odcSSvX/X34Wy+9TIfneYqafmD90pz9Mno0XEGPHtZCs9piFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IZrjkdej; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2ed01b95dso1193447485a.0
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 05:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767275781; x=1767880581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbSO2UCXHEIRUYnZGOdtvPk9HPghKjUeyu1LJtMXm8M=;
        b=IZrjkdej+cRLi+2CoINkIAB7Sb1wQLIcaJPXQQQ+if2/kFUZwsztEFxsu5EzF1/zGN
         UZ+B+yXRbpTnOgsxNky1JXzqwpupsXvmzBLlmwC+uNvqwKY+Q85tPtgx8hzfQ3FrGLGc
         PdHWUHyuNfT2jq0ksBd68zrvIUw95hnelCa2TzaOWqxTR0j0aZCoJisnhb7gcBLDUNXK
         g+nr06VAkpOc7yz/4+kaxkJbfUlOWCZyNxSeomoyW82cry+IXJyYS6WE+vI0Qz/oCR1F
         j73PVNAc3nGdXWa1aZsFS1nU/AyjjIcJ7Yjqiee7aGe9+Ta3EWKosK+7yKpkYc5rD+hB
         LLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767275781; x=1767880581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbSO2UCXHEIRUYnZGOdtvPk9HPghKjUeyu1LJtMXm8M=;
        b=N8g7HgWXnFa8HCNw9PoOcb8FvDqXOUa5ESsPX0Il5Jf37WSoEXluGXNb1OM/ndC3CL
         ULwkMrwwgzsleC1KznJGXfYi2SBwpv1Sf3Y447tvdXyqnFXlynYD38K26OKOMmKlWyub
         JYzPJSlYObBkHL+t7AZt7dVR8gt/j/KGq6btNmfm6suXCaZNLO2AQvimt28SWMRK2K6G
         YhRyTnNZieMLM77IgosxLCcWMVKozz+YlnxEsvrDJEOIVUaxEmO+GazOEPUrANZUEVNb
         bo7mYPQ1mnfBLFSJrIA5TjOTH93pP32E8UNpkRjx0CzqsVq7CWGRXCp+KMCvGq4oNeoj
         /7XQ==
X-Gm-Message-State: AOJu0Yw9lj7NtFJstSk/XARh+3BiMp+owqAdRPut/o7cPdwS/yhl+db5
	SVdYDKHRkgrnapmyo+QVBSazDsyH0eLQmC/zEfr5/jTZNc8DatCH3Hj73zKZpTv4UA==
X-Gm-Gg: AY/fxX5UInRC6LTXxIzAoDF27dtKqPzZ3tSsYELezFIsjxHqRDyD2ziJoS37IiPWVMs
	/h9FFGE146U7Ip0c7o/vMHUA/0IA/1ZghBFNEmAdH8ZZxSDxomkTT3ALgVz2R3RUwLhBhLcRKtH
	z2DlNlclieoyDAMtIkDkZDytrXZdcEAvEryJaMhMN2fLF+/C0F1sIDNhGoS4X50E98XJqgejCyA
	Nm+Bo8rbZVcDklrSFTyDBOxgISj0cVCjz5EAuVzTIDCK7vvm1NrHxmdfj9kcoiWxu0nm26O+No5
	64LHAlK3OyPW+mL5w19Q3UnyaqriCk7NtmuU/geFbsmET+fksCeK8W1LiynEbY8uGKfbDQJb7av
	O5/eiDth3E04WDcfpysZsu9BwCHHejZg1uXinQ+LF8s6cNIfLYqSDLCKxTY1Ma+MySDgH/wQ8Jm
	Wyi5MTtgCzRRc=
X-Google-Smtp-Source: AGHT+IFSxfMLzrJaEVaWzpLoe1fuSMEhNUnXhMLdBInqYUmi7k+q7YEy6+leLKtICybUZA2FfHDT2Q==
X-Received: by 2002:a05:620a:4454:b0:89f:db05:1643 with SMTP id af79cd13be357-8c09070bab7mr5570099885a.89.1767275780891;
        Thu, 01 Jan 2026 05:56:20 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm2964577985a.29.2026.01.01.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:56:20 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 0/2] net/sched: Fix memory leak on mirred loop
Date: Thu,  1 Jan 2026 08:56:06 -0500
Message-Id: <20260101135608.253079-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1:
Initialize at_ingress earlier before the if statement.

Jamal Hadi Salim (1):
  net/sched: act_mirred: Fix leak when redirecting to self on egress

Victor Nogueira (1):
  selftests/tc-testing: Add test case redirecting to self on egress

 net/sched/act_mirred.c                        | 24 +++++-----
 .../tc-testing/tc-tests/actions/mirred.json   | 47 +++++++++++++++++++
 2 files changed, 59 insertions(+), 12 deletions(-)

-- 
2.34.1


