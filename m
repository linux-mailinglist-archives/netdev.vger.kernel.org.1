Return-Path: <netdev+bounces-16798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A174EB9B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A2F281450
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8860182BB;
	Tue, 11 Jul 2023 10:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F817AD4
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:17:28 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D949DB;
	Tue, 11 Jul 2023 03:17:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1475519b3a.0;
        Tue, 11 Jul 2023 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689070647; x=1689675447;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/TPc4qbXoB0pbK4FsXQVUtP8mim8aigvIY0Kfk3sRk=;
        b=Jh71dhKLGrLPX3MkPXdJbmsvmHb9ymTPuDY8ke7IDUXKpr7l4Tm6bZmfVRWOhqGQ10
         m8m/i1wHtzeqzAIIL9XdE+AsImapn4C1EV6KYRVF3B57VNwlC1NzEq99WV1aX11hT+9V
         yZtx2HE+YzdrayNFFnCrPEg8sq7zYtHCcHCuQ8qWBkRYYO6Geez16nsqH1PSp1uGmNNW
         KKN2CplVMpbTxGmj/eEUqtcZ6XOAnlxgvl126pHuUA3leLO7IV/wqggdVPo5BTMI0YXw
         HTKR5CEOXWE4JZRuxeQC4Xvbod7jqVjA85hi3D0AWQquPtSa2xeJAsMHDadpzIdHBpn+
         RiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070647; x=1689675447;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/TPc4qbXoB0pbK4FsXQVUtP8mim8aigvIY0Kfk3sRk=;
        b=BHtXyrbFCldSG68KXC2/jQSuRk1SQ3NsOxn6KlxiEwzzAXjP1VnwerMuf+FvVmGyjB
         cnMYsZEfKyfgPI58GFZCeIdjz3gMzSiDWD/awb0hA1jjbvHt0c2YVR23DUn3My/T1xFL
         VFn3Yk1m/VnmJPg2yvx5IP3PddcLb7rleE0QmS05kb26mHxhqPwAJ7W1GCW62+hxq8xW
         qKfelPBSah7itrpotFYnUsoK9xK9H5P4yB9Ib1dFegdm8ItAIqQ94jZaQWcBItYehk+L
         JOFlXRznu9TBqS2j1pnTz0k3WqTzJC2hR7Vh0FJDL7/5gbj5Wmz/U7kl8CIqtegCUjHX
         JfxQ==
X-Gm-Message-State: ABy/qLZ4/cuxJ0ImeNfPhY/8mLXQ06wKtzMY9FAre/WNnJIeTjuJ29MG
	CUbZ9XOZ0FhBINvNSbZtSRc=
X-Google-Smtp-Source: APBJJlHATYduvyltjqPfPT6M+JtWfFyLAxbGikQ/7C7x9+RUVP99xTnAAFTvkxgoEv4j4Fc6RuYi9w==
X-Received: by 2002:a05:6a20:3cab:b0:121:84ce:c629 with SMTP id b43-20020a056a203cab00b0012184cec629mr19847457pzj.0.1689070646790;
        Tue, 11 Jul 2023 03:17:26 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7924b000000b00668738796b6sm1357328pfp.52.2023.07.11.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:17:25 -0700 (PDT)
Date: Tue, 11 Jul 2023 19:16:50 +0900 (JST)
Message-Id: <20230711.191650.2195478119125867730.ubuntu@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, aliceryhl@google.com,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH v2 0/5] Rust abstractions for network device drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20230710112952.6f3c45dd@kernel.org>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
	<20230710112952.6f3c45dd@kernel.org>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, 10 Jul 2023 11:29:52 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 10 Jul 2023 16:36:58 +0900 FUJITA Tomonori wrote:
>> This patchset adds minimum Rust abstractions for network device
>> drivers and an example of a Rust network device driver, a simpler
>> version of drivers/net/dummy.c.
>> 
>> The major change is a way to drop an skb (1/5 patch); a driver needs
>> to explicitly call a function to drop a skb. The code to let a skb
>> go out of scope can't be compiled.
>> 
>> I dropped get_stats64 support patch that the current sample driver
>> doesn't use. Instead I added a patch to update the NETWORKING DRIVERS
>> entry in MAINTAINERS.
> 
> I'd like to double down on my suggestion to try to implement a real
> PHY driver. Most of the bindings in patch 3 will never be used by
> drivers. (Re)implementing a real driver will guide you towards useful
> stuff and real problems.

You meant reimplementing one of drivers in drivers/net/phy in Rust
(with Rust abstractions for PHY drivers)?

Even the approach, we would get hit the same problem? Replacing an
existing working driver in C doesn't make sense much thus the
abstractions cannot be merged until someone want to implement a driver
in Rust for new PHY hardware.

Or you think that PHY drivers (and probably the abstractions) are
relatively simple so merging the abstractions for them is acceptable
without a real driver (we could put a real drivers under
samples/rust/)?

thanks,


