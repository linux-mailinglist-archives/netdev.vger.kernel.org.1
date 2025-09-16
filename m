Return-Path: <netdev+bounces-223518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543EB5964D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C13B606D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46C2DBF78;
	Tue, 16 Sep 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg+4urFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B882DBF5E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026132; cv=none; b=nbVsXmFBF2YhBtJ15IORz9XMZIm3D4R/R4HtkI199IdzEC7l9BjlFEfFq+f88NHQUTqcmz66cHS/eEulB95FTRTVjKAjj9C+tZnRNYIU2NI+E7uQkpDfyksHTubQFtF9toF6pzi4Vvb/9bHuXaomlXQC+GYmZ7PKcBh/U+uOjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026132; c=relaxed/simple;
	bh=frjLeiaDLsBcbMgkPW7s3MHcvq1Md/vkbPWCLIeAOrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrus2/IxbGhtXK54Fb3sOYhyX3EJEn1TfyTBjug81j5rYgkQEHD1iB7BRDw716rj7MCswjcvoEiJyqHbShpHl2gwThHOCzZ26v2UMeADRhDdoA71hyKIQT7Y96yFyyq+yMtYF5p7lt7ZoAYy2N6zFMqj3cWb3W5kReN2sHAz8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg+4urFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54480C4CEEB;
	Tue, 16 Sep 2025 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026132;
	bh=frjLeiaDLsBcbMgkPW7s3MHcvq1Md/vkbPWCLIeAOrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eg+4urFqQUY988P8eAuvxh20O3l5J162jpO7oLjIez8riODnMRwKzG3U2x11tzYTK
	 nDxEKCswX2cQ2HnDKkoQ7JuefSTyzJDbSMZUl6tDFRhoLKCOiQLp10BG8fIEPVY0/p
	 S2Bdk/BibxRwkgn5IxkbdabUZL0fvEFOcljWDPAbudAD5QsccmhgZe6VNhyFz65gLA
	 LyBIwh7htQuwO8WPEIAlpUIpPnyHQfDB/jtADM7J89R148Krop0PO1DeTRonZnnWwB
	 vBoPS8PNip6R7EgdIxk0ouAQ81gLZOWdbKuGheDyS1tjacXgWz0QBHF5x2WnpLsiHH
	 wD/7CPx1/bDEg==
Date: Tue, 16 Sep 2025 13:35:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 3/9] eth: fbnic: factor out clearing the
 action TCAM
Message-ID: <20250916123528.GB224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-4-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:06AM -0700, Jakub Kicinski wrote:
> We'll want to wipe the driver TCAM state after FW crash, to force
> a re-programming. Factor out the clearing logic. Remove the micro-
> -optimization to skip clearing the BMC entry twice, it doesn't hurt.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


