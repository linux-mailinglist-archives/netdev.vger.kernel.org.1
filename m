Return-Path: <netdev+bounces-158210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CAA110D9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779783A03F9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC071FAC34;
	Tue, 14 Jan 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoDGiNcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EA1D5143
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881730; cv=none; b=aWOD+nwQtByOUrx1aM3OpdIw/myFGHJtUkQUjN0L0iaNjCsEDVhfocfd6rkUbwHeFRkcf2oksqZirwRQDus2rP2AEL+TobEzzyjli3H1Z+4sNUUafOpfXtll5m9DVpwfOYVN8QSh8LMLCFgCw+cekJNDJwSM2eFhuLphoSZ11mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881730; c=relaxed/simple;
	bh=KbulnkEIp/mzrZCpBlZtg16TfPfYuala5KVf7DQLD/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2i1ovxX9XHOKIGneHWktt9NiXxTfkig+BaJ7tFygXy4+PvyJ0T2oEfMyIWxXz5tTyaHKjF6FWNIv7797ioZEDHlmMpn0OwRC+dKURH0D67O/pXYCp4H1dMe4FFkTu2/pZAHRSsR86x6iv27SVbVxdzLz4pc990MTmT3QBZH2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoDGiNcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FAEC4CEDD;
	Tue, 14 Jan 2025 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736881730;
	bh=KbulnkEIp/mzrZCpBlZtg16TfPfYuala5KVf7DQLD/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CoDGiNcXq5fvDDkC6p7spop/+69OMT3jDnIbzBp90z6TSx4maGSS42KnzVKvvqU6s
	 ticfy/eExY7wgvR9NAaLBi8Q5FM1uguQcY2lD5W+d8StRSK/pseAL021Cuv8Vz+jEm
	 4wBzXhLS070FrT8jXFFT1s3/mJ59hYV3vQXlqX5OHkvb9qAR4xS/LCc7vLBL3E1QBe
	 TprBss7yZ+WYvVmkmJbu9VSj0YbvISKHXKZnSZUDlHtKRN20MgmHMTjHKz0yGH6PuB
	 8qt7ZKKcO+hRmfdDADajQtKklY80XvjBtYWsIEovKM5i22KuW/hPKrkjX0e6ssa2P8
	 S3N7nVMj0K1AQ==
Date: Tue, 14 Jan 2025 11:08:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bonus <kernel@bonusplay.pl>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, netdev@vger.kernel.org
Subject: Re: be2net: oops due to RCU context switch
Message-ID: <20250114110849.0eb0ff2c@kernel.org>
In-Reply-To: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
References: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 11:37:36 +0100 Bonus wrote:
> I've encountered a regression with kernel 6.12 immediately after 
> booting. I don't encounter it on 6.6. If required i can try to bisect 
> it, as it is very easy to reproduce.

Hm. Bisection would be helpful. I scrolled back 2 years, I don't see
anything very relevant. The driver sees very few changes these days.
ndo_bridge_getlink has always been called under RCU.

