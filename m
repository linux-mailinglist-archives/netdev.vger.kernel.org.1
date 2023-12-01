Return-Path: <netdev+bounces-53025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5FD801224
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C864E1C209BD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6484E636;
	Fri,  1 Dec 2023 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mv5dMHa6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0DFD3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:01:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b57fa7a85so14771145e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701453671; x=1702058471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OUpzzbynYVylOZdAkA+/Oeq4bUwubW9fQoEVws1J0c=;
        b=Mv5dMHa6mwKqXNVt4+6AfxvAqY5m7sjyWjTBS11ykTLb4XS5XbNaVL1+hofrte3q6T
         XYPvlLS0iEwifOogSK7i4GdAOiSofvV0oraAsjOyDQ9jWnKTRmRQa2fSmgwZCUpppZgM
         K2+YfNpkDj2l/fBciftbqGw9+xF8ieYNx+N6D63KXrsaMN/vVC64kxp9essgC7AVVmLF
         em3jRc66bq3uPDjfqjQaqgtMzVwpwunRxBB3k/IO7NSdoWsqnDN4XSeLFdatlFwzmJ1d
         TrXxW5z0TClwxxLwgMW/wjdOrK7D2+CYNlr4bJNXcN0hCD3op2eQv7rbM8WR3pl+J08u
         A8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453671; x=1702058471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OUpzzbynYVylOZdAkA+/Oeq4bUwubW9fQoEVws1J0c=;
        b=ssNzmEFw//pWyzPtieb56hsKvWj76Vo0rrQRUAMBpubKvgpVfuKS1Rlt9zb4MFpI5P
         WY15n+rXh49QpcYNYSsOFdkklzIGTJBcBeH9sgZhlPUZOfHNwpZHkXxXJgSTZDTwnikO
         1HDw9ZqbB791SA6aMd+OtJSq91LEcBmQ3OcS5bK0kkPD6Lb4/L5vUaJfypUPLr1Lm8x/
         DzqAFbBQryvYDMfV0HcP+O2us6NzKBu+rEtFEuMMzx43UZXFRX+iVfCXggKlY1OaSDpR
         bgev3icyy9EmjgweUves6RWR3fuehyU06XO4zpAgS3IHXvse+pYe5rauh2iOetHRYnWQ
         YIhg==
X-Gm-Message-State: AOJu0Yy1tkUlwfblUi++ujk1f/cyM/OYfYrsO2ajVirKyhR44gcZC29Z
	s9ZIP8IUbA9mNmoRthkK/MULnsIGQgSye9h886E=
X-Google-Smtp-Source: AGHT+IGvR3DxjUPC/ik19L0UBDNYn8X9azGDL+iB0PcBhgFwnMuL5PZkijML08MPkk+haGfSKZXunQ==
X-Received: by 2002:a05:600c:1382:b0:40b:5e4a:2353 with SMTP id u2-20020a05600c138200b0040b5e4a2353mr1041079wmf.85.1701453671162;
        Fri, 01 Dec 2023 10:01:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b00332fd9b2b52sm4793200wrm.104.2023.12.01.10.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:01:09 -0800 (PST)
Date: Fri, 1 Dec 2023 19:01:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next v2] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWofY7Y2i/doBhOu@nanopsycho>
References: <20231201153409.862397-1-jiri@resnulli.us>
 <20231201083803.0e9ccb6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201083803.0e9ccb6b@kernel.org>

Fri, Dec 01, 2023 at 05:38:03PM CET, kuba@kernel.org wrote:
>On Fri,  1 Dec 2023 16:34:09 +0100 Jiri Pirko wrote:
>> +Note that some implementations may issue custom ``NLMSG_DONE`` messages
>> +in reply to ``do`` action requests. In that case the payload is
>> +implementation-specific and may also be avoided.
>
>"avoided" does not read quite right here, perhaps a native speaker
>will disagree, but I'd s/avoided/absent/
>Feel free to skip the 24h wait if you agree

Okay. Will change and send v3. Thanks!

