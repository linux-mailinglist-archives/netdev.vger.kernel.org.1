Return-Path: <netdev+bounces-14629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F5742BCD
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0376280DD2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E714274;
	Thu, 29 Jun 2023 18:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAD1426A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:18:42 +0000 (UTC)
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 11:18:40 PDT
Received: from resdmta-c1p-023854.sys.comcast.net (resdmta-c1p-023854.sys.comcast.net [IPv6:2001:558:fd00:56::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8930C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:18:40 -0700 (PDT)
Received: from resomta-c1p-023412.sys.comcast.net ([96.102.18.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resdmta-c1p-023854.sys.comcast.net with ESMTP
	id Evs8qboKAyMCuEwBdqk26L; Thu, 29 Jun 2023 18:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1688062569;
	bh=mWTnVt9e/Fb+ASjag2lt89PvPdIMQDGYRRlGDqMbUnQ=;
	h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
	 Content-Type:Xfinity-Spam-Result;
	b=Q+0AuBrhGaFz6KlLoL/+pV8GofDsIIh7y4Ls6dAsI7mcCnrTRySNQ/T45SK64w3B6
	 NEpKBErHu3rgUj+6ie6rAJDuvBrtVanduE1IL6bhxzoLCPLtk/fFlHn+LuW26wNNJ7
	 lSwZ+XmIf7LlNGYmqZVNkE1DqiQPloz8FB8bZXCzpva7GzUy++GB4ldM9KBmjHeuWe
	 VYfYBM8hTBaZn4bUKCTgb9hSqwbqnYaoWlOpJLepwBC0ZNHrW0WWTN9bGJQl5mGf4W
	 cYruoT52QBjAVAuPBYWAkrDhS6wDs6H8V8pFqqZUts6F1R/0W/L8Kzo7DHXLA4nSvV
	 WOnSBO8qw4PeA==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-c1p-023412.sys.comcast.net with ESMTPSA
	id EwBWqLftphq3SEwBXq8dQY; Thu, 29 Jun 2023 18:16:07 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From: Matt Whitlock <kernel@mattwhitlock.name>
To: David Howells <dhowells@redhat.com>
Cc: <netdev@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Dave Chinner <david@fromorbit.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 <linux-fsdevel@kvack.org>,
 <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Date: Thu, 29 Jun 2023 14:16:02 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d33f8a7-eb75-4a0d-bb10-aa4ab497c016@mattwhitlock.name>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MIME_QP_LONG_LINE,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, 29 June 2023 11:54:29 EDT, David Howells wrote:
> Matt Whitlock, Matthew Wilcox and Dave Chinner are of the opinion that data=

> in the pipe must not be seen to change and that if it does, this is a bug.
> Apart from in one specific instance (vmsplice() with SPLICE_F_GIFT), the
> manual pages agree with them.  I'm more inclined to adjust the
> documentation since the behaviour we have has been that way since 2005, I
> think.

Anecdotally, my use case had been working fine for years until I upgraded=20
from 5.15.x to 6.1.x in February of this year. That's when my backups=20
started being corrupted. I only noticed when I was trying to restore a lost=20=

file from backup earlier this week.

