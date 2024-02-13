Return-Path: <netdev+bounces-71484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1679853925
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A2B1C203B0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC2605B8;
	Tue, 13 Feb 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpC68EKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FD6086C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846925; cv=none; b=M3gLU+INfHF/AvA5wDUuXW5GfuNQPZc6FGLu2MgDG+61CJAtn9VwIm4GrIJhK0RfCGvZsZVa0q0uTPNSlVOe+C2QgLGyJa9IIaezGb7cYzri5lXjFSUbBxEKx2z62iEGik+zRJQhYCtwtZpVwTtUD0BEsfBh+4fvc2iiLjSA+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846925; c=relaxed/simple;
	bh=9tA4PJNIdxfhRObvzKWYDSHnvWdGJLyxyrK7xpD4Q0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwazKNusL7rL4C9xphVaoFfJ8CZP1vD7YRUNwgVB2hjF/oN0rioICvoa4ATMNpNFwxXGkzYIL2QhbuuZy6vxpoVAxdneWZdrL5sUqpM4Ck+Rlt6Nb61WtRRIwwLAZujSWeZxeaKRNdpZitT4KlhHgAhI77qhkyCP34B5gpM+OnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LpC68EKv; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2ed77e94dso890296a34.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707846922; x=1708451722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHH6DgRGJUK+K/3+G3CCr8FcJttt2bs3BQjcG1Lrj7I=;
        b=LpC68EKvpNG3B+MXWAlZJkJSQSfOCnEgSQKbm1OLenEyOOi6uilOcCotZttGDqYIzo
         XalLZCGsKa/vqu6pgUc7pFQ6V+qB0fXzf/iHnHVjdFGDNmuZQXLHDXId+yHhBrnmzygT
         s1wdshr5pb+mDdfjc5tmcq9UDZu1534S2U3l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846922; x=1708451722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHH6DgRGJUK+K/3+G3CCr8FcJttt2bs3BQjcG1Lrj7I=;
        b=HEL7fka2NuvqRwvBnAaUxfAi3B8Hnw0KWlrQU6szldjD14fEIN7HARi0ONZH0yFrQ7
         cGl462tICjxu3avhpuJiBj1+7Q4x5t7bcD8hZMmBiBlMhOW/UxKe0ewRziNBbmOWeiNJ
         M8iFsprkhvz7RwSYoe3Ih/KUOzhFxcnYy73FpdkeyqLsApHAKeB0/0EPEWaGLzYBhlsU
         9NE15DJReyYC9/FCvVyCLjyN12jLJyfRljvorefH1wg/bcZONwcC6Vi9qJqswl9pzWqi
         d9CYVEv/oRmE/K8xNdlgOyYZr1kzTCWotiATvoCZyLFOTR36ptfv+ml/wOAgpVDF+cca
         +sjA==
X-Forwarded-Encrypted: i=1; AJvYcCWv1KVfnrXYhEixp8FtpeRpeFMtdXe2t6augU4c3RUk2WPpNotzUTjtSoeIAag0yh8w6FKOJNQQJ6mL0wvWjn59z8yVi4tQ
X-Gm-Message-State: AOJu0YxW5e1cmxghR9uIoX0tH+Z2Wc/UkbWiU35i7Xp8jYiD3KUfczJE
	0U10BeSPwPkqRk+h1iuYEYYDcLVeCYsa1cbyUmAztE8jxGrUp5PdoUgWzY9Bfg==
X-Google-Smtp-Source: AGHT+IGYNxQGH8ux7gJ+l/xnGKzAZ18uVxeJixNqeVsBpC+UP5JSrjoZlL53WQFEfiii+ZAKwUM/sw==
X-Received: by 2002:a05:6358:2811:b0:178:c51c:7af5 with SMTP id k17-20020a056358281100b00178c51c7af5mr12691366rwb.32.1707846921875;
        Tue, 13 Feb 2024 09:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWkmt3IPXDuEj0zOlfxz9ExS0oa+gkwlj43/jOtMEPQLoiRm1RxpOFHkrU67ii1euE+S+sAya0midSyK9CryTNj+Fv/cbP5L1TWpcqDVBPLNdtr97DrexutBhGU/EyIZp4C3YoIF3I5IyunsfhZaAJLovT5ei0/C2iR4xmNw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j191-20020a638bc8000000b005cfbdf71baasm2693461pge.47.2024.02.13.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:55:21 -0800 (PST)
Date: Tue, 13 Feb 2024 09:55:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 2/4] selftests: kselftest_harness: use KSFT_*
 exit codes
Message-ID: <202402130955.8A2B2B1@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-3-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:14AM -0800, Jakub Kicinski wrote:
> Now that we no longer need low exit codes to communicate
> assertion steps - use normal KSFT exit codes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Yeah, good cleanup.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

