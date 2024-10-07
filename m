Return-Path: <netdev+bounces-132803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87229933A2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F271287FE8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B91D7E28;
	Mon,  7 Oct 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eFwaITMn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AEC1D1E8A
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319366; cv=none; b=meyl4wDzTZ2hAVj1mF/w36HLs0u7EMVWH5rGrp8+hJeMBn/iZ1P+yF9ss3Vd/W3ZArt000+SGdsqV2cl7eSGx+O7kCkqcwKVqMXjeix00sRiQ8ar1/fLRXkBYcE5c6lu9JbTrAzBCO0IGNyRGVVqG9NUAXZn7AJzzTmOiH0qWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319366; c=relaxed/simple;
	bh=OsFjrnHgCqteocAbZ0ZL286L+omyoHWMkj/C3qTonCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY4I/aN3NnQzPeQbCo80XepGV/1FKb9jDAm6oT7WGYb/aAvyU9p4hkdWFo4GWG+/4ZvBFYSiXkFsVj4uH/GOqgsnU6A8hea1srtYwKKkGaOpoH9EVT2Qgl1FopRPhDu7nxx5JgN3PhrsS8NPwwElD6c0CF+ivpbNRUyXTqaHKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eFwaITMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644B9C4CEC6;
	Mon,  7 Oct 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eFwaITMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728319363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsFjrnHgCqteocAbZ0ZL286L+omyoHWMkj/C3qTonCY=;
	b=eFwaITMnwUmkmR5Zf4HFCg1K49h2Cq/xEzjQSVJOQB1zv9Uof0qCy6oBGex6knaSZHKm6b
	XUEVEaSmKKznkNQjAW+l85zpvLMtqEri2XTyDQn8h83vcSerKYl/S4+AN3+XecDezjeZb6
	d2nA2fYxUBMgGiIEUK3V6NDECFO5l3o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 381477e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 16:42:43 +0000 (UTC)
Date: Mon, 7 Oct 2024 18:42:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, aspsk@isovalent.com, m@lambda.lt,
	netdev@vger.kernel.org, wireguard@lists.zx2c4.com
Subject: Re: [PATCH net-next v2] wireguard: Wire-up big tcp support
Message-ID: <ZwQPgbwio38LWqKS@zx2c4.com>
References: <20241004165518.120567-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004165518.120567-1-daniel@iogearbox.net>

Hi Daniel,

On Fri, Oct 04, 2024 at 06:55:18PM +0200, Daniel Borkmann wrote:
> Advertise GSO_MAX_SIZE as TSO max size in order support BIG TCP for wireguard.
> This helps to improve wireguard performance a bit when enabled as it allows
> wireguard to aggregate larger skbs in wg_packet_consume_data_done() via
> napi_gro_receive(), but also allows the stack to build larger skbs on xmit
> where the driver then segments them before encryption inside wg_xmit().

Thanks, I'll queue this up. Do you have any perf numbers on the speedup,
btw?

Jason

