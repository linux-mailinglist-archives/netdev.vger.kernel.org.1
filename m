Return-Path: <netdev+bounces-130040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96513987C65
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8F28388C
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353AA932;
	Fri, 27 Sep 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWHowdN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5931EC5
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400042; cv=none; b=gLBmnw9iuEeaTEqg0OKb5yNozhkAa29K6Y1+cuByHfQVADcvpnZsJFjcpAq8XW/ETs8K4bugmPbR+2M9erL77B1g2I67d3SZMQ1xYeLvgAUYOJ3zrau+HCP2GKkxGbjDp31o2sWPtntEG2ATbqgajhs35+6EWoGGSiJRv3VlJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400042; c=relaxed/simple;
	bh=WZb57WsOrLvMUtRfEiS84nJIHqi9ipFgXhil39XfDZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuL3II5shEp8qbeO9M6/o4j/6/1S+I2nfrhyEku/c9OOnnhpmip09ulpVtuykwphukITfelc9C2+doz2rttcTtyMhzIRidMqdCi02+mk5M8IaYRSdJHNJAcTLjXxbSYwUlatyKvVefy6Z62li1/fHr+LZu+icKFSkfpbvBnd3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWHowdN0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20551eeba95so15602655ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727400040; x=1728004840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vms/PsmUpNKijuwPLUV+VSmuFcdB2RQ0yx9yN3sZ71Y=;
        b=GWHowdN0g56RU8scUu/yfFa4hNFLCYIKpCm0Vcf566lDoaCvw6QIQlfu1dfbVdb0Ml
         cGOmycvXwhnYZL5ONOsQZdmzevy3/x00Q1EWG9OI6YtoG2DPBEqAK3FA2eMBDPN4NjzI
         jzh35dcoOUIczwE5UTFybgeGBa3PWvaxggyR+p+x2fUNJmEJtt8VpyprMlw5vcVu9m4T
         Q2KMgPmnAwE5P2xPKRGXVrziwf/y1qZtnsfnNXZUWSeIuZlUVCpsdXUZPpI+95jWtbi3
         pH99AJ2V4/DItWlFyRH65CT/XawdWhJWn8HF0DQwMFqaGLtTtbM0mfVKRB4YVTK0YyHH
         a2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727400040; x=1728004840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vms/PsmUpNKijuwPLUV+VSmuFcdB2RQ0yx9yN3sZ71Y=;
        b=VX2g4LKXuu8KBdMF8LOPh6w52NatlFQgtZfDAuGmhWU44NzcqnnzTWvRxbRnMav0mE
         JNcl+jNIaZQemnx9hKZmr1HEfobi65KsRduLMkT79pxrVpbx1jdOnYNOgeaabEMgtsVW
         mITd//FHPtNXczL348WnhtcOnCE0EK+G2D3OWrcAa7IrrAqZ5VV4CaIPylXYUe2PPRJX
         0mMm/CUvQIAxgQerNhqRidlEiYcPp5WQXWO/XxdrwR9UjKLFk/TRj+aapuBOxm6yrb3+
         IsoqId/lBQyO36IflvV8GLQOQQn7nlK/SS7nplRYiTFM2SrKCaMVgq4BI34Or8+4oiWf
         fruQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfqdhmUXS5Nil20zep4nhjaQq5XJqKMn+vgjb+A9bzH1yB9fzePYUQ7rvyO7OznMMNAg2ribw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hJsL7bKHo8csFuT2Vdgfn4NnWaopikfY55NkT+DOD2oDq/oz
	EOahcaHcDVjNv0GYeMdmYkMcrkvnWHwbwIOFdYIRckRPPsfHzfI=
X-Google-Smtp-Source: AGHT+IFvD96TS2AH2QBsA3O7gB5T0zy7QVZcy03d40napg/yxWtV643P+C/BngnnQo5llD5Zcuidzw==
X-Received: by 2002:a17:902:e945:b0:202:371c:3312 with SMTP id d9443c01a7336-20b37a538ddmr23684555ad.40.1727400040061;
        Thu, 26 Sep 2024 18:20:40 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4cddfsm4044655ad.224.2024.09.26.18.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:20:39 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:20:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 11/13] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <ZvYIZpgBMe0wMouL@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-12-sdf@fomichev.me>
 <CAHS8izNKzuNX-nttnucfVioOt4PuMOfq0h=5W5=30jouP_2qvA@mail.gmail.com>
 <ZuNhYn7wlXddLWiO@mini-arch>
 <CAHS8izPL4-PgSQit6Nhhf=4YXzKX5SkK7T+K-Q07yQ7xBVRxzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPL4-PgSQit6Nhhf=4YXzKX5SkK7T+K-Q07yQ7xBVRxzw@mail.gmail.com>

On 09/26, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 2:47 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 09/12, Mina Almasry wrote:
> > > On Thu, Sep 12, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > Use single last queue of the device and probe it dynamically.
> > > >
> > >
> > > Can we use the last N queues, instead of 1? Or the last half of the queues?
> > >
> > > Test coverage that we can bind multiple queues at once is important, I think.
> >
> > Anything against doing this in the selftest/probe part?
> >
> > if (probe) {
> >         if (start_queue > 1) {
> >                 /* make sure can bind to multiple queues */
> >                 start_queue -= 1;
> >                 num_queues +=1;
> 
> Sorry for the late reply, this particular thread slipped my inbox.

So what's better? Hard-coding start_queue and num_queues to 8?
This is only for the purpose of self testing, not sure we really care.
 
> Overriding user-provided configs here doesn't seem great. It's nice to
> be able to launch ncdevmem requesting 1 queue to be bound or multiple,
> and I had the idea that in the future the tests can be improved to
> verify that multiple concurrent connections on multiple queues can be
> handled correctly, in case we run into any bugs that can only be
> reproduced in this setup.

Currently, having multiple queues doesn't make any sense because there
is only a single receiver. I have some patches to have a thread per
receiver, can post them if you're interested (after we sort out this
series).

