Return-Path: <netdev+bounces-242040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA81C8BBF0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3ED4E4A82
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484E3161AA;
	Wed, 26 Nov 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYN2xCna"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0422AE7A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187281; cv=none; b=Bcv6RsEEZp/+0TT/CXMBFU2ikAzgwFFT2+kD5XMHqt21638EYyPXVjeFw9qm3etvHlIKAHET36A1UlSRzN9QZ26c5uj+VM+Qz4N/8Wn6DASuKXW7OQo+ddXnrsM8PRRUSIPyQP3b103wGdOip0ET6lk0EpNf6UF9PisaQ8lz8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187281; c=relaxed/simple;
	bh=CVk5Ik3dMIJ4Xe2jy9D7p0ieUE7u9nbrX6GfzALmaqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjWPIlM46LCQ7zcNldrzxuv7tGK1ia4dhlbFUwoaOblSONk1/4A+g88nSGjYFpvM70qN1cmTpj/Z2wZi7xCdVMsG1uixywxDuc9hJ7u1YWQ4FLYJho/ckm5ukUZthVNsYUcqCDGvtphNG+052wDrLLPJcO0tM101+YVFknOWJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYN2xCna; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bde0f62464cso149414a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764187279; x=1764792079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qMn6bFYv6kGyj9tjqAoP1eZ0Ua/HYVXcdKwly7wduc=;
        b=PYN2xCnaRgPjqeetusEZbuufrQ+wK6EsLQ8THeyYpNIjt95WHCimmVz6VErlmiyCOF
         pXXUpaqXV6IVyj1eUVek5l+FEYzBj9YaBFZyGcZJIozcktI//abygjvIwKrGNW3UNMIr
         xNb5CvwW6im3BWjD/j5Y/Z+hp96/qXqy56PbATJPoWRVOzVLCarRtnqAVvNYhTdy5IP1
         rxVxwlS9qcGRoUD/8fn63V2hFt5ZHD5WJNX6u2VZm6pc1FzOremoExxvRns2cZ4ly8Bq
         Muvmb4V90QZYxcXMl3O2R2ObFZ32vxlv16HzKqhpKYpTteNH/ZiewmFeesapIMzNxemx
         yPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764187279; x=1764792079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qMn6bFYv6kGyj9tjqAoP1eZ0Ua/HYVXcdKwly7wduc=;
        b=J+vNW28JUacBOfKHBKgA0myxhMCu2moJbpt+dZR/ae31o6eLSzMFNNJ5xnGWhoXQA7
         JxBU6M2hNgFL7TsFCtbQ/2PvbKAbQwzNV66LHXb7MjuYYDeRbh3tUHm8c0/HFstsfTcZ
         nIRp//jaoKJw31/WbzuuEiEeTU6qIn/BscZouZfoZ5uhaeQeHVxhVWomeKJY0Xh5+9ku
         5p1Q8DnxKbWg4PQywZ2PEEyZZJ4Og0CBNbn5N5rYDJdReb8hWOy9BozisHihm5PvL3oF
         8u/I2R+6w6moe7zKZad52+WQeptEyKrkf4Fr/iucgV4T2KaL7JQ0mzChmuwgWJ7hkPGt
         sV3Q==
X-Gm-Message-State: AOJu0YxnWbmjt01kpcT9Rzc5JuQaAPZw9kCKTL5ThgED/LoJjRCWJ2Oq
	tbQRMhcP9iBPKL+NzYSjE7eXGEWxMsp11b/phoqHrYLAAxohvyaWD8hI
X-Gm-Gg: ASbGncuGI5a5WsqxvRGwSwgDjUrBNRJz4lx6XEFpdLGHHS5RxRcQ7mzjI2prNIjeEPA
	juKB8WWQjkhsB8AHb8PFVvAYzifwjNvKficc5vWodep9vWEeAkVcnNgSCK1XbNEe3Rw6KpggfuM
	wYO8ewmlaGb1Rn0kUCvQeYqeds1ZqQCMKPc54D2cSLfAzNi/CxB8MnlrK56ZZ7YanyKOngXFDZh
	3DPgfTD7XoS8bFK9ax0Ys/rc6VEirvJbu9jthMBFlb4jXH7n93SM6K9nMj2H04B8jT9QZD3qvOE
	o6reqsCWAFqisLGXMeCVsxgDc+F0hDfg6UQudLoliyjC0YelDHLsWsLM+ASwjYijqKfCQ/7Dv60
	I9okxwjQkv1pOdsEoeJ2Bdlilw8UqyWW7tZYyBzB9OgnFx7h7lTQsZARCpLGZe56ptBT1xA/NYD
	yCTA0H2UYsa1JnhPPA+qYu
X-Google-Smtp-Source: AGHT+IHXHo6GNNm0POh1mAORb4BYcYXcF5Rd5TJ50ua+awlutI6+xROA5iFvORHBUkDOoIW/B5qFaw==
X-Received: by 2002:a05:7300:6115:b0:2a4:3594:d54e with SMTP id 5a478bee46e88-2a719d86ae3mr13955158eec.27.1764187278729;
        Wed, 26 Nov 2025 12:01:18 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm24363259eec.3.2025.11.26.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:01:17 -0800 (PST)
Date: Wed, 26 Nov 2025 20:01:11 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] selftests: netconsole: validate target
 resume
Message-ID: <hjty4katdz2lmkbjqt4tourk6nf5eq3x2nh6if4ay5xdslpr6n@3htraj5r67py>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
 <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>

On Fri, Nov 21, 2025 at 12:49:04PM +0000, Andre Carvalho wrote:
> +	echo "${BINDMODE} : Test passed" >&2
> +done
> +
> +trap - EXIT
> +exit "${ksft_pass}"

Shellcheck complains about this line given that it expects that exported
variables from other files are always uppercase. I'm going to submit a new
version of this test using ${EXIT_STATUS} instead, which is the same approach
taken by a netcons_torture.sh which was recently added.

We may want to refactor these tests to make use of other selftest's functions
that actually mutate EXIT_STATUS based on the intermediary results of the tests
(by using log_test and other functions from lib.sh) which I think may also
help with making result logging a bit more in line with other tests. I'd like to
do this in a separate series and migrate all tests, if we agree on this direction.

> 
> -- 
> 2.52.0
> 

-- 
Andre Carvalho

