Return-Path: <netdev+bounces-247236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05DCF6154
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89EC303D6B8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036C3D561;
	Tue,  6 Jan 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuETlSQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1D2836F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659454; cv=none; b=fvsubbnST6DA5sIk8SGnZTIhnNJnHBzZjbTR7br4RHPolai+oADaj6N594XyQXCQFxw1eL7kp6jEiDc45ZjCpB15SntPdIAsk36WWtUvKSbw6g1KGqJ6p8vXRROWIYfP/eClyJhZ0Veik+/ola5Ipg0MCq4j2/osCpnfUqTQwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659454; c=relaxed/simple;
	bh=EDZWQSNUdSN5iZcbOpRlMGD1Ic5S5dqM1R1Sbin50LE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfO/Lepp8NU1B4CPSDhhl1MRzpxsbO2MLpY7hizNaFjm48Pl+S/tGYty8zDrm7qDMbkP6tHQPgVy/UpTuaA4PZJ7KIefjkgh8H6f6dcitc9NQHNsRMv9ClspXFQk7PNk4N0O9mTCVv0Xi3bGTNABV3HMd0TvuSKcgzbxcZhE9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuETlSQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB6BC116D0;
	Tue,  6 Jan 2026 00:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659453;
	bh=EDZWQSNUdSN5iZcbOpRlMGD1Ic5S5dqM1R1Sbin50LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KuETlSQsAJbzOx9bVzZehEUUhGl0A/l3wGVOgCNf6tN+su9YK+dPHD5PjzX2YpFrc
	 h6o25sMIO45DBgOqEWufZyJkehl7Z2kiew9PbKLr2eql/Kt+tD//FuXdH+gZQST3Zl
	 z10ULjfyfBmaidBkdRYRjOjY+ENZPdHmUr7PIvBAC/L3Ja+40YwlD5S+CYe2rt4NIr
	 Cd6DPFeUgY+ARRPScr/Y+I8XPxJ2YFXa3U5sQEolye2y25s2nFKdO3+FYTJGUerlA4
	 2GPlcf0hXDXXWlKowmtqZtAqw9bL/51Rinu1tyTgLqaRFavWbN3G2dBLJ6yR7idC2Y
	 nXwSOBfiUXjHA==
Date: Mon, 5 Jan 2026 16:30:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net v2] net/sched: sch_qfq: Fix NULL deref when
 deactivating inactive aggregate in qfq_reset
Message-ID: <20260105163052.06bf29da@kernel.org>
In-Reply-To: <hvgvn5n45dla46vehvoi63frvkzk7s2wnpbi6l3mrbfl5njk2y@ttfv2gestxf2>
References: <20260102013148.1611988-1-xmei5@asu.edu>
	<hvgvn5n45dla46vehvoi63frvkzk7s2wnpbi6l3mrbfl5njk2y@ttfv2gestxf2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Jan 2026 18:35:06 -0700 Xiang Mei wrote:
> For the new version of patch, I attached the crash infomation decoded from
> scripts/decode_stacktrace.sh.

Please build your kernel with debug info and run it again.
scripts/decode_stacktrace.sh should annotate the stack trace
with line info, looks like it only decoded the asm for you.
-- 
pw-bot: cr

