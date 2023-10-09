Return-Path: <netdev+bounces-39195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F627BE4AA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82907281A44
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0437155;
	Mon,  9 Oct 2023 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2XWBOHx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89437152;
	Mon,  9 Oct 2023 15:24:17 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CACBA;
	Mon,  9 Oct 2023 08:24:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-58974d4335aso374656a12.1;
        Mon, 09 Oct 2023 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865055; x=1697469855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFFV+g8beNv1qozuYbV2d5g+kPeKVI3jo7N7mHXEG7A=;
        b=e2XWBOHxHDjXV4yfyaqAO5vZszcvRkZPL0lEOSzMZYnn04mXmFRJXrszoP01cqqhIy
         4uBWJpwZgEOSpUnDsagfacEsSs6MGuSAPRb23Q8HFJhKy/4fr78gv9KUzyWkNZu3/rL5
         MJEvhzOfRt7PkRR5Rrz/D3aV8c+Tkx/hqrSH08RqNI7GbBvDImnRAIIlKIwANaNoJ99M
         j+9g1CNgYIvHHan1eS7qMzTFMC9wiV40mu7NOdZo6QQOg6hYvOAqLJXcZvYM0s/xooG7
         2UIkKdjS12TCbXFih/JW1lNkWri4Burd0iJKSjAGuW2aGS4hizJUYB959V60hES/AJTM
         YlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865055; x=1697469855;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFFV+g8beNv1qozuYbV2d5g+kPeKVI3jo7N7mHXEG7A=;
        b=Lc7zpVYCoYZ0ZykInMAHg1jP7nRwmwd11FmyaH+5OqviPu3kn0X/Q6yL4PwHvwGI6g
         0AXnffzcrMiKVAxgCFcxA0yaNKZwxrUy1QmH2W8fNg6oYx1Ny8MwqDuE0v3XhBF+++oQ
         T24ebYmrKz9zWzIv/Gs2W/+++JNhQTLlvtEpWwPYWQESLDvu5wtLnxmlqr0rDMnvfULn
         F96mTHVlCOiBIFgVYeoIbF+NZZaNn3USvfbapJRHzitiVo4JpLNS2ZsVex0Pohabsbut
         je6XcULawiOCbrr4t9PLfMPLlKwMsqHK/JNWFsechiSDqPT5qaynSVFtTk3iuOhThlCZ
         Mosw==
X-Gm-Message-State: AOJu0Yxqe4XbP01WDSVtSWApzlHbnAChkHcrZSuDyGfJlWrxYM0RfuTQ
	r2ENcYigIzy8cFE6L7s0dHA=
X-Google-Smtp-Source: AGHT+IHQFoSxyQfT09+Axx76HpGcNb2HvR6H/My8T5mVb9wIwbGq6CAjrjSihBCZm/+tn6MyvLmF1Q==
X-Received: by 2002:a05:6a21:66c7:b0:16c:b5be:782d with SMTP id ze7-20020a056a2166c700b0016cb5be782dmr7654687pzb.4.1696865055007;
        Mon, 09 Oct 2023 08:24:15 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ka14-20020a056a00938e00b006a680745c8bsm1178694pfb.125.2023.10.09.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:24:14 -0700 (PDT)
Date: Tue, 10 Oct 2023 00:24:13 +0900 (JST)
Message-Id: <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100926-ambulance-mammal-8354@gregkh>
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
	<20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
	<2023100926-ambulance-mammal-8354@gregkh>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 17:11:51 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 09, 2023 at 10:49:07PM +0900, FUJITA Tomonori wrote:
>> On Mon, 9 Oct 2023 14:59:19 +0200
>> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>> 
>> > A few nits I noticed. Please note that this is not really a full
>> > review, and that I recommend that other people like Wedson should take
>> > a look again and OK these abstractions before this is merged.
>> 
>> We have about two weeks before the merge window opens? It would great
>> if other people could review really soon.
>> 
>> We can improve the abstractions after it's merged. This patchset
>> doesn't add anything exported to users. This adds only one driver so
>> the APIs can be fixed anytime.
> 
> There is no rush, or deadline here.  Take the time to get it in proper
> shape first please.

Trevor gave Reviewed-by. Not perfect but reasonable shape, IMHO. Seems
that we have been discussing the same topics like locking, naming, etc
again and again.


