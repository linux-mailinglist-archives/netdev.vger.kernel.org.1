Return-Path: <netdev+bounces-65518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5F83AE65
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034681C2293E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BEC2CF;
	Wed, 24 Jan 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuumG0q/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44834695
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114042; cv=none; b=CxowrV0kZS/BejzAJvp4YATMwU29SmfNmhBLQNKBwxTG3S9JQH2m2/UOhKuTtdk9NfkO1En6FI4FtHkSME8WkZqQwuWJ8PMR9Mp9/GDx2UD/pFw848jKq2aNUAhK4TbfH3GOKV5DvOVxUzAth5fjhu5JyBGXcMpVvUCyghSk7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114042; c=relaxed/simple;
	bh=OYr/cGhr3UCVFwvmoO8xL78ATC94bSIEmclozwjQKpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uefzp1xSGiqHbucWm0nOeFBL+cL2/8dZeZy0gvpZitqvr5slPMeXvJ8gW1VDNcrORMZ4+SuuurFMBlCkMY8SdpWRC9hfVAHaM/g5N28CDY8X+mrqJ8UkBZArjQV981UJdSrP7e2Oz0/E/3zZDJY9hJiKYBNH9Bseu3xklPUTtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuumG0q/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337d58942c9so5903756f8f.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114039; x=1706718839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhGTESZaEC2efoS8P3uH6TXXPeV1L6oAZ2yvW3NUgbI=;
        b=YuumG0q/Gw6V6/u81bkXsjPWGNM3VwjnOzHkPwWfTmw5fAyqTtj6nfZijeEpSqCHNk
         ySc0Jr7uvGVijXQEud65HQgqCJiwGViljLDrMDCRNxa3RXHjY8Z+KZm07RZxjIekSRQ2
         vNFIG3LQJcnm/3kuG4g+XtmWYfsAcISpnEjxWXoyOcIhIgtLEs1UeKHbSw/i+F9yych2
         Nzusa9+dRBLTDCgTT+OPNBV0sQXPbY4UJxTgkuCpB5uAP+DTre7hOY4Pd/MjGTLsDibr
         boLXeyI7wLNilKGbHGbQmZiUBXL/MSLeKMNSPHDGyS2jjfBy1UgVMN62w3aVYyb435kh
         4bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114039; x=1706718839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhGTESZaEC2efoS8P3uH6TXXPeV1L6oAZ2yvW3NUgbI=;
        b=Y16CdAxbO0tdzhfsUiRJm48Kky/eG/Y3k+03uy32inqm+cfeJrRzk7TYH75sxjxoaY
         1dAxJfpsf4TS0iWUeWwKSkejn+HF5SoOdiEGCwFYSUn9BS4n/KpUseIv1RMdovHK22gj
         miWr8bowIpVk7pvPy0vw1uuzfLk8Bct0ubRnyo9vny9S1S4+Km6Ah4cH/YeZQvs4bfuv
         KdCuuJqct9datRt4zs7yJ/cK1et0Nvm1tMlt6p1KjOi5oc+8e8BRJ8MlOqE43SdYUoGI
         Spa4NEpdB3QNIpMjYaFmea9eQI9j3lclO+6pBANiJ5k+dezydVqTrURyJ0H4YQRhOE0M
         Fqag==
X-Gm-Message-State: AOJu0YxjDNx/YM7SVrQWPW0gy9+wNT46ISHra+EVzughCwXF55hAaz49
	TLKVKuzu7jNc4ASKg/snxCebOX17Rd4VragJpH2f6iFr9IB7d32n
X-Google-Smtp-Source: AGHT+IGxiPEJ6CoiaTvxFlyVTSS0tkeigEsTxnPX2BuJ7QYYP2Z1wUV+IHf1/EhmpFfCxUiyfX+u5Q==
X-Received: by 2002:a5d:42c4:0:b0:333:f04:f2d7 with SMTP id t4-20020a5d42c4000000b003330f04f2d7mr710600wrr.55.1706114038816;
        Wed, 24 Jan 2024 08:33:58 -0800 (PST)
Received: from fw.. (93-43-161-139.ip92.fastwebnet.it. [93.43.161.139])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b00337aed83aaasm19082866wrw.92.2024.01.24.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:33:58 -0800 (PST)
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
Subject: [PATCH net-next 0/3] Add support for encoding multi-attr to ynl
Date: Wed, 24 Jan 2024 17:34:35 +0100
Message-ID: <cover.1706112189.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset add the support for encoding multi-attr attributes, making
it possible to use ynl with qdisc which have this kind of attributes
(e.g: taprio, ets).

Example:
The equivalent to:
# tc qdisc add dev eni1np1 root handle:1 ets bands 8 priomap 7 6 5 4 3 2 1 0

would be in ynl:
# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do
newqdisc --create --json '{"family":1, "ifindex":4, "handle":65536, 
"parent":4294967295, "kind":"ets", "options":{"nbands":8, "priomap":
[{"priomap-band":7}, {"priomap-band":6}, {"priomap-band":5},
{"priomap-band":4}, {"priomap-band":3}, {"priomap-band":2},
{"priomap-band":1}, {"priomap-band":0}]}}'

This patchset depends on the work done by Donald Hunter:
https://lore.kernel.org/netdev/20240123160538.172-1-donald.hunter@gmail.com/T/#t

It is a modified version of a previous patch I've submitted, where I
removed the part already addressed by Donald and modified the rest
accordingly. Previous patch:
https://lore.kernel.org/netdev/cover.1705950652.git.alessandromarcolini99@gmail.com/T/#t

Patch 1 corrects two docstrings in nlspec.py
Patch 2 adds the multi-attr attribute to taprio entry
Patch 3 adds the support for encoding multi-attr

Alessandro Marcolini (3):
  tools: ynl: correct typo and docstring
  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
  tools: ynl: add support for encoding multi-attr

 Documentation/netlink/specs/tc.yaml |  1 +
 tools/net/ynl/lib/nlspec.py         |  9 ++++-----
 tools/net/ynl/lib/ynl.py            | 16 ++++++++++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.43.0


