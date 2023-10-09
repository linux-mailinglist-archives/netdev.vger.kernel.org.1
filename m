Return-Path: <netdev+bounces-39231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6E7BE5C9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8782818FB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3437CA0;
	Mon,  9 Oct 2023 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gL6h0k5V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C9339BC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:02:34 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F309E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:02:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c7373cff01so41703185ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696867351; x=1697472151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBo7/M8weK7GqJKgsmfZy4H/ddypVZXezIGNc/laBIM=;
        b=gL6h0k5VVMBjDMJOPDCAChakBz/wXsEo6uNJ4kH0G/X0fAPjMgZ9W4v89lzqTRPAmV
         OFjEgn/K7ii/k9/uUnCvyiROzS6spfyytS20e92g13MKOth1lGpSsDdmoayzKpCOfGCR
         J9jf/PzmIKYBEbbFeaQ4jCzerQrff3DRdxWCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867351; x=1697472151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBo7/M8weK7GqJKgsmfZy4H/ddypVZXezIGNc/laBIM=;
        b=IeN8pUYtHuT5D7bEbxr+gVjQvkydf0tmvTmXOMSiq0KjCz+fPSev4VtEOyGP/Isc1D
         x2qQPe/knUTBVALDcZ8C9FVNAm1ReRlRsMbjf7X8p6mw98fXljJYTcT0YpD3omJMJG1u
         1rzNhAf7D5K1qhY/+aCpfQpCL4vn56LGOLuk8BKMhShfzgrYEA7SLqDFyCaQ1PJxwuSh
         jlrhzzNxThO6UmUCu4hKc9M2Ve1y7C/uToar5lIXIMhL9NSFRdIpBx76Cu5kbHstbHKN
         Y32ur3hHC/rDQfZn6xkc+puck+FxqVL2wFbfdruHv/INV6UUgnuS3G5fEUqQs7PQgW8G
         90jQ==
X-Gm-Message-State: AOJu0Yz+DGf/T8cQ8iXLgd7mmOgxLm0u1gcgHVUXBZ2RZMlrQuG1AJP9
	ofm/YSgIKoeq1GXAsa+eGqZKAT2gu5BU+hAOXO0=
X-Google-Smtp-Source: AGHT+IHzup/xAx1ifpxmi3UryQvmiHkOx8P4Nc2On1Fyx56aKemvsYmRNFsp4H4ofYMWZ2mFLT5hmQ==
X-Received: by 2002:a17:902:cecb:b0:1c0:cbaf:6954 with SMTP id d11-20020a170902cecb00b001c0cbaf6954mr21386914plg.25.1696867351114;
        Mon, 09 Oct 2023 09:02:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001bc445e2497sm9742768plt.79.2023.10.09.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:02:30 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:02:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310090902.10ED782652@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These functions are simple wrappers around memcmp() and memcpy(), which
> > contain compile-time checks for buffer overflow. Something in gcc-13 and
> > likely other versions makes this trigger a warning when the functions
> > are not inlined and the compiler misunderstands the buffer length:
> >
> > In file included from net/bluetooth/hci_event.c:32:
> > In function 'bacmp',
> >     inlined from 'hci_conn_request_evt' at 
> > net/bluetooth/hci_event.c:3276:7:
> > include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified 
> > bound 6 exceeds source size 0 [-Werror=stringop-overread]
> >   364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Use the __always_inline annotation to ensure that the helpers are
> > correctly checked. This has no effect on the actual correctness
> > of the code, but avoids the warning. Since the patch that introduced
> > the warning is marked for stable backports, this one should also
> > go that way to avoid introducing build regressions.
> >
> > Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device 
> > which has same BD_ADDR")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Lee, Chun-Yi <jlee@suse.com>
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Sorry, I have to retract this, something went wrong on my
> testing and I now see the same problem in some configs regardless
> of whether the patch is applied or not.

Perhaps turn them into macros instead?

-- 
Kees Cook

