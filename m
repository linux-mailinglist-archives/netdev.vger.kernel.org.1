Return-Path: <netdev+bounces-80931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E30881B93
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4545FB2135D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36412B641;
	Thu, 21 Mar 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feTiWOad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074736FB9;
	Thu, 21 Mar 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992284; cv=none; b=VTCGkrpj3viDPaa8ZPfpF+199DauzLvJ/4Pw72rILFh3RFmYD2oivXOdDG2omhHXMLPqTLFBCtDBazWHp3k/inOPYFfUeSYS5USip0m4OUo4k3CPV4gLnPt9v1/7+K5e96XYRAvyMssOZYoo+N5JTUtJHYLTaZgujPY6Gf2vJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992284; c=relaxed/simple;
	bh=Fas2GPcJqSFKc4TRosyOnXTJyUpVpqqdoA8FKsHNKkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2TgVwHavW4s4ObEbGTzLYgqhL6a06gNe6pYp5ef41Mz6/JCsNuFH7gIgad7q7LDIVVM9PKFNPJA4Kx6VwEEia0jn3KeHDvKtuUQ/Pzb2J7H1fDiC/g+9GA/wrOkKGmH8DQF/JIxwXXjcddCQ4JFpvZU8CvSDVXmdRLAwrDrhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feTiWOad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F379C433C7;
	Thu, 21 Mar 2024 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992283;
	bh=Fas2GPcJqSFKc4TRosyOnXTJyUpVpqqdoA8FKsHNKkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feTiWOadsvmjA6vBTMbtF62EasYWdZd9ARTvh9kiSSi9JdbveqtIHAiu8v9rJeaqF
	 9c5GXMIaQvEl4WHgilK+lCphWPmlHADTKkWROZk/tLT9bYk8SXz8M8a9RvpGL+SLZk
	 htGF3LJZhjDiHWNRO8WAFqyecAct5WO1VuZucheNZqRVWKg6Ve5dSbNSqUtSl34mNQ
	 xH/gea+MYw+DQ3anCel4k5mim9kW5Sen4m1boLtrlBuFlwI0Rhw5C5pzdOYIi9fagh
	 coJTutsn1kz9p2f+bsJTx5nBpg67du+EvjHc6o1dkM0MHOHAbZaL9iW3x3l6VoKEv1
	 XRVQTvMKEVLxQ==
Date: Wed, 20 Mar 2024 20:38:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric  Dumazet <edumazet@google.com>,
 "Michael  S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <20240320203801.5950fb1d@kernel.org>
In-Reply-To: <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
	<Zfgq8k2Q-olYWiuw@nanopsycho>
	<1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
	<ZfgxSug4sekWGyNd@nanopsycho>
	<316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
	<1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 16:04:21 +0800 Xuan Zhuo wrote:
> I have a question regarding the workflow for feature discussions. If we
> consistently engage in discussions about a particular feature, this may result
> in the submission of multiple patch sets. In light of this, should we modify the
> usage of "PATCH" or "RFC" in our submissions depending on whether the merge
> window is open or closed? This causes the title of our patch sets to keep
> changing.

Is switching between RFC and PATCH causing issues?
Should be a simple modification to the git format-patch argument.
But perhaps your workload is different than mine.

The merge window is only 2 weeks every 10 weeks, it's not changing
often, I don't think.

