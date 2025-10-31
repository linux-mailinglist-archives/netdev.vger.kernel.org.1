Return-Path: <netdev+bounces-234729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C9C269E5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CE3BB03C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0E2E427B;
	Fri, 31 Oct 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj+gzO9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947511898F8
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935922; cv=none; b=IEL9zPCYHFX+hwTvuNfS2OB1R84e6+2yEjQrfjKHV78fvXTvCv+pJAywSpOlZlEjP9lGQQgGopHSRiopHzvBNyKNrXdgTEmYJdyxyu538yggQi4UHVM+DprjAkZ1p+Fh+s5tTyH2YSd/W3Nw37WiU62P8C5h/GGOvPeJ87G4yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935922; c=relaxed/simple;
	bh=15E5ci1sKkWmYweiaVDjg/8xeqjQIU5DkH66QuBZWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayShTcLqksqSQEXwo22TdAm1wxL8R9Rj6pvWeNYxAcwx+3Gvwwg5F65HjvvoAVsYgY8dA1b8RjG6GoM6nMyhAme4MueyfssX0q4rnN7H73REMfMkR7KYMyilno2z7hpfzRpF+ZfiZHw+wYKDEefTLgypVnMzIz/7nyeMZ5ZSEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj+gzO9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A25C4CEE7;
	Fri, 31 Oct 2025 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935922;
	bh=15E5ci1sKkWmYweiaVDjg/8xeqjQIU5DkH66QuBZWaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qj+gzO9znW5xDDYE74Di489ySXv22EKDscNMyfXckAJeuDq2I1lWEZCIzkhy4u9TS
	 Fy1ubpPoCbQELwfgIComEQhr8vKl44DP9UVhPT3l29z4DN3J+9Y+qI7yvtkMI5lTW+
	 +Lf/LTd/BIPOVEO9hFRDCYW1GXcAlTFHmg3HP3Ap9NM2kurmqcnmcsyKg7V8kqN3px
	 ZXOJ732KRrHPq+dsqd+9MoK+bvlDQkvnNrXa3rKP7j/rgwPlFsvCuFXbAUz8Ada6Qp
	 53kd+Zia3t1rEsQ+S4bl2DEAoHEMQnztW5lAjvVO2lEgtSU6531+GMwR7RFq+vbdRa
	 iRtR+ZsZJegTg==
Date: Fri, 31 Oct 2025 11:38:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Sudarsana Kalluru
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sunil
 Goutham <sgoutham@marvell.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: pch_gbe: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031113840.067ef711@kernel.org>
In-Reply-To: <20251031183525.5b8b8110@kmaincent-XPS-13-7390>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-7-vadim.fedorenko@linux.dev>
	<20251031183525.5b8b8110@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 18:35:25 +0100 Kory Maincent wrote:
> >  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> > -		adapter->hwts_rx_en = 0;
> > +		adapter->hwts_rx_en = cfg->rx_filter;  
> 
> It seems there is a functional change here.
>
> > 		pch_ch_control_write(pdev, SLAVE_MODE | CAP_MODE0);

Good catch. Looks like SLAVE | MODE0 translates to 0 | 0
so presumably the device doesn't actually support timestamping
of V1 L4 SYNC messages? Unclear what to do about this.
Maybe let's leave it be? keep the hwts_rx_en = 0; ?
Not strictly correct but at least we won't break anything.

