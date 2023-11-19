Return-Path: <netdev+bounces-48996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D54B7F0503
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2306280DEC
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17863C9;
	Sun, 19 Nov 2023 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh8HqPd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ADB126;
	Sun, 19 Nov 2023 01:41:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc2b8deb23so7555505ad.1;
        Sun, 19 Nov 2023 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700386883; x=1700991683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0YOOzCeHOkHnjBxk/6+Zbt5VlA3U+GtXUO1n8YqClc=;
        b=Zh8HqPd2de4ibzBX3uwm6qyi9peGlh02n3i2T2nTqU0mGpKiUGeLWU+MT3lKwDRPG1
         3Yc1BhTFDie7n2dgD9jm3DVPtNQdZvHtpUwnLW1SPkti7a2UJ+vXbxeCZhPn4nFl+2B4
         rl+hqervs3vRsEV48HAIN63t8BN3jOxbKU15MXBjemKnp/yVFTcC9KMY0r2SyJke8DHz
         2WxNHNnxtGwi6fbUSHPbffqDkCtQVWxm7UW8ukBEiJIoJk+WptJGu2aCXdWN/OaoGbUa
         n5vEOGHnAg1Ye58SrztmjQTMfmqg5tbf9ZBb4PsxCv3goGcigCT33r9Cojh/HizPprne
         IfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700386883; x=1700991683;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d0YOOzCeHOkHnjBxk/6+Zbt5VlA3U+GtXUO1n8YqClc=;
        b=dglBnwGfFa5TkOYe0cRZbK8rr6AFv8JRbB45Sqjv4XywSCEjL9pTRTckhqBO6cMkxh
         UPr06KcsZLE2rSr2JO/F1ZycJswK3HJRU/P4WDUel4L9I4Rc9rZTB+mZMf3OjJouDk1g
         NCHBCXufPmBjG8u5n7k3Bf3BIRDXYPNyeHZ6U871/yCjHPWPQp+RYY0aoSkhbz8ZLBBz
         J4M2eCjyccIHNTpEBWw18EyGU8AUcoHeQyPYx4+LrxEgXdWpgNLpiSnvD7Fn0j5OWK2c
         VVIg+prtPd/dXnP1c8zZZuMHQr9v6ya1FUWq0ZQdMt2VBkqxRFfVKOfV79bPWGfqAlSs
         O++g==
X-Gm-Message-State: AOJu0YxmV32fr7Db8lpPE8tgor4etTpIaBnBjUS1uUy3Gmqp5YKWfi8X
	GQq5D3Q9o8mB1qTF4ydIYes=
X-Google-Smtp-Source: AGHT+IG9wM3aJoCK2JMOxR9ryAP7vo0piv5e0lp+ySFjIh5Wx5bq313/q8QCMkGxunzCxKbKrrQm2g==
X-Received: by 2002:a05:6a20:8e26:b0:16c:b514:a4bc with SMTP id y38-20020a056a208e2600b0016cb514a4bcmr6350733pzj.4.1700386882703;
        Sun, 19 Nov 2023 01:41:22 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id c20-20020a056a000ad400b00690ca4356f1sm4111266pfl.198.2023.11.19.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:41:22 -0800 (PST)
Date: Sun, 19 Nov 2023 18:41:21 +0900 (JST)
Message-Id: <20231119.184121.1885944108829358122.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: benno.lossin@proton.me, boqun.feng@gmail.com,
 fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <73cb9332-3e5a-493a-8ae1-227a2ea58eb3@lunn.ch>
References: <66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
	<7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
	<73cb9332-3e5a-493a-8ae1-227a2ea58eb3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 00:18:10 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> But `#[no_mangle]` is probably a special case, since in userspace it
>> is usually used to do interop with C (and therefore the symbol is always
>> exported with the name not mangled).
> 
> So you might need this for symbols which are EXPORT_SYMBOL*,
> especially if they are going to be used by C code. If only other Rust
> modules are going to use them, and the mangled name is predictable, i
> suppose you could use the mangled name.

This isn't loaded into the kernel. This is used only by the tool to
build a module. When built as a module, this information is converted
into module alias information for dynamic loading.


