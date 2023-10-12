Return-Path: <netdev+bounces-40230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4E7C64F8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DBC282697
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 05:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC061D274;
	Thu, 12 Oct 2023 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATchAQjv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A7613F;
	Thu, 12 Oct 2023 05:58:27 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C07A9;
	Wed, 11 Oct 2023 22:58:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-58974d4335aso87755a12.1;
        Wed, 11 Oct 2023 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090306; x=1697695106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug1h0skf15+cGkmSkcuzFhPPkKdfgImJKZvK9a+wJB0=;
        b=ATchAQjvfm1sOmpzVXdVEF0Bvp6xGHP4SiBOh5ppCwjdmTVthh8GoyMqt+lDlVtWKB
         7lHZUkyiI2ZRtXE9qDeotTjtqse2i+DtsE8qZwsKvliPAcCdL5T93FUN4u6nLNHNSj4Z
         r13oMk41GC8l0QAkiI80cRqpEMvv9TCjrWEwW/Z3lTTe7xVpyCnc34OL9m7sOB6RLp8B
         x0uEULux5UDMf0pG9HGHnOl0BaHIeKI/yv9BifRPy4/2YDJHjHtIZJHkuuc6gNM5Y9nH
         zohKyv4MtaQMMnbLNYp+bvVR80mAcrb3DhXQnlCR38nqODCiKT7y3r6X3xhCKV/JAEIZ
         TeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090306; x=1697695106;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ug1h0skf15+cGkmSkcuzFhPPkKdfgImJKZvK9a+wJB0=;
        b=kSxAEbE8BrtJbFWWRzHrTNHIF0kWqHu1fAW4xK27I/p9ZMh4ctXRQ6D/aZcZV/q2E5
         3Co5ZRR/zq5nqLamyx9lHyGpoOIMQISG3nLA6A2blybMyd+OQc+/zGZUx/mBvypA7KI/
         fJVOtteGUmRNjRb8EbnWudTm8yBsr8Zb/hd57whMbRTi6PS/1fK19Px56ylof/Z1g/nS
         bZIUJMzHesmbSdsEVLkpmEz2u5BSnZEBQL51Xhqe3iJlts6nK2a5DZbfX1seWQIJ3qeE
         eRBrCDsvVTqZp77DV+OsCIdEJpydlzVylJpY8Q+wQeKaL+Hee1qNwdCnHgHL31vCkCbF
         BpRg==
X-Gm-Message-State: AOJu0YxMFttSpxCHtwmsJN4mef84YqrjZxlQHt3K69VkHPWnSUhN3BWm
	0KofUOhz/meeauTQK5HmbCk=
X-Google-Smtp-Source: AGHT+IGHjf+1I8rQToNR8D4ACZst6+yzZAMqzRu9uJYfHD04APlbAdtCCwgFoR6pUG6/dlZRfYbCRw==
X-Received: by 2002:a17:902:d2c1:b0:1c1:fbec:bc32 with SMTP id n1-20020a170902d2c100b001c1fbecbc32mr25904024plc.6.1697090305810;
        Wed, 11 Oct 2023 22:58:25 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001bb99e188fcsm941268plh.194.2023.10.11.22.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:58:25 -0700 (PDT)
Date: Thu, 12 Oct 2023 14:58:24 +0900 (JST)
Message-Id: <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZSbpmdO2myMezHp6@boqun-archlinux>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-2-fujita.tomonori@gmail.com>
	<ZSbpmdO2myMezHp6@boqun-archlinux>
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

On Wed, 11 Oct 2023 11:29:45 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
> [...]
>> +impl Device {
>> +    /// Creates a new [`Device`] instance from a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
>> +    /// may read or write to the `phy_device` object.
>> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> +        unsafe { &mut *ptr.cast() }
>> +    }
>> +
>> +    /// Gets the id of the PHY.
>> +    pub fn phy_id(&mut self) -> u32 {
> 
> This function doesn't modify the `self`, why does this need to be a
> `&mut self` function? Ditto for a few functions in this impl block.
> 
> It seems you used `&mut self` for all the functions, which looks like
> more design work is required here.

Ah, I can drop all the mut here.

