Return-Path: <netdev+bounces-56149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DC80DFAA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9737282529
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE55676D;
	Mon, 11 Dec 2023 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egZjUNAW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41BCF;
	Mon, 11 Dec 2023 15:47:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d03f03cda9so9345595ad.0;
        Mon, 11 Dec 2023 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702338475; x=1702943275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lDFED6MIXV48nkTgVwdV8fjzHg24YTh/pb+stEfbPE=;
        b=egZjUNAWymiDPIxDbQLBJjs3NZ1xp2fuVIGYtL9WyLSiewpKbl8atuVdoKxtggVbS/
         ZB4vxxcE2CbF7wZ6l76PVyGFUqDL7aa9IcNmFMeIoIm4j/lF9ZMagpPtnQIz32Kaz5CQ
         yJcAJThf5DBrPUx1LNcgl4ttLOZqQPZ8icCUFcOzU8vYqsSloQ1xndUZTSZNiByi7Ska
         RGiMjYxCyEPQLbb9mmg9QH3x/ln0Vy8XvCcczhRi/lcBy28xtXJIUUYbBAeffReiuCJe
         KPAKbo4aU8zM+wWkk9I+sOZ2lqGlnpUdDpLBTHJtyKUdTtkLIm3Hi+O/KHo+WORlrR0R
         37bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338475; x=1702943275;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lDFED6MIXV48nkTgVwdV8fjzHg24YTh/pb+stEfbPE=;
        b=UU9neynjFaJj1ikG0Ol+Pw1eDkqw2fcU0UWVQPgdMEEarNuQO6DrZKlLiIHzqWkQSe
         yoEUbW9RSw6UBbxFADjnhpNeZ6UBdczRJNR9OidrhlmPUIeuW/Izv+wzkRWV3KLG0Cms
         3pMX2xztxLM/b6pJEiSPjiC2qWs7WYBGV5Uc76EwAUc9Emv7j6pxFbUaZNrIBuH/sl5e
         Finfh4jOhOINSlNVfVjKvqbQdRGrw5s94qd6CGQJS26uz4+Qyc9LaBObC3Y8h6hXwrFU
         9TrvsKlZvc5/jvW53zv2GPcKYdmmLN4LZB4hu2n/DOwGYlw1PBXvQnsGQW1jg6kuc7u9
         /+Ag==
X-Gm-Message-State: AOJu0YwRsIP0tjxRJBurjGUe23SV0TDTq79MkVNYEG0eqpssRnU6raj9
	4WpBDkXK6ec/MYCpfySFuFw=
X-Google-Smtp-Source: AGHT+IErGnmE987NqHbCaqdzNlpa85YI5WEhzyfIo2P3KReyNpv194C4zZqqVwyHPkhylZYchmJV6w==
X-Received: by 2002:a17:902:ee81:b0:1d0:5efd:35cf with SMTP id a1-20020a170902ee8100b001d05efd35cfmr9723922pld.4.1702338474722;
        Mon, 11 Dec 2023 15:47:54 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001d0b7c428d5sm7205959plg.104.2023.12.11.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:47:54 -0800 (PST)
Date: Tue, 12 Dec 2023 08:47:53 +0900 (JST)
Message-Id: <20231212.084753.1364639100103922268.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, alice@ryhl.io, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZXed8cQLJhDSTuXG@boqun-archlinux>
References: <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
	<20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
	<ZXed8cQLJhDSTuXG@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 15:40:33 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Dec 12, 2023 at 08:15:05AM +0900, FUJITA Tomonori wrote:
> [...]
>> >> +    /// Reads a given C22 PHY register.
>> >> + // This function reads a hardware register and updates the stats so
>> >> takes `&mut self`.
>> >> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
>> >> +        let phydev = self.0.get();
>> >> + // SAFETY: `phydev` is pointing to a valid object by the type
>> >> invariant of `Self`.
>> >> +        // So an FFI call with a valid pointer.
>> > 
>> > This sentence also doesn't parse in my brain. Perhaps "So it's just an
>> > FFI call" or similar?
>> 
>> "So it's just an FFI call" looks good. I'll fix all the places that
>> use the same comment.
> 
> I would also mention that `(*phydev).mdio.addr` is smaller than
> PHY_MAX_ADDR (per C side invariants in mdio maybe), since otherwise
> mdiobus_read() would cause out-of-bound accesses at ->stats. The safety
> comments are supposed to describe why calling the C function won't cause
> memory safety issues..

(*phydev).mdio.addr is managed in the C side and Rust code doesn't
touch it (doesn't need to know anything about it). What safety comment
should be written here?

