Return-Path: <netdev+bounces-106441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE59165A6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881CD284D4B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7E14A61E;
	Tue, 25 Jun 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO6jlD0Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F7149015
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313214; cv=none; b=GmWV8l2cvh9Wu53MOS3r312E/ZX5N53YXv6XXf8k5bFuooojb9YBYLC2B1TOLdjTnbQktIxoXTHaJe+pkWFOZeVuqHWFw3nw8xcZ2lPW1fBxymbJNzGlqh5hqktLmwAW0ip7rIUJExwu0lIWUFQ5wuDhBOcqzVRkmBKL89pG2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313214; c=relaxed/simple;
	bh=heffSbVFg1NgIuUMD7RNEMcrW119gOrId2nr9QqkeCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soU8tTQ+wbNKTjcxQhToK065tQa6pdHxcHPGXubUmcZpTgydtYv0aCUHzH5rxamx6ACI1M5f4IbOyMID+9afrhxUyk9neXc5fo8IodR/EufkETRHxR4Dq638N+GK+BVmAAD41FIXiZNMZfgXbYpwkxemEsEsYW3lpJz68hdTDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO6jlD0Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719313212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=heffSbVFg1NgIuUMD7RNEMcrW119gOrId2nr9QqkeCI=;
	b=DO6jlD0ZcLnI0J5nx37jUYGNO+lwECoc1jVGdO2kXj+wM55mDbmiWuu83qLNhxbn8C07ch
	LWGTG1FnIMMVtNqmsmfmlh+zHjTv+HhbBFYrC2PPSe2IIsUwhfWNZe375jwZ+n80L+iPSq
	huKPW4Yj/NtHDFTQrBuv34Buwhjz1xY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-d7E15BU_PXGcGRU3NZaXwg-1; Tue, 25 Jun 2024 07:00:10 -0400
X-MC-Unique: d7E15BU_PXGcGRU3NZaXwg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-362a1e80424so575973f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 04:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313209; x=1719918009;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heffSbVFg1NgIuUMD7RNEMcrW119gOrId2nr9QqkeCI=;
        b=Jv1KbTHEiq+HM94Gl3DJi29C5lKUA67tH2qTvKHY3OQcMBNxQ35pWQAjT+c6NW3xkn
         OG8f2USRgb6q/1Dyo+H/+U3Zhumb3wyxseWnKqitOf5lbYee0KyLq+8HiTxdf7oxpo+X
         ccbRf1jGC6Vx3crHrFL+l2iXdtkE1vvSJG1K+2lRhtLCLNQDIZN9QTi64BGK+nPeZ9q2
         IHFEgcxH3GJBrQmEWFOmqokksehiU8OY4nhrAWWzdJnoy9puOMJrEaHhTDub4CfKHyWA
         UWs2cYNmDq7/A9Qz0Bqxq23yB7wzS9RNzhLtMtSzN4I89BGEI22ZlKzVaOANGjCy77G5
         AkNw==
X-Forwarded-Encrypted: i=1; AJvYcCVdefteIsYZUn5V/NbQ2cgGW8/sKcCnFLKYMziXedD15RPska4iNQJnhgZSDYRGCmJBoXEC52ruVNKpwFykrmjkIFQtQQ3i
X-Gm-Message-State: AOJu0YxWjvmcXYLvz1VxvjuvWt3pmmil22z9c8KtMBfSGxdVPUrPWt1t
	faDUFt6sWIFw/BRCej5cD8CNZWG9o2rvgfXQ1XGQRBkXGalDhEEGKoSLPlePrUa+/ClWJ5yjw7G
	M9z4s7e9Sd0FDgAhSvhFEvnNNpArL3lZKyERZrEi4V4PtR/PlzVmC6w==
X-Received: by 2002:a05:6000:1542:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-366e28ae1d3mr6537753f8f.0.1719313209628;
        Tue, 25 Jun 2024 04:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/jTNgV+hbFxSW1kndRC3mya9vbx7WDkkO5ItKTN2GIgoS0b8CKmGD72Yo5ePKe6lgjhMC2w==
X-Received: by 2002:a05:6000:1542:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-366e28ae1d3mr6537735f8f.0.1719313209284;
        Tue, 25 Jun 2024 04:00:09 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3667c2fd7fbsm12293892f8f.89.2024.06.25.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:00:08 -0700 (PDT)
Message-ID: <0d975b97d9eda6c85fa5133aaed32b985cb6296b.camel@redhat.com>
Subject: Re: [PATCH net] net: txgbe: fix MSI and INTx interrupts
From: Paolo Abeni <pabeni@redhat.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, andrew@lunn.ch, 
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com, duanqiangwen@net-swift.com
Date: Tue, 25 Jun 2024 13:00:06 +0200
In-Reply-To: <20240621080951.14368-1-jiawenwu@trustnetic.com>
References: <20240621080951.14368-1-jiawenwu@trustnetic.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 16:09 +0800, Jiawen Wu wrote:
> When using MSI or INTx interrupts, request_irq() for pdev->irq will
> conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> system crash.
>=20
> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller=
")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

I think you should add a longish description here.
This fix is fairly non trivial but the above contains no hint on how
and why the fix is supposed to address the issue.

Thanks,

Paolo


