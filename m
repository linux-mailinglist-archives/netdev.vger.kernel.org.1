Return-Path: <netdev+bounces-129436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B5983D85
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721EB283B92
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67782D66;
	Tue, 24 Sep 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="To6FzJ9S"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6186823C3
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161394; cv=none; b=uVCMq3lR3TeaPZmgmL/DIQ0Rk1PCvXvKb9cj7HT5JPziMKk5YaXWRVAU7MELllJHVGETlXkSn1ycXIcGiKU9TOFsgrJZsxf8E0VzOmTMbe8lTp+nTgMZ2rJIk57mdb05LUXOVXAmkREnJC4rvd1MEqDEQjMz9TwO5x0ERAAFskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161394; c=relaxed/simple;
	bh=PQBhNrdKuSSpZYdlBoYbqtq3Owo7A1DXIW40a51sY8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=Uxc7WkxoGxPeLWE1vz8t0nA44w06SGQiupkVMenE5VgEYN+UjVLcdme0RyRcpZYDk4w1HNrn/DKxPuxVJiaAPKjBZK+ECEA2VvVgWlrI7VZsILdDdIxluCAdigVMkI6D3MpzhcPW8Ln4Hk9z98J3sWZl0lE4TW3VvIVradIic5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=To6FzJ9S; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PQBhNrdKuSSpZYdlBoYbqtq3Owo7A1DXIW40a51sY8M=; b=To6FzJ9SSc2bJ66OfiVnRBavwp
	H/054ZWYQPVjFNhEKIUbYMNZmgFTeidyY4hlOkswkgl6HokBRhKVMIIIEnNZ0JlUXZbERS6TPpk4x
	kQYlBM9x7ILX5JOTOmlf/e3Dz+MXfAAi31ouPC5waxKxquE8vv48HVDH3aD+DtF3wyYF8vQWwaJ0W
	5YhkYdXtQRcoTetkpbWcQKjfkizydhDktF/hmTrA7OSmTmFMoIU3SHehO1l1TBNIshEE09oTqGaiX
	aOWeu6kPHvk7gG06Dp3tFixStB1aFqOTfGO8SJGUUH34YVMnxmyqpJL0Wq5TG5ddCruiZsPISrD/X
	HR665GQw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sszZh-0005CT-Ug; Tue, 24 Sep 2024 09:03:05 +0200
Received: from [178.197.249.54] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sszZi-000Jiz-07;
	Tue, 24 Sep 2024 09:03:05 +0200
Message-ID: <6ea4bd33-180b-4b03-9108-6b316b10fd13@iogearbox.net>
Date: Tue, 24 Sep 2024 09:03:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: Fix gso_features_check to check for both
 dev->gso_{ipv4_,}max_size
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
References: <20240923212242.15669-1-daniel@iogearbox.net>
 <20240923212242.15669-2-daniel@iogearbox.net>
Content-Language: en-US
Cc: edumazet@google.com, pabeni@redhat.com
In-Reply-To: <20240923212242.15669-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27407/Mon Sep 23 10:31:24 2024)

On 9/23/24 11:22 PM, Daniel Borkmann wrote:

> Commit 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
> added a dev->gso_max_size test to gso_features_check() in order to fall
> back to GSO when needed.
>
> This was added as it was noticed that some drivers could misbehave if TSO
> packets get too big. However, the check doesn't respect dev->gso_ipv4_max_size
> limit. For instance, a device could be configured with BIG TCP for IPv4,
> but not IPv6.
>
> Therefore, add a netif_get_gso_max_size() equivalent to netif_get_gro_max_size()
> and use the helper to respect both limits before falling back to GSO engine.
>
> Fixes: 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>

(Sorry, Cc got missed due to config issue as I recently switched to a

new machine.)


