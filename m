Return-Path: <netdev+bounces-258154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFM0LUyPi2nYWAAAu9opvQ
	(envelope-from <netdev+bounces-258154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498D11EDEE
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 399313007891
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F932FA18;
	Tue, 10 Feb 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CMWhkJQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199A2FF65F
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753864; cv=none; b=k9oz9Y1fw7FPGO9QSLmaP8YJwvtA09oVpxDxwV2JdGbAUiruLHxsZ3M6XLNbULI7AzgLJlju1ll3HdJD5ORTQiqK0qa9KCeAlDu3/h+muQQJBfqtpZe7CIJt4I4Q1W3mu0uIzYF0OHCGGp57XI8LykFA9Zc4mbwRdpWpLBG2UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753864; c=relaxed/simple;
	bh=xcChzF6CP5xYup+qk5xzMD8Rej5Fa7X3hzwxZKIpFFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDOiFlFP+eKVnQ2k89lcluIOYq8OiN4rwE7f8oXWwB0EEP+nznWkGwXUo+MXiK2vsN+rfGdqLAI6GUpp1g664Uf1FMpBVtWp/svEbZjaw4RCkPpavrlkh6t//xOoZmIaYcIDdGmOIESfsOUVo0NDChiM3Kzonr4BMKzhAS1BCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CMWhkJQC; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40438380b88so773507fac.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770753861; x=1771358661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GurzI6a3NiPuUlCmLabde/5ROg7CIRUmFCrttYEnt+c=;
        b=CMWhkJQC+nVuesTdmviM4N/2bi905wITAvpQLpM6YQ+DtFGjuB9HJHYSUKK2dPtVF3
         LtrzFF3NxZqxygUFiHU5hZ49CYjmqiV2sW9a0puQD8A6/EyYZ+7Hzz1Yr7XcKlpfAEht
         uYfib0hy0hCrNqHjF5aUcO2Dun4Rdb3HwrK4yBwFI+GRumauAA7KXPIubdmMBaJtGt9A
         G0bYGHeyfxUOXnD7/zV8yEjUZLv78Vyjm/aZqYDvF6DRFxoVA18KRTQXmv/3Ebw9B1kk
         g0Cd5qgO3cSeq6fQPkMtub4OtB+/k2FACoJN+f2g3u3WNFzYZnHbjmvQWf656s4PSL/n
         FxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753861; x=1771358661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GurzI6a3NiPuUlCmLabde/5ROg7CIRUmFCrttYEnt+c=;
        b=sd6jF1tgW0kD1j1x1dojMc//JJcE/OF4y6VWQcU4+tWNUE9GiUI/ha190aIQ+RjV44
         /j5L0rvIsNLfAZR6A74u5+dEKORkCpwGxxTzb3etuXmO/EH925UBCjOwWsL5604iI8br
         ldqYArr8LJiDeZjgF84ELh93EBWUw1yQoMykHP9RH8KXpkBMdaA7fjFDIpHWr0Naojos
         z2bNAwaLHSGpi2Kf1JE1ksrcsyfQtPK1tkuQmNJJWh3nCDarrLQN45CjmbkpDuCVbddb
         hVk2nOWqlKc6Qji47qyhIkctDKSHN9bMn+T+s7teSVgGpoAx6hB/yp/21LmEXiKFEpOj
         me2A==
X-Gm-Message-State: AOJu0Yznyc4jnnzGkCUNV7D84CgtjJlzy+x534sWKTTFapPkS0PKJZu/
	En9pHppDxQBEbcl9Pb5aCfNDIq5rtbxroJjTcq1H8m7Vs2TuCGbBu2tMYL8z/izlUCLl2g/cQea
	T81KR
X-Gm-Gg: AZuq6aKM7PQpkTwGzzZ0fFPzjNLgPeoHfA9tneOxZDNOr5uY8mlC+nJDfRED3Ea5RmE
	YoRuDn7HNw9siQsr4b8rk9CWYQjlM1RVZCTyIQqEYqCt0Wa0alLy4s16tYiQHFBNlODyAd0ldD5
	wYaztOfHrNgWVF3sRa+0oN9YvCS7tuBJ9jgQqP4hSsJ4G534ljv9L5fTSaJWyUxoGdCM4AJHVQY
	OsPnn7pr4PbK6cbbyMTpRsxlEGVZzI1LF1hFZ8WrmUOxvwZrHDFgG+nBrH1sT4/GefAFNuEFhSz
	RZ4BQHGlj87kAywmlFtWeFRik4pC/Wv0te9N2WBuRqmjZzIiimbrF7iVERe+ibCc+ncDiN1KtOF
	flBL0SbiltuDeihha/pN3cC3qtF9WeunEY5RoVYSe+Li5frxGfVhi9KlkpXFLjYq+XoIC5D/k4M
	KITE4H3L86Lr4did7XWdYU6DXNAlsgCBBhX0Lgeg4aQA==
X-Received: by 2002:a05:6870:671a:b0:409:737b:719 with SMTP id 586e51a60fabf-40a96dd01b4mr9270139fac.24.1770753860858;
        Tue, 10 Feb 2026 12:04:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99352bc4sm11054119fac.6.2026.02.10.12.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:04:20 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/4] selftests/net: add netkit container env and test
Date: Tue, 10 Feb 2026 12:04:15 -0800
Message-ID: <20260210200419.3555944-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-258154-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2498D11EDEE
X-Rspamd-Action: no action

Add a new Python selftest env NetDrvContEnv that sets up a pair of
netkit netdevs, with one inside of a netns, and a bpf prog that forwards
skbs from NETIF to the netkit inside the netns.

    +-------------+        +----------------------------+
    | INIT NS     |        | TEST NS                    |
    | +---------+ |        | +------------------------+ |
    | | NETIF   | |  bpf   | | Netkit                 | |
    | |         |-|--------|>| nk_guest               | |
    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
    | +---------+ |        | +------------------------+ |
    | | Netkit  | |        +----------------------------+
    | | nk_host | |
    | +---------+ |
    +-------------+

I will use this series for queue leasing selftests. Include a basic ping
test in this series as demonstration.

David Wei (4):
  selftests/net: Add bpf skb forwarding program
  selftests/net: Export Netlink class via lib.py
  selftests/net: Add env for container based tests
  selftests/net: Add netkit container ping test

 .../testing/selftests/drivers/net/README.rst  |  19 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   3 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 ++++++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 +++
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   4 +-
 10 files changed, 272 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

-- 
2.47.3


