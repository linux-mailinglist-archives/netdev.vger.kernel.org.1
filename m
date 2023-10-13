Return-Path: <netdev+bounces-40603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC277C7D24
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034C2282B04
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 05:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078B5693;
	Fri, 13 Oct 2023 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9LbtW1o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E993D022;
	Fri, 13 Oct 2023 05:45:06 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759CB8;
	Thu, 12 Oct 2023 22:45:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c45c45efeeso1499715ad.0;
        Thu, 12 Oct 2023 22:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175905; x=1697780705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4IYun4mylpcHufRD1D0e1Rplm2xIYgMbMkKj95rpro=;
        b=P9LbtW1o9JcV8q8okFUseHcUvNax8SJ6TYVekaAElqHspUWC+wpiApmjlneSHX3cH9
         ArNZViBWFu6V5ZJbtlkbdQ2q+MmhKSiXzgTX8zb1GEJJtJuLcgBF9RPsEj2ktbVm2mfr
         /i3B1Fys7ZcpE9IKVqk5ijedW7UwhKOq+SF4cD95CkhZq5sYkVTHdagI5kzVDbLNN8zf
         kk1RPKnAT/5pmPvhQyb6SrtfPiOuo8g+BxpA7vXuUuLI/glVrBZvE5+hjzkm+P8B3SQs
         yUJvluVwkiuB9/WP6NtLPYdRgL//RD33w9MCoBoXaeeH6E1JPKuf+tVmfnaBcYSAsesH
         4/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175905; x=1697780705;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4IYun4mylpcHufRD1D0e1Rplm2xIYgMbMkKj95rpro=;
        b=UABq/GQ0V8xc8Ff5kekiHX6crw3ZQii2lW9sf7Z/FP76lwIxmg5hPdvKOVPBl/xP3t
         czkLOO5+CX6rxws2fQfzqLCYE+fOiL/YDBBLBOBchf8sgzy8lK3TV/eBDw5jQko+5ipe
         dEkZYbFW5IWZvB7USqWe61x7SdfTkZTnSTrL98ELT71qqKZhbZIz8Qid8L5FJb78d4ya
         jqHkD0jWa4+gF9wuQovOB3f/QQJ7yYzbSiKEdr/WshTqFXceL+9goUdWt3Ax+x0kEpnI
         ngDr9IJV/98v9JczSv3/e/hHwlL2FFCvtuS+cGctwRPF2t5FZqCHBpxSI584oAgpcwI0
         xXhw==
X-Gm-Message-State: AOJu0YwxYI69sj10y8eRPCayab4zRjFa3yGlwhi8LvrK5ySITWIQN7Zy
	MFEQD7lOuP1D25Jb5WKL8eM=
X-Google-Smtp-Source: AGHT+IFIkkCt2EoJ5aZfoCEdu80GIhMJierzUfsbJvup67uv/69+DTkLubOnPYpcxSDe+0kd3yFJYQ==
X-Received: by 2002:a17:902:d2c7:b0:1c6:2b3d:d918 with SMTP id n7-20020a170902d2c700b001c62b3dd918mr29264504plc.3.1697175904699;
        Thu, 12 Oct 2023 22:45:04 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b001bc675068e2sm2948743pls.111.2023.10.12.22.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:45:04 -0700 (PDT)
Date: Fri, 13 Oct 2023 14:45:03 +0900 (JST)
Message-Id: <20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: benno.lossin@proton.me, fujita.tomonori@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home>
References: <20231012.165810.303016284319181876.fujita.tomonori@gmail.com>
	<f3fa33f8-f4b0-463c-8ba3-5f0a8b8f6788@proton.me>
	<ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home>
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

On Thu, 12 Oct 2023 21:17:14 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> After re-read my email exchange with Tomo, I realised I need to explain
> this a little bit. The minimal requirement of a Rust binding is
> soundness: it means if one only uses safe APIs, one cannot introduce
> memory/type safety issue (i.e. cannot have an object in an invalid
> state), this is a tall task, because you can have zero assumption of the
> API users, you can only encode the usage requirement in the type system.
> 
> Of course the type system doesn't always work, hence we have unsafe API,
> but still the soundness of Rust bindings means using safe APIs +
> *correctly* using unsafe APIs cannot introduce memory/type safety
> issues.
> 
> Tomo, this is why we gave you a hard time here ;-) Unsafe Rust APIs must
> be very clear on the correct usage and safe Rust APIs must not assume
> how users would call it. Hope this help explain a little bit, we are not
> poking random things here, soundness is the team effort from everyone
> ;-)

Understood, so let me know if you still want to improve something in
v4 patchset :) I tried to addressed all the review comments.

btw, what's the purpose of using Rust in linux kernel? Creating sound
Rust abstractions? Making linux kernel more reliable, or something
else?  For me, making linux kernel more reliable is the whole
point. Thus I still can't understand the slogan that Rust abstractions
can't trust subsystems.

Rust abstractions always must check the validity of values that
subsysmtes give because subsysmtes might give an invalid value. Like
the enum state issue, if PHYLIB has a bug then give a random value, so
the abstraction have to prevent the invalid value in Rust with
validity checking. But with such critical bug, likely the system
cannot continue to run anyway. Preventing the invalid state in Rust
aren't useful much for system reliability.


