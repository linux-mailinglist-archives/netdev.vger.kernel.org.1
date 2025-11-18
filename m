Return-Path: <netdev+bounces-239309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBDAC66C81
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DADB9352A15
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50213DBA0;
	Tue, 18 Nov 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th3Aa8oY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016FEEB3;
	Tue, 18 Nov 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427913; cv=none; b=HCzSckMOTYs1nzzCofmi86RI5rwH2X4S1Kf+16Y6Q9nXZDIfpK+fXDZneRcHtDSVk9c9DQlnWnJatS9/U6P6Go5Klvij6UJVtTG3cCWnwnoJWYKTcmveQVISmIrg4+4c1gfpAsuLlfFo7a2zp7nDZyd8JRrgsQ6HNmZxA+dqPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427913; c=relaxed/simple;
	bh=3vRuS3jhAbIJ4aR5KD9+0crFujpy8R3Ml2SGNf0hWQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulLhDfqYbhObmSwk5xGBOHibEoD11Hq66oj0ejc5M+ghKeabPvfRyKJAX8qiIkRlTnJrKziVmC6N4kwAqfLaZOb+yNojYdYRzsNB9ifO50NMegBJVQU3ruEh3d6Ndiw7rozIibrR5zDrSOo33MdDElfYRztSBdxCBD6jHaV0s6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th3Aa8oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D195BC4CEF1;
	Tue, 18 Nov 2025 01:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427911;
	bh=3vRuS3jhAbIJ4aR5KD9+0crFujpy8R3Ml2SGNf0hWQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=th3Aa8oY2cXQ3JWEy4XJSXlFX10rgFvafqnnSXmZo9kDCKUjuHXF9Iay0nbQURsiQ
	 sd0PkY6u6uT7AoVJql4BvJWGY5aQP5PGnOfkCe9dMiIqpfKJ9GSYhlN646/StMkJ0l
	 1gWfUAICr0RsvSKnONMEjQ+SPdSAncWQi8yq1KlkMoXeIptfw5PTSxsAkdhFfKmus2
	 70THQqjA9YFvaUEEoXsSHajPt8tcoAS+FkzgcM7fhX+EVd3DFKml6nFF/NiMqCYCqS
	 dwCqt0UG8CIlkPs29FiCFwWvsMuVxGqdvdSA1R3i94PTnDFHZInbmBu06PMc1NWRnh
	 w1AdKfv8WNsuA==
Date: Mon, 17 Nov 2025 17:05:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com, Geliang Tang
 <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
Message-ID: <20251117170508.4ffe043f@kernel.org>
In-Reply-To: <a155bf8b-08cd-4cd9-91d9-f49180f19f6c@kernel.org>
References: <20251117100745.1913963-1-edumazet@google.com>
	<c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
	<CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com>
	<a155bf8b-08cd-4cd9-91d9-f49180f19f6c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 11:42:31 +0100 Matthieu Baerts wrote:
> >> Out of curiosity, is it not OK to reply to the patch with the new
> >> Reported-by & Closes tags to have them automatically added when applying
> >> the patch? (I was going to do that on the v1, then I saw the v2 just
> >> when I was going to press 'Send' :) )  
> > 
> > I am not sure patchwork has been finally changed to understand these two tags.  
> 
> Ah yes, thank you! If there is a dependence on Patchwork, I think
> indeed, it doesn't recognise the 'Closes' tag (but I think 'Reported-by'
> is OK).
> 
> While at it, I forgot to add: this patch can be applied in net directly.

FWIW I have a local script which extracts them from patchwork comments
and applies them (same for Fixes tags). But it's always safer to resend.

