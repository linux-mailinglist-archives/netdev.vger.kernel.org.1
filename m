Return-Path: <netdev+bounces-157444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D991DA0A51B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C373A7107
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0F1B415F;
	Sat, 11 Jan 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T3MjQo8L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD281A8F6E
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736617096; cv=none; b=L+JjtoeU0G723uGpEnvM7nf25aCNOXKSpxBkwS4t2Yyu/aae0c7vV0A5vGMfHbPqAdzN53HPtgtZ3hCJ+NK55HuTu4VDl3zQdgE2sRb0gxd8Ubjo05PEU+6Y06k/Nm44KE31uUFb9xOyhe2y86BF9zarhaRK32eiSq/Hj8V7KYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736617096; c=relaxed/simple;
	bh=ukIKd0pX33pnga423+NE3H92qFLcMOQpQnZix4V6dv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD/OYAfk4ncKi08ag2suUAtaNJfqQ3I/QJjlUgjAswDtIB8w/IeUGz+aPUmYCBgUp7Y4M1NaJle3VeBEMq9RzpmbPk5QnC7khs8BusA6YvFcpWvhv3C5qHZ5rZ5kU+eRC2t898BLM0xvTLwSMoZYRpDpVeGpN2ncxMl0mTrg9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T3MjQo8L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GbEQ99Oy/pgqXm6/qygvbWsuDXPbl9kFVPQl7F+SeN0=; b=T3MjQo8LOQAa3KRH9kB1RGl8IZ
	sBothPKzyz7mx5HGTosW0fkkpC7y2NOtPBXgufPpabco4rFqpv4zVTcH1XPoqpMVhIqTLZvN4l7JZ
	LsSm0+nElUEy1c3KqPUd2LxD+stKwFk2axxe87+YkBnZupShvZcw3lVwXtV4jv0ncYWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWfR1-003aQf-1r; Sat, 11 Jan 2025 18:38:07 +0100
Date: Sat, 11 Jan 2025 18:38:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] net: phy: improve phy_disable_eee_mode
Message-ID: <6c4692bc-18e9-4195-82e9-1be83645c8a4@lunn.ch>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <487d87a1-7268-4ef4-9bde-435e61c7495c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487d87a1-7268-4ef4-9bde-435e61c7495c@gmail.com>

On Sat, Jan 11, 2025 at 10:07:43AM +0100, Heiner Kallweit wrote:
> If a mode is to be disabled, remove it from advertising_eee.
> Disabling EEE modes shall be done before calling phy_start(),
> warn if that's not the case.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/phy.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index ad71d3a3b..fce29aaa9 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1333,7 +1333,10 @@ static inline bool phy_is_started(struct phy_device *phydev)
>   */
>  static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
>  {
> +	WARN_ON(phy_is_started(phydev));
> +
>  	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
> +	linkmode_clear_bit(link_mode, phydev->advertising_eee);
>  }

Thinking out loud...

Maybe we should make this more like phy_remove_link_mode()? That
function also removes the link mode from phydev->supported at the same
time.

	Andrew

