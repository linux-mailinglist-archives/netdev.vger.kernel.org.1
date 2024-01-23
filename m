Return-Path: <netdev+bounces-65182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082D839771
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62A3B2365C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907A8121D;
	Tue, 23 Jan 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQY5HHFX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550C5FDA8
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033875; cv=none; b=EWItf9bb9scJQ9Kf3mspe/jzH8c/IPmhNo+qoxZmWiutVgrbJoiBGID63kZWJ/uFe38pqsw5UaMiuTozP/B0ZDAFIcTHWWquREjLMMdfhhFMeiWtjHm4SMfMYTKwQFKdPeel4XEpNLX03Dr98/D72zDhyC8u2qWkO1QP9ZM7SOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033875; c=relaxed/simple;
	bh=4IEiuQn1tYB7kJdcLqc3Dj1ls2j9EyzuQzEAOUIuVPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbXNUcd4fNvWY3l0MoqsMcr2NLqDiOQFN89GYQRuw0ITIWTM5noovHco0hJu2/WBtRbIzBphEwhiz91xVPyvWIv0Da8cMV2eoE0/bDzfesieHF9O7UJZSf8m279l7NGurlC5vZiOzoCEqUIAN9qDMXMPIoNDpcY7iGHVVQoCb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQY5HHFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE64BC43390;
	Tue, 23 Jan 2024 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706033875;
	bh=4IEiuQn1tYB7kJdcLqc3Dj1ls2j9EyzuQzEAOUIuVPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQY5HHFXHurQ2YFxoDjH1Fh9ChgZYmRf+6rubgAIwQYhJ4i57eK+xbYIrz3dsWOIf
	 PBSBlsIldcrEwZDYqexh4C+ZZ7tyg7MjdTmGxpdBC+SLCoXuwM24ibPsgKAoDDj8UT
	 S6w8Opr+xfArx7hUx68FdzcNwBe//L0gZnH387HVbEBae3laf4QTt1CuFn1aACCuHu
	 tgBx3/x2VDHE6ghSOSDOHnyCI4htKuVcx3jKT9F6cLIzePRoAtP/rBsb969Lek0NY9
	 Xyi65SDuz/iJDre3N38m7T5OjC18N/9Ta15cwpjN3dNRY89qKxiHKGdpcWMdjH4mTM
	 t+MIKr2nLMRTw==
Message-ID: <158eaf99-1018-4ef6-bfdf-5f86464aae83@kernel.org>
Date: Tue, 23 Jan 2024 11:17:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] m_mirred: Allow mirred to block
Content-Language: en-US
To: Victor Nogueira <victor@mojatatu.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
Cc: kernel@mojatatu.com
References: <20240123161115.69729-1-victor@mojatatu.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240123161115.69729-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 9:11 AM, Victor Nogueira wrote:
> ---
>  tc/m_mirred.c | 60 +++++++++++++++++++++++++++++++++++++++++----------

missing the man page update

>  1 file changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/tc/m_mirred.c b/tc/m_mirred.c
> index e5653e67f..db847b1a3 100644
> --- a/tc/m_mirred.c
> +++ b/tc/m_mirred.c
> @@ -162,15 +167,38 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
>  					TCA_INGRESS_REDIR;
>  				p.action = TC_ACT_STOLEN;
>  				ok++;
> -			} else if ((redir || mirror) &&
> -				   matches(*argv, "dev") == 0) {
> -				NEXT_ARG();
> -				if (strlen(d))
> -					duparg("dev", *argv);
> -
> -				strncpy(d, *argv, sizeof(d)-1);
> -				argc--;
> -				argv++;
> +			} else if ((redir || mirror)) {
> +				if (matches(*argv, "blockid") == 0) {

Not accepting any more uses of matches.

> +					if (strlen(d)) {
> +						fprintf(stderr,
> +							"Mustn't specify blockid and dev simultaneously\n");
> +						return -1;
> +					}
> +					NEXT_ARG();
> +					if (get_u32(&blockid, *argv, 0) ||
> +					    !blockid) {
> +						fprintf(stderr,
> +							"invalid block ID index value %s",
> +							*argv);
> +						return -1;
> +					}
> +					argc--;
> +					argv++;
> +				}
> +				if (argc && matches(*argv, "dev") == 0) {

This one is legacy, but I really would like to see it as 'dev' (versus
just 'd' or 'de'). Such a change is risky from a backwards
compatibility, so I guess we are stuck with it.


> +					if (blockid) {
> +						fprintf(stderr,
> +							"Mustn't specify blockid and dev simultaneously\n");
> +						return -1;
> +					}
> +					NEXT_ARG();
> +					if (strlen(d))
> +						duparg("dev", *argv);
> +
> +					strncpy(d, *argv, sizeof(d)-1);
> +					argc--;
> +					argv++;
> +				}
>  
>  				break;
>  


