Return-Path: <netdev+bounces-44069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C57D5F81
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC04281C3A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BA17C6;
	Wed, 25 Oct 2023 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF44o81H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5C15D1;
	Wed, 25 Oct 2023 01:33:36 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D1186;
	Tue, 24 Oct 2023 18:33:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so1330549b3a.0;
        Tue, 24 Oct 2023 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698197614; x=1698802414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFwRpLuQ4QieHOpO3P980SaZrN03qX2vmLPHj+QXVig=;
        b=cF44o81HHPjM+gCksccWmBbxpIQXQ1tuY8r+3sndvVWRhLnQ4ca4Vpe8Ivb0Upz+C8
         XGkZWXtAtI1DXZqjbSMXBit67e+B7pAh+Lj7bW79hX+Q57Fj5pp5Nn+fIiracSxBs2g3
         GW9Mf+2O1sl/R/1J2fZnsaVzsECNSs9VrbAnU4d2jIPZwDK5oYnZU5YJqVUeYthYX6tM
         OJciaUIgTkodvLWP/09WhXnpjC9jM5qDYJRJBmjRQowGk+bmfEFS8y3xoVzXt47bvefw
         GqfW4R5L/x1CWS8KX/4XBBSt/i8G38zv9sO4+MNK87WH8rB2J4coR+Tjy27lQg8NH1sU
         SX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197614; x=1698802414;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFwRpLuQ4QieHOpO3P980SaZrN03qX2vmLPHj+QXVig=;
        b=QQQROHi70/ZZm42aWrfHYYsfBWSShQLuj157pkGE/oD1wADSXrYKq4IkTt9Jh9zLNg
         q4jCWsxt9KyZcO5+YzjUNkP6THarunggoQQJEDaVhHpGqJCjuBcMj3oNRTVn72kFbO+G
         IaLlEfz97yedQHoD+GZUGqHCst/E6kBttCt0AbfgLZk2g53+J0SH0CSffsXqkTHNH7Ev
         XI7lfwZSiHpdVkrTKJAJvZgdVPwtoqbN7xQ849YL1TElAps3l05ZqU88WgqaIVrot5M5
         HcHpZs5oZSn3wYdu7uvCHwIwB+l97DPb2zK0GH2S1VK2M5G52RzMQRogzR/5OCHt2A8H
         OttA==
X-Gm-Message-State: AOJu0Yxw2QCsyXD3no1iZjZFA7wcH3+GWZojSn5NMGm7T2GKi+QXunCo
	6P7mjbnAXbIh+gZa2z22aR0=
X-Google-Smtp-Source: AGHT+IEWjkqXKKpNxTq3dyYTTZA5O3QQkp4vKpK8rzWhOJrTwmGCjafxFB3wvSNKSg1MhQ2p6fVrsA==
X-Received: by 2002:a05:6a21:1a2:b0:171:947f:465b with SMTP id le34-20020a056a2101a200b00171947f465bmr19449525pzb.4.1698197614406;
        Tue, 24 Oct 2023 18:33:34 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001c57aac6e5esm8019832pld.23.2023.10.24.18.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 18:33:34 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:33:33 +0900 (JST)
Message-Id: <20231025.103333.1621473047809401289.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com,
 ojeda@kernel.org
Subject: Re: [PATCH net-next v6 3/5] rust: add second `bindgen` pass for
 enum exhaustiveness checking
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6412a54b-844a-497c-a7e2-2b5f94005226@proton.me>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
	<20231024005842.1059620-4-fujita.tomonori@gmail.com>
	<6412a54b-844a-497c-a7e2-2b5f94005226@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:29:16 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 24.10.23 02:58, FUJITA Tomonori wrote:
>> From: Miguel Ojeda <ojeda@kernel.org>
> 
> I think this commit message should also explain what it is
> doing and not only the error below.

Looks ok?

This patch makes sure that the C's enum phy_state is sync with Rust
sides. If not, compiling fails. Note that this is a temporary
solution. It will be replaced with bindgen when it supports generating
the enum conversion code.

    error[E0005]: refutable pattern in function argument
         --> rust/bindings/bindings_enum_check.rs:29:6
          |
    29    |       (phy_state::PHY_DOWN
          |  ______^
    30    | |     | phy_state::PHY_READY
    31    | |     | phy_state::PHY_HALTED
    32    | |     | phy_state::PHY_ERROR
    ...     |
    35    | |     | phy_state::PHY_NOLINK
    36    | |     | phy_state::PHY_CABLETEST): phy_state,
          | |______________________________^ pattern `phy_state::PHY_NEW` not covered
          |
    note: `phy_state` defined here
         --> rust/bindings/bindings_generated_enum_check.rs:60739:10
          |
    60739 | pub enum phy_state {
          |          ^^^^^^^^^
    ...
    60745 |     PHY_NEW = 5,
          |     ------- not covered
          = note: the matched value is of type `phy_state`


