Return-Path: <netdev+bounces-12413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD3B73760D
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 22:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9E281312
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2D182C1;
	Tue, 20 Jun 2023 20:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192D17FFF
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 20:29:10 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BF1726
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b512309d18so26250365ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=CMn9j5Qr0xGH6DPGZmJc+8hF5CS7hFNW/AUBWIcKDkQBdJ5uF/Iv6grWO3k2zaFj5R
         Pcqdzrq3VhdcrvlV/2cztlPSb2r9XJBRdRkJ8sH2KLckg9WUwzrqJmnuo9T18h65CsPj
         Q/sTtqBKU0QjMuls8JQTtSdsBjlIdAXmJUbvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=aFMdB/sjbT743K0QEpfyGS5n1QwE7SXl7AcDtLXYoPXlLBUjqeJreDkrfCTcB2BBkm
         fHhuk59m8gnHnvswBJgzOtJgsTTYmy/70z+rRUfd7/VMdwkOXjd14oWMfIKCYWE2aW/p
         SAg53UqtEf0hJVqmKBJNpc5qc7NwD/7U5xiLCWe+ee82uXAMd0V2NZ4yGX0pa7Kh+yxE
         m6M+W7dHHQoXH/NfRAR6Vk2HLD/M9TdUPuU7KRcLbN4S3HMfy79AE73KFzQl/EWsOaWl
         4544NH0WaGNby7DAYRs+jTj0T3gj6AQaaPFbP7eWsASDaX8USiAdKMX4N+PgqQqp41KH
         36yQ==
X-Gm-Message-State: AC+VfDyhm5fVbp8TBIeHvhmJNWjs5ivK+I9uwQxSYrkaFAKLUoZfkqaF
	zzd6wSCf6QkgSRfqKA1Si9b/+A==
X-Google-Smtp-Source: ACHHUZ6LzhHQEkbmov28C9WgtfEbYhAG2m29rvQZ0Ua4ICR8aQDGRoXYdt43oeJZee8pqeivB1cpJg==
X-Received: by 2002:a17:903:2311:b0:1b6:6b18:94ff with SMTP id d17-20020a170903231100b001b66b1894ffmr5114043plh.34.1687292948154;
        Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001b6740207d2sm1990746plh.215.2023.06.20.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:29:07 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: fw@strlen.de,
	pablo@netfilter.org,
	azeemshaikh38@gmail.com,
	kadlec@netfilter.org
Cc: Kees Cook <keescook@chromium.org>,
	netfilter-devel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	coreteam@netfilter.org,
	linux-hardening@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipset: Replace strlcpy with strscpy
Date: Tue, 20 Jun 2023 13:28:24 -0700
Message-Id: <168729290242.455922.9357942903753232037.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
References: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 13 Jun 2023 00:34:37 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Since this got Acked and it's a trivial change, I'll take this via the
hardening tree. Thanks!

Applied to for-next/hardening, thanks!

[1/1] netfilter: ipset: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/0b2fa86361f4

-- 
Kees Cook


