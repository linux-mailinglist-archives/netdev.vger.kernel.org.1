Return-Path: <netdev+bounces-40733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52977C8885
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AED1C20B2A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3011B285;
	Fri, 13 Oct 2023 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFck7BDE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18011CBC;
	Fri, 13 Oct 2023 15:24:34 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576495;
	Fri, 13 Oct 2023 08:24:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b390036045so143682b3a.1;
        Fri, 13 Oct 2023 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697210673; x=1697815473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ7WtNZgjJSfgroBq05/3lEy3OCT+o06OPhmA0hgBIc=;
        b=AFck7BDEg0phkkqqa2higBa0h2jL6AdBbxcRjHdWHTu5mVNqBlUXAQOBZJtosTUIew
         cSZK9yjv0QNvNTHjY+paRDdx8tyV52tDtsVuUPlabiNQjU8NEGjSMm0vSX1RO0FUHnLe
         h85DxI65866BQFrZMBCGx+RBF2mKx2A5MEWwnsFSCvBv4LOaAcrxDhMHPIKCifSpnRW9
         dEYZN5nXQJk30bwV+GmQOTX/5ybTwfVczy8ZH6+siwOOEl7cYJjL88GHwFk7zIWbtGqS
         jnB2Xy53EWxIPOMMMRvONyM6jBHGAZO0sm892+01UeXlDBNq0MfB++11pyXMYJtzmXNn
         1f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210673; x=1697815473;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZ7WtNZgjJSfgroBq05/3lEy3OCT+o06OPhmA0hgBIc=;
        b=bcOqRrg0CEfR1AZQf3izgNahe11JDjjCYMgiMe0HTls7akF0CX2uX7WyWOnmR4qIac
         91xoiyGe2/pURQqMSjdVb0aEvUB57wDLYclkFBYF9O4CzQFtEbs2pPKQ/Q45+gN5z+40
         8WTbgY3KeURljPQi1Lt8ic9eScQhc6DH/O21L0mdF7wwdSbGHfI1tzQmcWU2oJo3kanx
         SKkkhvicpssZmSFfUK0jgnLLc3psauB/bmVJe9260drJAAq1SjyjzlpSH2th45frd64U
         c39G/ezDM3EUNxBzTgXYX3CbhUTHtisGDzd8nhx2KR7Taywan4IxZmUbtZHGBagsLJ4B
         +nzA==
X-Gm-Message-State: AOJu0YzXLpSk+in7uZvNjm9qRNtUO8dY72vtT64+3IzDzaMX9HpBFYKL
	0hwwB4iV+Oq/sbPiFhQDbGI=
X-Google-Smtp-Source: AGHT+IEDwRSCENxA6vvv9qakmKKACYcjq4csulFjlk6rTgC3YwarSrpnFC06czSC06jHOdQNrGjDnw==
X-Received: by 2002:a05:6a21:a5a0:b0:15d:a247:d20c with SMTP id gd32-20020a056a21a5a000b0015da247d20cmr35517768pzc.6.1697210672228;
        Fri, 13 Oct 2023 08:24:32 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001b7ffca7dbcsm4000851plf.148.2023.10.13.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:24:31 -0700 (PDT)
Date: Sat, 14 Oct 2023 00:24:31 +0900 (JST)
Message-Id: <20231014.002431.1219106292401172408.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, wedsonaf@gmail.com,
 benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions
 to the ETHERNET PHY LIBRARY
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
	<20231012125349.2702474-4-fujita.tomonori@gmail.com>
	<ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
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

On Fri, 13 Oct 2023 07:34:40 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Oct 12, 2023 at 09:53:48PM +0900, FUJITA Tomonori wrote:
>> Adds me as a maintainer for these Rust bindings too.
>> 
>> The files are placed at rust/kernel/ directory for now but the files
>> are likely to be moved to net/ directory once a new Rust build system
>> is implemented.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 698ebbd78075..eb51a1d526b7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7770,6 +7770,7 @@ F:	net/bridge/
>>  ETHERNET PHY LIBRARY
>>  M:	Andrew Lunn <andrew@lunn.ch>
>>  M:	Heiner Kallweit <hkallweit1@gmail.com>
>> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>>  R:	Russell King <linux@armlinux.org.uk>
> 
> Since Trevor has been reviewing the series and showed a lot of
> expertise, I suggest having him as the reviewer in Rust networking, of
> course if he and everyone agree ;-)

There is no such thing as Rust networking :) This is PHYLIB entry.

If it's ok with the PHYLIB maintainers and Trevor, I'm happy to add
him.

