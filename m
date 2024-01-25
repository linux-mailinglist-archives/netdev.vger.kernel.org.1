Return-Path: <netdev+bounces-65934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B382A83C867
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C363296090
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF0130E40;
	Thu, 25 Jan 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBD667Uj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A447135417
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200993; cv=none; b=J8/SST2Vj4DfbbQzVl6eLGpvEYM9fqJvJM6mQIzDQ84VXzU4yX5gfXhkm+TubK3N5KPxcMVy1s7Plixo20cTXO2DZSJkJmkSzZUum8hyGBkeuODFrtAlSOyr5v3Z3lUehCKeewhdDehIMs4GOAsQ8+EGl0JPEhKnEY9/rHgy6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200993; c=relaxed/simple;
	bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0liNvDNzg7rXLiuQ6cVUdxAr/JAEWAuns7KyQhkRTuDpGIqwViKqvJfsdjqRoQsPZDWNTz9fd3ym/h5vu7QQOcOjk5VPHMH0RUHxz0/ZWBTp6KOldMc6JXRKLJaxsCGhaKhOk832DEfD3vHiVi2QOlD9EO9hENvQSyqd9Q6wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBD667Uj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so16531a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706200989; x=1706805789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
        b=FBD667Uj+Fo2kXL/mAzsxX0zqwekq551OuN+tvapKlGgKv8oFyamb3qQOZcJDo4kPH
         sqFrlNrX3WVRs+hlZdJIiX5WDlkSwWuYtDc9RyQ7/4vM38kQYKibGzSLQsbiVtxGLDq3
         MJvX8Zm/El1+mcGNPMYbU/NKVCEFIhwW2DzPcwPV53i/FWG7SQOZnMefGwzCKun7CKfe
         H1EJsGk40sL8rxEfWupwFDx+GG7NSNacmqzBcp2syStUh5s8XOHy5gBTwmFDXT32Zf9/
         7Zr8hzk6uFgpMHwE39iI1Za4KVzhaoBmYDCIDN0hMHQEoZYZhRf+V55mNwCCVaQ9kuFn
         cBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200989; x=1706805789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0kRxSHNEapMGeFHNVVRIL7qEYCxbJJCpd+SWBN5vMU=;
        b=MJwyoXMnMHs879OeBb1b8QYUFDtcHikk5XEUQMVdvYWIMpugJDa26BNVd9PvNCk6n0
         oDE3XQxp6MpmdmWrst6+0fbshxTbm8LKiq4YDraqQp2L/vFztRUjU2WtujJtnx1CC4CE
         IFq8xF12H+6bO7DbPmbWCYyhG5wn9S5Nk0XYuAcQ0UuAUAUpR5SquhStUPsFvsFzTMly
         IbirKztUA4XIlzTCSoqh/a494yxn1e0f1HoZfZkjPDhhGzxpx0Di92RoRe65zq21mO2Y
         eETOMyAmta/Ny4miHwIYxmM4lXOZ7JaqltqbEtTOmLn+YNYJcqEs0lkiqTxqqL1PlXrr
         0++w==
X-Gm-Message-State: AOJu0YyNBK5sH11CA8fjFJp8VK1mGbV8Ql9nkiHZ1Yszn3E3M4djSfy0
	wNTfvzDbBYTxS2ZrhgmAQRDWaWRcNfavFyRXPQDMruCl6XXxaXp75PgIIGIwPiu9ZkCsWeElLtx
	VZaJvYZNxjpl4yXrpYsvlbxHI9wukFkkdamYF
X-Google-Smtp-Source: AGHT+IHUFx32fC9YNC4d0sEJq63ZON8ak0fXZIg3iwWuwGiBl2m1AoMhCEvipFmByVo6TpSH958CAWSupW4zTOj0qT4=
X-Received: by 2002:a05:6402:2078:b0:55c:e76e:9c9d with SMTP id
 bd24-20020a056402207800b0055ce76e9c9dmr197121edb.3.1706200989077; Thu, 25 Jan
 2024 08:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
 <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
 <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
 <CANn89iK_i+7RzgeaGQPUieU3c0ME27QeJU9UH9j-ii2TeBoEAA@mail.gmail.com> <a50e07e46036947c873df09b6a48bc8b74547689.camel@redhat.com>
In-Reply-To: <a50e07e46036947c873df09b6a48bc8b74547689.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 17:42:55 +0100
Message-ID: <CANn89iJz_cTQDYJsh=Cxqjrxeo39xibH6HREi1-8R3H0UMzSPw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej enczykowski <maze@google.com>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
> Thank you for testing!
>
> Do you prefer I'll send the formal patch or do you prefer otherwise?

 Please send it, you did the investigations, thanks a lot !

