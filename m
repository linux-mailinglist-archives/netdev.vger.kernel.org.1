Return-Path: <netdev+bounces-39641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21E7C03AD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B031C20B50
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70762FE00;
	Tue, 10 Oct 2023 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU1FjI49"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87757225B6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5AC433C8;
	Tue, 10 Oct 2023 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696963727;
	bh=h6j86TrC8V2KWq19/3Q9rCnmpXHkQ06ig1kXdPncYsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IU1FjI49McWL6f0Iq30t/vo+FYxtRzG7Haa+AsFShtd7TgG6lIQ4k1sNeCre5wZNo
	 j3djaUY4rpbCuR0oXYYJFR8cnRf0GnkXoD6vMTlxPwXGxEAVdS0zXJ2IHi/FZ+eBnG
	 kYzvWNNBa82LreaWGM3nwN74jIeYt0o2H9AQ2Nq8nGk+y2EsNhN4JflCW5N8Q8457v
	 lkyWWgGAQ9EVGuspjqvgbSIfIE980R/Neey5vGcqZliqFLGa3Sl8uzwlrpL7g3Xo5t
	 9TmmqjBjYSZLC/VCr9AK/3aeU+MaNnxjFcNeDJe7KGwJ5CXmEwfEQ5o7lR9At4hvYQ
	 gckC386ceKLuQ==
Date: Tue, 10 Oct 2023 11:48:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <20231010114845.019c0f78@kernel.org>
In-Reply-To: <20231010110828.200709-2-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 13:08:20 +0200 Jiri Pirko wrote:
> Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")

Drop Fixes, add "currently no family declares ops which could trigger
this issue".

>  	if (i + cnt < family->n_split_ops &&
> -	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP) {
> +	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP &&
> +	    (!cnt ||
> +	     (cnt && family->split_ops[i + cnt].cmd == iter->doit.cmd))) {

Why are you checking cnt? if do was not found cmd will be 0, which
cannot mis-match.

