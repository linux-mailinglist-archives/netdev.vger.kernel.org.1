Return-Path: <netdev+bounces-119345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D2955473
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23EF1C21CF0
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD4653;
	Sat, 17 Aug 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KISJjOPg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA278BE5;
	Sat, 17 Aug 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856466; cv=none; b=pY20svagLKvUoEqbBW976ty3pPn/WoXsof5E0GLrrO1H+Ku96FIU4qmWeGQyjC9K0TWceKE6kpthAJy2EM1H7LxGpP65ActSmFTQyWY1+yWJvrZTifdMKasFHig+QhtLWAMgHmIH+2F4nULlY98Dl/EDxDcbH09MQiCsMnsYHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856466; c=relaxed/simple;
	bh=8CTkRrTUj02ZIWcuNru1JzE+ShAl2rkLBUWuz0bcW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI5r+nu5xW6gwVY4JjP8wbombaHHj1XTqcVXHnnTZ+r+snpcGQYcRhRAWlx7QRt7r0HcnzcrxlN6McbQPt6RAnyf/v6yisJ01EBVIWwk8rJ/5Wg7IauWwGZLkfUX07Xys8gNCNZ2S30Or2/PwXuvF8pXW3yKONcctQinFRJVwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KISJjOPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4792BC32782;
	Sat, 17 Aug 2024 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723856465;
	bh=8CTkRrTUj02ZIWcuNru1JzE+ShAl2rkLBUWuz0bcW2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KISJjOPgunQj+5Y9SayxAL8YOSJgQmnPEobNZWQLvdowGLrneBOyjbs+3VC0Ntdxt
	 Ds/P9xVWuXswQgH+VHqW6n8vXvPyl3hrdgZUyQ1SzN0LS4MFfCFQanzAqzdrGT+xva
	 AFHcqEJsPa71AMpmN8iLT+b/whI90qDLCPgzszcPPH4DXzhM0rALR7AWdCkNitI3QL
	 tEBON6woIeRze/8JgrEMkOc+g44xvkyPqmyock0LNrLnla14o1e5ZcJqbTffCXkraF
	 zBnN0FC+flk8ipO1P+XVTce2ks27Nze8vB4vHZgW6kr1t6iZ/0Fkw/7/FQeez4Vrkp
	 GzJhBHbkadriQ==
Date: Fri, 16 Aug 2024 18:01:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, amorenoz@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
Message-ID: <20240816180104.3b843e93@kernel.org>
In-Reply-To: <20240815122245.975440-1-dongml2@chinatelecom.cn>
References: <20240815122245.975440-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 20:22:45 +0800 Menglong Dong wrote:
> I'm sure if I understand it correctly, but it seems that there is
> something wrong with ovs_drop_reasons.
> 
> ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
> OVS_DROP_LAST_ACTION == __OVS_DROP_REASON + 1, which means that
> ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
> 
> Fix this by initializing ovs_drop_reasons with index.
> 
> Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Could you include output? Presumably from drop monitor?
I think it should go to net rather than net-next.
-- 
pw-bot: cr

