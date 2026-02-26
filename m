Return-Path: <netdev+bounces-261335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BEgHWpCoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:54:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 877041A5F0F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2621302F23C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6602D97A6;
	Thu, 26 Feb 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Fy2gX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C512D8DB1
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110429; cv=none; b=gzA6suQmS7+qX8aC2BPTWqL9Fb64J5P5GOxWQbQHCl48TsLiW42hPPzJkIr+ISsk/n/tBS4I+jZ0nFJayZmgBZpa73YD+SwqQDg3vdsW5hdzJscoFt0Q6t0cMh6i89iqaCQGzQBPlnUJy00FXpYL/UuO0tFQXV+y6PoRRVcH1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110429; c=relaxed/simple;
	bh=dwiStO/chK1OLFBK71wNHFWP6SlMqftxFvbc+vvnPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvlIMKtfub2KwyppO4XIClql92EYWvUu7xjI4kI59H7hL3xvzn8J3pCpSeQUw9XV41eYtyya3akJgb4qw4BPwhJbLwiksTgRtmuBEB0w7iNO2PP4vpwMc+vPNvGW8fqWWcfEDjam8cArOBJbRTJl/c6ZNHA3iCgTYXlM+Jeycx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4Fy2gX+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaecf9c325so5074205ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110428; x=1772715228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pU3Nlc8ltUu4dkb2Y0/KvgT3i+9qT+K1/h3U6dSw2Oc=;
        b=d4Fy2gX+XQ4X9Hnh9IH86jGWxpldlwGJQZwJgM/fyA2arJQcp3NSkJFUtHNbWSZjVY
         mqmgdovi+ztArNPF70hMQbuJpPcJ4nI5hsUJfx6oW0euYK9hY5qWRgtYN1vq04wfr59n
         pwpXxwmbc6Z/7qXDgKWhdaSf8ZL3V7X3UYdeZ+56t15UiRU4RxEzaZ73FeddH684RCwr
         K1vPmmEggsiKp+z+2XnpGlQJ4WNDi12zbUhzPLLbRfKJXthRRS7QZ11hMeZKlNNnXBa0
         ivX7zkAYzrXHilb83NYqD+WNM0RQvX7ScuXPg/fcbpDAKdB38iXnSZZnXvxWe/KuWl4k
         7VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110428; x=1772715228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU3Nlc8ltUu4dkb2Y0/KvgT3i+9qT+K1/h3U6dSw2Oc=;
        b=U8ljhOE4JdxSuAzhZxULvIBazosmwOiU7fM5PqSRhDyqpGMjSv4XLnA2dbOCwPg5zo
         qAlQ4W/XTWHLakYUs+a7Bk7dd8FHpyAd33ed96suuUM6PctHSYH/hkFH7kEA4aPy2j8N
         T8TS7X8qxyu2eQHkjEnu4sg+xGeAiATb93RCsbr+8MstM+HH4fO5VBGUYl74tjg72o+5
         l10GRGhShFDCMB4SxS83gXTn+EmjEDtvFswkwqqg7yR4k1hxJGkhqbCgvu+1xcoZQed+
         awkcZaMvFKlWjA4eBHej2tm5zi11uWRUJCVWOXG0pQMpl+K0KXjQpmwpkkvkYxJlSWcI
         3Jhw==
X-Gm-Message-State: AOJu0Yx2L1qvnvu/7ZTUoitAi9ZJp4FgmClnmc2rqh+1cTT+CN/wbi2m
	aEb0vLHShEtKTayRtSoUV7uruX51abPFW5C2gccsye6SEH4ss+wdYBD6r7+8Y2MpwXE=
X-Gm-Gg: ATEYQzw5E9T8m+Jegmo4OhdDdvAfvYOSK0tTBle18lps3jBax66qWFs/Lmbo0v1NZFQ
	JWj9LOkYfJ0ztroH0NqBfCC9Wapi2f0X8bQ22ITa1umv+zoKThDu0+Ug5vhGhg+1uWVAwI0+zFN
	dPLFe5FXNNgQg+5czirLNwvRWoM5u/18uBkptYhu40NrOY4TD9sd0L9Y0k0dn30xQWGLcPuOQl8
	0sQtZmRni43ENj79YdFD+Na0Y1lMZs5t76AaB6cLoGrqCuFoH1GMsOsKTj48FQOuV+r+Ar8rtHc
	valUiIaZaYkSJvaxCBULzh8GBZdAAU8GrgovRuPlBzPoRLiR5/kYlneOLkOAemVvrpEdtOXwaLa
	CEVVMfqcmF9vVNtfzIL3pgaC/trTkrIA5oxg8xV+96m7Svrss0AJUg/QXcUlw3Naig2v8Vgcwg5
	za9mls6wzaZTjSycJSQiOw41Zr1i4=
X-Received: by 2002:a17:903:2307:b0:2a9:320d:285e with SMTP id d9443c01a7336-2adf79c86ecmr24944385ad.27.1772110427685;
        Thu, 26 Feb 2026 04:53:47 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb705b53sm25276715ad.92.2026.02.26.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:53:46 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/3] bonding: fix 802.3ad churn machine and port state issues
Date: Thu, 26 Feb 2026 12:53:27 +0000
Message-ID: <20260226125331.28147-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261335-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond_lacp_prio.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 877041A5F0F
X-Rspamd-Action: no action

This series fixes two issues in the bonding 802.3ad implementation
related to port state management and churn detection:

1. When disabling a port, we need to set AD_RX_PORT_DISABLED to ensure
   proper state machine transitions, preventing ports from getting stuck
   in AD_RX_CURRENT state.

2. The ad_churn_machine implementation is restructured to follow IEEE
   802.1AX-2014 specifications correctly. The current implementation has
   several issues: it doesn't transition to "none" state immediately when
   synchronization is achieved, and can get stuck in churned state in
   multi-aggregator scenarios.

3. Selftests are enhanced to validate both mux state machine and churn
   state logic under aggregator selection and failover scenarios.

These changes ensure proper LACP state machine behavior and fix issues
where ports could remain in incorrect states during aggregator failover.

v3: re-post to net, no code change (Jakub)
v2:
  * set AD_RX_PORT_DISABLED only in ad_agg_selection_logic to avoid side effect. (Paolo Abeni)
  * remove actor_churn as it can only be true when the state is ACTOR_CHURN (Paolo Abeni)
  * remove AD_PORT_CHURNED since we don't need it anywhere (Paolo Abeni)
  * I didn't add new helper for ad_churn_machine() as it looks not help much.
  * https://lore.kernel.org/netdev/20260114064921.57686-1-liuhangbin@gmail.com
v1: https://lore.kernel.org/netdev/20251124043310.34073-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: set AD_RX_PORT_DISABLED when disabling a port
  bonding: restructure ad_churn_machine
  selftests: bonding: add mux and churn state testing

 drivers/net/bonding/bond_3ad.c                | 97 ++++++++++++++-----
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 ++++++++++++++
 3 files changed, 146 insertions(+), 26 deletions(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

-- 
2.50.1


