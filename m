Return-Path: <netdev+bounces-154094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589C9FB407
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2481885173
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99418A924;
	Mon, 23 Dec 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG7efAUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99901FB4
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978723; cv=none; b=PGvS65qNYsJIaoq9yRA50FRos9ViA00Ajz143EytV0CskHXo1cs5gIZfmRloFpQuAOyw2XjJtSh1+EgyzOZPSsj64cCkMxJZd3xreEc0ugirFI+CUL1SIFPuFxZHU6PT+gL8l76osckFshBxX2wSM+gilruHsmc/G8lJg+NUpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978723; c=relaxed/simple;
	bh=y9bJAsNGq6SAhO8pvPWsDPwViwj+lQJ0Cb0wnpwS5Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EG/THzmWu6xHkOUT3qHorAmvUMrbRn7kvdzVN0Tvnj5ZbEPqOcxB7NrRYgd/TrSCyrBcDP8+p5ITGRdcQyNuwMpDXlT56moyTDEq/EMQowe93aGmSPOiGegDtJKhHTwUutB8ZcWMG+BSXu116zGWVMU27i+kFVP8oJrzpz1AfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG7efAUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C61EC4CED3;
	Mon, 23 Dec 2024 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978723;
	bh=y9bJAsNGq6SAhO8pvPWsDPwViwj+lQJ0Cb0wnpwS5Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bG7efAURkDmhnG8iiAjBu45b4l/aVt+mE91rSVF/MBOmFdn27p/6CnnNTpvSIXnaz
	 QSIZCHBH8AWjxvDRczxzneJpbNnvcenn7nD31PzmfgnPS2lOHj+yKE6H+mSmjrKugL
	 5+GGa3cxX+q+SJnXt2rF2pckw3P1wZ80eUETyojvtCcFcTCXOurehnr2YLybyX2nlW
	 KQggSvasf6gKq+5vKzfPR9Q2cNq24Gz2Gck3pDQ2zGhZW2G6ad2Zzz5shUB0gE/vHe
	 9L4WgRDnoXFzJ4rm+l7wmgXDHBz/7RV+ppq7CzAFyyQXDduAnoei4aoiGNJnaYcK6p
	 y3QyQMxS3koLQ==
Date: Mon, 23 Dec 2024 10:32:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "Rongwei Liu" <rongweil@nvidia.com>
Subject: Re: [PATCH net-next V4 01/11] net/mlx5: LAG, Refactor lag logic
Message-ID: <20241223103201.65a46a7a@kernel.org>
In-Reply-To: <20241219175841.1094544-2-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
	<20241219175841.1094544-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 19:58:31 +0200 Tariq Toukan wrote:
> @@ -88,13 +86,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
>  								      &dest, 1);
>  			if (IS_ERR(lag_definer->rules[idx])) {
>  				err = PTR_ERR(lag_definer->rules[idx]);
> -				do {
> +				mlx5_ldev_for_each_reverse(k, i, 0, ldev) {
>  					while (j--) {
> -						idx = i * ldev->buckets + j;
> +						idx = k * ldev->buckets + j;
>  						mlx5_del_flow_rules(lag_definer->rules[idx]);
>  					}
>  					j = ldev->buckets;
> -				} while (i--);
> +				};

stray semicolon, please follow up

>  				goto destroy_fg;
>  			}

