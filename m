Return-Path: <netdev+bounces-68246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A78464C8
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD01C236ED
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9C469F;
	Fri,  2 Feb 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+KGT/67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A84694;
	Fri,  2 Feb 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832262; cv=none; b=f3J+4FNzjMAFq7YA61veOk6Gno4BVKbHRWui+LTWLqEnxl8h7o5a9uSqeaJeewYyo7dG7n93OEgDf5RRDNMBdSVnU15ctvo2cDnYqF86sNoA+qheln3E+qhTUJVk28O8yMWWRYGbxXS8cY7MJMVuVdFVBS6GQTayMK29Z+ngvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832262; c=relaxed/simple;
	bh=pNTP5KAhWQVKoi5tIE6ZiagSXkkKSX/ysVVnKPKlVr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAQI/xrGxT8AhOMQAnCbklVzo4iE0rv9rNNbZwwZIjn/9wbz4N1g8ER2MP6khAx+IVTcZ8BNO9OCfSnhP3U3u21ToZ+SNb33EXq5c7HozmhO3Q9h8dIll/CL4Jj1pqY0EgtXnAPKRcKm9bEGmTTm029qZbmScWOwJKPHeJ9+jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+KGT/67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572BBC433F1;
	Fri,  2 Feb 2024 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706832261;
	bh=pNTP5KAhWQVKoi5tIE6ZiagSXkkKSX/ysVVnKPKlVr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+KGT/67532lFzqQWf2qp3tEQorF868vzJZSYmvHQItVKOld9voLEOnX1YQRZ1bpV
	 uSH1edCyj/dVEW4eAAELqpFN1q4r+oRhMt6WU1ibyhSPxcyznwDUmVrsgxLXEclXU3
	 BtHKdPgfJVJBqGnBYEzRcMpIfkqpur6x6SVlGdkkLcNXj629OvnzBgSVHpla/mhQhO
	 CPP1ffEZGugqzf1Rl65diOQ0BEJHt4DE8abW73qbN71EIStTVUfCISOy/NX2AjG49h
	 f85TnUcQ4PBt2QC3KYFKw2wDdMPySEHwxBXLAhDvkLCgOoiuQI0czdC+ClRwVNCDZ7
	 9tF5c0XkBmPzQ==
Date: Thu, 1 Feb 2024 16:04:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Breno Leitao
 <leitao@debian.org>, Jiri Pirko <jiri@resnulli.us>, Alessandro Marcolini
 <alessandromarcolini99@gmail.com>, <donald.hunter@redhat.com>
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
Message-ID: <20240201160416.0da06952@kernel.org>
In-Reply-To: <029065d6-faaf-4e58-ac06-4e11c2ded02c@intel.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
	<m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org>
	<m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org>
	<m2jznuwv7g.fsf@gmail.com>
	<20240129174220.65ac1755@kernel.org>
	<029065d6-faaf-4e58-ac06-4e11c2ded02c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 12:53:08 -0800 Jacob Keller wrote:
> On 1/29/2024 5:42 PM, Jakub Kicinski wrote:
> > Whether YNL specs should replace policy dumps completely (by building
> > the YAML into the kernel, and exposing via sysfs like kheaders or btf)
> >  - I'm not sure. I think I used policy dumps twice in my life. They
> > are not all that useful, IMVHO...  
> 
> Many older genetlink/netlink families don't have a super robust or
> specific policy. For example, devlink has a single enum for all
> attributes, and the policy is not specified per command. The policy
> simply accepts all attributes for every command. This means that you
> can't rely on policy to decide whether an attribute has meaning for a
> given command.

FWIW Jiri converted devlink to use ynl policy generation. AFAIU it now
only accepts what's used and nobody complained, yet, knock wood.

Agreed on other points :)

