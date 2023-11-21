Return-Path: <netdev+bounces-49655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7232A7F2E07
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E113281A1D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06B48CD2;
	Tue, 21 Nov 2023 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nw8rWKpl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3DDF9
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 05:12:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a02cc476581so49616566b.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700572377; x=1701177177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8ta8vlDeAwijVj3ME/46Ae3fzlAkqbTXIt2pY9SK/A=;
        b=nw8rWKplpG4GHPadA6fMpgZOKiEjiKvpxErhUZvr0WZOExMctS6aWlYVW0d3culi1t
         b8QbL2FbztTnTYhiLxXd8RFtEUxsinsrdokghsC2PpHRF3P80goVUAeUxoqQKmOotK8v
         ODinvWuBPUua+v7vn8ErAD7yhbpiCkDl5IZer9QAXZwyETl/joBLpsxvkivDAXBy11bf
         /CgbPBCtsKjbPzMkiBtv+ed2/a9q6vCu3yFms+gstek/dxypf1v97g06KyAibsH4moQC
         Jxt6lAPozWkZvC2WUuTzCpM2LCs2D93qwkakt4/OE0DMz2+fWD6yV/pKr824F0pICGdV
         sMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700572377; x=1701177177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8ta8vlDeAwijVj3ME/46Ae3fzlAkqbTXIt2pY9SK/A=;
        b=TrqWTzJm4TITWKyNdu5L+cyIxLoaMreX31zwbO51CwzVdDVuyh0wF1XEpBbpZEPwpN
         NOKg4NcRN6g55PH21V06cQ1wo4qJBQpgKJHRI434LoH7yDgR1eRC3t2RAz6gpPUxKz7Z
         4Qp0toA3hWnreg8JMOxRr+CofzPtUPiYY16mvNPYujDAOtJC/hzuaYwdncnFv/xkJxbb
         e1dA4DMh9kGTmTr0kUxeLPxjavbqRmfE2eAqujVnc4hrqrWBJHVcI3C09YqkPnIHqPVH
         vJEbT2sZcOm51A0PO25i2HcaSiwnSmcTRccolh+IhZ4CRPLe1IXjnE850R0NFdKdUcnL
         RpZQ==
X-Gm-Message-State: AOJu0Yx5mKHd/Dc8nK/GmUQ66oRVlG/oqZDTPOZ2JXsrTTCeipe63bPY
	ku7Utjcb3HWSiVeeIEy92P4DLw==
X-Google-Smtp-Source: AGHT+IGmiFQxuY7DuN+RQ/GIFYzzuQ8fP727wOReH9t1Km2WdyepKdoVsgqymgds2BdTBcHShIGGew==
X-Received: by 2002:a17:906:2254:b0:9bd:f155:eb54 with SMTP id 20-20020a170906225400b009bdf155eb54mr7384606ejr.6.1700572377517;
        Tue, 21 Nov 2023 05:12:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090637c800b009fcb0e0758bsm3101792ejc.195.2023.11.21.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:12:56 -0800 (PST)
Date: Tue, 21 Nov 2023 14:12:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZVys11ToRj+oo75s@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120185022.78f10188@kernel.org>

Tue, Nov 21, 2023 at 03:50:22AM CET, kuba@kernel.org wrote:
>On Mon, 20 Nov 2023 09:46:53 +0100 Jiri Pirko wrote:
>> If any generic netlink family would like to allocate data store the
>> pointer to sk_user_data, there is no way to do cleanup in the family
>> code.
>
>How is this supposed to work?
>
>genetlink sockets are not bound to a family. User can use a single
>socket to subscribe to notifications from all families and presumably
>each one of the would interpret sk->sk_user_data as their own state?
>
>You need to store the state locally in the family, keyed
>on pid, and free it using the NETLINK_URELEASE notifier...

Well, pin can have 2 sockets of different config. I think that sk/family
tuple is needed. I'm exploring a possibility to have genetlink
sk->sk_user_data used to store the hashlist keyed by the sk/family tuple.


