Return-Path: <netdev+bounces-223833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA097B80317
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CFD1B22D75
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24420F08E;
	Wed, 17 Sep 2025 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7JxgqAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F8208A7
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075946; cv=none; b=fh6Z7CTp8F06Q+Vg3hOjCZhqoelOHIZKQcIQ3mPM96NbygYcJ8qnOxGdq8mKD8zFdH/W/50lzKVk3oftOUFwSJ399c8SxY4F64XynR0ywyqyyz9wlIkGWUXgdpb9EKFZPQhxHjolj7gBrvTqk+c7hk/AnvnCpvOho3nc5vkH/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075946; c=relaxed/simple;
	bh=ZYzhZ3Pjxcmz1LYvIai9PFk8Kn/SwbqBkt8pO6c4+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=on+37vyQ7L4x2WRmmQ3tg+TS0j43/UW4bAK6gPsrUaDSlbWJkQDJvIOxyUfAkAhrYsQvN8AMdDqwKJAgS5kw3XGGzrJuJMT2B5aGBuNtaRjKkkBfujvmDtZrRW4FXz1KLgVqeTWYjc7/UN9gjOWwS21A/nh0WQLzkLEQvHjRZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7JxgqAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B31C4CEEB;
	Wed, 17 Sep 2025 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758075945;
	bh=ZYzhZ3Pjxcmz1LYvIai9PFk8Kn/SwbqBkt8pO6c4+eU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7JxgqAy/+EnxaiW1YouTpa64Ire0GDzwwxt/EvTVty57V8dnMnlF8T1Op4YIZ0ya
	 PCQ3TkkMvq8oHsc3NZEoqIqApfLFwe6jPiZp7qpuXXSx737qxxRK2s7LIor1a93lby
	 9e79UsMJVFoB6LAwBcApbDzvBofMrOujj8/OL7wHSSAXO4pCequBIjY3R27XXJr1oF
	 jmd0B4xColcWI9woEPo2ECa849ZOoDeZbsS0Aq+F2xrqqB2iWZCahxj30VfQ5A7ZLP
	 y64kAIbPCz6jXoSfmKjXjISAcxjNFewmfK5N7YsbZbkmB5tp0+KeMFW+gBeWplhZL5
	 S308qa0EuU+2Q==
Date: Tue, 16 Sep 2025 19:25:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Alexander Lobakin'"
 <aleksander.lobakin@intel.com>, "'Mengyuan Lou'"
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for
 every pool
Message-ID: <20250916192544.36c20fc1@kernel.org>
In-Reply-To: <038c01dc2775$9f4c58f0$dde50ad0$@trustnetic.com>
References: <20250912062357.30748-1-jiawenwu@trustnetic.com>
	<20250912062357.30748-2-jiawenwu@trustnetic.com>
	<20250915180133.2af67344@kernel.org>
	<038c01dc2775$9f4c58f0$dde50ad0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 09:51:44 +0800 Jiawen Wu wrote:
> On Tue, Sep 16, 2025 9:02 AM, Jakub Kicinski wrote:
> > On Fri, 12 Sep 2025 14:23:56 +0800 Jiawen Wu wrote:  
> > > Subject: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool  
> > 
> > "support multiple RSS" needs an object. Multiple RSS keys? Multiple
> > contexts? Multiple tables?  
> 
> All of these are multiple. Each pool has a different RSS scheme.

Then configuration? 
As in "support separate RSS configuration for every pool" ?

> > > -static void wx_store_reta(struct wx *wx)
> > > +u32 wx_rss_indir_tbl_entries(struct wx *wx)
> > >  {
> > > +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> > > +		return 64;
> > > +	else
> > > +		return 128;
> > > +}  
> > 
> > Is WX_FLAG_SRIOV_ENABLED set only when VFs are created?  
> 
> Yes.
> 
> > What if the user set a table with 128 entries?
> > The RSS table can't shrink once intentionally set to a specific size.  
> 
> Deleting VFs will reset these configurations.

You shouldn't reset user-set configuration of the PF when SR-IOV 
is disabled.

