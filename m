Return-Path: <netdev+bounces-45809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED27DFB45
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520401C20F6E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72B219FC;
	Thu,  2 Nov 2023 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aHT35T9I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823D219ED
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 20:10:00 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58511134;
	Thu,  2 Nov 2023 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q2W1VCZdvfcA1TvVxXUd1wwMlA+b5wW2gVN59Ibyspc=; b=aHT35T9Ietusi+0XZYIXiBINUJ
	eAUi5eDPtSXy7tipUD14EmKIbdFtl5ZIe07MLB8laIK8XFiYommLBXXMFg6ZajQ2Ae6J+iUm2/tk9
	Jmwz/B/hiRzkfMxfUKwAVllzR0uDXOnJFoBQ9kKfKuil/VIcrasJe60saPARy9Qa75jUaLJ7GPjDu
	bIR41JKecfeLxkC+omQzMMfqER2bqSNWArHV181kHuYA/Wr1qwZeLLXQqBOA9J4jM1BivqGu5OCcN
	sB7I1paSx5pZYa0JUl1WNMDch2jdmJk2d4kCCm1JjxyB0RNSLmZYLIUSVX2NXIcgz2erurPEuut8l
	PnftacoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qye0d-009w63-1T;
	Thu, 02 Nov 2023 20:09:43 +0000
Date: Thu, 2 Nov 2023 20:09:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Philipp Stanner <pstanner@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drivers/net/ppp: copy userspace array safely
Message-ID: <20231102200943.GK1957730@ZenIV>
References: <20231102191914.52957-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102191914.52957-2-pstanner@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 02, 2023 at 08:19:15PM +0100, Philipp Stanner wrote:
> In ppp_generic.c memdup_user() is utilized to copy a userspace array.
> This is done without an overflow check.
> 
> Use the new wrapper memdup_array_user() to copy the array more safely.

>  	fprog.len = uprog->len;
> -	fprog.filter = memdup_user(uprog->filter,
> -				   uprog->len * sizeof(struct sock_filter));
> +	fprog.filter = memdup_array_user(uprog->filter,
> +					 uprog->len, sizeof(struct sock_filter));

Far be it from me to discourage security theat^Whardening, but

struct sock_fprog {     /* Required for SO_ATTACH_FILTER. */
        unsigned short          len;    /* Number of filter blocks */
	struct sock_filter __user *filter;
};

struct sock_filter {    /* Filter block */
        __u16   code;   /* Actual filter code */
        __u8    jt;     /* Jump true */
        __u8    jf;     /* Jump false */
        __u32   k;      /* Generic multiuse field */
};

so you might want to mention that overflow in question would have to be
in multiplying an untrusted 16bit value by 8...

