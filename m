Return-Path: <netdev+bounces-95429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B28C238E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A902833B0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9E172BCA;
	Fri, 10 May 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcPx6gi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA7172BC7;
	Fri, 10 May 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340536; cv=none; b=p/QL9ZpHrBP8YtJoVmyBD74ejGAehxNTkg3B0PCA9GMh2H6BLEecQ6W4Oh2NgzLhWtePbeh6O28UaG7xV4nXKW/tf4+8P2N14qc9DEGxTUN8zC9UmEak6NBGUvWk+1D/4PPTSiOwp67Ce5jZtf13mywnxZ7TbTE3v+BCt5ny/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340536; c=relaxed/simple;
	bh=4VNN7ch7EApIjWuibzGWM6R4YO3+UmjuD2tdNHVSqug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C08h32drkSfLa4zmhIi/kTJG8lJSuEXk5w6HCdoB3NCNgIFjOFPPUjRJgwRO9erQU6M+2bTRc51MDDeqpazpHwW1PA8pEDcog00ODBx3unICKxyRg0KMeXmTTKT5Xl+1AnSIUFEJzQugItYjftO5X6JRNEHSu7kQQnr37WIKTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcPx6gi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60251C32781;
	Fri, 10 May 2024 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340535;
	bh=4VNN7ch7EApIjWuibzGWM6R4YO3+UmjuD2tdNHVSqug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcPx6gi6hhqd7KeQ+Nms/F5Ji9KwVQ6IAwgS2vWuuo3Dm3/jkS9i/hHknaGC9vEz/
	 U6UpjULo+/VXjK9+uHJHFrcJvt0gK10umbI7Lq63oJWZ7GWMYVZwNug/THcHxFJDj8
	 rP9WJl+BMSfNWA30Hji723a8SdXRiMEtMrwWGEqwELEz1gOeoSD9XbPvPHiYD/d82c
	 L23Igbf2NX8rtVHb4gCA7G7nKdo+20687k3NB+RggX5IT/BS2Gy8MObF4Kxuwh0w5U
	 ol3gFhWvJWKnoEzSEV/2y22FDOBkJ8x32ok8FRtcFxnS78KjeXtw7pelx1+PBl93lo
	 iTStoyqisehXA==
Date: Fri, 10 May 2024 12:28:50 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 08/14] net: qede: use extack in
 qede_flow_parse_udp_v6()
Message-ID: <20240510112850.GK2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-9-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-9-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:56PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_udp_v6() to take extack,
> and drop the edev argument.
> 
> Pass extack in call to qede_flow_parse_v6_common().
> 
> In call to qede_flow_parse_udp_v6(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


