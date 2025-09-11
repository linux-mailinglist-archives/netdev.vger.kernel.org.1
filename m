Return-Path: <netdev+bounces-222223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009CEB539BF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5EFAA44B1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7C35AAC6;
	Thu, 11 Sep 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6R8oYts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B935A2B1
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609797; cv=none; b=Ci8gG1dDW9vzPS+W2Xl2tjVAy2yVCrADJ/UNSADp6DiHCD5VGpWJQKFRjSwoSDjnWfqGYqi7/8I0k1QhAS2/npGHFbXFA0zgQgseMIfi1L+Ksz0ELEFFw24iABzNk126cI5YKF4EIDWH6hZEX0H7UXEvxiLqDewXDK54BZ8SLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609797; c=relaxed/simple;
	bh=VHKVGhYTcc/cg3QA7E6s4Sif5p1BTxRoZWEYIuNzTNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPoUx0LvhTMqqKIw1Gx7XSq2lciUwNhxMfqxvQjtzXW6BhRCM7i66oHQzDA7aL0BpBZKLFawua12VApj5cXL35xOkiB1PV0pQr0EvsIlg3bkQc3pFRwpdHbVo16Uq/vC3gfdq5G4ddqUDN6lNjjESyK0PYDldTpkqcYBbazFj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6R8oYts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8063C4CEF0;
	Thu, 11 Sep 2025 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757609796;
	bh=VHKVGhYTcc/cg3QA7E6s4Sif5p1BTxRoZWEYIuNzTNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6R8oYtsy2n3A/WqoZnlNGLAjgJYPDt3TwNA8y+SFn/ygSQ1QPPjTXaNQDjPdoR2N
	 ql59HdeFHnfbpljy7Q7xMdMV9SYgivbUZLgNWdrHTTLhATSCGz7O0Ss+4sUQW/oPw9
	 3aX4SWZ4Dkgf5yChNqU1wruj/g5OpySHB2TtZDVegP2GJzBhlqYMQKJuNlNLTriCMw
	 144X6a4VIMsxLUJUkqRrDjAu8kgFxggKyPOn/VTJuJTcutxFBSxfm6lvO6eWdY8Ju3
	 yQMNd9vYTZzzXMBDd69PEtiiiuWBipvNVexN4LOqLKPZcWy5HHQ/dVOfBeMO90BTLC
	 +hgnVtZNWPuag==
Date: Thu, 11 Sep 2025 17:56:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethtool: handle EOPNOTSUPP from ethtool
 get_ts_info() method
Message-ID: <20250911165632.GO30363@horms.kernel.org>
References: <E1uvz09-00000004G0U-3bjz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uvz09-00000004G0U-3bjz@rmk-PC.armlinux.org.uk>

On Tue, Sep 09, 2025 at 03:07:17PM +0100, Russell King (Oracle) wrote:
> Network drivers sometimes return -EOPNOTSUPP from their get_ts_info()
> method, and this should not cause the reporting of PHY timestamping
> information to be prohibited. Handle this error code, and also
> arrange for ethtool_net_get_ts_info_by_phc() to return -EOPNOTSUPP
> when the method is not implemented.
> 
> This allows e.g. PHYs connected to DSA switches which support
> timestamping to report their timestamping capabilities.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


