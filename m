Return-Path: <netdev+bounces-158057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B83A10488
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50353A55C1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C228EC75;
	Tue, 14 Jan 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qbk8/KL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922122DC27
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851512; cv=none; b=JJkGgfNgAr4B8Ui27e3eY/A8xfWyzo71XSbrTKHin8uI0dIoJdpKUeEKM/y1jvFiHuWfy12g9+O9yCPg6OMRHaXSzKlG+8rC4SYkmADgciZT4ZSFQ9kpc5yQ3/O/fJszPqeDj3Q4p96++sLDgEuZnUck0lw4K4IY/emqU5N3OT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851512; c=relaxed/simple;
	bh=JX8BU/UHAINQ03gKNeZE3v64RzFXpUq4unVLUxoDGSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZAgbywiDc/qVBFGW3cbV84PSiqef2RhgQl3FRhXv9DAa9HbK5UJCebas0/cotICqkeY99L0IhlFM6z4ZeuknWqC6lMuMXbC1SKQuNgv5jcBxP8REib5/J/Xka3nt3mRZvMxSetfOgO7EABFZaSom5I5RnIEPSTXFHc0y/nny2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qbk8/KL4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso10314520a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736851508; x=1737456308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91oZE8SNrLdkhlSes3IetGvw7SmPXpAR69UBGkhXJZ4=;
        b=Qbk8/KL4SRg/al+lS8lv/WM6SU67elePOE1J+eRi99X1XUPzQHpR75rgG3KSUc9CW1
         hjurkNxuI0gEfFi8muQezyISPXdWLtN29/O5qpiREpNIn3aIN2vcVNzzi264iy0ZkBsB
         Q4SdW70yk27qmFit/zZf3nwwCEwK0gLdxxdR1ki8HgE2L1IpqlbptkljtvCkrXXTnKG2
         zAi9JdNIMWoDG36t/ZKU7q/KvhugeQSjK4iyNj5niEijPRoI0keC2uAPHkUHwNCpJzza
         Rp1hU8ayY8lLZS3bLoljLszd4TwU+xnYD89bkbatjTGTvOtI1NThlGPGa0Bn6yY6j6kY
         QVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851508; x=1737456308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91oZE8SNrLdkhlSes3IetGvw7SmPXpAR69UBGkhXJZ4=;
        b=cmwN/GTiVDGm58E66zbZExPlODQy4uD47nliNNvQuHinZf6CM26ahRZEMare5IfhdF
         4jgkLWjDhTK0knwi+81dpCe10vHeZPtAC3fAdh7BiNyw+WT7R8MHktlTK6hisgpuYuzy
         S94kEMco9Z/Ap7beyPi8vM/OuwyFUaC1Hl9vdaAz72oNJQ69te5tTD3I8aK/jyVibpNL
         j23ReRSE8e0GubCRxrRYI2uUAM3kBs+Axqje21pn9ccGmLmz3qD5czeCvyyy351C7bY5
         KvAjNp2ms3mFVk/lZ83jhWTcW2EaWmZJANBSiZCHQ1FEzYV08JSdXI4JpNUCisX/Z1xL
         ry8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMtOR6gY7g8Vyz+vOPw54B4W/A3dB6y9U4gtm7r4V0/G7I6Jz4vQMnySbThxHUPeS/41Z9+YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIwU39qyb57Zp49iPHrdRO+538yt485G/Ud5KcYI+ShCb2IIV
	o7JErxiN9ewxOzVw7rgUF/ry64Rxk0eIPduPlvHDd/tZe1W8noSyHwrDXJtbAHc=
X-Gm-Gg: ASbGncvIlxkw2gXm0oUhzIE60aTAlUsDGZ8ktz1+Mo/uIhHOAs2ntJhahmdf2/4xwEa
	SW/1A8ZpqOAWG/xV6bX8h2YsfeuM4eNXjfkJxRQDzBFDDcRkauTZmk5xbq4ZsD0XxdXF1O0MkKn
	GGVpRohcZ3oPtr2KEOkefmdGKZv/6jii1OFoosvOp16pqNuT8fVGQy8X8QMhsL4nyzZVBSa/i4i
	TwOrMIlmdr0xcjfcq0vwPW6Z4+yp12MYwx1jKDpuqjv9CCcxB2ctyr6rL79FA==
X-Google-Smtp-Source: AGHT+IEo3aHs2albkGeyR9BcAkeDWYBoYCWdzhqgjZb2f0VdDSTMfOOHcn07QDxniXBFjvVorqej7g==
X-Received: by 2002:a05:6402:320b:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5d972dfcbcfmr24768732a12.6.1736851508062;
        Tue, 14 Jan 2025 02:45:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4d49sm5812922a12.78.2025.01.14.02.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:45:07 -0800 (PST)
Date: Tue, 14 Jan 2025 13:45:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
Message-ID: <Z4ZAMCRQW8iiYXAb@stanley.mountain>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
 <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>

[ I tried to send this email yesterday but apparently gmail blocked
  it for security reasons?  So weird. - dan ]

On Mon, Jan 13, 2025 at 01:32:11PM +0100, Alexander Lobakin wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Mon, 13 Jan 2025 09:18:39 +0300
> 
> > The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
> > potentially have an integer wrapping bug on 32bit systems.  Check for
> 
> Not in practice I suppose? Do we need to fix "never" bugs?
> 

No, this is from static analysis.  We don't need to fix never bugs.

This is called from nfp_bpf_ctrl_msg_rx() and nfp_bpf_ctrl_msg_rx_raw()
and I assumed that since pkt_size and data_size come from skb->data on
the rx path then they couldn't be trusted.

Where is the bounds checking?

regards,
dan carpenter


