Return-Path: <netdev+bounces-108976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAB9266AA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE298B24FE1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D898183097;
	Wed,  3 Jul 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3HpRYMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E7170836;
	Wed,  3 Jul 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026172; cv=none; b=NVqTMQU/y9g6s/zn6w03d+zKPLVSQ/5BW/IMIa+39N8vV7twFTvgAOXAe+1AdhIBDvy6VDGP9ITrNdYIe7207waitdmm4wHFWed5B1oiEs8Eew9ChKyQRjRsqkL3YDaOPhKrNCkdPfWXw5cbfP9cYr2sURCPBMz6TEH4v2Ob2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026172; c=relaxed/simple;
	bh=SrvA4IrCK/VWJUq1TM3J3A5R5QWOynrx31KhbgXIta4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXzhhexssL0scMx4Asuy9gN0HTd7iLbnrugaphj90sCmN968nyHRHFiCFkv1th5kvQawTx5KOPpi0BUcB5XkhWI8UT1MD2yVEACPR3dZ7T3tgXzhN0/DfYp6DshkAXFI3eML+g0K88xw9PsYU2EUAdIXpEEMjBNfDCdLeeGB/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3HpRYMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD6C2BD10;
	Wed,  3 Jul 2024 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026172;
	bh=SrvA4IrCK/VWJUq1TM3J3A5R5QWOynrx31KhbgXIta4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3HpRYMZ97RUPyQUiVEpfcLE6747vg58zP0k9keuS/a+J6+n70x2tKPej8CIZ3CeE
	 H/2FNC0es57StZs6jmzFOQYC/nrwNhW0f+3xK94FrC0ZRgGCz7BNQ9ZBlQSEt5DVph
	 5kIt5dzv7RWJTZAWUgwkZJmP0uYYjFuQtEi5hTcXUZ0sLee7BZ9V5O0H0NZANYod9H
	 /h5pBrBf67JLgCgQBUuFZ8gnGAYhqCs82Kc7x3gDFWD4GHQLAja9Y7zJr/0IdyeX2f
	 57TO74bg+iNBHREAEHHCFLknj80I2UVPX4RZfOl2ROfaGTrYZNEXQxybZ/qriOgFj9
	 sdZ/oA5C8Ni9A==
Date: Wed, 3 Jul 2024 18:02:47 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240703170247.GZ598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-8-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-8-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:57PM +0800, Justin Lai wrote:
> Implement rx_handler to read the information of the rx descriptor,
> thereby checking the packet accordingly and storing the packet
> in the socket buffer to complete the reception of the packet.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


