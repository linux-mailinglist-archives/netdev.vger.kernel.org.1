Return-Path: <netdev+bounces-178626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9CAA77E68
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F51D16CAC0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BE02046AE;
	Tue,  1 Apr 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIEkEtiG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5427172BD5
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519638; cv=none; b=QwL/HtuD0zxYqsVuLCWUGaXVeG7CFVEZC4qiBUqX7ZRYcMXG9JMRpcMpSmsZI5CRoj4jw1QJKOGGqr37m/qxarmKv8haeY5lC7GEV9ZDTt1WEmaVD2dRRJkUlpF6zmjaEoSlyV99SWKpK9Fsxt+4axu2xMRbO3bdlVOFrm4kR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519638; c=relaxed/simple;
	bh=iJS0VOBDakoIECp1XStSFG/xQUNVIb9iKQmTWvIcmyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/JCxFAIzXyWtz28L2ZgXf2RIgiQStkOpNUdeMaz/qbtWT0D3pTVlH0UW9QLTzn1JIPJJrZLR0Qot81ClYYDUQUBgFSCSMtJGmS0krA6CRIsXeVMQzlPvQcNeui6qXr9oU3eFk6X6tCjsaDnCGAwu+K4cyPdhHg+VseBF4jb7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIEkEtiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A892DC4CEE4;
	Tue,  1 Apr 2025 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743519638;
	bh=iJS0VOBDakoIECp1XStSFG/xQUNVIb9iKQmTWvIcmyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIEkEtiGMxOd4bioo0tuuXv9OwzUHUKUNPstojWBuEmJB2Ep0KFJJnSsEYOVBKl+f
	 amGxc8lFjH5PkgVfmiQgc/UrMx2rC+ljSJ5+UtIg0oTaRJvGlD0JIOfoB0W9UginBZ
	 shuQYL6nQBv40WUWtobi1C2+k4XDsJnxX478A7wbE8XhnAqnVbw0OqMmNiPXiS0OPZ
	 NZqyF8pUUXL+jJbmY8/8un/vsmFzGO/YC+UATkZFmweg+8WshkkPPU2abXkT8QDpIU
	 0EmaOBQfKfn8fLb6xE2bEa+NI4r+Ii8JcTVLHFyT1G4p5P9QcGLhoWQ1pY0x5BBB+r
	 WWh6sGaFhptZg==
Date: Tue, 1 Apr 2025 08:00:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, almasrymina@google.com, dw@davidwei.uk, sdf@fomichev.me
Subject: Re: [PATCH net 1/2] net: move mp dev config validation to
 __net_mp_open_rxq()
Message-ID: <20250401080036.5aad536b@kernel.org>
In-Reply-To: <32917bbb-c27a-4a65-8ba6-1df5c4729c12@gmail.com>
References: <20250331194201.2026422-1-kuba@kernel.org>
	<20250331194303.2026903-1-kuba@kernel.org>
	<32917bbb-c27a-4a65-8ba6-1df5c4729c12@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 12:37:34 +0100 Pavel Begunkov wrote:
> > -	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
> > -		       GFP_KERNEL);
> > +	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
> >   	if (err)
> >   		return err;  
> 
> Was reversing the order b/w open and xa_alloc intentional?
> It didn't need __net_mp_close_rxq() before, which is a good thing
> considering the error handling in __net_mp_close_rxq is a bit
> flaky (i.e. the WARN_ON at the end).

Should have mentioned.. yes, intentional, otherwise we'd either have to
insert a potentially invalid rxq pointer into the xarray or duplicate
the rxq bounds check. Inserting invalid pointer and deleting it immediately
should be okay, since readers take the instance lock, but felt a little
dirty. In practice xa_alloc() failures should be extremely rare here so
I went with the reorder.

