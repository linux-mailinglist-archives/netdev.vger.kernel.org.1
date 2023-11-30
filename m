Return-Path: <netdev+bounces-52711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C947FFDE2
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2218B20F7E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5155A11B;
	Thu, 30 Nov 2023 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Udz4MS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B591737;
	Thu, 30 Nov 2023 13:49:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33330a5617fso54382f8f.2;
        Thu, 30 Nov 2023 13:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701380982; x=1701985782; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2OoZwSJUfIqZQwBptojEqNEhn+UQMwK+7zIqY5foD0=;
        b=E3Udz4MSE2+e8vaZP+JGP9e5V6ZN70z8UEcXzwbE5WEssLbVFtk++//QTtG088Rdew
         Llx6wZK2hIx3fX475UbsroVj0pOcomZ9UjbzDa1QFXMqkCT26SqGvWIcD3qb+QgEWa6q
         DzThPJTb0Ljf1yX73f8lp4P0t9S7xHJ2thuqymufbKbI4jlTMBAtQxmS0eGbuNdEizTT
         TegiBctwswgayNkMPoFOMchq7+GZpbw9jrilqdHrNnJwwmyleOCAgod7mqVu74j1DvxE
         3DK0jRgkTzNsCi275XCyazf7GDZo2QiT0t9B6n8FXT5aTnbS7xqU7jRAwz1xcrZrD4qF
         niPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380982; x=1701985782;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2OoZwSJUfIqZQwBptojEqNEhn+UQMwK+7zIqY5foD0=;
        b=awWEPt3EUSCxTEdo1DZAunltlPGk1Z6EZwlsc/q/JQs3PDOerxXdzG3WTzUtyOd/3x
         zc/M+0FJTqlORtwhsP1nswHux5IF6I3g9ptHJqbV8MfAWEfCYxRq8ZXzQYAGcAT4bs8P
         9eZvIfpO6K9dK7CCZxZqGJV+CFVsp5nSWoc5Nxrphjpl76aF8wVS6L1LBdgE3R22c61k
         CAZnNKZooJf4M/H41V5wIc3DLSvysxRyrG8fZDY2MNdncaJw7lYP6OIaNOiPxOBLbxjZ
         iNfJn3rueLzg01fL9Bd1dUyAurbD+ejL4xv7qQXvqcESgr0cWFs2oeuSDiwvmZylXut7
         JxfQ==
X-Gm-Message-State: AOJu0Yx6Uki8dmNqq2ICOXcbx95A2LBuFzVhIMwHjxSvWnS3tgW/O3R8
	uXrorUawWBYgQNn4v8bCyq4=
X-Google-Smtp-Source: AGHT+IHqLsELJY+jB+hoUDBKt4LlwCRnpvu2KKtFI1HLD3ruCqknr6ZKBtJo3PLWbW45Ai1GkLJnjw==
X-Received: by 2002:a5d:4147:0:b0:31a:ed75:75df with SMTP id c7-20020a5d4147000000b0031aed7575dfmr123721wrq.15.1701380981687;
        Thu, 30 Nov 2023 13:49:41 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b00327b5ca093dsm2509906wrm.117.2023.11.30.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:49:41 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org,  Jacob Keller <jacob.e.keller@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message'
 support to ynl
In-Reply-To: <20231130171019.12775-1-donald.hunter@gmail.com> (Donald Hunter's
	message of "Thu, 30 Nov 2023 17:10:13 +0000")
Date: Thu, 30 Nov 2023 21:49:31 +0000
Message-ID: <m2ttp27vys.fsf@gmail.com>
References: <20231130171019.12775-1-donald.hunter@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Looks like I'll need to resend because I got send failures.

