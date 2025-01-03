Return-Path: <netdev+bounces-154928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42CA00632
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D72F188684D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BF1CEE9B;
	Fri,  3 Jan 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH6qv1t2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E941CEE8A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893843; cv=none; b=ettGLvE8BZEoFnTy4/x0XYXz6gK0OX6J06Crw5uYLqRn9HmQWshvxwviM34LIRznI3uVBs92gWZputuyhKn9h9W0Iv806XB3o7Rj79Sia1ckAvmBIG3boZOx/8Vcabhk5/OW7DZARb1YaXPm+kp6ZCN/p/XBvFXlF21jbbpip9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893843; c=relaxed/simple;
	bh=KCOPKFQkr8RHPl//0vQqXxbJRYK6TGRHsmCfWBHzNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prEJzAWMi2KBbz4bvCjKylzHmjsTbQbdeQh+HP99DzFXGarsZG8qnt0HpwGEcsMbK7uHpcSGBamTkn7DTal/b2s6mvf+YNUVYIujzHfzLuCDEnJ585M+jSfUgh1/DUEcEEzV6FRP7mXuYn+Kigmax+9KhDX6ZbKCPcUSYUoxrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH6qv1t2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so7493403f8f.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735893840; x=1736498640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCOPKFQkr8RHPl//0vQqXxbJRYK6TGRHsmCfWBHzNTM=;
        b=CH6qv1t2599eA4krJXz/99OlFapgqJ7DyXiOUOXLRx2OVYfqXUQDWs+Ai5DK2iRVZw
         Af3PkiyALqYvfgIEtxrRFxPM8mI80H4Sx93vNR3ZfNrkrnk2LP9qM6jkrmdGpPHZ/cng
         T5Dubl7cdntEWFUTp4VYEmW/SbTu2SmxldcbK/YPOk5C+AYTgZ9dd0wNdWt5/taEFn1M
         dnS2ZPe/tXEWeSeBkTd1i47+dCwDDQhBIKCJHy0YAVCun2ype0NETzKZ1nl/od+68Skb
         KcXt3NFrdBnbklHMFNmK+mOPTI9bFLCD8p58NSf/+fje2GBY85eY8+2tncSj6yF+a9J1
         v20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735893840; x=1736498640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCOPKFQkr8RHPl//0vQqXxbJRYK6TGRHsmCfWBHzNTM=;
        b=b7U7iaT3NwQAL/t2h0w94rFkkAPExtDFBVAKeOmQcCdW0dLT/jI+utrI5nr63Fs4lL
         1rxZ3qd+8FzeEopvd58Kwr4ESbcIeTLEVZw13UqGvKID01Ngrbvq4pg5ikh4sNdH/iCD
         DfZbMnWckyIMEZy8ePpAE8eHp+Fv9T2pEoyKalXllVpmpQSVjAWjsCGspdFbDLTyku8m
         PfjtI8ENO3oeS9vabFYa/oFxl9Hi1PMHSMGrqncGjqggEWJld7Z22W4rBusfZJOaCEKZ
         fn+98CrhupwfVsS/n7fBzNdq80wfKD47NpyyABXtdgpaNdJFvqTSVAotDkiKE5kaQr5B
         SGew==
X-Forwarded-Encrypted: i=1; AJvYcCU9yQkWX4HaV5HQlixqknDcbYsMFxYW4oz1/d8VDOhwz4VMvDwI8O40Hpns0U8q4FKpY3vRKn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHv3yP9FTmtuxQ4p9kOgXXukyBtIeZZ0+oI51GUwv5if4SkD4
	auXilIuA9YfBxQNzOKklBi39jQRF7iz/9wSbAcPTrIUsJE7OLCnQ
X-Gm-Gg: ASbGncuT+K2Wz557G+8cZDeEZ3SpzU7Ig5eqXoZe6sNqiJAJrnJclbs6kYbHnev+jRS
	ZtSFJxaqs6OSXhD6H138Rf1M72LIH4tdE1dkSIWe/dQq2dBYAsSfZDm9uEXu/prEAzxoKqVbhzF
	ob/aXjT/8+W6tZw/O8094ha+VkFMJD9cRSdCv3fUvjj7ZeJqB0Jj2Vj/WvRpDAq5RhjaYPJeZtk
	yTqyBFWBJRuQMBbjnm5302usK2Zw9QtAWWEtJeyL06XIv4V/khbfmf/L8I3VfRszx5XpDgkwbAj
	v5sEHctr76FSGp9J32ph
X-Google-Smtp-Source: AGHT+IGcYEZSMWSm62hgRGJ80m5kLjtPnqz2o/+bjN4+sv8KPPexzs5juAeHCPEaX4S+0ZHOftDnIQ==
X-Received: by 2002:a05:6000:2a5:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38a1a221da1mr42749358f8f.14.1735893839574;
        Fri, 03 Jan 2025 00:43:59 -0800 (PST)
Received: from hoboy.vegasvil.org (89-26-16-1.stat.cablelink.at. [89.26.16.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119d7sm509321295e9.20.2025.01.03.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 00:43:58 -0800 (PST)
Date: Fri, 3 Jan 2025 00:43:56 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z3ejTGIpl8nF1Ku8@hoboy.vegasvil.org>
References: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
 <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
 <Z3a-HOwAVyJGEg67@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3a-HOwAVyJGEg67@shell.armlinux.org.uk>

On Thu, Jan 02, 2025 at 04:26:04PM +0000, Russell King (Oracle) wrote:

> If we fail to read the clock, that will be because the hardware didn't
> respond to our request to read it, which means the hardware broke in
> some way. We could make mvpp22_tai_tstamp() fail and not provide
> timestamps until we have successfully read the HW clock, but we would
> still want to print a warning to explain why HW timestamps vanish.

Sure, keep the warning, but also block time stamp delivery.

> This is to catch a spurious failure that may only affects an occasoinal
> attempt to read the HW PTP time. Currently, we would never know,
> because the kernel is currently completely silent if that were to ever
> happen.

Is the failure spurious, or is the hardware broken and won't recover?

Thanks,
Richard

