Return-Path: <netdev+bounces-81870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAD88B732
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E12C7E5B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8AF4CB54;
	Tue, 26 Mar 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrXYJLI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9091CAA5
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418999; cv=none; b=mtH6VqO9zdVd8ZooJABHyG97CAJLaHsG7cV53gNuxLPHf3OLrYhrHoeHHzoGNxZ2mc+5Q9ZyrkJM/HhjBZq8RY7mL+OlHav1KBQ1ZdaKA0zmwErWJOEz5WP6IZaXSFsK90m7cwvNKPKDWftbf/Xo1qJ09mP3dfLbb/UAn18/UrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418999; c=relaxed/simple;
	bh=BOroFWsz6a/1Lr1ULGaESHVSMwx1UyC48vnufYuY9xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Wd7Dn1AuOEbG8LR7Fql7q9OUEU/bMCXAAab4msy5NFEkKQiZo932QLpFh7y9JEM43P7ajI43++FaPC3Q+ZLCWRypmqrlCbz5c5FsGJtasX3B6nUQGtdWg4k9agQoOGrNwBd17Sasbyet7Q2qI8Kf/nI9TEHblzx8ZuPyFI4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrXYJLI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6C6C433C7;
	Tue, 26 Mar 2024 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418998;
	bh=BOroFWsz6a/1Lr1ULGaESHVSMwx1UyC48vnufYuY9xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IrXYJLI+PIBv7NZNDCVWA9GdtfK42H0LwCVE05d8xVo2rOgG/MpD95GF2XuPMs4XS
	 Kqaai/1qgANsm2mjQxEZCPPizEfZfWI8nXgJSSi6n1YtEua61WZmDrkNVM4HZR/eU9
	 gt7xIWM/QccvVj5C+/9FAG6swENXIu4pFK9o4wRk5BRKE556MVAknYTn4mGQDcRUIz
	 1qRUGKT1VlElnt1CfQM5A5ce5dkYAZjKNPOiNWckjbFTiU/R9Ws517Y8KQEtLNCRNb
	 Sz33rLUy5a48t2E0KiJ13nVKXwTueZlduIXLT7/6baK7CeMEJpcFtXicQtDRWY215V
	 zRWXplCuYB2Pw==
Date: Mon, 25 Mar 2024 19:09:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <20240325190957.02d74258@kernel.org>
In-Reply-To: <20240325223905.100979-5-johannes@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:
> Hi,
> 
> So I started playing with this for wifi, and overall that
> does look pretty nice, but it's a bit weird if we can do
> 
>   guard(wiphy)(&rdev->wiphy);
> 
> or so, but still have to manually handle the RTNL in the
> same code.

Dunno, it locks code instead of data accesses.
Forgive the comparison but it feels too much like Java to me :)
scoped_guard is fine, the guard() not so much.

But happy for other netdev maintainers to override me..

Do you have a piece of code in wireless where the conversion
made you go "wow, this is so much cleaner"?

