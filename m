Return-Path: <netdev+bounces-54426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5F8070C4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40CE281C2B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D9374F5;
	Wed,  6 Dec 2023 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cfS90Op1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F1AC
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:21:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so3829862a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701868886; x=1702473686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQqJumbY5/om6bDdbaAXe1etwBjyfBaS/JPDxfOUVo=;
        b=cfS90Op1KcpjwNwmV+pclQzzd1+JNvKPci3FxhuImaxINNxKtlV5Tx6u4IsxPI2sSG
         a1r7caH5O3TnwbHN2ivlVEjSd3s8ULEo/vh1nOvbLv+Z8OFySMBZ1hzUweuygrP+RYKI
         PoE7gFH5Ub+RFRgqs87lNhqnpi2V3lcBhERj90johk128tvIcvxTTNaKhh2LWboQoaLz
         ECjhsZbZGLxvI9Hb7LkrhZEcnqVFBebCk8OW4wFfkVI5NgnvsL617mbx72CIdgZLcdSl
         Ah0Ct/hu7QbU5toWbhCBKsSHL/uEFoAR3lbRoCCPVPpzucuTzAG8iCuDmlA5y6ODe6hs
         Llog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868886; x=1702473686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwQqJumbY5/om6bDdbaAXe1etwBjyfBaS/JPDxfOUVo=;
        b=cDlTeRVdQAYa4DAiBKJq2qQ9ty3/ZhebXqQ4P2dpLBjJ1MjZbt3xZh3N96hGF2LNfx
         SEhjyhO4gbOJIIPfuBVZZOlFxlqYqlWlbhNrrknIMyURtidMn6jGMP0paX0agSJ20RhZ
         gV3sNIjXHjpSYxLeLS9TXgqe1xqODYCylEvFRobke7llyov23gss6kAyF84gzWB/KxQJ
         e5oG5YaD+cjnInSDmUagulP9oxscjUl2O3ztU7vkXXhTNG6Too7+ySe8aLwGruWOVxiN
         bbErLQW8NAwbjO8whGSuyjpFCj+ESWjT/cZatmZQ8DvC0sbpuRo4PA4MmYstuL/oT3zG
         QeKg==
X-Gm-Message-State: AOJu0YwMEVQPfOeZ9YtA+SblJcp7u/yA7ThORMR28HhMAh3w6pxbnaXY
	Q7tqqnI2vb+YBCh3WdU0/10Cwg==
X-Google-Smtp-Source: AGHT+IFWmP6+Dna4lIHhaMi4c1opjtrWqysH4+kDdPrLq6nqgup7QjLrXkig7tJJExJ5IfeKExUcYg==
X-Received: by 2002:a05:6402:3185:b0:54c:4837:9035 with SMTP id di5-20020a056402318500b0054c48379035mr734306edb.45.1701868885946;
        Wed, 06 Dec 2023 05:21:25 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0054cb199600fsm2404810edr.67.2023.12.06.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:21:25 -0800 (PST)
Date: Wed, 6 Dec 2023 14:21:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXB1VHnrE98H4p9Q@nanopsycho>
References: <20231206123719.1963153-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>

Wed, Dec 06, 2023 at 01:37:18PM CET, revest@chromium.org wrote:
>In __team_options_register, team_options are allocated and appended to
>the team's option_list.
>If one option instance allocation fails, the "inst_rollback" cleanup
>path frees the previously allocated options but doesn't remove them from
>the team's option_list.
>This leaves dangling pointers that can be dereferenced later by other
>parts of the team driver that iterate over options.
>
>This patch fixes the cleanup path to remove the dangling pointers from
>the list.
>
>As far as I can tell, this uaf doesn't have much security implications
>since it would be fairly hard to exploit (an attacker would need to make
>the allocation of that specific small object fail) but it's still nice
>to fix.
>
>Fixes: 80f7c6683fe0 ("team: add support for per-port options")
>Signed-off-by: Florent Revest <revest@chromium.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

