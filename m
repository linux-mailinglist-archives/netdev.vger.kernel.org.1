Return-Path: <netdev+bounces-169529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60AA44646
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C249166907
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A6191F88;
	Tue, 25 Feb 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IiYinB/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF518B475
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501311; cv=none; b=m2LyyIgMu2/SsEz4Vgq39fFOt+0Rzq+TDxYk+sq0x+n1Myfo4Im0jNvI2574tFw5uG6StsD9glBNSf5ACkEsMteamTHomdTejJhMzKQX64sbIN/895l7a9KyLlRoq/eT0M73aoG42XntCrML+EGlsZY2vwUhRsZUwW2ywJIwQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501311; c=relaxed/simple;
	bh=jem3zFrU3iVsgiinhnBrVus3W9ZGzYLT1GZLC3giy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2YKdeubvMiRTaGcQMvh9Sy2LB1nihkQNwoytq+jpSBhZAKGTHHyJgS/Sqkj9tB6b86kPLrPPlNrKiGz780U/MF029hSK0vf5hE3eSCealB20XlOVcuXRneuXClADvLmBNL7CztkR6VjVA7M7FY2ntSbgEAGPg2WqLkFEw2xZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IiYinB/o; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c22ac6d856so246840885a.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740501308; x=1741106108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cWhMg8zrgaEeASgPaC492tuyAY/j8k61hn8EbblVbM=;
        b=IiYinB/ovJLyGuAOFS3hgSAQl/v+Kj64gGUbmJtkegMdNA7Zh/ki9IFSOJOT2w/6Jq
         nhbuX81s8r0AyOtgO277EVEcnDFoe5cxtjr98QeIdmkhbX6e5VYPYkCJ/r/LpZJp67w4
         woLO/ByOxAEoDV86LvxtWNJU73eo0kjNCC4PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501308; x=1741106108;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cWhMg8zrgaEeASgPaC492tuyAY/j8k61hn8EbblVbM=;
        b=YgKltIKDMDaZG5bPukWDKEckteUr6AFdOwgdXnV/yf8MIIieeY4B+2TukbiM2Nnkg2
         NplIpVTQxsKTm6bfdIhOuUy3N+PUn6N/Sl0go1Duwcw8oCLPUpvp7qj5k4MS0di0OsbM
         +XheS/AiwJHcds7aUQvu43PHOlPjE6LF1o9uumoOFQRQTdq26rFtHm4WUv0IpsHFJQLd
         P4SWC7LV1MW2ONw7Nlhgd1g+LgfP22EV+DThBq/V9gUHwEEvSESKadP0fELo52chhaY8
         fE73HeIBSg1WNScvtNMKRnb2liT9bp2Cxj3dCKE3YGiR4yzRqRdLnSMc5PPvmzHexT3A
         2yVA==
X-Forwarded-Encrypted: i=1; AJvYcCX2OHOq4HY2RAPaFqCA0HRiNHHwbyOqwBK5yzcPvMXqubttGU95ywiqQ9/zLdDk4LzPLXRSwG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsfLa71ljUpJjdFDFub7rDYbhmasV9SvTc/eIyc/mgd/OyF6H
	bySIhdI+mYbBKXGXjb5i0uACa2uYANstiLOonUiB8usRPUFmI9fH75HhCV9whdo=
X-Gm-Gg: ASbGncvE6QBRQeDPG1A8oLZkeXD6/b1+96uT2G3OpU7comhBYsmyglMjBeX+Sjhoiux
	59hEYKLfFvd4/yXvVSgW0bFtvL1fIRg1npyYJPZBoPntWaDjtdNpbOk9W3gUgZADgO65ZzCXuUz
	f7MMgTc8jYL0wdVm8BmAiZYZwEC5YBoeFMMZUAAHrMt3GGfhedL0Y2LOEvyVZXUP3VcuFgY6dWO
	/+JKTG46ch6Yke3jyx3tfPpHphBzASkokgT1MIBkZST8Kw5tK3Z5ImTZ9THTfdNYp43SBHUL/Sf
	MCAKxoeRAmTvnFQjpGQngnMkiKBOOCXFloTEebzVTfgHOSA/GproWaliVVLJIhZX
X-Google-Smtp-Source: AGHT+IGgDvy4xoDzig5kXJxe/3Fu+Tdps3+mFFwNS++FrVKpndvMvxqHL1EZ7SqClO+KATO6q7p1LA==
X-Received: by 2002:a05:620a:2405:b0:7c0:88e6:f76c with SMTP id af79cd13be357-7c0cef6da4fmr2613205185a.51.1740501308330;
        Tue, 25 Feb 2025 08:35:08 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33d06bsm123899685a.110.2025.02.25.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:35:07 -0800 (PST)
Date: Tue, 25 Feb 2025 11:35:05 -0500
From: Joe Damato <jdamato@fastly.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
Message-ID: <Z73xOUPuGL7jvyV5@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225071348.509432-1-gal@nvidia.com>

On Tue, Feb 25, 2025 at 09:13:48AM +0200, Gal Pressman wrote:
> Context 0 (default context) always exists, there is no need to check
> whether it exists or not when adding a flow steering rule.
> 
> The existing check fails when creating a flow steering rule for context
> 0 as it is not stored in the rss_ctx xarray.
> 
> For example:
> $ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
> rmgr: Cannot insert RX class rule: Invalid argument
> Cannot insert classification rule
> 
> Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/ethtool/ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

I was initially confused why
tools/testing/selftests/drivers/net/hw/rss_ctx.py didn't catch this
bug, but if I'm reading the tests there correctly it doesn't test
this case AFAICT.

Do you think it's worth adding a test for this case as a separate
patch to net-next ?

That said, since context 0 isn't tracked in rss_ctx, the fix makes
sense to me:

Reviewed-by: Joe Damato <jdamato@fastly.com>

