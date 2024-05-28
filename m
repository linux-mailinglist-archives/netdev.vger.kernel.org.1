Return-Path: <netdev+bounces-98765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D98D2609
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EE01C24844
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2385178CF2;
	Tue, 28 May 2024 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evmRVi0u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE7178367
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928750; cv=none; b=OeApVX6aMcuJYGijlUxUsscBO1XzrvUBBImx4lDmU+X1j4zYZRyldbL8wpntubZ8uh/z9X66uHTxZ7GeSUZf0dO2UJD0YwcXCcIe/j2D7SLZgqNJPmIWIq87m4sjLuSl7oAXhA59MQGIYdMB/0k9XRRjs+esfDm/7tyEJ3KJS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928750; c=relaxed/simple;
	bh=MqkU8oMpcrN3KK4KcoRiH7LleZVH5W+tnYH51A9Mbc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbBBVajFwFa2Ku07FFhal+3igTUs8x8iSwKh5ULUrvjoge37+/0cxUk21E5QA0Ia8UoNGMr1QSu4gcnSkCSrb1X83HhNjykkzsM0VW6st7rqX7OCgp2hmmdJUBPESnfmfFFw6uJH6+lCu7sCXWt6dHbESL8HZEd5Q4tqwfZIO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evmRVi0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716928748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6EffIoh8MwZvrccS37Mph32R2Ow6o/tLy3glfcjuB8=;
	b=evmRVi0utYG7EcYq4HjP1yarsGCse4DGSk5dUO7KEi8V4NOgmkQpN6UM7/YMeJntnWA1SH
	zIiKiwxVYUG8BF8DcpU3gqp6jN70Q4kG2GCXbkrddFxZwrbbUE9AGnrrLYNtxC+7rD+SVZ
	Lrtvq47i6YTmy7yt333xtzDxEmTlkM8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-vnGgJCU2NbSr3CMBuXNpuQ-1; Tue, 28 May 2024 16:39:06 -0400
X-MC-Unique: vnGgJCU2NbSr3CMBuXNpuQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-df4e8a43552so2250021276.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928746; x=1717533546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6EffIoh8MwZvrccS37Mph32R2Ow6o/tLy3glfcjuB8=;
        b=smLAxo6/L9X0KG3y1AT4HXY7HHVJUEKB1Js80FL7+AmZh1q8Bn4OfatA/5iCGIcNn4
         CAWQcjOds2o/XFshZ79ueOjSJss/JjJVIUj+BBFc/7lL9E22GAYZl9lBLCR6/IFAtLK5
         zsPBUYpp5r3Pw5lL6xaDfiftnl4UbFUIkM8s450dQx42c9QiJrBExJSf8NEOZHm5Bc3R
         JyVtOcfqCdCU6F5kSVZoyH9pHwIZCSK20hrRDkaE5F++B8h2ZgVTsRXs2X+tYL/l8ToB
         9MvAcjn2+ENABEooiPrUp2b5dT21OZ1WSJyZgUV94iYQwzwSygmL4/+rr/5Xry/BdNb6
         5qjw==
X-Forwarded-Encrypted: i=1; AJvYcCVy3EJcpiA93ytZj9eZL8B+4eunPJBzWnwdHn0tU86Zk7fHcsCB/a9PKwKe0JI4FXDbjyCqGpYP0+W5ISg7EmX2bDzwZpIB
X-Gm-Message-State: AOJu0Yx+1EDlC4Weks5CEmXk5/I19fUIh3+rPjSARxPSif/kbTxl4F45
	qN/e+2ulSmefSh3AurBsxx2B76g7ngEK+OF7wp9I2ZTAOLMaB+vKYPVc9pT1ZOrCpZ1PS/I76hY
	xBOQ8/7F7EjQmZjVRZQ886k/z+blTckxj1h6YSTAaUWQBx4cFLjDPEL19E7lzhg==
X-Received: by 2002:a25:dfc2:0:b0:df4:e882:2808 with SMTP id 3f1490d57ef6-df77225d6eemr12658324276.56.1716928745603;
        Tue, 28 May 2024 13:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFADiGtMB5PHe86EprRX3pmqHddjYCjSB5rShp3UiTh2k95/ADv7AB2qoUulCAwgA2m4mv7xA==
X-Received: by 2002:a25:dfc2:0:b0:df4:e882:2808 with SMTP id 3f1490d57ef6-df77225d6eemr12658299276.56.1716928745169;
        Tue, 28 May 2024 13:39:05 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef87fsm47291986d6.80.2024.05.28.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:39:04 -0700 (PDT)
Date: Tue, 28 May 2024 15:39:02 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwxgmac2: remove useless NULL
 pointer initialisations
Message-ID: <omzrnmy3r7nhdhj4ji4m2db7dswhbt5772yft5no5yfjb5i6re@wbqgy36ernsm>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvJq-00EHyW-TO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBvJq-00EHyW-TO@rmk-PC.armlinux.org.uk>

On Tue, May 28, 2024 at 12:48:42PM GMT, Russell King (Oracle) wrote:
> Remove useless NULL pointer initialisations for "PCS" methods from the
> dwxgmac2 code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


