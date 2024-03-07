Return-Path: <netdev+bounces-78466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17B8753BC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443011C20CCF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40612F58A;
	Thu,  7 Mar 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIyKWD5m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8412E1FE
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827097; cv=none; b=cAxOGANPQZ8PVGFFEY05irg+xhtdrSh5pwJBlyf0sgRUlXQqY+RuHXRDKOXmAe8TfkOIHRBzTTtiOTrP8uVLPsAYSpW58CgK3s4LFVLyStE3ojMg6WmP1UKZH/VORrpkdk1HadcQ4RxyDei4BxxwbDEM5UIXL+bXemqmKJbjhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827097; c=relaxed/simple;
	bh=epkNlpKq1S586RWc4305Yks9J3e+30OcDLtQjEOccpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLKYvWvAhz5j6/ZRab5klgCqyvFhbxuQPLZbtngJDAcmWmtBZpso5TIQT4ARmsYMfJIthXTZrFFM/HBJ48f8BDSGTfHwNCOU9m6nq1LZFZc7HXFvC+irdNpwjd+83qyFNbzC7KfS5vwDwbm6QlaaFoJwKPHsUy5sxIuU4daFkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIyKWD5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D56C433C7;
	Thu,  7 Mar 2024 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827096;
	bh=epkNlpKq1S586RWc4305Yks9J3e+30OcDLtQjEOccpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIyKWD5mhJXu2PEDOSaxInCyaAE7ZpsnQ+nWwjK3PWgnLVDuQmtwKo6t8YeY8iO4T
	 jWSMbwvETCGSy7Uj1wxXLXlJwHnf073Q1teoCXJSCllQdV1WMpa/3B3rHqenU4ikUS
	 Rrn4U+DHr9ZdaoMTMyjyiSOI7e7WQL7DKJdupzKpyWJqHGsEJmJLww8S5R8Z4PTpzk
	 5EPEf4frJ+PPZx9TASTHGX6tZUU/+/ZQz0YTdJOD+0iQliGlzRjpWx/NEOZ1YtST6A
	 lLGUuS3HsU//29pHugHOBQRoBYRBlUM7YV77C+uf+OtitBniZtg0QPVBOmyN9D1W/r
	 GK783lSc+urHA==
Date: Thu, 7 Mar 2024 07:58:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Breno Leitao
 <leitao@debian.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors
 without stacktrace
Message-ID: <20240307075815.19641934@kernel.org>
In-Reply-To: <CAD4GDZyvvSPV_-nZsB1rUb1wK6i-Z_DuK=PPLP4BTnfC1CLz3Q@mail.gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
	<20240306231046.97158-3-donald.hunter@gmail.com>
	<ZemJZPySuUyGlMTu@gmail.com>
	<CAD4GDZyvvSPV_-nZsB1rUb1wK6i-Z_DuK=PPLP4BTnfC1CLz3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 11:56:59 +0000 Donald Hunter wrote:
> > Basically this is just hidding the stack, which may make it harder for
> > someone not used to the code to find the problem.
> >
> > Usually fatal exception is handled to make the error more meaningful,
> > i.e, better than just the exception message + stack. Hidding the stack
> > and exitting may make the error less meaningful.  
> 
> NlError is used to report a usage error reported by netlink as opposed
> to a fatal exception. My thinking here is that it is better UX to
> report netlink error responses without the stack trace precisely
> because they are not exceptional. An NlError is not ynl program
> breakage or subsystem breakage, it's e.g. nlctrl telling you that you
> requested an op that does not exist.

Right, I think the YNL library should still throw, but since this is
a case of "kernel gave us this specific error in response" the stack
trace adds relatively little for the CLI.

> > On a different topic, I am wondering if we want to add type hitting for
> > these python program. They make the review process easier, and the
> > development a bit more structured. (Maybe that is what we expect from
> > upcoming new python code in netdev?!)  
> 
> It's a good suggestion. I have never used python type hints so I'll
> need to learn about them. I defer to the netdev maintainers about
> whether this is something they want.

I'm far from a Python expert, so up to you :)
I used type hints a couple of times in the past, they are somewhat
useful, but didn't feel useful enough to bother. Happy for someone
else to do the work, tho :)

FWIW I reckon that trying to get the CLI ready for distro packaging 
may be higher prio. Apart from basic requirements to packaging python
code (I have no idea what they are), we should probably extend the
script to search some system paths? My thinking is that if someone
installs the CLI as an RPM, they should be able to use it like this:

 $ ynl-cli --family nlctrl \
	--do getfamily --json '{"family-name": "nlctrl"}'

the --family would be used instead of --spec and look for the exact
spec file in /usr/share/.../specs/ and probably also imply --no-schema,
since hopefully the schema is already validated during development,
and no point wasting time validating it on every user invocation.

WDYT?

