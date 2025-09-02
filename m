Return-Path: <netdev+bounces-219120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DACB4003E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CA81653DD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735AE2FC006;
	Tue,  2 Sep 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPznax6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15C2F998B;
	Tue,  2 Sep 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815289; cv=none; b=KMAmwqSFSgoEnYb/rVygMZBWh35PVtNtbGN4Ngec6QRp5ZzK2+54AH6J+4qzRMTnVwDdctWmoGc3wgCgzrsoy8mXVK2EZ8hykrVHX+QXaRdQbuleN5y/Bl9xNBHTpAklcvPY4nZorm2+JtqUVL4+LPI9f26hZKXuAj674n0ylfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815289; c=relaxed/simple;
	bh=UoippvnZMyUSR38pwGIqf6cgxIiJi9THmYOSK7Jr/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnM3klooS7b9ftwvGWELg4h9CTNT2l1xclxccy1FpnhJuXsoYslEaMYbQPpO++HnCtVJso6ycz8Lhx+tFxmd9jY9T0XdpGw5kP1GsBYQO1EnksvXtikTIHJcTKrxFXwHqhoQSg4QxKXlTiiWfgKwvzS3UqFvnD9lskLLL8kJWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPznax6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB680C4CEED;
	Tue,  2 Sep 2025 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815288;
	bh=UoippvnZMyUSR38pwGIqf6cgxIiJi9THmYOSK7Jr/kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPznax6T+tWbpfFfV9SOjX9KcurCoj0YuqIBFLe1XFdPGKVkEqJu0QqdrI5sDGa3M
	 jnFj+1wB5G+wPBCuX54wRHT2702GxIJDTLfWFg5cZZdCdRoyZ7lTFZqXP+L4Nm5OuV
	 uwxzPVfymidfJn/T9tuc7ckuw6BMf17iH/nsfchyRa2O0CI+bUko99xZWUWBbpujzD
	 1R3sW/bXUTyz/0FKg1aMLC3VXMHVaUBoPkXtbJqI2f89dnlDwtSOyEFNCTrmDiJT9b
	 vTgiJnZ+dUTnlbdMgI5PpsQhfG2vPCF1dCW21wzdySDUbvhJsjMJ5wBAnhlugNkpX5
	 PHnBHO5AMsygA==
Date: Tue, 2 Sep 2025 13:14:44 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ipv4: Fix NULL vs error pointer check in
 inet_blackhole_dev_init()
Message-ID: <20250902121444.GE15473@horms.kernel.org>
References: <aLaQWL9NguWmeM1i@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLaQWL9NguWmeM1i@stanley.mountain>

On Tue, Sep 02, 2025 at 09:36:08AM +0300, Dan Carpenter wrote:
> The inetdev_init() function never returns NULL.  Check for error
> pointers instead.
> 
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


