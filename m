Return-Path: <netdev+bounces-206120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74306B01A63
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15128E18CE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D928C86D;
	Fri, 11 Jul 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jugg2tPk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448542877FB
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232512; cv=none; b=hKUtXtpwit9XjN1if+r9ECX3kL2KsUU+xyLXZU6t1k6GEfZYtkkXpNJNhKtV82MxpLiMcDbDZs9te+7ImLJcIdnHCZ5+ZNPAMP4Sl6+b8iFRCCqsoww955ckD7v56D51Xi2kokQbk/zaCg2js/dzFj2KhviXBpShPSaxlTM+1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232512; c=relaxed/simple;
	bh=EcByffuwUcd7oQW2QyWsAGx+RM5xodOTVZ8aKYplYpI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=almRQRCPvTOF/wZ/8gFpRz72W8GFweL4jN+czREfB/lfb/+MBwFvFkbvnOa7YkI+utpSlapaxBiw4p+Fdfr3ExDKc4Rwdy6AgreC63Oy84Ii/L8VS6tFV6lsAA+KAJwxxZwTSnxMM3v+kuccFUdbrJokB3yHyuNvY2DqKZ0ruV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jugg2tPk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1956238f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752232509; x=1752837309; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwL6u4qmxfBkfQgiMtdzfZkNWMu7NVRYA4AdaCCvII4=;
        b=jugg2tPkOdhf1zJAMrS2OUWHfmvC4vJz3GuS7JeOIeS3jVTJw53SW5G33xl7VTu0Lt
         +JWGvB5pimeHqVS8AGDT1CXGmRZx6xoN8qKfgbvaQK5pBIoLMLQDZ2kLG67HyztftTff
         bkRI3BEL8iALGHkd7rlZFV0nx4o5RIkyDIhyfCIjrBBPeldYab0tpKIzLsWfaTvCu3oG
         gp0EPx0O/bps2FpF1oMKkVXWKee9PHFb465JolPB7C4TzWaD0XzUD37A8LgOpn21U8Ps
         pgrL6mtcXVvHjSJFRF3rh6SGZszDSLDDOl0v78sq0Sy6kdmEz+woKa+deXnjEsvYhfCR
         +8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232509; x=1752837309;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwL6u4qmxfBkfQgiMtdzfZkNWMu7NVRYA4AdaCCvII4=;
        b=eV243orRnWGE0OvagG91BHsqaX8sBgWXwsH2z3ni3WVw6RgbduHgLIbQgXcta+STp9
         dBq22U6rKYcvYDWQPyko9eusBABR+dV9fkI9tH7pogmuf9Xv1VdSJg6IX2tgCAsPIFHy
         lZnJoecjEgl2xu7D/05Ge6eWr/KJh7+jB3iYQPRYXfydSWjK1RYfaEAY85kOylfGJP3b
         O+7pOrtweqO6VgAqQ2c3jdHra6E6RBRuNo7WrvwVWzWwU/TIQNWGi2bt7ylz1ksL05UZ
         w4bdcN/DzbhfD4DkWvzFknIibyB00UC3fQ2tHfQDI0UAdm2okWAE//9Djl8xO7zSN7Rr
         /YWg==
X-Forwarded-Encrypted: i=1; AJvYcCWTLMkeyfdXmXFTVvx2037T/WdSBK6Q65d/jdRxuJ4Wbg7Ez5+y6KbsTq2Fks0Ubc2G/GKb3xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ihuKnBDs+UOGyTJMp0YtFpyD++fj5mCc4HCorpdxnQAyd/s2
	Fh6psGisbM1w1qgAXudlRvre6UB+HfB2RpigLcEk3PWFWts1fTmE8Agi
X-Gm-Gg: ASbGncvg24wEJ9gpIjvOpnxBR/CzPjLLoN5qwjFH8zPJq49FwOgM98wY+DLqo/OoNKo
	qJdEGkCNnN8OEcO183E7nJnRnfU0pmTbOft2PYQQDb1dZNnr0QFBXJBBoProyditY8SrEhKBLH6
	YUNK99+Rm/o8ZrjXbYh/UH7eL8MtdEKQwzm2eY2BVOcx4HfykB4owMcRO3NKNLS5GiNYqC6YxQu
	Zzbz+s3nJm0G0ReWqeVvHNFP0dGIs4mGWU6HMkMloa4ccmXlm/vmazlIainbDMrF2UkjKRsDDIm
	sA1oJznWPwRwvr80UzbQ/oudcpjs27EsGIICDTnQUU2uriLGW4wu3jrch9jSKCFzme0rqpkLJ2g
	WQkLJRY5B8/LbHxDV1hSporCfH/rSJKCtB/Y=
X-Google-Smtp-Source: AGHT+IEL6LA94WPEpEshX+q6WEC7i+8kw2FA+pfH/so+T+X4A1CKvZo+Rb9+IgJ8wHaC3FJf3V8iQw==
X-Received: by 2002:a05:6000:250c:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b5e7f3b047mr7382160f8f.25.1752232509377;
        Fri, 11 Jul 2025 04:15:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:4586:9b2f:cef2:6790])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd180fsm4138995f8f.2.2025.07.11.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:15:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jstancek@redhat.com
Subject: Re: [PATCH net-next] tools: ynl: default to --process-unknown in
 installed mode
In-Reply-To: <20250710175115.3465217-1-kuba@kernel.org>
Date: Fri, 11 Jul 2025 12:11:35 +0100
Message-ID: <m2a55b56e0.fsf@gmail.com>
References: <20250710175115.3465217-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We default to raising an exception when unknown attrs are found
> to make sure those are noticed during development.
> When YNL CLI is "installed" and used by sysadmins erroring out
> is not going to be helpful. It's far more likely the user space
> is older than the kernel in that case, than that some attr is
> misdefined or missing.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Good call.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
> CC: donald.hunter@gmail.com
> CC: jstancek@redhat.com
> ---
>  tools/net/ynl/pyynl/cli.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index 33ccc5c1843b..8c192e900bd3 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -113,6 +113,8 @@ relative_schema_dir='../../../../Documentation/netlink'
>          spec = f"{spec_dir()}/{args.family}.yaml"
>          if args.schema is None and spec.startswith(sys_schema_dir):
>              args.schema = '' # disable schema validation when installed
> +        if args.process_unknown is None:
> +            args.process_unknown = True
>      else:
>          spec = args.spec
>      if not os.path.isfile(spec):

