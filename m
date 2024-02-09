Return-Path: <netdev+bounces-70593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5F84FAD7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0410B2BDEE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8A7603E;
	Fri,  9 Feb 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQcGpBLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004424D112
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498945; cv=none; b=nqCca54vzm48jI9Y/U21wjuD6w0nHKgK7spnGVDK9fVyTXBMfOHPIi8ykQ9VCr4tDhz68wGNC8cKhFlwGAxfnQExfpfzsdY9GTiaW4ovY/6JqF+QG8voZL8vDxDJfUYneS58yDp+wf3Usoq1b0EyM3xSyXTsyRnjKeKggcWJM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498945; c=relaxed/simple;
	bh=pKx6CQhTbamof6ZXifN46m219sBH7UjBG+kOuAC2k4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFZyx74cJAOL+9Iu+c/gvMPZvl5/RZkqfqy54XCaXevhuhRkbf3/xck2Oq8z/jA+f5IT1GVIMG7TluO6hnSn3OPzq7THYqyH9Nv7iA0+2LRe4+mDzU+Yp1dAturmRMSQJFlP/CtRGqSAzaH6x1kmoMUmzDEQuOB9kAqpHGk4hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQcGpBLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1159C433F1;
	Fri,  9 Feb 2024 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498944;
	bh=pKx6CQhTbamof6ZXifN46m219sBH7UjBG+kOuAC2k4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQcGpBLfbNjWX6ikcUh5Dt0Hi1OBW/2tX9XbHU5QDWEVUlVR5ipZagYe1PaZ+IZYC
	 QqHaHCMZemcMrmIXs2F8GawlAdVIu8pn67Ahz4vetEn7pV7ZrCh31dA6hIxMMYF1GN
	 ksB+m4kcw7zyhTK95bpH8dlEwVbinSLBiZW4M9rYGwLoaA48W5hVO2kFg4hO9sDMTA
	 J1h2F4G7zgc6dEmZ0s9QOlbbS9EYklSX0R5GT4KHEL8adjnZp3Sc0bBHjXh9IdzgE6
	 1UMLrSP+JnzXxRWmehY1vZOGRzPSO3BqNmjW+k+/NBIsNqE7jhoSL99hSksf3V/64o
	 izIFMx9ckVZuA==
Date: Fri, 9 Feb 2024 17:15:40 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/3] tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx
 group
Message-ID: <20240209171540.GD1533412@kernel.org>
References: <20240208144323.1248887-1-edumazet@google.com>
 <20240208144323.1248887-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208144323.1248887-3-edumazet@google.com>

On Thu, Feb 08, 2024 at 02:43:22PM +0000, Eric Dumazet wrote:
> tp->tcp_usec_ts is a read mostly field, used in rx and tx fast paths.
> 
> Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: Wei Wang <weiwan@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


