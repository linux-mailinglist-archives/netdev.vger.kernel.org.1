Return-Path: <netdev+bounces-14811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C0743F4D
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B201C20BCF
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E01643C;
	Fri, 30 Jun 2023 15:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DB1643A
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70107C433C0;
	Fri, 30 Jun 2023 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688140719;
	bh=4Ag8PIinzNCorLRTkQlZHurH9hQ96DLnqmuFbBkacGc=;
	h=Date:From:To:Subject:From;
	b=KmOxwtlkYNHljrOqvyg17ees8x6tC3sLPu+U/mLol0sbUFFOb8+ZzknuUpn6nH0wD
	 0KVeze0mAxhs0weFWnj7uqamjRm4njtBOSvgYRM2VQrRyLD10mNbqrCNCZFZVp/k9v
	 PqnLFFLbJcLBbKSjU14JukVWbTG95fgjQa9ScyDoquhvc/VvUq2UHQ5s6IA+1ECKI+
	 UgDBdPjgQpW0yXzHjoGsfkg+NB8iU24RP4QZRwme96G8Sg+FdbZQutHMl4wThqaJ2N
	 2YZ57Hlfkt4BLmb1z0lXpdQvMURRIMc7eJT1KZYOfkFsWqL3QHG6fTe2ppmAuBUVqc
	 Oj53GjaZ6hOKQ==
Date: Fri, 30 Jun 2023 08:58:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] pw-bot now recognizes all MAINTAINTERS
Message-ID: <20230630085838.3325f097@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

tl;dr pw-bot now cross references the files touched by a *series* with
MAINTAINERS and gives access to all patchwork states to people listed
as maintainers (email addrs must match!)


During the last merge window we introduced a new pw-bot which acts on
simple commands included in the emails to set the patchwork state
appropriately:

https://lore.kernel.org/all/20230508092327.2619196f@kernel.org/
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status

This is useful in multiple ways, the two main ones are that (1) general
maintainers have to do less clicking in patchwork, and that (2) we have
a log of state changes, which should help answer the question "why 
is my patch in state X":

https://patchwork.hopto.org/pw-bot.html

The bot acts automatically on emails from the kbuild bot. Author of 
the series can also discard it from patchwork (but not bring it back).
Apart from that maintainers and select reviewers had access rights
to the commands. Now the bot has been extended to understand who the
maintainers are on series-by-series basis, by consulting MAINTAINERS.
Anyone who is listed as a maintainer of any files touched by the series
should be able to change the state of the series, both discarding it
(e.g. changes-requested) and bringing it back (new, under-review).

The main caveat is that the command must be sent from the email listed
in MAINTAINERS. I've started hacking on aliasing emails but I don't
want to invest too much time unless it's actually a problem, so please
LMK if this limitation is stopping anyone from using the bot.

The names of the states and their shortcuts are in the source code:
https://github.com/kuba-moo/nipa/blob/master/mailbot.py#L46

