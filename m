Return-Path: <netdev+bounces-152504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05B9F459A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEBE188EDC2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE71DA113;
	Tue, 17 Dec 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="eA3Llngi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF21D63E8
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422410; cv=none; b=oT/ltYTzTukrVoxFUyK6y8ALyMcB9eWAvdWYOBhsE2QOPajHwVawbs3l9E5FZYS74Uci8opi0if/toRSTWv5nOonOrdrYU2NGs7M1KrhbxbdbUsgz2nUkorQdzTgiduL4WMlAzor0FuOGEWn8YVfo48rUzWVEskKjKK+muf3J18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422410; c=relaxed/simple;
	bh=42m/kXPZ/0zi5GK4jtizOT+wRG0RN+4xoJtIiTADehs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=WKG64r5+sugI92+mADu0IT1T0LOWbuqAVUxygYLc8kusU72EVi4NJVIdMrrkdSwGd+O+PklL5ddxD8yLKDunVWRfDcwtkmtFOkAy7hfmmxzeGyPG80UUJ5D056COvK/rXdIciCDu37s7OFyxN4Obfs7/v1taW0V5D2vD2m+B4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=eA3Llngi; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:9c63:293c:9db9:bde3] (unknown [IPv6:2a02:8010:6359:2:9c63:293c:9db9:bde3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id BF3787DEE1;
	Tue, 17 Dec 2024 08:00:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1734422401; bh=42m/kXPZ/0zi5GK4jtizOT+wRG0RN+4xoJtIiTADehs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<14f4b2ce-37b0-e187-17e3-004ebc29ef99@katalix.com>|
	 Date:=20Tue,=2017=20Dec=202024=2008:00:01=20+0000|MIME-Version:=20
	 1.0|To:=20Guillaume=20Nault=20<gnault@redhat.com>,=20David=20Mille
	 r=20<davem@davemloft.net>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel
	 .org>,=20Paolo=20Abeni=20<pabeni@redhat.com>,=0D=0A=20Eric=20Dumaz
	 et=20<edumazet@google.com>|Cc:=20netdev@vger.kernel.org,=20Simon=2
	 0Horman=20<horms@kernel.org>,=0D=0A=20David=20Ahern=20<dsahern@ker
	 nel.org>,=20Tom=20Parkin=20<tparkin@katalix.com>|References:=20<co
	 ver.1734357769.git.gnault@redhat.com>=0D=0A=20<2ff22a3560c50502289
	 28456662b80b9c84a8fe4.1734357769.git.gnault@redhat.com>|From:=20Ja
	 mes=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCH=20n
	 et-next=205/5]=20l2tp:=20Use=20inet_sk_init_flowi4()=20in=0D=0A=20
	 l2tp_ip_sendmsg().|In-Reply-To:=20<2ff22a3560c5050228928456662b80b
	 9c84a8fe4.1734357769.git.gnault@redhat.com>;
	b=eA3LlngiGyx5ndHmek6KKlRTWH0aHoNHToesTsvGbLgNx7uDUeIe/MC8fMrPhxKIu
	 hDtwssMSlfdNBfgENarRkhk2mGP4FI9Z8AT7Cez+5y0w5Qorq5y2fZAFahY8HvHaxy
	 zNsqSUmfjO24vv7TLShL9JnHQKwHjSn2xmmwT1BeYZutlmtDPa8yUSRbXnObU4063a
	 HRlT3dYWTZSh0k5Z3DCZT9HGTs1a33PWPs+R5CDWdyOpW1FHp+ufMhkkHozdtlzjf2
	 4jmaWUB5q5XsyD8mHMtRbOQtlpzQ4DMAcP5VDr7hIGRLtcUc0Rr+Ini7D0d9151k5Q
	 SkmYIlkrZUt3A==
Message-ID: <14f4b2ce-37b0-e187-17e3-004ebc29ef99@katalix.com>
Date: Tue, 17 Dec 2024 08:00:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Tom Parkin <tparkin@katalix.com>
References: <cover.1734357769.git.gnault@redhat.com>
 <2ff22a3560c5050228928456662b80b9c84a8fe4.1734357769.git.gnault@redhat.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next 5/5] l2tp: Use inet_sk_init_flowi4() in
 l2tp_ip_sendmsg().
In-Reply-To: <2ff22a3560c5050228928456662b80b9c84a8fe4.1734357769.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2024 17:21, Guillaume Nault wrote:
> Use inet_sk_init_flowi4() to automatically initialise the flowi4
> structure in l2tp_ip_sendmsg() instead of passing parameters manually
> to ip_route_output_ports().
> 
> Override ->daddr with the value passed in the msghdr structure if
> provided.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

This all looks good to me.

Reviewed-by: James Chapman <jchapman@katalix.com>


