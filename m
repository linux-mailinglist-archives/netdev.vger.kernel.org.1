Return-Path: <netdev+bounces-180698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E1A82288
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B511BA6597
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C125C71D;
	Wed,  9 Apr 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOqa/h+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A025522B
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195449; cv=none; b=hcHCuphod8+v0EEhIzFqv5dr0XzKATWRbNXaCD2dBYWJFQSi6Wk1xMoRA6Z7njcSB+AiTXlEgEdzeKorwngrDadlI0HTYr09iF04QmNeyK+0Dp63yjpBS2WgTMUrFuE0tXD2tTd7ovGXdkAhNShr/7yBMe2YjtD5Jf6O294gTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195449; c=relaxed/simple;
	bh=PfLU39HpC3y8eEPkBLfC/e0ue9kdVMUd0VvbhQPs0e0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=auWzckdF1G37OVbkyugV/EhkxDM/+kuA9VjL+LxbbTJxfFXCNHGGN9NlktYZ0SGzIwZK2FAmDqSxHaF5elqhVCmfrzARwt8slzJBnU6YhhrcGFS/Vf76ghrn3sDp82hG0RcINIUS5i+7/bG6BrXHeuVwuJ9vUfR7DXZRL0DOLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOqa/h+P; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac34257295dso1324734766b.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744195446; x=1744800246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pr3uY4XxzeIkYQHF7h++wRBoZ9tshcZUvh7KY2WmuFo=;
        b=VOqa/h+PGr00fG/4GkRxutmyTQO1yMOpnSHNvzgndgECXTXFOCn4f1vG9HqkurYbKa
         3u1Jlj1DwHwXmOU51ao3yFuhvspFRLB+dh1KLHHPDurNPdzn3tpU6awvU9Mqa4G6YElT
         nfg+6tEn1f4kxD4lImIFCLNOJu6/Cq5jCrXi1t93cZJ7d4yva/3441ourtWz+n5OXVBW
         zjVYSXhOKEd22Q6Sw84b60rVGnFRSyTj/BqL85e1TvDDNYAHQhzDhTHR2aynfBdZBxe3
         FxbR3B/vWIliHSiEakq49otiV9RGwgOjzP+OeIBv6l8J77BL3gRuM5dvmrHQ8ja3nn8v
         iplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195446; x=1744800246;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr3uY4XxzeIkYQHF7h++wRBoZ9tshcZUvh7KY2WmuFo=;
        b=ZGAMGiebZ35vnKtrSZQNJCLaRQyGp//JDAKjwTiwUDzu3428WrnNduSaMQuqtn/yjy
         DeRxtpmbLm4B08MOQZ6cGBxCJenKJ5wNCgWg1QDzmHeets5Euzdci7sdytXzgkPc3H26
         yPrE8+IEKqxmiSEf186OE7vmdVQRbbbT+wLo77uHFHvSqHf56u0DXSoE9B32V1rE1E60
         j1MOXPoT4TiuFhUV20DXeg52dxAikxe5EufyAfmmcCNk2YdeeYZpbblIyIpIXC3/DDOZ
         OpES56sfMimX++HtJYmfqa8BadRGpmwBWZhxIWU7YXlnAYT+mWMsgvu5Aa64f7FTwRWO
         nacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLuQYbfqfBTYNWOsuuMuqPgcq/Bwr9e8Q8eWn30OkiTgQCx01ErE2lcr8wICvQKgxiQhQ1YhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDtceurN2LNyosYqw/gA5+sT2vxL7tfLbdTDnuiBc5qW8CU3B
	XPJL7n3yIsdgjh3KFDQUn9IgnvxkD/iJZkayOwgCRS6MQq2gtvL+
X-Gm-Gg: ASbGncsUng/cU97h611/7aey95jh6FuaeQqQ6fNIeQycxa3z7bkrrivCgtFQK47r2DN
	+LiYHQ1AjhcPSfUlRjGuXU9BBU1BKFkkt/KLnJiuYfTfB1We+LPmCVoOmtKlgsoBY3eMOuOMEgG
	/hym7SdYbJdaQAf5CCFKj32Eqs9opNFIfaCEKcYrcgR6HcQ32chrqSPh296ysX37Ygv1NVNiEyK
	XnLy26oz93lYl4ua0DddB556wVjGjG/jo6o+YvyqiuargWgJ0/A8dpxhuYdl/1T8ik12VWrxcmI
	imr7ELSu+qkJzchm9ZzRkpVrJhZv2ohpLsbFe8Ycmn1mQKt7KXk7i675iQAHB2UFfSt4yKZKLj9
	K0B0Bw+qQ2dA=
X-Google-Smtp-Source: AGHT+IGDcbkhQFop/silcNqZ+lI5ZVPTtjSl9S6wIgig17VnrVDiCyHtpaKl+Ehx0X5Uxf96hHq4Aw==
X-Received: by 2002:a17:907:3c93:b0:ac6:ef94:3d9a with SMTP id a640c23a62f3a-aca9b5b2f25mr332654266b.4.1744195445826;
        Wed, 09 Apr 2025 03:44:05 -0700 (PDT)
Received: from [127.0.0.1] (217-175-223-180.dyn-pool.spidernet.net. [217.175.223.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb3d8fsm75675666b.106.2025.04.09.03.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:44:05 -0700 (PDT)
Date: Wed, 09 Apr 2025 13:42:59 +0300
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Slark Xiao <slark_xiao@163.com>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>,
 Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
Subject: Re:Re:[RFC PATCH 4/6] net: wwan: add NMEA port support
User-Agent: K-9 Mail for Android
In-Reply-To: <16135e8d.86f9.19619ac8560.Coremail.slark_xiao@163.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-5-ryazanov.s.a@gmail.com> <2fb6c2fd.451c.19618afb36b.Coremail.slark_xiao@163.com> <16135e8d.86f9.19619ac8560.Coremail.slark_xiao@163.com>
Message-ID: <E0D733BB-34CB-47A4-9871-D7F0B2B47DD7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 9, 2025 11:30:58 AM GMT+03:00, Slark Xiao <slark_xiao@163=2Ecom> w=
rote:
>
>Hi Sergey,
>Device port /dev/gnss0 is enumerated =2E Does it be expected?
>I can get the NMEA data from this port by cat or minicom command=2E
>But the gpsd=2Eservice also can not be initialized normally=2E It reports=
:
>
>TriggeredBy: =E2=97=8F gpsd=2Esocket
>    Process: 3824 ExecStartPre=3D/bin/stty speed 115200 -F $DEVICES (code=
=3Dexited, status=3D1/FAILURE)
>        CPU: 7ms
>
>4=E6=9C=88 09 16:04:16 jbd systemd[1]: Starting GPS (Global Positioning S=
ystem) Daemon=2E=2E=2E
>4=E6=9C=88 09 16:04:17 jbd stty[3824]: /bin/stty: /dev/gnss0: Inappropria=
te ioctl for device
>4=E6=9C=88 09 16:04:17 jbd systemd[1]: gpsd=2Eservice: Control process ex=
ited, code=3Dexited, status=3D1/FAILURE
>4=E6=9C=88 09 16:04:17 jbd systemd[1]: gpsd=2Eservice: Failed with result=
 'exit-code'=2E
>4=E6=9C=88 09 16:04:17 jbd systemd[1]: Failed to start GPS (Global Positi=
oning System) Daemon=2E
>
>Seems it's not a serial port=2E

It is a char dev lacking some IOCTLs support=2E Yeah=2E

>Any advice?

Yep=2E Remove that stty invocation from the service definition=2E For me, =
gpsd works flawlessly=2E You can try to start it manually from a terminal=
=2E

--
Sergey
Hi Slark,

