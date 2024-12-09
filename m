Return-Path: <netdev+bounces-150280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95119E9C79
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D9B1883E2A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C6154C17;
	Mon,  9 Dec 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccoe3Y0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD1154BEC
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763679; cv=none; b=fkPwNHDVZOtP89Y7C6MMg2JDgKxhVpi9dAS7aKoDPlMI0Cr7wRe5qe+51AC+WmRpop+ULpxFXbwovmtnePsiryQO4BhijACCJl8CSb1ZO+lhjt7VkFPtiFkN5UU5kDlGZcSIMhv0RYVez1QfBlXJTsuTEI/2ahYvoRJi8sHTHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763679; c=relaxed/simple;
	bh=pUtcaZ3G9aSBvBL6TFRnCeFW4lRZiE7xlIPP1JC/mOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXClo89b1yZ6GA8R+MKBnC8bXgr61nQpSg1r9w8smoqy9MZ2k4h4ucVkPR5plBDMMsLUmRyFBkFZhIh2eYI3tw/3dAJjMmQcqoRLVmBhGxednySIcyKHAEU50fJg3pbml4hud1ITRlo1ZpWvX182YSJlO3WimuBcpKmzV5qn2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ccoe3Y0k; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4675936f333so304511cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733763677; x=1734368477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUtcaZ3G9aSBvBL6TFRnCeFW4lRZiE7xlIPP1JC/mOo=;
        b=Ccoe3Y0keWZw7SBZzMwPVBaLZ6KVzJeTh47QAM/u3G/0ATfpHJWsetsJ68ZeJ1hPcP
         rGUi5gKu02nyS1D9JEC1hsPHooucKENsL01U3aikNr41Sw8CAGb9n/hXvzC7CGcKjuJ2
         +R7Ogjhz0XdzKfFNwunoWsfu+2nWXtvwutOoohMddwUn5EAhhnvaIAZ82qBq4KwD7XvH
         bJ1tPzOrD47ic78ufXqI9uKuDeHuyLRjVk3tATgNy8o9dIZmIcrTBA9jk5ATHMWMuAu0
         o07/yCogtaokc7NmI60WbliVSWaNrOMRnZjknHzYCLBJ7i6ppB/OgepPYyW0k6KPuEQA
         /saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763677; x=1734368477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUtcaZ3G9aSBvBL6TFRnCeFW4lRZiE7xlIPP1JC/mOo=;
        b=gdlAoX0GbsDvmNtj0rYd2OlhBRpFp7gXd6qsSYTOCYIbfN4HyVdpYuSkkRIVHrtv6f
         vyBJ1pN0VqCzknOK3WFNjhs/m1zBzjljWjKZv8sswBA3CUQezEk8ALdycwsuS0xJw900
         guGWokT9uJB0FOJlKpn8uL0/QYSpQ/r3wywkda8BQPBoTZX1I5McSVhNaumZqDqgxS4w
         WgijwffieRUIpUjRbO4wTJ9V5LZ8CNYZJW7nipTwSBLiP6FuSRPg/g1leYcyMIIw+rZR
         hWGslqNqvIh4YoVSYIAckzVT+RqHY/R2EImu1cKUGTqVm5HjCSjnZUbazMYfZBzvCbf7
         FUyA==
X-Forwarded-Encrypted: i=1; AJvYcCVdS5l+JwWnSR4tE8W+egUuWz8kvULconnUCSi+nuEh3xzb0bT8bgSjth+1opn1t0hv36GNv2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0XuTLig1F5OI6YjYSdzwg3kqy1bm3e0ehIfr6lFsq+1eLNNm
	Wyl3csDXl5IFEC2XcryCdgo8EPEG/GNEOiQJi58eTlyDbibwqEoNUDY61NFbQ5GsQJCHbJ/rtnR
	oz9ei0ookCz4GI5Ga+/RXh5GUAHfwi9ibQ1AT
X-Gm-Gg: ASbGncvXQkmBa8kUrtIAWvsnqfQtk0DoXudXLvXpXFmEbKx/sqfdf1hzv7ljedGBK4o
	Lp6mayddYmJDnoYO7tt9j+eZa1rIElXLUSVt1B7ui2G9S5um44TBbCVMknVfNEA==
X-Google-Smtp-Source: AGHT+IG7ztvj5oICFMEuNH6nn+JsDFn+n5yiRdsy4jmtRu797XAYVrp2pVczv9CdzMVfXqHzkMpVSL487X7ntrQt7xY=
X-Received: by 2002:a05:622a:988:b0:466:8f39:fc93 with SMTP id
 d75a77b69052e-4674c5dcda5mr7999271cf.3.1733763676705; Mon, 09 Dec 2024
 09:01:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204172204.4180482-1-dw@davidwei.uk> <20241204172204.4180482-3-dw@davidwei.uk>
In-Reply-To: <20241204172204.4180482-3-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Dec 2024 09:01:04 -0800
Message-ID: <CAHS8izOR=C=eV91hLu6WubkR1Y9UXdyX0+vyXqiS800gSP3pNg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 02/17] net: generalise net_iov chunk owners
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:22=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Currently net_iov stores a pointer to struct dmabuf_genpool_chunk_owner,
> which serves as a useful abstraction to share data and provide a
> context. However, it's too devmem specific, and we want to reuse it for
> other memory providers, and for that we need to decouple net_iov from
> devmem. Make net_iov to point to a new base structure called
> net_iov_area, which dmabuf_genpool_chunk_owner extends.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Mina Almasry <almasrymina@google.com>

