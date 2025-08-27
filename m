Return-Path: <netdev+bounces-217125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CBB376DE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C57C08BF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F351C6BE;
	Wed, 27 Aug 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpTFmjNe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD54A33
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257831; cv=none; b=rgR0Qrf1Mg5vR34NSNDElQk/ZS2vtiR+jqQ77z+D+KymSBd6/tV3fKx7HbZ5xZwZ+atgdyCMOZsoYmR86bZ2bEhBAWkG7AV53kFNB9XptYLq3haHKQ8XtIUladHUhK2zsmGsaPkFjeZxpsLHIGsRgLSADWJlSFj2Txbsr+jkp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257831; c=relaxed/simple;
	bh=JQH0PsWnt+cKawqt4crmG7LvorBNvpD6QAJUB+XmxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDixx83FR3kmDAa6qDp/4Kqck1Zmhj19koXt/GuJf2fhne0R3E4D7GlJTVQI9YrSg2RmYl2rHgXEhDm9zO0qbYs5utGLWoyrvJv7WYeBJT0zSrVVSkrwrrV2MXrZnMTl/VrwJOhHpHkl2s0woC8uZU1gDWTTwX1avdGSUS6Az/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpTFmjNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F7C4CEF1;
	Wed, 27 Aug 2025 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756257830;
	bh=JQH0PsWnt+cKawqt4crmG7LvorBNvpD6QAJUB+XmxHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XpTFmjNetEnPXlvAplqt2xLarihLbg9G/bLnfd4vFom7XmzVgzMHqWXYSGnwNNG3o
	 jLegU+CMR261RhW4a4QaDL2Uq+E9U7BONMU/srtmnSJBrpkFx02KWHWwi2jAvtrqpu
	 wB7J7NtdVxwkddhBypuScMQwOj94FYJREZgbKPbninMSe43dR8QLEWBdfYeo8OeTku
	 /rGqzCUUhdiqcrPLck2VLLcXYxgEQCF+14h3canJHGVYAQtSbjUV0UT6gWcC1eP2+9
	 nc/KEa68+8Emi03fAk5Uk442e9YocKoNsTXIUsBuE2dfJ6EGjjGWdAiFN6Y+esYd7y
	 Qchp/xf38Bp9w==
Date: Tue, 26 Aug 2025 18:23:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Parav Pandit <parav@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 1/7] net/mlx5: FS, Convert vport acls root
 namespaces to xarray
Message-ID: <20250826182349.678c87ef@kernel.org>
In-Reply-To: <20250821215839.280364-2-saeed@kernel.org>
References: <20250821215839.280364-1-saeed@kernel.org>
	<20250821215839.280364-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 14:58:33 -0700 Saeed Mahameed wrote:
> +fs_create_prio_err:
> +	cleanup_root_ns(vport_ns->root_ns);
> +create_root_ns_err:
> +	kfree(vport_ns);
> +	return err;

Please name the goto labels after targets.
-- 
pw-bot: cr

