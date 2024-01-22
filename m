Return-Path: <netdev+bounces-64804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6E837254
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A0229308C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF23D3AF;
	Mon, 22 Jan 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjfE5PGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382A3DBA8
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951153; cv=none; b=AGtgdpcruzHb5L6tBNR8ZJpEqoxcgt5Iyz2Vd/iG7Xk66IEBEECW85X1czS3OGHMl6oCyQhL3wOlUsjtiwZ6MMvMDHrIts8mX/N4yRf+YYC/R8CyG90NlZ3lvRAGlFeztZtGggPGOVWOVcVYkXmJLvFYMYK+aDdzJ4vN90FbinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951153; c=relaxed/simple;
	bh=uca6q5Oh3s/CoS8UCW0ogv0w7QVy3wQtaI6yUwDqIoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMNV98uXs1j8Wch7Vks7fk3lNcn5FE6qHBvCc567WUcVnVf/fu4s8uayyr2uhGL26wMOgP+gE2pkKLQz/igayeo+bLp8UPgIPodWigHt6EdH6izRybAyOTV0DzYKhDfdYW3/FpJaqvYNyaK8ig7+Fn++tiAgMwgwjqui/+EjuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjfE5PGo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339231c062bso2356291f8f.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951150; x=1706555950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zZRCetuh/hmwn2DQqJfxSRqzPBAeMxk5hf25iYxxbs=;
        b=LjfE5PGouY8jrmHgEEtYtnyYHtxW8go0xVrD++FO8QMlq4pYkTF+a0pSoL6aXBAqFx
         urQs5Bc8O9ZZEx9c0dXcJJHCdvkgzrdrQPGyWpa6iAZ7ciWgBeoAFZ8mzoKt13MZGmis
         80jZ2p+OAPds7USfYDqgxif7hAAWs6WR/dsbNOo340nYKjwVHYzScwnW40iznqFW1itA
         DBx+R8i3lPZzZT2Uns5D/TwQAbm2/vRaPZpoXVbfmEIaULDBpeekRDttKqeROnAO/a64
         ZyWqYZGUCqL1LMHCBN1ztc34whBMd69dsybxgmJebLfX0zK/08Ggwmtp6KcU5a/JDL0n
         qpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951150; x=1706555950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zZRCetuh/hmwn2DQqJfxSRqzPBAeMxk5hf25iYxxbs=;
        b=KvaW+WwxyxfmLT5bE3w2JKonmAybhX5fu/CJG5X7EpG+ycVNQcWKh7nd/sk90yiyfF
         0Gli5xCc6kwPYlGPApedjrpogQ8iWwfyaxaLuVyAeCxIAjuTu1q1646iGbuv3ihbrs9q
         fFvTKhw01AavrfKYUjdH4Ifte5Nar6R/hBCdZCTK2MYNjmEX0Fjk5xXOWNMDxuHelBSB
         j1WpR5+Py3hzqSvpRaElS/A/edRgf0+t2gRdMFutlfIP7oM+a5OqbknYjJoSg+mwPxx9
         y3haH5NfFAMYDZHk5rAoW9jyxIHLrVe1ncDLHDR4bpsWU5vNEgASoIOCd6VVG7Cqdvae
         YBXQ==
X-Gm-Message-State: AOJu0YyBtv4bvQ1ZFk72fcXSMFMIY4cgdHA31wd4zBOLp/2rzofvCDTc
	CKdqdwZwgo/D0lab06WfaU+sDaYMZHkZRAQqJpt83zB4xj9fRkuz
X-Google-Smtp-Source: AGHT+IHb+XI1Kdwa//c5+T/oUA9B6y56Eyv8pPIMHVTyBDasseDbmsmgxJHeeME/bk7ceAbNtffniA==
X-Received: by 2002:adf:f4d1:0:b0:337:c88d:51b1 with SMTP id h17-20020adff4d1000000b00337c88d51b1mr2279690wrp.96.1705951150225;
        Mon, 22 Jan 2024 11:19:10 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b003392ba296b3sm6211104wry.56.2024.01.22.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:19:09 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 0/3] tools: ynl: Add sub-message and multi-attr encoding support
Date: Mon, 22 Jan 2024 20:19:38 +0100
Message-ID: <cover.1705950652.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the encoding support for sub-message attributes and
multi-attr objects.

Patch 1 corrects a typo and the docstring for SpecSubMessageFormat
Patch 2 adds the multi-attr attribute to the entry object for taprio
Patch 3 updates the _add_attr method to support sub-message encoding

It is now possible to add a taprio qdisc using ynl:
# /tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do newqdisc --create --json '{"family":1, "ifindex":4, "handle":65536, "parent":4294967295, "info":0, "kind":"taprio", "stab":{"base":"000000000000001f00000000000000000000000000000000"}, "options":{"priomap":"03010101010101010101010101010101010001000100020000000000000000000000000000000000000000000000000000000100020003000000000000000000000000000000000000000000000000000000", "sched-clockid":11, "sched-entry-list":[{"entry":{"index":0, "cmd":0, "gate-mask":1, "interval":300000}}, {"entry":{"index":1, "cmd":0, "gate-mask":2, "interval":300000}}, {"entry":{"index":2, "cmd":0, "gate-mask":4, "interval":400000}}], "sched-base-time":1528743495910289987, "flags": 1}}'

Alessandro Marcolini (3):
  tools: ynl: correct typo and docstring
  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
  tools: ynl: add encoding support for 'sub-message' to ynl

 Documentation/netlink/specs/tc.yaml |  3 +-
 tools/net/ynl/lib/nlspec.py         |  7 ++--
 tools/net/ynl/lib/ynl.py            | 54 +++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.43.0


