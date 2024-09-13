Return-Path: <netdev+bounces-128127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759D978293
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CB8284A1B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD45228;
	Fri, 13 Sep 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7+1cwJG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCD29CEF
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237900; cv=none; b=sONHbclJ3KVA+qcfWR9Hw0WXNlKnUT5U97vbPJ0IO0wgu9TUnfTMLSMYw+jjXgh84Er7EnmCCmq0mIZVpfFTW2BrpoOHVNkvLyiThm7EpBWA/QaUSA8QDtQngRO4csgpsgLM1wUOnK9SoFpPM2rUZ1ZM8gJTElHTcnLrdTl2mxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237900; c=relaxed/simple;
	bh=6hzlkmU/otjHcIH1IYUQ3U6UY9QZ/4UUgEYWCdikcWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4/GQNMLAVG8v1ruo/K5l/cSI8gbR/YFvYUTbishnNUYsCni/mBl6TjF01Rb6ZB49J2Vl96Nzv+PpJOpqAIq/04w5K0mFww44KvcPVgxmZoR8X8mkEX1HP/sNvXKrr/j0cZjEiHo+Ip9wX0BoifscgY3HofiIk9j+LfgeWQc9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7+1cwJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71107C4CEC0;
	Fri, 13 Sep 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726237899;
	bh=6hzlkmU/otjHcIH1IYUQ3U6UY9QZ/4UUgEYWCdikcWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7+1cwJGT4ScEQVEZLiFVDytUVorcyCQmNUiPUC/s1g+5Ebg/9gUC96GNQ34bthoV
	 fNtedZMYcL5FKPwjYYNkKycUGp31OdJIfoD8ius6QJ9E/U1j3SM4UGdSLR7lGHQiUb
	 Z9sHGMGIH3xxnEXYKfyaRHHuftlHEXWfDflGlhDjFI8eQ6VhjqlXIDLAP+GhrZe4oh
	 YMNhjBoy3HY5C8al1GBGHYDuv05fdc5Dt1zGKmdLN+onnNkac3RfNcZLaw5Hi6PNaQ
	 t/6+jb/zSZ0Ic4c3YRfOoO9svhpzdzqqH5VUzHBDwiqiGujzsVraN3y0EYJaqrqL0W
	 YMt2Usut0ysEg==
Message-ID: <a2dec615-4f4b-49bc-bf0f-3ed0e4b5a7c6@kernel.org>
Date: Fri, 13 Sep 2024 08:31:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: avoid possible NULL deref in
 rt6_uncached_list_flush_dev()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "Eric W. Biederman" <ebiederm@xmission.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240913083147.3095442-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240913083147.3095442-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/24 2:31 AM, Eric Dumazet wrote:
> Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
> as spotted by syzbot:
> 

...

> Fixes: e332bc67cf5e ("ipv6: Don't call with rt6_uncached_list_flush_dev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



