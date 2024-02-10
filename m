Return-Path: <netdev+bounces-70743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB685038C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D02BB23B00
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F02E3E3;
	Sat, 10 Feb 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="UWDvjfmG"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C628DA4
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707554912; cv=pass; b=i6fGS6VsjZS7u4F1R44nB42T+XdFPd10qMwFEqfDGDekl89nhKgnNNeQFNjNrVTuoUbEqA3EbnO1QOyyd9TyJOZUM4tloL436TJWI+e+JMeLImlIrVilOilmr53crFlRQto4GIIi1iA6hG5WMIMzo7FIHk0mHVzfbnM8OIlb7gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707554912; c=relaxed/simple;
	bh=sSPXNwE5vTLSN5n6ZcnolmzrMMV7FnNR2dLXEMv6gg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoOdevRTLT4SiElOjknRdYvBd/gW0R7dIVawBpshXHPuiLB2PtxYtdhe8ZyHgM6QlccE9hDn5XOG4pGHXqz7j7yvjp5kHZQ9jSiq0dm5Jd8Q0DZdDf7vThKDb7lZuyIk+6LHnNemW9nM4JxN8GXF9thx3z/JmeEBvKi1qto0NY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=UWDvjfmG; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1707554897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i6W0MmvanaC2Jyh+325xlBwyu5R+amv7n2gNlFh7gP1tu9vdKhwvOQop8/2jzswBkoBW9sjs/U/u2mDVRFCt95exioz733mD12UnwUSnwKDZBn13G94l+Y6Czng1PBXKgoGbFXmORXG3Mv7yNAvcdzoDfBuIqH5UrgPChMA2Rh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707554897; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vFQ6lKj6Y4ynk5FepbItJh5TgyG0vklA30HtEpS9sIE=; 
	b=TYDbUrKpv/QAAaojl41OrO2uNy4HPIIf40/QqwoZZQGSXlrmdWsVRWp/7h6DHkYBZLf/rPiYMpJZ27lG4P2ZrZKKUOlEsj9T3smpaIt/9Yg8mdtQNr0OiVVrU0ZrI3wpALoks0IFoHwm5W5hRnNnmVXv+Vvv3I/IQbQFLUmPu+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707554897;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vFQ6lKj6Y4ynk5FepbItJh5TgyG0vklA30HtEpS9sIE=;
	b=UWDvjfmG8ZumH1l3ZnKfrHAkMj/cR8eG4AQoCJa6p/H/Eyf3DpYrmMiymrB2eoI9
	DtQoLJ/OCRNxmDhGTyW3ScA5PdHkODkh+CDzCPyMAAlb8zvzIGHB7f2X0RSHNq4rCqy
	dc5IzcYIKAAdwGe8AwGq4epiZJ/M4Taa5oXxI21xTo1dSzOO0C3R0x/rFVtzLsydIGn
	dWeiDdVpbX2hdF3zF8kc7GupKNLJlpOaQ2JYLezmqElALAhBB4hV9+mJ8e0kx7FvhsN
	rp6g8PmXchDqIWD8/LnakQ1qLRHLjU0oUdzbim9mKtHYNbqvTnWS3f+bwjMQTpxPjYS
	mJveMkw8kA==
Received: from [192.168.1.225] (83.8.237.114.ipv4.supernova.orange.pl [83.8.237.114]) by mx.zohomail.com
	with SMTPS id 1707554892566167.19528057587877; Sat, 10 Feb 2024 00:48:12 -0800 (PST)
Message-ID: <01747e34-c655-4dbf-bda9-544f4e3f8ebd@machnikowski.net>
Date: Sat, 10 Feb 2024 09:48:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-4-dw@davidwei.uk>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240210003240.847392-4-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 10/02/2024 01:32, David Wei wrote:
> +###
> +### Code start
> +###
> +
> +modprobe netdevsim
> +
> +# linking
> +
> +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
> +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
> +
> +setup_ns
> +
> +NSIM_DEV_1_FD=$((RANDOM % 1024))
> +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
> +NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
> +
> +NSIM_DEV_2_FD=$((RANDOM % 1024))
> +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
> +NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent netdevsim should fail"
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent netnsid should fail"
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with self should fail"
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
> +if [ $? -ne 0 ]; then
> +	echo "linking netdevsim1 with netdevsim2 should succeed"
> +	exit 1
> +fi
> +
> +# argument error checking
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "invalid arg should fail"
> +	exit 1
> +fi
> +
> +# send/recv packets
> +
> +socat_check || exit 4

This check will cause the script to exit without cleaning up the devices
and namespaces. Move it to the top, or cleanup on error

Thanks,
Maciek

