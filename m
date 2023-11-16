Return-Path: <netdev+bounces-48427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52E7EE4E8
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0969F1F24BF0
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3043A8E3;
	Thu, 16 Nov 2023 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Oiv5F6jK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF702196
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:03:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1434117a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700150635; x=1700755435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67lWi1khNFKDh2TF9Oi28b0MSBxN3Mo+0RqYqCKcNBo=;
        b=Oiv5F6jKtdbZtS9nakn/WC2BC2hwU/CBHiEJP+4EvFMFIMwFf/o1rDESLaAUbMmFc8
         yPpfSbv2nsf+RD/wEVLWZ17dipwX0Ehhy4FXqzgrcVvvqfS9ThasKhO6t9xxG66tHd0b
         0jNK/XjT9TVW/AJhlnu+cq0BMNrvARr1jNAEJd4RtcPuQFdZLNGz8qSKPx9NeiOhhUtj
         v3weY4xCNuQh64/7wOg3HxBQUJX4PJE+vJSSrUC6ttmtAEULRp4YCzirLIQ5wRWFbejp
         k1AeMVCSz6w16vds0UW0H3+42dAhCFz6znfnETVcUM8KuMrBxqRyeLNO4ApbQuidStyK
         WM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700150635; x=1700755435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67lWi1khNFKDh2TF9Oi28b0MSBxN3Mo+0RqYqCKcNBo=;
        b=iPhm2b+978sXvEB7eXwIBUh8rnoIu+bN793gikl7oKkVpybAQLWHhrBwZRe/5H9Upc
         2m6HiRC289cjBuccLAVGQd7h/XVOsorlzvJ1iBnxbytqZ9c/6nAxyDf20Md+/dx+Pz24
         nC/a7gfNa/jGiERiEfCD4is6nSlDITIW18mtZbJD/nRTHkUDGgXqLdtolQPS9v/zHZ+M
         jzTDzJTZPRofbudeGXlhfmKpYJhRSB+wAd3vTVQt7KVxBhEVcEL3raRquBjJ5DkKOIBK
         hlJ9eYSj977nynigNaC4qS48HS7WZExZYeBjznklOLMw2MGBE0ZjUmQaUNEHcsh1h6mU
         M2BQ==
X-Gm-Message-State: AOJu0Yw4Hi8mwX72vn2ZOFWNtC9UFlOOLvqOsek1nFxiiqOv/6vgRJIb
	TJWK0ixMrdzj7ej5f1o+5xp5YQ==
X-Google-Smtp-Source: AGHT+IFxekn32MKO2A2JKW+uFm2KOnfwSIwAPTQgijQeLn8YLb/+iIDsavYVSRkNfs9PDpGp12fyog==
X-Received: by 2002:aa7:d49a:0:b0:533:97c:8414 with SMTP id b26-20020aa7d49a000000b00533097c8414mr13422326edr.7.1700150635095;
        Thu, 16 Nov 2023 08:03:55 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b005401a4184ddsm7822933edv.27.2023.11.16.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:03:54 -0800 (PST)
Date: Thu, 16 Nov 2023 17:03:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 08/15] p4tc: add P4 data types
Message-ID: <ZVY9aQW0C8kxq0xA@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-9-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-9-jhs@mojatatu.com>

Thu, Nov 16, 2023 at 03:59:41PM CET, jhs@mojatatu.com wrote:

[...]

>diff --git a/include/net/p4tc_types.h b/include/net/p4tc_types.h
>new file mode 100644
>index 000000000..8f6f002ae

[...]

>+#define P4T_MAX_BITSZ 128

[...]

>+#define P4T_MAX_STR_SZ 32

[...]


>diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>new file mode 100644
>index 000000000..ba32dba66
>--- /dev/null
>+++ b/include/uapi/linux/p4tc.h
>@@ -0,0 +1,33 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+#ifndef __LINUX_P4TC_H
>+#define __LINUX_P4TC_H
>+
>+#define P4TC_MAX_KEYSZ 512
>+
>+enum {
>+	P4T_UNSPEC,

I wonder, what it the reason for "P4T"/"P4TC" prefix inconsistency.
In the kernel header, that could be fixes, but in uapi header this is
forever. Is this just to be aligned with other TC uapi
inconsitencies? :D


>+	P4T_U8,
>+	P4T_U16,
>+	P4T_U32,
>+	P4T_U64,
>+	P4T_STRING,
>+	P4T_S8,
>+	P4T_S16,
>+	P4T_S32,
>+	P4T_S64,
>+	P4T_MACADDR,
>+	P4T_IPV4ADDR,
>+	P4T_BE16,
>+	P4T_BE32,
>+	P4T_BE64,
>+	P4T_U128,
>+	P4T_S128,
>+	P4T_BOOL,
>+	P4T_DEV,
>+	P4T_KEY,
>+	__P4T_MAX,
>+};
>+
>+#define P4T_MAX (__P4T_MAX - 1)
>+
>+#endif

[...]

