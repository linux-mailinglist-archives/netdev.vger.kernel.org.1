Return-Path: <netdev+bounces-146257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904409D285D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A647BB27EAB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827321CC8AC;
	Tue, 19 Nov 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+vDgAsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E560E57D
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026795; cv=none; b=PZxB0Y1+SaW1EYcoKQSETF9XYyBeeDavUzmabMqAN4r3NaqAK3IvhXxzR+B15qrLI1kv0xYzMm1DtNIXPwXX0WfvTZONkH3zqcA17FpRXW+HqsqVTND6yocaIsy2laAnFLqhc5a1neFeesZuymmB+8uekHSsC4vhHzhbIcw/Sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026795; c=relaxed/simple;
	bh=yMZ7j7U/AT+PJdiv1a/w8sXvSkuy7zWhwNXzWJnQzic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVVZ8SIZj2dQi8dQMGn0T10nlUnPW5fGHtxbdkLaTN9XFepQkjZMkRTid4+8vkPEk43YcE+wFB5yt0GBgEBY2y1EptkCp1imSu1F9lMY3WngNYIYX9ob7dIEFHIg2uRJlaAkHJuTEUi8/+qf9ckBybHxjjk7wl0FjqCKDpr8ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+vDgAsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103AC4CECF;
	Tue, 19 Nov 2024 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732026794;
	bh=yMZ7j7U/AT+PJdiv1a/w8sXvSkuy7zWhwNXzWJnQzic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+vDgAsFtVBOU6MD8PQ+TjrHP23rQB0josfcQHLcOB+udYhPdUFOq3IgPUNO4zcxG
	 VfNZ2Slx5RVjMkoXa5oXVPOM1hukwKaiUPAahkmcwtuXdzMMWYhnShqX0U35zVchkq
	 4hys6v74njiC18KamESY7+b+U875yxiNPW7XiSizmLG9iHktRi5kD11KsmUjwcEVJ0
	 4iz1idKz/2k2CYv3RwzLodoc348VmUS2z5sXoR7Y4pLhuJnT26QOlC+4OsI6K8D405
	 uf2q8jGzvlJIr3Wf52VDnJh4vYPaqMakW/iUQPLNNmqbNLPAj+40xiZJpHfwKVPu3x
	 z/4ozrvDXYiXQ==
Date: Tue, 19 Nov 2024 06:33:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, donald.hunter@gmail.com
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20241119063313.5bc46276@kernel.org>
In-Reply-To: <Zzxa13xPBZGxRC01@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
	<20241117205046.736499-4-tariqt@nvidia.com>
	<Zzr84MDdA5S3TadZ@nanopsycho.orion>
	<b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
	<Zzxa13xPBZGxRC01@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 10:31:03 +0100 Jiri Pirko wrote:
> >It seems that type: indexed-array with sub-type: u32 would be the correct
> >approach. However, I noticed that this support appears to be missing in the
> >ynl-gen-c.py script in this series:
> >https://lore.kernel.org/all/20240404063114.1221532-3-liuhangbin@gmail.com/.
> >If this is indeed the case, how should I specify the min and max values for
> >the u32 entries in the indexed-array?  
> 
> Not sure. Perhaps Jakub/Donald would know. Ccing.

I haven't read full context, but all "nested" arrays are discouraged.
Use:
	multi-attr: true
and repeat the entries without wrapping them into another attr.

