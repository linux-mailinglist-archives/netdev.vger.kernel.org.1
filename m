Return-Path: <netdev+bounces-78230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C2874738
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9D28637F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66321168AB;
	Thu,  7 Mar 2024 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYvt4Iny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CD13FF5
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785155; cv=none; b=LSGiYY3KptbbM6tE0BvAcjESmGd0EeAvPhm/mcNG4rNnyepTiHqTdckPjFl7gdHYs9sCAnTQb6iPQws9mJR+6N/00wKetfPl74Tnm5BrKsZRov8aBP0DW29lYqkzsNH0Ovcc6dBQQvISBL67NsZppNrOVoR/+w7ER8s4HSh4fwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785155; c=relaxed/simple;
	bh=7X0c5Kp8oObvc3ylbxUR9cCfhYtATZKxdxL8E+Sr77E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmgaLRiIplTbAgHVamAcb6yS3M7htO0G9nD4j7sQ8An98oenfw4RwxUR3rASz82R0YIdkBJGPlwTz0+ISCHh+/hEuGjV9lJoF6CGe5mA1OgToPgTSxqNC7xyY1MkXKjwGEh2VFa4zYTp/pqlsganU8idzesCOnzTvAXDAtEkS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYvt4Iny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62548C433F1;
	Thu,  7 Mar 2024 04:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709785154;
	bh=7X0c5Kp8oObvc3ylbxUR9cCfhYtATZKxdxL8E+Sr77E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYvt4Inyl++1rcTsJ0a4Z8CvFUKeb9EFVyjY+A377cTscP3xGSoBoXVp/Ew+7Gtot
	 QuYbZ7+i8KGJCx0UhuZIXEuPlkVBzcSlaKvMGmY6vd35+R+CBvqJV09sJObDDz626R
	 mC1WP5B7TlxqjvoHhpoOfGCO8Us29fq3QfC3WevtMXD8RpTBwhjES8thupqG3xQTcD
	 EzddlrBQGzYKkp9OpHUyzFIHdQHmSunkWnJ63ojFykmqKB3TER2QhmhNmXoidvAoMz
	 YJI5wVomxBNAv0w0CKoMnFV/+OKsiD/iE4uqLDKCsOh6dzk2J1VkH90A7AG8+DeKqQ
	 rxgo2CGtTQGtQ==
Date: Wed, 6 Mar 2024 20:19:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko
 <jiri@resnulli.us>, Michael Chan <michael.chan@broadcom.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <20240306201913.626a41f0@kernel.org>
In-Reply-To: <CALs4sv123NSvtprMEqTxhHVjS6i1ZDgfOrx4z_cEnUyYuQP1Zg@mail.gmail.com>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
	<20240229070202.107488-2-michael.chan@broadcom.com>
	<ZeC61UannrX8sWDk@nanopsycho>
	<20240229093054.0bd96a27@kernel.org>
	<f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
	<20240229174914.3a9cb61e@kernel.org>
	<CALs4sv1WSJSxTM=cJ84RLkVjo7S8=xG+dR=FGXmDHUWrj7ZWSw@mail.gmail.com>
	<20240301091857.5f79ba3d@kernel.org>
	<CALs4sv123NSvtprMEqTxhHVjS6i1ZDgfOrx4z_cEnUyYuQP1Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 09:20:44 +0530 Pavan Chebbi wrote:
> > > As such timeouts are rare but still normal.  
> >
> > Normal, because...? Why do they happen?  
> 
> Excuse me for the late reply.
> In my experience so far, it's primarily because of flow control and
> how stressed the underlying HW queue is. (I am sure it's not unique to
> our hardware alone)
> Hence we wanted to accommodate cases where the expected wait time is
> higher than what is default in the driver, for the packets to go out.
> But it's disappointing to know that even private devlink params are
> discouraged for such purposes.
> I'd think that non-generic driver params in devlink serve exactly such
> requirements and having such a knob would be useful for an advanced
> user.
> Not to mention, in my view, such additions to devlink would make it
> more popular and would help in its wider adoption.

The problem can be solved more intelligently.

