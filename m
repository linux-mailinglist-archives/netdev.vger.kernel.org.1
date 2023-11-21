Return-Path: <netdev+bounces-49481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10827F227E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F208C1C20C2E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7A715AD;
	Tue, 21 Nov 2023 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJQjkoTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780FCD;
	Mon, 20 Nov 2023 16:50:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc4d306fe9so11403715ad.0;
        Mon, 20 Nov 2023 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527799; x=1701132599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbqZwvuZom4sESncBEzYjtUHVZxnsYl9ipIsl/NCNBg=;
        b=eJQjkoTtppdMM7pS6gu82BrGJytYzNN8MmoR1CgOY1RMmjkUHgCBG5xcKsZKVuFlQ5
         l00/FKVtKRNLcoUcKPXQMRkqtcgN/l4O1LrCb+90tiaJGFw08rbCje2mAKaVrWpopxcP
         5llyzPzCswhRHqpDjfo3tyqG1gcPMH3z9afH29Q+Hz6wPPd6PwdksAdx6E5hKRS5F/ZZ
         FSi5BgwoiLjOl9uAux5FPwkvdeDSoAAn3X3erqiWMf02DLEyiQFH9YIa8X1HjtrjwEd7
         48JqYN9/4G/Ha+SXBXi9ddlpLRjUPJOOmOPlUwxUfCezfXu73s2KB97JG/y7dmJpr9l5
         z6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527799; x=1701132599;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MbqZwvuZom4sESncBEzYjtUHVZxnsYl9ipIsl/NCNBg=;
        b=UvsBjIRPT+qmT+N02phw7j1o35sbvHWS/HW2mrsTsEQfxjoU0csaMXIjp0Hjv0Uvuj
         +pDOFWZGTz1tbo2x3qTw/a7r54N6DJBj4kwQCUIBzGSVMKd/TqZcrwmy3/6D46mj+DSj
         nEnPvuXPN56VspUtviNaqEMF6Qqu4Ta60XabGNCnPmIfepXRZNbocjUpMM4yg7qYlQVl
         VXxyA2d4Ji8d0vx9mUkoKkkstiE3McY+xBFM2gReZ9ML8OjbLFAuemNp4U91B66bixcr
         8Av8c/qHMnGl64hZ4Xyiov3ecSBvVdsDvHCFZJc/Kz5HTkhrXEtDKXoWS0dT88umbDcd
         ODKw==
X-Gm-Message-State: AOJu0YwQrHXxp7bZs/STVhcQvhbOTmrYnwZjWeSoDQ5QGObDIExKTMBg
	8u66EPy+grhg+C0b0JPtkrU=
X-Google-Smtp-Source: AGHT+IGhmknLKKf9tYTrbfn4KYe95Xf2dukvdMABI6+8e1yV8zp15KPM1QOJFaXggMGkeIQmHxQwRw==
X-Received: by 2002:a17:902:ecd2:b0:1ca:28f3:569a with SMTP id a18-20020a170902ecd200b001ca28f3569amr11685236plh.5.1700527799266;
        Mon, 20 Nov 2023 16:49:59 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001bb97e51ab4sm6675596pls.98.2023.11.20.16.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:49:58 -0800 (PST)
Date: Tue, 21 Nov 2023 09:49:58 +0900 (JST)
Message-Id: <20231121.094958.1954120205224730676.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <bfee014a-617c-49de-9344-b7d511cdf58f@lunn.ch>
References: <8f7a7fe0-bfd3-4062-9b55-c1e18de2818a@lunn.ch>
	<20231120.225453.845045342929370231.fujita.tomonori@gmail.com>
	<bfee014a-617c-49de-9344-b7d511cdf58f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 15:13:23 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> The Rust ax88796b driver doesn't export anything. The Rust and C
>> drivers handle the device_table in the same way when they are built as
>> a module.
>> 
>> $ grep __mod_mdio /proc/kallsyms
>> ffffffffa0358058 r __mod_mdio__phydev_device_table [ax88796b_rust]
>> 
>> $ grep __mod_mdio /proc/kallsyms
>> ffffffffa0288010 d __mod_mdio__asix_tbl_device_table	[ax88796b]
> 
> I checked what r and d mean. If they are upper case, they are
> exported. Lower case means they are not exported.
> 
> My laptop is using the realtek PHY driver:
> 
> 0000000000000000 r __mod_mdio__realtek_tbl_device_table	[realtek]
> 
> Also lower r.
> 
> Looking at all the symbols for the realtek driver, all the symbols use
> lower case. Nothing is exported.
> 
> Is that what you see for the ax88796b_rust?

Yes, all the symbols for ax88796b_rust use lower case.

