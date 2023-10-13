Return-Path: <netdev+bounces-40664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2F7C83C8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B911C20B41
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46718125D9;
	Fri, 13 Oct 2023 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAgl7GP5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F15125AF;
	Fri, 13 Oct 2023 10:53:50 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3829AB7;
	Fri, 13 Oct 2023 03:53:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d27026dc2so270412a91.0;
        Fri, 13 Oct 2023 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697194428; x=1697799228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfchUhAe/dfyhW3TQVIln7SnK2q79bHME2bC/tbs6mc=;
        b=HAgl7GP5RBzzatnURJaFZVptQuooLtZ3ZEKpYJjbd7jN3sotCUuB9OVhC+dQZ+bAr/
         RnprllgEUtNiKec/AAAqFMNVWJ2jpaGTJB1LUTE/ES8+ebUyAfpdihJavejOSF/DA/9t
         VYzrb0HfXLFr5EkPWk7tzRE1iUgWZ8vWaAQuobf14d9UQ3hwBYCE/K1NG1t27gt1g7f9
         mqGqA+Fe9DI+AK/hINIEWxNdLisY9J9RNBvAUtnimdL5PAXupODaXv4XT4fbzrTLYNlG
         SF8BcLRbPP/5jGWe4wcYBQ8ymThHNTs3QMWEC1CtkbRPaTi/t7keJXWNDH+ICl9UxgS1
         rM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194428; x=1697799228;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EfchUhAe/dfyhW3TQVIln7SnK2q79bHME2bC/tbs6mc=;
        b=QvK+tBSzxZ5UyMfLmU1P1gpGgwChqaIeje62LsQKw9R4RWpCM5azGFbRDIBMxnRXRg
         ZTZUDA2RiSS7HbUhhlHVrdxfiPV3UOKiBOEJ4znNyGz7yE9IUADNdrwhDL4d5k+dCCbY
         Q0yiUltZ6L1COugWaARRz8Ogomv+3yMjoksGHNMAAWIDBsQdpzIZTLEd/SUTAee11xcn
         okfC/eym7dtUTGqyvWqZ2vZ1fdUSLBv9Uqv2+W3Zu/DLZDK1kf87qt8TLsp4Xuxk/nmk
         hIQ08KVD2w8+w9aOEnnhoQwg8yZzs5fR/ckzBSRokz0cmn5PajmmNXZddj11Zj21g0jA
         z1Mw==
X-Gm-Message-State: AOJu0YxYvdn4iCTClwcms/ijzIJfRfXHmazlgtqRjQLzCGPzqQg41nVv
	nn8ylylzY0TDjxvRx7MQtgw=
X-Google-Smtp-Source: AGHT+IEJ0T1ywdTUxGiRAlfFN/VgZrGqELDpRZ5/Tl/oZOtjTTAKSbhsE+AY+2j0MpHusJElTB2QkQ==
X-Received: by 2002:a17:902:e885:b0:1c0:bf60:ba82 with SMTP id w5-20020a170902e88500b001c0bf60ba82mr29854521plg.5.1697194428534;
        Fri, 13 Oct 2023 03:53:48 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001b9da8b4eb7sm3593194pld.35.2023.10.13.03.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:53:48 -0700 (PDT)
Date: Fri, 13 Oct 2023 19:53:47 +0900 (JST)
Message-Id: <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me>
References: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
	<20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
	<7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 10:03:43 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 13.10.23 11:53, FUJITA Tomonori wrote:
>> On Fri, 13 Oct 2023 07:56:07 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>> It's not that we do not trust the subsystems, for example when we register
>>> a callback `foo` and the C side documents that it is ok to sleep within
>>> `foo`, then we will assume so. If we would not trust the C side, then we
>>> would have to disallow sleeping there, since sleeping while holding a
>>> spinlock is UB (and the C side could accidentally be holding a spinlock).
>>>
>>> But there are certain things where we do not trust the subsystems, these
>>> are mainly things where we can afford it from a performance and usability
>>> perspective (in the example above we could not afford it from a usability
>>> perspective).
>> 
>> You need maintenance cost too here. That's exactly the discussion
>> point during reviewing the enum code, the kinda cut-and-paste from C
>> code and match code that Andrew and Grek want to avoid.
> 
> Indeed, however Trevor already has opened an issue at bindgen [1]
> that will fix this maintenance nightmare. It seems to me that the
> bindgen developers are willing to implement this. It also seems that
> this feature can be implemented rather quickly, so I would not worry
> about the ergonomics and choose safety until we can use the new bindgen
> feature.
> 
> [1]: https://github.com/rust-lang/rust-bindgen/issues/2646

Yeah, I know. I wrote multiple times, let's go with a temporary
solution and will use the better solution when it will be available.


>>> In the enum case it would also be incredibly simple for the C side to just
>>> make a slight mistake and set the integer to a value outside of the
>>> specified range. This strengthens the case for checking validity here.
>>> When an invalid value is given to Rust we have immediate UB. In Rust UB
>>> always means that anything can happen so we must avoid it at all costs.
>> 
>> I'm not sure the general rules in Rust can be applied to linux kernel.
> 
> Rust UB is still forbidden, it can introduce arbitrary misscompilations.

Can you give a pointer on how it can introduce such?


>> If the C side (PHYLIB) to set in an invalid value to the state,
>> probably the network doesn't work; already anything can happen in the
>> system at this point. Then the Rust abstractions get the invalid value
>> from the C side and detect an error with a check. The abstractions
>> return an error to a Rust PHY driver. Next what can the Rust PHY
>> driver do? Stop working? Calling dev_err() to print something and then
>> selects the state randomly and continue?
> 
> What if the C side has a bug and gives us a bad value by mistake? It is
> not required for the network not working for us to receive an invalid
> value. Ideally the PHY driver would not even notice this, the abstractions
> should handle this fully. Not exactly sure what to do in the error case,

Your case is that C side has a good value but somehow gives a bad
value to the abstractions?

The abstractions can't handle this. The abstractions works as the part
of a PHY driver; The abstractions do only what The driver asks.

The PHY driver asks the state from the abstractions then the
abstractions ask the state from PHYLIB. So when the abstractions get a
bad value from PHYLIB, the abstractions must return something to the
PHY driver. As I wrote, the abstractions return a random value or an
error. In either way, probably the system cannot continue.


> maybe a warn_once and then choose some sane default state?

What sane default? PHY_ERROR?


>> What's the practical benefit from the check?
> 
> The practical use of the check is that we do not introduce UB.

hmm.


>>> In this case having a check would not really hurt performance and in terms
>>> of usability it also seems reasonable. If it would be bad for performance,
>>> let us know.
>> 
>> Bad for maintenance cost. Please read the discussion in the review on rfc v1.
> 
> Since this will only be temporary, I believe it to be fine.

Great, if you have other concerns on v4 patchset, please let me
know. I tried to address all your comments.

