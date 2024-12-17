Return-Path: <netdev+bounces-152567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA39F49DB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1826C188A556
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC31EC013;
	Tue, 17 Dec 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cF4ke/KP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301E1E3DF7
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434854; cv=none; b=HjKWixcz4UbI0jslE5n+D4owWMzy3C8XFXW1I0+IPiW/S0dj+CObwjUQy6lkzhAEAhiy2DYX0CD3JISAZB8tKnFBaXHPjH+c75wTSixCaRTghK8+7jA4x3xWJGsk86Tq3yKi1QdXRk2jIf3sWPrZ4yuLFzIiLX+o3BNTZtLJrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434854; c=relaxed/simple;
	bh=X7+qCqEa8+qKYu/VAkjg9aRNn4frFx1sdOkftDYvGeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe1NomMXm7gq8fpE9jJd4VpSsUlqSZvL/IdpkXnRxPWryD3VlNB5XpJSIwicjUUnJVlDwbVLO2WK1OFUejvnjtHMa68bbSq9ASmuv1xm2apM5PBJereJYIQ8aVDjw9H5pQ8sqPom96l5U2+bUwPiwY04s92szxmpHUlKSRJsktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cF4ke/KP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso726736466b.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734434851; x=1735039651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nISDxXF8q5zetRJ35leE5pBgC1+/Hmebckx+GxEuBMU=;
        b=cF4ke/KPxy+Rbnuv1agpwiwyOvQ7Zo7Ffdq2jB+4Ezkg061nJUGHYGZnZcCV27G14j
         0JHqVORh85l79rp5QLlVDH6o5fj5nhA2SzHyeDGVReVAzTfLUzAt2QioFl9jvTssCIRD
         QhgF7IhoRRvoIyB1e6IJfq3Ps9+nVfhwkgvox8Kg8W1ftooLX00ttkRkY8LTbaEaFPSS
         v4lN/SGMBX00b2zFCBknYNnPJe+ERWiTawCCJ7REj52kXvJKMSehMjN3YCo6Xj871gsh
         lge8qNrDld5ifBZ2IJLjBug9DlzcatUo39TXnVoKy835aKVUhPCf260qig9UgpFHEN2A
         J5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434851; x=1735039651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nISDxXF8q5zetRJ35leE5pBgC1+/Hmebckx+GxEuBMU=;
        b=uWVYzDH/f+DYg/l2Y9I/RFHDjq2U5XlHLO7yfG9Qb7rx4EOcj8ZT68X5RYYs0NGtbG
         zre6Hnrs1NxqgieNNzln3fGxxFmov7r9hmZCVrjzic0QiQAa3shEIMlE8ajz9YzUFJ7a
         0z8uwLa9pK2sMF+ykAOkPSNthgWK88m5GCRShVxdLfHqGuv8VjzIfJNNgKCbNmHkWzsW
         sTdSMFRTWCeJzPBL8szFMia/dtRwbLckdcnh3DkKYv0hYhCOKLRWcRDaIG2SDEZWFXMm
         rBcR/lmfy/7Nt7OMCOc8KqDuaHnqlUqSrdkVu9bR/pkduiR3vVyMOo2jeftuO83SpZk2
         t14w==
X-Forwarded-Encrypted: i=1; AJvYcCXraRlALNP5icL8R8DOSyjrRWoqRmEULnYzv6O4BdfeFHEZgpRf9pn3zWJTdX0QXN4Z34JNIk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoyofQq33x3RiZKdU2cPljFSGwOLBL8ro+zCskR3O0aDPlJdA
	ouOYGUa/xuhf7ZObiA/SD5q6Y/7LMF4Uyyb+Kyh4SGAS7K7nXPgytXDrmGu354Q=
X-Gm-Gg: ASbGncvrPhd0i+YXtZtGEgaFf2O9xqZ/VoSenKGUnyOM6vAgXDj6tSO5PVxurEvfXsb
	hhTfHCvHDIJyQ274sbabaO6SM5dz4IfppCKczubKvez2X7Nys/Df9yDsaV5yVLioZAgb1kvzt9F
	WVrJM1EKg0PWhm8ZhnRFQcPcqUICrLr0KBPWMCP/JhkJOJYOXQ+ZFP9vul+Wt5AnOMaH1JieRgz
	c7XJd1sd4b0HEn5dYu+k/Q2ApFoHN1Oy+MulYq4MC3oHMYhPj89odJ79NSY/A==
X-Google-Smtp-Source: AGHT+IHY4FHHK5AOjX3/2VgBskYnwHWpjI9GxEndIXnFEWF8rAYJXuXZvLX4Wm4Nhm19kDvsSXYjjw==
X-Received: by 2002:a17:907:9625:b0:aa6:a228:afa9 with SMTP id a640c23a62f3a-aab778be6d5mr1825981866b.3.1734434850752;
        Tue, 17 Dec 2024 03:27:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963595e7sm433186266b.115.2024.12.17.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:27:30 -0800 (PST)
Date: Tue, 17 Dec 2024 14:27:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: call stmmac_remove_config_dt() in error
 paths in stmmac_probe_config_dt()
Message-ID: <ec8509c2-1124-4f8a-b831-459d084ac726@stanley.mountain>
References: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>

On Tue, Dec 17, 2024 at 12:32:43PM +0900, Joe Hattori wrote:
> Also, remove the first argument of stmmac_remove_config_dt() as it is not
> used.

Don't do that.  It makes the patch difficult to review.

regards,
dan carpenter


