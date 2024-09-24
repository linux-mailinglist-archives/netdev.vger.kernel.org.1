Return-Path: <netdev+bounces-129629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF20984F1E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 01:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0026D28506F
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498B189B81;
	Tue, 24 Sep 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Be+sqIBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F8146A60
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221813; cv=none; b=N/C8JEJy5iMQ5F3Ct+e58vRM9eklrmfAFhSbu1emPZoACMv+Zj9DByeg6XAlLaUxXNCvafHAHZf2EvBoHurhegpj4mUFn72VgauIDBf4oekd2sm5nL1OOp4zFuFistcpOIiNnIs8VcW7Y7BR5zagmTQSxR5HtvfJkAERSshx+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221813; c=relaxed/simple;
	bh=a8Z5mmnu+VQJLis1hyP5wTPbRslAt4ObomSNIgtp2Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKCyMoOuA3xgYeRoBfcA+lBMmocna3HzZBe6/5HCqxC5leNv40ZK05b7VUGycQ0Qup8qsgLXJQQZMWKIAPj1EQOmoM1SeG8MRhsu/anu3Oq62alCQPTTuVgku9HAUC0Sv8GvuH1oVMqXDi1Zpg8qmCXwjQPUk74oixoj//o8c+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Be+sqIBP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso4060494a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727221810; x=1727826610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETCN/PQccI3mGV1t1V6gEzjBaIIiFLibedrAaSu0lxQ=;
        b=Be+sqIBPfwsNUHziRkv+z56T4VbaBGez0Oq0LiksMoWjqqICyP/TS/gaQATBlbSbjC
         lbT8cl/KajZzAxeyBD/zI6GXi03bHgfv6tURqcJhKBpQFmH0NsllbD3NmunwcsCJGY8K
         RwGN91Z6SKiUYMKxTUSTRyoWieI0KtaAJosIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221810; x=1727826610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETCN/PQccI3mGV1t1V6gEzjBaIIiFLibedrAaSu0lxQ=;
        b=tIYY0qEAzN0sd5Yr2p3b6xkqRQ8w4V9G3QsiW6pTqVWYYRgWpUd0yzoUOktg9uYU34
         2emqYi1rTSuPfv9x9L6fRpL4Odt5lfb10qyrSfis0pvU2rSY/5VCNBnMsqdkUPZAJphv
         SYYnl+0uHOnZ38OeY+6/eVrREC8LNY7jExuv3QV6bF7y4xtGjBb6zf139i+SMh62sGkT
         qzEfSSaQdP33xsfgp+ue7CyhLgkgPtfu3oXhGTe+o3MsVMfVhTF7YGzG2+aI72bywmJ6
         PTJPTGYUNkZWp4YuAepTo9BeenpJwOlAhsIPdSKm5EpoXJ/RRk+mz3VnL54NCWmnDuLa
         yZOw==
X-Gm-Message-State: AOJu0YyVcGosNH3hwSryqFFRL5ce0UnddmORA1eREmaOI59HBXZcEHG4
	V5dxDK/fFvbli0mnb/BuKZdF4UHjOokNle3KjSF2frnEFADz5GRkr0PM2FE0KZKVCcTG2d+dSpI
	FNIK8DL4KHKon9aDYPDJmRSLoHP95CJ/SIVdN0aVwF8YuTtDNdIEqHFpVjkZeeqQ3ZfXIQhmmOV
	gewqASYMppYZu87RSh3ohkf9MRDAdkdF4mnjg=
X-Google-Smtp-Source: AGHT+IGabz/BkSHAXY9l/2tIxLKDQaWWJM8cFi5pyhdcllv6X47I+AJ9UrIwFqEsDgVFeMO8JhjfwA==
X-Received: by 2002:a05:6a20:d489:b0:1cf:440a:d447 with SMTP id adf61e73a8af0-1d4c6f3071cmr1194891637.6.1727221809704;
        Tue, 24 Sep 2024 16:50:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc834c3dsm1684269b3a.30.2024.09.24.16.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:50:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 0/1] hyperv: Link queues to NAPIs
Date: Tue, 24 Sep 2024 23:48:50 +0000
Message-Id: <20240924234851.42348-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

I've only compile tested this series; I don't have the software for testing
this so I am hoping some one from Microsoft can review and test this
following the instructions below :)

This change allows users to query the mapping of queues to NAPIs using
the netdev-genl interface.

Once this patch has been applied, this can be tested using the cli included
in the kernel tree like this:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

Substituing the ifindex above for the correct ifindex on your system (which
is, presumably, a hyper-V VM).

A sample of expected output would look like:

[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Which shows a mapping of queue ID (0) to NAPI ID (145) for both RX and TX
queues. Having this mapping is extremely useful for user apps for a variety
of use cases, including epoll-based busy poll which relies on the NAPI ID.

It would be really great to add support for this API to hyper-V so that
applications (including CI and automated testing facilities) could make use
of this API in VMs.

Sorry, I don't know much at all about hyper-V, but please let me know if
there is anything I can do to help.

Thanks,
Joe

Joe Damato (1):
  hv_netvsc: Link queues to NAPIs

 drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.34.1


