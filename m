Return-Path: <netdev+bounces-247366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3890CF8C90
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 552E930022FC
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288973128AB;
	Tue,  6 Jan 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTwT9DcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9492F1FE2
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709834; cv=none; b=SQrVzZqjy4/b+KquNIURmhgd0NCUnxSJYn32SS6qAKfTMsXSSKZYR4dvxI7DMW98mABbN4uz3NQ7mBwP0xPbsR7VQKNiN59YZ17kwALtXQN5gg0+SxzsTXTpxpmprl0Z4+1MmpTgaJMBLkZuZnjXy5Eu2DmQ1jvL6Bl0rwIGjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709834; c=relaxed/simple;
	bh=eE12yfAlE1rfj5earAgwFv2AZemZgv3pixoGX8nJbhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIWGtAnbJu9zmcAWmX+pRV4GPjkvEaGApUbqHteIfkwYUtsuNR4qQmlRfTBxFzfIfuPVDowuMOXpjYscQdPWK4ikuHn8Akgm3XIGLiO1ogk4t3RkMCVgrN4+1q6cYMXv5vMKCbdqEV/sRpjByDdWARArKHEPuXqYXwLuKzrcOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTwT9DcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166F4C116C6;
	Tue,  6 Jan 2026 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767709833;
	bh=eE12yfAlE1rfj5earAgwFv2AZemZgv3pixoGX8nJbhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTwT9DcEVu7q9GBwyZtT/X0pLti4R9RxAdmg2+4BlViEnusAo3Sx5dDiA0N5pQ2v5
	 neYjVsxf1rZZwP4as9sqyy7oAv/4xUskKB3cj31swFjJlNxt3aLtRenqkDOdVrnkvz
	 bi06+qZ4H5pijXkS4ikCHZ9pMEcguS74up0MFmpeYqyAzY9cENAwm5c2VLRyGgwsNH
	 3Lj0rzleGcdT4Xv5JK2P0Waz5/7n0QBpoaMyia7yWf6hDv8j/OzWYXE665mAuxNnb2
	 okPfyqeykre83C+xgaFcbS1XBuJoUMyrRShMgj9SPbdNhfjduJxWhMKpwqRG4ftTqn
	 Fp20qMvOoVHTg==
Date: Tue, 6 Jan 2026 14:30:28 +0000
From: Simon Horman <horms@kernel.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jkarrenpalo@gmail.com,
	tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
	matttbe@kernel.org, petrm@nvidia.com, bigeasy@linutronix.de
Subject: Re: [RFC net 0/6] hsr: Implement more robust duplicate discard
 algorithm
Message-ID: <aV0chBkc20PCn-Is@horms.kernel.org>
References: <cover.1766433800.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1766433800.git.fmaurer@redhat.com>

On Mon, Dec 22, 2025 at 09:57:30PM +0100, Felix Maurer wrote:
> The PRP duplicate discard algorithm does not work reliably with certain
> link faults. Especially with packet loss on one link, the duplicate
> discard algorithm drops valid packets. For a more thorough description
> see patch 5.
> 
> My suggestion is to replace the current, drop window-based algorithm
> with a new one that tracks the received sequence numbers individually
> (description again in patch 5). I am sending this as an RFC to gather
> feedback mainly on two points:
> 
> 1. Is the design generally acceptable? Of course, this change leads to
>    higher memory usage and more work to do for each packet. But I argue
>    that this is an acceptable trade-off to make for a more robust PRP
>    behavior with faulty links. After all, PRP is to be used in
>    environments where redundancy is needed and people are ready to
>    maintain two duplicate networks to achieve it.
> 2. As the tests added in patch 6 show, HSR is subject to similar
>    problems. I do not see a reason not to use a very similar algorithm
>    for HSR as well (with a bitmap for each port). Any objections to
>    doing that (in a later patch series)? This will make the trade-off
>    with memory usage more pronounced, as the hsr_seq_block will grow by
>    three more bitmaps, at least for each HSR node (of which we do not
>    expect too many, as an HSR ring can not be infinitely large).

Hi Felix,

Happy New Year!

We have spoken about this offline before and I agree that the situation
should be improved.

IMHO the trade-offs you are making here seem reasonable.  And I wonder if
it helps to think in terms of the expected usage of this code: Is it
expected to scale to a point where the memory and CPU overhead becomes
unreasonable; or do, as I think you imply above, we expect deployments to
be on systems where the trade-offs are acceptable?

> 
> Most of the patches in this series are for the selftests. This is mainly
> to demonstrate the problems with the current duplicate discard
> algorithms, not so much about gathering feedback. Especially patch 1 and
> 2 are rather preparatory cleanups that do not have much to do with the
> actual problems the new algorithm tries to solve.
> 
> A few points I know not yet addressed are:
> - HSR duplicate discard (see above).
> - The KUnit test is not updated for the new algorithm. I will work on
>   that before actual patch submission.

FTR, the KUnit tests no longer compiles. But probably you already knew that.

> - Merging the sequence number blocks when two entries in the node table
>   are merged because they belong to the same node.
> 
> Thank you for your feedback already!

Some slightly more specific feedback:

* These patches are probably for net-next rather than net

* Please run checkpatch.pl --max-line-length=80 --codespell (on each patch)
  - And fix the line lengths where it doesn't reduce readability.
    E.g. don't split strings

* Please also run shellcheck on the selftests
  - As much as is reasonable please address the warnings
  - In general new .sh files should be shellcheck-clean
  - To aid this, use "# shellcheck disable=CASE", for cases that don't match
    the way selftests are written , e.g. SC2154 and SC2034

* I was curious to see LANG=C in at least one of the selftests.
  And I do see limited precedence for that. I'm just mentioning
  that I was surprised as I'd always thought it was an implied requirement.

