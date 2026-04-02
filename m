Return-Path: <netdev+bounces-274763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBkpFUb6zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F738F2B2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51BAE3019C83
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2360383C68;
	Thu,  2 Apr 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="0jADmYu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA293612F6
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172161; cv=none; b=PjagabZJ2CScSsNIKZx3XqHnbX8uL8lZYdISoZusqIwj3oz7yGMWbDA7gE0pRpA+ffyd1XJP1Y1HnMLaJpdPbgELJW6267Zjr8wj0PxUhxV8SKMgWWDy/ZjWxSLbktbfO9YlBNG+rxkTanwUN5yL0GZyP/YeE6PyxKFSUqtYLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172161; c=relaxed/simple;
	bh=X66sMD2JSJlwtM4s4LLO8jzXLNBFVA3A/cf33Aazx5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxDilAqyXv3nUjBknMtGlal2d0gp3O2zduQ2b39/eLBWXagJ7S/8Scd1LsQMyxfwwkL/VINIFsfAMt8b6U1qmyJsiWsVDYE1uGdDj6rK+wF4hcYy0bwfNae5jlttmqU69/zDRUqwRGrZffdfVQUiMS/mXT36XfdGI+FeFHg49Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=0jADmYu/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296d553142so668835b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775172159; x=1775776959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dv6FE7db5UvibRsBKbh58uqqCUadsNI5imxVzaAN9G4=;
        b=0jADmYu/o/xjpcCFUsWZ3dfE6eknKXQiDZBUi6m9nv+3mGSfnolvXsRt7Cs3qIKPIo
         jvjky1YlgJ36yKfhPOWqajNPm0AlR/+vipdubt3FUA/CA6k4llodoicShlXiAi+qyonC
         vVlLqAmoCDDHZR0ebnPjsy/px/SpNDOUOtSFFHeA+2+wU1wdpzbAOmUVWPQ12fm78kat
         nH84mj1y7dOGiJOgYHVskz/oVlwLYdkLRUB6kK6J+/GyceQKA8mol/ISQ59MQLBCkCpI
         mXb+OL5KoJR33z1iu/PrHYTWVrlqoielyfancoqhQ5L4kgp/P2MAgqb44xqljr0EOnVp
         h1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172159; x=1775776959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dv6FE7db5UvibRsBKbh58uqqCUadsNI5imxVzaAN9G4=;
        b=e7QXZnGYLbSpb28KgoPaDzQRXiZmLSCJjbWxsRjNL6Egm6XLaIi9YgXabHj738e4HY
         +j3QXNOHOfH6GccNeTLziOckcvWRUiBfq+CMsKtF0cXNeYA9uwbA/ZhNd3YmtEmRnL2O
         j3auHao2lVBkh1aHm/xbkj+5O99xn+z4w23tQ61EREvITF7XfTzbUUKBE+2GRsNv6zr7
         TFPuLiL7bCoqXJEkYY4ZWU/9WOoIn2xDSWpOnm8Zo8cDpZen+qquNml2C41a+OgcXoAy
         2bpwJOTqnRFJAWKP61AV2SiCwy/sp/xFnc+KIXCBHL+5BrICIYXjBmGaY25CXaZWSrGl
         AlBQ==
X-Gm-Message-State: AOJu0YwZ4UuzbCZW5Eext5pPHDwSaT89JEHzuEtWMEiih+Pvm1IXylfs
	CUECmh3gjlR+ExJBOXaNp4mKrNj1HGbTfXTnLHDPbBI/3UWvCTe+7rLVvsTvnqP9TnDUGh+JLxb
	z6//YuHs=
X-Gm-Gg: ATEYQzyvFfRJXc2HUOTLs6gG2NbP3y5Y+CD1xaIpphqy8VnzA/WnGTj6hYjfYXoINpe
	M+skmTPTh0WD5AniOyejRQy3QDof1h+HCAkSVzrzcuACUzl95BcCr6fbCoIX9483/OubEPfQrwH
	b2X5pQhRirSguWUg4Xp1Xrxhrdh1ObI75PTRpU1R4gIZshmymk62NnN3j7wwo23UQAdB1+Sb97v
	OR1d2ruiejMtjWUdneFJYcZvBC9pGDgCxDiH/tg+xlWIzh9wsbbr5NLz/1dJzXrHdCmYcPi9Cdl
	Km9TaEUUQNaGrq/SfFNG9GyMLXxQFKeUutDLD7QTiT5IgfJuyM4975ocrTi+COTgPscl/pHxYFs
	Jt/rq7dn9vBoz8u0NBWChq9Clep9ZT/iUeUrTR4Fd6Mfhew0Bn8S++n5nUq3446NOIPlpSsnlo7
	NPZJA=
X-Received: by 2002:a05:6a00:2d12:b0:82a:190b:2225 with SMTP id d2e1a72fcca58-82d0db717efmr836294b3a.31.1775172159417;
        Thu, 02 Apr 2026 16:22:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3dcb3sm4064933b3a.16.2026.04.02.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:22:39 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: [net-next 0/3] Extend packet socket selftests
Date: Thu,  2 Apr 2026 16:21:56 -0700
Message-ID: <20260402232203.2004496-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:mid]
X-Rspamd-Queue-Id: E33F738F2B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings:

I was looking around the packet socket code and noticed there were a few
features that could be tested by extending the existing packet socket
tests.

I extended the test to test stats, drops, and auxdata and re-ran the tests.
The existing and new tests passed.

Thanks,
Joe

Joe Damato (3):
  selftests/net: Test PACKET_STATISTICS
  selftests/net: Test PACKET_STATISTICS drops
  selftests/net: Test PACKET_AUXDATA

 tools/testing/selftests/net/psock_snd.c  | 131 +++++++++++++++++++++--
 tools/testing/selftests/net/psock_snd.sh |  10 ++
 2 files changed, 133 insertions(+), 8 deletions(-)


base-commit: f35340f2d653f1003602878403c901396ab03c17
-- 
2.52.0


