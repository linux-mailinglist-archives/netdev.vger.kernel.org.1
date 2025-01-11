Return-Path: <netdev+bounces-157437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A1A0A4D3
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC1C7A3BFF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241631B4141;
	Sat, 11 Jan 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrFD4K9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD156B81
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736613741; cv=none; b=Fz+EdFeZ/QlgT4SAYp1RIXMi7NoDObVHpLOwMA4Rf8jS+GLvtvgKbRcIHe5AqWKboDH7XLp29iVg6+2ClO3Uvvqlqa8XU0Duok6AvB0WifqagTSFitxT2O4i2ATrW169r+WWK2cIv9XBvOUI497sbpSm4aEKTcssd4FP0g5FjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736613741; c=relaxed/simple;
	bh=dG478TQSZyOL+ABB3bHzMhh0mPdLhhwmWlvYqC1V5oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ2C73fE3q0PFFPBm+O7Xi8eW01V/eSok71MRYyyKWhpqoz3ZONm+S3tUS78Y2EKsEiaQGQ+9kSeOGT+jh86uAjfmbWLPLNettqhSNHBC1VCng8ubqlqLsnL7eScmMAdOQnECvfMqtENvyTAFNdJ0x9zyaqQgbR62YrTBpWnDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrFD4K9m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so4966302a91.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736613738; x=1737218538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLc82lqiJ45Cy2RcnrIQ975qa73QpUT0oB9O78o0+j8=;
        b=mrFD4K9mgaG7QdoduMYT6C2L1xVkSyCW6TdVJ+veq0Wy+sOIzvfOgPxvnrH0kCjnhu
         sTt2/bsNnvANYn9s6JDnhUWo08AkTRb8UfrffsdXAfruDTOPSToYR+I8WwigeYawkTP7
         Efs8GfwmPQhxprotlEl3KS4kl4HJ3bNFNxpgDKv69L7x5BDcz/bJ1aufks4Wl+5M+R+J
         2DsA/NWb+lIUhkVbhHOggHnCQFvXxOS5MHchVTfeh+q8yZOSEv/zT8IC7Ky5PyhxbmrP
         VLZeuyB5TmFhBKG8HDrU6N20R3zeDTlTWoC86sF0Jigg1RIWFg3Bxt3ZgW96R9LpZn5g
         TA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736613738; x=1737218538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLc82lqiJ45Cy2RcnrIQ975qa73QpUT0oB9O78o0+j8=;
        b=Jf0WtudN864RyBYWXGxSA3aRk7mWQKqChnNEkKEzDq47+8m700pkiDMUxpQYvRo4C6
         N4Y+mmQOz3oFLR5sc7IUnpviPG2dHp4dbtvI4OEP+oeVki/sk2NFrfX0DooKKO0FlEe9
         1tpW/NZloOw4HMy3sNdRdJHjhamzPglL31WeY2sr+NEbawYgBl8kI0ojUWugvHSG4S3c
         9UH8aNDt0j9mM9/wragzUuokHSCKepibwFSt7W5GXSrlhYg90COFVRKgE1KGMnvU0Ny0
         3Jc6/8lSY9mrkrk1QG85ZSXbWJPNXRZeUbwWLC9s9EqILh7f5VuV4tPbufyNmicRY/X0
         /E8A==
X-Forwarded-Encrypted: i=1; AJvYcCV/i/aunx6TEQvpw5GHvIxOYlHa2Pm2eV14R0oVDVt/jyUxv6UxO7CRHDiw3YwkMqiUQXCvQyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48a33zeFJXS+fday+1J4d+eeSaJpne5CHDmh1QR3xKxAuQ6e3
	ieSxBFVN8x46t1h+LJZSIF4leU2OC3QZq30Y3PamD3tAgAPIc2Kk
X-Gm-Gg: ASbGncu7InoPu2750X1dB/vnLnAXMpgtgiCBXQK1vUD9Y3LaOdGGN1N1uewzu2Ch3e5
	aT1K9ZetweMUa+9er9XMtINflBdrUBp6Nrq3v/PVcr9U+pP2uB8GDwHT2AfZrRmiKK1E771yjOg
	53ZQH+Uxaq4zcZ1MNFY7h7hIqW0u5Chwz0xWgb6ppMHRz8BNa7TB+9BW9uxb5/gdaKTp2zg5S3D
	cGvWRsYjXMXswci4UupaBk0nQQlLz4FVA5nLFAy+/wMY/kJI40l+3GpGaTd2SWQjFrl7u7ak2iX
X-Google-Smtp-Source: AGHT+IEWu1CTBoz+WfW6b6cRmEE2GO340m2QWLAXOHRaVLu91ouXPZrynaDSJliUFMG3h7X7EnUmaA==
X-Received: by 2002:a17:90b:3502:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2f5490dbcf8mr19310457a91.31.1736613737894;
        Sat, 11 Jan 2025 08:42:17 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219de5sm29444425ad.133.2025.01.11.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 08:42:17 -0800 (PST)
Date: Sat, 11 Jan 2025 08:42:15 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4KfZwcyraeFUtNr@hoboy.vegasvil.org>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
 <20250110031716.2120642-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110031716.2120642-5-jiawenwu@trustnetic.com>

On Fri, Jan 10, 2025 at 11:17:16AM +0800, Jiawen Wu wrote:

> +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +
> +	/**
> +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> +	 * feature, so that the interrupt handler can send the PPS
> +	 * event when the clock SDP triggers. Clear mask when PPS is
> +	 * disabled
> +	 */
> +	if (rq->type != PTP_CLK_REQ_PEROUT || !wx->ptp_setup_sdp)
> +		return -EOPNOTSUPP;
> +
> +	/* Reject requests with unsupported flags */
> +	if (rq->perout.flags & ~PTP_PEROUT_PHASE)
> +		return -EOPNOTSUPP;
> +
> +	if (rq->perout.index != 0) {
> +		wx_err(wx, "Perout index must be 0\n");
> +		return -EINVAL;
> +	}

Why do you need this test?

Framework in drivers/ptp/ptp_chardev.c does:

 299                 if (req.perout.index >= ops->n_per_out) {
 300                         err = -EINVAL;
 301                         break;
 302                 }

Thanks,
Richard

