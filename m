Return-Path: <netdev+bounces-154929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1EA00633
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F531655C8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314E1CEADC;
	Fri,  3 Jan 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QshIiXjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C11CC8AD
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893961; cv=none; b=sOzwKnbe0O+ohnDFPpPNxGJE1IyRgWDKB6t2RrFfaEGzPXcBuuSRR7G2rt4LO8rgXYDSX5BU9NeVDqGAM1MvdwOcG+N+pgnIuIkn5doSH8BxSwH5RPE4oc0laDrnhivpodc236xLExiH7UePYgprrh9HsObfoVgWswB6SFX30Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893961; c=relaxed/simple;
	bh=DUE4Dloklph/yulzGpHI6O6PPAfG93r+8wWGvQEtbzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GReD/iyBSrlm6s1OwMxSdfNQTszLJSJij+cH8JOHUCXvBZ6HQng/06tgySIwtTaQsjQk+JT9STwFY+8agKNPVpNeeDoN9fjioS51Pnwiw39mWarxUuPHRHXRC8uSdPQy04HBXVf6bI1bUrZUcWbbpfAakN+d3QSZKyXt6Mq9lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QshIiXjH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436341f575fso124791045e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735893957; x=1736498757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0crK+GbuF9mIzPAaiipCEbnmbuteuiyzmcJ5oh9RU=;
        b=QshIiXjHHY3YHLORQO/xXel3SmFALGZUBMZEUPok/mZgd+OcsQPyS+ohTLyOJ3I5Tm
         E2LBSjKxi68uz3suBAdTyTHPiWYaBO6ygKCxmNt60qXQ7Rbr7ghb620+O32zDClj6RY4
         469qiCbwBVfRzKZ+5tL0xbN3cWAiEzfhQ/CITxgxQxJGhOdQBIVz4qvtStE51NYYjUxw
         NNeQy4rj5NY6Ec5c9i6UAv6WW4TEOVXld5gTWgBqY9J/5AhlxAppky6EEUXhyr/Y7H5A
         tpHPUVyJiSKLh5jQ1lc+7kZVgRwCevRsXq7MJZ/97m74+9LcJsd5RZZKrNOSzD0wLiME
         /4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735893957; x=1736498757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA0crK+GbuF9mIzPAaiipCEbnmbuteuiyzmcJ5oh9RU=;
        b=KYgD+bDJVpJXkb2RrXrWraMZrSbGwzmk0b3b70gch8Wh5afrmo+IHJrt/3dsWa9/MQ
         WnpYx+789uhn+L1/1mosN86xUpIzl1zjs0IMlBiVMbXCJErB9cHS2C8vBYp1gYRDDwkI
         eVFlO5+usZ50R+LgDHun0nsulGEEfHCVSTLHVRNxJGlkciDLgB4VlXC8htDurnaginc+
         kVivBTMR3DmTeOquEDIYirN1idwwyHnDVenENM6KqNgi71S0Jn0ydIlajJ9sLMOKjlQU
         /u6UVTurttWN+sPpKsQLtoDawl8k9WqbD8mf7QEVX0XzNdUqto/bw4e/in3TzKdwfK5Y
         UTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXmC1foSW9WyD2WEtugS16UGnZIiSOWBzQOF2l5qRGB4gLclkH9sd40CPJ1/zHuHYADRSViZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyQgxvMQIRc2uw84dQWuuxf/i3zhh3T+WsEssiMa/0mQTRlSa
	ewiv+fEKF7RTHUcY4W8gdzEWRMOv8+rw6P0AsGo2A3cFPm09f9Iq
X-Gm-Gg: ASbGncsfJX7ZjhBysikC/TNPcwxRSBaZ0RIkF2YswjGGkZfUWYNbMZSxVHP5v0qjsM5
	NjnMYa+zoRRp9/AoPocyonyF61yxMtKMWu0WexIm1SqRZAPAG8pwM6z8agJfM1ZQN/aRAVOXvGN
	T29UE3u4roBXL7bx1kraG3Lk237dtTWqMCAlLaDegdMonbs0qddR/XrwiL8lkLWf0Gpuum0p0tk
	BJ7mQ/wEcWdlGiRNlI1OHTtPO0euZSsv+3r/4FvQYYwhIjD70hENnrwgqVvtV+uINVB+BovOUMg
	SObL6Ex/EL4TKkBDT1wW
X-Google-Smtp-Source: AGHT+IHcYG9aarEu7uIrTLZExONKjWfhjhV1mb83P+PfRBVJD69jQOGXxA7aTeJY+FF5VIML6YtaEQ==
X-Received: by 2002:adf:979c:0:b0:38a:418e:1179 with SMTP id ffacd0b85a97d-38a418e13dbmr19623819f8f.2.1735893957293;
        Fri, 03 Jan 2025 00:45:57 -0800 (PST)
Received: from hoboy.vegasvil.org (89-26-16-1.stat.cablelink.at. [89.26.16.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2432e587sm36547141f8f.95.2025.01.03.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 00:45:56 -0800 (PST)
Date: Fri, 3 Jan 2025 00:45:54 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 3/4] net: wangxun: Add watchdog task for PTP
 clock
Message-ID: <Z3ejljjy1QqsRxox@hoboy.vegasvil.org>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-4-jiawenwu@trustnetic.com>
 <821186f1-8407-4abd-9dfc-4aecdebdc89c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821186f1-8407-4abd-9dfc-4aecdebdc89c@linux.dev>

On Thu, Jan 02, 2025 at 05:53:17PM +0000, Vadim Fedorenko wrote:
> On 02/01/2025 10:30, Jiawen Wu wrote:
> > Implement watchdog task to detect SYSTIME overflow and error cases of
> > Rx/Tx timestamp.
> 
> Commit message doesn't look easy to understand, but according to the
> comment in the code, watchdog is checking for timecounter overflows.
> For PTP use case it's better to use .do_aux_work of struct ptp_clock_info.
> It will simplify a lot of code and will setup a worker in a dedicated
> queue which can be prioritized separately.

+1

Thanks,
Richard

