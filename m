Return-Path: <netdev+bounces-241016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B92C7DA48
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D654E0408
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6F14AD20;
	Sun, 23 Nov 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Od0if0Sg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7A132117
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859073; cv=none; b=m48U+Z8zMWbwFU8Q4sPfrv048/T5JFffMxVFXv9cjIPgH4EywGufiM0wwX9CYA2ub3mDl3gRQli9oJuUfseE1r9S6oxEzemOKw9QOKx7yVSUdKu83m7Ss2h011KQ0O/UHc0iHZDWZxZZuKWaiLsDJQzAjImOzrlYJa+4abZQ8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859073; c=relaxed/simple;
	bh=zKcgxsAl4Xwle0rcTS0nyKIUL1CgeylOJPD/p6xGbug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGSzcenIdKC42+qWOBb1YaxnNv+RIZJuTOmKlBH5GZ+BF1l4spvNFFz1Nipn40kBvgDaXfP89QoJc2HQxR3r72z73I1SfOdiuIJDFfnBtyVoiq4f0ZTUUHWSba+vlwveckH+nfHUNTiU9e89/lC8cg3bA6qM33gpeqyQkbRxBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Od0if0Sg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c7545310b8so1533960a34.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859070; x=1764463870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4NLLmI91q2cEC2JO9nQ+1yyXiaCpBryxRcW6rorq+w=;
        b=Od0if0SgSZAO+34PF395aKKHeADSdMLGHmDU2hFffQwVEj8cqTjJPfgpIAfqYzXhIE
         CEnHH+EiNXQLz0UYe9kb6P3fim3cg+hHv3k6w9fnKNI12AQfUVub2a0Edvti5MiZlTPY
         OcVZc+Anf4gADMhG7MDFPgtqiaHjAkOWgZqhiKw406/yKf77hs57VqK84VBW7/4nlqPK
         QIEpgLG0CATaoR1pX2ov+yeBOB8YLM8owcds1C9Q1/rLwZzOSiBI7owtDUL+/EIf8bQ1
         gwlelvlCj/KOxHXiYWKGxizgJSprimzrD7NIkz3NzMwjP88ulBjR7tKJNqzs+6SmeQ3M
         Ivnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859070; x=1764463870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4NLLmI91q2cEC2JO9nQ+1yyXiaCpBryxRcW6rorq+w=;
        b=SDx23gVPqFgSt9EyzYtOrx/OV1nwoJxQOUEp3nCbakvEW0YlIQ+4bCGMg0/qngy2Z7
         V1cVGqdPuS82Py0PslOMI7v8cAFDRQ+l8mKVbjt/05S79sVFVJi5E+YO0oJ7JxMeAwa4
         VsIWUVUOY1BNx0DyHU6MSePODLkupJX9mlrEfMuH5oWSNq8N3FU9Pxie+pM55Z6Scr/v
         xqzKPX/LFG5Rx5IiSfkCaX9BMtUyEjAbLoYro3nNkpU8fJPT/Q5YHi5Fvnqc6pje1oDW
         aJayCWYtw1ukcrNkJ2PA9TuF85sQNFloPjZbrYvAp3UrLninoBA25rTDFdVgDIEzabxe
         3DBQ==
X-Gm-Message-State: AOJu0Yxij2Go0+/b9plM9eAAPB5wuuxv3a+XcSoXq4m4rJ+UqVrdhPse
	/+YKswPwwwK4N3XnA3bod2+iJFa3hIwzAUIRcDuVnZz4n3/+/TGozZestWVwmpVTKi5ol9KFeuV
	5JofM
X-Gm-Gg: ASbGncsQKEQYFDVggE7jN3WmVtSR5iBnI4mzqe596JBkmaN2ATl8p+Up+YVLDDJHyYe
	0GQ41jMfGEBBocK2KzwlZRQ5uEueT/KJOpj/tWL6j3O54VQhMaF5qCU5175GXrgLY8B45e90/2L
	VfnJoIbk5HNsDOd6GrnBieyzRe3xxghGSj68InRwvpEMwnfv5wP6Wy0UJfTVYAhgp1GToWEPbve
	QJj+fmwctfC6TXpIMW1K8vwfWrGNyY6wOODD4iHc3k4m2bJf4JMsSGvyxcp0wA9ooghlprtyRix
	MTXUI2iZtTzzeINloL8MEhUUMUnLjKmSpOvcvFtm66+6mcEXo53YtYezc/cgH9x/vRA6O4ytyIU
	b4pd68yk9cAxT1Qvr4DXwxYRKgEHXJa4eq2JX1Xv+rmfItqCoL5Hki2SfGW0DtqpCZvG/81NbzN
	BBcWTItwsdRUI8bObhIEguQPoY2B0TCe+D5nZL2e/DGYP6+furbIY=
X-Google-Smtp-Source: AGHT+IEMttVa90sqFaSWZRtNFbvocIq+VdIqZyBlLRuZZJL54tgLNMo/yNYFPygqaxQIBYN0SHLKfA==
X-Received: by 2002:a05:6830:4409:b0:7c7:59ed:ca0d with SMTP id 46e09a7af769-7c798cfc904mr3118237a34.36.1763859070507;
        Sat, 22 Nov 2025 16:51:10 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d4021afsm3818612a34.25.2025.11.22.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:09 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 0/5] selftests/net: add container ping test
Date: Sat, 22 Nov 2025 16:51:03 -0800
Message-ID: <20251123005108.3694230-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is mostly prep work for adding a data path test for netkit
bind queue API used by iou zcrx and AF_XDP.

Use ksft_variants in iou-zcrx.py to run the same test cases with both
single queue or RSS. With changes in v2 this is a bit of an unrelated
drive by change but I'll keep it in this series.

Add a new test env NetDrvContEnv that sets up a container based test
with a netkit pair. This only works with netkit for now, but can be
extended to support e.g. veth.

The netdev core cannot forward net_iovs, and so to get skbs containing
net_iovs into a container, add a basic bpf tc/ingress prog to forward
skbs into a netkit pair.

For a remote to talk to the netns netkit, it needs a publicly routable
IP. Add a new env var LOCAL_PREFIX_V{4,6} that defines such a prefix.

Finally, add a basic ping test that brings everything together.

v2:
 - remove ksft_run suffix, MemPrvEnv, rand_ifname, bpf C loader
 - implement NetDrvContEnv
 - redo nk_netns.py ping test
 - fix docs

David Wei (5):
  selftests/net: parametrise iou-zcrx.py with ksft_variants
  selftests/net: add bpf skb forwarding program
  selftests/net: add LOCAL_PREFIX_V{4,6} env to HW selftests
  selftests/net: add env for container based tests
  selftests/net: add a netkit netns ping test

 .../testing/selftests/drivers/net/README.rst  |   7 +
 .../selftests/drivers/net/hw/.gitignore       |   2 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/iou-zcrx.py      | 162 ++++++++----------
 .../drivers/net/hw/lib/py/__init__.py         |   5 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 ++++++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 +++
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/drivers/net/lib/py/env.py       | 106 +++++++++++-
 9 files changed, 266 insertions(+), 94 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

-- 
2.47.3


