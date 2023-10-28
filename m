Return-Path: <netdev+bounces-45010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759957DA7F7
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435BBB20D5E
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55BBB673;
	Sat, 28 Oct 2023 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5WBOI+w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DE621;
	Sat, 28 Oct 2023 16:09:08 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18EEE5;
	Sat, 28 Oct 2023 09:09:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc2b8deb23so2186825ad.1;
        Sat, 28 Oct 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698509346; x=1699114146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaFutZklZ5J6ueY8yFA2VkTidgqQ1/VkltlZwyCj5lI=;
        b=b5WBOI+webTOIaDIkZYZbDTfVuCy4/yUfQaD1e/pUcxXbVuqRUH9gJEkbJSokSmP2k
         gv1n69QgL0YSAi0yyMrGzjCkmbknpdAPEDPF2mdJNr58vOXPcMBTRR3iZ3vrhB2mLU0g
         Xhv97St4o0YUKlQ/NLXbF/dDP+HJlyBiYyRkgWcPbECy/2q9HFvStO6czBqr0Cyb7yCx
         DWmLkqTzoJ/1isCipday6PXDdo2L/oarsd8a9N0oLC/9WTJHk0hMFFMPA7/KqN9p3ESM
         K5kl5ZwsOiyadt9Q757/OjR0CebrYUqz66mDbHf9cA6o3upn6B1KL5WM5kMIo2MWJunG
         tXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698509346; x=1699114146;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aaFutZklZ5J6ueY8yFA2VkTidgqQ1/VkltlZwyCj5lI=;
        b=RxXFdKKbMQVzjCkMKamUqMvTbQgDkLLFOXQVnveUlEof3empFtNuHbMzlDtKe320OF
         gKGpEDggi+OewrLly9FfqQlhAVrxJWvEY34EsWLw2iJpUEH8k2NDcQFIBOfQePnlarHn
         6q8GBQWOELkMOz5XPLO/GnXqGhl0IRJJejQPl1eJar6N+eA7r8v96eEwTAag31h8fIAK
         5mh8V6bwjcyyw+1k5afUXtIM97M59/4gccEgS1Ce6fzDljAIectnXU7KT64Ch8crOAMH
         ynDt8JluvDlBBtFpb5eUGQBU0RGO2lM7MEisMNlsoKinU60qVdXTDMB84E1OxnnKuAlE
         PjrQ==
X-Gm-Message-State: AOJu0YwwCABe0u+5Ho3PvsztHLisoLGds3h5BCVgmskt0N7hXS3IN0Vf
	XQuQsQcPDOuF/tARgHxOVxs=
X-Google-Smtp-Source: AGHT+IEKeSFDsxRs8kE9JCgGRJYgG0rtYrLqUCWEMtscrVK2+KoAULri4PJ5Ba903X49HQ4DtiKSSQ==
X-Received: by 2002:a17:902:e2d4:b0:1c9:e121:ccc1 with SMTP id l20-20020a170902e2d400b001c9e121ccc1mr5871602plc.5.1698509346289;
        Sat, 28 Oct 2023 09:09:06 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902724c00b001b8b2b95068sm3378348pll.204.2023.10.28.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 09:09:05 -0700 (PDT)
Date: Sun, 29 Oct 2023 01:09:05 +0900 (JST)
Message-Id: <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
References: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
	<20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
	<f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 28 Oct 2023 16:53:30 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > We need to be careful here, since doing this creates a reference
>> > `&bindings::phy_device` which asserts that it is immutable. That is not
>> > the case, since the C side might change it at any point (this is the
>> > reason we wrap things in `Opaque`, since that allows mutatation even
>> > through sharde references).
>> 
>> You meant that the C code might modify it independently anytime, not
>> the C code called the Rust abstractions might modify it, right?
> 
> The whole locking model is base around that not happening. Things
> should only change with the lock held. I you make a call into the C
> side, then yes, it can and will change it. So you should not cache a
> value over a C call.

Yeah, I understand that. But if I understand Benno correctly, from
Rust perspective, such might happen.

