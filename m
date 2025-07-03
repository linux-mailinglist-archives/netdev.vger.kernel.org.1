Return-Path: <netdev+bounces-203767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDCAF71BA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97208561CF3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187A2E49AD;
	Thu,  3 Jul 2025 11:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE72D193C;
	Thu,  3 Jul 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540716; cv=none; b=YGH7iWorqVyPUezReotphBKSiKxpCJCY/AKzSG2+hP71pr1zoAsfbOnCqIiBbgD5fwNAKj3hnstB6f/oFvL7yzjo0uSvTRZtXkZH/raU+GQo4Pwh3r6nAVduqRBV2EeKxuq4uRjMnKCTQIiKxEyjtG2BNIo2qCjLJPHV/WtMIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540716; c=relaxed/simple;
	bh=9tkZXPXcsHuWWnloRIZizHQqFD7Jkc66m8088svhd9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqvA1aQ4MdRN3/E5lOiJTRU82BQalHFy3/d4eBYYk03EB/UKfwn6+g7UHKwF0cHxAwfHHWB6QB9u0ffkloIbLGSMVFMsfShHO3/jdEvEP8u9OuynKJ0pA3WF/kT7LY0w6Or1LgPN0AQehUJuji/Zqj4N6GIRbrBEotzNhtjXku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 342FD479E2;
	Thu,  3 Jul 2025 13:05:12 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:05:11 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <bes2ehifwb25xwbxg6dog27hi63vzn2phnhtiibed3wgazjpms@cwcrjo3ky7xq>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <20250702073458.3294b431@kernel.org>
 <7c47cfb6-c1f1-42a1-8137-37f8f03fa970@6wind.com>
 <20250702091055.3d70a5ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20250702091055.3d70a5ee@kernel.org>
User-Agent: NeoMutt/20241002-35-39f9a6

On 02.07.2025 09:10, Jakub Kicinski wrote:
>On Wed, 2 Jul 2025 17:14:42 +0200 Nicolas Dichtel wrote:
>> > Should we invert the polarity? It appears that the condition below only
>> > let's this setting _disable_ forwarding. IMO calling it "force" suggests
>> > to the user that it will force it to be enabled.
>> Not sure to follow you. When force_forwarding is set to 1 the forwarding is
>> always enabled.
>>
>> sysctl | all.forwarding | iface.force_forwarding | packet processing from iface
>>        |      0         |           0            |        no forward
>>        |      0         |           1            |         forward
>>        |      1         |           0            |         forward
>>        |      1         |           1            |         forward
>
>Ugh, I can't read comparisons to zero.
>Let's switch to more sane logic:
>
>	if (idev && !READ_ONCE(idev->cnf.force_forwarding) &&
>	    !READ_ONCE(net->ipv6.devconf_all->forwarding))

Agree!

Thanks for the review.


