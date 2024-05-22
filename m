Return-Path: <netdev+bounces-97616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D509E8CC657
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583B2B2160E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524418004E;
	Wed, 22 May 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="oiHAQExv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp99.iad3b.emailsrvr.com (smtp99.iad3b.emailsrvr.com [146.20.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94031BF2A
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402723; cv=none; b=FcxHz4vabo7NX1UYwBZiyJAEXMHEefFxjLYJSiU0D+oaeZJbfCeV11VeK7MxIEepH2Y5i9DOWbKUTXxXjww9kihDQZMZr1WxLyekb7d/lOtRGiJ/6Z000AIHolaD1vhmVH1r0S3qT/BqRN4Bk8B1PXV9+/L2XBAPFr5vtY2NGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402723; c=relaxed/simple;
	bh=H0zTzTCjK4soBCluEyuZgoRZslqdQkTfZ1JW+hfHOHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfYdjQOoDBdkCklEm8PokDyv/aRzhtc7wxQHhtWhomSGcDxDu+S4jr1vrJrQWWg04lYY97k2IxTccpbg+wcjW78I8+O3wkD/qUj4LrLpX5hKZb6yzvEj3N01PCbfrhuJl5cdKVBbUPxTfK0hljmQ0+Z2SmOIcq50oa7i+LmtEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=oiHAQExv; arc=none smtp.client-ip=146.20.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716402337;
	bh=H0zTzTCjK4soBCluEyuZgoRZslqdQkTfZ1JW+hfHOHk=;
	h=Date:From:To:Subject:From;
	b=oiHAQExvHkQi+FCTU5AkFRv2ZiD9ZGEeVITNRlYY063hcU6W35WH5upv66LG7QzoG
	 tmeD+QECQ5J9Ek8s9qPl0ZVBvhWdF3An4TzhsqeKR7JsONYA7HLFcJmhJtO4x+b2cZ
	 eSHiW+ZkWgb3DrXMR1NQ5l6GyEfnywhpikrZ1/Xw=
X-Auth-ID: lars@oddbit.com
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id EB525400C8;
	Wed, 22 May 2024 14:25:36 -0400 (EDT)
Date: Wed, 22 May 2024 14:25:36 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] ax25: Fix refcount imbalance on inbound connections
Message-ID: <yzz225joxbxptlrdqjr4u2cwk4myactk6ozz7bfpv25dqbzri4@mz5ocbxbefxp>
References: <46ydfjtpinm3py3zt6lltxje4cpdvuugaatbvx4y27m7wxc2hz@4wdtoq7yfrd5>
 <20240521182323.600609-3-lars@oddbit.com>
 <20240522100701.4d9edf99@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522100701.4d9edf99@kernel.org>
X-Classification-ID: 227f8a22-6abb-4b73-b50d-84d59eab2358-1-1

On Wed, May 22, 2024 at 10:07:01AM GMT, Jakub Kicinski wrote:
> correct fixes tag for this hash would be:
> 
> Fixes: 7d8a3a477b3e ("ax25: Fix ax25 session cleanup problems")

Jakub,

Thanks for the correction; I'll submit a new patch with a correct Fixes:
tag, but...

> Please CC maintainers (per script/get_maintainer.pl)

...the ax.25 tree is currently orphaned:

    AX.25 NETWORK LAYER
    L:	linux-hams@vger.kernel.org
    S:	Orphan
    W:	https://linux-ax25.in-berlin.de
    F:	include/net/ax25.h
    F:	include/uapi/linux/ax25.h
    F:	net/ax25/

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

