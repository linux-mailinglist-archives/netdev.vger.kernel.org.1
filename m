Return-Path: <netdev+bounces-283970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLOLOjfa+GnG2QIAu9opvQ
	(envelope-from <netdev+bounces-283970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C674C2012
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60E430104B5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004583E3DB3;
	Mon,  4 May 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In0E+sY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48093E3D89
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916466; cv=none; b=hwxrf/VNlPRH/1vOO3A59osb00AbYiSgHCBCtAg2k51v0zhI4Y3DSf/8RfnuPK3+p28CiYRxpL0dbGwwuxcQa0l05/d/kgJa4DY9FAE0r2dmK5087vbOggDtIWy/+y7l3+O5PPsf7KhZXFVI9xksbEuB78HkSAd9EEiq2FfMIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916466; c=relaxed/simple;
	bh=1UsReSX+8wdCLHB7KFJQ+E5VgWUto9I66Wc7oO8lIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoy8CR9ar0NMDYcOOzLYTf0L3Gsd4Di4qnOXMrA1dEIIThCbgbVndGTP7J99xWSJy9Vncnn6WZ4AlTvsulMvUjsJDvnbZtJTzSFe92bjpJbZt4asIo9gIYobxY26NErqibQ1HuEPHnPnQShpJHbjhL6/gdBaG4Nc5mrc0ydzp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In0E+sY4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79495b1aaa7so46240477b3.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916465; x=1778521265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVXd468iEVfxLrg6jVOPb84V8zxADSA4fIpheWYNkXw=;
        b=In0E+sY40WjXr38vjuFwqy9YAP9Uo5UgBmqy3Qprdg5mlu2uyL3cy122gNEsaFn7dW
         hemO1tPw3qQKb/8uImOiRWerTgkuXuMxY9hC5ksTd15rzo7mvVVgKwbO2iwXgj1M0DRS
         tOz/dABDMi9XANL5ylOcZmTqAdGzRyX9eFFhieD8mhKYmdv0C4XnPJaRSdopimwHWP1C
         wtpswnK194r2H0ywyWanBu80k9l9BwvH1QkO3dB1rQkAg+Li1zNA81PQdrLFspAbftCt
         mUPWMh2QQPtS8e+PX8vL+Y99AaJllfysXy505pavZqqNorromYownMlnhXrwWxZi4Mtm
         pZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916465; x=1778521265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVXd468iEVfxLrg6jVOPb84V8zxADSA4fIpheWYNkXw=;
        b=NMq8rXOdMQvSJcY42UBswvEfdDYIDJbQPmCQYY3i6oJpE4z+sDFSKP2MIfR5A9bVoT
         JDGaTmGpywwkZCv64vzswIc6RaINFUG4dkXkuU936sXnorQ84oIEsY4hm8sZO1cDcQi/
         WR5x9gpEgzZqwTZAQqm/n7cIVkd3x2mTWhjMK/Md9522SioAh4dEGNpPZXIP8mUwyu3M
         P15tIIMzEGr9LVsF5djV1rUAP6dKarOYUH5mL/ilwbp4ZDD19FQGu8dsXTboe+JEloPY
         Hsit09RAMfl0uu0FqV5vuV1K+ewHbnTPqj0hTna88iYnKAC8ZY6+nklhk2q4FAvd9v11
         j7gw==
X-Gm-Message-State: AOJu0YzI1IcTPTlE8T7RUFah474GfLKmAc5dT27/nF7JLh9yIFdPN3zH
	2Mp5LNy4ww5Vpm6w+rPr5HT8U4obMS9bPUMBBrkuRbRrd/KX/DuN4WgQbT249Q==
X-Gm-Gg: AeBDietHd1kPwioZlhuVn4V8L/idNk9dIS1Wt5vgy4MBMaMhhwz60DMgij6ZIxmBDfh
	/EViOYsDShORzoVaZxk7yk4qrUJiLsaJwsbWaffgmuG74/QyX4QHxNIhMFbZx4em+YbTEgUzfq6
	D3ywzHAXaCMPuRIroQ6D4l8REZHE75y7xXGjukWI0wOlXdQDEpVzu4CSqOA4KvVZIFYkoRoQohg
	QeNjoy+b/ncm6bobQK2lzKtoRB13/ZqHgGqW8qtzOdcnB4uDU1pMfSzdqv4D6CeWuciso4H6Jfq
	4mJlDRDqVoJenDwXCesj5TgYXGToVZiDIp6iAxCON8J6MxYJYqFOv6OdlMlM7O3i1BgZmxRpzxV
	Tux/3pqp78LAPRofs0Y4dvkaZowYDG+Cgvt2yMNpoTeyXPezct4YxoIxMXoNlP6xT0hGOCkEC5X
	rC6ry3qCsdZmeWzQhvY7QcLMANYvZOXINb6tUKFvdqwcNVEPpjHzaZduEAVMzlFW9UeCngqPoV9
	h2ARpQtaPwD2hcEnR1B4beg5dDo3FUGOGjf2g==
X-Received: by 2002:a05:690c:c0b:b0:7b4:b591:e77e with SMTP id 00721157ae682-7bd76fdb62bmr112277547b3.18.1777916464547;
        Mon, 04 May 2026 10:41:04 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d0cbsm51551767b3.35.2026.05.04.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:41:02 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 0/3] selftests: drv-net: convert so_txtime to drv-net
Date: Mon,  4 May 2026 13:38:31 -0400
Message-ID: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59C674C2012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283970-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Two preparatory patches
1. support negative tests, where tests are expected to fail
2. add a tc helper 

See individual patches for details and detailed changelog

Previous versions:

v6: https://lore.kernel.org/netdev/20260430132820.1944517-1-willemdebruijn.kernel@gmail.com/
v5: https://lore.kernel.org/netdev/20260427201640.294694-1-willemdebruijn.kernel@gmail.com/
v4: https://lore.kernel.org/netdev/20260409164238.661091-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260406025020.1636895-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260405014458.1038165-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260403175047.152646-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (3):
  selftests: net: py: support cmd verifying expected failure
  selftests: net: py: add tc utility
  selftests: drv-net: convert so_txtime to drv-net

 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   2 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/{ => drivers}/net/so_txtime.c   |  25 +++-
 .../selftests/drivers/net/so_txtime.py        |  96 +++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/utils.py   |  51 ++++++--
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 11 files changed, 166 insertions(+), 133 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (96%)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

-- 
2.54.0.545.g6539524ca2-goog


