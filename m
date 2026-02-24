Return-Path: <netdev+bounces-260664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id chJkLoornmmVTwQAu9opvQ
	(envelope-from <netdev+bounces-260664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:51:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8618DB1C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A93C305C493
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1A34CFBA;
	Tue, 24 Feb 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UazQpQ4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8733B970
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973222; cv=none; b=WXmFuCJx6srq56Fh9SY+T1dwy/XuVu9/tVBDTJSKLiosKqcYlVnT5L6m9PdDesnLDSdSrOMj9taca9gSYAlbiDyeXaUZipIG2dejtxvCH0ZIQugL790XAX/3rWfK2AyDlNV3S+QgpR03GZjNaO0s6KHVKoNt/PRqBcS05eTMk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973222; c=relaxed/simple;
	bh=Y3I3Z6aMF6k3luiiTn9t3iVSMNicsz+VMWaOi+NdkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubKQ4/aMbFgAzOCkSbFtBL0dRzxDgsC5g8vS6S3Jzvyuzm+un9AXFmLzsV/yTEJObXyz7n1mGupS6lWjmU6r1OBHqMm+QtJ5DxwQXSMHYzRRw03qzlvWT1YVTwNtNH3RUF78ONW5Q29Jt8vdSbpt3od716zliDT/Hi22Fq8URKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UazQpQ4M; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d19d3c7208so4559137a34.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973220; x=1772578020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5c1EoPKk72Be+126KhlAHwq3me18corIKZfzY3nIwvM=;
        b=UazQpQ4MC6IuJDHAppTJFFos7hu0Qg9ssWNcMhyup5PEQOHvP8UaJ0MtvrMpRpav/0
         6EPu5n3zbgx4miBdTBzELe3fROjSN5FO4bq+UeqomyZ2Ky8GJa65biFVYo5rtd7KqBo+
         Eu4D3FNmYmxRSiZyx+JXfr/2xj1U3ySqPe/boGJcPv5GuZinHNJrFGhIPff5VlfX2qd/
         Z/30bJFqTn1JMnY+7sqLbkPjY7eD1jk8WLioO8XuSvncP1XZYMGCdpuLNdA+4eAXKKvC
         JyQdI7edFBtACJgnfFW6zFmsdsKtcl1k9c6ogAr6IS8S07yBfSZUY+r6jFSiDQqP85Ym
         kRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973220; x=1772578020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c1EoPKk72Be+126KhlAHwq3me18corIKZfzY3nIwvM=;
        b=GYOYc2YnsQqAg1jVWJXJZ58oTA7FoSIAJwybJBkl70bJrc4dC30lpr+OJReffw5MoN
         US2uKldoAXCG2XbuYRZ+2WNC7BVFHvcgf6D8GuDs1uYFFXxRSSqn08rMn7o2uOzoO+nU
         E8+X6TM9kxrrMpkrJtlgJH9cxFuF7J9RT9Zp8+piS/tvui/L+JuVZ0Rhtmv/GWIEYhSF
         Twz3sqERhFpzZpxkXBE5vyBGKasjWrparvTF5AY/wwK4Dy5gOeYGZbTW/R8iLVeRvu7y
         4xe8Ucwm5nwZgGMnQx76a2nBOzzT1oLhpLFfM1KbGn44h0zAsZ1Dy8jLJh1fbqnZ45yh
         56VA==
X-Forwarded-Encrypted: i=1; AJvYcCU7NRT8TooONI5CCdyDCLoJJclIWMEb8SpBz0PO/Pw8B6Brb96og/DzxPgdT3KKfC+ytTSULMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEt9zYVsmqgKeOOYPm1ORUiNYYaX6mUOaKcnZUAgahHjUuzuK
	pXINkymwDncYMcmDEdkRzgdlbHQ3FyP4+vuuJEy6pVfIAiduC1f+D8oi
X-Gm-Gg: ATEYQzwGRh+c7wjS2WFgfp70B6jycocYLQVPIcICvc4tYJS+GLzIZYNP1Y8urcRNK28
	1Irhht5IBin4BmfYL8ypqf5Rnn1ySVXcCeYOHkC6tIwTApD6mIFPT8iSddH2TaePHJP14+x/xsI
	AS5ITWPYRvqE7MRtJ8KFsK4CJqQA4B5oN6xhVraiGEb9s+3csHP61nWxKihI6vdpaZCB3U5Fou1
	6Tpt+4PQ+EnrMwab7HOWfPsEhfsqg/UnS1svEMxSWUkAf1sYRV77SrOwaFXoNd3iiDu2Cgzn6B0
	1AVD+cVMthcUhEth0O9Av5jYnNAD+ahIaNTYLDNI3KRLvl22d2DY5zKejIbGcxBGJYFWk6tO5ly
	DMrv8+ztczvDWINQDfeEuvRb7oD6mDi3uaEXpY6FycUMqrAGMMMrZOgkUWGk=
X-Received: by 2002:a05:6870:e6cd:b0:3d4:b76:5080 with SMTP id 586e51a60fabf-4157b0c8eb1mr7792977fac.28.1771973220715;
        Tue, 24 Feb 2026 14:47:00 -0800 (PST)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cd54ed8sm11007733fac.1.2026.02.24.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:47:00 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/2] Add selftests helper to get N unique ports
Date: Tue, 24 Feb 2026 14:46:57 -0800
Message-ID: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,redhat.com,fomichev.me,gmail.com,nvidia.com,davidwei.uk,debian.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rss_ctx.py:url]
X-Rspamd-Queue-Id: 1CC8618DB1C
X-Rspamd-Action: no action

The rss_ctx.py tests would occasionally flake. I found that the successive
calls to rand_port would occasionally return duplicate ports, breaking the
tests invariants.

Add a new helper that guarantees generated ports are unique.

Dimitri Daskalakis (2):
  selftests: net: py: Add rand_ports helper method
  selftests: drv-net: rss: Generate unique ports for RSS context tests

 .../drivers/net/hw/lib/py/__init__.py         |  5 ++--
 .../selftests/drivers/net/hw/rss_ctx.py       | 13 +++++-----
 .../selftests/drivers/net/lib/py/__init__.py  |  4 ++--
 .../testing/selftests/net/lib/py/__init__.py  |  5 ++--
 tools/testing/selftests/net/lib/py/utils.py   | 24 ++++++++++++++++---
 5 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.47.3


