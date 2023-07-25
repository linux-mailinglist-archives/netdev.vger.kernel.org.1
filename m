Return-Path: <netdev+bounces-21093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C254762709
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F29C1C21072
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73726B1B;
	Tue, 25 Jul 2023 22:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADE8462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75A7C433C7;
	Tue, 25 Jul 2023 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690325400;
	bh=yCYXB/co0y66KfJ5siP/ruQ0G4HPzFeuKJ1ydF2sdcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nON4It2PJgV7wEINj51T8CkZ9jRF1X43G12KRSmLJ7POrAXcdM8vSHja5dY00Rm+q
	 l6tkt6hmOFSMc4WolozDrpQapu5FYESr2JEJwyqhx1IeqMc+FKj43BdWnBMfCZdyZw
	 2fwdwm2coM+xXbOCKr131y9fkJ8VT51zBS5OwSJvHsLXpuADOwUCa0KUeO9I9ezBKZ
	 PbnSNQ6BpntKs/MJBRwVFGTgN0ybn+q7D3sYrEaM5PgqZ4LaHCBw1O2kz/WvJtaXy9
	 w6sYnyrBXqKOHCL2gMmjdDx2aYbBrywJnpRPRkJAsYymRuuW2dFFL/gqpYXHeBxtiY
	 bJOsnrtisaWQA==
Date: Tue, 25 Jul 2023 15:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech,
 Milena" <milena.olech@intel.com>, "Michalik, Michal"
 <michal.michalik@intel.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
 <mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
 <bvanassche@acm.org>
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Message-ID: <20230725154958.46b44456@kernel.org>
In-Reply-To: <ZLpzwMQrqp7mIMFF@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
	<20230720091903.297066-10-vadim.fedorenko@linux.dev>
	<ZLk/9zwbBHgs+rlb@nanopsycho>
	<DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZLo0ujuLMF2NrMog@nanopsycho>
	<DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZLpzwMQrqp7mIMFF@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 14:02:08 +0200 Jiri Pirko wrote:
> So it is not a mode! Mode is either "automatic" or "manual". Then we
> have a state to indicate the state of the state machine (unlocked, locked,
> holdover, holdover-acq). So what you seek is a way for the user to
> expliticly set the state to "unlocked" and reset of the state machine.

+1 for mixing the state machine and config.
Maybe a compromise would be to rename the config mode?
Detached? Standalone?

> Please don't mix config and state. I think we untangled this in the past
> :/
> 
> Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
> to hit this button.

