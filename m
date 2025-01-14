Return-Path: <netdev+bounces-157988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE6A0FFD3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 05:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A416232E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644502309AE;
	Tue, 14 Jan 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFSIVm5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324C46447;
	Tue, 14 Jan 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736827258; cv=none; b=Gnf46x/LbtT7NEQnkZ7xcvoSi45CJBugGa5nq7Ok1ROjQfSZEtLwSs0IjMMY8RjfPxcbQXXQ1/C0DsT9RhPlx/xbcJ4E734tPJ3wm2JOn945nV5RlATdVJg0bOJ3SSZ5T7mhiyNOfaTmUiCEQQfZOCwJbUo41g9YPqGTWVFTpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736827258; c=relaxed/simple;
	bh=8ALiiXYzwocaw4nQ8C4MZcDYRsuR1ClJQLWUpITfAbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlph+HLimT13LKUrw4zHgZl1ydybymwXqAVGF/zQHZvNg5MkMVUowIzeqdyz8ZJJn3OSPc+rLHEyDrWaZu6TFYo+z4E/bF2pc3PNkX2jZOx/qbhmMsxgEihnd10DN+OfzrYJe4F5w36Zcj9DKyTd0h+JYs46V4IJo4Z9kNKVkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFSIVm5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32FC4CEDF;
	Tue, 14 Jan 2025 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736827257;
	bh=8ALiiXYzwocaw4nQ8C4MZcDYRsuR1ClJQLWUpITfAbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFSIVm5MGTAw25NDZ0OdBFOuJ752Lqo91PxsfLazAWmAmG8AnOhFgYiTtRjFmOAqN
	 MrqaG/rQH+nMg3F7bLbvNhmEdHntXEfks5iMIJ9KGlgnRjhSXeN9+uCqCZNFq7Bv+6
	 G61dGMEHOw21jXAmRtrBra3UgZbCpaOiJUYZBrfwyfBk42j5g1CgeYgXQUFKGyTtaw
	 Jzx479HdkLCiNgcOb0OcwwkYNTaKhhlJt8TQBz5fPyJyklMeXc4I0VYGRidB0jWECe
	 oc51iNYSfh545RreYLoXsc+I2yyNE03Qtn2ScCL1gf1dddsi2VLIvvF43+3jFBAjrB
	 9aivWwRd2Y07g==
Date: Mon, 13 Jan 2025 20:00:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kalesh-anakkur.purayil@broadcom.com, linux@roeck-us.net,
 mohsin.bashr@gmail.com, jdelvare@suse.com, horms@kernel.org,
 suhui@nfschina.com, linux-kernel@vger.kernel.org,
 vadim.fedorenko@linux.dev, linux-hwmon@vger.kernel.org,
 sanmanpradhan@meta.com
Subject: Re: [PATCH net-next 2/3] eth: fbnic: hwmon: Add support for reading
 temperature and voltage sensors
Message-ID: <20250113200055.20d9c4f3@kernel.org>
In-Reply-To: <5252ffe7-56a7-4be7-9fdb-6d0b810ebfb5@lunn.ch>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
	<20250114000705.2081288-3-sanman.p211993@gmail.com>
	<5252ffe7-56a7-4be7-9fdb-6d0b810ebfb5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 02:19:08 +0100 Andrew Lunn wrote:
> > @@ -50,6 +50,10 @@ struct fbnic_fw_completion {
> >  	struct kref ref_count;
> >  	int result;
> >  	union {
> > +		struct {
> > +			s32 millivolts;
> > +			s32 millidegrees;
> > +		} tsene;
> >  	} u;
> >  };  
> 
> Why have a union which only has one member?

One member per command, the commit msg on patch 1 mentions:

  The data from the various response types will be added to 
  the "union u" by subsequent commits.

More commands are on the way. It's a coin toss whether it's better to
add the union later or have to re-indent already added structs.

