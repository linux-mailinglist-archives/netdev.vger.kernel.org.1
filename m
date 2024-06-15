Return-Path: <netdev+bounces-103751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5051909543
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477BAB212A6
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F209804;
	Sat, 15 Jun 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD5Vezln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59866635
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415474; cv=none; b=hK5PAFKYNCEO8tILJXU5sXkq8RWBDu7XXbooXj0ZY+ItD86x7yIGqPoVXuQzPBGndD+mmrRRWBuz4sxTXgDPtG7LnCtrsQDzqgoq2OecA4v+SzCpehVrdnyntoiA2y0bGnIuxmOFoTXukmlChvTW+MaoLFbax4TFtjtr0f8rB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415474; c=relaxed/simple;
	bh=uLYMqbPswsiBUYSceRCISq+dDOntPb6pjZk5ByyaOGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yooi1ET67DIZO8LDjycsmgCqayi5Xdu/6tM7g+VsB8eoKFa9LlrvdvQUuC9ZIt9SsI+8lWNdajJAaDrsNfLOLcRtQYrIl3UdlHeZBb6/DBItGsY/3bA8bXhqcvGKkg04AUff5iHOjpFStEW/Aw9tkeNE6wUYjF07q3IfmVnLhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD5Vezln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B0DC2BD10;
	Sat, 15 Jun 2024 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718415473;
	bh=uLYMqbPswsiBUYSceRCISq+dDOntPb6pjZk5ByyaOGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lD5VezlnDFXrknSO1Q1bqkeCTencNpzvKChzgN9vY+FXesf5EUPl1X1UURcg9xOl0
	 9SbUbpMGoDUbcjra5ntWFlWNbCaGy5Got35+Di4a6zwu1c0ADeKMU5OgHo65UhCAxP
	 SU+qDctgHgRyBp6miCNUqMMeIv3oGdV9+ISXoq7NNB0Nqj+m8MHk2I5pXZFFo1KIIE
	 JlrZDHWcPPJJKYtpZpfVp5XIn/lHM8/QU1Y/pznEl5kmLgjdHGatpsYb+MiBY6bwgw
	 GgQCPd5Um0f/YlU8TZv5FPfalY3Y+65X9xBnd/FZOQ/aK9iWpX8a2wQ9pEJDH142WG
	 6lwPM8kymDWlg==
Date: Fri, 14 Jun 2024 18:37:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net/mlx4_en: Use ethtool_puts/sprintf to
 fill stats strings
Message-ID: <20240614183752.707c4162@kernel.org>
In-Reply-To: <20240613184333.1126275-4-kheib@redhat.com>
References: <20240613184333.1126275-1-kheib@redhat.com>
	<20240613184333.1126275-2-kheib@redhat.com>
	<20240613184333.1126275-3-kheib@redhat.com>
	<20240613184333.1126275-4-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:43:33 -0400 Kamal Heib wrote:
> Use the ethtool_puts/ethtool_sprintf helper to print the stats strings
> into the ethtool strings interface.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>

minor build issue with this one:

drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:453:6: warning: unused variable 'index' [-Wunused-variable]
  453 |         int index = 0;
      |             ^~~~~

otherwise LGTM!
-- 
pw-bot: cr

