Return-Path: <netdev+bounces-109438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B49287A5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C42F1F21B79
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD5148844;
	Fri,  5 Jul 2024 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUi21u7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03F1487FE;
	Fri,  5 Jul 2024 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178262; cv=none; b=UA3gAJS+RbXy/+R3NkXKOq9yopZYkDgfSHZTixFcX1FhBYMEabCwnLOlOGGTp+P5Z+GsrWiuOm/YJUjOI6LY77dcz7ahrOpCJlUMo4tQi+nkyu98hbfCMAQ8uLaDJw5ctc97ahh+veMwBPgacm7JqT3AHEDlC/vDFmQXaTRXoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178262; c=relaxed/simple;
	bh=RBYIf/XbFHmUFmPR+A2DquaCRZ2Vjj0Yt+m6L1vh5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDKOW4ozBl+8QPiLX7L9dUagmVo9egSFsGf+Wqlhr8r0khpq139FxoCl4Xu49pcYuZpRgPbIpsow178YdqdQbayV1Ch/DZFx8uuia/IqMCwdhzwPYyKifeV9rMgpajCeSSSkazZTEE6wA2x/K3uoC5yPz1Rc775Y8IDQ4uiakXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUi21u7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21038C4AF0A;
	Fri,  5 Jul 2024 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178261;
	bh=RBYIf/XbFHmUFmPR+A2DquaCRZ2Vjj0Yt+m6L1vh5sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUi21u7RHrnH1FP7Mp7AfpE8L27C/mlkUHBcve1n3JVaz86wzqZ+BcsclCazQ1kNv
	 wjkNBV+1F5HC1urmBazyaJjWyBCdwX1m348oH0dZKMlJ1FNei0smLFY2LmyVThb0Jx
	 3xI83LRQpb2gHl18jCUMZ+SkOGmU11EUXIqWqTORLQb3UF/pIe1FdCSPZYe5MTSrWs
	 6Y1on/RhK5XoelG6zBDC/gFwBDSOfaKZX9RwFE1qwVGCwLzTzEi0O7rwLhI3ONj9CD
	 x0jPJN7JJptVO7pannx1ZCKs7tjKacQO0MjIXe5izduWxpfQxML0n8Z2EDv2Hfsnyn
	 EqivQ2XFEjFqw==
Date: Fri, 5 Jul 2024 12:17:37 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] octeontx2-af: Fix incorrect value output on error
 path in rvu_check_rsrc_availability()
Message-ID: <20240705111737.GE1095183@kernel.org>
References: <20240705095317.12640-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705095317.12640-1-amishin@t-argos.ru>

On Fri, Jul 05, 2024 at 12:53:17PM +0300, Aleksandr Mishin wrote:
> In rvu_check_rsrc_availability() in case of invalid SSOW req, an incorrect
> data is printed to error log. 'req->sso' value is printed instead of
> 'req->ssow'. Looks like "copy-paste" mistake.
> 
> Fix this mistake by replacing 'req->sso' with 'req->ssow'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 746ea74241fa ("octeontx2-af: Add RVU block LF provisioning support")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Reviewed-by: Simon Horman <horms@kernel.org>


