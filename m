Return-Path: <netdev+bounces-55608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6C80BA7A
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B31F20FAF
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F109882E;
	Sun, 10 Dec 2023 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sbKdgQkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB46B102
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:47:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so6432635a12.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702208875; x=1702813675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhgVSRdRn3llWlJ8OJltFa9MozC9c6edXtDwjxY93s8=;
        b=sbKdgQklIUZn0lTkDF4migF56blM/jtl1jrrY3BoFh86an9Qk9NVMNthtqi7DXua9f
         qh/q20LDlX88utU1xLHoBFSqmYvTwMm9P6V4Np+XxYeJOdbvCyU6cKM7GD1rbjKg8XBs
         zMwNr4Q7EPMcnTRvAClv9YspTW/T0ZmPKuL8OWw29O5cQZBnQDwRnwyOck9LckjqzXcJ
         k4xbPeKA8C9J3Tf6U6WVyJLHMeLUsnXGdPESZBuTIu6tYeEBp2EXzSNIP5/cEKv6tJKd
         OkXxPLjPAokQ6NZLGG6vSpJfygJvABw+CvzR/RXWJbaE/c4OcApktgM3pLcu+9ROfj4a
         WhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702208875; x=1702813675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhgVSRdRn3llWlJ8OJltFa9MozC9c6edXtDwjxY93s8=;
        b=VeuePFQHDFTmmSqmMIfzJ5XySP7qlYXBi1O7ePpXw0djpPEf+Y113K5aywlLC9a5QJ
         A1qU0Zv//utUVRZX2PKOXBr5clkxXMmXpjKjmVU49fPNjcdPH3p/Fdpy/v4BqjqFo5Sv
         w9px7dggl11upWMbyYPPpfGgY5wCt0YJ8QnRD/wKSvCFwc5gkyKTcDqpx1KnSchiz9km
         MbSTRwtFdAhnfJTdWv5CWVITCxCV7U8ZyotHK6bzNR4jwpdU2OzaQpNdIAEebFsuu8x4
         w9XszHdciGoaQr/75RLYA2aiw7D8bS5CpqUTyyka1h2G1w2ZIq1Nx4MZQ7ewWw5ba8V8
         8Uxw==
X-Gm-Message-State: AOJu0YwuSgsnzoiGe6Zu51yuHxsJD+43o6V6yYMyn4L0GLQQh+JBaNnH
	+3wCW3BmXwGMSkSjzpvjwDisXw==
X-Google-Smtp-Source: AGHT+IHN+xNmkqJntnXrDnI+KIGsCJqBVZxUfJzhQ0VEp2Yyq6h8foUlLyN2cwDG82FHYDRa2JxEdA==
X-Received: by 2002:a17:906:b1d5:b0:a1d:aaa0:ce10 with SMTP id bv21-20020a170906b1d500b00a1daaa0ce10mr3241644ejb.71.1702208875241;
        Sun, 10 Dec 2023 03:47:55 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id mm19-20020a1709077a9300b00a18c2737203sm3347832ejc.109.2023.12.10.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 03:47:54 -0800 (PST)
Date: Sun, 10 Dec 2023 12:47:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next v4 4/7] net/sched: act_api: don't open code max()
Message-ID: <ZXWlaZR8r2IdBqoa@nanopsycho>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
 <20231208192847.714940-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208192847.714940-5-pctammela@mojatatu.com>

Fri, Dec 08, 2023 at 08:28:44PM CET, pctammela@mojatatu.com wrote:
>Use max() in a couple of places that are open coding it with the
>ternary operator.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

