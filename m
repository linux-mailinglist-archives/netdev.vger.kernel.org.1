Return-Path: <netdev+bounces-52720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D499D7FFE29
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E40E28174A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB05EE6E;
	Thu, 30 Nov 2023 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LzHmNT7T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD81170D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-286406ae852so818551a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381604; x=1701986404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=LzHmNT7T9OxxOb1QquTvMGrKV7wO0Sg+X8fJAEm9yzvP8KnKNb3CA4s2nDgc8XBwBL
         wbAnybflvTHmu607/EUPJZjvJsmGVUdEBFA46dSLXI/RJo48n8Y/NsYGqhB2tRXVMeNE
         4xM44BLmBeptCJw0drtptkUFx+WIgaFzGWQ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381604; x=1701986404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=Oai3zHcXYwB6qMX++GSk1afrgzqqEy3Bt9DNhwVqaXH3JN9jKpvniCWMLj8qTrelee
         ckuZAAW/sGKTEQvuSejyv0ArmRJRslX8/OAuWyErJYIdlnpqvD8kxIuPGuo4XSO3q/pR
         QNRiWnwKgLfGO8SyHOk1Eajs/Uf1SMP7iEAJEMbzhpO+17ijNc5WNDEHd20gl7Ne3Eti
         hhY9qNUmsdqzpbm1qC1vyG/eCu7Nkki02k/uJcqtnKow1sNsG+sHfPkYpq+6uyXEWys8
         D2Ev/QZt6+zZ7aQOZ8zX3ZOfm36CTTkovVGP6E+ZULIkQe4B2uu3/xYdQraxpEK4+LKC
         PAsQ==
X-Gm-Message-State: AOJu0YwvdDH0cxXwJAriUOtlhYeL9LhmAjGkEBY9ZPuSqwMNwtOb2+kl
	cVKWHW82cz23EVHO5r1t4NSprg==
X-Google-Smtp-Source: AGHT+IFFUtQvkutbCzwEJYcxjo8NsuSrn4mGmVkHUogFLPx4tF/QDvpCKAlGy1xHzlefkRb9ZtgYRA==
X-Received: by 2002:a17:90b:4c4d:b0:285:9a33:258d with SMTP id np13-20020a17090b4c4d00b002859a33258dmr22743450pjb.44.1701381603922;
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001cfd2c5ae6fsm180457plb.25.2023.11.30.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
Date: Thu, 30 Nov 2023 13:59:58 -0800
Message-Id: <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Oct 2023 18:56:50 +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
      https://git.kernel.org/kees/c/f1c7720549bf

Take care,

-- 
Kees Cook


