Return-Path: <netdev+bounces-54947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E69808FC0
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B931C20958
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A514D596;
	Thu,  7 Dec 2023 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcyiJZEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77354A980
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01BAC433C8;
	Thu,  7 Dec 2023 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973306;
	bh=l1836QInH1YKUP7iP4792Lwn6+xdCYLSqY53pHjj9qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hcyiJZEjWdA2zZteNun1wqy42M4oKs7RX9psa3H502PaylKT9cW0Z0OUeVzFwYsir
	 WP8nSy54AdlA7F+XO7+VuWm/6D/b7zQdMc5hkt5TEOqXfma08rCN8+9JytLrps8Meo
	 xD4vsZQXrNo/DX4nLPTnstHDHihvtxicpu/vrznMC93eFbExsmq8jbe9FExuPFAXxY
	 exaIPxZexKqI6mf0EBeelAbPHzbR30xTEybJQU+L2/JTYGjFb7dmjWMciO/66b/7gJ
	 yegZOztNJB1tWk/Mv6cq6sQT70Q52I0zcfJoUIkhJgKJy/p3y6M3dXyd0eBwI8lhet
	 gzQHU9QC+wIAQ==
Date: Thu, 7 Dec 2023 10:21:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>
Subject: Re: [PATCH net v2 2/4] bnxt_en: Fix skb recycling logic in
 bnxt_deliver_skb()
Message-ID: <20231207102144.6634a108@kernel.org>
In-Reply-To: <20231207000551.138584-3-michael.chan@broadcom.com>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 16:05:49 -0800 Michael Chan wrote:
> Receive SKBs can go through the VF-rep path or the normal path.
> skb_mark_for_recycle() is only called for the normal path.  Fix it
> to do it for both paths to fix possible stalled page pool shutdown
> errors.

This patch is probably fine, but since I'm complaining -
IMHO it may be better to mark the skbs right after they
are allocated. Catching all "exit points" seems very error
prone...

