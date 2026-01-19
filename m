Return-Path: <netdev+bounces-251026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18799D3A2F9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF0A30062CC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E5354AFE;
	Mon, 19 Jan 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9C3KrYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB0346AC6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814942; cv=none; b=D6jPWyMHx21FqCGKlUuonqL3I9GA6IsF1xmDMSQL5lgG4AWzYLysrTlpWCLSY+0OBdRfoCcEfMdapoiriitcQVWmplB0LPJnvOrT039J5goY2UARn545N4bixQLMMU0tJmpu7lpr7W49mjdIjqTrojRucTFEzQo/N4QHKXe8APc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814942; c=relaxed/simple;
	bh=XjQxaNaJtfrGY2pwNPROWy9ibNGhYmBFzU+ohE9RW38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ROJlvKOn45A7eLzhAxyO+IACpxVWf6ny+94tVsHowIBdik7c2wpsZmRBoEh6VGhV2VAm5qSnQmiymisJo9i9J2+l69bbJT1IWFmlf7dgZfgx+bCQwlWoMO/AnMsfkTzEqdlBC+p3/OTQ7pGqMWBj1wEXDV7rVeoKTuNEZci6puY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9C3KrYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3628FC116C6;
	Mon, 19 Jan 2026 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768814941;
	bh=XjQxaNaJtfrGY2pwNPROWy9ibNGhYmBFzU+ohE9RW38=;
	h=Date:From:To:Cc:Subject:From;
	b=t9C3KrYD3BLeoj3psIkEaVq+cyl2NMrUe/8DZUEVKoiHx90K2udqw/VJ8LA027Pg6
	 +AQxd0kq6drapLGcg64+km9gffloHYyUe1ERBLtypazOp8cXHLJSFKHCYcWFkm52ot
	 CPBoa5O8k5xmHijF5sm0j7IEOVn3AjV4sg2VtAUjzJ3NGFUvx8+RZnccM6j0Qtc/vl
	 aMzeIzBJHZaxgYdIPL7Vaqs0xb8W5itq73cezIeoYPr17xojtoM1LXYdr6Pp9WsP81
	 1XfLGWESGXaURSHG0ouJSNVvpKtOSlqV5IGk4mNsns/mLSpeeCx261GtggPcUeXd6U
	 EiFxPYVwcN1pg==
Date: Mon, 19 Jan 2026 14:58:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>
Subject: Re: PTP framework for non-IEEE 1588 clocks
Message-ID: <vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Jakub et al.,

This is a follow-up of the recent discussion [1] around using PTP framework for
device clocks which doesn't the follow IEEE 1588 standard, but just provide the
high precision clock source to the host machine for time synchronization.

Jakub raised the concern on exposing these kind of high precision clocks as PTP
clocks during the referenced patch review and also during [2]. I agree that the
concern is technically valid as these clock are not following the IEEE 1588
standard.

I then looked into the existing PTP drivers and noticed that many drivers like
ptp_kvm, ptp_vmclock, and ptp_s390 fall into the above category. But that could
be because no one cared about them being non-conformant so far. So I'm not using
them as an excuse.

Then I looked into creating a new framework which just registers as a simple
posix clock and supporting posix_clock_operations::clock_getres operation as a
start. However, it feels like it would be a stripped down version of PTP
framework, with a new class, and chardev interface.

Creating such new interfaces means, we should also teach the tools like phc2sys
(for -a option) to learn about this new interface/class.

So my question is, is it really worth the effort to create a new framework for
providing a subset of the existing framework's functionality? Even if such
framework gets introduced, should the existing non-IEEE 1588 drivers be
converted? I personally think it is not a good idea since that will break the
userspace tooling, but leaving them as is could also induce confusion.

I'm looking for other suggestions as well, thanks!

- Mani

[1] https://lore.kernel.org/mhi/20250821180247.29d0f4b3@kernel.org/
[2] https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/

-- 
மணிவண்ணன் சதாசிவம்

