Return-Path: <netdev+bounces-229926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7BBE2199
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C777A4E0410
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157392FFFAD;
	Thu, 16 Oct 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWn4Kp+X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AC32549C;
	Thu, 16 Oct 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602335; cv=none; b=fdCsv+zjRijz5Etl3ZWzKJGqaJkdmqOz/Nifb5Tjce0tK45/WClTNAcD8MQGs4TABqNgWAyp/L+/kXLpJT7DCc4naZU5FJC266n+w+ciX/RNwMDySg//FPiK1IDz65/e4iTBXAOoCbz4CWhyChH+ER5PciNh+P4kSKZYMS7IGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602335; c=relaxed/simple;
	bh=WCCsY2cS8nAhcliGIR8Th2DjzTc97+u72/JnvpbGUj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cco80Mqo+nsOOoUbimalGE/Juka+gCp72OvoI2AvnsqmbIxQg0okwDQLAiYk4fCcJdiv0gCK4EDtEw5gT6YsivavPzY7ZmrJwItSkg1F18o+vgRZEuWciBNaor5A5M6TpwEf55AiNXSyOSB4K6KIFT2uVjjlcq/oE2iLeqmQWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWn4Kp+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F87BC4CEF1;
	Thu, 16 Oct 2025 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760602334;
	bh=WCCsY2cS8nAhcliGIR8Th2DjzTc97+u72/JnvpbGUj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWn4Kp+XYTWdXDo0nDW4a97ltgmv5wKeD2Wig1w9Qzol0k4XiGjuG3EL6ZwEBHzgj
	 YCkKVcTWDJPs8eZfMNps416Y0R/ggrMq/tKZ6YMKptva3hNVR7uaDTCw26FHSYpf4r
	 JfDlYbMwa27YaODBq+MBWZOQMHuxd2IA1K0QjOj4dL2Zc/VDFXmQo9i/ETS80DtoXg
	 alFdwMpAetv2Yi0VbnzJF/HMGDctMeU+aDK+nNqT1BZ9Q1gbuDuRt2ELqX4d/Lwl2t
	 yxKkslr85cNwHItAYmp0Pm+Scn8lHaHKNYyIM93N1hJm3g/J1EnRkwuNwMm+B+TFU6
	 sjTKbXiCLss9g==
Date: Thu, 16 Oct 2025 09:12:09 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <aPCo2f3lybfRJvP0@horms.kernel.org>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
 <aO_MefPIlQQrCU3j@horms.kernel.org>
 <aPA1BzY88pULdWJ9@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPA1BzY88pULdWJ9@archie.me>

On Thu, Oct 16, 2025 at 06:57:59AM +0700, Bagas Sanjaya wrote:

...

> I think that can go on separate net-next patch.

Yes, sure.

Would you like to send that patch or should I?

In any case, the current patch looks good time.

Reviewed-by: Simon Horman <horms@kernel.org>



