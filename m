Return-Path: <netdev+bounces-218976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67EB3F265
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D87AA3AD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9C2848AF;
	Tue,  2 Sep 2025 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQMchYF9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273635948;
	Tue,  2 Sep 2025 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780626; cv=none; b=S7ugTMEQTUquhr127Y/+hiVvr3bhokT3bo5x37c7gwO7NSURSfJIDvMQ5pM21QNRK45oDtn9lG+QKYb6CtQmsXzdugrWF9rpM2vqu4B6YcFLIhiwwVRcI/al+JPdn02W6tYNSNjTkd+Em4z9OK8udx/Nlh7T5hcBS515mqGMyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780626; c=relaxed/simple;
	bh=QqOBreW+xBMXDcrIkpYrP7uQt95JX2C+s66IJUVnIZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udhk4mt9iljApKw8RqiiDEiDSfObppG7cIEpiS6jBr7paj5hCbm+hitTt42KRa5DRk3th/QMWyBmQl53AKZWBAQRyrGhvHwf0wzzT5Rd3P491PqjXT4LwGGCKCXhA3x3M4Zca/S1d87y8mNjFAfLVwo8TkPW/my4pCz3d1uNeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQMchYF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB41CC4CEF0;
	Tue,  2 Sep 2025 02:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780626;
	bh=QqOBreW+xBMXDcrIkpYrP7uQt95JX2C+s66IJUVnIZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PQMchYF9KDJXOtdSIrM6Ol/EHB1lfzga0bGDY0DoDQnoCjlP52bXh6tSQJy8Mc2GS
	 D3wjIpUPugl2vHj/v+isdVvDL3xqd0rElfhik9aZ4msSFO8azl7dSfc3w5DVOsP3Rf
	 JIr8mljkFVeDjKQLRCk5FSOxcesG+8gsMNbx2+C2pf3O3NqKcgBJ9hVOrWhqp1H9TX
	 TnUHzntwYQA2mDdc702yaGGeONwdjhEsQVRXtQBf0RAR+GSGObsDWmi455PelYTLhI
	 CVrz1KT99waZ615nmfC98JqYoVEfmYtefH9S7D5WTQgyhYyl4b62uowdXpr4EOBpcj
	 BCartIlS+BksQ==
Message-ID: <3e523601-88b5-4aba-bf90-916b87d73555@kernel.org>
Date: Mon, 1 Sep 2025 20:37:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] ipv4: icmp: Fix source IP derivation in
 presence of VRFs
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> When the "icmp_errors_use_inbound_ifaddr" sysctl is enabled, the source
> IP of ICMP error messages should be the "primary address of the
> interface that received the packet that caused the icmp error".
> 
> The IPv4 ICMP code determines this interface using inet_iif() which in
> the input path translates to skb->skb_iif. If the interface that
> received the packet is a VRF port, skb->skb_iif will contain the ifindex
> of the VRF device and not that of the receiving interface. This is
> because in the input path the VRF driver overrides skb->skb_iif with the
> ifindex of the VRF device itself (see vrf_ip_rcv()).
> 
> As such, the source IP that will be chosen for the ICMP error message is
> either an address assigned to the VRF device itself (if present) or an
> address assigned to some VRF port, not necessarily the input or output
> interface.
> 
> This behavior is especially problematic when the error messages are
> "Time Exceeded" messages as it means that utilities like traceroute will
> show an incorrect packet path.
> 
> Solve this by determining the input interface based on the iif field in
> the control block, if present. This field is set in the input path to
> skb->skb_iif and is not later overridden by the VRF driver, unlike
> skb->skb_iif.
> 
> This behavior is consistent with the IPv6 counterpart that already uses
> the iif from the control block.
> 
> Reported-by: Andy Roulin <aroulin@nvidia.com>
> Reported-by: Rajkumar Srinivasan <rajsrinivasa@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/icmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



