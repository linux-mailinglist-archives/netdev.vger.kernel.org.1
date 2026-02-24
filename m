Return-Path: <netdev+bounces-260469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDDCOr6LnWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-260469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:30:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8D1864AB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F2DE302711A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653A37C107;
	Tue, 24 Feb 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhfyw7Mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196737C103
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932307; cv=none; b=Y2QpHZglpajCFQooZkGVg4onyax2csHfHmXTXLt2EtGiFDRXSz8a1lviwUnebaL19MYvb7NJczMOxi+Euufc7frU0c4OLJKPq4q0VfIXLl8pnx+SoZTae9l2z+KhNenzd5nO1o7EDSNzMUN6FG8OCcayFKT6WIsMldY7GHReHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932307; c=relaxed/simple;
	bh=7bdhHPhySj/AVG4aVLAyHnBvfKOWB83ahb3JGfgq+Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F79cNqCkp6wS1PDNLjECUQN8H0ZBpiKgww14G8w1xfHuZ3YBIYyO6Kt4IRONBBLYxyyrbGyETnYlY1jr7Ls5FFmllRQpHj+gUU6rDx7dztBOOVLj9T08UVxttmsa/Oxgq4ThXCUaac+twKVjDhGV2VueB2gX24R28dx5dQWACck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhfyw7Mz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230c839409so4453225b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771932306; x=1772537106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xS+1ANy78PygoLDhQXmSx08yr6dtxSTbNApKDUoI13s=;
        b=Hhfyw7Mzr4QUbM4UEeq7TBiboYasP0gG33lSMA26aTgK8EVlS7ztYBWbDEaTmJY625
         c03KMIga0AzwhRvc/BP6MWz5a6ybqj7RXzQFjG9PZmuTH+jAc22a7fk7MOIwWrzHK+hl
         NpoTHue/1ubfPp+9BuGZw5gUl7bSxPV4WA0q3hrnmO15CpgI3lVSsZtY4XU3s21/HwFL
         dIyELfkV8KtS71bbylZXAOkBaAd153yzz/COobokNklqsy/2oPAZiI0NfsJ94skJGeDQ
         SxrIT34KSjPCD7XvjS4N3zP9oAFZzs/5gQfp7hkO2CXOaoLa2Ddp9PtC7uWUSLORmtZq
         Kvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932306; x=1772537106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS+1ANy78PygoLDhQXmSx08yr6dtxSTbNApKDUoI13s=;
        b=tpNRCcgQgPsy0PYnvgxzHsRIyFZ672HMIQy4LKdO0plj0kgCe12tKl54DTO0dABmB2
         oFhWlkYXKGl1fo33DXmKPwGnk1TiHyUtp0u+Ey3k/B7eEE3vxJ35U3KSbiZAnNjkcSU7
         douHMtqJwUxf/zZZBDgpFZN5ryj4dv2Eq3N6HTdYQTS1f06m01srYqNuzjEomxNOFi+h
         U2PogqM1mZeqYkJqSNC67ZBOxL8J3ssrLBDktYnhBldAcZ4ePkAaM1y2+sNEly0GpCRm
         dg2o2ifoQtWua3tG3Du7VKjCwoTL2dgQL0vyYt9FPf3p/4xlLzUClQxVke471ixMMfEw
         AtMQ==
X-Gm-Message-State: AOJu0YzUWQRzJviPRF4T3mRz5aLYXHu8P+AuKbUGUD5E1nTo+/aRIuyn
	eHdKTg473oARiYyg3GYzFHRGL1O/UCi8/oKPbvzAzTo3Q82lywqOp8zu4ccqcp7Q
X-Gm-Gg: AZuq6aKO77k1rXtwkOFtT1B3KfgBj1oulDqDljDMXwbu8efzLlpJTM1UBsvMsdFS9U5
	b0Bxtb0sVqV7CnRyoUXoSF6zDMeu1aFHcbSHf0AYtVcQbeGGI5Hfc1D8gogv6CJMNrME4OPBbEU
	HL1WYUVhiqVRCqDVqk+uwGR3Xkr4jlD2JOHkCj17ctd4Eq7oii1NCLH6vAl0z1JYv0O/khefT4l
	/1jc9fG4BByWNay0zGb+W48hEwhPudHdfWbWp76VxHc5NUjuzoSUt9LM6s+zMj7qKPAZZkmI7Qu
	rRjUpwcJdxe+JOHFPmgZZ/zVj/zxOW/d0MVSitqsGh3Nkxt5MkHLeO9WDReVsBpcKW9KTNwx8d9
	12EL0O2V0qCBSaF6f4PDl8WLxMQXwxmVQJqzl956Bq6ibT/7ijAZieDIPsIs5sS+GXXW672WOUI
	Kd+xoe6/hpL4wLu2cHKCtgPwQamuWDd/QZfqQ7/Xq0FWVG
X-Received: by 2002:aa7:930a:0:b0:81f:5f49:6913 with SMTP id d2e1a72fcca58-826da9ee839mr10464994b3a.30.1771932305814;
        Tue, 24 Feb 2026 03:25:05 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd694eecsm10262316b3a.25.2026.02.24.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:25:05 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Tue, 24 Feb 2026 19:24:04 +0800
Message-ID: <20260224112411.1561917-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260469-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 50F8D1864AB
X-Rspamd-Action: no action

Avoid load/store tearing of 64-bit values on 32-bit architectures.

v1: https://lore.kernel.org/r/20260203171305.95085-1-mmyangfl@gmail.com
  - use functions instead of macros
  - rework commit message
  - hold lock for stats when possible
v0:
  - Sending remaining part of
    https://lore.kernel.org/r/20260118013019.1078847-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: yt921x: Refactor port error message
  net: dsa: yt921x: Return early for failed MIB read
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 235 ++++++++++++++++++++++-----------------
 drivers/net/dsa/yt921x.h | 114 ++++++++++---------
 2 files changed, 198 insertions(+), 151 deletions(-)

-- 
2.51.0


