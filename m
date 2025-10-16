Return-Path: <netdev+bounces-230078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C25BE3B1D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F4F427B7A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89E32C319;
	Thu, 16 Oct 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ONFSU7e9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AE1E5B73
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621105; cv=none; b=rYXkYO/Lm2LEgaHryvaYPxx/jPKLJ4rsnVvYzK3K7GqauXOEJ7ABN1eFHyaPvUjUUM8MyXAD6/T7FzS4Epi1FRx/Ng5CqlBjcGbxn8M7np6mU9E9ljRvModcEFv0cGktBHhCfOoXnO+VDAnUOQyVZGRteA5haHIl1PtyvTc1s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621105; c=relaxed/simple;
	bh=VruJw1T7uhapGa0jtAj1x3LRy8FHdBE1j78JBq4QfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXWaqK0KriVRlqoXFKCykuzyhRtex4/C9kZcuv6/Ph8EXj3L1mH8iaCmVQ/Bol1lpn16SsSZnte5y6YGwC2NhoAX/b2w6pdxlD4NjxMyWHakuX8ZC8dA8UlURvkNhvWZylSr6Eo+ixtiGcxx2gdM4rGUhig88TYvogy0NDQCLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ONFSU7e9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so8520885e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760621102; x=1761225902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=ONFSU7e9ZfkjbcBQQekg+7RJxFGCkdpe0suu2cT/r1wbfVPBbPpS3S1xHOdJXBC0WJ
         T9aw9iliMWS6bT47IHV7DKU8DcfJX+ajRIcAjgLpkpUUmcOIpVdxVtjnJyxkuErkRfkL
         T6kUOnNtuQVl6zuLuKFA13te1Em0kJtXQ0lQoHCj+wVosl42Ke96kmdkPm7vA1CwLyCe
         6YeAsJEkgk4vcFk/ASg3xngRHoLJIhh9EVYDsM2lErx1iWGkg9CN2ZYuaAIbq/poM3Z3
         vz6zDnFSxqu33aLoRbs5Lzpnb+vvI5aOK5ocKH4iVJ9ac/w6meHkZZ2W59FzhHblUOuO
         6HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621102; x=1761225902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=pcz3JoCsxtGaut1f8AYDHxbwMcxTYu95M0S3Ot/900C7y7RjdANwl8OYfLayJJjCvq
         1nWarEu7zoCn5ByHbSjEtuFdrq6huEaARNcK6VrcyvKCyMsV7tHEj5ehRfdTqpTFPG9g
         dD+9+MkAXZCSqJR2nwRza+6XJfKXbsd/u75zIG1MAJgpqSbTwpw/NkSrjbVckIi8gaWy
         FW3zbt6OG15rU24GNPenHfHbQfi+toieDwQK2ml1GB/BPFCq7WjQbd6zkCFCcowi3PCo
         OE1gjQFgnc0JNUTmke3Teuaf99IbhsW2PPmuMp98Twf+S2h7r2t72vG49IdlrepAFpYn
         /Z8Q==
X-Gm-Message-State: AOJu0YxvFZCeDffiY4YvPFjUN8n+KigpfA3Q568y/wMf0AiwlPhxxvmu
	udsyzk8xDxMqetr1lb1xt4Tn9srTfXO6gzSPdBEwPw8/uCirYI2jdNQ9aVOfG3/Xw4E=
X-Gm-Gg: ASbGncvjHHwhn0gxtWMDASzqT871c768gW7VQ6bOEs1IOFXEzbBo5gBu+lTG6UeQmgH
	UCtL1NM69oFIxdEhBwRJVu3mUKyna8uS6lwSUQ/YTtR/SXiKY8nU5SDHeE1QSONPEoWbCKrZsGy
	T5aLEGMsBYIYlwuNsb7oYehAsBi3Skf3LIaa+tpzqGJEqaqqBSzie8koHV7CTlHBaXqkjGU6TQy
	rkIy01qjTmV8l14bwl0USGDThoq6/dpUxL87F0HhuYKZp3K6mGu4cCT9nOv0sLSd+MDf+vYhFOu
	74YFrtURBh8bP1qDBi3eyA71GHVZHUwxuc2YD5sHIdNoqBVunIQ5KC8rfYAUswDW6bheIuDbO0l
	YouL73LTV+2CK91WTpW4TelGMCE9GFj+ncU+xctfwcJGHRZ85/CYn8VrLFad7wMMFI5BXTXLGnl
	jZzYb7BzSMxRzhhMp7hohkuEm90iU=
X-Google-Smtp-Source: AGHT+IHylLhegH8EBHKyKNx8tuKkwCcVBihVX2MrfVK0KP+2FLw+1osRi3z/tz/c09s6arjEO2JRUQ==
X-Received: by 2002:a5d:64e4:0:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-42704d900edmr77046f8f.26.1760621101900;
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm42268005e9.3.2025.10.16.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:24:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
 <aPDnN072argrq23q@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDnN072argrq23q@fedora>

Thu, Oct 16, 2025 at 02:38:15PM +0200, liuhangbin@gmail.com wrote:
>On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
>> >> How about "master_upper"? This is already widely used to refer to
>> >> bond/team/bridge/other master soft devices.
>> >> 
>> >> MASTER_UPPER_DEV_VLAN_FEATURES?
>> >
>> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
>> 
>> Why? We have "master_upper" to point exactly at this kind of device.
>
>I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

If you don't want to use that, change the existing code. But when the
existing code uses that, new code should be consistent with it.


>
>I will update the name if there is a next version.
>
>Thanks
>Hangbin

