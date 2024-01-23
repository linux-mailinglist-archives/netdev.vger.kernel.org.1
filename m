Return-Path: <netdev+bounces-65123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706283949C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C3C283888
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4664A87;
	Tue, 23 Jan 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paH4/SMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B06351E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027222; cv=none; b=gkAydpIr90uyD40lwfIOpogcpmCnToxyks+WtEnFt5fEMdOPpvHw9W06PYWE8qqZ5GeMwYv24Ab76F+nnvnnxuoiAvvhCn8vNXglDJ5ayaYS5cS4DFKcCvo4BG3pCMyytaMrO2vJXvPh8PoejbjY4kzdRVZRQ/DhyfHpuNSQ1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027222; c=relaxed/simple;
	bh=etKd2UDSS7QvCop6xF0FqTcYHFoheoLF1EQ54I4dl9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG+BHFEQjFWtyA8B+ECxoAHfDt2M6kxYb+98qjyYyBIlwwL4MWdFX8qkz6lkezmkpBH60+f6u/74GFhUliFZiqOAt10W1EnlD7LbvWy0qMrXgdBWprccpYSmXmErc9K6v0z1cMyYiPH5a/1EmKBXGMHswAEhhrZp4lHBFnmvoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paH4/SMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6734DC433C7;
	Tue, 23 Jan 2024 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027220;
	bh=etKd2UDSS7QvCop6xF0FqTcYHFoheoLF1EQ54I4dl9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paH4/SMCLk3aSkvAk3u21N5tSDOVuVQQUXUFsvqInslrwGjhQM/I10vo+XF3u2Kiz
	 hLSv4/9Fk3zhwLURT9YvKfbYhZYxxGWx2fWyCzOEA4idc5e4xdM9HnHxE6O1i/VQD4
	 /f+6YcysoZ1LVEFOSDMpRcQhGGldhLy5f6vDH/3m6/6CH/acfSJ8SXaIzGTH6S2M8/
	 rNilq8hfRqIJrn4WrRWRtWJfLg3WdaF+QE/dDNkiEf0GEuFgi2nacGdIIGtzJp04ZW
	 7i3Hh58+TJPKu62diLqn+EwLEi5AXHDyVOLwP0wqASQ+rnD9qqDP8r1arVHRjiQ/KO
	 v7ahxAEvKJOkA==
Date: Tue, 23 Jan 2024 16:26:56 +0000
From: Simon Horman <horms@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jeroen de Borst <jeroendb@google.com>
Subject: Re: [PATCH net-next 2/6] gve: Refactor napi add and remove functions
Message-ID: <20240123162656.GC254773@kernel.org>
References: <20240122182632.1102721-1-shailend@google.com>
 <20240122182632.1102721-3-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182632.1102721-3-shailend@google.com>

On Mon, Jan 22, 2024 at 06:26:28PM +0000, Shailend Chand wrote:
> This change makes the napi poll functions non-static and moves the
> gve_(add|remove)_napi functions to gve_utils.c, to make possible future
> "start queue" hooks in the datapath files.
> 
> Signed-off-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


