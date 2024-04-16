Return-Path: <netdev+bounces-88298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480C8A69CD
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13658B21752
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35B129E8A;
	Tue, 16 Apr 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbSmZU52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612912883A;
	Tue, 16 Apr 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267645; cv=none; b=lyhYpEJexTYSnW4Bxuu1mEbo/weQGcpHmvNpdxAF7J2CYjvFDkwlaEMGdHEIT4aXIpZvraKbINXZU3tsVVYmU+hNycACjueLvksH1tdGqel3EYk84qh1wyLSZI8T6/HSrS261cn2dAhKHHKaK1+oTPPyzh9dekSmv/HvaM83Ezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267645; c=relaxed/simple;
	bh=3VtSKxuv+1qS0wmMVAOum07FDATDvk15aJ1S6BYLmhA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mTqd7OSPNQE8mqAmFO7JwgkFJuCECmhaTJm3RQAJxB/PgtuBw9Po3Uss5WNb6rzFa3WV+6xGy00ftTuLH858lBSl350Ztecfnw6WNmQeUq6juqBaI81nb5JnZyeCrpcNZ4/kU3KWdawaWF6+UtcVKTo3RsdoD8iwN3FEMWXSGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbSmZU52; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e45f339708so7490315ad.0;
        Tue, 16 Apr 2024 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267644; x=1713872444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODu1iiX3pT8i2zdeQxtu7wDKMDr6vALv/AqQUtSOwu0=;
        b=DbSmZU52YFOIXde+nsL57Nl6lszqsb6v7uzs0AtlDsoYO5lZpwS5A7VYRnMaLcY8tB
         Ja+TS4gPutbpenY+Hbx4XiL+uXqAHgUpHQLl7DKfbrpjIHOGpLN8q0j5isyYpoQN8oQP
         QYTjrM8XQQ8TfhlZzJS33htJtLfCIIh2AztmGJJdBlkh3GvBW06R76oZHE1Nd6F0nQK6
         Xur2pVX0aE1TeDLcyfRvwZNvKfglbQUdHZ5e059hejBXZf6LdtmnTUDNyuEn1zSju9Li
         QN6o9jd8QEqbjMNG4vfW/wb5yRPblCPz79Gaj8OwHTjrYp54TkpJfzk+1KgdLl0hQAey
         pqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267644; x=1713872444;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODu1iiX3pT8i2zdeQxtu7wDKMDr6vALv/AqQUtSOwu0=;
        b=bHBwAyMsbdqZUwc5pwKU4wknn9DSw3Nbb9TuDTl1bRnqyYU1HXWKlNcvub4o7aE6gn
         2L9BN/MU6RwzA5DzGtPd+NnBIzt5QIBycvW7v32lNV/gkHNvuVN74nFKJfMfAcGPgikh
         B1sxdyXm9SXvN6ukQOIds1podF7Nt0pf5BNMkHvzboaZ5ZU8HKcob2O+rIR7ShZ+4H2k
         u+72yEOvNiEiWWIePbUtOB9XAd5PVtoeFZC7RKY3bGTtqQOY6xw+ooXZmUoBHah40jcP
         BNUtCV4s2f0NYQUCR4antCKcg88zUch77myYomrpJnUflbFH7Zyb9OxUEdz9XT+sVo0T
         xb/A==
X-Forwarded-Encrypted: i=1; AJvYcCVrfzWo9fkwtW8TAqZ1rYPV4WoQbiGT/T/e1OMqKhO4eSdDHx9jLYy5p8bybaxAKhWY2s8qL9XegMyrpHtUx+BZVj79sJ81Z1exLAA5OYpK5ucXZBpmofExqs8rBZGpUR9KpQPiDt4=
X-Gm-Message-State: AOJu0YwCEwJN5D/pr1hQ4668rmrDoUXfArCtcq89nugsyxdo+nXbqZz6
	lESfdN5jEVgDCTpFWMZ3+u4Ipsd6B2Ngkygpvi6JVpAg4o065V9t
X-Google-Smtp-Source: AGHT+IGrTyV6EAI58R4mzM1vGINWdfDbdBMiSmNj/EoDbT2wN8Sj2IFutZpvuHF3ph0jAWgrP65vww==
X-Received: by 2002:a17:902:e845:b0:1e0:c887:f93f with SMTP id t5-20020a170902e84500b001e0c887f93fmr16323453plg.1.1713267643784;
        Tue, 16 Apr 2024 04:40:43 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001e77d1e6b64sm3243726plh.241.2024.04.16.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 20:40:30 +0900 (JST)
Message-Id: <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
	<20240415104701.4772-3-fujita.tomonori@gmail.com>
	<e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 16:20:16 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +    /// Reads a given C45 PHY register.
>> +    /// This function reads a hardware register and updates the stats so takes `&mut self`.
>> +    pub fn c45_read(&mut self, devad: u8, regnum: u16) -> Result<u16> {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        // So it's just an FFI call.
>> +        let ret = unsafe {
>> +            bindings::mdiobus_c45_read(
>> +                (*phydev).mdio.bus,
>> +                (*phydev).mdio.addr,
>> +                devad as i32,
>> +                regnum.into(),
>> +            )
> 
> So you have wrapped the C function mdiobus_c45_read(). This is going
> to do a C45 bus protocol read. For this to work, the MDIO bus master
> needs to support C45 bus protocol, and the PHY also needs to support
> the C45 bus protocol. Not all MDIO bus masters and PHY devices
> do. Some will need to use C45 over C22.
> 
> A PHY driver should know if a PHY device supports C45 bus protocol,
> and if it supports C45 over C22. However, i PHY driver has no idea
> what the bus master supports.
> 
> In phylib, we have a poorly defined phydev->is_c45. Its current
> meaning is: "The device was found using the C45 bus protocol, not C22
> protocol". One of the things phylib core then uses is_c45 for it to
> direct the C functions phy_read_mmd() and phy_write_mmd() to perform a
> C45 bus protocol access if true. If it is false, C45 over C22 is
> performed instead. As a result, if a PHY is discovered using C22, C45
> register access is then performed using C45 over C22, even thought the
> PHY and bus might support C45 bus protocol. is_c45 is also used in
> other places, e.g. to trigger auto-negotiation using C45 registers,
> not C22 registers.

Thanks a lot for the details!


> In summary, the C API is a bit of a mess.
> 
> For the Rust API we have two sensible choices:
> 
> 1) It is the same mess as the C API, so hopefully one day we will fix
>    both at the same time.
> 
> 2) We define a different API which correctly separate C45 bus access
>    from C45 registers.
> 
> How you currently defined the Rust API is neither of these.

Which do your prefer?

If I correctly understand the original driver code, C45 bus protocol
is used. Adding functions for C45 bus protocol read/write would be
enough for this driver, I guess.

