Return-Path: <netdev+bounces-173042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E39A56F95
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3D189A974
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C923E229;
	Fri,  7 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWl0FdEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D123C8B5;
	Fri,  7 Mar 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369800; cv=none; b=FfVM4g5nIBRm+Q2f+QEMzntvVO+Az3j/wi80H83REwUnw4nokNhjzWQPUEPkZFBkOTUcPS5/4vD1+zOt5uiwbzM2Y7RtuYGGoMK3sv1a1Fq1/cpKMSyzqy6T46hnnR6VM69nsqKF4zIprabrNajtiDnuPQkwkxepEWwIadbUvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369800; c=relaxed/simple;
	bh=0DZPIe95LWP24lYQH6DTn/rr5jMCk3/IPdeK3fYlyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLhkTQODxg3aAOSLt3jRDt09bUW/xFjtEQt63EH516abRyGf0+c+4PlEyTQRduY4aQzilzZjS0HZ7BwsZqtrY/Db0O0PDMJAOB3METGSzUsZgX/kpr0wLYZ0qntmpLm/oCB6tIEkTsOeUk2XdP+CyB8YC06KUfH1v+kH7WcP+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWl0FdEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F4C4CED1;
	Fri,  7 Mar 2025 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741369800;
	bh=0DZPIe95LWP24lYQH6DTn/rr5jMCk3/IPdeK3fYlyKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWl0FdEPUx7hFd5ydcVHQRcvgNfydg5JuGSCG0WTCGI2vfkumjNIDCp/Li36B9v4A
	 aWxy6UF0C8jzaLlEsJdwzBkbl9jZfLrYjCbDOPJkw09mgsbUcfS63gCEXYdRAeRKLz
	 uifN7Z8QusIMQuVXhP+YfgBmAK6vLsglWo+T92Xw9xaAPAz0hZIghMNHQKdC5MaGN4
	 ulqKirGQXNkZGZ6VAq+kjToS7NYNL++VDVN951Z1oydpNcCwp5us17XdjTKO93SDTd
	 1jmCa/CIqMagj/ynLm751M/FCxc4uWPbG6G2pRvy1gdqHJROoyzS+p0hvSHNLAxs52
	 p/TN2qwfSNygg==
Date: Fri, 7 Mar 2025 09:49:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk
Subject: Re: [PATCH net-next v1 2/4] net: protect net_devmem_dmabuf_bindings
 by new net_devmem_bindings_mutex
Message-ID: <20250307094959.1df7c914@kernel.org>
In-Reply-To: <20250307155725.219009-3-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
	<20250307155725.219009-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 07:57:23 -0800 Stanislav Fomichev wrote:
> In the process of making queue management API rtnl_lock-less, we
> need a separate lock to protect xa that keeps a global list of bindings.
> 
> Also change the ordering of 'posting' binding to
> net_devmem_dmabuf_bindings: xa_alloc is done after binding is fully
> initialized (so xa_load lookups fully instantiated bindings) and
> xa_erase is done as a first step during unbind.

You're just wrapping the calls to xarray here, is there a plan to use
this new lock for other things? xarray has a built in spin lock, we
don't have to protect it.

