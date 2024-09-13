Return-Path: <netdev+bounces-128213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0009997882E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDF1F266FB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186E13AA26;
	Fri, 13 Sep 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu2kjHj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3E126C13;
	Fri, 13 Sep 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253487; cv=none; b=SLyRutT0kGyL20i+K0JET5jkNLf5gVj6NO2vplaw83G49im1yTSJ6m+yvSX2J218Ih3rsKfSpmOa2I+73oDd4pJEvALmeDs0prb7enObL0+tznb42mI2TpCvF6Fln/0PQ36ArCCWOIDKONthCL6IsIVvTzITuiS8OhMWTooOTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253487; c=relaxed/simple;
	bh=8Iu23eBbEJL7ct2fljpk9VOYT8tiAHKCB1nNFWg0iRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpHyHXMLvWCgFKvqPqlpg/udd2W+VeLaaYJ3uY6FmjyA7+b9Jg1pMqR+BDu+mRPT6/9Qc7CXjMcAaSMk1BO/74acnUAOkbio2ngzegSd2jlUIpmtpoHP2EnkCHwDjK5QYJV6dRT/CB4hXGGSEOUQZRAfEVfGI9I2T7N0WUf9VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu2kjHj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C2C4CEC0;
	Fri, 13 Sep 2024 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253485;
	bh=8Iu23eBbEJL7ct2fljpk9VOYT8tiAHKCB1nNFWg0iRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qu2kjHj/4/Y3mEjQS4GOZU6qtNVz/sQeElAk4IGFDJmpEdRfyY0T8e31DHSJx+F2l
	 zgirOCJiDq02QBeU2t8He4HDHV0p/6sngYdnyDgwHJnh8FDRbx4DJiVR+GUVA3uNOt
	 HGGhV+KMi+efKlGYf+aKG5KToxad3lLRcBSdw6h7qd982+we0Se5Hfhtzwkm4V13gt
	 vHSIUXByXY14T8QGLEwmVqKz/g513yrq5W3FPc/cuOd3MQGLtbTnO/C5NPf92qugcl
	 Xu4MCZsVQ1+thLkQcVlZyfSM6v7d8O8WQPSwW6iXe6RXMkDmM/6SJxIHvi1LZwZbtR
	 3bCXUhExv2qzg==
Date: Fri, 13 Sep 2024 11:51:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jacob Martin <jacob.martin@canonical.com>,
 dann frazier <dann.frazier@canonical.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
Message-ID: <20240913115124.2011ed88@kernel.org>
In-Reply-To: <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
	<20240912191306.0cf81ce3@kernel.org>
	<CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> trigger the pmtu_ipv6_ipv6_exception sub-case

Sorry, I missed that you identified the test case.
The split of the test is quite tangential, then.

