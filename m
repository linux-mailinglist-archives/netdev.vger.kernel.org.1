Return-Path: <netdev+bounces-121655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96E95DE41
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5963B21247
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0A4A05;
	Sat, 24 Aug 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMWvv7sv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6A1E521;
	Sat, 24 Aug 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508146; cv=none; b=S7QFONrmfN1iphdHqT9BZoS6AzOsT4E9xTOXqJe81M56MnF/o1gb2SI4/F8UoIOvy5M0DTDpyBYjNeumQmdqcKNvWd0Yp+c/Kf7ScurMVliUtdz0MXpj3Cq1L4Xf0Egsxk78Fcb/4lbkfmIxWucwlCQgWC2EF8Lhx6/VdRa+DXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508146; c=relaxed/simple;
	bh=ZPoSQKq7/cGB7SMW/or4FV1bejIc5+AKsHtyFye75P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfuxOIPATDHegTKWpVIekQ6AvDVWIsmB2p/8v3nhudcKsL31etA56/WgowPfQxArU3AVUkWhmI7rKqvG72aFJL+vKkWA1PZp3bQtU7WByzVm575QE9h434+iCcicM/qUeXBnSh9y8JWPtYuRqs8B9QKLyOS4muhK7jlVvy+Xi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMWvv7sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F3CC32781;
	Sat, 24 Aug 2024 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724508145;
	bh=ZPoSQKq7/cGB7SMW/or4FV1bejIc5+AKsHtyFye75P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMWvv7sveFg+Ma8M73vV3mbN6mto0rE+hcjiTx6leMw2G1V/6g4zj83yCNJ5sDPmv
	 Nkmu5xRst82Prqi+sbZGyPSeSg+WtewJtZURdePy4rIbdW1/g42eqQ4GPvuPv/vVkb
	 XqQt0UFZCBsxWovXf3fZCuYRFBccLJK9BwsGn26cNTmXvNXSmXGn/z9wjPHqlrzvc5
	 ZlogLY0MTEWY+DOjqJY0luLTSoZ6cH2ZcxLxCy/by+ZoHSH/Pr93wtwSa53Kd28MQK
	 xC3oWafwpxwb48OvWG6HgVuHKhfWE35FbMh5mkqtcoFSiSv7ek/x8KmjrWiW7nibMf
	 m/8WI2IgCdKUg==
Date: Sat, 24 Aug 2024 15:02:21 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: vsc73xx: implement FDB operations
Message-ID: <20240824140221.GM2164@kernel.org>
References: <20240822142344.354114-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822142344.354114-1-paweldembicki@gmail.com>

On Thu, Aug 22, 2024 at 04:23:44PM +0200, Pawel Dembicki wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the bucket number by itself.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ---
> Changes in v2:
>   - Use FIELD_PREP and macros in 'vsc73xx_calc_hash' funcion

Thanks for the update, that part now looks good to me.
I'll leave a proper review to others.

>   - improve commit message
>   - consolidate row, entry, bucket terminology
>   - check for error codes from vsc73xx_read() and vsc73xx_write()
>   - check if cr return error
>   - remove redundant comment
>   - set fdb_isolation flag

...

