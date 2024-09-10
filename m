Return-Path: <netdev+bounces-127112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8997428E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25AB1C26010
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE519ABB3;
	Tue, 10 Sep 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNFgVEMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8A1A38C1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994032; cv=none; b=psyZhdWDn1DFzc1Yc56hOyVGrelEuHWotAMMcR6QrKTmtE21Hf4CcmR+EwrIeaoK8inU6T6bI2WYDetwO+DQEZUqBcTDcPHID6iAsZ9bfUn++OXj7dOCo5dWTdozePGmRyeMySYBpWHLuqQKddaHICOaKIWsjkqTSLvfJG+177c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994032; c=relaxed/simple;
	bh=y6+jU1nkaFCJb5CtmFh3MI53xVH1yh3eKGITi0k/9LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auLll5OIR3MBOk+61LkMIvWsCS3lp99CTXOmNuhKWVs5dfbtuBCeBeqO4rNbXLhIWdjOPrPOq+msdJc8kYvZRpUkJcU1z5y6f6rJ+lKs0AjnaD0CIOlc4t2xdleH4BSwl060IDcT+ryMNHfvXwVOqbjSjtb4580/RJ2sLQRYnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNFgVEMU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso10191288e87.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994028; x=1726598828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=BNFgVEMUrrUw+DTwLSdTf6aVKnD/iQPqEEpty9XdxukjUc4oN09IUCjC/cnT9ILW49
         upVUNwz40JNKZbh2ovIr5LuQQRE71z0dtGLqjknmvv6juU9JScHO12a8lEY+93v+cFeI
         VScB0Q8CpXz5/c8UUYz6HojVTwgf2cY+5MfPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994028; x=1726598828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=Lx+zwMMJSlxr3LcQm+uFkPvXcCMmIq+51CgDMMuS7Mew9BAWuZ84bOWhi0W/uKyNmo
         fDJegKRdJn6m9eyH9Jb/PEOf5XErfQq+bEJ9cVLEdnwbT70Exxl61Zqy3g3mQDoMOmXz
         nbwPcQT5Wfe7VYoGsZlq6KDlyPM2nCWfXX9Am/IbAkIdfRZzAi4DYaEe6j3LWWlp7H6n
         vkcUxxhfmOZgRWCAmo95diDx4B82g5/TZPtubAFJhIy+MslFY18CWpuhJq5dka99W32m
         wfRKAopySZ1rzR3zuU286ejNdXeNN/aM05Mk4JB71EO6FxYCEnCShhr6c5PeDjLUTleU
         mrXA==
X-Forwarded-Encrypted: i=1; AJvYcCWCU4Rjh8ZD4aLWU0dV/WfcVHMW8DN9QMi9oJxLeSd89a8BPyy5NmmP+zqc/jy/aZgM0h+W1pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0m8IrGs1xcLbix8E6uFP3AYDM3z/2VKKHBEMqeOY38LTBpx8/
	dVXIrbNxe95QQJUdAeu7+/qQkX3Djt7EWFpxOiXlxavrHvzncsk20ZIo63R/8yZxbd4775p6Pfe
	9oWNOqw==
X-Google-Smtp-Source: AGHT+IHvGK0lK5g7Nz83t4yQ1VrwzeUgZB20oJC8Z151xwghpjf3eWw8UHGxXnzk9+U9K2Z23043pQ==
X-Received: by 2002:a05:6512:39d3:b0:533:4505:5b2a with SMTP id 2adb3069b0e04-536587b95dfmr13299117e87.28.1725994027762;
        Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25831875sm521551566b.11.2024.09.10.11.47.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so2878812a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiBhOqqgzvypPE32hgp5ZFoLnI+5858ICxBkk11GRb3zz5VrCL7anFOdeSdYaHI1pCM/ukGFw=@vger.kernel.org
X-Received: by 2002:a05:6402:26c9:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c3dc78b469mr11458506a12.11.1725994026812; Tue, 10 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org> <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
In-Reply-To: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:46:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jens Axboe <axboe@kernel.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org, cassel@kernel.org, 
	handan.babu@oracle.com, djwong@kernel.org, 
	Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 11:38, Jens Axboe <axboe@kernel.dk> wrote:
>
> Curious, does your init scripts attempt to load a modular scheduler
> for your root drive?

Ahh, that sounds more likely than my idea.

               Linus

