Return-Path: <netdev+bounces-119346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81224955482
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2C283836
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC38184E;
	Sat, 17 Aug 2024 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBPa376E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F2653
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856955; cv=none; b=iZac+rXQXQm6jNYa3v1J0tmmHSaBnoSoZ66mE4A/i/Kq2GJTIzPFyMPVTeUPFFFXTJWnAdn1yxGJfnWRQE0b9hJCqTTlSylRFL3qZNOnSLjEK4mggtPcMVidb39U7hk73+JkGAAdcssLqFLKiBJI2MZTXvORT65QH5tcsa79SDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856955; c=relaxed/simple;
	bh=IH5Q4MVwKE+usU7hS3dKrIc6apEhco1WAITeXgYftek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhbZy8gFxCSdOYawBkU5RxIKjUHOR3r8i23lghmMOgZ+4QSbxUqGBobOWn5svaTyIY8l/+O2GZ+tRjlkfpHxakyLEp3c26O+h26FxOUMh7bHlU7WBRU8lX6fyhEHhhkMi7U1p31AzMrSrN4m7pEQVGDByXrUQgYOiK07dnP+7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBPa376E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897BBC32782;
	Sat, 17 Aug 2024 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723856954;
	bh=IH5Q4MVwKE+usU7hS3dKrIc6apEhco1WAITeXgYftek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NBPa376EIIzaz8vH9M/LyvJzPScho7K1bhFpY9FJ8Pj3rqnIx6z9Vzd5thbHTHYAb
	 p7NXzVUbd9yJ+91BQTyLEsEVgSBq8fmQjsbadwnI7vgy/m4F4Y5RVCV40CVgltUoTg
	 YHMw4gO9ZfxvQwuXxhWx8yj9X44EpeSSzQegBLEpUzKb6ETXlr3UJYe8iTA2yuwth8
	 GgrOS4UABHR1G+OlxVGMWGc96/MPxrt6S+1B+Cwp+bZlcjj6VqrDJtQFxgswYBznnr
	 jHNFbbV8S6WE8lcKGj+CcFT4Qt9CoM9cPW2e+2xmbkhpyit5EW35j2YuW8pYg59aTk
	 KRmTBDkQvNv6A==
Date: Fri, 16 Aug 2024 18:09:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 felipe@sipanda.io, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 05/12] flow_dissector: Parse vxlan in UDP
Message-ID: <20240816180913.73acfa7d@kernel.org>
In-Reply-To: <20240815214527.2100137-6-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
	<20240815214527.2100137-6-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:45:20 -0700 Tom Herbert wrote:
> +	if (hdr->vx_flags & VXLAN_F_GPE) {

sparse points out that VXLAN_F_GPE needs to be byte swapped

not 100% sure I'm following the scheme but it appears _F_ flags are in
CPU byte order, and _HF_ flags are in network
-- 
pw-bot: cr

