Return-Path: <netdev+bounces-27728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB87377D06F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB86B1C20D05
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EE156D9;
	Tue, 15 Aug 2023 16:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20212B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51967C433CD;
	Tue, 15 Aug 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692118520;
	bh=0NoRpcHZaUX5im0cn9/N12oK9jNQtW6pqx60BrLK0cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/qtXebOTThtIYgLdqHqoNRqfFRfa9y/NntkWbmyTvfgyh9BOctmFKj8k3XAsH1JF
	 aoJAGqTrHqidY5JCD+vm0ExK6+BLcxDLSq3p717eHvClBAxkaQSQRbfU1psUYJ74Bd
	 kRbPS0rjZmAdOGYHTHVXNwPnKjpnhSFi0B1wAuRKNJLkChNkLAJtDl052iMqhiYfZN
	 gLXuKq0MKFOl6PONyTJmxtK4SAvnRX8Q7p9ID1pGkSED5bp6y1rmkY83gbeufmn7as
	 b20tSiNqCkYQIn2ljZnydCYVtFoTrK3QNRMZqB4owFbaLyN+qC3eEAVhaUSNzJt1Kk
	 YrHv4JWLD1v1g==
Date: Tue, 15 Aug 2023 09:55:19 -0700
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
Message-ID: <20230815095519.76d06274@kernel.org>
In-Reply-To: <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-5-vadim.fedorenko@linux.dev>
	<20230814202441.349586b4@kernel.org>
	<d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 16:18:16 +0100 Vadim Fedorenko wrote:
> On 15/08/2023 04:24, Jakub Kicinski wrote:
> > On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:  
> >> +	xa_for_each(&pin->dpll_refs, i, ref) {
> >> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> >> +		struct dpll_device *dpll = ref->dpll;
> >> +
> >> +		if (!ops->frequency_set)
> >> +			return -EOPNOTSUPP;
> >> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> >> +					 dpll, dpll_priv(dpll), freq, extack);
> >> +		if (ret)
> >> +			return ret;
> >> +		__dpll_pin_change_ntf(pin);
> >> +	}  
> > 
> > only one freq is reported in get, AFAICT, so why send a notification
> > after each ref is updated?  
> 
> The pin can be technically connected to several DPLLs and app may watch
> for the specific DPLL messages only. We would like to inform all users 
> on any DPLL which has this pin connected to.

How does this end up looking in the notifications?
__dpll_pin_change_ntf() only takes the pin object, from a quick read 
it seems like it will generate the same notification multiple times.

