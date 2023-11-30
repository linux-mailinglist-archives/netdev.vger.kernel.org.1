Return-Path: <netdev+bounces-52721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB47FFE2E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E75281559
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111DD5B217;
	Thu, 30 Nov 2023 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bpbq/bd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D376DD48
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d04d286bc0so2753255ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381631; x=1701986431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHox1E9tNMDh2WCvlA3Q79O3YlEbU4KfGdr0hP3kvXw=;
        b=Bpbq/bd+YEvVDZmZExZw6n8VR5z9JHmXXOHYjYf+AkgtNPxAsudaH+gjAaMXBDF5+i
         H2m3vjiDe4WolZCkDR+THlrngR0sY7r/sXcyQRFs9eovX8f8WGEVhvWEo0tuqcxM8MGG
         qPzk7+MzcHLrFd7slFCsfNPLVsRgLRx3wi1pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381631; x=1701986431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHox1E9tNMDh2WCvlA3Q79O3YlEbU4KfGdr0hP3kvXw=;
        b=nCe8db4WNR7FMgIY20zdnda6XNv8ZVl04ma2nAbYMAkI71yfO7vZG6TkLNtL3bOeKW
         Tng8Hp32YgLJeIYd43AYeV9Oq6xsMrxSH5NyEcZVVb6eP0cNrrJE2M0Rc91rpgQatTpx
         RR8fuxyH+dDJChUJJAGU/L0WLjC8F8Cjx3wY5Y05ShJVXQTPL6ZQqpQk9TTujmVGlgFV
         AiSBNgKyh2UotuXjspnpZiadRwcPdYnlz121cvBxKiGUaasduhI4zs7w18eCcmqHFYfZ
         UJzsE1N3ayFJTW8sXfWme/sFtLkKf3N9jSxsjEWHsO1ttRPNMiV1AIQ9ECK9XsBhdfi9
         32xg==
X-Gm-Message-State: AOJu0Yz5ml4DNheMm3Hf3a3D9p0TH+Rx5t938rSovL5KqyeTWOW4uKqv
	8u0shGAvsi58GEDwlLUXmIOlRw==
X-Google-Smtp-Source: AGHT+IEtmHKikrS9bAIhRsCO0Z6yTqGcvTktzJ6uknKaVIdGzoXLj/KkG2DshpCtw3r39an85r8otg==
X-Received: by 2002:a17:902:ea11:b0:1d0:3f5e:d4c8 with SMTP id s17-20020a170902ea1100b001d03f5ed4c8mr3088019plg.30.1701381631312;
        Thu, 30 Nov 2023 14:00:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001c5fc11c085sm1870985plb.264.2023.11.30.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:00:28 -0800
Message-Id: <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 19:44:29 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect fw_info->fw_file_name to be NUL-terminated based on its use
> within _request_firmware_prepare() wherein `name` refers to it:
> |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> |               dev_dbg(device, "using built-in %s\n", name);
> |               return 0; /* assigned */
> |       }
> ... and with firmware_request_builtin() also via `name`:
> |       if (strcmp(name, b_fw->name) == 0) {
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] qlcnic: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f8bef1ef8095

Take care,

-- 
Kees Cook


