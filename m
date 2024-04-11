Return-Path: <netdev+bounces-87187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5C8A2092
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33F52853FA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95D15E8C;
	Thu, 11 Apr 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5eecZX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9666A36B08
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869316; cv=none; b=YCCsyJ+KOePWvzlb7kJ2fnLmyAxbq2UK14+rLHZINcIloJSTgRAgUcKa8Zcj/yi+j+NK3d+4+wwjNqd+gSjZfcnPhlckJjAH84i/9T3ejOVUqUpqrhcNKiRB+Xzh91OCZnR/IsqSf2hQg/Xvf4BpYzKF16FKp37S6eeNHR0Lgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869316; c=relaxed/simple;
	bh=/t1M7EFphEnTOUrwVj8tuJZBQcUFBNDqUEqA6cl4Ub8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkrlpOHL7MLi6k3lR9IRfDn2t4IJ82Hof0gqzxhXEGNkTSaRJ+ZywK2JC79xKXYaCuujt7K737wbnlcKgq5ztx6plEZiTOHoo7UCUf4cszsAnEFEa1qg6VIoVn+KsscE0xiqGQ6glLOEfUP8wFpZxHaENV49rHoEolcznij6snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5eecZX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E80C072AA;
	Thu, 11 Apr 2024 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712869316;
	bh=/t1M7EFphEnTOUrwVj8tuJZBQcUFBNDqUEqA6cl4Ub8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O5eecZX/fW49vep8S5uSsSpdv12dQt1PO0uKK9TaBbXf4hduDo/LwJoqZ3BtqA5On
	 qyOiMRMF5yS7K8MrRI/LEm2z15Ramp3bkxr4S7tM+IKy/WzEMO+y7qm3o0hg7aS7F8
	 GYEGzmXk92yV1cAI42v9+s8U738fIL7B3mzhQQO9jwQOFUMfZtuBmz+/5x6/kRgKcP
	 qLdXh8crd0pCFF8O0mDS2DGpOzFE/UxzfHBSaIC+7WpZGiNA9m3DLkQjAbytzjTEUd
	 IuO6Ld5Yc8YBR9Ac15qJJGgt+rvIgkSNQju80R20javxhjC9Dmd9GqwVbNvTdWtpkp
	 2Vpm6oL1i1VHw==
Date: Thu, 11 Apr 2024 14:01:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Stefano Brivio <sbrivio@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, donald.hunter@gmail.com
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Message-ID: <20240411140154.2acd3d0a@kernel.org>
In-Reply-To: <b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
References: <20240411180202.399246-1-kuba@kernel.org>
	<b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 13:45:42 -0600 David Ahern wrote:
> > +	/* Don't let NLM_DONE coalesce into a message, even if it could.
> > +	 * Some user space expects NLM_DONE in a separate recv().  
> 
> that's unfortunate

Do you have an opinion on the sysfs/opt-in question?
Feels to me like there shouldn't be that much user space doing raw
netlink, without a library. Old crufty code usually does ioctls, right?
So maybe we can periodically reintroduce this bug to shake out all 
the bad apps? :D

