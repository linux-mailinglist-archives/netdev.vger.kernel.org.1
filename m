Return-Path: <netdev+bounces-149956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0B9E8328
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045AF2817A6
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8848749C;
	Sun,  8 Dec 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjiux2nJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5571B95B;
	Sun,  8 Dec 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625506; cv=none; b=Twcx7dCvk+f0ebBo4D6dpIlC7OtfkchVGmjtx7cDvT2oY/vkCm3oewssHOdjFIzwW4B/F0+NwYzLsHijSZ3pJ6GPqe5PSGlUrViRySkOja+q7vH1+lDJZByGRuEq008Cxd4khjVIH74FrDE8pDB6WesNggUo77DNzxxwGRSkOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625506; c=relaxed/simple;
	bh=zls0SViV4nxrcbm6mKO1+fE1La5aeeOE1tiBftUibgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOLnE/42kglA1qwf3DbO9YAv9HJf+3wCoSs3EMeXo0CbbjUXkkGlfshVvlytjWCWuqcHTfLIaZVgsIQxJlZQ9qW7alV4I7Ev1ZTjV00H52jIO6hOQLp4rAUaF/5VP4PHn/iRn05w1oajLPbX+msRHySQwrWUwWjngVL/6kbsbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjiux2nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698F7C4CEDD;
	Sun,  8 Dec 2024 02:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733625506;
	bh=zls0SViV4nxrcbm6mKO1+fE1La5aeeOE1tiBftUibgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qjiux2nJxYpFu0g9ZdAvpi9M7MbQvN5rn3kEKS9G05clxoTuuPqopM1x28qYU98qR
	 cTit/UP4kv8JemdC1m82cu7b2t1hdqdCN2/GCLwxdtjSazX8ZGVu1tz6Ig4OLFupVd
	 0zV9kMjDafvSP2QVTuxGb+VKOv+Lbo3l38HAwg3rf0E46iSsvtC5Yl01tuSjcaa2NF
	 TXx2LbFMxt8oovWVM/OfDfU43s7tYYjmSx82fCsg8ePnmKztCGuK+yZE2SjnELCvKh
	 G+K3DgHJyhu7mXWvMgskyNjsojY7DtBrA2pml+lOE1SvoruaqkCI1qF2421Zbz9Mta
	 WhlEBZfTP9yNQ==
Date: Sat, 7 Dec 2024 18:38:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v5 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Message-ID: <20241207183824.4a306105@kernel.org>
In-Reply-To: <20241204140821.1858263-2-saikrishnag@marvell.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-2-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 19:38:16 +0530 Sai Krishna wrote:
> -#define RVU_PFVF_PF_SHIFT	10
> -#define RVU_PFVF_PF_MASK	0x3F
> -#define RVU_PFVF_FUNC_SHIFT	0
> -#define RVU_PFVF_FUNC_MASK	0x3FF
> +#define RVU_PFVF_PF_SHIFT	rvu_pcifunc_pf_shift
> +#define RVU_PFVF_PF_MASK	rvu_pcifunc_pf_mask
> +#define RVU_PFVF_FUNC_SHIFT	rvu_pcifunc_func_shift
> +#define RVU_PFVF_FUNC_MASK	rvu_pcifunc_func_mask

Why do you maintain these defines? Looks like an unnecessary
indirection.

Given these are simple mask and shift values they probably have trivial
users. Start by adding helpers which perform the conversions using
those, then you can more easily update constants.

