Return-Path: <netdev+bounces-199926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDDAE2453
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 23:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C5C1BC273A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 21:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A223ABAF;
	Fri, 20 Jun 2025 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUF2JKH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4923AB87;
	Fri, 20 Jun 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750456301; cv=none; b=XNf1nNX24zhZTxXeq7Kgx6DBV+qg+AyO/bIbOlytxhw7C17yJYScDK1VRod8dhk9suiDzlno1Tvqz79958cSYCi4A+bhQZ/WEHRI6hSW5rE+Yhw5nZrILfmK4fnDhjjSfl5ncsuU+a8MLcNiXyxoAJnOgat9yqIO60OO9aETkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750456301; c=relaxed/simple;
	bh=yyT37FVYMxc3pvsuybNv+R5u392ufUHT5onLtkknmoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nStL+GRVMm1HUfAYbTqc2lBjjXsPq7dWOtRK7OX95Bj38qcHOkqRdtxWNJUiVlNqgaNxGr1Nel28A2psPzMbuCsehe2dR1ewfRR/4kpsDRfDql6UtpgTNOzTppP0HMBEyUMaLW8jtncqS9PSsoZ5Qj+TL+wfflQfkutanenUkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUF2JKH4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7111f616c6bso3000747b3.1;
        Fri, 20 Jun 2025 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750456297; x=1751061097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJHMifKVc+SOcf+N/mU5T07qJGJW3LDfk0F+0ysQoRc=;
        b=BUF2JKH4t9mONas2Pj8tkiKCpnMSx4LthiSZSePpNC8tM7b0ppvlT/bXfy8FnC3VZe
         Q33kehDcsC94lL87qWVsJh1VIqMHsVYBQHVHwT+LQpgzSAS2lkL7BK2zTw/Six/370ir
         GDBstLrDrIVrN9I6+uHDXzzvtOYfhaIXbhM9MAk0O3WGzsKNt8xrwue9347wX6pSiYpb
         Ppk5uZ8XokAaTJ6jZkYX3f3GkSKa+40SSiaVY90XgjLDOaXJzMm5oN7Tr8Cse4DLNM0A
         EnRRsrf4WO3/17ZWB/BwPu6z9bhlHhU+wXC0/ryvV4Jdiq4jvjusauhfrAhwFcyTtZs8
         xY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750456297; x=1751061097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJHMifKVc+SOcf+N/mU5T07qJGJW3LDfk0F+0ysQoRc=;
        b=h6PyADqtTfQlb2KaBW2GNTVWFulgThOsIs6S2aeJSEPldQ5un4FmjRBDXk7bYIWtXS
         BNOXj8Q3gqEpIopWNBpjZKthzeAuJrKisWzEEAWBRU0TuEDdvfZlSUuYxN3SKldQNSpl
         IlTZy9XXivR3HLJgBAz6AD82VAOKhqh0xtUDxDu3yDxkSQejm4AVRWRvVPslQ1Tb9i+c
         xwqk2qTXB+wb/TJnqcTxu0Ssc2IUbbZ1I+5pdMpvsGG0lJlshjqlq8chwkaszRR/2oAT
         5VMKkRt2pY/jHWL8+2UJ5X0Fj8y1nxNAUD+aQJ+CvV0xJvQjaB0sCKwjBHOd5ACZ7yKi
         XlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxiBM7FyOqQTuEZQrb26nVtnroIQCvOMvhHDaE4l8vds2fmrpQBGtvRb0ZmjkJdtlcV3AWfcf@vger.kernel.org, AJvYcCWzfRU2EpaFummUvVzZzfn0Q9CWVHhNJPOY15ApudGAPBB0EsSiBBueEqjvzR/zLMrCVGm6JGlIIN1InoRY@vger.kernel.org, AJvYcCXGAoca2+EMyR/3RRzBMv2mucktYP0kzuK4v1teCGSk7OpbyosQYNzEvPP0mRI7o8f6qdrV9CDXUYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yuvAo06Gj05GTKuvR8qioWbHTh42EIHwUVryWAXs5nJf/ex/
	vSCeKz8Anal6ApxLXEBh2M4v28rJjO3PGZKa0OCE5VtbFmmjqOD/9uQ719cdhKvIIjkS0zceZ2h
	4mb9/JHI35EOfjJ1XxwUTYQeqUpnB0Dg=
X-Gm-Gg: ASbGncuHlS0LqMULwfgh54BdOn4ijoUJm9WeDF62fTjEaaJNmfsMk90pd7laYnT+Lg3
	RA8QvCw342vy17VAlhK9tN3DPdHiCDbIW3tW1mDcoVQpVQ6cNNLBrhpzfZ+XBe0E25OrrtkFffe
	kOZAXWDmR3tX0ucz11EXV2sXtjjRNJxMeQDjNZ/RsJicWxwWgU7JKvLc0=
X-Google-Smtp-Source: AGHT+IH2DKA2rSw+dytJIi10/6die2HLD1sv1v3othTe3lp3JFsz1ecHk5GScFEEWVmflAUox1MnHnrI8upf47AUTfg=
X-Received: by 2002:a05:690c:f0e:b0:711:7256:54cb with SMTP id
 00721157ae682-712c6530555mr34978747b3.7.1750456296685; Fri, 20 Jun 2025
 14:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
 <20250614225324.82810-3-abdelrahmanfekry375@gmail.com> <20250617181219.GB2545@horms.kernel.org>
In-Reply-To: <20250617181219.GB2545@horms.kernel.org>
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Date: Sat, 21 Jun 2025 00:51:25 +0300
X-Gm-Features: AX0GCFtUsm3G5TCCAwjsTHaKQv_Kk_OYKf6HQyFZSN2f7zg3KjZrBsbQqMzWN-0
Message-ID: <CAGn2d8M=Q9DdknYwSUtdb-TMks4CEmMmbNEnSesJA66ahLT7wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: net: clarify sysctl value constraints
To: Simon Horman <horms@kernel.org>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.com, jacob.e.keller@intel.com, 
	alok.a.tiwari@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> In his review of v1 [*] Jacob said:
>
>   "Hm. In many cases any non-zero value might be interpreted as "enabled"=
 I
>    suppose that is simply "undefined behavior"?
>
> Looking over the parsing and use of ip_forward_use_pmtu (I did not check
> the other parameters whose documentation this patch updates) I would take
> Jacob's remark a few steps further.
>
> It seems to me that values of 0-255 are accepted and while 0 means
> disabled, all the other values mean enabled. That is because that
> what the code does. And being part of the UAPI it can't be changed.
>
> So I don't think it is correct to describe only values 0/1 having defined
> behaviour. Because the code defines behaviour for all the values in the
> range 0-255.
>
> [*] https://lore.kernel.org/netdev/8b53b5be-82eb-458c-8269-d296bffcef33@i=
ntel.com/
>
> ...

well , Thanks for the clarification , i will only keep patch 1/2 in
the next post

