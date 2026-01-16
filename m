Return-Path: <netdev+bounces-250506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC4D3069C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A864830E90CB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B017136D51D;
	Fri, 16 Jan 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="mRC/fr86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch [109.224.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAA36D518
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562768; cv=none; b=e17Cj+5ZHDcPtoVuX/bx95JF0CJnLyyMYiyWzzUDnvXRH7q98DNZ6A/GkSbnQMeX5h7HhkhAzUNryvSd5C70rqVLQ3nnJhDuKjBp7nYImbr5eCaootwS/OYXQSFJJHCdq+4ZUJj5BANxHcXeV01WnD/FuieTz1YEr3kDmkC3mOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562768; c=relaxed/simple;
	bh=+BuFRn1o+6Z2kA4ECKTBrGzgeKoY7/S5rkxof3Fs3N8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k8s08hC9AmNu6JJoZNyEKeiLCp2SRxjJoGeQ1NH5GhVf8NmUS1OvfXVuEcJmKWuVvgQWDemVYG09liKzBYiHDSrp5oQ11TLomNlwzQRrjQQoHgZrQvNXKVRVTySC7v2KR+IE1eHahq0RMmXT8mJ5jARkMCU37GaF3EvVfulNdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=mRC/fr86; arc=none smtp.client-ip=109.224.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768562756; x=1768821956;
	bh=I0nbR5sdjk9Yq/qwK+BllzmEe4LWeuPm9GH/5A6mm84=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mRC/fr86hLfEMFxEu8rkeVk2PMsTBj0scOkugcRA1T7m9+Vm+7PChVnA/PY/26Z4P
	 IakSmlamIrq8LrXyTeSjsu2qctKPhqMwrGGwoPxYRry4KZon1ksD7NXDBk5JKT90Mz
	 tXQgZbDeZ7QBU61hcnATab6lOzqBJAr0D/WaICbNjR46gFbWvTRDCfN845oI0sJ6sf
	 Bfp0/r5AlKgt6qNkSsmRnIucx1K2VFzy1B0W/6/b5pKeRT5PZP4gDbE+km3VjCPhkn
	 XuvA1i2oxEsnDafVGoTdzoUEPCs7k2zEBWTSghqaGsq0ueru55TfYUnZvcSIh312kY
	 3VVqhrBBMrYIQ==
Date: Fri, 16 Jan 2026 11:25:50 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Paul Moses <p@1g4.org>
Subject: [PATCH net v1 0/3] act_gate fixes and gate selftest update
Message-ID: <20260116112522.159480-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 405eead8ebfc9d4e60a00ee97f4a6cf76649c9d2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes act_gate schedule update races by switching to an RCU
prepare-then-swap update pattern and ensures netlink dump structs are
zeroed to avoid leaking padding to userspace. It also updates the
tc-testing gate replace test to include the mandatory schedule entries
so the test suite reflects the action's strict semantics.

Paul Moses (3):
  selftests: tc-testing: fix gate replace schedule
  net/sched: act_gate: fix schedule updates with RCU swap
  net/sched: act_gate: zero-initialize netlink dump struct

 include/net/tc_act/tc_gate.h                  |  43 ++-
 net/sched/act_gate.c                          | 287 +++++++++++++-----
 .../tc-testing/tc-tests/actions/gate.json     |   2 +-
 3 files changed, 254 insertions(+), 78 deletions(-)

--=20
2.52.GIT


