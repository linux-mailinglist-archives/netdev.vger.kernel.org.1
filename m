Return-Path: <netdev+bounces-53719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17880442F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A45B20A79
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9EB17E4;
	Tue,  5 Dec 2023 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa9VMMjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA9F0;
	Mon,  4 Dec 2023 17:42:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5a0dc313058so718669a12.0;
        Mon, 04 Dec 2023 17:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701740525; x=1702345325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFwBwErfPVaw2uR9RGD8mN7UrwckG9KolaLriEpRS7s=;
        b=aa9VMMjSkUGgG6ZBjBWG+DbdUm8KK8S15AbhvnellgZXQAuGXoh6Lzzx7HHRjJ4mwS
         EV7AihQJtrnU4IJs3pLPeMlZxZJvyVaK8P4kYazZrVMobR72wD7oaO+aevblF6KLTtIP
         c/jmhpUY817lZHLDifSTQdiaKUiLhPKsvB01wct/fQVZ5WBnwcfxQzqt1JU5G4/5twT8
         SOJd32vlMtQ+RK06FgFIW5LbasP/jHChnjh00az6Ch43AT3lU9bhrESPZc/FpLrNGzEF
         yMcbQL8FDTbFYGot23JISidQ6H9VbW0VwaiQehZ0c3SCKyWiN98A3b7ZjSuNaTvJVgBL
         e3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701740525; x=1702345325;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFwBwErfPVaw2uR9RGD8mN7UrwckG9KolaLriEpRS7s=;
        b=O/L9oqN5apPImWa1kf5To714t8mcaif4wH5rEc/K3S0vaV9dLJ5gAY8QdYdb7zf8gi
         y4KE5YjaMLEZcwVEWXPOLd7myS8+bG1XKdEIa/Hf2KqdLC8zNd0MOWg7cCqjBXH1KH+L
         z1enSaJ7E/Fe1pSDmRtHd1++wkqkIGWodFh2Y5dQwyB+/wgCmgu6mKL+9DQJ2BLVYXRM
         3Egpd5m2WBwAJK0BVlB7vyd8ZmMhCAO9H96T5l0RRPV17PXerafRRcr0t92gTfMpXtZV
         QIFp6JycN4NlZ1ViH4VzOvN5tBMmXVvMOT6+Uf/3ch5JcwsxJpxVH7knAsxOfvOsKPYx
         7bBA==
X-Gm-Message-State: AOJu0Yx+ljLEVon6NbpyqTh9SfKZlVpwaOXELQNZma1mOwD8WcTwkMdF
	EfyUKSHYA8EMYiMyAaZ6FSQ=
X-Google-Smtp-Source: AGHT+IEqchqE/qLmWw/WZkJn5H/PPdg1c16cs2hBXSxbKXkwrNwpraS9+KZPFZy953Sd5XZxAb5yzQ==
X-Received: by 2002:a17:902:e881:b0:1d0:c738:73c8 with SMTP id w1-20020a170902e88100b001d0c73873c8mr39847plg.0.1701740525091;
        Mon, 04 Dec 2023 17:42:05 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001d0b0353a92sm2039693plg.304.2023.12.04.17.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:42:04 -0800 (PST)
Date: Tue, 05 Dec 2023 10:42:04 +0900 (JST)
Message-Id: <20231205.104204.1385990383177627211.fujita.tomonori@gmail.com>
To: jarkko@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 0/4] Rust abstractions for network PHY
 drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CXG0IU9934BK.XO99IFWA0J3D@kernel.org>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<CXG0IU9934BK.XO99IFWA0J3D@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 03:35:10 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
>> This patchset adds Rust abstractions for phylib. It doesn't fully
>> cover the C APIs yet but I think that it's already useful. I implement
>> two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
>> they work well with real hardware.
> 
> Does qemu virt platform emulate either?

No. I tested these drivers with hardware. It would be useful if Qeumu
spports PHYs.

https://lore.kernel.org/all/460e7d2f-2fd4-475b-9156-88d61c9f7347@lunn.ch/

