Return-Path: <netdev+bounces-241395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCDC83568
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34C274E34D3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85727FD52;
	Tue, 25 Nov 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnohj4AH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647422D4C8
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045200; cv=none; b=igZI+myKSEI23B625CNsiIxNu2JhSVJIr00uCoG5zHoDYxo+uh05cRkvZzNWdkVq8SWBpAh23IWhnjg6uALvXAn4d6+JxTaXlShtkxG/EfFXvNzxo9Yh2PrM6krVTR4Sdo41xFE0Z/AGdKcm85iMupd0uO9zclQeWNUunA14kg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045200; c=relaxed/simple;
	bh=0tfEFF31HO0p5AVtPB2m9wDnsam1+lKDH7iW1ZAWsmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoWutSbKsqyVWIsElOFnAJX3KT5DfHAFTKKcDv3zrK/cBWQS8nBrFNdI5lVY7nAHcYmh+ABU/78H11POwKO6g1b/k9Y2NAjC7Qq35RjjeTSBQlmoh8J4gcEQvQpzzDgKU4r8jC6mP7ny7gCuR7NVfGaqyVWrqIGvBWnMUT85vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnohj4AH; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-299d40b0845so82116035ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764045198; x=1764649998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+zjcbL0tDzyXVFIG46xwFstTpucFPpn3y7+gA5A08g=;
        b=Mnohj4AHeZlOByBRoTEWRze1h3kZj5lPfowL/d2fWSZuigOeAnYZOEZdv6tOQNBNAh
         2h8YUva70VTdfsDTrRbV9hRJJXTsGxVZxUZ2MspcO4IF3CcSYP720sJAYrDgSrECDUFH
         v/Ojh3uxCU6vrVx4Y3XhlV7y95hSBtILYUQeBIhbT8u3KE1ol+7iq1XdrjFS+2tyZBcL
         k92m2DQnaYlYKN1sad1uRWi0N8rOTZtU/G5Po4EaFC3s3zLIUkOzs6/lB0+a2grzX5CH
         rWPJLGg1bb30eI8MqsQI5J5FTUOIUE/S+qy3oFBD22v4yuf9sW631XR3vz2z2qoToX91
         dadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764045198; x=1764649998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+zjcbL0tDzyXVFIG46xwFstTpucFPpn3y7+gA5A08g=;
        b=q0KJoYv37A506n1gwsIZNJh4XBnkJ4UVvaX2ZtbP3TPjRZHOjegZz19MKr37jxfESH
         YGXPZrFYttPzvGbILyLL7Gw4uSsjJXkx6rmBl1jf2A7AWOZMresdaY5WrCcDeHT8h1h0
         K06co0IH6LEIBeDbIlyK10YoC3qkmIq1LJp6mk8zHblQwFTmLDBteEWoZnQyJVoFCWSI
         dUq5XYhSjea6rg2G13KFS9whwNIPN+HWWogUAp/SxrwGGpWSfwctjm49GoJ4Gj9hX3Rh
         Pdj4CXApVpLAoLjZYX/s0W+JN5Oe4PW/liaM2FJnZeB92ptny/HpBSIYTCOl5yGX3dec
         ifmg==
X-Forwarded-Encrypted: i=1; AJvYcCVOnVt/Ok/rbM3HP8CaPScK1GbPsfcjo2xpD2niTvi0NJLLgSdqc+EUWCX5h7qBcYDGR0l/NHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybi2FFFOtwgqVx8Z9a2cFwDHJK0EqtLN7Z7M5A+x76E0CafQgF
	3+hSOwMDsGIN0BjKu870Q5QSH1w0dkf/LjW9BlvYH2TBpfrluSS+RVdk
X-Gm-Gg: ASbGnctdekfLHvrmYXNB7RAHKPAvJMHnnRrQKsAehr55BqZ8ZZ/lV6jopACZKo9lO7a
	AxR1kcw+80/GCKPGiIT3TIY6N1JnqdObdHH0+Sw2RpyECAj2rGibnS/s872G4JR+ij7DS/SQ435
	5TzY3h6YvzqC6pjcle7PpNYveJTsu3NE9UvdEgKOqgz4h3AP0p7713Wm9ycIqgizs2jqLl7QUgc
	svH4mPNZPO81zxKOQMUHG6JE6gRCaSHM1wCtcmAHFnwlq+f7HD5vGwXAboy4qOL/IXgpmRN4lNu
	S+VEB1dbBx8OrTwoc6Lo/v3u5UFR4VwTq7dvkDhPnm43m7BAGujK5rmx4PVKxtQbW0xaWBXfM5v
	1USc7pMUCKlST2sP9j7rKFbrHpo31If2159RPNt+GgzdTTVnwBsxt+2gyZvNRx6WjfsNcBsoSf5
	qmYhkUEPpq/r/CqcCCbxksjwsJ95bAAw==
X-Google-Smtp-Source: AGHT+IG5wQiSA6DoLuqSdaHSi1FyIN7DulB2JAUjgDcIX0e3566wQM/LBnN9t0ZmEp/7FjsrZS6E7Q==
X-Received: by 2002:a17:902:ebca:b0:295:9e4e:4092 with SMTP id d9443c01a7336-29bab1daa12mr16030285ad.56.1764045197941;
        Mon, 24 Nov 2025 20:33:17 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a6b22sm149678695ad.86.2025.11.24.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 20:33:17 -0800 (PST)
Date: Tue, 25 Nov 2025 10:03:10 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Message-ID: <aSUxhmqXmIPSdbHm@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1e69bae6de428@gmail.com>

On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> This does not reproduce for me.
> 
> Can you share the full clang command that V=1 outputs, as well as the
> output oof clang --version.

Hi Willem,
I have added clang output in 
https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18

Thanks,
Ankit

