Return-Path: <netdev+bounces-202443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444EAEDF6E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE561634A3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939828B7E9;
	Mon, 30 Jun 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vne9Uuo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0628B7E5;
	Mon, 30 Jun 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290964; cv=none; b=dvSqtTDoTHTQ/2UTmGlKnO9KqMVEyl34oP/n3ARogDxsR5RJ+2iEeRXYMGMGOxAMPBHY0ebnSXLqbY3tpYWjYvxI0MbBcp2oPrf05Ja+a/aEqsQ0PVHbvgSRvuJMO3tykIr9hDcRfv4fyaDboBtuhW7egTmlEfUnLbDgN+3xQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290964; c=relaxed/simple;
	bh=xaF5EDSvK/zHIHe3sz8pMJUK3FPEF75i6oTG2ovAT6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceHAg7ODQu+VrG2pZaIzzJwdyjcoMU25Mbg7GZZBK30g4Spx07PqW/lTEoSGSn0E+CTui3dWRLRS8HLFi/0DXk125wDsOLGgzJraPXzupT8nNRPxgGBYmpYtT/cXVejiY9nRo5b/iUpVRJxxMI/Ja9nmW2TMM4NmbX00/geu8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vne9Uuo1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3980757bso38934747b3.1;
        Mon, 30 Jun 2025 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751290962; x=1751895762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaF5EDSvK/zHIHe3sz8pMJUK3FPEF75i6oTG2ovAT6I=;
        b=Vne9Uuo1ZCKaFaQoCH3sEJUBBbuCaKAJiFFDmCUScU7qsTioTVw/qhTY0hHwkoE5nW
         J7aSFC74NtEJwZsyyn9fA5wwQcBhMFJkHMvtEQ7wPD65FVkP4EPvjZKBPhNJN3hHdgaq
         r7eBdPj1bFEGUOlBA5MHdFvCd5Yl+iNIxiLQgUnlHXmfNQGHcctyw1RjB9GQRHwhGGyF
         3iQD+HJEk7u27NmKxf6rY+i82Q8crWvPxfswepLoXmuI4MJ5xVwu+2+x2rrjsb0Hfqqj
         2njNrR5Ww/O/Zm4yRYjWPMctsNi7eH1jge1CEz3yfeRIKqGr2n3zKmHtHlfmyGnZSujp
         a31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290962; x=1751895762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaF5EDSvK/zHIHe3sz8pMJUK3FPEF75i6oTG2ovAT6I=;
        b=L/Dy2loZtY3luDC3KEQFvf8wlVu7t5dXEoGiB+w3ilPPremHWx7Z6lZYoxu6P+9nWl
         aKWsKKb8Ebf7h/I0/bV6T2NZO/2MvSdCRjosjd0Y5+eOiqAKPt3veGSvbvAYGiUANGMa
         Puhbqsy9hdcuxS8zcDuHxaHjs/LCp0CHfNQ86ripcB8Cm2Uw3UyZW0qSVwNoKDov+Gh+
         mwcG+vvlCsPvV3W7FIdPe0wp7SnJdQcTYQmabgvu5yKKtWBd8hAIZzfPy2E+PNqdj6UM
         MosiFJHAX1dHwJ70V2+j+ypyAYAuQ5RF2cpbbvMj3Kp5vPG9Xe59yssqUUdDkcqrFdsb
         /FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7DokWDX8oarLkhLW/aIFYL+NnefJZpvPoX4ZciJ+rzfzwGRdBFyFRVGr8XarcM/4z4vxk7Z8T@vger.kernel.org, AJvYcCXWYaCwrc3sKWbIqFVnXnLlMb0OQF3imKHuuGmOgYPdL4VmgnV9+hNIiLmQpyXAVyAI1sBKoteyutmPeRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVgQR2UrLBb56NWEMQQtCCr224MG28NJ3mI0TawflW3VTLgl/
	HL493nQ0310p+dhfwEuBytfWzeX+jU+xh3E3CklbhTWaYj4iwAut8IcZ
X-Gm-Gg: ASbGncts6P+lKIwyke2gExXXXJ+3M1UcJffH6XgMeGMm5UozuR4dOx7edHGkGIdiMNZ
	xIMvzPMZA/9MQQmRKhpnTFHEZRPAoFfUIYLZTGF1iKCtyHDN/1myKQPASUMVtnJQhX6IAxzPAET
	XW4Fx6+VVXCamLgj2JmNLnPpIT7lmgzuDoeQqoXXbsI1y2uST8G2zGUYEb8iipmbymaDyQH4HXL
	0jlYX2axhZY3KMlDmiBawNxwNBcE8AowG5Ei6T7HVAVO1qlhLMVHz2asRRPIY/bqdZ0NU/mkz+q
	yl6lSycdQI5TZspb5Mj2re1xmUNygkFTSpwUWocMUUQXQDgw9VW5/jJA26HhIw+6eRkJqN0201l
	IwrwQjg==
X-Google-Smtp-Source: AGHT+IHigeY4bV+AT0u4W1yAkmi0nLia3YxSj10siM/FS0VfQd/Fuqb1Ode8LaGi98/9iFH4ESyguQ==
X-Received: by 2002:a05:690c:9418:10b0:70c:ceba:16 with SMTP id 00721157ae682-71509602bdfmr182753447b3.17.1751290961690;
        Mon, 30 Jun 2025 06:42:41 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cc6e76sm15303997b3.111.2025.06.30.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 06:42:41 -0700 (PDT)
Date: Mon, 30 Jun 2025 06:42:38 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <aGKUThtBfPvlWL35@hoboy.vegasvil.org>
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
 <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
 <99debaac-3768-45f5-b7e0-ec89704e39eb@linux.dev>
 <ea85f778-a2d4-439c-abbd-2a8ecea0e928@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea85f778-a2d4-439c-abbd-2a8ecea0e928@linux.alibaba.com>

On Mon, Jun 30, 2025 at 07:23:49PM +0800, Wen Gu wrote:

> In ptp_clock.c, ops.clock_settime() is assigned to ptp_clock_settime(),
> and it will call ptp->info->settime64() without checks. So I think these
> 'return -EOPNOTSUPP' functions are needed. Did I miss something?

Right, for the essential clock related callbacks, stubs are expected
by the ptp class layer.

Some of the newer, non-essential clock methods do indeed check the
function pointer, simply to accommodate existing drivers.

Thanks,
Richard


