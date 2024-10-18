Return-Path: <netdev+bounces-137112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CA9A4680
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B8F1F231F5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681F20493C;
	Fri, 18 Oct 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9PGI8T8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EA2040A8;
	Fri, 18 Oct 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278550; cv=none; b=bMTn9A7FKK+OSC3GP29pPKRSOhqkwwLcwd8vUrGfqkUa20QHZIM9vKP9InOzYnubATQPToaIHjcTK71im1OBLr+rnMMeX7ShGus3WK+ssSeBIBlYByA3SpnzPcka+MsYZ/8XkiqXAgQz5v4Llmp/FkU55fp/OvqydKZWh9Tg4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278550; c=relaxed/simple;
	bh=r9qxVTOoOOcQeELamzQCjVd+BNmi80nHyEMadgZwn+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVy+BR0sHnnpgL+PXog58nBSUB8jpsZGZ7zsXtk9FOyxwHZS9fam9Eykj2IH31LlyJpcWYiV8pz1RPftjMCnlPgNBUgdPuhZflUa6+1XDYC4csSPDrljbifwLDfvSpKDuqLog7OLQmmMuIpPiYu0dUTUoNHWn8mQL+JnkOtOADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9PGI8T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7184C4CEC3;
	Fri, 18 Oct 2024 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278550;
	bh=r9qxVTOoOOcQeELamzQCjVd+BNmi80nHyEMadgZwn+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9PGI8T8RnGExTvogJovI6rlr4V7arNWAIindhvN47juVIJSxB2EG0fCLF+yAUhZz
	 lvXT1wJ5SZ+FSCVEdrnwGEBt9w0XrXTGmuXwkY8i/PaaDivYfhgs3qhyUddqS30gaa
	 yxw2HpyA/G1EJt5ft8P21wRUiVSS4/Yp7bbFuKzWGmsAu28CQlbf/4wX4xnwXZX3dZ
	 lRvCu7n2Meg9Im+Q9TdgsQbcD78MUSNkfSY2IT1cKG7PDMpsL1QpV1yFzU1Re+Spmg
	 pk5/6JyQuQYCUwOtQVU6s2rgme6xFgKzeExKBRk6fJLDPs81HpU65Ol3TmVURcx3vz
	 WMH1t6i6x5tuQ==
Date: Fri, 18 Oct 2024 20:09:05 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in
 otx2_ethtool.c
Message-ID: <20241018190905.GT1697@kernel.org>
References: <20241017185116.32491-1-kdipendra88@gmail.com>
 <20241017190230.32674-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017190230.32674-1-kdipendra88@gmail.com>

On Thu, Oct 17, 2024 at 07:02:29PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Fixes: d0cf9503e908 ("octeontx2-pf: ethtool fec mode support")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


