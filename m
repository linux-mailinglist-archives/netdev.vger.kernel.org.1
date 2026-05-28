Return-Path: <netdev+bounces-292858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD0BNoa7GGoOmwgAu9opvQ
	(envelope-from <netdev+bounces-292858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1485FAB85
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 257173011E88
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A1363C6F;
	Thu, 28 May 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZwU5P5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DC34041D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005761; cv=none; b=DU5w06IgUPuqEo6qmJEKRl0QUEnvBgihrAZPc/vUrSnkgAZn5ul1acxZt6YkeG/cu/HIuVSweoBO98qjxJzX28pLDl5xieewMm2Qo8BdH4gbYLHAFLz17N1ChU1Vg9PyoT+X9KdewnO5iqUk94Rg9R4cTmrPN8zscoaDBeaEivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005761; c=relaxed/simple;
	bh=LdY5w1w9JKQhpaZBSyVUr8rGqdk+R+saAIJWzDuNvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8qgJZUGsUAX/YsMJ3DgPMU4owvFiGjhzRUHtgUcucLgy7j1AMQxNDyGs25/JZqergLoSeg1PIgjdUHoCgmOdQ2/dguvLUVXY8vgw72G8Xrki6cz7vq3XglS0p2sHHEGDlooWXqJrDF1PWCjuyQuzpIuLJ5cei9kDRYMbxU+2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZwU5P5p; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8173b2af32so10093226a12.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005759; x=1780610559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=jZwU5P5p3FTmdDG+AARv7m1FxkGzt/xkXiN6mu9dlBJJ+wYiJUBE4ZX4bILYM7+Rhj
         gGdZ0fezVJqD7hPQGNyiGQc3C+z7jjK0/LB1Lxw/1fHUR6V9W7gzk1zTmmSswrZcVFmn
         iFJDu5MAd61uo5ATATVm0eV2eojLn1fJ1RdQG9H5vFLvl/lcCcFlOz9XPAnIA0oAr0Op
         Z56mScARGdAwb5wZDzrSNHofRBGuYMQETy/8TlQbOX+MkyimBIDptf7i36rSKCy2v31r
         6A2xIrDD7GOt0/82jKQE/XCWEKMrqSMcdahg7erlbjTZO5UivapaP3wkzMDC2bsIoHAi
         W3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005759; x=1780610559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=mJsa0ARdvCT5r4ifztaUsQ+ORvdGX3IIUcmvygT6XVFfWhT3GQgGIcnpgGZ1UaxQ2I
         3LaeIFYEImECv9nEMBw/JzzcEDii1Cp8A6dnnjK7vL9mXN4hcxBhWNjD9vGso9dfzFbO
         RmoODEOlYGLQ4vB1A6obpW7jnNy6r8cmXSAMEH8YaqaMlYHHDhGMU2RVtTyfKCwdUuLa
         I2FFmfKGRN0l7HuOkjvWRLGMNuZCJ5ea2r8lr0EPbd2jLSp8HUOlKWgvwkn7vJeNHSJf
         7mTrXO1KWFSt9Y2dFRnoN4Ga5YRqR3cIhBkojhMMP5D0sS0kDZyjKZhFFwDQ/XX3GQ0U
         L2/A==
X-Forwarded-Encrypted: i=1; AFNElJ8PJnEsOnWKlohqmjLUzl4TLQBvzPc38xRnyuR0j4TLC3J/WB55ajrUkbrHKGXLQr20itRIfgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4G+ehwNEAToxP/Wy3M8c+oR63YYgNsEM2YCVPkXt58ejSFqAL
	fYVaYMU11LBqXcZdh3m1GfNRUzutRGGrLy1R7/qYq7hgB07CkoMBcxoCotYiavzULQ==
X-Gm-Gg: Acq92OEZEtRUjIGoNeSBsAv9zlpxMTNFqPJVPKySecd6QYwTCiWpGSkCnplwoWilLss
	5h8UIlQoanNAsr/EJm2EvzmpVkx55Nm0NgGuHfKrt1rOhcXaGG0jAW/DVP+SWF1d8uPu/uzvYN3
	dtU/VfZ3BsUa7IJL3WBBA2zpsz1z8TqT2ezOXjnBa11pluKt1TPTFV7g63wu6v5xKas++GRCJcv
	2r7Ipb/ftjumq/g03hVQDfu4TfKB0K1DdcUH9VB1F4tw4pFUXQEgCLRD4zFg6EIU0cgOsfVHL3g
	tX5oT+BvVpRIsj6b6R/9O6HSUn6MKN1zFsi//AV9WwiX9nbowMxIZwJoZTkuOEmQXtzTqJhmYwv
	43H+CBhIE0SKZz47ruLepq47cplZPxxqbt+4bSY6EQ2upwR5b/kwcmeluuwNrZherNPuuYnaHct
	xgwmfpdJE8GLWF9hCLxoKv/AZpFtYzch7auNfaRdalxGBYLPGMl4yi8AZTTBOuLuisFp7FAAvv
X-Received: by 2002:a05:6a21:648f:b0:39b:9644:6e94 with SMTP id adf61e73a8af0-3b40e32b279mr628896637.9.1780005758951;
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85759af1f5sm31047a12.11.2026.05.28.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Date: Thu, 28 May 2026 22:02:35 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 08/11] vfio: selftests: Add dev_dbg
Message-ID: <ahi7e1MEoHwk-rtF@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292858-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A1485FAB85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>

