Return-Path: <netdev+bounces-108605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D956924807
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD41C253DA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A61C9EC2;
	Tue,  2 Jul 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zw85ijRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B41514DC;
	Tue,  2 Jul 2024 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947977; cv=none; b=QSB3zJXx8whnBzV63wesdN4Ds7ZQHS2knfoytLP5cTtR3D2slMmTI7E09nsssY1n8HXhSRYWX+PThX4doOdLcW23EmQEmSIwH7lfSO9tnVgFL7d0Kk/LERpqCZ38epy0JCuchgpoluIa3gsc5EFcHCtm4aZOOBm/cENLwis7L6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947977; c=relaxed/simple;
	bh=ALW+f3fwMmwHYezn1+T4IzRc1NdvgyM+/EzoU1dY1g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwBtZF957gSjSRDzE6oCHf5Bxzz6u7TVSi+3LETqesob9sGlw+5H9tZbUm86A+i9M/3KUapNI+MPVxtfjMr7oMAkTCTTCYXZRuw7ld1oQc9xs6Y2daMItaYIdXB4yXEY1f6Nluw0mug7I6Wv9WW5dWtvSny1tdZmi8QAJgr9uDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zw85ijRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C2CC116B1;
	Tue,  2 Jul 2024 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719947976;
	bh=ALW+f3fwMmwHYezn1+T4IzRc1NdvgyM+/EzoU1dY1g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zw85ijRqNsBOgVkHMH9e1nlIuY/17c9p0YwMGOftCrVti/FP+51mIwsG8pey4mOk0
	 wc77u9g7j565ArBnM+0HJSI7q6mf1VShZxBGUyRpl6fVP9lv6FVbVCDor9QkxBEcok
	 4kUxHanXKK1tTp79uI2bqYLYLnj8TpqHyWqVfoEk=
Date: Tue, 2 Jul 2024 21:19:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: CVE-2021-47285: net/nfc/rawsock.c: fix a permission check bug
Message-ID: <2024070208-legume-possible-de8b@gregkh>
References: <2024052155-CVE-2021-47285-4fee@gregkh>
 <4bka5bbczovc7z3tplqjlsfukf6qneg4wwddixgodsgqkudwlu@yws3uczmtzsn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bka5bbczovc7z3tplqjlsfukf6qneg4wwddixgodsgqkudwlu@yws3uczmtzsn>

On Tue, Jul 02, 2024 at 06:15:09PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, May 21, 2024 at 04:20:39PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > net/nfc/rawsock.c: fix a permission check bug
> > 
> > The function rawsock_create() calls a privileged function sk_alloc(), which requires a ns-aware check to check net->user_ns, i.e., ns_capable(). However, the original code checks the init_user_ns using capable(). So we replace the capable() with ns_capable().
> > 
> > The Linux kernel CVE team has assigned CVE-2021-47285 to this issue.
> > ...
> > 	https://git.kernel.org/stable/c/8ab78863e9eff11910e1ac8bcf478060c29b379e
> 
> Despite the patch changes guard related to EPERM bailout, it actually
> swaps a "stronger" predicate capable() for a "weaker" ns_capable().
> 
> Without the patch, an unprivilged user is not allowed to create nfc
> SOCK_RAW inside owned netns, with the patch, it's allowed.

Ah, we misread this, thinking it went up in security, not "down".

And this was from the old GSD ids, odd that no one noticed it then :(

Anyway, now rejected, thanks for the review!

greg k-h

