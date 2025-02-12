Return-Path: <netdev+bounces-165548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB4A32774
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E883A8B11
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE59210180;
	Wed, 12 Feb 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0YzINBEu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271620E326
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367853; cv=none; b=t5L9Mdd+dVO4OZttvSHNfBnC2Wl9eqMeFnObNg3I2hDMFRFlBBHxLHFFiL1DtuUzJYjcs3zywwAAUaSKnvobV/UvHvxjczZaOkbeMt/kZihrE7tVusEfB2fZjoE8g8zu9EpWn6ibMXbzED5No1wN0kmxST5zicuKWRqNMiYotRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367853; c=relaxed/simple;
	bh=U9YMBnzkq1wmG5/fozixc50SxxdFnL+C1UZWCInuIUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe6+dearhmZw5JP9J+yLp96YAeyubT/JdbKDITPN9dxKi8CAVtteoumwuT3JluXs601Km2aNfTAbQ5PN30xdwAanDL6eOnE2OdXPsfBrUQDMx52Do9ZOyzcrNqyi8Xwd1a2UujH1554fnCBt/xAtWQ1GlepJTApSvAQbah9fMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0YzINBEu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ebe8YJuuF0Pgf6+A+luI5ms3fWQAEapoj0Y9JIcmFVU=; b=0YzINBEuPRegsW0EXiRJGwU/Jd
	uKUZgtAlQQipDfvmqzCu7tPB5AGtrZE7eu+OP+cJJsjVv8WvQNtPjCaP+a3RtNDAy/hYAsERfxEpK
	qSom2MstaP4lSx+FO5pMu2X/AWpEn2pr7MWESYpGDFKW2Yydk1Kedpzh8ZB50ucMSBVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiD23-00DPIw-2H; Wed, 12 Feb 2025 14:44:03 +0100
Date: Wed, 12 Feb 2025 14:44:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
Message-ID: <466e68ae-db4f-4ac8-af8f-a8b286821c51@lunn.ch>
References: <be356a21-5a1a-45b3-9407-3a97f3af4600@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be356a21-5a1a-45b3-9407-3a97f3af4600@gmail.com>

On Wed, Feb 12, 2025 at 07:32:52AM +0100, Heiner Kallweit wrote:
> As part of phylib cleanup we plan to stop exporting the feature arrays.
> So explicitly remove the modes not supported by the MAC. The media type
> bits don't have any impact on kernel behavior, so don't touch them.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

