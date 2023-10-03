Return-Path: <netdev+bounces-37577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC57B60E8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 95721281773
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04AC6120;
	Tue,  3 Oct 2023 06:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AF111E;
	Tue,  3 Oct 2023 06:40:55 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6E93;
	Mon,  2 Oct 2023 23:40:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c61c511cbeso603125ad.1;
        Mon, 02 Oct 2023 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696315254; x=1696920054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjGbCrfKtnTYmFnkLKUc39blLiDt4a/sHwZZcrca8fs=;
        b=Ix6uSejXYVVzehU2liptvObFWWCIPF3+ZSzQT2CfWGHJPg6R9C3NQ6+/dNC9gdu+9w
         Yzho1Y9MB62z2W85tPHwF+HnGhfwDYfZ86dLpBF5No5LqOvNxsA8I4UNhQM8YGMPQtK3
         RjeDeDWFZqytPaKM+gT/NJqAUf1mBbvfVfavHufZR4dIqWX3pyiaQf7oWjJaclXq6Qdd
         ljtKo+iq9rw8HnGJlIT15Y4Z+reFCbD+AKARQXVJM+kXie4CleGLVlSCowB1zJxmqFdJ
         DsrcoRX822mtjoXQyh1F+ct6KnKOb+liIQjJwDouyfoda57r3rslpdqV/ttJVD/MVlzf
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696315254; x=1696920054;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AjGbCrfKtnTYmFnkLKUc39blLiDt4a/sHwZZcrca8fs=;
        b=b0GWFTol5mv7IALE8LOr5vPT8z/Gz8GltitfLHgZSlMMkhyLmHzdoHczWOhbG5dpaB
         Mo8VDZEYioOFcONIBJ4TUebTIwhtRMFTPwid4X+Jcvsr+0D5kNkldSAWmtQwHfoWMAyB
         xaaVCzGcf5zbd4TltXRbJf2CraxGz3fOSbg0MRu3LD4/xlJC81rRLVdv0O7F44J99EWo
         ukBDruiFKqHtAlUCr1zZd36QzzmTeWqgRXA+WzqkvZOrKNBPD8pJyQ/nf9r+XUmbie3q
         0yddsBj6jyaNPF74kzTDc+id1puWJ+Ls2hbI1yp9Dpd+u9EyQCJg0QxiLSLb2dbDxpAy
         psRg==
X-Gm-Message-State: AOJu0YwlQdrYp9weZj0qINL9H7J/1ayLNIM6N1/Qy2KVewMHEc4cnzx4
	x7ugxzvIaxXmMPx80aBpx3j7JH74oXyj+4+r
X-Google-Smtp-Source: AGHT+IFYvIjiwytQH9QKoqTFfQv15PStp5eVUOI2A6Z11F2F9Kx/tqQbRicdCfLJ5HFhF+0b8v2RKQ==
X-Received: by 2002:a17:903:41cd:b0:1b8:9fc4:2733 with SMTP id u13-20020a17090341cd00b001b89fc42733mr15706301ple.3.1696315253599;
        Mon, 02 Oct 2023 23:40:53 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001bf8779e051sm602519plr.289.2023.10.02.23.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 23:40:53 -0700 (PDT)
Date: Tue, 03 Oct 2023 15:40:52 +0900 (JST)
Message-Id: <20231003.154052.1399377054104937782.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100317-glory-unbounded-af5c@gregkh>
References: <9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
	<20231003.124311.1007471622916115559.fujita.tomonori@gmail.com>
	<2023100317-glory-unbounded-af5c@gregkh>
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

On Tue, 3 Oct 2023 08:31:38 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Oct 03, 2023 at 12:43:11PM +0900, FUJITA Tomonori wrote:
>> On Tue, 3 Oct 2023 03:40:50 +0200
>> Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> > On Tue, Oct 03, 2023 at 09:33:38AM +0900, FUJITA Tomonori wrote:
>> >> On Mon, 2 Oct 2023 16:52:45 +0200
>> >> Andrew Lunn <andrew@lunn.ch> wrote:
>> >> 
>> >> >> +//! Networking.
>> >> >> +
>> >> >> +#[cfg(CONFIG_PHYLIB)]
>> >> > 
>> >> > I brought this up on the rust for linux list, but did not get a answer
>> >> > which convinced me.
>> >> 
>> >> Sorry, I overlooked that discussion.
>> >> 
>> >> 
>> >> > Have you tried building this with PHYLIB as a kernel module? 
>> >> 
>> >> I've just tried and failed to build due to linker errors.
>> >> 
>> >> 
>> >> > My understanding is that at the moment, this binding code is always
>> >> > built in. So you somehow need to force phylib core to also be builtin.
>> >> 
>> >> Right. It means if you add Rust bindings for a subsystem, the
>> >> subsystem must be builtin, cannot be a module. I'm not sure if it's
>> >> acceptable.
>> >  
>> > You just need Kconfig in the Rust code to indicate it depends on
>> > PHYLIB. Kconfig should then remove the option to build the phylib core
>> > as a module. And that is acceptable.  
>> 
>> The following works. If you set the phylib as a module, the rust
>> option isn't available.
> 
> That does not seem wise.  Why not make the binding a module as well?

Agreed, as I wrote in the previous mail. But Rust bindings doesn't
support such now. I suppose that Miguel has worked on a new build
system for Rust. He might have plans.

