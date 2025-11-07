Return-Path: <netdev+bounces-236806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A96C40427
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319994E20DF
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22913328601;
	Fri,  7 Nov 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jd05a5Y0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA31322C98
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524636; cv=none; b=SQIjJhxrLCW/JscWCiXPhoLDIhe3Eqq8MsuA01x4IR5ZOKcSWKY4wnnby+08EC2Fbv3VR6wDoQ0xmWsmuwC9z3Tg0w2/5ONST7fJLLHNtD5b/ls3Esxh42LqkLOspsvkSHRQzoxVtXyxtgTVsEHlMiBjdYWUBaXktBz01G9IGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524636; c=relaxed/simple;
	bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrFsAgx8r9fAG81KEHtgHZsJME8fwQmXWN/W4bJDLPenXQ43rlWCCbxyRqQyEN18WMifxHwoINUbwnSBsNv/9fR/tog9kNh0HcDzuxIuPKXl4Y3uzQJVGB4Nxke6nbLt9jaOnwYVSRPUdkSIgEBGkbRAdwZHjLk8iJYOgHPxU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jd05a5Y0; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640c9c85255so660711d50.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762524633; x=1763129433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
        b=Jd05a5Y0VSWEg6+WhsNNNP8SP5sWGXlREIoQ7QL1YSRh5n+xYDYKhN3VVUF5PMauNv
         k1oFQ4XdybJJ816WPMB9wp7ZUPFavSRX9FvwVWWlnnjzf8spk9fKGrSbfOpG51a7JYKF
         JMpQOLl2JhJsh1qCk18sPyzOQBYZ3r135FGyQ8UNNCm2WGWYNy0sLx/uSC7sF3TMmpaJ
         kdDNfQClpuTYwY2H8E+M3n9CfevAXenBf6j91ng0IYu8050N2PJuSKiSSAkjhtZ0pNs+
         4FLdX11mJsMvMSMlOG/nOE9MYyShq60mBDf4ArZr1eLwyOWJw5UexKAaLmIXZWMCF56m
         k+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524633; x=1763129433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
        b=wmywrzkNX1tST7cbSSJe5G23nfB1K+38Qpas8dWZQnTdVvZewjVQgKfQxRR2h01aYD
         H0/9a6QgvfJzeOY5gMwYbTallVzhpE4vRQO6qLtMU8Ovz4idcwuGTAsgkidKzGMHDLhe
         sDqoj+4Xga9q73wHg66WAUCdRtYm1yZIq3Y4+yMAgetV8WJxcwyuSIv3CMZbL2Megc+9
         nhWkkz386zzR7JaNKqr1PCEGaQlaNUzy1I80FPM2ZHOGmvxPqQfIIUxC6iv0RGb8ndjO
         qlZop6QoMtOg+Ia1ZbBJyFAjd9uYuPWjirbgq6QxhJrig7romBlajbfdK5ovo13hM4S5
         YPEA==
X-Forwarded-Encrypted: i=1; AJvYcCV/4MprE/9LnTQr4wXSNQX2SJ3BKnciqX5lZ99fridDbE/HJ9vVLSl7pFM+BAlrkhAxXzLlj/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGJiamculClZhODKXOxvw8Wkh9d3pxUK1QIiYgnntlPnV9Njy
	pU9zdaqFwNEbXrKHa77Uf+SoabDrExG5YB4zFWdfVAb/2m/f3H7mht4DE+UiZ31qbnB98Kb3YJQ
	ypT+eT5Zxnc9p8W++9fwpJwpQ6SkneUCC1to8tfPlrgjDFxWrSUUoIoVd
X-Gm-Gg: ASbGncsylNgJDnvDaPBw1yzmLYFS+Ky69dacUIFtagcOYOErk06u3ntv1z6fM74zbiL
	ta2mISxgE2X/B05ApuVSddWVP3uPqu/efTUjbe66pvY7+V59LWBRAJDhU3N4hmupwwxwNZbIyD7
	XIGqvFfp7iVmiyzDMz68ksA+LzH04IrGqJEMO+Ap+X6XuEjkpIUmMDfxba/9q6jSSf0PKFD8KG4
	gjdIRusuypvnVwEaSuMDXUg2v80gzJvweoP5IInuD8X/LztPS39IR6DTwWp2uG9YwQRdS4=
X-Google-Smtp-Source: AGHT+IF4MNPjtjkI0HykYzQ/N+DjSl09Uwih8EXv3NQX/RBzR++OlV/O2BGN0tPhSnQ92UawBVQW3Cb0VrPm4WrY5A8=
X-Received: by 2002:a05:690e:2557:b0:63f:a48d:b7ce with SMTP id
 956f58d0204a3-640c41c6a29mr2059410d50.27.1762524633098; Fri, 07 Nov 2025
 06:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 06:10:21 -0800
X-Gm-Features: AWmQ_blZgftDNHs4-HzNXdI8nrjDZ7hGHov3wbswer-i55xUXiO1FMu9wnhdIiA
Message-ID: <CANn89i+Cc=y_Powx5aWC9fkASsMpuDZsL5TxDxEQiHmSjj4khw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:56=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> In the current implementation, usbnet uses a fixed tx_qlen of:
>
> USB2: 60 * 1518 bytes =3D 91.08 KB
> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
>
> Such large transmit queues can be problematic, especially for cellular
> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
> fully occupied USB3 transmit queue results in:
>
> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
>
> of additional latency.
>
> This patch adds support for Byte Queue Limits (BQL) [1] to dynamically
> manage the transmit queue size and reduce latency without sacrificing
> throughput.
>
> Testing was performed on various devices using the usbnet driver for
> packet transmission:
>
> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> - Quectel RM520: 5G modem (qmi_wwan)
> - USB2 Android tethering (cdc_ncm)
>
> No performance degradation was observed for iperf3 TCP or UDP traffic,
> while latency for a prioritized ping application was significantly
> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
> utilized by iperf3 UDP traffic, the prioritized ping was improved from
> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> connection, the prioritized ping was improved from 35 ms to 5 ms.
>
> [1] https://lwn.net/Articles/469652/
>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

