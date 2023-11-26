Return-Path: <netdev+bounces-51158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34227F95F0
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928BB280D45
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027914A80;
	Sun, 26 Nov 2023 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJJu32y9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497312E56
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C52C433C7;
	Sun, 26 Nov 2023 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701039299;
	bh=ikD1IcWn7pY0Kg0l7nVoix086nkdC/HUPPp5zrf1b4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qJJu32y9fKFumvgnuECyyu2TS9UMK5Ap6sAmKlCfNCIG1Ao17kQtALBfEDRHWruyO
	 DySl8NfRpcr0kz1FfH4ylkBz9WhCBgh1+yrcz1LlzRXqi0F9fbuqKnm0Y0EkefUhBv
	 +BlB1H8xSLp75zBwmJO7XbcyVO3eU+mrChAMiPaESALpb0qMwVpHK4if+s/SYfXFhh
	 z5cka8YmKQ06Ep6beWWA8c//zo/sCaoGMbvkO8tsW5erj/DaDz8pZtydLkcg8wYb2O
	 CuVWAF09Fi9PHhwx4TTHQM/mIoGXhKf0+nUBa0QWRwhdql1pBW2d92lF+pfo0q6CYZ
	 pehRSiZD2QmSQ==
Date: Sun, 26 Nov 2023 14:54:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, David
 Christensen <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Paul
 Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
Message-ID: <20231126145457.400726e4@kernel.org>
In-Reply-To: <20231124154732.1623518-2-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
	<20231124154732.1623518-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Nov 2023 16:47:19 +0100 Alexander Lobakin wrote:
> -	long frag_users;
> +	long frag_users __aligned(4 * sizeof(long));

A comment for the somewhat unusual alignment size would be good.

