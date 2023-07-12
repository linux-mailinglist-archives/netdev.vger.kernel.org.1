Return-Path: <netdev+bounces-17286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4875114D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018CC1C20FD6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC921507;
	Wed, 12 Jul 2023 19:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4920F8B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E222C433C8;
	Wed, 12 Jul 2023 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689190574;
	bh=EogeTGIiuUFqzne3v5vm4Ifad7BZZ2pCtarM917N8FI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LpE3SJuNK4U7nmwc8P4oTt0ZKY7/t2LKkaEq8vEXLKYM8LnUOaJU0H7H0C+RhZ4mv
	 ttm0IOyk6cIjvzPIMUxFThldGR4abW/8Aknzi53P2wErDaQpIoPiU5gAaWKIhHWY/2
	 EtMI8/8C3jH0byvt5apBXNgnl9RERwkcMMqffHgnOpZH3eskXZXWBPo66ohtW4v88M
	 2PwmkAW2cUDbgkk5A8EJt8OgxuC1PcQY7W8Lqio7OUlzAwtDlHIBOOTXOOCOrGO+8I
	 2XW6vyo6jBcouoJXLjKa44KCxp5fRJDiXH8JHDYDCjwziNuOxnJLrYvZCrRG3IscTu
	 DEhB8WwhRBQiA==
Date: Wed, 12 Jul 2023 12:36:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <simon.horman@corigine.com>, Rafal
 Romanowski <rafal.romanowski@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Ma Yuying <yuma@redhat.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org (moderated list:INTEL
 ETHERNET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 1/2] i40e: Add helper for VF inited state check with
 timeout
Message-ID: <20230712123613.20a98732@kernel.org>
In-Reply-To: <20230712133247.588636-1-ivecera@redhat.com>
References: <20230712133247.588636-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 15:32:46 +0200 Ivan Vecera wrote:
> +	for (i = 0; i < 15; i++)
> +		if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
> +			msleep(20);
> +
> +	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
> +		dev_err(&vf->pf->pdev->dev,
> +			"VF %d still in reset. Try again.\n", vf->vf_id);
> +		return false;

I like my loop more but if you want to have the msleep() indented just
add an else { return true; } branch. Take advantage of the fact this is
a function, now, and you can just return.

