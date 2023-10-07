Return-Path: <netdev+bounces-38781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81E7BC717
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE11281FAA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C251864C;
	Sat,  7 Oct 2023 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Kz0eq6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BACA18630;
	Sat,  7 Oct 2023 11:23:27 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B05B6;
	Sat,  7 Oct 2023 04:23:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c746bc3bceso5707845ad.1;
        Sat, 07 Oct 2023 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696677805; x=1697282605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXNkhYvl3J3XO+qHJu/vbKZRfhm4+vSrcYnrwTyVkQk=;
        b=O8Kz0eq60AUfOjXml92kR9EV55yzTtzp7LQrEKtFCS1aZraAPhi6ZqwS/e+3/tdeAG
         9scDkK6uBo7LFZrtqqivCDuSi4aGK8j/OWGOQJVBBfRmgvtqs1+LQLjaoOACPZOfrrvH
         8wmflJhOZvI1vyCGFQhPmcF7hep8G22gBk+2/Gs4oxPX8AJqIoqbNy3/RtUc5OtWNtCN
         f4T/GR5cbba4uofGmTDdksrEsFlMVxPZs0FkW89rWkPoHATyjge2ta8whN1tjugktgWq
         HuIAb0LtcXPo0ZXDCCuUgxAWWq0dR1wujzItF35wqH42su6qGpI/HfTI8zWo2kOSZwOz
         7LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696677805; x=1697282605;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXNkhYvl3J3XO+qHJu/vbKZRfhm4+vSrcYnrwTyVkQk=;
        b=DxXfag3pxlZokE+C69AFeIPTfTP7HIbzY7488v3kW53EgB6445ian3+0E7C7nAL+Yr
         LZFiiEh6dToVI8Xqo+ioacHsZ6Ep30COFm1eBzFnONkaMGJCVyxeTJxtJCQxsT/u8BTW
         gVI5rq6imQoeuFSCBd+XH22diNjvS/L0zBBqr/ni/MzVw9YGQ4GvKcgXCnA46SVsPFC5
         Yb87el1nttABzoeDEU19S/cIZKDsh11K89jrZFdc8rr5tfFvVfluawukCQSLTr7oBI9w
         EynzmTFttTna2+dDepxYUJkI7VmDUCAHaMgFOWLQhvYwcTXKSVUMxPLDywy9GatRcMDA
         IFZg==
X-Gm-Message-State: AOJu0Yxn/WUya2Jqqhj98Hiv4FomQXSphFLHKzw0uOJLQCX5dzQjjbCp
	MCAjnfCfuyiA/qh11Tq8ZyQ=
X-Google-Smtp-Source: AGHT+IFsWsPkxFR6DmUNhYrxWz7Y7CwA6WCUF48QSD6IOfY40nzAUltjI3n8NbP7t9jQNrXuyh73Qg==
X-Received: by 2002:a17:902:d512:b0:1bf:349f:b85c with SMTP id b18-20020a170902d51200b001bf349fb85cmr11715358plg.1.1696677805196;
        Sat, 07 Oct 2023 04:23:25 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jw17-20020a170903279100b001b89466a5f4sm5682209plb.105.2023.10.07.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 04:23:24 -0700 (PDT)
Date: Sat, 07 Oct 2023 20:23:24 +0900 (JST)
Message-Id: <20231007.202324.2257155764500021886.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100757-crewman-mascot-bc1d@gregkh>
References: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
	<20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
	<2023100757-crewman-mascot-bc1d@gregkh>
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

On Sat, 7 Oct 2023 13:17:13 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Oct 07, 2023 at 07:58:57PM +0900, FUJITA Tomonori wrote:
>> > Since we're taking user input, it probably doesn't hurt to do some
>> > sort of sanity check rather than casting. Maybe warn once then return
>> > the biggest nowrapping value
>> > 
>> >     let speed_i32 = i32::try_from(speed).unwrap_or_else(|_| {
>> >         warn_once!("excessive speed {speed}");
> 
> NEVER call WARN() on user input, as you now just rebooted the machine
> and caused a DoS (and syzbot will start to spam you with reports.)

Trevor uses `user` as the user of this function, which is a PHY driver.

