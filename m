Return-Path: <netdev+bounces-172278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C030A540AC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919AE3AEF0A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8F1591E3;
	Thu,  6 Mar 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeJ1W48j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EE150997
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228218; cv=none; b=C+Ne3Bx4Q/ujU6pY+YAjkGorrllLx/ZqejLMXVDYNhpyDW9dhAsQQZX/vky+GJqErgPQ1SDEt9H8IjMkOxoUJPxdiAUAtjorZ9KN/2bqVeB+uszVsGxyt70i5vdMCepdrC5Wb+2bw2C39fw2TCU79ckJbfGti52s/NRY3VhTV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228218; c=relaxed/simple;
	bh=3VI+24BhgSgXutFDYAZNVMqgGzQkV2ma1GqqgYQJAF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWYY4ZoBDpnKiKxh0XbS4gpnXkXFmuZNVGuY47cAILZuDcnqRswslB6u8CBHnvK0+AcIThfP7YqVMln6YGx9IA5CLoWWJJtWwls24hFRXkU6sxlbHHrZtEXUTJyRjLocJ1KvpQxuRUXFDH2kIeh0JPxrAKqsN4Sgg/qw2ZNKry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeJ1W48j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F62CC4CED1;
	Thu,  6 Mar 2025 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741228217;
	bh=3VI+24BhgSgXutFDYAZNVMqgGzQkV2ma1GqqgYQJAF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JeJ1W48jc83VjeyD85OnliPmdD4ORJl7kjWDqGr5er96qn5tCTcDbEQoh0MwEieip
	 CVeUsWAfzBELINfs7qYP1p3Dh2SndlEH8sM73CbV+y/D2IqWohFD0kaC/nfQSfydfg
	 3/Na/gTt4BSwMg2ew2Ch/MTfBQ8zCdb9tQxEiv+MA9VsWGpHA/5ZHiJP7aXCJ68S01
	 hfTQA48/EGoPqg6wRoyAs2yjugoXIqM+dsp5ru2ZYgwjnyCIkrV4IiANuEq3i4/aX1
	 XuFtWnubapukLeMYWe/zlqwCOHOPpmA+bwCu3qQaDxdzLL8+c7dagNnF9bjPO7xFDK
	 4ticnLXmMzWPA==
Date: Wed, 5 Mar 2025 18:30:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250305183016.413bda40@kernel.org>
In-Reply-To: <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Too late, take it via your tree, please. 
You need to respond within 24h or take the patches.

