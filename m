Return-Path: <netdev+bounces-27557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9677C653
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82788281288
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF31C13;
	Tue, 15 Aug 2023 03:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DF622
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 03:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B7C433C8;
	Tue, 15 Aug 2023 03:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692069783;
	bh=3+FTO5tYbyi0mvftVJwDIuqYnqD2lynJbuJhWEOFv1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDjT8cCx82/67tu2egRePi9MaFGJvhbGmQdECqvo3CMYdryzy5u1IkjR1YOVlL9c3
	 YyBOTPAFUmedSEl0lngnxJeQjXUg0N3pu9DdN/2PL1jRsrY4X7rmiLOAKJ6SEWhovx
	 wh5zpVLlWqMTw7ydONqAUZVo/Rt24gXumrstNuqDv/w6mycYXkjKSDgTrN70shfk8L
	 G4wqRmevtZvHMTdTSXhKPmpvGYlR6kAsG7GXGEczOIT/Rlzfk5L/kFVzOj9Rev7iCm
	 o5N5AfLFEYsmCJm9KK/OywOrhC+6eiL08ImPk0dTLXJ38Haicc4dMoCf93o0lRx5Hs
	 MRRNk9E5qw7Eg==
Date: Mon, 14 Aug 2023 20:23:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 4/9] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <20230814202301.13768f0d@kernel.org>
In-Reply-To: <20230811200340.577359-5-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-5-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:
> +static int
> +dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> +		  struct netlink_ext_ack *extack)
> +{
> +	u64 freq = nla_get_u64(a);
> +	struct dpll_pin_ref *ref;
> +	unsigned long i;
> +	int ret;
> +
> +	if (!dpll_pin_is_freq_supported(pin, freq)) {
> +		NL_SET_ERR_MSG_FMT(extack, "not supported freq:%llu", freq);
> +		return -EINVAL;
> +	}

NL_SET_ERR_MSG_ATTR(extack, a, "frequency not supported by the device")

