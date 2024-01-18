Return-Path: <netdev+bounces-64150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99718316C0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CDE1C21EE4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C0219FC;
	Thu, 18 Jan 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWBUwON0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D7B65B
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574432; cv=none; b=ofhBWnqrJwSFa1GFFuGuw9eJSXfyuE8yXOF8ZI26sQCIE2LBt1SbzAYsV52jlBTKZELe4hZ/+7hKrkBSV8oFI75W2Zdd2x6G/iEWJCV6NXXjvCTkYMPmQE1YMGWAe2PTCCUYhREomCCla7QiugTa/wosGsf4SKIihAXDrjOT/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574432; c=relaxed/simple;
	bh=IxTU0CpwYwU5OjD02SeJhVD6j9qfTl9eRa5Oiuw/UIo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=FH2bNzl1r2+JRxKbD6Mx9xgtroEGt1A44A15s71WQnQ0ieYyU5Sq3c5LMPXwCCbCpxF4uZ956mJbLLaWFS//zGhicdW/cUdcobpo0hdW9OlR1uTIMnfbzbkn2bngCBd1iRDQ4rkZPkes4OvC4QoCnGApPL5QuAjyYorVgUSF0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWBUwON0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso5020a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705574429; x=1706179229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fElkpCVVAJldn3QU1Gyph9Wfk3UDHTwccbXNk7e5OiU=;
        b=ZWBUwON0d5irTzudchoDfU1m0micVfZAeRVz4hW/3rGXZmtnumgcWEyr1/586kUcsc
         2zbDopxGtF+PjwIPP9MN0SSTR+LTD4a4l7CuPLsRPgNsyhBrhLM4YMmu3OZxff6NAIs7
         mToTrOBOGPzjqCIaVheS3WJ/9/euynA08VqSTR542ZjbFhuukgTQakm1SuMYM8iLKFit
         iIyDstnF6KjXOtt3YJD6vafZxuHUQg2tC5+8kOChVnGcbNiatPqMkuPkpOzzMX1DMApu
         j3FRzjKJGpNpmPPrEUge8QjqyQc58tVjY5M9Mltg/iMsrNgukTyQByOdCtr/fWlZg5Dh
         NqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705574429; x=1706179229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fElkpCVVAJldn3QU1Gyph9Wfk3UDHTwccbXNk7e5OiU=;
        b=YXLu0g7w5qOmE5OH71Te0EVMhiQ7/Cs/4XRCwZXNYM8PDkJor4zRZmY23FQdiBcsjl
         8bmCDJjosPkG8Go+dWmyUbjysz6hjsCyhgcRqZKIHQOMKSwm0Eu1pQR3zK09OAFcxnVJ
         x7ULM5dKj+WTuK+59AZAqbZktevfJy8v5xqkvGjogoTlFXGhKiR7LvvNQcm3vog3xze0
         mdt0jLtZTb6k4qJRsoR6X+D7iRhmDGggokzOrTHqVfLy6D8IaDbBLex8j80TTocQkN12
         6jxpjeNXD98PaumaU5WKpOjXQNfADa/iNHMrJ1M8Q7OUHfmO6QK4FWk5bWoyUnIRgE8m
         5jpw==
X-Gm-Message-State: AOJu0Yx+rW3JjwovSlJ5lFJaNre2orwoV8E3r+cZsE9Iil/MLC4yToDV
	fwG1pLCq+gNy9ty9q+f+Gno3GNFb3pGiE/H69jTuC0kf4CvHhb9SjqDePpA+S+fweeN9OkRARvB
	RiL/17vY54WN8cTVJAW4DPSJGkg2I4s/qRhVjN4DCY3RBOBGWYg==
X-Google-Smtp-Source: AGHT+IEYNWlKqZLrL3HJBANhMnaH3shXkbyCTpNWSLJK75Xj5W1sNxHdV3ySYAZnIK49Oo4Ewysq04Pchmso2pZCsd4=
X-Received: by 2002:a05:6402:2061:b0:559:b668:90b5 with SMTP id
 bd1-20020a056402206100b00559b66890b5mr47939edb.2.1705574429095; Thu, 18 Jan
 2024 02:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118012019.1751966-1-shaozhengchao@huawei.com>
In-Reply-To: <20240118012019.1751966-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 11:40:15 +0100
Message-ID: <CANn89iJmpFStU6vBN6iXKSwzOHZ2S24QHgTTpuBW+SYu9hCP5g@mail.gmail.com>
Subject: Re: [PATCH net,v4] tcp: make sure init the accept_queue's spinlocks once
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, sming56@aliyun.com, hkchu@google.com, 
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:10=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I run syz's reproduction C program locally, it causes the following
> issue:
> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/l=
ocking/qspinlock_paravirt.h:508)
>
...
> The issue triggering process is analyzed as follows:
> Thread A                                       Thread B
> tcp_v4_rcv      //receive ack TCP packet       inet_shutdown
>   tcp_check_req                                  tcp_disconnect //disconn=
ect sock
>   ...                                              tcp_set_state(sk, TCP_=
CLOSE)
>     inet_csk_complete_hashdance                ...
>       inet_csk_reqsk_queue_add                 inet_listen  //start liste=
n
>         spin_lock(&queue->rskq_lock)             inet_csk_listen_start
>         ...                                        reqsk_queue_alloc
>         ...                                          spin_lock_init
>         spin_unlock(&queue->rskq_lock)  //warning
>
> When the socket receives the ACK packet during the three-way handshake,
> it will hold spinlock. And then the user actively shutdowns the socket
> and listens to the socket immediately, the spinlock will be initialized.
> When the socket is going to release the spinlock, a warning is generated.
> Also the same issue to fastopenq.lock.
>
> Move init spinlock to inet_create and inet_accept to make sure init the
> accept_queue's spinlocks once.
>
> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_=
queue")
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Reported-by: Ming Shu <sming56@aliyun.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

