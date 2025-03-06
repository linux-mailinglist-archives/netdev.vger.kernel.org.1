Return-Path: <netdev+bounces-172380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7BA546F1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557943B0A2A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9420AF85;
	Thu,  6 Mar 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGbZiE+B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E71FF7C3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254943; cv=none; b=p7tjVDsbJaCStVr8eSGNH7N44cpKWhzh0ZCOsxrcZjU0bKm4Zrsj7y8DJfQMSjNLodxl9HYSZG0t3xhzSAKs+Y/yLWUREELgMGUI25AHfHApXEd/EjNyEw8boR5As9GbVGIPCf3eHv9XFZM/YLL0YLOUlr3QZZ0hRLEClPpHlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254943; c=relaxed/simple;
	bh=qyHU6nwK/mjGzxTaEot56wQs50VKvF/RPMJSYFa6hEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6pQKDh3nTomXc8Jt3E5CPFa0DoEovIwuXZ3+onzBIbzFoFpS31kSSRnzck+/FuJi7Dk927xKY7Ti4IsXAlfb27bS4Hml+mms1quWHknyuZu+qEZxw63hEWIF6CAxPmJLUGxyWobT6pPXVDy7xomzqBGiLrAU2c6KsBhW5apkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGbZiE+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Iyl/8UKDSiwGF8KFxT8SB0q5g2Qi8O53ARUdlTeQ4=;
	b=hGbZiE+B4SGtsQDxPc4Ey18UIABqbpSsD7MNjAleTbxBpqZce3hsnwOriYh2kP+k+FiBG1
	iAFKN4InGhyS63y6cdPDIyhFml8F83i0FIFeFB3BAq25uklfbZkFFzRcjP7i8REInHUj6c
	R+0AwSj8LwCcIVCXqOCtQUuPQkwjijg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-85KSjylPNXqRRmh2XsS7Nw-1; Thu, 06 Mar 2025 04:55:34 -0500
X-MC-Unique: 85KSjylPNXqRRmh2XsS7Nw-1
X-Mimecast-MFC-AGG-ID: 85KSjylPNXqRRmh2XsS7Nw_1741254933
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390eefb2913so328323f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254933; x=1741859733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Iyl/8UKDSiwGF8KFxT8SB0q5g2Qi8O53ARUdlTeQ4=;
        b=YXTQh9fX9ebhXtG4UwDblPN5QtWZ3rv20SD1aCHzHJBfGuRlFezuX9h6c1na55Dn5g
         s+hyslJJ2Pot+xIZzcsNX4hYG4wBHa6z7APLEtDdmulttlfq85SWwSA0Y/tvROpNxt+0
         Q4lr7FNO6Tcwh0BSsCsXFkiRx1AzTKGNgYIjwypdnoaiP/0xYcq/PNbiw54op3sNBYjz
         Pj81ZrrWZkq6BzpSMvMy4b4gke+fby4sEbVkm/qMHsJJ1WTUuI2rfPwzfIhxpitfkkJw
         c/Q35F5IatG846QJPcwCthTTcxLlvV8kS01JS8vf+KOxz0ggVPyt8uuw4n5fV9Crhyoc
         QhAA==
X-Gm-Message-State: AOJu0Yw8oajvKrFdHVi9QnZ/TAKSLQN2wDVtXYX0CUFz5X4AB7deYN83
	nFajrXS/cCJc00r1X/KhrGO2lTne2cPmNaqvDwXqUL72gcE6QpzdQkdN9FzVuuqOn3D4/armk48
	0gtU0hKUTfPR6TF4KwYF0JcA9T6pGozPWg/cjTC1VuHYLfIzCb7AzDQ==
X-Gm-Gg: ASbGnctOX5gtEk5FNeZYE6srsL7yOKFEvsaFTjv8dGD6ANDrGuf+JEmH8FTiuvCpqGE
	rfnC+g0mm0rOJAgcGyS9Tm5ENKjbmts90uK/NB3ufIUvGyUwgTioAbXeggvi0w19MvRXjE6ChuZ
	bmYjfwaaTiJX/5+9Vchb4YsOGFM6zAokAA8KCIshQ1YiE8V5207NMQtKn4/PNr/p7KaG/Q48sR8
	fMt5O87lQjyvaZjCP8tv49l4+UoUQRROREudmqQajDI9xVnVte3DSeb9a0Tiq940lKVbB3UFbCb
	MF2CyrAT3FApdYlU09Ctd0/QLZibrBFMiZYy6VHEUrFWLQ==
X-Received: by 2002:a05:6000:1acc:b0:390:f358:85db with SMTP id ffacd0b85a97d-3911f75c743mr4469455f8f.30.1741254933431;
        Thu, 06 Mar 2025 01:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEYFBaDFnSpPs5pnagi08E3gV1mWTE+gn0Ul/oBprxbACvaeGpZ/eXBvO+4VtQ/ZMf/PsM3g==
X-Received: by 2002:a05:6000:1acc:b0:390:f358:85db with SMTP id ffacd0b85a97d-3911f75c743mr4469436f8f.30.1741254933091;
        Thu, 06 Mar 2025 01:55:33 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0194f2sm1534441f8f.54.2025.03.06.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:55:32 -0800 (PST)
Message-ID: <7f2c4478-cbb1-4c68-b980-d6e07a7b971a@redhat.com>
Date: Thu, 6 Mar 2025 10:55:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: marvell: mvmdio: Add missing function argument name
To: Vinitha Vijayan <vinithamvijayan723@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <CAPSa425Ntd36P3DHMGNhRN_GJ6g1JCMW1t2gMYFppJYSXqetoA@mail.gmail.com>
 <PU4P216MB103753B46AF6597DAB78A4CBA2C82@PU4P216MB1037.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PU4P216MB103753B46AF6597DAB78A4CBA2C82@PU4P216MB1037.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 8:58 PM, Vinitha Vijayan wrote:
> Fix a coding style issue in mvmdio.c where a function definition argument `struct orion_mdio_dev *` was missing an identifier name. This aligns with Linux kernel coding standards.
> 
> Signed-off-by: Vinitha <vinithamvijayan723@gmail.com<mailto:vinithamvijayan723@gmail.com>>

The patch does not apply, the commit message is not trimmed at 72
colums, and the SoB tag is mangled.

More importantly, this kind of purely formal refactor should be part of
larger/functional changes.

I'm sorry, this patch is not going to be applied.

Cheers,

Paolo


