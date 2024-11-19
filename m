Return-Path: <netdev+bounces-146044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF329D1CEB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554BC282242
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7805200CB;
	Tue, 19 Nov 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YMM4MRrJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF5E57D
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978397; cv=none; b=e7ZI6Pi9ezOLAmXCzLzHjgU/pjrVY+1kYuL1MFJxs6LZWb9qjVN4cTHS5vBWcl3RNbYP6oqlQFjzUcSQwukmwHaXqjXLYX7jUm3pQChYsPni/A3cbHtn3ExwBH+gXY2rsSnqHop9NxfP4DQKCj8HM7nwYmoWOf52I2t1s3zhtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978397; c=relaxed/simple;
	bh=CUkIeW8h1Sp9Vnqe15p1aphNEMb/rhGp9vK2c3tFsHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ultZuGW3hbyTuD6mVq3lxSk8DfiC/qB6LAncQ8NQcQZ+TtzlLw0LliTywQ1O9yviJlSKzTYnzAZjETRX5ijpMjJgrsADNZFFuTvLMezDY4JW6fCjtebsOSXRdTzyBmlf+rUqhAm6FVY2xlOdBHnWn0d2hJPw5ZqdTtz4/smaYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YMM4MRrJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WIon7vUD0OGo6wW9syp+Qt+mS9Z/QulhgtNtTflE7po=; b=YMM4MRrJlzDJ3uzx2hlj414GmV
	5aHZ7LVr1fPtlj5ddH3uyE0eMZWMasiTJ+JIjqRdUGEZDgp1wQ/0Pt1dVOXlrpfvKyxptZVDASGeD
	GG+5UQb++uCVwb1Q8AQUl63FxcsIyJh9PrGgNQYI18ktEvYORixXTW0RfDtJZdBTNHMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDChE-00Dj5i-U8; Tue, 19 Nov 2024 02:06:24 +0100
Date: Tue, 19 Nov 2024 02:06:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com,
	nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
Message-ID: <695a0358-6860-40d0-989e-614e066a9170@lunn.ch>
References: <20241117141655.2078777-1-yuyanghuang@google.com>
 <Zzs0xDi-3jdQSuk0@fedora>
 <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:19:59PM +0900, Yuyang Huang wrote:
> Thanks for the prompt review feedback.
> 
> >No need changes for headers. Stephen will sync the headers.
> 
> The patch will not compile without the header changes. I guess that
> means I should put the patch on hold until the kernel change is merged
> and the header changes get synced up to iproute2?

What you can do is have two patches. The first updates the headers,
the second adds the new functionality. What then happens is that the
headers get syncd once, and then all patches queues up for merging get
applied, dropping the first patch of each series.

	Andrew

