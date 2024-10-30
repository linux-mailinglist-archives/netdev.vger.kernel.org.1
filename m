Return-Path: <netdev+bounces-140524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32489B6C3D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB54B219F9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725B1CB333;
	Wed, 30 Oct 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KMt5VixN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B5199EB0
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313282; cv=none; b=HGMaA5oeFqZ3YfLRmSUQ1tZX/8zjgFILrenEhvvZv5wvpuiVvV4k/q4nx0hTHgcTdBkghkS44Ao+8sVa06gYL5Jm/PEWPj6ufOYgdR4q+iyyTo9ArhuHd1Js+sonUCnRqvB3AiHxxNhbCZORl9kiQPZ7Cnd0kIrSiQbs+Bk1+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313282; c=relaxed/simple;
	bh=UzJxC33MRrKfpVwwxZEHfMB75qJxProftC3+1nIF+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+jvYwyUKX3SXBtxB759p7H1w67jetfqxq94l+XtoEXJbo+xKe3/2TKN08KBAf5nAIK6omNDkd5TT64A7woGfeINomnRK7g1lSFFYc9zw0C73CodAgGeccVFz1p64/zPRGy9eZxF2YffVzDbT9YLLNUU+zR+0Ds7686CXk5V53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KMt5VixN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mdXjtcUoWUAuOEipgOwmY8CYHUPP2fT11CasTo6SG4o=; b=KMt5VixNqdtlWJNkvNOihsEpGm
	/5Zx6PR8bxMk3ZeFLQbzb7p3zyuRT8wOKP3xqa1P6u300vC99PKUkChyWi5xKbg0yjKVcbKTMoR6a
	fh8W1hNW2nKJSiPvLpMPev6LG9KXHtttuPHQiSxvs7LCMat6TGONUHMzjSiK1ngAMBT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6DWb-00BipS-Ck; Wed, 30 Oct 2024 19:34:33 +0100
Date: Wed, 30 Oct 2024 19:34:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024223135.310733-1-mohsin.bashr@gmail.com>

On Thu, Oct 24, 2024 at 03:31:35PM -0700, Mohsin Bashir wrote:
> Add support for writing to the tce tcam to enable host to bmc traffic.

The commit message is not really helping me understand what is going
on here. What entries are you adding to the TCAM? Normally a TCAM is
used on ingress, but you are talking about host to BMC, which is
egress?

	Andrew

