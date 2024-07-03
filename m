Return-Path: <netdev+bounces-108979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEA9266B1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F2A1F2182B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D01836EC;
	Wed,  3 Jul 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIjZrjFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66D18307F;
	Wed,  3 Jul 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026298; cv=none; b=qGnjdcOYcLlf0q8QlwtlNMHshnpC72lVvhemg4wahRut/h1yGBg6m2NAcMn0OAUqHD7IZ03nHJnnMoxmgDoUh9teIvBpVJLxHGMrxIynHNrNddWAhnEbLWQp8SXlXnGNaSJRhE/UQh0x+/ZorMlz062BIj0erkXPePhGrErtibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026298; c=relaxed/simple;
	bh=XwQd+DWl75xamnf8nyW3x7jvpLX19BnBWgwoi7Aipi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQJV6ZEtZpaMQgnoYUVDXEeUsJo4kXMFN8AYvPWLkOyXxhe68Jfc4gBPiVeCdEA4R6SyZZdnANbPPwoZQUApwWGpKjz1ImD+EmeRHA6R0FGADBM2wVyXtJEXQhkninrkOphs6yxlnZNXUt/OHd7YonxcDLZGum1Kv0dezKKoTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIjZrjFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B39C3277B;
	Wed,  3 Jul 2024 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026297;
	bh=XwQd+DWl75xamnf8nyW3x7jvpLX19BnBWgwoi7Aipi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIjZrjFsayPHg7uXiqfWGtTqhLt/vEksnumIoZ/ocDu9ACP9lmyCO1ikQrUlNowaF
	 z/3QemWgQ4dWmQH06EWteeG0Mli970ilPR18/roXdzpZScZTdNucu57dDEP2FxFzQX
	 1urRexnWdy0ytfA6aYVgbhD04zPdnff/UT1y4ukM/cZ1OXuWSiRJpTMp2csjev/QJG
	 vI+AS9bYpsUOvS2k5kEc5GwHzGeA/IytPp/MJU7GabmrNVtwrQgsz5zKiEImjydlLz
	 dElaw1cHnjuOr44v5diC4FlcjX/p3ghN6SujfwrnmJAqwFHmr8oNv72imMatqp1mdF
	 pBSpB1dgoaVNw==
Date: Wed, 3 Jul 2024 18:04:53 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 09/13] rtase: Implement pci_driver suspend
 and resume function
Message-ID: <20240703170453.GC598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-10-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-10-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:59PM +0800, Justin Lai wrote:
> Implement the pci_driver suspend function to enable the device
> to sleep, and implement the resume function to enable the device
> to resume operation.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


