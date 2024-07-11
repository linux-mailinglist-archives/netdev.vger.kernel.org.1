Return-Path: <netdev+bounces-110970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182B92F283
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7CE1F2289F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECE14B061;
	Thu, 11 Jul 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7nJXiQL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E44F1E2
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739777; cv=none; b=fGy0gteq2JyhrkL6amWIKK+KsJgWB0O8tzyfsGgMdnV7t1FaCLR2rZUET9aVxGwGLbY3m3RlLzXIkrI6fyBsJjycaGhHXcTMfCpU8S6qIeD9fHEB69ER/EIJ5pwCCapJjvUo6nblhWvSbtXPW/otpgYRugZb2wlGJnEkPn4QezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739777; c=relaxed/simple;
	bh=/G5jebomNoSeuOtYnQw1FhFYniU7G76DtNIt1eKT6tE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRmeqKTLoV9iqZczHqYczlJFC2M2x/KAMetuwzcoqzW1uDXTMNlN4aZvodTP/2bZDpYm1Pg7wPgxNEYbCaaCh8IUmqrylpZb27t3IgczKef1ZdOjlT6znIVhHiQMyetp4VZALkw58QDdynikmDmnnWG311gZJpVBgavfuSqCdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7nJXiQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A06CC116B1;
	Thu, 11 Jul 2024 23:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720739776;
	bh=/G5jebomNoSeuOtYnQw1FhFYniU7G76DtNIt1eKT6tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7nJXiQLhvvgk1nT0wj2QTfjO2osO/fCUD3XWtLB1g3FW6YZTFJh7s9HEVMC2eDou
	 +smTbz2Pw5KenXOPT0zKOptkDq7JCWqhEZBUKLdovGMb9bYO88hl3a4DRgvm6wiHsl
	 9Frnx9yd7hBjlREUkneCrBzGaibGDOCPEomCGeKWU4MLdDc4Xc6WFL0jsTJ+pmRvLe
	 1ip+QYcXyBYGN8QZhsBFOiA7+k4DpK7XDbYXiAuQTGaC9pXrNaV9RX8ovuK8CrM70H
	 /7f7sRosWYxYA/qeaz1OyWCNcXCynzQagOJvsJXSIZZGjSmcbhf2wyuAeVRQm6kG0a
	 Sn7Sga3Ee5LGg==
Date: Thu, 11 Jul 2024 16:16:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, rrameshbabu@nvidia.com,
 saeedm@nvidia.com, yuehaibing@huawei.com, horms@kernel.org,
 jacob.e.keller@intel.com, afaris@nvidia.com
Subject: Re: [PATCH net-next v2] eth: mlx5: expose NETIF_F_NTUPLE when ARFS
 is compiled out
Message-ID: <20240711161615.123a5008@kernel.org>
In-Reply-To: <ZpBlOWzyihXUad_V@x130>
References: <20240711223722.297676-1-kuba@kernel.org>
	<ZpBlOWzyihXUad_V@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 16:05:29 -0700 Saeed Mahameed wrote:
> >+#if IS_ENABLED(CONFIG_MLX5_EN_ARFS)
> > 		netdev->hw_features	 |= NETIF_F_NTUPLE;
> >+#elif IS_ENABLED(CONFIG_MLX5_EN_RXNFC)
> >+		netdev->features	 |= NETIF_F_NTUPLE;  
> 
> Why default ON when RXNFC and OFF when ARFS ?
> Default should be off always, and this needs to be advertised in 
> hw_features in both cases.
> 
> I think this should be
> #if IS_ENABLED(ARFS) || IS_ENABLED(RXFNC)
> 	netdev->hw_features |= NTUPLE;

That's what I thought, but on reflection since the filters can be
added, and disable doesn't actually do anything - "fixed on" started
to sound more appropriate. The additional "[fixed]" could also be useful
for troubleshooting, to signal that this is a different situation than
ARFS=y. No hard preference tho.

> Otherwise LGTM
> 
> Acked-by: Saeed Mahameed <saeedm@nvidia.com>

Thanks!

