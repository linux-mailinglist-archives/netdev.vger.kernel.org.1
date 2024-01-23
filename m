Return-Path: <netdev+bounces-65025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C945838E6E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C117D1C23077
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDF5DF19;
	Tue, 23 Jan 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4+uPsLp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC35DF11
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012654; cv=none; b=dVUZLbUgiL7emXOXXAc6wleCFwWwH8eooNZF6ZUx9ypH6h1gV8oyE3KBtxBNme5DxsKDC3is0G7nPnKIpbfBpVRsYInmR0RnCXLlT+haNsMt9jUJS0prTUcjVJxXZ6i+NPQ+kw6Z4oz9Kp0FvpsYBdyBs6nERt0z6Zghefo5pYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012654; c=relaxed/simple;
	bh=cwUiDG9TnL2wyrFDozfdu6fmnmNV5sjzBXW/vXQ8Fl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kB3aR3bDERHQZqPwHjSlVxRbCbWzlfvgUWTciEnerrbHKVirwLpaqJESUof9jEyWug5NXIMj7bpIecXlksG0dT5XI0351Q604hP/KvTROvjIoBsA/VXS9naNWzcIFJM13gSwIBwO/WO5ghqIyeOALuaOvERec4qHft9dl7hmHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4+uPsLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706012651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0GP8kHvXsS/a6dVGdG3JNhMZur+H6hlkIGGOWB+Xk+k=;
	b=F4+uPsLpzfCj3zBafN/2WDbqfYCIWt1lS/IwafTdZ0G6eTCfdH4bvnvS6VlSMu2pV3Jnav
	29HyUcxwJOYQvPH+lMAgn3M2Nx8kkUlRD8CzguRVVhA5uGSUhl/GMNiFpaQqqoMKp6tRGQ
	6SJd5wEyHeUl/LaEOfMOcI9ijPlsW+E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-k42uSe5-OUCTfMpabZo0SQ-1; Tue, 23 Jan 2024 07:24:10 -0500
X-MC-Unique: k42uSe5-OUCTfMpabZo0SQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-783ad358941so11649585a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012649; x=1706617449;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GP8kHvXsS/a6dVGdG3JNhMZur+H6hlkIGGOWB+Xk+k=;
        b=GNgjm/XpB8DODU4onSJ5oJSCpuQnKhZeVatx+uJ4milbtnyUB7rAQXqkLJmL5OcmX2
         gSmsTkX3lDX+RnPuVJx4UmwNSLL67+mfGv4uV8yEo15+7jwKFKVGcfHxs50p3eqx44bO
         15xqDsadoQD3z7rmm3oxihn9fyNXCTue76MRy2eK1xhYZI5ilwZe3vZbjbOAc/Lra0Fw
         S0Y/f7ZKyxxlhwC8Cx6Fc4Rd7OH9JKfbjpRpNyGHG0sU+1ZFEFrgMmoG6t6lt1hsNp3x
         3YoNtOgxzDVbwd4Aktxp+mEi7bbt6q0mnVa3YbQ6qmVo925jntSHGS91QjNV132saYpI
         S4mA==
X-Gm-Message-State: AOJu0YyAbX5Go/IDrwjgHdsKhvbVXJROmlzN1IFa0pi5xbiDElRR+cPX
	tz1umEDzsDLmjc2evmvOaLYPIs63N8hedNz3NR4eh3/LLrr9GK6RYKsJfdJW9SILEnuGMzmaZbh
	2XZxLUlICywIwiA1cNkcXJkalAXSMjUCgg+pwVIKlQXn/pDoeS9nisg==
X-Received: by 2002:a05:620a:40d5:b0:783:89f8:3dc3 with SMTP id g21-20020a05620a40d500b0078389f83dc3mr12575268qko.1.1706012649721;
        Tue, 23 Jan 2024 04:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJBRFSCFjcQNQ7NStmZbEX+H5/1l+ZnCPe1+/ywOlOhSOk7EpRPzOi9OiS0x761VsX2o8meQ==
X-Received: by 2002:a05:620a:40d5:b0:783:89f8:3dc3 with SMTP id g21-20020a05620a40d500b0078389f83dc3mr12575239qko.1.1706012649389;
        Tue, 23 Jan 2024 04:24:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b007839441b69dsm2825376qkb.97.2024.01.23.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:24:08 -0800 (PST)
Message-ID: <5e7757c7ddc4cd0bb4256d893b65aa53b549d052.camel@redhat.com>
Subject: Re: [net-next v5 2/4] net: wwan: t7xx: Add sysfs attribute for
 device state machine
From: Paolo Abeni <pabeni@redhat.com>
To: Jinjian Song <songjinjian@hotmail.com>, netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org, 
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.com, 
 vsankar@lenovo.com, danielwinkler@google.com, nmarupaka@google.com, 
 joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com, Jinjian
 Song <jinjian.song@fibocom.com>
Date: Tue, 23 Jan 2024 13:24:04 +0100
In-Reply-To: <MEYP282MB2697D7CFB233DDAE83F74988BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240122090940.10108-1-songjinjian@hotmail.com>
	 <MEYP282MB2697D7CFB233DDAE83F74988BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 17:09 +0800, Jinjian Song wrote:
[...]
> +static ssize_t t7xx_mode_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	int index =3D 0;
> +	struct pci_dev *pdev;
> +	struct t7xx_pci_dev *t7xx_dev;

Minor nit: please respect the reverse x-mas tree, here and in more
places below.

Cheers,

Paolo


