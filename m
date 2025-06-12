Return-Path: <netdev+bounces-196952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548DAD7141
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088B4189A3D8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F923BF91;
	Thu, 12 Jun 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4hUTc74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077B23BCF5;
	Thu, 12 Jun 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733691; cv=none; b=XwmxcwLNRoeQ060Dhl2yRpqe0pEziS49Vt48CMkZZSN01sRqM8d32JStclNuNbc7xNcNIFFlJA3wPPpeEDRDeLtZv4cn19ta5HyLFGpGDQ8H8bKk3XkOJpw31TrcVoU+OacpbnyVle1YZhzkEg31qAESo9tEU6bm/08vjwreOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733691; c=relaxed/simple;
	bh=8LqQ3WpulRQxv6yiLQBLvRK1gxzUm9ax3ppeC5xwnMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6fEjq3ndFz4xEcG3AFFoyWi/dwOi9Mi3b5w+k/foSlZjo/h/vq0MDPdfY0Vadz6dJGuTEYw73xFgq8Ctnnpw9LNlHM8fP0RPy7xl9HPEKQRCaZRejpgdNUWxgnKgrg1N7YGAdMit4DtqEyZR9PildMkDFul8VhzH25ECuSbgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4hUTc74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5927C4CEEA;
	Thu, 12 Jun 2025 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749733690;
	bh=8LqQ3WpulRQxv6yiLQBLvRK1gxzUm9ax3ppeC5xwnMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4hUTc74+foIl3XCre/7PHcphwJBhK/25PgzC+eLn2yX5qpddu6EDA6fzyn1F0b85
	 zaXyHBSs+RpXiYhciySiAG+jirEgIe6BBdaSTNpVWDbgcWVE6QxzDj8zSrMqc7xITu
	 kcYq3H07vSXygazUYpJrkebN6KqJUqUBjmEcJNzc+gJTnzpn9nONDuruseuq8sXcR0
	 QGxfKjsegIs795txf9KNBjAZh8GaW7gbFnCo8co+RhRjIoYL6TkiCYZZMvSvexxeTQ
	 zHQXGGcAepQ6SoXp+jsg654pY+pxkROgKLjAjh93Gifx06NXYI3iKRWE7CF0yBi+aK
	 EnANXyGY2czlg==
Date: Thu, 12 Jun 2025 14:08:06 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net] ionic: Prevent driver/fw getting out of sync on
 devcmd(s)
Message-ID: <20250612130806.GA414686@horms.kernel.org>
References: <20250609212827.53842-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609212827.53842-1-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:28:27PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> Some stress/negative firmware testing around devcmd(s) returning
> EAGAIN found that the done bit could get out of sync in the
> firmware when it wasn't cleared in a retry case.
> 
> While here, change the type of the local done variable to a bool
> to match the return type from ionic_dev_cmd_done().
> 
> Fixes: ec8ee714736e ("ionic: stretch heartbeat detection")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


