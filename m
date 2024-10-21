Return-Path: <netdev+bounces-137446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FF9A66DD
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F300B282484
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A641E5716;
	Mon, 21 Oct 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3wb6XlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013021E1C22;
	Mon, 21 Oct 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510979; cv=none; b=W0P1Ji8uXCfsVnOO5JLtZrglBhcCvOr8uKr66tTyH7TOUgIGgm9YhaCKPgauNZk6Q0w4LubZb1pw+Y04UkRv0Kd0GDT+VBCIW2k6+CfSHkg9o/87UFT/R54dy2pwYu3iNLVP/L6VQG2k1FylVSWVIiw8nfUokXW8pQl1cacpXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510979; c=relaxed/simple;
	bh=Xlpe+4NZVygqUfAYbeG1l2q/sC9oUMjZlGGCCv2/+1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYSCcV11LhL9mkUkX6B3o2lcbzYifl4CRGHd+NPtRj1Z2phh5MPRU23uOJIcOcCKylUVnj3GRcoCGIlNXiYyn5UTsB6c86EByY8XOXVwqDUnv3PSzmcotRi+ps+IFYEPUv2CdvSq3bqB2FK42/ij5N4GnT4TIpx99FQ6cv4ae70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3wb6XlN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so636575a12.1;
        Mon, 21 Oct 2024 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729510976; x=1730115776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlpe+4NZVygqUfAYbeG1l2q/sC9oUMjZlGGCCv2/+1k=;
        b=M3wb6XlNydL/oKvhnuXEZqYP1066z5Zjz01xjMZ+/aMf1/8orcWRMH5R754O0PEN/6
         PzKFW3Ny7ZPg4Gs15V3yTlctrYiNJkvKAJGcPwwmqFlCVWFp8fRUagWaKhUBU0hsGd5n
         uf2VbCM34JHTlPD3z4oXsiWQbVaDoRNcNTqCJfnWbWZQJRdUfaAm0huXqJlPNczrzbtd
         V52ziZQcFoTNC2L+8sD4U5EC3KZXAWQCCwXGv27mY8akEGIfbpTraytpZNL84XPQT70h
         lbr0N73+Gs/1WTzOaJTv1/by3SxmhL9lCW9AsK6P6mS+3dyHv65bbF8BHRrqQZym8vMX
         F2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729510976; x=1730115776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xlpe+4NZVygqUfAYbeG1l2q/sC9oUMjZlGGCCv2/+1k=;
        b=EAjeR1b9AGn8Aq57l6S6GDdvO1KBUKB4IzgPDp84bZDtsbavFE0fL0hZI2davJIn6V
         k7tsD1bQzFLwFrnT9FkwraadeoFU/BVJLFibQSr+js9y/ob+91cHqFby0YxgbB64p6DB
         3V0NTJ/RzCvSaLIZDziWnL3srvWT8tzIK93+bZ4U2eudXatjsvmBAhXiy2zqeYtMn3Ui
         5mop8qzxWAB2ysnDdLfIEi1LmzyiHsPHTtQdOrK1e/1Beqku7JK1xpIr0TncXdjG/Ces
         oJIj3it9e3V0CDYHQCotf1LNdcwweqjy4P8GgLtFuikkox13sCYBFXBLWGhpBGfU3bEh
         jslg==
X-Forwarded-Encrypted: i=1; AJvYcCWTzIoHDBt2+RrbvIKScA4r/bKN+wDTLR9AFjXiSkGBAK1vtBcspHqOnly0VIysm28PQqjUkmLtMxzyARQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKzkDb0zlwZXK/5PXksvqIuCC32POafVx/oc7gNuanSQdNThP
	I+MZzgh0+J1EkVlypTL5xLqMeUkF2G+M78VXkZrGJayua0VbzvE8
X-Google-Smtp-Source: AGHT+IFteQ1L5ugUmQsKdOnz02qLtbs55pYvogPiCLx1JZQY/ANGN4EUXz2/F9lCZQtJtBH6UE3U+Q==
X-Received: by 2002:a05:6402:3585:b0:5c9:7f8b:4fcf with SMTP id 4fb4d7f45d1cf-5ca0ae8753cmr4060146a12.6.1729510976024;
        Mon, 21 Oct 2024 04:42:56 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b4e4sm1818093a12.61.2024.10.21.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:42:55 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:42:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet
 reception via control interface
Message-ID: <20241021114252.u6wa2eqj4bv5fv55@skbuf>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
 <20241020205452.2660042-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-2-paweldembicki@gmail.com>

On Sun, Oct 20, 2024 at 10:54:51PM +0200, Pawel Dembicki wrote:
> The packet receiver poller uses a kthread worker, which checks if a packet
> has arrived in the CPU buffer. If the header is valid, the packet is
> transferred to the correct DSA conduit interface.

s/conduit/user/

