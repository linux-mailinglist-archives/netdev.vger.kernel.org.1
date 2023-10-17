Return-Path: <netdev+bounces-41722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD67CBC45
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465FC281409
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C3A18B1A;
	Tue, 17 Oct 2023 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE48KTM5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83A747B;
	Tue, 17 Oct 2023 07:32:53 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B593;
	Tue, 17 Oct 2023 00:32:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58962bf3f89so494845a12.0;
        Tue, 17 Oct 2023 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697527971; x=1698132771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdztVy4CXH6kUCFsFARk6VsKQ6Jj/+IFMkgv+HYDI18=;
        b=YE48KTM5eG5xWwQxkXMuoiCoU07QP4WBmzR0TuA5tZdPEq4+5BMtxYymy0XSjOCbBl
         pMDJB7klVOkpZuDMZqz8eHN1R60hESjrtRkvA263IBTT/mFTlw1wDg3vs9GQyNB+jEVa
         cm7/193qgji1a9yM/7OXc554+XMj1FDdL9aZWIGKh3W1T10lvic4Q5VF5zZs2AXZ8UtT
         bLfVbR+0uXUMn1t4gyCCFysOTupWcSaPmPhBbgcdrviPOvKdtRDcDYou5R1gxr+ZqYly
         hkQGJ3806LzJxa1/Rc/mjWG6DmUe4ZtgKgOQpWGNyIrEr4duEs1WfhS+Yq5C3UkjhHVp
         Xv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527971; x=1698132771;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdztVy4CXH6kUCFsFARk6VsKQ6Jj/+IFMkgv+HYDI18=;
        b=uqOAXv5/uCvVUqwiFleFVdmjRXFXwBCaOhFxBK2I3jNrkOSJFZbVTD6XjUXblFXI0f
         6GtNGU8XFgGWtiQoSTn50u6csJqKulqpfUqYpvei/TdFXEc935ds4kycc05Qi7AnBcjA
         pZv/bj1q37iKohI4F+zSpDtvlkAlB4X0zbJt4+s9mJirAIZoYgsQ+Stz4Nrm76gs7D06
         FXcbZRQlMKuDFXYRwMTv/5bd4MW23gt/ywsppnYtwvK7ziGpaUgmhlLn5ieGBYRkUQ3B
         eFL+nCYaYWeADor/x/drXWe9qFYxlTOGD24rP9ZfosHjuTTbeRklSGSfWlOpXLMA1LsB
         sdCg==
X-Gm-Message-State: AOJu0YwEULobiFFDI0ZcOam5p04soV+NlCSpOeY2IcAY8Xtu0uQ9fqi7
	C502iyGa0sM/3UpaPvJyFsg=
X-Google-Smtp-Source: AGHT+IGo0BKqz0AoaYvhK3EsBI2NdSHTquCFwfppkth39MFX3gAOP9k+ewmoz4cOiZBGOa5A16/6og==
X-Received: by 2002:a17:90b:38cf:b0:27d:32d8:5f23 with SMTP id nn15-20020a17090b38cf00b0027d32d85f23mr1548855pjb.2.1697527971087;
        Tue, 17 Oct 2023 00:32:51 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a030700b00279479e9105sm6424810pje.2.2023.10.17.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:32:50 -0700 (PDT)
Date: Tue, 17 Oct 2023 16:32:49 +0900 (JST)
Message-Id: <20231017.163249.1403385254279967838.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
References: <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
	<20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
	<98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
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

On Tue, 17 Oct 2023 07:06:38 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 15.10.23 00:39, FUJITA Tomonori wrote:
>> On Sat, 14 Oct 2023 17:07:09 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>> btw, methods in Device calling a C side function like mdiobus_read,
>>>> mdiobus_write, etc which never touch phydev->lock. Note that the c
>>>> side functions in resume()/suspned() methods don't touch phydev->lock
>>>> too.
>>>>
>>>> There are two types how the methods in Device changes the C side data.
>>>>
>>>> 1. read/write/read_paged
>>>>
>>>> They call the C side functions, mdiobus_read, mdiobus_write,
>>>> phy_read_paged, respectively.
>>>>
>>>> phy_device has a pointer to mii_bus object. It has stats for
>>>> read/write. So everytime they are called, stats is updated.
>>>
>>> I think for reading & updating some stats using `&self`
>>> should be fine. `write` should probably be `&mut self`.
>> 
>> Can you tell me why exactly you think in that way?
>> 
>> Firstly, you think that reading & updating some stats using `&self` should be fine.
>> 
>> What's the difference between read() and set_speed(), which you think, needs &mut self.
>> 
>> Because set_speed() updates the member in phy_device and read()
>> updates the object that phy_device points to?
> 
> `set_speed` is entirely implemented on the Rust side and is not protected
> by a lock. Since data races in Rust are UB, this function must be `&mut`,
> in order to guarantee that no data races occur. This is the case, because
> our `Opaque` forces you to use interior mutability and thus sidestep this
> rule (modifying through a `&T`).

Understood.


>> Secondly, What's the difference between read() and write(), where you
>> think that read() is &self write() is &mut self.
> 
> This is just the standard Rust way of using mutability. For reading one
> uses `&self` and for writing `&mut self`. The only thing that is special
> here is the stats that are updated. But I thought that it still could fit
> Rust by the following pattern:
> ```rust
>      pub struct TrackingReader {
>          buf: [u8; 64],
>          num_of_reads: Mutex<usize>,
>      }
> 
>      impl TrackingReader {
>          pub fn read(&self, idx: usize) -> u8 {
>              *self.num_of_reads.lock() += 1;
>              self.buf[idx]
>          }
>      }
> 
> ```
> 
> And after taking a look at `mdiobus_read` I indeed found a mutex.

Yes, both read() and write() update the stats with mdiobus's lock.


>> read() is reading from hardware register. write() is writing a value
>> to hardware register. Both updates the object that phy_device points
>> to?
> 
> Indeed, I was just going with the standard way of suggesting `&self`
> for reads, there are of course exceptions where `&mut self` would make
> sense. That being said in this case both options are sound, since
> the C side locks a mutex.

I see. I use &mut self for both read() and write().


>>>>> If you cannot decide what certain function receivers should be, then
>>>>> we can help you, but I would need more info on what the C side is doing.
>>>>
>>>> If you need more info on the C side, please let me know.
>>>
>>> What about these functions?
>>> - resolve_aneg_linkmode
>>> - genphy_soft_reset
>>> - init_hw
>>> - start_aneg
>>> - genphy_read_status
>>> - genphy_update_link
>>> - genphy_read_lpa
>>> - genphy_read_abilities
>> 
>> As Andrew replied, all the functions update some member in phy_device.
> 
> Do all of these functions lock the `bus->mdio_lock`? If yes, then you
> can just treat them like `read` or `write` (both `&self` and `&mut self`
> will be sound) and use the standard Rust way of setting the mutability.
> So if it changes some internal state, I would go with `&mut self`.

They hold mdiobus's lock and update mdiobus stats. They also change
some internal state in phy_device without touching any lock (it's safe
since PHYLIB guarantes there is only one thread calling a callback for
one device).

I'll use &mut self for them.

Thanks a lot!

