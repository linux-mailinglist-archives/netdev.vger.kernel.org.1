Return-Path: <netdev+bounces-40051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BFC7C5904
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F4C1C20BA4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA49636AEE;
	Wed, 11 Oct 2023 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H98WJaL5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AF30F88
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:20:45 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA493B0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27d1a03f540so60534a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697041243; x=1697646043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=H98WJaL5RfVoiaalQKFNSgD07kq9V2RvVV0fx+6MFZ2fwuvqP7ctj4r8HYXc0swock
         ruSVU0YrcEJdryMYf4joPZ8F078hcQz7vF8R2cVwCeyaHRGLEOK4290BQb3cfu5WXOYB
         WkZCM+kPzD0yeMQOYBs/J7NrAT8J+2kfGfaVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041243; x=1697646043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=l5eGy9fe2nbfbpFvhpzVZf89EuZZ3gOjNHCBXKamHr81taXJsObqQW/phFgHtVMH0t
         o1epkiPFW2p8sLk6OUMJ8Fv9JVR+j8KMJp//s9KWIjkgzpXqEoTo1MHPfx+chlc7TFrT
         dxE+0VQfrO8QDOVbgJ2nphaD+W+qzEZB3UvTZKoOlGOQVx2zj+axkJ3Mb7/o/23su4t0
         Xze//g4kmq6v2JRfhvEFlvkhnzj+6p3WskLwzAglF9F0i4mNHpsnfbd3kZYqhY7i7C5D
         w8AC3221nwcPjm8K4S1qdCfoc4NLtUeGXUZhHbKcsV58Lk1WGpRfbxyz8Yf7HGbqRpN2
         4ckg==
X-Gm-Message-State: AOJu0Yx6BhHyiZ/DoMqL8gOVAxlTYstp4LftTF7+7Fvbdq2xdzvb+HfV
	3lg+thT87OoLmAhEsgKqKqabLA==
X-Google-Smtp-Source: AGHT+IFBkkzjfqUFPw2LHU/WJiBG51hkvc97uk8G4hhO5uBiGO2zJPFVWSMOQulsb16+hJ+LUaknmw==
X-Received: by 2002:a17:90a:7541:b0:27c:eb7f:cd00 with SMTP id q59-20020a17090a754100b0027ceb7fcd00mr4432651pjk.22.1697041243325;
        Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b0027cf4c554dasm125627pja.11.2023.10.11.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:20:42 -0700 (PDT)
Date: Wed, 11 Oct 2023 09:20:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
	kuba@kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com, marcel@holtmann.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_sock: fix slab oob read in
 create_monitor_event
Message-ID: <202310110908.F2639D3276@keescook>
References: <000000000000ae9ff70607461186@google.com>
 <20231010053656.2034368-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 01:36:57PM +0800, Edward AD wrote:
> When accessing hdev->name, the actual string length should prevail
> 
> Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 5e4f718073b7..72abe54c45dd 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -488,7 +488,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
>  		ni->type = hdev->dev_type;
>  		ni->bus = hdev->bus;
>  		bacpy(&ni->bdaddr, &hdev->bdaddr);
> -		memcpy(ni->name, hdev->name, 8);
> +		memcpy(ni->name, hdev->name, strlen(hdev->name));

Uh, what's going on here?

hdev is:

struct hci_dev {
	...
        const char      *name;

ni is:

struct hci_mon_new_index {
        char            name[8];

You can't use "strlen" here in the case that "hdev->name" is larger than
8 bytes.

Also, why memcpy() and not strscpy()? Is this supposed to be padded out
with %NUL bytes? It appears to be sent over the network, so "yes" seems
to be the safe answer.

Should ni->name be always %NUL terminated? That I can't tell for sure,
but I assume "no", because the solution was to explicitly copy all the
bytes _except_ the %NUL byte (using strlen).

struct hci_mon_new_index's "name" should be marked __nonstring, and
instead strtomem_pad() should be used instead of memcpy.

-Kees

>  
>  		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
>  		break;
> -- 
> 2.25.1
> 

-- 
Kees Cook

