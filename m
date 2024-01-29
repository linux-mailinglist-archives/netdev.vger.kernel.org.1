Return-Path: <netdev+bounces-66864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC008413E3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C259A1C2361E
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5C615A494;
	Mon, 29 Jan 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5TC8IDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC715A491
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558053; cv=none; b=qFhgz00rhFs4boWZPoDioNknGSMOgPsEd9P6OuMtl93JYak6bAM8fscz/V7ph7cN2HgNKTHfbLY6/7i7Wwj/+EaPNXdSecZV+sMrR3VFqPVTE1rQ26J0kfZS0hfEFukUoUPUFKhRLktOCEH8vlZHJ6R3NbQt4AY8vbdsTnnHzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558053; c=relaxed/simple;
	bh=uVTpFfi9jRPvunUX21rw8sIbOfx3r8wCUcO4hwEEXSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSNA6qarmIZ+l2O2snd3Nqbs1VkcD9kitzDTXKRWcY1D8PF8q95JOuUiWwA8FRIpCy2XyXUVtgbC2K4YwT5EEFz9ISbfOABjWK5BTIrVewbiKKyNk+I6XH4zxNt/4NKukmuoxnC9u3Y5vAV/7WUjOrSGTCmgV5AUKirEAfpQTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5TC8IDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E62EC43390;
	Mon, 29 Jan 2024 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558053;
	bh=uVTpFfi9jRPvunUX21rw8sIbOfx3r8wCUcO4hwEEXSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5TC8IDqVVFCZFA8deEXxoXhnVBrMSBBgmWwpJ8kSwuPTWkHSA2uBoxEoiEidfcoT
	 XEzU2Pqhs52YAbhm+FTy8QrkWwtZmhNeBFTN0UatQLhppBTn3czrY3mbosCIsfj9bG
	 fAmx/tNKkQQ3HuXDeWClh0Lyfb0AuTcQT5d81BbFkZ1+h6hACVIE4VT9RpUTaipeKu
	 75QJBi4cBNfOUM6nL+ASoiia54Tw+L1JvnLyk4LFjVIbYK97L+E8LPltB9Rr1x3cW1
	 XzMdGlij5FksavPyG6O/LXVsjsDglTaLIbc4T0WLnEi4acwuIy6S3gOZKaPNVpvW7i
	 Sq2kfn0i+4YyA==
Date: Mon, 29 Jan 2024 19:54:08 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 6/6] mlxsw: Use refcount_t for reference counting
Message-ID: <20240129195408.GQ401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <4ffc173920a7b0780dee4f5af91e0d44d0b898f3.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffc173920a7b0780dee4f5af91e0d44d0b898f3.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:31PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> mlxsw driver uses 'unsigned int' for reference counters in several
> structures. Instead, use refcount_t type which allows us to catch overflow
> and underflow issues. Change the type of the counters and use the
> appropriate API.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


