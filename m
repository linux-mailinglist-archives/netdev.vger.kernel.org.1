Return-Path: <netdev+bounces-41899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B796B7CC1D0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7661C20C31
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452D41AB7;
	Tue, 17 Oct 2023 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOOlEA8N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADF41AA0;
	Tue, 17 Oct 2023 11:32:41 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6042F1;
	Tue, 17 Oct 2023 04:32:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so572196b3a.0;
        Tue, 17 Oct 2023 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542359; x=1698147159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlG4425ZJG56gASWrCiVxtWOAmHEutELCv8uyCjBQSs=;
        b=GOOlEA8NwL1Nsa4kmE7jkUf1vz4Jsehve+VrxBYAXD8Zh+7kQnGWY2l+fAn4aWhbCs
         w8lZkCAAlh/RRaMB1mYCnMagxCTs0lJp/wgoBNs/gk5axuDCfBomE4LXYNC3RHZgts73
         tnqM8OthtQJLa0K6VoJ+7pZ0OSdjuOGDFu+pKjf7cxplmbG9jI+RSTYVyl5AA6WlkcGM
         1479jARNz1d0BNH5PrRWBrCnPEPd9kNjYP5ck9Fj3LRqzT1lJuXxMblfmHlWjzzZW4t3
         kmZAabboLIVULRHymxV38XW3uoVfZYoAVZvIKOuPCoaZim0PzNuFGvAOmmGH5/2eVHw+
         FOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542359; x=1698147159;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dlG4425ZJG56gASWrCiVxtWOAmHEutELCv8uyCjBQSs=;
        b=C9DdyHIy1IR2apIBLmYyxw+l8AgEArcnw+rVatUlKHafTpwBXQtUagWoIqBJl83zyQ
         XW0vsluD0lW9JIoGNdTyWteN2TnJq/9ciV+ybaFF+ieTa4LPRs8oQIu3jqnVTpuXeWJ5
         nwjCQi1ouzIHA/2i8m97qxVK098DKrBOhXl1951dL+8yEBNZXzsySJsIlEAwXF3jedpC
         km7fcqbmY+w5wBljykyXVBjGEIYuWzbzpllE7tSciSbago7QZ5T6+ZOBCrh28A4/zFjG
         LrzxbX7Cd2bGcvZ6ZzLBnSdjEGIE8Jkhj+aKE8Z+BtUJBbm2asb4l0j469pHiOI94PKD
         9Rcg==
X-Gm-Message-State: AOJu0YydGBUr4cNa3Z3WVx1SHDfS3SF/wVVNj7s7Ar4l2Zrc5b6M0ZPL
	3KZNIlghuG6PHsjB38LyHpCVyaXI5Q2Eica0
X-Google-Smtp-Source: AGHT+IHaB9K6PBuYVdOjK9j+ll1LRK2eAgXDkaljTn51kkAEsDlCsg8t/vP1TMSU9sBgf/YaNchFrw==
X-Received: by 2002:a05:6a21:81a1:b0:16e:26fd:7c02 with SMTP id pd33-20020a056a2181a100b0016e26fd7c02mr1566969pzb.2.1697542359307;
        Tue, 17 Oct 2023 04:32:39 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jh13-20020a170903328d00b001c0de73564dsm1299261plb.205.2023.10.17.04.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:32:38 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:32:38 +0900 (JST)
Message-Id: <20231017.203238.979167277269755650.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <cad79d65-4c66-4344-b0b4-93d2cbf891af@proton.me>
References: <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
	<20231017.163249.1403385254279967838.fujita.tomonori@gmail.com>
	<cad79d65-4c66-4344-b0b4-93d2cbf891af@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 07:41:38 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>>> read() is reading from hardware register. write() is writing a value
>>>> to hardware register. Both updates the object that phy_device points
>>>> to?
>>>
>>> Indeed, I was just going with the standard way of suggesting `&self`
>>> for reads, there are of course exceptions where `&mut self` would make
>>> sense. That being said in this case both options are sound, since
>>> the C side locks a mutex.
>> 
>> I see. I use &mut self for both read() and write().
> 
> I would recommend documenting this somewhere (why `read` is `&mut`), since
> that is a bit unusual (why restrict something more than necessary?).

I added such at the top of the file.

