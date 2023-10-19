Return-Path: <netdev+bounces-42467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C07CECE6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6921C209C2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808D38D;
	Thu, 19 Oct 2023 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmXMP/4y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCF38C;
	Thu, 19 Oct 2023 00:41:50 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1B0115;
	Wed, 18 Oct 2023 17:41:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b390036045so1222529b3a.1;
        Wed, 18 Oct 2023 17:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697676108; x=1698280908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYnilDjHoPuUF5aYegr0iG9VgVec34Vh/+0lNHw8/zs=;
        b=CmXMP/4ymEI2qmmfNXmvJ0m/6XHjiNA4fWEGFtjrgeaMKbMYiBkXmohlvoGqHcgOkA
         fW+c2JpTrizytQXlVUPpCafTup5IflYkW5yC0btsUXRYS8/QCWmwgtf2QmCyBc/7nruk
         jNfQnHpWpyULBwWYKTOnHQkW1ypJHHGIM4PCKODDlGcWIR1Bq0lPWjgME4S5OE99O8Wa
         SwTxHcCehzwt+wRTcuyOysOmPMZ0CE342QausFdblx9bucDSa6ar+PLgajk1NsVXoJmq
         uI/s1IJxq1FRYNBuA/lJG48R7kWTOBgnu4EqpA4vR9uFAIktdo4yBUHAhoQKI0aAXp/S
         0h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676108; x=1698280908;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xYnilDjHoPuUF5aYegr0iG9VgVec34Vh/+0lNHw8/zs=;
        b=Tc3/jICBuWcV3Su1PxGv+Bsz2nAkX1Nka/ERxgyAjd5CR7I7oQWwCa62Kc+w26nP4R
         80tIpnhoQ4+WRlLq3lEWbOKpviog73QFmRckRFjyF6hqnXx29UX2tPUh72bSx8+06WCG
         ev8YOQkc3siTAASgZUTauu1lPKiQG6lVB+331DRFc9n3SVHwi5AWpOR6wW2cx5cC7PL5
         qBg9l/44QpVBX9yBDm6S/WN8hxMiNjsrrexrk4GlLm9xJ8SHLjh1WciGpThqFZp3oRXx
         zKjSxQvO0LRTtVpAkjEMFnB0o5FuNbvqIrTeanLp1CgvJpOit88oJ5CBa67O8yQml61O
         jzyw==
X-Gm-Message-State: AOJu0YxLZHI90dahaR9QZiHhaGyTQuyFcEoDGQjiJwAuS2QYAmiZwrnV
	bqJjDb9xDEAL7DskBZymBHM=
X-Google-Smtp-Source: AGHT+IHuhIIm3Sb5smbcYLBmb1wD289fqTDhfUqTNOe0ZZ6KFbvH10xe2Q+BMpBVNmLfvQx9VF5xTQ==
X-Received: by 2002:a17:902:c994:b0:1bb:9e6e:a9f3 with SMTP id g20-20020a170902c99400b001bb9e6ea9f3mr891382plc.4.1697676108183;
        Wed, 18 Oct 2023 17:41:48 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001ca21e05c69sm538258plg.109.2023.10.18.17.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:41:47 -0700 (PDT)
Date: Thu, 19 Oct 2023 09:41:47 +0900 (JST)
Message-Id: <20231019.094147.1808345526469629486.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
 benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
	<20231017113014.3492773-2-fujita.tomonori@gmail.com>
	<de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 22:27:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +    /// Reads a given C22 PHY register.
>> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        let ret = unsafe {
>> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
> 
> If i've understood the discussion about &mut, it is not needed here,
> and for write. Performing a read/write does not change anything in
> phydev. There was mention of statistics, but they are in the mii_bus
> structure, which is pointed to by this structure, but is not part of
> this structure.

If I understand correctly, he said that either (&self or &mut self) is
fine for read().

https://lore.kernel.org/netdev/3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me/

Since `&mut self` is unique, only one thread per instance of `Self`
can call that function. So use this when the C side would use a lock.
(or requires that only one thread calls that code)

Since multiple `&self` references are allowed to coexist, you should
use this for functions which perform their own serialization/do not
require serialization.


I applied the first case here.


>> +        };
>> +        if ret < 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(ret as u16)
>> +        }
>> +    }
>> +
>> +    /// Writes a given C22 PHY register.
>> +    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So an FFI call with a valid pointer.
>> +        to_result(unsafe {
>> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
>> +        })
>> +    }
>> +
>> +    /// Reads a paged register.
>> +    pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
> 
> From my reading of the code, read_paged also does not modify phydev.

__phy_read is called so I use &mut self like read().

