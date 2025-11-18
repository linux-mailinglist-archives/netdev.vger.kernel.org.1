Return-Path: <netdev+bounces-239615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08528C6A422
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EAB5348D3D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451F2FE57F;
	Tue, 18 Nov 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mLBaKvMV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADA262FFC;
	Tue, 18 Nov 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478926; cv=none; b=TXU6HrPWp6zS0NhZNItl22adN0yrMhnmAqIOmpmHn1dId/d4Dq6xFAFQ2L2e4qB5dal/z400qmXB+IFVfz+ub7K+7wOwFkAg8CBiikH9r+laSWARErKPx2QaIny32nIInz85hzJA38/fvyI4HMPpOMGr9rtsoowBK/MkE3Cpc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478926; c=relaxed/simple;
	bh=Bxa5uPy/onStueFECgqqt2eLFDwOuOUW4bi0pyltq6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPMDtu6Pes0GO7ljBmxDf/xMej+fhNObhnOBOdz7L6DlNMk0MJPOt9gZUi/cstn/M6swbE/6FG5vea9VtOthe/xcV+W3ggz71tznUgg/MB4DMFTrRzqJkjOmgKq2yJlzp88u1jI7AytJKV9E5cuG8DG7RhAFDfRudCLb1kVrZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mLBaKvMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49147C116D0;
	Tue, 18 Nov 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mLBaKvMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763478922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbAhqR2bQcN8n5/ymmN0Zw/Y0Cr2VE9MOF8Vh0XJR8s=;
	b=mLBaKvMV0zTlJFwnVA6NU/3C5pCDAL2JtXc2ZP9LW7KPMTBEYo7FD1NBba/siCs/5YJ82k
	l5NJXjeYf5Y1Jy/XqA7ycUBulOcYcJ52/bD6ucm78+fbRsj48McqfSp4bpCof8z1Wor+WH
	TJsOqTsi451kM2VOeIh7W1U2zFWgtJs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 901a31c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 15:15:22 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:15:20 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
Message-ID: <aRyNiLGTbUfjNWCa@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105183223.89913-12-ast@fiberby.net>

On Wed, Nov 05, 2025 at 06:32:20PM +0000, Asbjørn Sloth Tønnesen wrote:
>  drivers/net/wireguard/netlink_gen.c | 77 +++++++++++++++++++++++++++++
>  drivers/net/wireguard/netlink_gen.h | 29 +++++++++++
>  create mode 100644 drivers/net/wireguard/netlink_gen.c
>  create mode 100644 drivers/net/wireguard/netlink_gen.h
> +#include "netlink_gen.h"
> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/wireguard.yaml */
> +/* YNL-GEN kernel source */

Similar to what's happening in the tools/ynl/samples build system,
instead of statically generating this, can you have this be generated at
build time, and placed into a generated/ folder that doesn't get checked
into git? I don't see the purpose of having to manually keep this in
check?

(And if for some reason, you refuse to do that, it'd be very nice if the
 DO NOT EDIT header of the file also had the command that generated it,
 in case I need to regenerate it later and can't remember how it was
 done, because I didn't do it the first time, etc. Go's generated files
 usually follow this pattern.

 But anyway, I think I'd prefer, if it's possible, to just have this
 generated at compile time.)

Jason

