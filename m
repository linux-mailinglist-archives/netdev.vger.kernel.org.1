Return-Path: <netdev+bounces-179708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08479A7E410
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503A4189AA2A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BA1FC0F5;
	Mon,  7 Apr 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU5XZ7Rf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B31F8741;
	Mon,  7 Apr 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038816; cv=none; b=TmdKqXSco3anK6iBeoeYdVH0YzwuxpUuX048VvTAhMS4L5jDGwzIPN+7336DiEMrAgdQoWhfXg6to5FsMOzBEYKzvA6rBZfgPlN3pZ4cSiNfZcj9DYEGTv3sLoqVTNN474LzJ9yVDYTph7Un9Ha3FRgOwF4dtgXTZEh6QqF0Xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038816; c=relaxed/simple;
	bh=NXT3oErA7F0ZWAAtUuV6bGlHY2sTX9fZh6zjsrdJZyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYACc8qyvqxbAxXpwcmfJPIR3CeLaIAr7x5OgItOyjIdqbwdgbNXBM5piVT5gaB2yHwvab4+uGRvPYUjN/BZEiotk3RgrpDpVibvkyQgbS/YiglzyEYXyeZ+vbHq37NuEm/Kb07Yj2Kg7Whmwl9SvTV/93muzPGtzgmkdQLWWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU5XZ7Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC2AC4CEDD;
	Mon,  7 Apr 2025 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038816;
	bh=NXT3oErA7F0ZWAAtUuV6bGlHY2sTX9fZh6zjsrdJZyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU5XZ7RfTIjn1Kb1X8kFW933VNlQk0TkF5g2gwEu/E9oo4VCsz40VM6OLL1mc6zIC
	 zXHZWDZBoLhkEJaZhzCCWfleI9SpdlucQjXxq5pT6g9k42GCzns1VSnRA3k9EeLVRU
	 A8af+l6GeHe/j8QoPHiQw4iAkcJIJuG05ExGKm2LdrzfUR6qX2eXDkhn5YEIfv0th+
	 iEC/tS7yhF7EHMKsQbs1cYLa6exlxeOEnFbtjsbjGTpjdAfSE8SZlFQeLFEuwSvjz3
	 /EvKIznsYvLqZFZiUvj2K24P9t7lqKOZ2Y6fSgqPKu3sa/udybNPpuj1KwUHHW7Y0d
	 CMV32vKSJ7I2w==
Date: Mon, 7 Apr 2025 16:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: qos: fix VF root node parent queue
 index
Message-ID: <20250407151332.GO395307@horms.kernel.org>
References: <20250407070341.2765426-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407070341.2765426-1-hkelam@marvell.com>

On Mon, Apr 07, 2025 at 12:33:41PM +0530, Hariprasad Kelam wrote:
> The current code configures the Physical Function (PF) root node at TL1
> and the Virtual Function (VF) root node at TL2.
> 
> This ensure at any given point of time PF traffic gets more priority.
> 
>                     PF root node
>                       TL1
>                      /  \
>                     TL2  TL2 VF root node
>                     /     \
>                    TL3    TL3
>                    /       \
>                   TL4      TL4
>                   /         \
>                  SMQ        SMQ
> 
> Due to a bug in the current code, the TL2 parent queue index on the
> VF interface is not being configured, leading to 'SMQ Flush' errors
> 
> Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


