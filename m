Return-Path: <netdev+bounces-275287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM72OSBO0Gnr6AYAu9opvQ
	(envelope-from <netdev+bounces-275287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:32:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794B3990E8
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD8BD3008D42
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3236DA13;
	Fri,  3 Apr 2026 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="r4/YVtPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793422D5C91
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259166; cv=none; b=mkJFBvtNn0CQ5tYIjNSNY8+Y9Y9BJ4Oeech/FOIZXpxcJQm2vd44bLG832ucj0JoGUVMmdGbsih8pTLZBZgl4Rqo7Uj/tygmX6DH/wRZjQ88phzKxuZ7OsI/7QjPUGOLXwnbod/sTqrsi9gESGXfgT2oIQaYVaqOAE0Hzlg/52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259166; c=relaxed/simple;
	bh=yFGcPJop85wZ8cEx589GhB/V7R68vhleWngS6mZ38Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjqdtZytRTr0qqH+I43u7gZRL9+YkBDBeVnu3o8+tmjc+OYKp9cQBBGwrb+ShCSarZBkvFoXbY97rsWPFTLEuWw+1upyBB45kuMBpDHg2AAY1WGlAzZ9eLl4CA/DBW031NORmINiAi8rSRHTK+Ps1pxFh4IGmFFmSjnIXY2wvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=r4/YVtPc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2503753efso18890215ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775259164; x=1775863964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/xbyaX6S6fstMa5ZYhx/htsEuifHcRUa1re3mF/dzg=;
        b=r4/YVtPcYvO2rAdN/VddGq6IHAXriK0jj8SC5Xj/F51ENj7EC5K1ZPN6rwE5f7Fm0u
         oP0neAYv0V9q7XnuU1OWZn0ItxSXmIS6501N0oLC/C9pcNW6Uv1EgFWimVRh2b07KJQH
         3Xm/6+1r5BY32edjKT4b0W9IikeEkxB2dlRO5IXjTwKKNhqgtbXSV24aSzbSpI40yTSX
         GvLirQJEE7PPDQtRJszutqMscnUbMZv2yvhAN9Z51RDMLesPaMmYITeBxZND36gaAK2C
         hx6pdLFT/ZnRxaY8z0fhh5mFJT9dvlwbAdeYS0BCQzGl+NdsbM/jqgegCGQcAszxEMRI
         at3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259164; x=1775863964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/xbyaX6S6fstMa5ZYhx/htsEuifHcRUa1re3mF/dzg=;
        b=bFaWT3d6auVZHePOe+ffqhocxY2QBh427duf30nO56b8aktOk21GZkzrStYBD7aWk3
         EHmYpCOKsdLIzK1r/BFBGvwSXdEOXhxLH6CEdB/iZABw83MSoGYLcWodCxZjj7trv7CS
         IQ/xskWHxMk/Zat2qdT4Z+sGyY4BqYRTe1wY9VoFsXLYH7WrfF1y3CwfIkAuKMnKeymB
         RGLmsgsVQJp8m9YczHUlsrAIVErCCqJcGAktPs4c3lwtm+6X+6eHep1dh/9B+32rlq7+
         OPAwAUNYtyImvpod1Umg3EyGr29GVD4PwvhvIksQOL2jPJ5d5cBQanA4VCY5L86B3/Ps
         b5kg==
X-Gm-Message-State: AOJu0YznzCibT0h8Sc2dVAwvZDxV/NoPXmqIrZ/4G/B87AnaAVy3D3hU
	vRotaEb90++2okTiqzDP1Uxaq3xNKkhaYIPXJkz7dRKqsE6DET+1fPK/0a8jtZz36Og0hKEMsoh
	JJyoNKuE=
X-Gm-Gg: AeBDietydF24guWYKbgjQipJpgbqxSj1kx3eL7IDZlky4tv8sj5IL8gmJpsl3lrWeGs
	gD6XBQmOQFubtxFYtLy4w5JM/XOF0dKN46oJY4nT2IDbdpndnvX6or8W98tWOkPB+5R50m0bMfC
	V92Yw1Rg4YregOwGmh3i6TBQDDa1+bsj6DgYN25LmfuOTiB0Q1/zmrMrkySY1oto5G0kt7+lRJW
	vgVml6vCZim4oeoqyhShDJ5BDXm4xLB+w+Q+s2H0ctkBThOW27fpIkzqAmAeqobNydgv1OQeWBv
	GNVEc/oEe+pQkPzJSCF7wmttqJW6P0AvdMMEmyrwMpHSfnao9RJC0YtXfiWnJRhaPC5Qq/CPx/0
	tg1xgQs+Cb1CZWnIgoT1QGMShZc0g9nGWK2FbMs92VFNInytMdJDGJpS55YZb4rVaJXvP8ZDEgJ
	+tKOw9
X-Received: by 2002:a17:903:1a28:b0:2b0:cb96:9815 with SMTP id d9443c01a7336-2b2819994e2mr45703355ad.43.1775259164524;
        Fri, 03 Apr 2026 16:32:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747af6e7sm69050925ad.37.2026.04.03.16.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:32:44 -0700 (PDT)
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
	Joe Damato <joe@dama.to>
Subject: [net-next 0/3] Extend packet socket selftests
Date: Fri,  3 Apr 2026 16:32:35 -0700
Message-ID: <20260403233240.178948-1-joe@dama.to>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275287-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8794B3990E8
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

v2:
  - patch 2: remove argument from do_tx and use global instead
  - patch 3: add argument to do_rx to specify if the socket is a packet
    socket. factored out the aux data check into its own function for
    readability.

Joe Damato (3):
  selftests/net: Test PACKET_STATISTICS
  selftests/net: Test PACKET_STATISTICS drops
  selftests/net: Test PACKET_AUXDATA

 tools/testing/selftests/net/psock_snd.c  | 137 +++++++++++++++++++++--
 tools/testing/selftests/net/psock_snd.sh |  10 ++
 2 files changed, 139 insertions(+), 8 deletions(-)


base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
-- 
2.52.0


