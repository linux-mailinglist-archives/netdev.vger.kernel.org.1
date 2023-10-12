Return-Path: <netdev+bounces-40237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E6E7C65D3
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B311C20AD2
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A739DDA3;
	Thu, 12 Oct 2023 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo/9Htps"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC8D296;
	Thu, 12 Oct 2023 06:44:47 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B643BE;
	Wed, 11 Oct 2023 23:44:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d132d92cso1872045ad.0;
        Wed, 11 Oct 2023 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697093085; x=1697697885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ga4Q/Y3kVOuu6Ya+naTso0WutyUgJECcjkKOh6bx8A=;
        b=Bo/9HtpsbNv6Ed8WForjMtclzOpusr4+CMdkG68oX46Vg0bOOIosStTKzDudw4t7Xm
         b8qvKKByjKxRL9I7hFqD+BfMx6846e6CyyXfcxWyD1YZgQBP/sFGv2jxFnygma+eevgP
         KQOvEv3Vj2iNRX5k3v9iYzolooW/xzhboqoFt1ydRbwyvD5yKh1qLMPrDG21hlwMh3Ca
         FcvrESapcx0WpYlVg4A20DOlA40RtDC24wBvtu4yzs6rwVqmg9zDi77AsCiacOCMFzII
         ACWOpqGqPhzIiI9GHht/bhqwhhaQw6xs65f7e2NYqNJeR1OWKFHjGwMfQinQV4sp90Jz
         0N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093085; x=1697697885;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ga4Q/Y3kVOuu6Ya+naTso0WutyUgJECcjkKOh6bx8A=;
        b=ebgZxRHuw6EGp4O28GBRRtiE+Q1T4winI10nbmm5Myg3NRNlYX9SF1zCe2ipQ0fs3p
         pL5hIpU7TlFIy8uvpfyVFeLSWWnZdW5ByjL+u/zIApkchvgdDgMpMQoRhAA7BK2gtvRZ
         nb3ez1axy5V9tgWXsoL34+675W4GxLgYLWKipxo8fURqo+cbmIMo0v/rsebJTpHz4zlt
         QwnyoTmgwqiJB/07srYiuTT8Xml6QQe2w2FmdEqCcIp+qlCI2TRBCHO074Jfdk1QRl6t
         flk7mb2OOY+JSaEyIuenB9lvA/DqmuHTd7QH+/1BP80p+hs75+Svb2pcyLJC/NhJWWs4
         wLdQ==
X-Gm-Message-State: AOJu0YxoxkcuEX7Yj8/9Surlfc9pXJcsIgFWkeBuq8y5pvg5V0O4yUcK
	HA3egqJu7ZXf5ZeQaOmq1t0=
X-Google-Smtp-Source: AGHT+IEYwFzMnV9sAo2dHBliVcXeNv7wEWSINUpi56AmsnGm+dHz1Iza6MM5+26OTvSa573eB9jEUw==
X-Received: by 2002:a17:90b:1bce:b0:27c:ebab:5c60 with SMTP id oa14-20020a17090b1bce00b0027cebab5c60mr6573206pjb.2.1697093085325;
        Wed, 11 Oct 2023 23:44:45 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001c9db8f9e36sm1054081pld.232.2023.10.11.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:44:45 -0700 (PDT)
Date: Thu, 12 Oct 2023 15:44:44 +0900 (JST)
Message-Id: <20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZSeTag6jukYw-NGv@boqun-archlinux>
References: <ZSbpmdO2myMezHp6@boqun-archlinux>
	<20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
	<ZSeTag6jukYw-NGv@boqun-archlinux>
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

On Wed, 11 Oct 2023 23:34:18 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Oct 12, 2023 at 02:58:24PM +0900, FUJITA Tomonori wrote:
>> On Wed, 11 Oct 2023 11:29:45 -0700
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> > On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
>> > [...]
>> >> +impl Device {
>> >> +    /// Creates a new [`Device`] instance from a raw pointer.
>> >> +    ///
>> >> +    /// # Safety
>> >> +    ///
>> >> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
>> >> +    /// may read or write to the `phy_device` object.
>> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> >> +        unsafe { &mut *ptr.cast() }
>> >> +    }
>> >> +
>> >> +    /// Gets the id of the PHY.
>> >> +    pub fn phy_id(&mut self) -> u32 {
>> > 
>> > This function doesn't modify the `self`, why does this need to be a
>> > `&mut self` function? Ditto for a few functions in this impl block.
>> > 
>> > It seems you used `&mut self` for all the functions, which looks like
>> > more design work is required here.
>> 
>> Ah, I can drop all the mut here.
> 
> It may not be that easy... IIUC, most of the functions in the `impl`
> block can only be called correctly with phydev->lock held. In other
> words, their usage requires exclusive accesses. We should somehow
> express this in the type system, otherwise someone may lose track on
> this requirement in the future (for example, calling any function
> without the lock held).
>
> A simple type trick comes to me is that
> 
> impl Device {
>     // rename `from_raw` into `assume_locked`
>     pub unsafe fn assume_locked<'a>(ptr: *mut bindings::phy_device) -> &'a LockedDevice {
> 	...
>     }
> }

Hmm, the concept of PHYLIB is that a driver never play with a
lock. From the perspective of PHYLIB, this abstraction is a PHY
driver. The abstraction should not touch the lock.

How can someone lose track on this requirement? The abstraction
creates a Device instance only inside the callbacks.

