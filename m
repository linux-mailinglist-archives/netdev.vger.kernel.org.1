Return-Path: <netdev+bounces-128887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0397C502
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E68282E1F
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0163F194AFB;
	Thu, 19 Sep 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ26g37b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116A7E765
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731736; cv=none; b=pAEBkSxzZWWxRlqyNGPuCsPvclvf6rt7xzsbTsUpNzf/GpYIVvNqzohPHYQZgGTEggWIK862/qFO0smipGTIJihFJesWTorGV+JVzYPSlZoNZ/+7mYHcZ4fNGyhgeLh8qHAe/qy3kltCNUU0hhEudGjTuS/Qmz4JIGfDehi05sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731736; c=relaxed/simple;
	bh=b5ZgASznFyGQS43/FLFjObXYg+ZQyRaf+h2bx2S+tAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwrlgenYC4jpiV0zABC/fRiDb9X8GmxuE480Hfg1pfseEshBnwLzBNKV0AjXhKP9br8vPRbMLf73I4R4Hs4evGOX8E/Jn2XTuVE69FHgXxYxXeqFD36PFwOnKZR7xtfEYBhTaYbbuQlrhpIdbjO/XstPkNinQOUV+ylUsI2QAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ26g37b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D27C4CEC4;
	Thu, 19 Sep 2024 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731736;
	bh=b5ZgASznFyGQS43/FLFjObXYg+ZQyRaf+h2bx2S+tAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ26g37b/hSaaj0YbAzmvbwIAsHHYOzDukUC3EzdiNpg8ILwY/9EplYvkpIRAqjgH
	 CH5/4ymS1Y83kn6SnQl7mZxK2S0iw+CQ3wsjZ3mF/Wa4PZvvbkhLOdjCF1l2a1TD/U
	 +Hou9TwujPjTgeT6f30nOqJ/78NndGnWY4bjiRfug0gAcJWBPMFaVUI7VQAcotEiBG
	 qLCqPOaztAoQENVR6axIzbgWIb1Zscc9KNjg1XES8tJq8+foNdi5R5ziWr+bajl8g5
	 lq1NpNSQ+r6rYbbhhdevioOutcz8LOpP5C+l20EzhrHlElkOwDJ4xtBHDK9IqWF0hX
	 5fVe5RL90GvNA==
Date: Thu, 19 Sep 2024 08:42:10 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Message-ID: <20240919074210.GE1044577@kernel.org>
References: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>

On Wed, Sep 18, 2024 at 04:37:30PM +0200, Lorenzo Bianconi wrote:
> Align PSE memory configuration to vendor SDK. In particular, increase
> initial value of PSE reserved memory in airoha_fe_pse_ports_init()
> routine by the value used for the second Packet Processor Engine (PPE2)
> and do not overwrite the default value.
> Moreover, store the initial value for PSE reserved memory in orig_val
> before running airoha_fe_set_pse_queue_rsv_pages() in
> airoha_fe_set_pse_oq_rsv routine.

Hi Lorenzo,

This patch seems to be addressing two issues, perhaps it would be best
to split it into two patches?

And as a fix (or fixes) I think it would be best to describe the
problem, typically a user-visible bug, that is being addressed.

> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

