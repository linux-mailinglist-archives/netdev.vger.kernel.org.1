Return-Path: <netdev+bounces-247731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64811CFDD78
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FC43060275
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4903161AB;
	Wed,  7 Jan 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR+PBtZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B7314A65
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791018; cv=none; b=XgTPy1T0T7TlME3M6X/U5DVIpRvuohwbNm26wtsqQaY4VxwFACWXftkMLA7a0LfAgYJWeZDmxJ/3tKbfV7NNk7PKMRuBBmZsZhAQqn0RYiCBl6fNU9+8Y51wytS4kO5kqQlKmrlWBl8gMsF1I3uQZhKax44d5pvZsH5smk9oTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791018; c=relaxed/simple;
	bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RzBMymSFyhcwYml3OR+CHmmgKqC6h3e9OBylBXc/0PBJ7QRRkGVBVugfXcLzn4AaSriJ8wPl5STZXUQtNLW0cSuHtj1efd4QKns62Ef2U/MtI5tLxoUCUEijjA/OY5OrqzuCClc+3X3BMNYlYfmyg0ge35wSB+vjoNT69GZYtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR+PBtZx; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd364so1612728c88.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791016; x=1768395816; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=fR+PBtZxEY+N0Njaja/uKAKcp5uQMBZcHwjdMwGFFFrkviInaQ6jX6hZSFgvoqEw3o
         fEQU3b6aDbISNzAIfXKmPuUXuUhgU8LHhVp0uBucCxUSsWC87Fng6bj/y0/LCsVscJ0P
         s0SAvUH0BR9KDX9/wEgpgtuS0JRexJFF5ejooEfkz4RwoXA9rEL0ET4Z4goCU1S4lCu2
         56FVZ0/3YAW+B5ak8XjSAk2TRhKGmopesDakWfY3WxKDLcFy6w4hSU6Z+pPR/4icehJR
         RjFOIPAyoNa9UIiZVMmQd94OsvCbI2pTJ6Y8XsPmAHTOlE31U0oqw29G9H8Z4xiS95yL
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791016; x=1768395816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=BNKEUueVl4xBwBKHintErLmayl32Yj+bFzD0PWKkjR2dS/1b9ZlNf/6shxdoXwJDxs
         HTnO4HAHGfIw21jpzIPxnStFWYxc+KpaotcPvOIT+cFBXFU7H3GZfJnVAjY3uOQacXbI
         hoXSfg0J1CRa6SlP+5pTvTsy10c3zKaQQOd0K66Y1sUgCg1WfQqRu0JXAzzCxcmQAnF1
         am0i8TdgcK1bfnqRF8Im2UucaTMB1cq4X9j86iPU+bRv7xVGzwRqzA0Z0jWEFEHfomSg
         E3yDzboUtUiTPgm6nvZfF3l98WArRKfNuGS6nyDrGPzldB9Lt1GcO6cuybxWooyDsuoG
         p8DA==
X-Forwarded-Encrypted: i=1; AJvYcCVNus2209/hh8kl/VSTTLZeRKAdXEGOA6ltlh0ojkOxIPuqoe2o2afajOFin96HqKw2KZTaATU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY8jOk+5es/c4YnQl7BD1j0zZao7dUm1MnMI1HbZkMn1DDtGt
	YvUglmi7MOCWPkZjcM9zfmOvx6Dhtc0zWS5wOhW5s/UXpxTaGXr8618Z
X-Gm-Gg: AY/fxX6nsEUb3YUKPugLGePEKOQZO2wqFh1pib0018jPCRsbg6xKlO9u1ncUYhOx3DN
	cHu1WX46VeDhRM0cyeL7v18asGsg3yDGGgeoGjEJlx0zeEURVNq7OCywXJ22pwD4H3RSVQCLPzE
	uhSY4YWLiDFpWgwZDWIXWGPEQBx1ywXUSe65lT9tRYzAJa2akkW8vybIzG7y4VljrJLlL1rTZbl
	SLBkqlLyWs2rxXf618imKoEue1sOzuxKsJylou0wEFlfguFeLWCW8CTwQFoI4dlfKD8jtzWdlsk
	mxxZMl4ZzZcGD4/NfjgMIB8/uHrlTTJq0vCH48K01KOQY1t9zNxxPnfXeS+YzCUf+uC5glSwKgE
	5JLBGcBBeMfF0UCDn5SzUPGmXcKBqWKgL95d86ykGyp6jbtqoJXIApaxN/lOivIcXulchVlNWSu
	1XV7djN2w4nqn/EJPMF18fmcb5
X-Google-Smtp-Source: AGHT+IGnL2xjS0GT/VWvHOK4H+jFG4Caomv3SQN7QcEqr0Gwfdq8sN01qehGzYICVgdBY7YOseFREg==
X-Received: by 2002:a05:7022:eacd:b0:11b:79f1:847 with SMTP id a92af1059eb24-121f8b14836mr1854896c88.12.1767791015447;
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Received: from smtpclient.apple ([38.207.158.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm7985515c88.17.2026.01.07.05.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
Date: Wed, 7 Jan 2026 21:03:16 +0800
Cc: ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 eddyz87@gmail.com,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@fomichev.me,
 haoluo@google.com,
 jolsa@kernel.org,
 mattbobrowski@google.com,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 dxu@dxuuu.xyz,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 electronlsr@gmail.com,
 gplhust955@gmail.com,
 haoran.ni.cs@gmail.com,
 martin.lau@kernel.org,
 clm@meta.com,
 ihor.solodrai@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A68EC8A-3F7B-4CA0-B75B-195BE5E7495A@gmail.com>
References: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
 <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
To: bot+bpf-ci@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

You're right. I'll add the missing flags to these prototypes and address =
this in v2.


> On Jan 7, 2026, at 20:44, bot+bpf-ci@kernel.org wrote:
>=20
> Would these helpers fail check_func_proto() after this change, causing
> BPF programs using them to fail verification? Should these prototypes
> be updated to include MEM_RDONLY (since they read from the memory), or
> should the check skip ARG_PTR_TO_FIXED_SIZE_MEM?



