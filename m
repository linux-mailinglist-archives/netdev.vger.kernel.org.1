Return-Path: <netdev+bounces-221421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB61B507AE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED63D5E3F09
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172E24C077;
	Tue,  9 Sep 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtKk70sA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737C2459CF;
	Tue,  9 Sep 2025 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452088; cv=none; b=UFFe/HBs8xou+XzqfRylZzqMvDEpWgGINNR/nLNOcrkiuWG2rqblzNCw6wEP4ZfYKatIdzF0bz8mDprjlhRDLMk+o2lMUA+oYpH36it8wHIUIJkCyMWMEsGsk7e/lQT0/Szw5oYhbfDNn6i+1vUkIF+5qH6SNgyf55oEINrRTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452088; c=relaxed/simple;
	bh=XkmTaH9b2eHAHtvq0MgZXPrRQXRZHsv02/DSZMXm6HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XGjMOE62BLqNwDh72E8/yqjEyo3z/OvptBeqXbvpdnYpYumSc+KJ5xiN2IYODovqvRQZbriA24KPafZTreI4VzcB2+4/Mt6R3rHLl9Zm54Tl5vY7QmbEl0Uwzv4EOx7OpJIShgn6MRKe26NDMCO8etjDjI5Nx+ec5QcjYh91L6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtKk70sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF9AC4CEF4;
	Tue,  9 Sep 2025 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452087;
	bh=XkmTaH9b2eHAHtvq0MgZXPrRQXRZHsv02/DSZMXm6HM=;
	h=From:Subject:Date:To:Cc:From;
	b=QtKk70sAfAbHV8xH/rC2JMRynoR7Q8A3FpNX+PUOZLlzAjh+hWbB/SILM4MdDAR3w
	 2zdXU3RRp/6BFSF2SzsdOpLpYSZleA+JPngvcmF2nN4vnJCTQMxzCJbDqz72QtmlrF
	 vt2flPYkMy/3SkjUASOhIRm+VNY7QbNAX0czETinS0Z8q/Y4lZp6xpdnwKQphODdkb
	 QHpgwHaZwQ/v0HV4OnO/p2F8JXcf+RMAwM3pGCTHqpmLAUWNxGHzkynFvrhz54kgLM
	 vXhhYCKczr52kn6zu2YqpEYoSYArmGzEKse3KAYia/cG2vOx0SXavm/1hcDOqFQbdl
	 hWTy5POflGZfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] tools: ynl: fix errors reported by Ruff
Date: Tue, 09 Sep 2025 23:07:46 +0200
Message-Id: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKXwGgC/zWMQQqAIBBFrxKzbkADC7tKtCgdayAstMKI7p4EL
 d7iwfv/hkiBKUJb3BDo5MirzyLLAsw8+ImQbXaoRKWEFho97Zm04+UXDIdzWAtnm1FpaYgg77Z
 AjtP32cGfQ/88L1k+3DNtAAAA
X-Change-ID: 20250909-net-next-ynl-ruff-60fd7b591cee
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XkmTaH9b2eHAHtvq0MgZXPrRQXRZHsv02/DSZMXm6HM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTNetkFZL11C/HD1hZ/L6jJvbzoVPiHhgE/mX8+j+C
 eWzbsnM6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI1gxGhmXndEI02DYJ9E/8
 6Oh1OdbwU43/pLbPjyNmBP2anKSq/ouR4crdS3Wr5ruocyukJj8NK3L8Gssk2KjK9erX27sG5xh
 2MwEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the YNL code to add a new feature, my text editor
automatically executed 'ruff check', and found out at least one
interesting error: one variable was used while not being defined.

I then decided to fix this error, and all the other ones reported by
Ruff. After this series, 'ruff check' reports no more errors with
version 0.12.12.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (8):
      tools: ynl: fix undefined variable name
      tools: ynl: avoid bare except
      tools: ynl: remove assigned but never used variable
      tools: ynl: remove f-string without any placeholders
      tools: ynl: remove unused imports
      tools: ynl: remove unnecessary semicolons
      tools: ynl: use 'cond is None'
      tools: ynl: check for membership with 'not in'

 tools/net/ynl/pyynl/ethtool.py      | 14 ++++++--------
 tools/net/ynl/pyynl/lib/__init__.py |  2 +-
 tools/net/ynl/pyynl/lib/nlspec.py   |  2 +-
 tools/net/ynl/pyynl/lib/ynl.py      |  7 +++----
 tools/net/ynl/pyynl/ynl_gen_c.py    | 31 ++++++++++++++-----------------
 5 files changed, 25 insertions(+), 31 deletions(-)
---
base-commit: 3b4296f5893d3a4e19edfc3800cb79381095e55f
change-id: 20250909-net-next-ynl-ruff-60fd7b591cee

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


