Return-Path: <netdev+bounces-194651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B65ACBB7A
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396793A6792
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411A1991B8;
	Mon,  2 Jun 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaaRuv7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5C86344
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892309; cv=none; b=T0iiKPHpOXBF4uZ6nIK8t6mAMgxFjBGHc7aoAjI2MGEEb/9GaPmKUxmliS2XwOs10BU+jkq3itLTWv/Z4n8DfydA4Bu87f+OgB01SXws3MW2z46yKkuDSNQsPil9+gvg/WYOa7wabzL/1BMCzq4V5DZB9zcm5fzwiOsgpv8OfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892309; c=relaxed/simple;
	bh=ZiKLoDClI4oGB7ePHYm/PoXwM7SZEFJ6RFU09Ddtsnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVejCVa393cCaTf50ixJIBcQHN0alse/w5nwoRGE+ApjHkpktWXLZpm1wakFcHaB55DejGhv5jHALeolEvDRXeoE3kTfePVUtvetVFvKcLCNQ51p55Bk6WuVMaVA2KUhAHMwjBqFabBP17ZykdEEJU2xzQsmhNaZ2LkREU44HaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OaaRuv7j; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47e9fea29easo88031cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892307; x=1749497107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiKLoDClI4oGB7ePHYm/PoXwM7SZEFJ6RFU09Ddtsnc=;
        b=OaaRuv7jmcsy/9L+RVCyYhaWHreZkfxkp/7RZQYdaB2FlIH6t3rwF4zLN3IOfSLILd
         6QHn1jKEFQxyiaTckmgdpCggnjR6VllzqcHJg3c6sFhlPILS2/mlxYBD40XkFpKXDFqh
         66uHIXc/aFdC4QL2Gv1tjKAPeOBeI3lr5s7/1HqYNm6Uy276LRSDCm9TUGSdyTGl91Nj
         bPHfCG6gjfQn1l/Pw3o87X3RpABn/lKbTbngA/5VTFAGfqABGBEhfx++7xFAFRu8oUkf
         yBBfH56S/03AttvIwD2UEWqHSGFbk1FMsPhWXmdi9lxEuB+Xm5PDxilzwDG/ndDt6B7s
         XaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892307; x=1749497107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiKLoDClI4oGB7ePHYm/PoXwM7SZEFJ6RFU09Ddtsnc=;
        b=joeedyap4iirMbdPdnvGJw5pKV527tznodHZC1lDYp6WhFsCUYmZNDd6A4byIr9jVU
         41b3lubPayAkFPVBnzIl/EYF91JHqDR7IN0GddCF4YojT1w5Aa3mS4HDa8JVxsMNs90U
         cbbyJZp55yCOacfE3wyxydJTrl/3/GZXFXnC8uWAj3RkGSO+GsAluK0LrvB627ibulOc
         UjAMtM24RPI79njF34iJ1Phb+nc9uV8ASuBP8g90vNXTu+VH4Cg4bAncyDjrze6+N6hR
         8jwEXqtW4hJ/lnI4JL0z4IylT0raycfgP8lqf7eBQZ9vPTVDaerReP/KnDpgm8Xqt2I4
         e6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVJjN1tn/P4iHnNNkxi+FvnUQwyFv5a/JmRFsMV4Y5B/CD9R7ksw7d/B01lMHpwPcuXyFYUsmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0aV2GUz7dqLvyI/COUBL5OkHPti5pGLDY6SpDkJZSzN95vYi
	N69R/xWIGjmF5ZCIsFdtMjx4QXsFh7EQgFUdA8xaKk0HXbvGVav68vcA+FRF5wiUuuATZZsbysp
	eg6uLpJPKGHMp6BpnwOCUs8g9+VghN9C4s5juij6Y
X-Gm-Gg: ASbGncv+ZUadpu7VuibvafSzDZYqA6eWk/0UOWOuv6LQbSZ3dnwm2sRYqq9zMIuuvk3
	/eGXbEg1VoPYjpbzsqgjGgc5lPoKSEfpdSg+KrT/s+j+GV3pM3lbnt+uy2afCUT7B2ciYcgSUXU
	QZdCpYEeZjBgGEpuHHrIJVx/w9EyQrjkgvM95w/5SL5Ysn49wRComp/j2pnEgf+67P682iJFDc
X-Google-Smtp-Source: AGHT+IFPqF6+xgf2xnfcCP8J8BR4Eaiy808C6AxSQUS0B3T49PpL0VIetrrDihRnmJ8ncanR6OjMB+yAkSST315QMF8=
X-Received: by 2002:a05:622a:1f99:b0:480:dde:aa4c with SMTP id
 d75a77b69052e-4a599ac4377mr580471cf.4.1748892306857; Mon, 02 Jun 2025
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com> <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
 <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
In-Reply-To: <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
From: Bailey Forrest <bcf@google.com>
Date: Mon, 2 Jun 2025 12:24:55 -0700
X-Gm-Features: AX0GCFtdZ9HGYJjQPQrzm-S9QW9ak_wfCYsx7jU2Dvzw2QakpQ4B-b9RABc4yNk
Message-ID: <CANH7hM5O7aq=bMybUqgMf5MxgAZm29RvCTO_oSOfAn1efZnKhg@mail.gmail.com>
Subject: Re: [PATCH] gve: add missing NULL check for gve_alloc_pending_packet()
 in TX DQO
To: Eric Dumazet <edumazet@google.com>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, Mina Almasry <almasrymina@google.com>, 
	joshwash@google.com, willemb@google.com, pkaligineedi@google.com, 
	pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com, 
	hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"

Hi Alok,

I think this patch isn't needed. gve_tx_add_skb_dqo() is only called
after checking gve_maybe_stop_tx_dqo(), which checks that
gve_alloc_pending_packet() will not return NULL.

