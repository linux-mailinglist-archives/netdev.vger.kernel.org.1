Return-Path: <netdev+bounces-77555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492188722E2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051A52824A5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4271272B7;
	Tue,  5 Mar 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsEg6Bqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59984A48
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652831; cv=none; b=WtromIoiRgOw+Finaft4KtqjfOxEPlmMiy9YSvqwmDDtVwykrupgutYgZ8KYOzSZzijTJKuBLbgQAfQi73AtarGKNrVPUzITSEOP8GYDCTY9Qs5tEm839bUCRLH2Qqo8IW7yB62GfXFT7Nf8C9mG2JoHOhefz+6vHro3obA/ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652831; c=relaxed/simple;
	bh=6aNb8vLSBX1Qvl67wVe3X0xuOVATuAxrNByB99d91uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCEDjld6AJnOdKWoyXxx8cfiyKFIoeAU33vPNqkJBwZ04JinmB+slSREmzHJdHx3ydzA7fQ4y19EqH6Cka94lADGpgQA4R4KjsLbk7UVZPwW+g4RVX80Gx/ZTAMaGzaeUyJHoYCIN8Xr5EU65Rh8gywLZXbTmX2xjuwBhIKc5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsEg6Bqt; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36575bb8443so155725ab.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709652829; x=1710257629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aNb8vLSBX1Qvl67wVe3X0xuOVATuAxrNByB99d91uU=;
        b=GsEg6BqtZDOsoUP3pUh7Z/i7nazf/eC7uTEo8y25JKU8YlEqvwwIEqOfgx+tFC+mKk
         34CsxnjZtl0Eu9cXDpBBMscKegkuwwbGdHVlUNveIjpVI8piUPll3v2UHWMJAHXfv8ZD
         iSM6mYyR+Yk2+zXr13P99k1ymX4gN2RJgvRkmGgI61NtllsdGa4j2ZMKpOeb8XYTQZJl
         cz9i59kpplZ3oi6GJI4mIqcS39li4sFcoqWeVWXLqd7LuT06vhtWgCPpFY0pnU71rtRk
         8qQaVDN9sI6PEUpp35LwR70Z1Zkt5ed4tlm5bm+Fs0TqKOKt6no9tGVOSsKPBn7CFaew
         1MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652829; x=1710257629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aNb8vLSBX1Qvl67wVe3X0xuOVATuAxrNByB99d91uU=;
        b=lgYk9YrIUvpB0Dk95M6IZP7M2+vWn6d64YiOE5EiK7fsjhgPwBxkf5vJGSTADWBl41
         sVHwP8nuQEP79FfGkB/37hklvmStTTwhlVduXEyODNmD7IVcxxurewZVT2wQZq6UypFn
         ijCjcgsyIYG/XySzK5jiFxjMoD0xDW9sHQALU/MuVrE5rxNiBozoSXgSSfWNdLIepfJW
         vTf9LH/i8LmaF3I5Z7JFMq4nbkwcVLJJ5eHliiObcRbTXC5FwrV/5CSp4xiDFo/qcntq
         9A6fuAz3j7u3BapIFWAWXbx0rtfl+XN/ui1HmNuXPy/IzAE75Dho6tnc2rhr23Ek99NW
         UAqg==
X-Forwarded-Encrypted: i=1; AJvYcCWIawKTLkYMWcDwQ1FQP/kAiVTacPVAmWrmaf6pdnhsn/EQEWpxCvDdPZbGUB6Idt1msJ8/TnCNbBHvulTwRJC33nehv7EB
X-Gm-Message-State: AOJu0Ywd3odsE7xoBwfcaaAXVq6euwUBVYwS93tUH4uCAfpoM0IE7LJn
	3eo4elVtiY6HJKyrJsFQzUg2wGyzE4NUOIroRiZe8kwvQJzjz7wD0pea4ugA2XErTia3vZhjIyq
	KVr2qHnsije1aj7DvIS39OEj0BGiFyJ81e2y9
X-Google-Smtp-Source: AGHT+IH3IYVNnE8e8N8UDKks6JoyqRRkWzOVRdYNc8oCDDwwF8WcDBv3sAsE7g0qGwV6z/0yJfuyddiWRTi0MmXbSJc=
X-Received: by 2002:a05:6e02:b47:b0:365:a781:8d74 with SMTP id
 f7-20020a056e020b4700b00365a7818d74mr204290ilu.0.1709652829142; Tue, 05 Mar
 2024 07:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-3-bigeasy@linutronix.de> <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
 <20240305103530.FEVh-64E@linutronix.de> <20240305072334.59819960@kernel.org>
In-Reply-To: <20240305072334.59819960@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Mar 2024 16:33:24 +0100
Message-ID: <CANn89i+Xdo-=4daFxCsRr2w5Yai=cpL=19Uv+WmaNsxtaXS2+g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for backlog NAPI.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 4:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 5 Mar 2024 11:35:30 +0100 Sebastian Andrzej Siewior wrote:
> > I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
> > the results look good. If anything it looked a bit better with this on
> > the 50Gbe NICs but since those NICs have RSS=E2=80=A6
>
> TBH if y'all tested this with iperf that's pretty meaningless.
> The concern is not as much throughput on an idle system as it
> is the fact that we involve scheduler with it's heuristics
> for every NAPI run.
> But I recognize that your access to production workloads may
> be limited and you did more than most, so =F0=9F=A4=B7=EF=B8=8F

(sorry for duplicate of this message, user error from my side, using HTML)

I was hoping to run tests on 200Gbit NIC, but current net-next tree
broke the idpf driver
(at least for the FW running on my NIC)

:/

