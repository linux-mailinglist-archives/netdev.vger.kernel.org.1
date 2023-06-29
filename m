Return-Path: <netdev+bounces-14625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F8742BB7
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B5C1C20A85
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199014269;
	Thu, 29 Jun 2023 18:08:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7714268
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:08:01 +0000 (UTC)
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 11:07:59 PDT
Received: from resqmta-h1p-028594.sys.comcast.net (resqmta-h1p-028594.sys.comcast.net [IPv6:2001:558:fd02:2446::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86602297C
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:07:59 -0700 (PDT)
Received: from resomta-h1p-027911.sys.comcast.net ([96.102.179.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-h1p-028594.sys.comcast.net with ESMTP
	id EvDIqhyJNGOPdEw1IqXUlU; Thu, 29 Jun 2023 18:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1688061928;
	bh=n3lCJnmHXgrKtY1GgvvLvqdYKQaVBuxxsH4QSdYckhY=;
	h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
	 Content-Type:Xfinity-Spam-Result;
	b=OvByRBqBnEIr+e/6xDdFFmh/9bXMQ9/r8dUSLNk+5lPf9vAP6IZGHetjcThW0YJd1
	 C3NisgRRK5l7jgbzI5C4Tif3/WamugPExvNabLPoW0Qo7rG38f4gbHq8Bc3nlnarZo
	 c1ZNlcxe2czzh5bt+Izf1L4wjPh4DZMQvGKxQvv9STWUyl4CRlbeIbc3f9kfLrgtqp
	 TZTe/r9GLDlusQeTpxVpdkR/Bd2KtVm++vpQwq6QHKmhPHy4If1/ZcLZtEJ3iOyOg1
	 JRdDS5cQNI0VZaYWB54wB3TWKDTF5AsyQzNkJpuaoerp87PWFiBmuguc4L9WkYJPDs
	 7zT6y5xvP8W+g==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-h1p-027911.sys.comcast.net with ESMTPSA
	id Ew17qC5nh2DGmEw19qI2Ra; Thu, 29 Jun 2023 18:05:23 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From: Matt Whitlock <kernel@mattwhitlock.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
 <netdev@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Dave Chinner <david@fromorbit.com>,
 Jens Axboe <axboe@kernel.dk>,
 <linux-fsdevel@kvack.org>,
 <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Date: Thu, 29 Jun 2023 14:05:16 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
In-Reply-To: <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MIME_QP_LONG_LINE,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, 29 June 2023 13:56:04 EDT, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 08:55, David Howells <dhowells@redhat.com> wrote:
>>=20
>> Matt Whitlock, Matthew Wilcox and Dave Chinner are of the=20
>> opinion that data
>> in the pipe must not be seen to change and that if it does, this is a bug.=

>
> I'm not convinced.
>
> The whole *point* of vmsplice (and splicing from a file) is the zero-copy.
>
> If you don't want the zero-copy, then you should use just "write()".

If you want zero copies, then call splice() *with* SPLICE_F_MOVE.

If you want one copy (kernel-to-kernel), then call splice() *without*=20
SPLICE_F_MOVE.

If you want two copies (kernel-to-user + user-to-kernel), call read() and=20
write().

I don't know why SPLICE_F_MOVE is being ignored in this thread. Sure, maybe=20=

the way it has historically been implemented was only relevant when the=20
input FD is a pipe, but that's not what the man page implies. You have the=20=

opportunity to make it actually do what it says on the tin.


