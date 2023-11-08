Return-Path: <netdev+bounces-46595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AE7E5440
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DB1B20A9F
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBF813AC4;
	Wed,  8 Nov 2023 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CId6UBeF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38512E6B;
	Wed,  8 Nov 2023 10:46:49 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BD1BDC;
	Wed,  8 Nov 2023 02:46:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc703d2633so9962725ad.0;
        Wed, 08 Nov 2023 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699440409; x=1700045209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LaxoozJ7I+klHkNOhHP2mdn2JYn2UIbQ7Fww5757Zk=;
        b=CId6UBeF1jP/cxmr/ipTgPU96GC3tTU2/lX+pkLqYk3mLRSLalzrgU9RaIqvmbB5Dw
         nobh2OnhckNopeNKgI0ADdLvlndFaKDPctYuXDpHADRzBH/KHmq4t15faBPTkK+f+lKH
         qJP6R3t2Sd5xuiooKs2UhviX+8w0qPLYZP51CgBRKORUCTWbJ0EP7sW4L9eII3VbSO2z
         IN2UWnfRHW89JJ9LfKVwkoLJC+XAYdqqYFwtQYBaF3+miaXbJeqAITW+BtJdzfgnsS7Y
         KlMXu3utX5CCeUO8RvGpok7pVjCstbwK+MKavOdm7U4nwl+G9edjoww8RL6oWMjszupu
         dPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440409; x=1700045209;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+LaxoozJ7I+klHkNOhHP2mdn2JYn2UIbQ7Fww5757Zk=;
        b=XsoYcaQ8LewSaKPEOGjpVZrgT57aBxajlQOdjFYtFdHfVgwVFDLPAKMHGWM72F2fpU
         oWmDtgih86B/11BasKEXY2D2I5IsMJwdAjzQXDW/2Lr9fkcrBlCoGFzXsL1MMimfWnOE
         dCsX/OLLN4CCUXS/nu/onu9OFr/mhEyBvFWDzmNZnVFZqifYFfE23flS/dPdP4dqV5oL
         SXQTCfOw8Woo1fYXBTCPWJLS7FMyslQ/Z6cOGd9EerGlE6hUo7sNCkxQS8abvvcsE6MS
         q/6BhMJyfy5Srjw/1ax/kmGHpHujptJ/DehLxgn5uTzNs7NnV1scDEUjmcedZ7GE4Jgi
         ePNw==
X-Gm-Message-State: AOJu0Yz9o2hGWUYwG7KP/SniIH7a9JsR61SRl1nNwypldEn4XlJ5iQ8w
	ZeXhzw1ANkoNZDKSvVClDBGghlABfQZVFQ==
X-Google-Smtp-Source: AGHT+IGA0ja5kBlvWSLqVBG7jECVCZZI6gbM0vboSuumksiSqZYeghTc/Uvo/P0GCQv219fCS3hixQ==
X-Received: by 2002:a05:6a21:7892:b0:163:57ba:2ad4 with SMTP id bf18-20020a056a21789200b0016357ba2ad4mr1784012pzc.2.1699440408568;
        Wed, 08 Nov 2023 02:46:48 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b03a1a3151sm1451864plg.70.2023.11.08.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:46:48 -0800 (PST)
Date: Wed, 08 Nov 2023 19:46:47 +0900 (JST)
Message-Id: <20231108.194647.1383073631008060059.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1e6bd47b-7252-48f8-a19b-c5a60455bf7b@proton.me>
References: <41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me>
	<20231030.214906.1040067379741914267.fujita.tomonori@gmail.com>
	<1e6bd47b-7252-48f8-a19b-c5a60455bf7b@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 16:45:38 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>> But I would wait until we see a response from the bindgen devs on the issue.
>> 
>> You meant that they might have a different option on this?
> 
> No, before you implement the workaround that Boqun posted you
> should wait until the bindgen devs say how long/if they will
> implement it.

It has been 10 days but no response from bindgen developpers. I guess
that unlikely bindgen will support the feature until the next merge
window.

I prefer adding accessors in the C side rather than the workaround if
it's fine by Andrew because we have no idea when bindgen will support
the feature.

