Return-Path: <netdev+bounces-144497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F969C79EE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592E7284ADC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5A17ADF8;
	Wed, 13 Nov 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1kbI14m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7A158DC4
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518866; cv=none; b=UBC5PmV+WCExR0yeSRwUHhSlUpFdNF5Ts0neHKVGv3nFSAv2GF73OAJtm/4mb7QI64JsD/OABO2OKLLlAbc273mAiXvSHku36SeIDde2FvD6af7/XET5OBEDtM1OEdVuOhGk6hK9/ANThRFWfdatTXsm7wPUiHjldkiTnMIENto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518866; c=relaxed/simple;
	bh=gJOLo2v8Fi931b0PuXOlRWTscuHccmq+3zjXTLBq7Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEnW+ZnddLb60QnPSKDdcJ1wCfPC8d8Pv5AcA/aXjcoRa7+clooydVc5ef9jKlX8EFUjV1DFkg9wu4+sVtlGjf4TuUko0J/IjYZDd8iWiK4W0VC/iysR6ZmHlGJ2v11O0wZiwc6+FFIFrNSaDMEDnhK75U6hDFMX5tscMxTtfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1kbI14m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E98C4CEC3;
	Wed, 13 Nov 2024 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518865;
	bh=gJOLo2v8Fi931b0PuXOlRWTscuHccmq+3zjXTLBq7Yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N1kbI14m3Nb/0YbpU73q8M65h6Gb1AImcl/Y/w1R9tIGnoH0AQcKIRJxDzQ0QSfcC
	 XDeRMttjFSvY8FTkEHS20Bc832QmWSNg8B7Ncn/QhuznI0EHJUT2Wfkbn/D8h6O5zv
	 OboFxKHlNBrDWVOVEMpXqRoD/rn9Eo2iBRlwnmrGdbU2dfy1hEpr0W47yqmlPETgfK
	 amPTjTNphK3AUT0hhhMVn4Ow2hIVdY34f8g7k/C+lcSvi4ad20/Z8+2JGJPX8MPmy+
	 IO373XzR98VaIa18d4jiJ7pQ1Oz8lAmP6fvPjHI+cSjsXZkJLq7K4FGetlEbaFaVN1
	 opTG6iQFwllvg==
Message-ID: <2df9d232-9d87-4c0d-b910-b82a0ba68986@kernel.org>
Date: Wed, 13 Nov 2024 09:27:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Content-Language: en-US
To: Xin Long <lucien.xin@gmail.com>, Jiri Wiesner <jwiesner@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
 <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl>
 <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
 <20241112085655.GA19776@incl>
 <CADvbK_dz9ewsEmGa63DgMOwRwFyE-evALq61CUYi54-K_WTvog@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CADvbK_dz9ewsEmGa63DgMOwRwFyE-evALq61CUYi54-K_WTvog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 2:51 PM, Xin Long wrote:
> This makes sense to me.
> 
> The code prior to 92f1655aa2b22 ("net: fix __dst_negative_advice()
> race") had no longer been able to release the cached dst for the
> reference held by socket in ip6_negative_advice() since
> rt6_remove_exception_rt() is called there.
> 
> Hi, David Ahern,
> 
> Can you confirm this?
> 
> Thanks.


I am traveling this week, so even less time than usual for patches. I
will need to find to refresh my memory on the history of the code.


