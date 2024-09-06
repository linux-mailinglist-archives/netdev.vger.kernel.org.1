Return-Path: <netdev+bounces-125967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1196F725
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9109287097
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC181D1F6D;
	Fri,  6 Sep 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgkV9XcH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC91D0DD6
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633752; cv=none; b=FjQ+H8S0eONSjpJCPoRECjixupJLGPJfQYxDDMXHY4OdOqsnAMWiGq0kEj0WTAy/P3gCF0Dc4Ihd0eM++EErLXnOIaSPi1K1OVxe+FAGsh/smMmOv5Oup+4hg9QW/KF1aho08KIof/BfSx0hqY64H8mElP35hV4zTXziRpiMRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633752; c=relaxed/simple;
	bh=1CxWoaiW0pTjEkHq6N+3x8ZoSssTOadf/5sodzwdK3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAvIbj6NswmqxAJ5uPEwzNw5cIQFU8l+1FcJZC3rCEK5q7RNGYDRA0rD02qDUjeF0QqbmLXuDAN7Y8JBtcV8KsytyVIkZRk8ptRkr2PV/EKKGuwFrJDnEmSDR9x2xUg2DW5B0N1HCzqhYWRXp+VJmp3hBaV1boQxaMsj+Tw8uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgkV9XcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C69CC4CECB;
	Fri,  6 Sep 2024 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725633749;
	bh=1CxWoaiW0pTjEkHq6N+3x8ZoSssTOadf/5sodzwdK3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgkV9XcHzpu7fZPLX5KGoeXDPWb0Dj2eOrUXk4iobMW+fhB2wHV9hMLMaz9emZmpU
	 lcK3Mor+uHdQo4BASvsjvu3CddkJOFR9JH7SIFIVLZco0NDsBO3g20rDs/NkhS+xFy
	 t0aoyAhrDGclUAp17yR1iiSe7jTGNq7qQFapr9C9vnoTM6bMUjZLQu5ztyq0K7uz0C
	 sluGHoinbG5kUJjIaG4Ad/+pGzu4zQyfAGpjXxOa2wK4sf48OLIvOTu9RhdAy4Sz0q
	 YfAuX+EoKKRb4epHfKszVy9FoxuOop85GSuJDhmMyvexYu8cZtSzxzKV/qbpcg+9ib
	 DOQQM7nN6zJCA==
Date: Fri, 6 Sep 2024 07:42:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
Message-ID: <20240906074228.0c783fdb@kernel.org>
In-Reply-To: <8ba551da-3626-4505-bdf2-fa617d4ad66b@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
	<20240904183329.5c186909@kernel.org>
	<8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
	<20240905182521.2f9f4c1c@kernel.org>
	<8ba551da-3626-4505-bdf2-fa617d4ad66b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 16:25:25 +0200 Paolo Abeni wrote:
> I think the code should be more clear, let me try to share it ASAP (or 
> please block me soon ;)

No block, AFAIU - sounds great.

