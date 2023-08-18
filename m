Return-Path: <netdev+bounces-28970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1575E781481
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAEC1C20E2E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78081B7C1;
	Fri, 18 Aug 2023 21:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41D2C9A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C68C433C8;
	Fri, 18 Aug 2023 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692392585;
	bh=HHxNOIqgqP6yYIqo8lV6m5wy51W8npjOcTEiKx/jJO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQ1G45rnUtbvnxhcsWbx94oyx/wuL9JR9EKknlg1Rfs7gLKRAS21Q1lpWqWQvVRC2
	 iOmH4tn0t06UkvIGfIt+2qfahKr1Kz03lQErN6upF0ZVjlOvvnUINWvnIpjnCzbm3B
	 RaAlSN+ps5J0EQHtpdCz20fhEHxYKPQesS9UOYpobQyA84U55WUl3u/Lm0bdY22FlQ
	 oZYz1T7zmnqkYOAEPY2jRBxMOPmdMuLw74TamIhMLB+kdrQiUtI1bxD8a/znjgNI8E
	 qJYqUziTnO9PQbKD3EoJqkvBNygwT85YbrzZzFfLp6OuVrrp6SK/x00Qcw0CUzCqnU
	 LPis6trKOy8ew==
Date: Fri, 18 Aug 2023 14:03:04 -0700
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
 <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Message-ID: <20230818140304.11f316c9@kernel.org>
In-Reply-To: <DM6PR11MB4657374BF0A9361647444D239B1BA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230814194528.00baec23@kernel.org>
	<43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
	<ZNtm6v+UuDIex1+s@nanopsycho>
	<20230815100203.4e45fc7e@kernel.org>
	<DM6PR11MB4657374BF0A9361647444D239B1BA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 10:15:34 +0000 Kubalewski, Arkadiusz wrote:
> HW agnostic tests were submitted by Michal as RFC for test framework
> with fake modules implemented here:
> https://lore.kernel.org/netdev/20230817152209.23868-1-michal.michalik@intel.com/#t
> We had an agreement on latest dpll-meeting that we will follow up with
> patches that would test dpll over fake modules, and we have started it.
> As there was no requests to add HW-aware tests yet, we are not ready for
> such submission yet. We could probably extended Michal's framework to
> make it possible test real HW, but Michal's patches were just submitted,
> we do expect some review/changes there, thus we could think of adding
> something simpler for now..
> 
> Is simple bash script wrapping around cli.py and talking to ice dpll
> while verifying the outputs, an acceptable solution?

Okay, it is what it is, let's leave tests as follow up.

I'll reply to Michal on the RFC thread/

