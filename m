Return-Path: <netdev+bounces-124206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87FF968846
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A1E1C221DF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330F205E35;
	Mon,  2 Sep 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvwItzQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308519C543
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282106; cv=none; b=isULNXxrwW3m7h6GaXi0IAkbu1wwNrXbI1pbPyIpnWsW+SLUTEl/yJj+osvxSndfpi7BwC3pQKNHAB/A9OIdQluNtIDz+Fi0SXOtHUYIjL/bk7thLlPHNCB3jgT+G8dCAvZxbre4I4CtgN8dlZfVIAToQJ8XvTqQEYWL4xea8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282106; c=relaxed/simple;
	bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poanBC5/KrbApzD/hfzM1hHKc7Ufb0E/plmgaNRFNREDeRqv1E+fvJVrNt1YU/kuJRhzDG9euAiSkSw23XsJs+ILur0nq1P+TQZCMM1xMkqqmFY6hXOv1OrrOIJgx+wIs4mFlnyENhBL15ua+MEWjTaS8y5ya9WXXCBPUP+mZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvwItzQk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86883231b4so507162966b.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725282103; x=1725886903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
        b=ZvwItzQkAwNedFcs630M+hLkw/tmm/lisIdJNLZDIo4ioaq6NGjbE8qAGHx8oRdjRX
         hOHRN4BDvrfUNdMneVeSCgsjtIqTm1xdMwLzHSWqOxE0LWjKjH5/XSdpRAyxVa6g71Th
         Ho2s40tUMpQrRrWR2fah77keuK+G9oYT0cEtYQ1FbkZhywbzz9zDEpUUaVuagODf1dkE
         rkuZaeS2E7ApquwVR9D0OHk75WvdZzargYA/1MMIMMLjforRf5KMDjAbjrtfnHqJjqIg
         2CphjEHDsm2ml08w8Oeb5AYrdp5Gea7gJOZXsuyqkRFQPvLU2KKbGAQek7iRI2pbfz+/
         iPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282103; x=1725886903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
        b=SMo7JCJkOQeSf82gBCuK9rKsHIt6HHYyS6pY4CA5523CKlLZeNy9hxuebCo9tqxOqp
         WdObvUh0ix2jfwBzke4FCJGNAYhAES48p1GH4QZItpMWYM63hT7vbYkFRb2b7+s+MWVb
         dR9MySKvmaeWXQCvfesHVNJhCaddzfC8ddhGgb+ky+qMrBb3gwVDGarV/iqeDxlK8q4s
         J7RANT1gVkMQlERwqP1HYgag6ckseNVuWgi69zJ/oR3kkP27yxZWLAI7dqPhysFXPWsW
         M8fTpP3jy+Has5pJgvSbpfOSJ5DDdvWxshlk/C8vV5teaLVnkQzU9wOoD7qKBPyI0XDA
         YPVQ==
X-Gm-Message-State: AOJu0YxPO0bsfT8VtNnXB+Y9zrCK3q3tb2Xd9ctEzSMIjzTkymFJl+oc
	sko7OZF7GH3rGcdcybFe+lz5AV+HYCubRmjALAharEMiLmcXUJbTxe9H8+PolA0cF+QS095m5kg
	9uI68wdw6ZkCFKJ+aw7hSvkBOkZNyalSYhAZ3
X-Google-Smtp-Source: AGHT+IEqxuDt5F9iLAPqh29duXxwhGXKRe2nes7X9QlYEzjiULot5Kc8klsLZ2ZBF8NXVRMhqG5+6UVEa6rSFv8Zqvo=
X-Received: by 2002:a17:907:701:b0:a80:7193:bd88 with SMTP id
 a640c23a62f3a-a89d879cf05mr456688866b.36.1725282101820; Mon, 02 Sep 2024
 06:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831113223.9627-1-jdamato@fastly.com>
In-Reply-To: <20240831113223.9627-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Sep 2024 15:01:28 +0200
Message-ID: <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, stable@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, 
	Johannes Berg <johannes.berg@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:32=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> added to napi_struct, both as type int.
>
> This value never goes below zero. Change the type for both from int to
> u32, and add an overflow check to sysfs to limit the value to S32_MAX.
>
> Before this patch:
>
> $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irq=
s'
> $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> -2147483647
>
> After this patch:
>
> $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irq=
s'
> bash: line 0: echo: write error: Numerical result out of range
>
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Cc: stable@kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

I do not think this deserves a change to stable trees.

Signed or unsigned, what is the issue ?

Do you really need one extra bit ?

/sys/class/net/XXXXX/tx_queue_len has a similar behavior.

