Return-Path: <netdev+bounces-105345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C1910883
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F9C284C1B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAC1AE841;
	Thu, 20 Jun 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKPQjSbB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RREwGbk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AF1AE861
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894068; cv=none; b=QgxeuScyHOcf8tukzefKdFLMDJErn0mICVfyN8GALgRZH3B3lwhbCylsdidlwDvw+XsxdLMZMFB4SgSjnMBWf+YBOz3F0FJtKKIMqqK4NhddNLa3C6XJadqtqm5gi/EeY2bf1oRJ1usEdk4vTys1oUdn+TI4TvNv0lQLFQRb3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894068; c=relaxed/simple;
	bh=S8uzI3WwNNkGqrCD5UJ3CMJdJNFSwchl9XncvLVGA5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kskf38DbXKDWZvNOu6HXhRpkddNOfnXfr0lPMn2SpSg/uAbusUgjsR1vdhaDUZCzqJBEIoXLqUYlgn1OFdW5sOj89IyBPXGnvytaWAjQQ8EWZ6TY1lSJm6ge6Kg0ipfN9A3QoKDjeqWJ3AZk3TGi5mcffM9t+zWq5tG/BFaiGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKPQjSbB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RREwGbk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718894065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8uzI3WwNNkGqrCD5UJ3CMJdJNFSwchl9XncvLVGA5Y=;
	b=yKPQjSbBT3zxLvQJOM+w/rSEdG9dQkhFIpGMDQstXjXUqGJ49t1Mu9S+d5eAyqXdh3sL0t
	aCnAXOUfABQ7VHfzDKS8xkZY89jg9nBM2OSbIgbBNem4Bt3zQcQjsoPKbBHtevDNlmX7+H
	a8s1YpZv+3qANoC30eq6335vMAASz5x97oEQ9XNGp9f3nBovD5D2ByuAI9pw76u3sZgrAQ
	l43LWa3LzOpyYV3o2GhUocr5IxhigGGt3e8F0+cHl1qUh3LkUhW4HFEn8IDIThahFYZ8qs
	S6l+X4RR7RQ1+ztljKYpBg84Lfp4vlIGx/Tmu47RcbXDGClJiQXF+SvEeK3ZLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718894065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8uzI3WwNNkGqrCD5UJ3CMJdJNFSwchl9XncvLVGA5Y=;
	b=4RREwGbkQBOGL8yDy/PkOVQjSv1leVxAbPPaJLGHSVmjXrlT2wdkV4R4y0JQUmLVkeuI8a
	QNZJMLRv9DMv9bAw==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
In-Reply-To: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
Date: Thu, 20 Jun 2024 16:34:23 +0200
Message-ID: <87r0cry974.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Tony,

On Wed Jun 12 2024, Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
>
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
>
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
>
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
>
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Can you drop this patch from your queue, please? I've found one issue
with this if the number of queues is reconfigured e.g., with 'ethtool -L
combined 1'. The number of vectors is not necessarily the number of rx
rings. I'll update this patch and sent v2.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmZ0Pe8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsnYD/0UBoMz+enu23dV6qrNQ5uHRsgLrj58
wXdzubX9b1yvYVWEbbiqM97mlxt8KO/1ANUPrAF3no77VeusXDzAH/C85yGVMkVI
LnZ7yW+783F3mrN/6lZoopGqGiH5gwlJsW44TqeBX5NzEJmmDle15Ny0nSos4x0G
VaYFSSwAotJ1+pu9++GNokFDGRM6v5deEBB4c+fCZrKAv1EjaVnmPw/9Ov/BV19F
1hQfLYYc/YOKK5/XHppS+di1wuPTyAsm1gYPGi7N3lF/HUcogs9hbjjxq5h9YTmn
BJ5y1xZnW4WBtnD53ZA1bJb3uZbOSVyW+nkaoBwNg3Qv/MQ38lLPHKjv4ET/iood
J1v8XjoaD7MiPtub1FzRuwGdJDg4z3kR9iJg7qYP889Wy131VgVctU7AgDA+KBwl
sOQG/6zbpPzO8DuOjSIvDQCqE/ktOiUjxnT72PEwj+of3zrcEGtYJVF2yHeuPt9W
huy/yzL+t0z2ffJ/WRDDaJw0JaqwqZwkkiW92R4tTNLv9KqcilUJ6Q8mMFgi4iMW
MtLqRr4PYIKUKXKolzt58UVe5csf46lLLyBUSH5Gkpz0bm8d4771GQbK1ZNVqZ7a
FCwgbpuMRborhy7NpDdNG9n+aTf7Oq+MlyLvP/q1tR5bVVLG5Gi7sTCyPAi+XOXO
nBC51jhdFelM6Q==
=jCW/
-----END PGP SIGNATURE-----
--=-=-=--

