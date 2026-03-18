Return-Path: <netdev+bounces-269178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLr4K8YFu2kgeQIAu9opvQ
	(envelope-from <netdev+bounces-269178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:06:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E2C2C2574
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FD27301D4C5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0043F7E63;
	Wed, 18 Mar 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Rq0nm1U9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4D33D4E1
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864380; cv=none; b=C+q1trvMPuW2a+IJKHGIcHEntx4kk4MjKXFYyl8tO9KDOrwH3fa4WQMchAHT12C6jgVnEa1KpsPEi1E/UeZ6Aw7HJapoQ7grxUH5QmT8B+akrpqasULBDWLutZymP+00yoUPr3FRfaeWfA0b8sQCpyFqPOifJobXl+iA91ailzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864380; c=relaxed/simple;
	bh=KuPSmFfK/2b8A5e3jfwFssD+wIacjMZ+zJyp9NVt61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpSJIoqS3dcnva2w9kMtATxNUFfh1GaF44GtYULSA35ksvuvferqioIgyStjjXXapJusIHQ6AoMeGYIyrUdJKtpwRuZ/k9P0r/VBCU0/Eg2PzkxY7CjJPjcWU1+fNiRKQZ1GHCgn6fQMzjc9+6R2nAhyX8P8QUszfyuYdEcR5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Rq0nm1U9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so157268a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773864378; x=1774469178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp/L77L0/zotrZ2zU531gMdFREkU2AqJ3gHWhhi3kO0=;
        b=Rq0nm1U9JzBtUITIbriZvcTMUveTv+3CZCJvoK4Qu8ESJMcqi7BtIKhoeXOQzDsHaI
         lid9tVzJOjkaIzXJGBZ4QbT9WpwN0GsrZkqMqQ9UnAVWCaN2uH9U3BFKL5Vxt3FireeD
         3qha00R6mI5aUdhAwcPyhp0wmCo1qR81T4Jeog0VoPtku9uG2MUjZDoA5DiZAEyj6WTI
         bWH5inkMkAvGSUiRjYxI+D9V3W6kJhlsAGGIU0u+pkJNQbqY0iDIJ32u5ULKclvgMm5t
         E0CE5Hz3UXLq9gYls++n3UcfMhsDvhEhqfrA02K87rYePHDQsTpAAagma7Zy+tPHsNRk
         FODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864378; x=1774469178;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/L77L0/zotrZ2zU531gMdFREkU2AqJ3gHWhhi3kO0=;
        b=s5AGHiZvHxvCUXGidvqMh90q6sEySH27CKkNUskPIaTURu1E0pDCW5B3kA9zJSkR35
         5hTvQnqIjJo7kXOhObyk/slFFS1FimdXBhs39zYoYkG1yQO8BscmxaTWkmUdXd3riXEF
         wWeDeG2lSJHOwasmDosLxKF2kRZs/hqEBNZR7Ka+wBwiXXRwv8hvzH27suZPBnmiTubz
         NKvRiip2M2UGulaIeCZ2D6Ocj4s5u8xwRe4Fjk4XsUPRL+IeB14prEgEAlKDszmt9X6e
         fGyg4SawBJh1g73N0tVdCaVnChhQVSxY8fJcWPjMSyyZ2DSOJR4eSPAmnp8o3etIethj
         JTDw==
X-Forwarded-Encrypted: i=1; AJvYcCWKBXCrlLIdVHKgiwFR5h6/Q3j/nI2ozg35vfFM6x7nvWukVvDb6liQ1JbhZLId2kHhDTYhFE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIjjWpSRyIkNGCKlRazK5mX/oS1m1b9RDt2XU6CmfqtJkVgIv
	nljmhtzV0CbMHVEHUwydvXZttPQfCKTkwqahFEbRafVGNLFeeACY4BgsZ5nILSo3YxE=
X-Gm-Gg: ATEYQzxEBqrOWpbEIS3IhCrPq1OkhJQ/2fc/jCtjMUeB6h/HDnTG30JR7sJS0D0KieD
	vhDZvTYHf5n5TWTbw/11esKeCfroCnggcyi55Sh4a0T74ksE4autOYneQIPASWip+IkLI9xZAtl
	/hI5KUqSf5aDKZUvHtDOog1bdGJyWP/r9wBSRISLHW9QvPRRma0j35gDXzq5/6YfmGO73pRgviL
	6VKjcrLWywMuCbVLk3J6AZQUDe0e1bxHcDTW/F95g7pl4IStrhZXOHtXIrANkykm7hOVB50X4AV
	CDotXTkPoxhLZzqkeoQHhVfwS9RLll5m1CwTgOWl+8c/qwbPPEnUd3QYLRN2YrNC9yjHy3pPBaj
	s8CopPhNBgSQrkk7XZocQD4pYVrY5CqXTZTOa9b8U5ar4NPvF3p8sSUgf3pI8uvur3DZ6IWoKIA
	5UXwyD
X-Received: by 2002:a17:90b:2ec4:b0:35b:a7be:ae48 with SMTP id 98e67ed59e1d1-35bb9e5c4ebmr4159648a91.12.1773864378543;
        Wed, 18 Mar 2026 13:06:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc618be0fsm433703a91.0.2026.03.18.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:06:17 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:06:16 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Remove unused field in
 mlx5e_flow_steering struct
Message-ID: <absFuJ/Iuh4YUjrL@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20260317104548.15697-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317104548.15697-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 74E2C2C2574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:45:48PM +0200, Tariq Toukan wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Not used in mlx5e, clean it up.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>

