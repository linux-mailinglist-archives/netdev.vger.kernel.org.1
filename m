Return-Path: <netdev+bounces-125141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5696C046
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028F81C25160
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA31DB551;
	Wed,  4 Sep 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpLZmGsI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2011DA2F1;
	Wed,  4 Sep 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459789; cv=none; b=Y5XJfRlCn+srk0xUh1fFCvW1CbRGyTf+XsaT3N/EMbPR0RdlFGNoNBuCNyMs8xMEvw2LRdP+4cCOe2b/MXzGEqN4q9E11fcm8I54/MenQ+4mTZKLMV5n5d6cqpXnlJrhxSthaX0smgsrYx/VjIfBwdS0ld2wQnMXpKGsC+6+JaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459789; c=relaxed/simple;
	bh=Km7Er5CuoLQVJvJnRyZ84Ji10/rmh0uRaNVOeng6nqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP4FB6TxdV7Mg1rXHNxqXMFqH+jK19kJBhKRrV9Q37aY39bckCpnvQpYE4R1P6zhMfWmmv2fCYn0yD4rqiS625R012fOVAS93nQ2NVwDyQ2KWk7LsYb//xjZm46J5O7loUMjPaXioj/fhW9Hsl1hPS7EGMQY3tBl2gHf3gEe1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpLZmGsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97151C4CEC2;
	Wed,  4 Sep 2024 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725459789;
	bh=Km7Er5CuoLQVJvJnRyZ84Ji10/rmh0uRaNVOeng6nqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpLZmGsIflHyNmyrPxkeYu8PRrBIaMNLuXVuG8Zt2oHACjwj4Qw5LtW5XsYGm5M5H
	 qw8HrOKGfMkbG33kgoHGEW9z9IQiSHHvMcrmZ8tQZHyZT9SskR//EP+6pRgqTmKnmg
	 hcmhfFrtnjHOp23Z0jT9/6eu4MYl973GvYh/khpQLxOi1gqK+yTOyL/B2SzZCOHL79
	 tzN+v1uGtebmlysnXI6JeftqAwGNlRS037WSUf+7qvy9EF5zKHepiWYfreBifIG9Pp
	 xDs1AX7cAr99FxbyToGOelMPTIvUB5u30X6OKZz+MrFAlYJ7+eerVOXJOnwY0S6f/4
	 3WFKy3Xzmkw8w==
Date: Wed, 4 Sep 2024 07:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Igal Liberman <igal.liberman@freescale.com>, Madalin Bucur
 <madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v3] fsl/fman: Validate cell-index value obtained
 from Device Tree
Message-ID: <20240904072307.1b17227c@kernel.org>
In-Reply-To: <20240904060920.9645-1-amishin@t-argos.ru>
References: <20240904060920.9645-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 09:09:20 +0300 Aleksandr Mishin wrote:
> Cell-index value is obtained from Device Tree and then used to calculate
> the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
> In case of broken DT due to any error cell-index can contain any value
> and it is possible to go beyond the array boundaries which can lead
> at least to memory corruption.
> 
> Validate cell-index value obtained from Device Tree.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

coccicheck complains of_dev is not released, we should fix that first,
before we add more returns here.
-- 
pw-bot: cr

