Return-Path: <netdev+bounces-271131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBpFIqWxwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:45:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6A3184FB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F20E9306715E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADDF406287;
	Tue, 24 Mar 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXwHGGHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776A402456
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366245; cv=none; b=Yabx56uqX2IThj3/+rRtwf+1b3tSmcMJ4SBc7MocQhEJudPr7S8kejNFFBa5Ku2MI89/WUVMnrpZrO85tNzhVmm3cLkI0rC/4NopYAJSAYTzQahjbUZr5iB7MrIvYIs8FlAu+YAEGnZHu9zVQQawPZ4BnceTWzfMfxqT3zeCRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366245; c=relaxed/simple;
	bh=TxJ+oDNySr+IyxdxccVfNUa3nwBwfiPZNX0RSPAlVx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxsnNO24SopPVC0nzor4JXbEP/9sq48Vpx3ZCKS/m4YsafVqamnQRmdmfnKxdT+E1JvysSpf1qKVCzbprOCYE5ai8oYAwX2TUh7jn1oJBfi+cj3V4zpoMayzWrp8xu13TGkfg1siJbuvJ9J5igKzgOADaBM5J6EfsFu8Lj/2gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXwHGGHb; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-127380532eeso2671217c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366242; x=1774971042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bro20BaiUhSDFUr5rtVn5yIB3sY7AcX1uY+fY9VQbQ=;
        b=AXwHGGHb5p/P++m7wjd05fvHRAnRBJpGc9nQXhjzMwS2qoAMVTYepl+SwnkCSSH9XT
         RRDt2xxVvQcBrdQnCJJyIm/dRpLXQhUKjQ5HtCmvAPLy/b5HmivTd4lJrZ7ANlsQCB53
         m8aVzcAOctNezw8Un+A5xRCIabL9HH9qssKRSah24q8BMEmlGJDQQgTV0bV1U3LDN/1G
         5D52d9G4g/GsNu5T64sCxPOsu+8L2TRo19nXDRhhsoobLvd1w7Cu2N9YWzq9aTsnyUlH
         cN5Jvlo1FwLFNT7GMs/fcGv+klY1VZ0p6nZEzAtliz/atoYiVYd/kTn4pkLeaqmQ0hG6
         7S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366242; x=1774971042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bro20BaiUhSDFUr5rtVn5yIB3sY7AcX1uY+fY9VQbQ=;
        b=Eom3jtjrcoNO+Dppo798j9riF4WekxgsF6JxJgV9v07x90eZs7XN1KXpENERLGlMI6
         Sv43zZgZCZcih7EHqhDnHW4iEXqF8HXK4WujpRWJHswrADfl9JS2++AeG2OiAWkPA3WX
         R+82TBYdA8bDh/LztfOjH/Z5K8jpHk9d/qpOyBI99wPNA8nDYfID9YFE8Hmwgb+kxpsA
         kY16VRrw6c4WXbkfLZWvhBUrmJ8JG6ysY6MBvnnMdfU++zq4u75gK4VDWTTwcC6IwpTt
         0/qWlSVvRadjXa50p9g1ngaosXFuSJSU3LOrDVS3YB/DdHLXUED6cNn70xXm/bOdRPCE
         GP6w==
X-Gm-Message-State: AOJu0YysYxbG3xsFQ14BzyJJQ5R/WRf+CE0nDFB/IDiLJLMdkkD9ipu+
	NiBbnp7rbQ0NkN9kipVrIkdh20VH/ygCT9BWT3/n2nb+/nGNqithrK3h
X-Gm-Gg: ATEYQzwjyqzl1BRKjVPFD+1eYp6rvQcdilHz1jU8hjcE2Fa7WI7yM0fUV9YexNUDqn8
	L9o9yS4w+qtKaYMO50rJ8f6y4KXIs5fIINDyAjLn/8arJI54eMop/v5NugYVUvwTCOxEIzukATC
	1VSkgUWg/WxWipsyZ/VpRiRYs/GqDFzhh6YaqgRUFHMgwfoVINSEDS3UWvc+SjDWFjNazn3VGgC
	fHMPLAWRNO/F94mC/aTwiRJUJYi8rUDB+yFU84oXBCKXqY8xnVBu+wpQ3wMprAPiMtazNMm/4GA
	7wVXMZO8F6HzF64lUCcfpPAjFjTFhh7GWif6xUaU49Koz62IzfB5FaMdsp1kAefcEj9jqBYXdjj
	gPR+Ya+aq2pmgS7zgINOHVT9apKisA52QS6aKFiLHFydnqq9bydOEKz3PSFuWpr5sNM1yMRVMt/
	Zk8Em+VSkHjbDG9pHdZEevfyTVRpeEUwdArv+UyDVy4tO2ewkn7F+0njRzpGHO5mlgFchW7A==
X-Received: by 2002:a05:7022:6728:b0:123:34e8:aec2 with SMTP id a92af1059eb24-12a726570a2mr7392229c88.1.1774366242086;
        Tue, 24 Mar 2026 08:30:42 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:41 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 0/2] net: replace deprecated simple_strto* parsers
Date: Tue, 24 Mar 2026 23:30:34 +0800
Message-ID: <20260324153036.86901-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=ericterminal@gmail.com; h=from:subject; bh=zssS49qkfo1363PBqfzh1+o0wqR3w3I90sqNuTWA/YU=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqt1U3fWI3nWM4keKiwnX1zjcNFncLoTmswjNZfl6 MwlHotWdkxkYRDjYrAUU2S5+3/f3FyvW3Oucx/OhZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31 DI10DHSMGbg4BWCqDXkZGS6fq+ysZvv9Nn0VZ4Gu1JSfoWwyH1iWO3Pv2tjI77k18TUjwyTxPLZ zRfXLtgq9m77WxbxqkuLXaGZZ/nUVU76K6SdVswMA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-271131-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1B6A3184FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufan Chen <ericterminal@gmail.com>

Hi,

This series replaces deprecated simple_strto* parsers in two net paths
with kstrto* helpers and tightens parse semantics.

The series has been split from a previous mixed 9p/net series to ease
review and align with subsystem boundaries.

Patch 1 switches bridge brport_store() to kstrtoul() to ensure strict
input validation before taking locks.

Patch 2 updates sunrpc proc_dodebug() to use kstrtouint() for full-token
conversion, improving error reporting consistency in sysctl paths.

Testing:
- Verified migration to kstrto* ensures that sysfs/procfs interfaces now
  properly validate the entire input string, rejecting malformed input.

v3:
- Split into a dedicated net series for bridge and sunrpc.
- No functional changes since v2.

Yufan Chen (2):
  net: bridge: replace deprecated simple_strtoul with kstrtoul
  net: sunrpc: replace deprecated simple_strtol with kstrtouint

 net/bridge/br_sysfs_if.c |  5 +++--
 net/sunrpc/sysctl.c      | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.47.3

