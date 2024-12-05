Return-Path: <netdev+bounces-149426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130009E5957
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B72844E7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08521CA02;
	Thu,  5 Dec 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2fGKpDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67FBE49
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411218; cv=none; b=Acn7BIkppt59s8CvjGsxclpNJhj9H3IPYDwtJOw3esmCG+BSks1NMWt0Li/ePXUV0k+7HG2gLwyD0s5iGBLg7yNAROcUUfe9EYbSVEjqRbLCK8Wq9MvHG+LNji/cAV+pNZpSPRnfsoTAdvVGU2CD/SqpURWVt45yOftCM6CvIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411218; c=relaxed/simple;
	bh=gdF9/3D2EbWUMuSk/kOMSooR20fu+CP3Z9Ho+Kr2oi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=nNP6elFd/41rFDjBzJ7jAcfmEfFpoSc2GVIWPU4UeVj7ZpMMFa9ZLfnO48Ucana1X9A8WiSgpxjK7k/XZPkQ3O2PzS2jkI/gP+Uklj5FXLCJnJ2AotHaAu4CD1WjW+9BBVaU+pUAKsOPkk57A17ZqJt8RCL5O2c+OLO1LeHG1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2fGKpDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7A2C4CED1;
	Thu,  5 Dec 2024 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733411217;
	bh=gdF9/3D2EbWUMuSk/kOMSooR20fu+CP3Z9Ho+Kr2oi0=;
	h=Date:From:To:Subject:From;
	b=J2fGKpDssLMMV3yBmL07oVr3FL+cw0keRjOB0Jjb8AWHxANwOMnfO1N2s09nzyyFu
	 H0DaF9amcR2wBH1naVZX8iuG/rcwFkUeF4cXItYfDsMpJseendQ6nGDmsDtwi6Aoxs
	 DOWhMdjOeA1QVG0iJYZP2XuWXr1+u2alBwFrB+jmi2OP5Pf2FjDXXxVhMRqjzQvG8p
	 nxWZZhLCK8TaxlzD4uwy8fZfwYTLP2o6goWXR2IgCDz1/Qb+p8iTmWptFTwTP8h7Sv
	 WKPjIUZl2JbcCO1OMb2/sBWPk24x/IbEToSM2swtLsaj8wRODQy1hW2CBquLtGndYu
	 WP6hI/fMrUSjw==
Date: Thu, 5 Dec 2024 07:06:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [TEST] tcp-ao/connect-deny-ipv6 is flaky
Message-ID: <20241205070656.6ef344d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dmitry!

Looks like around Nov 14th TCP AO connect-deny-ipv6 test has gotten
quite flaky. See:

https://netdev.bots.linux.dev/contest.html?test=connect-deny-ipv6

Spot checking a few looks like the failures are on test case 22:

# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_key_not_found [2001:db8:1::1:-1 => 2001:db8:254::1:7010, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 0
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_hash_ao_required [2001:db8:1::1:-1 => 2001:db8:254::1:7011, L3index 0, flags: !FS!R!P!., keyid: -1, rnext: -1, maclen: -1, sne: -1] = 1
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_mismatch [2001:db8:1::1:-1 => 2001:db8:254::1:7012, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_key_not_found [2001:db8:1::1:-1 => 2001:db8:254::1:7013, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_synack_no_key [2001:db8:254::1:7014 => :::0, L3index -1, flags: , keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_wrong_maclen [2001:db8:1::1:-1 => 2001:db8:254::1:7015, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1
# # 325[lib/ftrace-tcp.c:427] trace event filter tcp_ao_key_not_found [2001:db8:1::1:-1 => 2001:db8:254::1:7016, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1
# not ok 22 Some trace events were expected, but didn't occur

Nothing looks obviously relevant in:

git log --oneline  --since='Nov 14' --until='Nov 18'

I have installed virtiofsd on the test setup around Nov 9th (which
speeds up tests) but that also doesn't align very well..

I'll filter that test out of our CI for now, please TAL when you have
time.

