Return-Path: <netdev+bounces-40245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71F7C6615
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C73282777
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF4DDD8;
	Thu, 12 Oct 2023 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLe4dQTa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A120DDBA;
	Thu, 12 Oct 2023 07:02:49 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F4D90;
	Thu, 12 Oct 2023 00:02:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d935dbc2so130758b3a.1;
        Thu, 12 Oct 2023 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697094167; x=1697698967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9xtlar/nRfoDD6ODeqntbdmD7fbN/NHgdOPY0nCaiw=;
        b=YLe4dQTaoPiaKMBE6KIb3FXl3A9ExzZe+UlChYkuiF3MrnggjtE2JHji+bNDPnUTKh
         YkiSWuuSThW+bWD4TqUlStccwYYovL/53+PhV+ME/JCQk/rFcP4eiieAqMcpYv7sFSr+
         SDc5R7miMqjZgN/pnYEB+Ku3SeyLvrk9mEWSHQQBzHx6BMeix2gxvF9HVmnvYEyhRdft
         MyOStv1pCnmEm0kBDZGYvpSFV71owh+4hNSQ27Dsomjw6sl2sypq2BTEOZNmc6+pnEM9
         8SX5nvtV75TZvCNS3rnCMmNoQOeaWHwqDgozKr5Gu3lfy6+Sn4YrG1GVOszygi847bOr
         qEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094167; x=1697698967;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9xtlar/nRfoDD6ODeqntbdmD7fbN/NHgdOPY0nCaiw=;
        b=Zy2HZn/WV1cmqIdQuWpuTlaSrHo6jKUXViVvYkBEHHEez1Q2uabzYn5NSlntobxeqp
         G+2vCrJHWKjPNut7lZCeTItXqHGoKBJ1umAESNj/gKbYJTC8/jyB1EOEPjo1yRN5cZk7
         U24uXJbWZMO49o168L9CwrdC6ld/0Dww1zvYjhFGfJHv6omfdEwAwQ+yBDmpMQ5JBvMB
         nXfGis5y/sE6X5LIpjAtaS0Klm0bS6pSWLcNXTwlNRtfY6XMf2gsTba4Utkxv5QMIQmd
         P74HYVnDhSZsLDePfsWhY/bB4GIEmzjneEGd4sfv9XVsv0Kq8Bi+JA8Z1ByDfK0bFFmP
         314A==
X-Gm-Message-State: AOJu0Yw8lkOviTA7Oyt+nqdUwzF1ggnfDTNPfYSGw57vNOTgv4UlXuCa
	g5/ocVi7BQsb+2dbmTJcWZefQQ4/gftxnV9o
X-Google-Smtp-Source: AGHT+IESKCINNRFTr6epMNOn7HbTnlBwfUoinvMKB9QxVjI/cSz3NJzSmqLdYT+dkEc+GvKptlw3Jw==
X-Received: by 2002:a17:902:d2c1:b0:1c1:fbec:bc32 with SMTP id n1-20020a170902d2c100b001c1fbecbc32mr26018373plc.6.1697094167517;
        Thu, 12 Oct 2023 00:02:47 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001c63429fa89sm1125314pln.247.2023.10.12.00.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:02:47 -0700 (PDT)
Date: Thu, 12 Oct 2023 16:02:46 +0900 (JST)
Message-Id: <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com>
To: fujita.tomonori@gmail.com
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
References: <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
	<ZSeTag6jukYw-NGv@boqun-archlinux>
	<20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 15:44:44 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Wed, 11 Oct 2023 23:34:18 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
>> On Thu, Oct 12, 2023 at 02:58:24PM +0900, FUJITA Tomonori wrote:
>>> On Wed, 11 Oct 2023 11:29:45 -0700
>>> Boqun Feng <boqun.feng@gmail.com> wrote:
>>> 
>>> > On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
>>> > [...]
>>> >> +impl Device {
>>> >> +    /// Creates a new [`Device`] instance from a raw pointer.
>>> >> +    ///
>>> >> +    /// # Safety
>>> >> +    ///
>>> >> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
>>> >> +    /// may read or write to the `phy_device` object.
>>> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>>> >> +        unsafe { &mut *ptr.cast() }
>>> >> +    }
>>> >> +
>>> >> +    /// Gets the id of the PHY.
>>> >> +    pub fn phy_id(&mut self) -> u32 {
>>> > 
>>> > This function doesn't modify the `self`, why does this need to be a
>>> > `&mut self` function? Ditto for a few functions in this impl block.
>>> > 
>>> > It seems you used `&mut self` for all the functions, which looks like
>>> > more design work is required here.
>>> 
>>> Ah, I can drop all the mut here.
>> 
>> It may not be that easy... IIUC, most of the functions in the `impl`
>> block can only be called correctly with phydev->lock held. In other
>> words, their usage requires exclusive accesses. We should somehow
>> express this in the type system, otherwise someone may lose track on
>> this requirement in the future (for example, calling any function
>> without the lock held).
>>
>> A simple type trick comes to me is that
>> 
>> impl Device {
>>     // rename `from_raw` into `assume_locked`
>>     pub unsafe fn assume_locked<'a>(ptr: *mut bindings::phy_device) -> &'a LockedDevice {
>> 	...
>>     }
>> }
> 
> Hmm, the concept of PHYLIB is that a driver never play with a
> lock. From the perspective of PHYLIB, this abstraction is a PHY
> driver. The abstraction should not touch the lock.
> 
> How can someone lose track on this requirement? The abstraction
> creates a Device instance only inside the callbacks.

Note `pub` isn't necessary here. I removed it.

No chance to misuse a Device instance as explained above, but if we
need to express the exclusive here, better to keep `mut`?

