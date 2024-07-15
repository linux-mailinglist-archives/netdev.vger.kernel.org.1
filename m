Return-Path: <netdev+bounces-111579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A1931966
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25941F229F7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD55482F6;
	Mon, 15 Jul 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMhXP77F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40C1B7E9
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064805; cv=none; b=JuuRUcXYTApE9b2rt2Hx+9U78eRfIBKW0VyKyzcAmtckfn5zWQra9++cLztKcNrruZ9PW1LV40tLoIC35+mQ+SwYg+7NGla05zU1+M4RgeyrJ+kZGdueSTDodbkYQn7dAA9++Bq0UCLBR/gK6Ze2JmO2Fe4/7sEcEADSYmKfo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064805; c=relaxed/simple;
	bh=c3Gp1frGq4IjeEmNxCJSeLj9jjH8jY9jOnkPDQTrUaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s7idydG5Ym+YvRTQk45uZeTn7tUFYOTELAD6CQVawC+Viebzm6Yq095WfYI99A4q0i51AbbwkyGxT1iBwcW0cwIHfUgPZPSpu30D9FIAgF3MNZEWd+E+MtUuysb3CNMVY5NR1PPP7wtnr773m72EMXr5ECliF68k5Z9hMvnCz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMhXP77F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D412C32782;
	Mon, 15 Jul 2024 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064804;
	bh=c3Gp1frGq4IjeEmNxCJSeLj9jjH8jY9jOnkPDQTrUaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lMhXP77FyNGj+tFq/695DsjlXlh1yugXrJYSt4aBnf0PSIdwL3vkybQfo5zr+duwm
	 N+MWtfpIlVW1teNSPE7ficfloLBDuAtFV8/Z/IFhFP+5zgayQ43xfP1VH1lThJe+bJ
	 R2BZu34n8w1RjTLGa6Y+gTc761DFeKQnlO/GcLLI8ih7t1H1Mv1wQxA2X3T92Wt8Ci
	 ZLaSYE6rgzQl7M2CHY5D79iq5l6HktCr7TfcmjmqT8I4NuusYL/KIWBJmsK3ZmgZA3
	 xFrRl+NNFR6V2Lb8oc7IO5Mh6Kh900JkFPo38n3D+aumOpIX5izWKbgJq5wHJ51g5M
	 PhSaqxtKkQhkw==
Date: Mon, 15 Jul 2024 12:33:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 8/9] bnxt_en: Allocate the max bp->irq_tbl size
 for dynamic msix allocation
Message-ID: <20240715173322.GA435896@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-9-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:38PM -0700, Michael Chan wrote:
> If dynamic MSIX allocation is supported, additional MSIX can be
> allocated at run-time without reinitializing the existing MSIX entries.
> The first step to support this dynamic scheme is to alloacte a large

s/alloacte/allocate/

> enough bp->irq_tbl if dynamic allocation is supported.

