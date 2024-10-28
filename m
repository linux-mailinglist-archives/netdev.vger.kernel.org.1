Return-Path: <netdev+bounces-139715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5B9B3E5B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73170B21AAB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD21EE02A;
	Mon, 28 Oct 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf99pS7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CEA1DEFF3;
	Mon, 28 Oct 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157693; cv=none; b=cbiLaJ5ei5gW426Y49zIfGprHO06hAeYGzR68m3FEWVJT+y6/Lq83fX1UZizKOB077zy+KydStph+YX7nJPdBVaCk+9sr0SeBlJWT6VqpoaFHv8Qmn4aaH73r2DGqdgn/RKHBmt23vQGHdasA8Ti3SWFoBQqjnyvF054QzNwzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157693; c=relaxed/simple;
	bh=WOpq1rbA1T4zjc3ndGrSWjTuNxWi7o9FscLcI3v91r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moTOxDkXqZgB3WCOY3/UCCHu9ATCGWlFDKJZ1btopfASqIZBA3tj2JNaOGubC3BoJzqDAKbC89lAReTnpBb2hHIAg75YDtfDU2kI4x2wapeljlJZSvu2BwhzcgO/CLvb0jfkzhhrjp4ah1kEV/I5kV11gd4dsJz/DCu6bG/0ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf99pS7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FDFC4CEC3;
	Mon, 28 Oct 2024 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730157692;
	bh=WOpq1rbA1T4zjc3ndGrSWjTuNxWi7o9FscLcI3v91r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yf99pS7IiIOG1ouWS6SL/pxZ/EYmFgE49RtNUYkEs9E8ETXORZ7dTuYzWVwN4m37W
	 oVsy79X7cWt118SUZy+M7cxv3VL6yUc35zS9KNHMY5Q1D8ugaUtiv38EvUL1ZAQ3TF
	 BqXr6IkNG6Q/CyJreHIHh8yvE3YOpG38AB76zgTZbAW8GJXSgbjKOrKlN70PsRNes3
	 x6CjNug+ZPH/CyjuHNJYXzz8rkMZV6c0UUwpuJiG23t4VM+EWPHSHuBo2zg/g5Rp2B
	 xlpJzHHKrGoE52DRd1GKGAE4xpFsWf6s65mWn4mR+1tCkLp5S3TAc7GGJm2ZxI+XNe
	 npeEilNA0CYQw==
Date: Mon, 28 Oct 2024 16:21:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241028162131.39e280bd@kernel.org>
In-Reply-To: <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:
> Fix 3338 of the following -Wflex-array-member-not-at-end warnings:
> 
> include/linux/ethtool.h:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

I don't see any change in the number of warnings with W=1:
gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
Is it only enabled with W=2?

> Additionally, update the type of some variables in various functions
> that don't access the flexible-array member, changing them to the
> newly created `struct ethtool_link_settings_hdr`.

Why? Please avoid unnecessary code changes.

>  include/linux/ethtool.h                            |  2 +-

This is probably where most of the warnings come from.
Please split the changes to this header file as a separate patch 
for ease of review / validation.

