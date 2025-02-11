Return-Path: <netdev+bounces-165112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D740A307F0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4093A7340
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99721F2C35;
	Tue, 11 Feb 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDz3IABY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F61F2BB0;
	Tue, 11 Feb 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268312; cv=none; b=HZvsq39JNVpwKrENA11NzKPlNH/i3FzwY0xk2we9lVWXJdot5WNTUqGX+uXBAyggDWuC7drzOb8kMadgzTDZF7zl1Y0u7t4jgAk8f+sKXE4VQCvcIYOZ8/jnJYrZWrIjaD3kAN91WwzL1d+GF3utEifPv76kKZy7duvGqS+W024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268312; c=relaxed/simple;
	bh=16KN1Mp7otYAOTGe8F70UjNoHgS3ex+64eqSdYJYwmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WINIjRxRNHvwzFaNir5iXc6HCyNUnOzsCPVe8xa2uj7nD20Btm63+UjpfDDHa21wqEPiBKIuYMOcCWLJwmA3201flLsr8ZvAZkQjeRxw80vzUWpCbiDbhDe+LEXzxiH1DXziOcP89hqBBFzVioU0Sc573yIbwMFc3FNsocqm0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDz3IABY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626AAC4CEDD;
	Tue, 11 Feb 2025 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268312;
	bh=16KN1Mp7otYAOTGe8F70UjNoHgS3ex+64eqSdYJYwmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDz3IABYScaHlSV+3mrN5zdijNEVvEaa2+pGfiTkoej9kljC4nGeQHRG7e3im7mcT
	 +CXHcLyAgjNXu4ZcwsHSV4sBnVbU3pMMF6zT66WFZ4k+t/T4bTyggLuH24cjAfzNlv
	 UnQXgo2DSlLS/jxcO4gn+oeAUoI/8dWAhBDG4CXYg0TYZjHRGmRoLRTBTauQbWPXOU
	 CJAcPxrGHBab+uEq4syNJajlHlvBwO06O833eBPIDPlO43bZtO22zUkKNwse4hFXxs
	 o6Ns0VeGVJif2wdEWF6q+nXkJgjNfPamUtVyeYYmlPaXjTWn2VoPdWwD4BSY9KTWtk
	 o84aDpcmuRxfw==
Date: Tue, 11 Feb 2025 10:05:07 +0000
From: Simon Horman <horms@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v8 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
Message-ID: <20250211100507.GH554665@kernel.org>
References: <20250207110836.2407224-1-yuyanghuang@google.com>
 <20250207110836.2407224-2-yuyanghuang@google.com>
 <20250210161306.GE554665@kernel.org>
 <CADXeF1GP24uJNYBPjjegs=sycUa1d=cVacvchKdAk5+p=ZOj8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1GP24uJNYBPjjegs=sycUa1d=cVacvchKdAk5+p=ZOj8w@mail.gmail.com>

On Mon, Feb 10, 2025 at 09:43:03PM -0800, Yuyang Huang wrote:
> >FWIIW I think that the YAML spec entry is distinct from, although a
> >dependency of, adding the test. I would put it in a separate patch.
> 
> Thanks for the feedback! I will split the change into two patches in
> the next submission.

Thanks,

After sleeping on this I realise that this is really only a very
minor process issue. And as we are already on v8, after mostly
minor revisions to get there, I think this patchset can be accepted
as-is after all.

So no action required by you at this time.


