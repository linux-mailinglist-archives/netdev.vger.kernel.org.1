Return-Path: <netdev+bounces-45234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034787DBA23
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2592B1C20A5E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472C156C1;
	Mon, 30 Oct 2023 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbWPENcJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504414264;
	Mon, 30 Oct 2023 12:49:09 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68804C9;
	Mon, 30 Oct 2023 05:49:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so1298522b3a.1;
        Mon, 30 Oct 2023 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698670148; x=1699274948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2XCfmBBtk169C6lE2Ret5wQ4hD1gmLeVoFyIcMAyYw=;
        b=gbWPENcJ3fUEAdK/c9fWvAwlyxQcc8I6qMU74kfk2vh3MVkt904KvmyiHMyYptUPmx
         Jqw08h0jUcOP+LCzfdeuGTB1kDiJeDdHBc5UwPaGs2o1gdtmSAPMdSbTB2vx1Pm+pjha
         s62VwGHHsnLwzT+VIrI6hns8G3FXzDgCOca2Rf9ihysX8EXPdMPpdSgmx7AcQVa+hvBX
         L0bfkU/XxIciPqgWWk45/Yodap9/gE8tjLx1fuVgAcnbpbVbQhv2aawbGv36LIBsaIb8
         rmLNwnRsMaEpNkalc9bz5+M8Px1qsHRWarhjFUIQ08rJ173fLrUlEq2AD+n7PICXqDQh
         cdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670148; x=1699274948;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l2XCfmBBtk169C6lE2Ret5wQ4hD1gmLeVoFyIcMAyYw=;
        b=rdTBkEUmipzP4M0zIa79ZWNMeAMS336K0yx68QncmPqZRddu2ijbGnh2g7jWvJIOxc
         k1ERXqDSmJ4b1ArlpgEZLkb+qw2Vz07ms5R42Mcb6aDctl7vtUF7UzKQYZIKFDQDzAFi
         EXLLbEq0MpqnVPUcvh/ot/+bQDRCF4NMdf3FTssbj14OMKnc7oU6Dz3fzfawGxZ4WdQ2
         MinjdTI18858+pW1iIO/Z3UqzLGPT4yL2ryfzRHCL8GJ2q4IJhZ0GUuDcyuar8E+gwNy
         ZMpMveHYFh+r0u8w6h9PsRFhOx8yt3KIgiIV8pWGc4eZ201QuRT0G/qvZYMEf6kTlxe5
         nekA==
X-Gm-Message-State: AOJu0YyaDdXGWl4sVVhHOCPQWCnUgFUW9IO1R+pRlRi5NwmPt2IgXf0p
	drDADVu5NaUDu83NvJiXfV4=
X-Google-Smtp-Source: AGHT+IHONf43flwPodj2bEXmQA8/Q3IP7kAmDSwFZVlQc3WFfAmWTxFS1qba6Z3eUFGT69UMXV3ylw==
X-Received: by 2002:a05:6a20:440d:b0:163:ab09:195d with SMTP id ce13-20020a056a20440d00b00163ab09195dmr13716984pzb.0.1698670147751;
        Mon, 30 Oct 2023 05:49:07 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm5864769pfu.139.2023.10.30.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:49:07 -0700 (PDT)
Date: Mon, 30 Oct 2023 21:49:06 +0900 (JST)
Message-Id: <20231030.214906.1040067379741914267.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me>
References: <20231030.075852.213658405543618455.fujita.tomonori@gmail.com>
	<ZT72no2gdASP0STS@boqun-archlinux>
	<41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 08:34:46 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 30.10.23 01:19, Boqun Feng wrote:
>> On Mon, Oct 30, 2023 at 07:58:52AM +0900, FUJITA Tomonori wrote:
>>> if you read partially, the part might be modified by the C side during
>>> reading.
>> 
>> If you read the part protected by phy_device->lock, C side shouldn't
>> modify it, but the case here is not all fields in phy_device stay
>> unchanged when phy_device->lock (and Rust side doesn't mark them
>> interior mutable), see the discussion drom Andrew and me.
>> 
>>>
>>> For me, the issue is that creating &T for an object that might be
>>> modified.
>> 
>> The reason a `&phy_device` cannot be created here is because concurrent
>> writes may cause a invalid phy_device (i.e. data race), the same applies
>> to a copy.
> 
> Both comments by Boqun above are correct. Additionally even if the write
> would not have a data race with the read, it would still be UB. (For example
> when the write is by the same thread)
> 
> If you just read the field itself then it should be fine, since it is
> protected by a lock, see Boqun's patch for manually accessing the bitfields.

The rust code can access to only fields in phy_device that the C side
doesn't modify; these fields are protected by a lock or in other ways
(resume/suspend cases).

Right?

> But I would wait until we see a response from the bindgen devs on the issue.

You meant that they might have a different option on this?

