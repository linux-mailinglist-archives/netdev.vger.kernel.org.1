Return-Path: <netdev+bounces-37849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F77B7573
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 091BB281741
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3191D41205;
	Tue,  3 Oct 2023 23:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44177405FF;
	Tue,  3 Oct 2023 23:46:49 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280CCE;
	Tue,  3 Oct 2023 16:46:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so336722a91.1;
        Tue, 03 Oct 2023 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696376806; x=1696981606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcUqE9dhnpdkwEWc5/UR4jpA7Ne7zxjZBrKq9/qJDLI=;
        b=l4DFQ55mWBJuFItyOL3/4rnU8X+wyqno+pBD7UeHNhrluU6/l0mmakdRk/eq5vAvh1
         Upyl3H6uZAwftiNyDwgROvB4aY6p5wIhHcbfRDNCGJ6AtZjBVkBkLQULKeNU/b5vISo1
         YxQQYE+ObhEiEcSXxA2STh3e6ja+/EyIMr/AtLaJbhZF+8L9FEzG6NgepAcoXB3HK1gi
         xoOy84t1NSt/5UMzxdO4V1Nhf7k9cQdd4YVUZIdNBeH7p9wgZ6aBONOOAn5qVvDInac+
         Ra+XcI9YcNK5Z0yQJz7WxvXWNtS52qzDsWWuysqu3V979nIwRduA/BKV24LXgpdOZUDz
         ckgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376806; x=1696981606;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XcUqE9dhnpdkwEWc5/UR4jpA7Ne7zxjZBrKq9/qJDLI=;
        b=FLVdM/Hky0PzcClyImJic8mFDYD7Ng93yo9wB1vBZOp1AL4opHdgoNFgTt/XjAsKmJ
         3S+iSEDsOPjSGUyThloS1C0dVpDJNTOLhakjMcKbqCoqKargtcK//rN0So8loYkNDU+B
         ko99ZHLZ04KV27Rk7c0usj8b7sVJ8ktF/BEbxLkGzqbQBBW+kPSHPR3LMxO+Gf1icvb0
         /vdHjQMOvFgKZvPS10bm7qHwwbLmeLNgrJ6UeDQqJLpRY+i+Hf1hMsOCeBWzolbXEK7q
         kV34a02e1Df91ULTCvYC2hXyaAh6GzUeXG8gYNdKmMJ0UNqXDWkD4CCU/6x5sExc6zpK
         4Gcg==
X-Gm-Message-State: AOJu0Yxg3k6Rzq5Kxqfq1T5vNY9iFlaCks75M/bk4/uragwc4AKhpQq/
	3k0bzOcQYQ1Oo7abmBQALz4=
X-Google-Smtp-Source: AGHT+IGrLTvuZgp8KW9UzovnRWv62G03DvpZRnl+aeBq4Yn+OVUnaPIzMaC/717ZyRsq+wRJZOepHw==
X-Received: by 2002:a05:6a00:3916:b0:68e:2fd4:288a with SMTP id fh22-20020a056a00391600b0068e2fd4288amr1023151pfb.3.1696376805803;
        Tue, 03 Oct 2023 16:46:45 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78d09000000b00690c2cd7e0esm1932954pfe.49.2023.10.03.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:46:45 -0700 (PDT)
Date: Wed, 04 Oct 2023 08:46:44 +0900 (JST)
Message-Id: <20231004.084644.50784533959398755.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <c0c00289-3bb3-4091-be78-8616e2ba90ee@lunn.ch>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
	<20231002085302.2274260-2-fujita.tomonori@gmail.com>
	<c0c00289-3bb3-4091-be78-8616e2ba90ee@lunn.ch>
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

On Mon, 2 Oct 2023 17:24:17 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +    /// Gets the id of the PHY.
>> +    pub fn id(&mut self) -> u32 {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).phy_id }
>> +    }
> 
> I somewhat agree with GregKH here. It will be easier to review and
> maintain if the naming of well known things stay the same in the C and
> Rust world. So phy_id. However....

phy_id() is fine by me.

The complete type name is `net::phy::Device` so I guess that the
method names usually don't start with `phy`. But we maintain both C
and Rust so I think that we need a balance between them.


>> +    /// Gets the state of the PHY.
>> +    pub fn state(&mut self) -> DeviceState {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let state = unsafe { (*phydev).state };
>> +        match state {
>> +            bindings::phy_state::PHY_DOWN => DeviceState::Down,
>> +            bindings::phy_state::PHY_READY => DeviceState::Ready,
>> +            bindings::phy_state::PHY_HALTED => DeviceState::Halted,
>> +            bindings::phy_state::PHY_ERROR => DeviceState::Error,
>> +            bindings::phy_state::PHY_UP => DeviceState::Up,
>> +            bindings::phy_state::PHY_RUNNING => DeviceState::Running,
>> +            bindings::phy_state::PHY_NOLINK => DeviceState::NoLink,
>> +            bindings::phy_state::PHY_CABLETEST => DeviceState::CableTest,
>> +        }
>> +    }
>> +
>> +    /// Returns true if the link is up.
>> +    pub fn get_link(&mut self) -> bool {
>> +        const LINK_IS_UP: u32 = 1;
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).link() == LINK_IS_UP }
>> +    }
> 
> Naming is hard.
> 
> This one is trickier and shows a difference between C and Rust. C just
> does phydev->link and treats it as a boolean, setter/getters are not
> needed. But Rust does seem to need setter/getters, and it is a lot
> less clear what link() does. get_link() is a bit more
> obvious. has_link() would also work. But as GregKH said, get_foo() and
> put_foo() are often used to represent getting a reference on an object
> and releasing it. I am however of the opinion that many driver writers
> don't understand locking, so it is best to hide all the locking in the
> core. I would not actually expect to see a PHY driver need to take a
> reference on anything.
> 
> Since we forced into a world of getter/setter, the previous one
> probably should be get_phy_id() and we want consistent set_ and get_
> prefixes for plain accesses to members without further interpretation.

get/set_something names aren't commonly used in Rust, I guess. Some examples
follows in the standard library.

https://doc.rust-lang.org/stable/std/net/struct.TcpStream.html

there are set_linger(), set_nodelay(), set_read_timeout(),
set_write_timeout(). correspondingly, linger(), nodelay(),
read_timeout(), write_timeout() are provided.

https://doc.rust-lang.org/stable/std/io/struct.Cursor.html

There are set_position() and position().

As I wrote above, I don't think that we need to follow Rust naming
practices strictly, as long as there are patterns in Rust bindings.


>> +    /// Returns true if auto-negotiation is enabled.
>> +    pub fn is_autoneg_enabled(&mut self) -> bool {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).autoneg() == bindings::AUTONEG_ENABLE }
>> +    }
> 
> Should this maybe be get_autoneg_enabled()? I don't know.

I think that we can leave this name alone since tis_something() names
are used for OS related functions in Rust.

