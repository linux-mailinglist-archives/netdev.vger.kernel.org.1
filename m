Return-Path: <netdev+bounces-202649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4706EAEE7B3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A9A1BC287D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC2292B4D;
	Mon, 30 Jun 2025 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaYW5Pox"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BB23ABB1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312600; cv=none; b=eejjh1GhusPnkuc5drs+i3jbi2f+IChtq7pEpaOK5KXI5dTS2sXhwA5bbgIIvMiPI4ie5o9WHvuYCiDyLJ+WiMLDwSHjDWVMhHscjfVt5vPsf7kIaNhTzK9SW8Tsj7qaz7I0biHUQa/FVFr9s+7PxEWUvyfzI9ljyQVsCmHZwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312600; c=relaxed/simple;
	bh=vglCAmp/XtqiKVOs6kO1PyXcNO1MMYPnV5bMxK0EyrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0zmTBSm4fg/ixcqzMC+nFLdF0qqYQbsmC39e2kmrt38DNu//S4RsQaV08KPVhsELdbtMk6k8ndPxIQ51Bs0XZqpDVpbvdR0DtPRy6t9oxvXD5G14S12dF7oQAWJuSAeM8uUqPDuDQpKQ+QrdMvLyfAqU30/UNPid7Wrx+cD3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaYW5Pox; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so2166374276.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751312597; x=1751917397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skJ3Mm0AIUR2CiTBtYkfersaKq1mjbDkMWFVEAf+jx0=;
        b=EaYW5Pox07MrzHT3dpHsODjag89nzK53lKKxMmwTZ5nHcRH+ATyTrj+ubQMVRJIie6
         xSkekfyk9xoL/EBbOqbdPmvg5VD4DOtoCYCsuqMOCaUb3bu4TySneh3N0q1gwdN77nfn
         Gf2vC+xE1chyHXA0SteX5DeviBuMtfvvEft/JJXqW7ypIi1RxqQ3/lbIDMoHo3/G4d5b
         tEQoYvesgemS1rdWi1UBJTkoRKfhr8CYTTimbkefENtqhqmU+PV93Ej/cnBxV9CoUlBy
         T75g0ZlC3mwtd134eKETimBgchxmW4L/oTojlcLG4Ev6p5ZKiaKIlF1V8gIyt2wbrj4C
         9HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312597; x=1751917397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skJ3Mm0AIUR2CiTBtYkfersaKq1mjbDkMWFVEAf+jx0=;
        b=k7CFNlxlkmhUpnHDFz6qZ2Oxvz5Nw1CxDNzdKEtc1MhGrmRqWWQDoyo4dY2wHoKZ0c
         fedVjuXnTGcu5nsxtICuSBJqlXgiVirtKRSAqDg2mhsFBcgpM0sDmNoGupwb0FptQpmX
         GmgxFuNezs0mG7l7sMcZCKBFRYiwUbL74SF1h1j/x10StUBnEhid6RDJXEyn5PxRJ2we
         9B9QKOsB2IDYl0tOdsE70DxPFwdhB3++m+o65IcaOFP537NfLYten1HyW7oR/0e1Rn84
         MyajD1wCiQZxfKkBn4qLTnzb2HfpUQitWh1KaIlRwBMFRVN6sWxnoV1hLx5GGnxAL1ij
         vBuQ==
X-Gm-Message-State: AOJu0YyigEhDYPHWz9QVPKh+CUZXh56qKBFK/95sUJjYTetVG18wAH4G
	LRwxI7DsRHyHLUh41hAoZRwsT3TGKSgCRd9VbdHoKqLFL3cpC2TQYgAc1s0jbA==
X-Gm-Gg: ASbGncuMMst1G+m1qQOuJcccc88ye9wNHY3rn+WrhlDUiYgM+AN7uPcH1LRgEicQJJy
	Hudd56gJxn3J1UrDwjzOwZ2Gaf9mqcSJ2Bp5Te4T9r+H6pIXTJWCVectvJ0tfTxjuq9GWAuWFtX
	GrNAznYdJ3p6ZkGAQ4+ZDuc2TS0hiOtE1ClsDelPuXQr7+Qp5CI7+C5rYYvLxIdisqC9ltMplM4
	1sWB1475Qmf7XHj2ZydNZCtoVViS44hqaf++9xlQz8u8PbqHzyod+IyrsNPQWVpSePNpraJAkk8
	cFOVRiu4nmGNcnBXNnAqCuoL18oXPwrGxVEQnueCRVwFZVIeRdoCOm7x+YjjQLcZHVNeAXVQb4S
	IYwXvPo3rZhtRHNVQEgq1+GZG+V6M77bOHzP8SM2gFsbMz2VyrVe59WoFoUxzZA==
X-Google-Smtp-Source: AGHT+IFUEU2Svc4SQalIl6BEpy4J37ZQJhQbXz25bvDmJ/vthg56uVgxvgZ4Em1PffUzuiDFt/i/Vw==
X-Received: by 2002:a05:690c:fd0:b0:70e:2c7f:2ed4 with SMTP id 00721157ae682-715170b9004mr214989637b3.0.1751312597437;
        Mon, 30 Jun 2025 12:43:17 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb2661sm16884177b3.85.2025.06.30.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:43:16 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/2] preserve MSG_ZEROCOPY with forwarding
Date: Mon, 30 Jun 2025 15:42:10 -0400
Message-ID: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid false positive copying of zerocopy skb frags when entering the
ingress path if the skb is not queued locally but forwarded.

Patch 1 for more details and feature.

Patch 2 converts the existing selftest to a pass/fail test and adds
        coverage for this new feature.

Willem de Bruijn (2):
  net: preserve MSG_ZEROCOPY with forwarding
  selftest: net: extend msg_zerocopy test with forwarding

 net/core/dev.c                              |  2 -
 net/ipv4/ip_input.c                         |  6 ++
 net/ipv6/ip6_input.c                        |  7 ++
 tools/testing/selftests/net/msg_zerocopy.c  | 24 +++---
 tools/testing/selftests/net/msg_zerocopy.sh | 84 +++++++++++++++------
 5 files changed, 90 insertions(+), 33 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


