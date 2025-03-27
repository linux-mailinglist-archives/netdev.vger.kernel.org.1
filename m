Return-Path: <netdev+bounces-178020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E63A74056
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F031416A52E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FE1ACEB7;
	Thu, 27 Mar 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QktxJcJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2838462
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111385; cv=none; b=ZAkFX/HmiAFoVLCjZt0ckmkrIas5DfuySQQcLNFRLX6WXh32XJlZOgUiVDJl/T5GduxprpPg9YKSdjVWUVmwjuAUx8LkQKyFNUuZzQjLjnV1CxNCcg/ZOu8AMltwImYcelmKwm8k+f+4Q9G/ePvKiIOml9GeFIv/B3iQw2Y0jPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111385; c=relaxed/simple;
	bh=+oRxpdRhHGHwjVHoS4HRm80C43MgpN+2btuCL1gv55A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9HEu6GGJiJzTket7xGW2I1tgDoAF0HjaVwUhm+lv8TKYyHXb17QE+ijeovZnNVWivdNtiO08IwhVgvJBKI1rVZfWcK1jKVLnVODzh5ZCAi7UrYpRXKMdptr2AaSHgE3BiWq1Ul4MpVZ2HpkXC9V7vClBHvVA2LfPzqIqwzNDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QktxJcJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEB6C4CEDD;
	Thu, 27 Mar 2025 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111385;
	bh=+oRxpdRhHGHwjVHoS4HRm80C43MgpN+2btuCL1gv55A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QktxJcJVdYFv8+n8sXLEhP7na+rtfys/Uzz0w5oAuDCLhFLpOUA8gLxh0qXkOYpqd
	 W7314gKaERnOBs2WvNuZu0wB5R+oBY4LcBinXcFbS/iNREkHQnETfDe/34Fi1Y4QUO
	 3sksuGlBmXOdGTeeUQ90JNrY6mPOpRJGDPrBlIqU38LIPADFO07biLQTT5+/h1P2rh
	 KT9hDsGjIAWUJSrZTrY4nAi3E4J/zEdOD1pIre9YkBzb560IivLMdRoNlb0y0B4jhF
	 uvWMTioALFkocaE0hwYUYiP6M0QvlGRSTvT44xwqXtNPROHsesL8uP4OjsP/mIeAtj
	 P0jO8XzQpImYA==
Date: Thu, 27 Mar 2025 14:36:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <20250327143623.62180058@kernel.org>
In-Reply-To: <Z-W-c8RyFxg30Ov5@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-2-sdf@fomichev.me>
	<20250327115921.3b16010a@kernel.org>
	<Z-W-c8RyFxg30Ov5@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 14:09:07 -0700 Stanislav Fomichev wrote:
> On 03/27, Jakub Kicinski wrote:
> > On Thu, 27 Mar 2025 06:56:49 -0700 Stanislav Fomichev wrote:  
> > > +EXPORT_SYMBOL(netif_disable_lro);  
> > 
> > Actually EXPORT_IPV6_MOD() would do here, no?
> > We only need this export for V6?  
> 
> This patch is touching v4 net/ipv4/devinet.c, so both :-(

IPv4 can't be a module tho, we're talking about an export..

