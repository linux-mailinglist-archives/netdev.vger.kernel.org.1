Return-Path: <netdev+bounces-149776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134809E762C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84E3284ADA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BE1FFC73;
	Fri,  6 Dec 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Do9LuaMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F720626B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502936; cv=none; b=U5oIueVy5mAfhVJ2nRO3zML8T220nCQAkFkr6yk6LftuxxOaUI2qSxhZMnu8R3HrQN2KHVgxdboOY/ix0RLt2PAYYJTmKwtD0SWMeHQhVgmC/KtjGn+hw8BU1P23WvwTFLUJwWWH4sVlpAXOeR4xvmeKBTnX+YfsHM6PqUTwy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502936; c=relaxed/simple;
	bh=InO8vnd9bDxgBetOrct2A2w46nENPVDRXnvuraXsVjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6wmAXOx/eNYi02E7HIM0S/E1ELUZ9SB1mlPa3+6oB+JQU95djH67lXRIovsANs4vYC/C5PRKctN4/MDu6zi6HtJLydS6SpZw1br4P4yeRrE247E9be6WSEW+Ek3Ozsvrf7lRpZwUqWaAaE+vLzT2M87H9SiHZwJEnXQVu0CA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Do9LuaMf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d10f713ef0so6063785a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 08:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733502933; x=1734107733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InO8vnd9bDxgBetOrct2A2w46nENPVDRXnvuraXsVjs=;
        b=Do9LuaMfH9qMhqhrmZFG6SsVmre+1WLhDTeyOfdird2fIxhRGaTPmz3ax4VAncakx4
         UNYtP37F5DhPDf3CF8ZI9r5PDSaGGSLK7m4V1ciWYwJpYwmuhy16fMDrEDuQCkZLS5OM
         k0clSI0r7Q0DAsAG3Dq8se9g/8PrM2iO7cDQRlETdevUYVk1BNNshIAtcwponoB/cDKi
         8WWrzw04ZLxnodIbhRD4AoTvWi1rHO+u+bq5I4O+J4HkwTMExH8bsFkv9RvINw1JFH7C
         P4CEh/yk6ZAwT6l0V7YIWXdJmTpRdKmbQTNB+SLO9i8KhjF5AsJCQSxdAUhBfZrC3fxr
         +Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502933; x=1734107733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InO8vnd9bDxgBetOrct2A2w46nENPVDRXnvuraXsVjs=;
        b=f5Dd/Z/eLxF7yDTskTDaooQNwjCkmc4hICPwa/23yFRnt4gAjDPs6ciCCcqs+M8A5f
         0Hp8tkbxF18+q3Tjc0YSBC1DV8j8T7WnmysnHlUe2mIWeVwTib8Yy/7KZQuNORfUck6Z
         l3a8d8fqXyUtH+LD7bznVRuY4v6A+n0w8uHHrtMwOMW4dAHr76M1RhFwGfwdPuIdGJc0
         JCaZ7cXfyYtafAv1/Q8E02FQPeJ/C3/lnHesjhblL3kw1y1Jg9fLa3g++C5bQfLu/hzp
         bKOp0JEE2wYDIwS9xvAKOVKnA07hLJNbJEkHcr7OwCfw+V4xPZqo64jNTf2Ifs8mpt3f
         81IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuf69htBedkMrfic0Nxk6SYTtqA+DlojTS4v38Rszf1H2BXdWngtbBR/q5KPWeK8RgRlzGBXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlRWFLiywUj0iYKFlO9f+LjMR1HlyYsW/5AqMJXrY9FtQ2R8s
	h0g09MJRwZLPxMGkKZfEGG7uZ2sR2H3ddKPTQdtEOwKPUtOUIaBrdF77q7C6N/ennlvEnVwnrfb
	AlBIsVnNkwDkptWXd37uDMipRAQslnYnWcXX2
X-Gm-Gg: ASbGncuegK1ycQP/wGX/E/u2FBdrcg03e2ZGyqHCU38r18LIItvCgK02Z3518pxgLVl
	RG+8H2W5F1wMy6lWM3/9QAlZtvxFsCiY=
X-Google-Smtp-Source: AGHT+IGIL27LvzG2pP1GZw1BlJkJXc49UvzxHLkiPIFFlIBaviZJwlcEpq6QyiyqrlJYLewI/ZcwBRpp3mjhcY66ZZc=
X-Received: by 2002:a17:907:96a5:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-aa6219e170bmr702751666b.23.1733502932655; Fri, 06 Dec 2024
 08:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140230.23858-1-wintera@linux.ibm.com> <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com> <138dab5cc2ee40229a72804c2b92dce3@AcuMS.aculab.com>
In-Reply-To: <138dab5cc2ee40229a72804c2b92dce3@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 17:35:21 +0100
Message-ID: <CANn89iLnG4qkFR0mH_BN07BXGdYjBD_TzAYjB4nLtG2_SVYdFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: David Laight <David.Laight@aculab.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Nils Hoppmann <niho@linux.ibm.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:48=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> I've also wondered whether the ethernet driver could 'hold' the
> iommu page table entries after (eg) a receive frame is processed
> and then drop the PA of the replacement buffer into the same slot.
> That is likely to speed up iommu setup.

This has been done a long time ago (Alexander Duyck page refcount
trick in Intel drivers)

Then put into generic page_pool

https://static.lwn.net/kerneldoc/networking/page_pool.html

