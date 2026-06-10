Return-Path: <netdev+bounces-297479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3N0ND40DKWplOwMAu9opvQ
	(envelope-from <netdev+bounces-297479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC411666395
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=aMLT31pf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297479-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297479-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D8B306B9E5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2F372670;
	Wed, 10 Jun 2026 06:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E633F58B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:22:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072566; cv=none; b=sqeRDUmNflZMz3iz74SajG4JewmWJcXDiNclSIPY2B7sGDu5teH3qOpeJ52dxgRbNpaNACm3ZTF40PZEY1HBsZGKF7pugS2JVBYwhGlhNZ4bZHm3oMqLosX4rMmmqSUJTT4YUPCogo0kN5s/5WOhyzpb7ZxfFkzN9ZGlDdMT6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072566; c=relaxed/simple;
	bh=1G5Z/r/CLcO3rcLtiqRPDta/nElVm7Ks/bwx4ygMmMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH4YVh/TKXvnFTHvWebUNYaee1BatWzUoVyr1Wqp50FbOaBSAPF4oe046xJ8AB42CLwsRWxhsPrr9vvya4jQJ45G75iSjz0NOdUTOaeBqZ4rLM27arIHqi+6ZQv31CpTXPS0e+n0Rfgow4GriDG886RsGiDCByCbQZ0n41547Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aMLT31pf; arc=none smtp.client-ip=185.125.188.123
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8DEA83F5FF
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781072560;
	bh=yyj6UxFFAHEJQaifJORx+nCQZ9WfyZvUY4fGAwLJA68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=aMLT31pfJHq3CdVo5DnVviIfI48bpuIt4dvwkuo1Yrv9cfXDybs549Ea7k6/jQ7ec
	 Q4np82o2q86zkc+TIHHRlqTPQ25XCpbU0RDfUWVnnJSxWK5WtoJN4sRVrc+FbUo21S
	 xNUsCwacMCE1yclbgE4SGmKsNOboqbF7De/EZo0cGfNSzdbPI8vYuNKLb1mhcQOOpi
	 pfSqJ9I1irmWBGtaObdxALZX0gxsiiBuG/zPAm/ZFONqjdoAc3K1MAqGoQqyjwlHY0
	 ySK/sxGO2p22pGgGpng9cRv3dLm4XAIHC7jR0ro5Y95rEyRsJA1dmcPi33JjekBEsA
	 U2OnZB1oI0ELrPfBSyZogzIMp6coYW+L61Y/DG0lvLpA5TPfqBvNsWHi5jx087TzRH
	 PHYw3QaSIN2lZNI6cSALB5BRNDYrYh8Z4T3BggVqGAO5+OqwXym6USooxkV/8FDOO/
	 83L5+mnKB64y6F2qmpY4jIg/vMDUEA+mKl6eijwaMqxZkGndTq8GJSaDHCvO4ORrC2
	 HZ+KhSfYnmRwq4hnZe+xnR6BPhlQriLjMmxy2vW1Y/JGFpby6I995n7YTC/XWKLC3b
	 EWTHkYIluO2hHvxk5X4by3CFJThmNy0PUrRFxqy/fKnpGSNAvcR3KVajWsOi+2uZ7o
	 YJ6cTtAdam78C3buxLWV2cuE=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d99333358so6114285a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072559; x=1781677359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyj6UxFFAHEJQaifJORx+nCQZ9WfyZvUY4fGAwLJA68=;
        b=HFbOlffd4NntE9m61Ykz8jrzrVh1kObztXHnBiPDesUM31Ts/UK5VLkOp2T6htG8A0
         owttbfzlUSKg3RLrX9JfypCdoShgIncNBMCjGuU/QLh+59XTh2U9LM5RvoZOSukBB4XM
         8DFZcddpJJnBaBFqYPtEm8DR9wBqZMkr2KUNZssfJeg2q9wFC7DBVOTSO1+x8vOulW5s
         9VKL0OFzQlxAKHQFPyenlnlZ8t1fXbaiJbdwL1ZDM+MIHp+QsxcuMGfiGkzHNheQx+Yr
         xtYDc+4bVAhE1AeEPvU3Ms3b5PNPJ20VocOq7NPrcmwHhN3GDHfT0rlfVcLj8lVLhGc4
         cesg==
X-Forwarded-Encrypted: i=1; AFNElJ+uDi2NtWqqvg+gxi91lw7L5l5e8jOvvuIejgwkVpRi0MgpohbdJxwxsKPIjFOwrC45Kq/CqLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldXrKg4XMomnj5aDeXlRONF87hYLKKaJN3lFB7XzSiVbVm72O
	siT9tSvfTMy/j4O4h9mJJjsJgdQX6WdyWgIkM90wzEdxyKMM7sA/S8+uCVtYLRKEFAcd03MH4hV
	t1B/mknZ6HxajQqM/eACu3+vlIWJHRULq0RLEOSIny7O63xh95A/7Ft8klFGSYdrg/qhTm8B61Q
	==
X-Gm-Gg: Acq92OHhS4pwgUT5FLIHSJu9Q/QCb2N5FLGA1VVamXMLvxREhzvkGO8XBEJVqY/TOfl
	bLxLcFaSu9T4ybB6MEWldlKw/TtZtkNG64IEu+7oQ4VYKexJqmqrOZog2rySUMIH+2XIxOr5muE
	QDUvks6GQsOb/SLkXtEeS6XbNk9csW5ITNI31qaaRWhCyDQkFI4fHAusc4yOL3sBIEe1pUXhzMI
	Suz7awW6pcLv0VNd08J3f6WM1oW1ej4U5QvvbzA8c2CHtxF+NtJO9NBvJH7BRD6DezEnuukZap1
	3RzMEo2CySuLhhBy/owea5UV6fCiyp0pKGHsLejxUCnzRSH5HTRG/41mI/U3AiYbWzsGJsuBSvK
	dcSQ0hRXEBJdSozRZJwmhfIUZQEagJCpv6eGR7fippVTO6h4=
X-Received: by 2002:a17:90b:5490:b0:36d:b12f:6143 with SMTP id 98e67ed59e1d1-3752177f893mr6537000a91.25.1781072559143;
        Tue, 09 Jun 2026 23:22:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5490:b0:36d:b12f:6143 with SMTP id 98e67ed59e1d1-3752177f893mr6536975a91.25.1781072558830;
        Tue, 09 Jun 2026 23:22:38 -0700 (PDT)
Received: from ross-pc.local ([2407:7000:b06c:d300:82a9:bf58:ce21:a41d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm946176a91.2.2026.06.09.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:22:38 -0700 (PDT)
From: Ross Porter <ross.porter@canonical.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ross.porter@canonical.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>,
	Oscar Maes <oscmaes92@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Wed, 10 Jun 2026 18:22:28 +1200
Message-ID: <20260610062230.71573-1-ross.porter@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297479-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[canonical.com,davemloft.net,google.com,kernel.org,redhat.com,librecast.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:ross.porter@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bacs@librecast.net,m:oscmaes92@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:mid,canonical.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC411666395

The broadcast_ether_dst test can spuriously fail due to file
permissions, depending on which flags tcpdump is compiled with: If
tcpdump is compiled with the `--with-user` flag then tcpdump will
step down to the provided user after opening the device. In this
case the test fails due to permission issues, as the output file
is owned by a different user.
Debian ships tcpdump with this flag enabled, so this bug
appears as part of our kernel testing.

To fix this, we can ensure tcpdump remains as root (regardless of
whether it was compiled with `--with-user`) by passing the `-Z root`
argument when invoking it.

This is my first kernel contribution, so please let me know if I've 
missed anything.

Ross Porter (1):
  selftests: net: fix file owner for broadcast_ether_dst test

 tools/testing/selftests/net/broadcast_ether_dst.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.53.0


