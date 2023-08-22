Return-Path: <netdev+bounces-29728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CC78480B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9F1C20A67
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311D2B55E;
	Tue, 22 Aug 2023 16:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E32B54E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4254CC433C8;
	Tue, 22 Aug 2023 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692723297;
	bh=UoOkKIMbPfEd0c+D0Uln/kWgFO+YI518rHnvKJm0rLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FSW1H/InJ2afLXXYL2DTIbtdyEMvsvlV33F1+8nwiy+mPTMnZSkf5rQYOZPUIYgOJ
	 KbKOR9QK5OXYgCCadIlZbHfa/ilQRbg/ewWQfBVzWcB2MlDaMnL5adQu1yRdy4ihx8
	 rlyJhCqIqCnTRnUEZeSz7bllPFA5aIhZ3PFtO2sptLM9MoISuNOt6+ezpkEUAB2Wg5
	 kWoGVIS0paAl0jwTiQreTve7v0Ywb5dKFSmCEJ4ZLHHSuSxqrbDDE7lHiJtOSNcnCB
	 U/eNEsQZ5JYTPI5+/bhjZfm+eg+niNopnoEmKhnTdwoA9qDiXEBt6b4l4lP84Nkx+h
	 W3lYaCXNI72Bw==
Date: Tue, 22 Aug 2023 09:54:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
 "Michalik, Michal" <michal.michalik@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
 <mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <20230822095456.0a08b008@kernel.org>
In-Reply-To: <DM6PR11MB4657E60D5A092E9FC05BC9EF9B1EA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-3-vadim.fedorenko@linux.dev>
	<20230814194336.55642f34@kernel.org>
	<DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
	<20230817163640.2ad33a4b@kernel.org>
	<ZN8ccoE8X5J6yysk@nanopsycho>
	<DM6PR11MB4657E60D5A092E9FC05BC9EF9B1EA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 10:15:41 +0000 Kubalewski, Arkadiusz wrote:
> I prepared some POC's and it seems most convenient way to do the
> split was to add new argument as proposed on the previous mail.
> After all the spec generated diff for uAPI header like this:
> 
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -148,7 +148,17 @@ enum dpll_a {
>         DPLL_A_LOCK_STATUS,
>         DPLL_A_TEMP,
>         DPLL_A_TYPE,
> -       DPLL_A_PIN_ID,
> +
> +       __DPLL_A_MAX,
> +       DPLL_A_MAX = (__DPLL_A_MAX - 1)
> +};
> +
> +enum dpll_a_pin {
> +       DPLL_A_PIN_ID = 1,
> +       DPLL_A_PIN_PARENT_ID,
> +       DPLL_A_PIN_MODULE_NAME,
> +       DPLL_A_PIN_PAD,
> +       DPLL_A_PIN_CLOCK_ID,
>         DPLL_A_PIN_BOARD_LABEL,
>         DPLL_A_PIN_PANEL_LABEL,
>         DPLL_A_PIN_PACKAGE_LABEL,
> @@ -164,8 +174,8 @@ enum dpll_a {
>         DPLL_A_PIN_PARENT_DEVICE,
>         DPLL_A_PIN_PARENT_PIN,
> 
> -       __DPLL_A_MAX,
> -       DPLL_A_MAX = (__DPLL_A_MAX - 1)
> +       __DPLL_A_PIN_MAX,
> +       DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
>  };
> 
> So we have additional attribute for targeting either a pin or device
> DPLL_A_PIN_PARENT_ID (u32) - which would be enclosed in the nests as
> previously:
> - DPLL_A_PIN_PARENT_DEVICE (if parent is a device)
> - DPLL_A_PIN_PARENT_PIN (if parent is a pin)
> 
> 
> I will adapt the docs and send this to Vadim's repo for review today,
> if that is ok for us.

LGTM!

