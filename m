Return-Path: <netdev+bounces-210787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B7B14CD6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026A954446A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC251DE891;
	Tue, 29 Jul 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJc2lwud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CB2A1CF
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787742; cv=none; b=fX+Doxa+2DrWVml0r6nAsl8oeFyczuT1HZnhuPLYS1/pdJuwM7KXv+ifRJrkM7jQc5VG5uOrrQIkt5MZm09SXu77wvK1UY4SNmaSaWKm4uBtr7fkOmvq23sriOtGOFry1mOGdbqRIxPtqPQKfUoAk9xq0go28mcRkw/wmPCDH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787742; c=relaxed/simple;
	bh=FcYkCm3UxganLnofamh67kLQIof//L9Kqq37J5pzGGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdciGlFbClpSbW+e4syA28axDURf7/rO4eAE5lo+ktU66kSZ5khwiYwX2hGhEPrOOLONF5K2hClILqRTx+Vh9qP4W+h9z37yzaVk6ze65HmZEjH95CmZDB+pMJAxFYWaG2akRXzsyvubRaJ7P/0bfr3fD5okNdftAVc7ZeX9gOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJc2lwud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FD9C4CEEF;
	Tue, 29 Jul 2025 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753787741;
	bh=FcYkCm3UxganLnofamh67kLQIof//L9Kqq37J5pzGGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJc2lwuddMaBycEpMo06nhHOAmhMIm9jSu0VVj6uVQQ0r21JV/naev+pF1PNM/IyM
	 8Q9cDQxN5uvHFxvtjpGnrHDmw3gsabdoy3kIzDZeCE93FL40V77ny39PzX6wC04zpD
	 sV9G5ayBsbPMLkPF0Smo24iNVim07+a2tXWVGOFwi8afosvhDQpMqrXVsAlc3SCoCj
	 Z8WfEQbGxPRXP1Vdu3d8u2sZhKWSCYZ1u4ONF5jM8kfSvDtqMkCeXAQOx7MD+q8uYU
	 iM054BrzQSkgwLmRqlNLyB5wepivJkuNk9GvClfCvbOIVbxz83Z9p7J2KpWG4qz1H7
	 4kFAMu0qvjAKA==
Date: Tue, 29 Jul 2025 12:15:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Alexander Duyck <alexanderduyck@fb.com>, mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net] eth: fbnic: unlink NAPIs from queues on error to open
Message-ID: <20250729111537.GC1877762@horms.kernel.org>
References: <20250728163129.117360-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728163129.117360-1-kuba@kernel.org>

On Mon, Jul 28, 2025 at 09:31:29AM -0700, Jakub Kicinski wrote:
> CI hit a UaF in fbnic in the AF_XDP portion of the queues.py test.
> The UaF is in the __sk_mark_napi_id_once() call in xsk_bind(),
> NAPI has been freed. Looks like the device failed to open earlier,
> and we lack clearing the NAPI pointer from the queue.
> 
> Fixes: 557d02238e05 ("eth: fbnic: centralize the queue count and NAPI<>queue setting")
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks,

I agree that the cited commit should have updated the unwind path as per
this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

