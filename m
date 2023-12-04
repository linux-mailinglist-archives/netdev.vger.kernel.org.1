Return-Path: <netdev+bounces-53529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B1F803935
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044C9B20B32
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839602CCD4;
	Mon,  4 Dec 2023 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHfOsxtw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659902C18A
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 15:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4A0C433C7;
	Mon,  4 Dec 2023 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701705111;
	bh=iz86JAfRse2M54yW3YHgA3pdIOtlo3sqlSoB6Pg9O8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NHfOsxtwgV8faU/T5TyTtPw1DZdF7hLm9qRrwe4KEwUsKXT1gTEhC9EaDrq9J10CS
	 SAMmhyp9ZI+ViGxz9VRI4tRUDE7B+C9kGN+R3OeBAYPdOr99fCZg3hepEh0GScqn88
	 SHhEweHveIBBDRm9+W2vSZ9chv2d9P8257GEGhlaAHnvD1sS6v3X9DkShKquN9tCJj
	 q4XpMKer6wjuHZ3YBlJluPnBnf3Dq+52BFXOYsv/byCBgwtkKr38tiWPKwBSRwVHcR
	 LhgGVBp8q+fc2DFDS93VZhJ0QIzHoeL1/d7VMdX06kf//sSE0EWZY+6xHVlQcdeWuQ
	 JvnvaUK+bkyEw==
Message-ID: <695c2152-f7d0-43f0-919b-4df23840907d@kernel.org>
Date: Mon, 4 Dec 2023 08:51:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 3/5] tc: fq: add TCA_FQ_PRIOMAP handling
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20231204091911.1326130-1-edumazet@google.com>
 <20231204091911.1326130-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231204091911.1326130-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/23 2:19 AM, Eric Dumazet wrote:
> @@ -193,6 +196,48 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
>  			pacing = 1;
>  		} else if (strcmp(*argv, "nopacing") == 0) {
>  			pacing = 0;
> +		} else if (strcmp(*argv, "bands") == 0) {
> +			int idx;
> +
> +			if (set_priomap) {
> +				fprintf(stderr, "Duplicate \"bands\"\n");
> +				return -1;
> +			}
> +			memset(&prio2band, 0, sizeof(prio2band));
> +			NEXT_ARG();
> +			if (get_integer(&prio2band.bands, *argv, 10)) {
> +				fprintf(stderr, "Illegal \"bands\"\n");
> +				return -1;
> +			}
> +			if (prio2band.bands != 3) {
> +				fprintf(stderr, "\"bands\" must be 3\n");
> +				return -1;
> +			}

do you expect number of bands to change in the future? If not, why make
it an option or just a flag?

