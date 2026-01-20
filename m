Return-Path: <netdev+bounces-251335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8230D3BCA2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7AA2302783D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E91DE4CE;
	Tue, 20 Jan 2026 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="QRdLLYtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E91AA7BF
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768870129; cv=none; b=UOn6GnrE50CmFxm63W2UDvbHjd0+ZSZ+lVPGcL8VcjYOnShj7EClcMI/gBjeeOiEprBzvIw0KEjfvj6zIMz4PXmEZcXSML0uWA9VHOG7D+e9x/SGikzLFnRdpGEDiFh4/bph4wzfiwTq1MS3+VZsvFoMSuygleo+TzpeDpjFtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768870129; c=relaxed/simple;
	bh=4svxBZQ3RPxlhAENJZN/CF6IXpMwFIpjnBX33bl4DLM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ttcQQg5Trib3ezG1IFCXspS4YTGzM0xtWPbMCmIOBgGL6L3OlQLfD4irdtDVnSQDQRaSvPfkbxkV4PYYwpq+bAYYnywIs7urjHEv51JwcYayT3n32I85UeFcbdNYgkl3rVlRQeomxefWKB8X6qnTlZmB6XsfndaciYMoIKpQw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=QRdLLYtq; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768870108; x=1769129308;
	bh=ZkEBgcbthzeyCZGFSk1PGFkY9eDCiL/ndFf14lfNB9k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QRdLLYtqB5xX9xLLcfz77d+uVn/eU+MJkFg1o4+HvIzIYcxUhAVkGykADZ4btWAHw
	 wMmmt3YqUuSPkRPHpe4kXtyNGkkcoE7fr2vT5jS7N5Zm6NC5nbeDCEWp21f/Ji+en0
	 JjXu3WP3kP2rhRpMNPouDHywztz7AiPG4XeBOuBxfD2xxeJn2IxB5tlzNoCHlDP4tN
	 iMurei7oJIfE4lfGVWPBo9uOmPEYdPJkfJIrI8gMlp6ioLzA8VEFlRaFqSJbYz9yL2
	 V7DMW7EncOZZEC9RXLf9udy5taauVZG+vdir74t4uoFBk0zqGoviKlS0x8+98FjWNR
	 Rb1ZNTIP+A3WA==
Date: Tue, 20 Jan 2026 00:48:21 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v2 0/2] net: sched: act_gate: fix update races and infoleak
Message-ID: <20260120004720.1886632-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 95d34b41a6eeee5445f72e890bbf123da97a4a6c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes act_gate schedule update races by switching to a
prepare-then-swap model with an RCU-protected params pointer, so the
hrtimer/datapath never observe partially updated or freed schedules.
Old params are freed via call_rcu() after the swap.

It also zero-initializes the netlink dump struct to prevent padding
information leaks, and tightens schedule/timing validation to avoid
misprogramming the hrtimer on invalid inputs.

Changes since v1:
- Drop tc-testing changes; no test updates required
- Validation fixes: base/cycle range checks + derived cycle overflow guard
- Fix create/update corner cases: avoid oldp deref on create, publish param=
s
  only after full init, fix partial schedule copy cleanup
- Timer handling: cancel/reprogram only when required
- Keep dump struct zero-init without unrelated code motion

Patches:
 1/2 net/sched: act_gate: fix schedule updates with RCU swap
 2/2 net/sched: act_gate: zero-initialize netlink dump struct

--
2.52.GIT


