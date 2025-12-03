Return-Path: <netdev+bounces-243418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB8C9F8DB
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 210B43015ABF
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBE31280C;
	Wed,  3 Dec 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvYhPmAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B4311C15
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776157; cv=none; b=WE6qY5VufMgh7pQ5onG9apofKOqdzALBJXcAfyZ31mvuyTY10acDShyWP0x7VlZXue3Ira6HkdvOvFIrk74jmskvaoVhdi2A2taMjSPlirYFu6eLHHC8gOptpVuwvRso6ga9N68ixQZVeX3OdDAFU6AkMqM1U4e1VoGmM+F38Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776157; c=relaxed/simple;
	bh=9dF7HKmp431jqP0JpvD6DkpzO8C53TJW9TCOpUTEXt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ha1aFdlbMmrcT0DJtvEyv8sIxqcjLJ+D9MV1Y24704bZ13MoFJwWH+bRMRHmI3q/+bdmRwIb/F4hiEIx7pAOaRGdGmehiFLjrYW/8n8Yj7jEZXZ915fFPaZoUEXyZWWWFWYy604dqWJcSILlzrZSzA2GNLHSBgyseNLWAJmh3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvYhPmAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A864C116B1;
	Wed,  3 Dec 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764776156;
	bh=9dF7HKmp431jqP0JpvD6DkpzO8C53TJW9TCOpUTEXt0=;
	h=Date:From:To:Cc:Subject:From;
	b=tvYhPmAg5NiGQyE5gG2401hQ5gQjVZBCGUIHnSsNldZizj9fGqzB7QLxUSTCX1Cps
	 YQWAdd8kr2hJFIoHVp4fGDJBkx4r/JbvhJNF6BxfSSDM1RLGfA5Ad8C2wkwcA8j0CC
	 N/x7DFSICuo2N19Szu0kwNftu8lWHnVpKK/SUyLcMADln70iL2F0TdDhN6QekEGDSc
	 EcDGUDCPStPufkj1JSg7cu3zvtNHNQsGBUS4TKJPgogTVngUUAgPMZONN7UCYOFrRX
	 rdn2WgSX2Dc1WidSEyEakLW6TfLuhmF8bKffwOQkTwPOz7xmEKEtcLyb7T4ohZWUDX
	 ZxygFf3JTzMKA==
Date: Wed, 3 Dec 2025 07:35:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: MPTCP deadlocks
Message-ID: <20251203073555.1f39300c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Not sure if its the new machines or some of the recent work in MPTCP
but we hit a deadlock in the tests a couple of times:

stderr of join.sh:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/412720/1-mptcp-join-sh/stderr
decoded:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/412720/vm-crash-thr0-0

