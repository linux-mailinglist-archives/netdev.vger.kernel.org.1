Return-Path: <netdev+bounces-92550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC58B7D45
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0671F21BB1
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1F179675;
	Tue, 30 Apr 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Z4U4g3Bo"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB33E478
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495054; cv=none; b=csqDX9js2QjkihzAwEffV6NYqwAg4Mlz+Vq/UpjDHBAu8tIyU5Tt6gPRynGkNNSJGPRreQr1CPG2nGymBBpkRtxhfyGRj+aPT6uocfccxaRZsZMCJA2N50R6Rf2RSFUByRFTQyy49h3Lwc+Yt2UtIEc9DdQtFYMK6LC4YqwiyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495054; c=relaxed/simple;
	bh=x1n5fVuIZUseUv4Z+iVLcNclM8sW+3M9KXYfpHYfyms=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=UeF8m+86f4gVupLp1LG3ULR/qX/C7QA+8S+9hTCEftuJrHoIoz6DNb7O9jBgix+ZrB235LztqDPCxmi5KTY1sFp3D6M1qT4vD0WUONRcJNPr2oTCpSOJ4gww13Hvv7SmDBNK2CMqsWWax8i8Io4NFu4DhOxZZyI3DuvP2vnVKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Z4U4g3Bo; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:f8c1:ac3:4d22:e947] (unknown [IPv6:2a02:8010:6359:2:f8c1:ac3:4d22:e947])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id E1B3E7D8BA;
	Tue, 30 Apr 2024 17:37:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1714495051; bh=x1n5fVuIZUseUv4Z+iVLcNclM8sW+3M9KXYfpHYfyms=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<212f8956-0c8b-569e-781f-80216f858dc8@katalix.com>|
	 Date:=20Tue,=2030=20Apr=202024=2017:37:31=20+0100|MIME-Version:=20
	 1.0|To:=20Tom=20Parkin=20<tparkin@katalix.com>,=20netdev@vger.kern
	 el.org|References:=20<20240430140343.389543-1-tparkin@katalix.com>
	 |From:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=2
	 0[PATCH=20net-next]=20l2tp:=20fix=20ICMP=20error=20handling=20for=
	 20UDP-encap=0D=0A=20sockets|In-Reply-To:=20<20240430140343.389543-
	 1-tparkin@katalix.com>;
	b=Z4U4g3BoeLpRC4aVp+/cHqYV6yw9YqpV+8oLItbcVw+ezekKBnvfEksYAi54mvgSq
	 38Ncwzs0GDvCQd94tHMnebz3PSnGYrhD3iQr59YGGdZiTDDKZpkkWDhTgqs6IqHwHt
	 gtWpEBcX56KTrIAZS0AErLZuaGcVZouRDNnkDj5V601dSLQJSWIHYjUbuUmDlHD2Wq
	 upRz6EVO+US0+cDYB7goub2x9tZU/5vXUnWE8g7kjJVN2laFKIKvFGI7l0sw/QqkHf
	 9hZPmeY4CbwswxvQz27yoD1QgIMjjdehT8dB4x3RITl7+YlgtufE/vDRRJPlc5hiUs
	 P/UDPdkrpgOsg==
Message-ID: <212f8956-0c8b-569e-781f-80216f858dc8@katalix.com>
Date: Tue, 30 Apr 2024 17:37:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Tom Parkin <tparkin@katalix.com>, netdev@vger.kernel.org
References: <20240430140343.389543-1-tparkin@katalix.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next] l2tp: fix ICMP error handling for UDP-encap
 sockets
In-Reply-To: <20240430140343.389543-1-tparkin@katalix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/04/2024 15:03, Tom Parkin wrote:
> Since commit a36e185e8c85
> ("udp: Handle ICMP errors for tunnels with same destination port on both endpoints")
> UDP's handling of ICMP errors has allowed for UDP-encap tunnels to
> determine socket associations in scenarios where the UDP hash lookup
> could not.
>
> Subsequently, commit d26796ae58940
> ("udp: check udp sock encap_type in __udp_lib_err")
> subtly tweaked the approach such that UDP ICMP error handling would be
> skipped for any UDP socket which has encapsulation enabled.
>
> In the case of L2TP tunnel sockets using UDP-encap, this latter
> modification effectively broke ICMP error reporting for the L2TP
> control plane.
>
> To a degree this isn't catastrophic inasmuch as the L2TP control
> protocol defines a reliable transport on top of the underlying packet
> switching network which will eventually detect errors and time out.
>
> However, paying attention to the ICMP error reporting allows for more
> timely detection of errors in L2TP userspace, and aids in debugging
> connectivity issues.
>
> Reinstate ICMP error handling for UDP encap L2TP tunnels:
>
>   * implement struct udp_tunnel_sock_cfg .encap_err_rcv in order to allow
>     the L2TP code to handle ICMP errors;
>
>   * only implement error-handling for tunnels which have a managed
>     socket: unmanaged tunnels using a kernel socket have no userspace to
>     report errors back to;
>
>   * flag the error on the socket, which allows for userspace to get an
>     error such as -ECONNREFUSED back from sendmsg/recvmsg;
>
>   * pass the error into ip[v6]_icmp_error() which allows for userspace to
>     get extended error information via. MSG_ERRQUEUE.
>
> Fixes: d26796ae5894 ("udp: check udp sock encap_type in __udp_lib_err")
> Signed-off-by: Tom Parkin <tparkin@katalix.com>

Reviewed-by: James Chapman <jchapman@katalix.com>



