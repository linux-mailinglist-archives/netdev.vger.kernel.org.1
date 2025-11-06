Return-Path: <netdev+bounces-236297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C01C3AB05
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FDA5622E1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCC30F7E0;
	Thu,  6 Nov 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SILAAAiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335C21ABD0
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429060; cv=none; b=Y7KSl2cCT1Wzz/JY/6CmjqBMT/0+bfp/b8L0CfEuWdq/GjhdUZrhSrsML+9QCM7ZeTt45jLwic5po07tZ2GpycH1UXk4M9GHw3kkwDQRSJ7DeAEFdGFntlTAqOjNrrcIyOU7N3IiPXaSAH6/jzuVuajSpuN2lxUfvhJcD0MnOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429060; c=relaxed/simple;
	bh=ialkjfXPUU6X8FC+SzJ3KVgS8vsqr4ixyFVj95i+7Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFw2hEg5B9ptH92Bi1eZRkl855AOpR6kPH4JZPC/sfHF46nZlANxrvK4xRESv/ntz1lM8d10tEY6Qojz4yy9ZrCW/YYTbUWj7qT0ZXih9tzWCaDCzEIEWfYXsiUHyF2Bh8PFruLEiP9je2bQwv1os1NN7iYNo8Wpd4z+JQEvMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SILAAAiD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-793021f348fso744119b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429058; x=1763033858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=SILAAAiD+95xMYc54QFUI6fvZAdTk06zkyBQ2wIUcrPya65Z3mNG2TTpDwP5/UNK//
         P/2RJKa92xrEFGSLaxi2WxEEDXpnxCVU2vmgrL2E48rEALOgu3reC0J7NV63KKZIJOcK
         Q/fWZI94mR8LZRJIWf2a9+6cSlcc90hVfpv/pBJ5x+VT5uKT5ieQfhtaAjsZMRRUy/vB
         h9GIc08m7gZyxoRC/78Mwjy+x/CXfbkAenbBMaiqua//DJEGNOZKFuGXgTI0F5Mz1roJ
         kmhkGMTtJ24egsIeNGFNTKc3rjFqbL44si/EhWr/g639ZTg4RwAKjs1EBqeLDKjF/Akk
         MM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429058; x=1763033858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=VExv2fK5iA/Ppe6zSwt4ku96Za7dd3k0Nrkd9Frb9iPRXXN8AcEpDz+kBakJSMFP52
         u75l/d8oEmSJNEujiN+7k4AMSKHbAStQEII7cJgtexYKO3pK6KzY530hN2cka9hPCa+E
         YAd2gDzjE85d0MU0QT9ZE3qHJlAhALPYx+9Y0l+v+rwXufY7Y+XLQD7jG8hp0mqTHI2c
         ZSii0Wwzn6aeDhWRJE3KExlaISSB+Tlqb81k9iLPce6LDhpPnn1PlEfqEjoiqRvYET4o
         Yy8IJcbxG4oYFffy5fS3UVaHGYxMst1BYwKlSBTdp9hd2zosEDB+hdFtHSq/LzSEs32f
         kXOA==
X-Forwarded-Encrypted: i=1; AJvYcCWlGBEzOX4cky+o0MfK24csYiXi/LGZlqNAwzWrvzFOt+RL/SoJT/mtgmUUEX8AwjFalX9TsWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrc5lmawdrjIFivAGLOVgGU6ZqYRasdMbl+pVrxBOBtmxZ/YZ
	5ODNxmomEtJvGf7Sw7gKmLm4tngr3iqV3mfac8d426IqYGSUtdt1uoEm
X-Gm-Gg: ASbGncvqmxbkmxd7enLvcPioIauNNQlD3+H19WYn4pQ3kZzTxGybO9n0jnJpUEjXgdc
	VSmC06W8PWYUiEh0x+b15w64LgDZfFdvAf18myqGpUIo874i9xiB63WQQwXyzPpbuZfE5k+DtE5
	0eSWlhlPjskvE8EfDN4kCwZNOseNKcn1VJdBgulxGwWsOJDJSRBKO6ysAzvrYQPUHvt1GM1NHEI
	HG9HghjA0AR2Sztfhgan3bTPJANZMEXsBbu2ym8D6o7d3ouLvhuI2NGofXkOzYAJOzLTWeaj1SW
	dY6HwrJ2Lsu/Uy161bzbh2joiBpLVbrBj47V74qvsZWqyP+rrrBhw2/+vSe4FHlR1mB+th4HNDu
	mxT/w9gZ1dHt6Gew9JB2ZO77OW1ctFms5U2TUhiFDBK3Y0ByMysZQVX/hu/Bzhj8866uLIWyWOv
	IWiIOkHjNYdNLq2u3m44uxS3/xjSdcjnFYSODVnZs1nE2MB/Ar
X-Google-Smtp-Source: AGHT+IE49q3UoW4OFpWbNglvInQNVRlN+yhDQFQFunxA5RskR8zFPZ2d8CXgzPfWY0cjgsF/X3MOtg==
X-Received: by 2002:a05:6a00:4601:b0:7a2:74e5:a4a4 with SMTP id d2e1a72fcca58-7ae1eda0949mr8034636b3a.19.1762429057535;
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:5041:b658:601d:5d75? ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af826f9520sm2452518b3a.56.2025.11.06.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Message-ID: <f3c89a9182387cd0df012726fc30841aae8d330d.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] net: ethernet: fix uninitialized
 pointers with free attr
From: ally heev <allyheev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang	
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Cui, Dexuan"	
 <decui@microsoft.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	 <linux-hyperv@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 06 Nov 2025 17:07:29 +0530
In-Reply-To: <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
	 <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 10:18 +0000, Loktionov, Aleksandr wrote:
[..]
> Code style:
> The new declaration + initializer is good, but please ensure both hunks s=
tay within ~80 columns in drivers/net/*.
> Wrapping like this is fine:
>=20
> struct ice_flow_prof_params *params __free(kfree) =3D
>         kzalloc(sizeof(*params), GFP_KERNEL);

I ran checkpatch with `$max_line_length` set to 80. It didn't throw any err=
ors/warnings

Regards,
Ally


