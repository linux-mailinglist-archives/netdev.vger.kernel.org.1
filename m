Return-Path: <netdev+bounces-166177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA31A34D85
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F10E1882D47
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C08241678;
	Thu, 13 Feb 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vOsiWQRs"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504328A2C3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470936; cv=none; b=I2iMOT5ZENygE/4emD73zUf4/+1W8Cp9fkp7LV4laDOqH0PixL1cCt8QXWdh/3atMc6jfsqt8aL1Sd/Fn9yJuAaYBIknA4Nt4XhwF5xByBhd15ys9qPy3/FitjJAqPUuGUi0aghtCG5lZJ+2pHMQZjGir6QdVP9DzGOtMqA1Aqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470936; c=relaxed/simple;
	bh=IGWbafvYRMl0ZLTdEril1KI6J+ieAjs6IjhIZs8W1e0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8vdAZ5ULUwiTQOHMSAlm9EBT2uNcR7vy2A3bLUTfiWNLWb53lXskQ3F6Ab6masIxZ0F7TKsShuMJzr9CASQkzWl32xKq/Mcqz/dIitCTvpsj4YWtTH5tGMOIx5a63UKt9SXSmlt8et0CISxiz2sLrGhSI46pg3doSuNSSM15d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vOsiWQRs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zvFlIU3V/8eNbtU7fzLr/vVwLPCbaH0nOfNP7zCtkyg=;
	t=1739470934; x=1740680534; b=vOsiWQRsQu1BBzwdzWfNjg4Hw2K+i05a7TbMVuebbWx4n8V
	wDr4Vcy1h3qH1cK3cTHNuVNSqcDiAviIIh1uwtaS3GS0PQM8D4JMES2HXFJYP0A3q72s68VgDYw8m
	MznVsSTN7hgfwz0iMngUreki6XS+vvn3006j7DnlmbkmT7cEAB0WFX6Lp4ozedOL6llUnEVhQ8w5x
	6k5zE0KeGkXnDcWEmxKA3FuEoDEfguW2/Zp6sfklPLJwnRzsV9PFFAZaAzpfbz/7s47vpy8leL8JV
	hcYsNgHzEMyj0rSthZuwqv28Y5QHcYlXsf2YW+81VrBJDsGAzOt4sxfy2BSgoizQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tidqf-0000000DWvc-31Ds;
	Thu, 13 Feb 2025 19:22:06 +0100
Message-ID: <dd9fa04ea86c2486d6faba1eff20560375c140b6.camel@sipsolutions.net>
Subject: Re: [TEST] kunit/cfg80211-ie-generation flaking ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, "Berg, Benjamin"
 <benjamin.berg@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date: Thu, 13 Feb 2025 19:22:04 +0100
In-Reply-To: <20250213093709.79de1a25@kernel.org>
References: <20250213093709.79de1a25@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-02-13 at 17:37 +0000, Jakub Kicinski wrote:
> Hi!
>=20
> Do you see any problems with the cfg80211-ie-generation kUnit test?

Nope, never, we must run it dozens of times a day ...

> We hit 3 failures in the last 3 days.

Four, actually, it seems? ;-)

> https://netdev.bots.linux.dev/flakes.html?min-flip=3D0&tn-needle=3Dcfg802=
11-ie-generation
>=20
> But the kunit stuff likes to break because of cross-tests corruptions :(

Hmm. Let's say ...

https://netdev-3.bots.linux.dev/kunit/results/987921/kunit-test.log

is your serial console simply too slow?

ok 70 cfg80211-inform-bss
    KTAP version 1
    # Subtest: cfg80211-ie-generation
    # module: cfg80211_tests
    1..2
        KTAP version 1
        # Subtest: test_gen_new_ie
        oaction: accept multicast without MFP

should say

"ok 4 public action: accept ..."

instead, I think?

johannes

