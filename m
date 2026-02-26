Return-Path: <netdev+bounces-261261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JQmFVYToGlAfgQAu9opvQ
	(envelope-from <netdev+bounces-261261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:33:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A44761A36F2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7216130591A7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426338F24D;
	Thu, 26 Feb 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKTyEoEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6D2BCF6C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098148; cv=none; b=U781kFVW31YgpEYileE+bihhRz7JL/Wp6VX19tBXDuXu7J1qcHYlXoW0K39BMlDLJDZlDmmte7TvBZWxGW1hxZX435KALCySVwccdbska4IoyUA9yyV+OGShoyCE4QCr9ZCqkpvWJhQ5pOttQTir+JKya71TSRwNni1d07b6JqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098148; c=relaxed/simple;
	bh=ENTh4RvR0eLqOOtGb91BzvRv+gAkjcfvvHqvgxmwo5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uofOSCqrDU9kdu9JWSGzUqCDE/XO25Qz9qh5RlN24LmRGlfkYyP4ObcyCoPmn6EdsOOYIAp08HLis0xp70NbALr0zkweLSbonX5tkuCm9IG3m7QYMNsqk7ZJoBkDHQXkx7y+Sk2zMoHS7eQLG7AQieb5pyiXpw6DsfVfc1SrR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKTyEoEB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso4422935ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098146; x=1772702946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=630alYilvL+Kbs8vmDeduhC8DqBIYwx945pb6cmKSAs=;
        b=FKTyEoEB5DXKR+50upLNLfW3Bo0mQpax2RUjqMEKQAk+kz39i/PoEvqROrAintCtKg
         b1o4tVeMEOHIA8Epz3SNPf3ttmGpentWSqevGyRXSOhl+Y+2Z609ZXJyf08OMWGW4KWm
         ljRokKDfii+/Kd5m7gHOqI35mNpclvBSeutzG4MtMpz+tEFee5zWPbwv071crrl0IOIR
         RLey5WiGf5pkgk5VNKNxEA0m8bwK+bd5zwRlvVbAZQowMV272Z3CWHj6VahYVsxM2GfA
         EeUHPyvnh3oLjw2yJOhDdCvYzBcmrFsID3erCkTIeKw8W4zxxxwnre/oGdtQzu1GMHZP
         rkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098146; x=1772702946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=630alYilvL+Kbs8vmDeduhC8DqBIYwx945pb6cmKSAs=;
        b=stx64v/kIUWSTJstOQDL7XK+KWmz6vOgsckpNUBmFpeGGnhZ9qI4g+sYEPVUHRzYCB
         KBzChWsmMmbNupJgjxQisjAWuOOBXmiu9k41HzPpjfqZfcfyAiV9nvLudod1manc1eCE
         GI6Tjxky+8QGyoFneGwpMXFSivyId8vfQSo7R1AMMqqONwgCjc3yyRkOrN0deIzoKMQ7
         lfxx98dZBn7jvN6scwQM4kILazbMEjX3SbzR38BPdEdaCJGi2bDGRPNvzjQbKDB2OELM
         LzNy+LSggM4Nz/RCE11DrHxN9QU+RyAhOtWUvswr0AmDh7z2NkxXT3+dNXI4bWdo9sZD
         huRw==
X-Gm-Message-State: AOJu0YyE9zIaHoTq9k7SxwD7bhUgoTVZq4KgmIGjNLtV4XrPuvmwbbdr
	qDItePU1F6LauXrYZdxJEiBpSd7vfzcKL8a/pNYtKMUIRiirio8KJqZnd/oiqQ==
X-Gm-Gg: ATEYQzxagswi0/SUexXR849kY5OOM0LU/Pqc6ijDs0U6FP+3ygu1/vtA37B9/FNehC2
	YSG0i3bmXJgPOTtAzoKIbN5IvLuVBSk671nPvO24LnZP2v1WgEwkyPJat/n4RNjo+WuqbJuvlb8
	qwolDTzsfg4foJTjGuuGpbQgL9ByN9o/cCsSSCqmhM0rspI+ytABwqSN+8iNG/uZQiUksigb6QZ
	h0r6oiZWLG12pkA8bxhnfDwdcNI7ar2p57xdWOWFtHcKlRWEJwg8NbnOjLAaCdNhHuElcwD3S+L
	SQ2An932uO3QC+x5Hpvm11rpomqYQGO6FTiri2XECVgBeyl595Crde3yt3MnKDyDqbbaryfN40Y
	XMhuJNgOCXjdMax2rJpuzkNAnbo4jZwbqjF9BcryjesHHjfMb9sffFOhjdSjd4ZpSB2plm6co+Y
	uigTgB/sqKmua5NWLKV76GF5lcKKhAZm0XGIt0H3PLK43IAqH5jJE=
X-Received: by 2002:a17:903:3c25:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2adf7913771mr27990705ad.15.1772098146417;
        Thu, 26 Feb 2026 01:29:06 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:68f:cc94:9882:f73d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6cab92sm18846935ad.73.2026.02.26.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:29:06 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Cc: jserv@ccns.ncku.edu.tw,
	charlie910417@gmail.com,
	yphbchou0911@gmail.com
Subject: [PATCH 0/1] net/mlx5/core: Fix stack frame size warnings
Date: Thu, 26 Feb 2026 17:28:54 +0800
Message-ID: <20260226092857.1583984-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261261-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A44761A36F2
X-Rspamd-Action: no action

Hi,

This patch resolves stack frame size warnings in the mlx5 driver by
dynamically allocating 'struct ttc_params'. The structure exceeds the 
1024-byte limit, which risks causing stack overflows in deep execution paths.

While compiling the kernel, I encountered the following warnings:

drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c: In function ‘mlx5_lag_create_inner_ttc_table’:
drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c:543:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  543 | }
      | ^
drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c: In function ‘mlx5_lag_create_ttc_table’:
drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c:527:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  527 | }
      | ^
drivers/net/ethernet/mellanox/mlx5/core/en_rep.c: In function ‘mlx5e_create_rep_ttc_table’:
drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:991:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  991 | }
      | ^
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c: In function ‘mlx5e_hairpin_rss_init’:
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:890:1: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  890 | }
      | ^

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (1):
  net/mlx5/core: Allocate ttc_params on heap

 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 15 ++++++++++---
 .../mellanox/mlx5/core/lag/port_sel.c         | 22 ++++++++++++++-----
 3 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.48.1


