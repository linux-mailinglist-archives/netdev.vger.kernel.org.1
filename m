Return-Path: <netdev+bounces-66861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3A8413C8
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BC1F23BA1
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79967758;
	Mon, 29 Jan 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6zs8tor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B076F074
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558000; cv=none; b=lH+Mz0aWsd14mskF1C34RAsuJ2ZOyHVCRDGyaBFG8KmnsfvMl38w5VwtLs2m+rZ41Cp9Vn/FjNhCevNhUFNClLfJLp0qUctBirOLmNjbLnyLkHOAkhNjriCw/fC+wXitnr5P372a3Jfmt7rY1hO1I/cdeeL3c4kOoivpq8XKrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558000; c=relaxed/simple;
	bh=6stNTfqgnPm2dRSvcOsAkSOcH9wxnTjJ5aHA9bmrHHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug4wrUf2fPihEq+J0BSeo7vQnaK1vUrBouk7CauJZpj6gt/cBjwdOpu22L0arw2dAjbc7/cEQq9eucZU1q+sQJx9BFMhXGed3wcZzIUiPY26DXkGvQChzF4r+WOEK6IP4BZ+x6XNYTST5EGrObhLivQyeoWJnQ/fKGu6u9JEQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6zs8tor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70377C433C7;
	Mon, 29 Jan 2024 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558000;
	bh=6stNTfqgnPm2dRSvcOsAkSOcH9wxnTjJ5aHA9bmrHHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6zs8torS/ABJVrYUNyU1fXixTRCDLNz3A8N8Y5Nw6KbbCVKDNDem2bzsrhiqi2VT
	 P2RABNajCzjKW7nJD89Nmw58Vhj8NnlRHhUFw0zJ586fu7EUF49HcXP81wWzYuM6M6
	 sL8VHn2rdH/TOkU9g4J2Tq8nsAV67KDlLoC/5SsZc7gtDJ7RWwreB8Bfe6k4x8qA+G
	 RH98036GGwyaZKMIBbkrNRLOt4Coouctw3KXxfF7WjmOOJlda5ITL9z0J7ziUVDj6T
	 RPKC8d+g3nQdsNAzB4Oq4Xu7yEsEZf0lA1f2bDzHYbVsKP2Y1btyt715Vm+lc8Hyl9
	 hwUF3CojnkJVw==
Date: Mon, 29 Jan 2024 19:53:15 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 3/6] mlxsw: spectrum: Query max_lag once
Message-ID: <20240129195315.GN401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <5bfdfa5f8df8ef0211649f08d508b631d104d214.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfdfa5f8df8ef0211649f08d508b631d104d214.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:28PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The maximum number of LAGs is queried from core several times. It is
> used to allocate LAG array, and then to iterate over it. In addition, it
> is used for PGT initialization. To simplify the code, instead of
> querying it several times, store the value as part of 'mlxsw_sp' and use
> it.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


