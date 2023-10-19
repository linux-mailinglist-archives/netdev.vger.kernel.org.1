Return-Path: <netdev+bounces-42458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423827CEC8F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BB5281471
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86BA181;
	Thu, 19 Oct 2023 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn3QZbYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA917E
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6BC433C8;
	Thu, 19 Oct 2023 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697673968;
	bh=FewQDix5K2xzAqhEssDfKbDVEbx1s5sPncq91M85278=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gn3QZbYryeidX644ynsDuCfrmYPm2P5XG6htQ/pOT3DE3q8AMTNv9ptmyIome970B
	 nC2jsZZByDg1FKnz6AyBJkvCXqHRCua1y+C4faqDnx1a6xuqRA6Zbyqwh0qRdzE6TH
	 Z0QYkWuXRnlj38OUXIoz12qV/giPYe38FlDGGoFdfNQr6+Omgxyg51xRlNC42nT4Eu
	 A+72j/DJ1U8w4xkqz9g2EQDoW1pDGt06vEev/lIS+5RQgk6v7k2GzC+Qm4dToazk6t
	 YpmozOK/cditkAO773VxfnUwBLYxWslhsB6qWZ0ZdLhp+A6M0NJJStHto4HOcEeXIk
	 P8eeM3NaDUncA==
Date: Wed, 18 Oct 2023 17:06:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <horms@kernel.org>, <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
 <hgani@marvell.com>, <mschmidt@redhat.com>, <netdev@vger.kernel.org>,
 <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Message-ID: <20231018170605.392efc0d@kernel.org>
In-Reply-To: <20231016092051.2306831-1-srasheed@marvell.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 02:20:51 -0700 Shinas Rasheed wrote:
> Clean up structure defines related to hardware data to be
> attributed 'packed' in the code, as padding is not allowed
> by hardware.

Looks like the patch was marked as Changes Requested in pw.
I'm guessing it's because we generally discourage __packed.
It's better to add size asserts, e.g.:

static_assert(sizeof(struct octep_oq_desc_hw) == 16);

__packed also implies lack of alignment, which may force compiler 
to generate worse code.

