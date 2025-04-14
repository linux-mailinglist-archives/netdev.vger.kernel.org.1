Return-Path: <netdev+bounces-182485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEBA88DB3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB61017712E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59C1DE3B5;
	Mon, 14 Apr 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QomymD2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962461C6FF3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665858; cv=none; b=Iy2oKwKYQ04OVXh3bGupczTLMRkTvuc85nx4cvdyXR1fWgeWJVKphOsWsdGM+qcGunAejAg92KCUGD5oP59ovqxynGdMYTZfHTYlCfsNPuI0JXzfLdyF28k2DXc8T2bWlqO2vYUPxemujSuaMVl8jYpW8b8q9+waCD9S5HiJvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665858; c=relaxed/simple;
	bh=phLluQepQHPpy0EycaYCH27m19SWuvJ+nWqWfx5X8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnFdharH9On/L9IwvmMCRZ8uAmqt8Lq/pu7CO/UXDiWDJNx4SQlLJQV9JwBjAAWxoP+dS6T0stbHqv5/PemSNTsiNHqE3RDIHTDTqQP7gTDGTX0bbms3NAQ2c27KD37h4LDLQcpWmp3xdXglw/ym/dDR5L4Qp6xpqSxkmQnhYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QomymD2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D76C4CEE5;
	Mon, 14 Apr 2025 21:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665858;
	bh=phLluQepQHPpy0EycaYCH27m19SWuvJ+nWqWfx5X8U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QomymD2NflLXn6n+Ej+dLHYQYjq00JJxInIa82Esu4RmCl+c2Se5wulE0GMrfekfw
	 m2I33reKH6w2YxelOk4+PxMArYdmTxPI6TSF3ldtB26D3Nj+UuN5HxkOWsaklvXsgD
	 QYpRCuG9Y3gAvc/quxUBFrplO2UN/w5zBSrEv442lVxGbIerkaKBW+CP1DI/m/bTFh
	 rvK6CPBnpI4f1M3zJ7LR8p8ObU10GMWq9aKfJNqesA8YabpRqwz64IGy8CGz7LJ99c
	 IyWR94QXpqQ6pwoVN75yts4t9B4i8lsGiqYccioiISAMm2UoyAP4YQTfXRbmtfX/CT
	 O41RLNXrcmMHw==
Date: Mon, 14 Apr 2025 14:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach
 too many actions
Message-ID: <20250414142416.7a4936d2@kernel.org>
In-Reply-To: <Z/14I68bvZRza6eB@pop-os.localdomain>
References: <20250409145523.164506-1-toke@redhat.com>
	<Z/aj8D1TRQBC7QtU@pop-os.localdomain>
	<20250409171016.57d7d4b7@kernel.org>
	<Z/14I68bvZRza6eB@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 14:03:31 -0700 Cong Wang wrote:
> > > I wonder ENOSPC is a better errno than EINVAL here?  
> > 
> > I think EINVAL is fine, it's the generic "netlink says no" error code. 
> > The string error should be clear enough.  
> 
> IMHO, EINVAL is abused (which is probably why we introduced extack). I
> prefer to find a better errno than EINVAL whenever possible.
>  
> Extack is available but it is mostly for human to read, not technically
> an API for programs to interpret.

How is user space going to interpret the error code here?
Seems to me that'd mean the user space is both aware of the limit 
and yet trying to send more actions.

