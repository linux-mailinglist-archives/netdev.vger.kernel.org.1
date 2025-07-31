Return-Path: <netdev+bounces-211174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F27B1700D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD101C214D7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D1222FDFD;
	Thu, 31 Jul 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bzFimen+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FB2367C5
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959749; cv=none; b=l3RFiW5xGFNhwlU2ZZl67BRQ9b8yGrEaHC2Joc3ItYhL1WypW5FiBelSUgIGZIhpHB2yj/BLOz0xH6Q+2IJ5ffU4+FO26/96P7zaEBIhWjEYx1LZjxAKYnUrakKD5RsAPqlGvJ9ltoO2a0hrQigyQTeadYdd/wkA4jLaWLkqyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959749; c=relaxed/simple;
	bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McQagN5sHlcLZzt+NLvFaPJAwemHtN9aLxoTcbaYUrjoAb+yxIlI6YvBwhN5IIZloVwk/LrJuruda//1QIE7EKFFfEyV8QWQKkEp9cF57SyHngkgja/MtKaTPH+l/cf2A41u9MWJNUN9abtZh5G7qGluL94+76lQvrJbNV8fxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bzFimen+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so540712f8f.3
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753959745; x=1754564545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
        b=bzFimen+wqTVmX83QNKhdZnN0/4gnS1n5dJjXooWX4BTNH+3+G45dZuy1VcpzkXAjL
         QBE5JgJEcFF4FPVPrknzOq6eIgic8LfAp+33DtuK8VxBWrujxt8tdoj/AKDnS3QotO07
         zxICwu3Lee5SWtd7qn0kY8ELwpccJrOXupRe4juWkewiqmOCDJ7Z69Dj3U9gd5m4W1+w
         DRWNQxaJy2X+0aZZHGqZxkRmVeXy2ndAmDO4m5x/mCC2e5njfWnsVjJ9l4YmqtaO6SbR
         E4YbUE0NLAH1Btvg1ERRTuOpi2C9gQHNyATGGMxdMeLLO5o85i9wNXyvb8JyfVBJnYPd
         L/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959745; x=1754564545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
        b=cklOObHsN/3kOTfQ73uz2zkKitCUacMGBxhKIolnpyc1Pn9w0pN6SonBPjfeTZBDoF
         nUMjfBIoarVwJ4E3SU+Lk0Sw77v8mE79OpmkkrbFUrdJ4vdptMjbIIkJiOuCBMAs42wC
         8FnT0Fb0A8FF2HT1/fGJW1YE6I8PNr1tuF97FrSrBPZ6gO/EgU4C4Wa8jd3CaFf+e9yP
         /sQSAZtsp5bIILEW9n5OsKHnMg/NqWN11C3eXIm56T3QE2A2UQ2SwFxG5Jl1hEeayiwy
         L+F33RQqeUIz6LgiGBR3xHTl6RWA8Uuuf7gfb09CYI2KVqQu8eJ8aFLjkFLw/jDz3+9T
         a21g==
X-Forwarded-Encrypted: i=1; AJvYcCUzy/axvZLkRxUCK0u2W5QB8oJRr1Hw/1C9o6disKjLxCsIQl/E7QzR9yM2IUqkt8qYlmMulfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Zr8J7q0Ego0LNPKjN6bhRNt6aQwxRiTWbUyFA30sYiCSzwYt
	ASOcmNE0zcZbJJzNt6pytMqTt+XQHH2LOVVu+dDbwNTC+ZQjpVAXAKvhEInCHyWsLtg=
X-Gm-Gg: ASbGncvYGn0m2X1tnSDnUbZpH/gJQaE6lGtymPtbUfbBopmbLspmA3DSp/zriwVL0A/
	l/bnN8Ssm70o7VZY8H7p+NH//ZadQgzDTfeXTqLX/xyAIuUUrQoHtHFKUTolUJyrDclZ/BM3yo4
	wCLZ1rU3jB5HomWQuR6J1bpJRkEnXzO3kNhWJVoqYJxvdzA/mw2z8IqmWxSBREuNK9hCMNNOpdh
	jKUoHAnbKGA9LOM8tU7FfwYyZPiSbG90N65S7fqf2bXbGHHoP3XTAwurnJu8TQJ2DgxgtmO0xLT
	VNQk0CQAgSJshUJkEIclvnmzO6plS9WTY/vcfKZhW5SW2CjDQyuCmP6SOQtzkefIfmEsIK+o3DI
	YHsqcmG6F5KFw6TbrEf4SJeEPzBxbTAG/YGU=
X-Google-Smtp-Source: AGHT+IG2/YDknmEESe5rNKpjwCrNrfPKzRjwLoe34Qq7Sxv+j/EwOrCLSeP7CTB/gVBWYK4E+WkoyA==
X-Received: by 2002:a5d:5f54:0:b0:3b4:990a:a0d6 with SMTP id ffacd0b85a97d-3b794fd5a7bmr5115544f8f.19.1753959744629;
        Thu, 31 Jul 2025 04:02:24 -0700 (PDT)
Received: from jiri-mlt ([2001:1ae9:6084:ab00:1d82:e38a:3dbb:d3d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469b4csm2024096f8f.56.2025.07.31.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:02:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:02:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"almasrymina@google.com" <almasrymina@google.com>, "asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"leitao@debian.org" <leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] net: add net-device TX clock source selection
 framework
Message-ID: <tmp2xu6wrgjk43oxzvzpt7gqb6tdgncwhhapjg7jkmhpb525zd@uxabkfcpbghg>
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
 <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
 <SJ2PR11MB8452713FE8051A2B18E742DE9B24A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB8452713FE8051A2B18E742DE9B24A@SJ2PR11MB8452.namprd11.prod.outlook.com>

Wed, Jul 30, 2025 at 04:09:03PM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, July 30, 2025 2:26 PM
>>
>>Tue, Jul 29, 2025 at 12:45:28PM +0200, arkadiusz.kubalewski@intel.com
>>wrote:
>>
>>[...]
>>
>>>User interface:
>>>- Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
>>>- Write "1" to switch to that clock source
>>
>>I wonder, if someone invented a time machine and sent me back to 2005...
>>
>
>Probably temporarily, but this was quickest to invent :S
>
>Creating a single DPLL device for each PF/port seems overshot,
>Could go with extending netdev-genl

That would be my first choice.

>Any other ideas?
>
>Thank you!
>Arkadiusz
>
>>[...]

