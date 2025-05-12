Return-Path: <netdev+bounces-189777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBFBAB3AB0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B2A188FD05
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890F2288C6;
	Mon, 12 May 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RenxDWsI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DF78F43;
	Mon, 12 May 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060380; cv=none; b=tv63EECViWNy/uYFuiHPgCSZBXcrI+VzU3wvsjD8btMxtI4WRCV8+rMFPjuIliAFMCgmcKKnwGs6PmExFc9lDGbEY4OiIM8e0aXzQcbbG5Ff4c7Bjc3GIPaA+Vyp4d8vxvqUfTfl1wnW5w0Kxw77ZU3SKTHi7batwFCAdIyjndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060380; c=relaxed/simple;
	bh=z+eY0zq/n4AmhwEZ72MGuXRS98+3Mg7id4BsjIS9v20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLBnOLvOqgcNkE37XCQgzQ4iSWW83uU2cFELAosU/yyl2G75oTVe36XDawLyrorIlGbpBL0mRsES33P+YF4iOAKmpAnm78HrzPbbT6c7uDTqW7pPg16MDhbtjFgwVhmtYD20InYM3lwk5AJ10E9tzutY/4JnUH8XduKR6iJtvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RenxDWsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D03C4CEEE;
	Mon, 12 May 2025 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747060380;
	bh=z+eY0zq/n4AmhwEZ72MGuXRS98+3Mg7id4BsjIS9v20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RenxDWsI4aw+z8k3iQiWQWygEGz2evM5C+dyREoMo0XKXU+CYdio3MiN1xrTNkYT0
	 LTZl/r8G8s52Gr7N13OqAFEEWIMHf2rnMOLEMfpXGfwmd45BydqZYGLFyOT9uVbehc
	 Mp8qlBK0Z2wlyD4sACF6v3ya+FHXufFnsLPokFQmYRtQ0OVJbPujPd+pCCHvsmYdHy
	 iCv/TakHfNhWXOUn6UiqGbIIAjuCn0oF/PTF3Au2751Pwoob9OnsEzStkyeOpFeSGj
	 OFeg49+9Hz86i/3PUHUH/Wu0Jk0s08yPH7Ot24HrLptDPbuELiTrc7klmKs5+5knvd
	 vBjGiXgKWAxsg==
Date: Mon, 12 May 2025 15:32:55 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/5] pldmfw: Don't require send_package_data
 or send_component_table to be defined
Message-ID: <20250512143255.GK3339421@horms.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-2-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510002851.3247880-2-lee@trager.us>

On Fri, May 09, 2025 at 05:21:13PM -0700, Lee Trager wrote:
> Not all drivers require send_package_data or send_component_table when
> updating firmware. Instead of forcing drivers to implement a stub allow
> these functions to go undefined.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


