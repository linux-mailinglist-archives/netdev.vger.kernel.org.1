Return-Path: <netdev+bounces-259001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNVhEPtJlGn0BwIAu9opvQ
	(envelope-from <netdev+bounces-259001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3C14B123
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BDFB3021D23
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F532BF25;
	Tue, 17 Feb 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV0W5xo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018463271FD
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325943; cv=none; b=I7WiYdS53+mwBqoGfv5GGvqSi69WULLfwgQY6l8E8k9dh271scO2RQO+F7HyFTxxO326NcGKdrA5oM/NeM/SOz3p8ik/QAloUP+yB8qkDagLIcziDaGznQVoBr6WRjnCyBZU0G++BUcB8fY5CznI2wdoR4hz+3pKAHG7u8H8WjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325943; c=relaxed/simple;
	bh=dxkUEdW59WpbrdfCocb7yEpG8N+Jc3txoaD3rPLr/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a19OjO+lSo8e0Sesjpk5jHhYRax1oQFiq36mQmg0/dXFyetY8hiz+QNDAgYkTmvgI1gDOWDDYdL/UIyM8hARsNBZo/JvPwinUA4oVqAJb1sA2OcU73igFkWE0VQToWj2B+wgGP8A07CGGugLyUbConX7hmnRYziFvxnBuodJAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV0W5xo5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso34971215e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771325940; x=1771930740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqd/qSNd5cJh+qVEsxJycYcGDG/6Gev0XJ7NgtBdi6w=;
        b=jV0W5xo5TUjK0Tpfg3f6zkPpqAVfKjj4DwXEaw0xWZGZbjLbkmZcI8RGl7PJPwAZh8
         6T/4JEOUoNUkaiVEFFW+78daVT20yJFwnBMdDOrbPGKPH/NBngHoVY+66phvQ4Yq7eFh
         lasXHJYVssAtCEzB3ujqGQkMMFwABrg7PuToSELxE1MlZg2qrGj+ASgUyXk99Gmq1ano
         p3QkB60yXAMvRiKn3itpjXYPs45Hzk4z6Bekfs+OR5qOlKvwjTt5d12XvJ+0xiEZvj5W
         MNWtjSBFelLl76gVB+VooDlPwfvUm3H5ig44QgUu3/9x+zTAHYfUjJ6hnPISpGZ2Icnv
         ZnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771325940; x=1771930740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqd/qSNd5cJh+qVEsxJycYcGDG/6Gev0XJ7NgtBdi6w=;
        b=NrS284iphUEx1PUSz5gPEVrnQgbLeugAIQNoKJEWMHynbeA1LDOsCvweij3WLaKCTS
         4x6FLcnPNcPsHabtU3IK9m3HNPMSMTCk2BBZmG6m97Pm6YngfabPXa2w/r4P0fOmogpH
         YGi+Je+V7W8E48JPfukXQHpAJ4yt7lpscSlljb4nVl4ANPbHG2RE1iEp2y5VKJMnWJHB
         i9AkGqRO6U+QdWM+NlRqYKzL0awBhyRPaTcWCrV2DwPDvp9GtmAp+dVSsz1C1LPLifQn
         inaww1mkJV6e9PCfAM1ZAnry2u8yVdwbTIn2L3eCYxL7vnwiU/h0hgYlHQoX+joUkWJ3
         cIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPnmqrqy67nXiNFqsZJfqdKsBedbHruZUHSP93ie9JW/FEwyCwxMf1jeugWB6188JgvMAjoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg4Aqq6xE4APEhB7tqodnkQHtYXCcYuHiBRGkpc3ry3B37hR0
	1v3C7Nb87s++JQ0eS1YVoulnk6P3e5tSACN8ME0Vut4r6Q7Yq3ZnIa0f
X-Gm-Gg: AZuq6aK1Bb2vnZ6OomHQ/XuTNfWkkb9z3S+VyojkAyl1f+LkdfyM5+fp5fauIPA/nAD
	KwYgirNeLeYGNVNWT4RRBXKV2atJnq1vvybzDWi+xttGWLneqfWBM3H45Ftz+8Xex7l5ZIBG44U
	Kncs/a4x4nrnaiHRMdgMglG6PsqKYbJrGdU68MQ5gVk4Xc7Jp8WYrK4r195JGv7mm94o1yP7e72
	T+J164P1ZZv3VfJ1nr8YTIj37hO3NU+Fv//jhL21qlyvDyBYGbFTifNTDhIGUBuekfsQVsMgFNO
	0n76e7EBQ5Si9Z3Qst2O1Gku6UGVjGbW5f4D81T6tdEbvFLKl3z04+4lRtDZK4LbkkbvnK96L9y
	vYygppKeuJW7rSxfZfj90hpgmHcZh52widPF9lYoLWRIXUOJ8QZE7IXPHi+o+KRkw4v/SZ4jR6F
	yJ0nKh+nLkjdLcypxTKSAEU6yfNWR/N43tnfV7BKECfU7vDwvHbrKS4zQOkg1dFQvaoPprpsgWI
	gBvK/f4XYzmrqACqkJaq0vC0xBdsf7OWjj+k+15
X-Received: by 2002:a05:600c:609a:b0:483:7020:864 with SMTP id 5b1f17b1804b1-48379c178eamr193526775e9.25.1771325940268;
        Tue, 17 Feb 2026 02:59:00 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a78c89sm327759395e9.5.2026.02.17.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:58:59 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [RFC io_uring review-only 0/4] zcrx mapping cleanups and device-less instances
Date: Tue, 17 Feb 2026 10:58:51 +0000
Message-ID: <cover.1771325198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259001-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B0F3C14B123
X-Rspamd-Action: no action

First two patches move user memory DMA map creation to an earlier point,
which makes it more uniform among different memory types and easier to
manage. Patches 3 and 4 introduce device-less zcrx instances
for testing purposes, which always copy data via the fallback path.

note, based on two other recently sent patches splitting out a uapi
file and defining constants in zcrx.h

Pavel Begunkov (4):
  io_uring/zcrx: fully clean area on error in io_import_umem()
  io_uring/zcrx: always dma map in advance
  io_uring/zcrx: extract netdev+area init into a helper
  io_uring/zcrx: implement device-less mode for zcrx

 include/uapi/linux/io_uring/zcrx.h |   9 +-
 io_uring/zcrx.c                    | 145 ++++++++++++++++-------------
 io_uring/zcrx.h                    |   2 +-
 3 files changed, 90 insertions(+), 66 deletions(-)

-- 
2.52.0


