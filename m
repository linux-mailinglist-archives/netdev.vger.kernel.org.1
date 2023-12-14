Return-Path: <netdev+bounces-57496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5449813308
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37837B21733
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FE59E4C;
	Thu, 14 Dec 2023 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsJPnZ2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151E9C;
	Thu, 14 Dec 2023 06:25:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e2f34467aso750445066b.2;
        Thu, 14 Dec 2023 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563914; x=1703168714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=palsx5VIwiV3lVq548jtGUNWQua/RNNKDbImyebYbPE=;
        b=AsJPnZ2rpPZ6UI99MxQUtqXLXf8HIpaSNotSrerGA9FrRo9mNyZRO1aFNaCx2q24W8
         woohfthYgqA07g0HQLGVne6I32eCq4sYmwFslsVglydfepXxiOQXunfTSZlIqV8L6Vut
         P7uAurRl0LxQU+hoLGbY14SWCw3HE+xkiyWGou316X5WmkXT1stWKJN+qj9W5dk84iiy
         MU7jCzlaiu6oi04to7NZ/L5crloiZUTLOliLPLzITXKfWr7Rhsm3pTmY5+fcYF+yb1kT
         nV/+LPArS9Mq7iBLLC/Psc1/+WI3tARmmQOllpUQ32kzRpMUlfM+142cCt81+eLiC6Vx
         oBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563914; x=1703168714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=palsx5VIwiV3lVq548jtGUNWQua/RNNKDbImyebYbPE=;
        b=me9Y+LKRQjnM5+n0oI+uUl5BbEzvBQIqjDvMnRkkqXRv1vqdf9M5SjChjImM2qrSwl
         jiB8JrqVqopUmXW9L6WYu4oIGJq/hMPCjblecIp8+As0nGJA/3YAJTReNuKg/G9/YnMm
         yWww3szcq//IvEFHbTeOA198boLq6tYSRAnCmQHLhhfP+H8ZMYdm1Yy2ALNJO1np+gjl
         8yk7M6FSU/gMA2k6teWreAem0IZJZRBEmDllL3A7nioblpeEVYeNXYxL4UA7UX4mEkUT
         DjwzZg+FME3qB5VKlCK4zEUiqtRZn0OBm6JBa4wR1myt1JlEpTkMHdNI2QfSgTZoPqtC
         EudQ==
X-Gm-Message-State: AOJu0YyELxlT+W9gNbukH6S2x3QWlTJlGBbS73qRexRRApM+KsFoGayk
	oj2Pa7Qad92g0XRMRlYYvN5ZpM/vHPgYLA==
X-Google-Smtp-Source: AGHT+IEK9LX+g/G+1zUGApWd4RjRWxnVcnFClxY6nAZFvzYL5F/Zi1gKClEoHSDV2vUxB9Wf1eFp7w==
X-Received: by 2002:a17:906:29a:b0:a23:f3a:d997 with SMTP id 26-20020a170906029a00b00a230f3ad997mr617781ejf.75.1702563913837;
        Thu, 14 Dec 2023 06:25:13 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id tl1-20020a170907c30100b00a1c8d243cf7sm9409988ejc.2.2023.12.14.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:25:13 -0800 (PST)
Date: Thu, 14 Dec 2023 16:25:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: dont use generic selftest strings for
 custom selftests
Message-ID: <20231214142511.rjbr2a726vlr57v4@skbuf>
References: <20231214142136.17564-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214142136.17564-1-ante.knezic@helmholz.de>

On Thu, Dec 14, 2023 at 03:21:36PM +0100, Ante Knezic wrote:
> if dsa device supports custom selftests than we should use custom
> selftest strings for ethtool.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---

I didn't notice when the selftest support was added that there is no
implementation in DSA drivers of custom ds->ops->self_test(). Adding
interfaces with no users is frowned upon, precisely because it doesn't
show the big picture.

You must have noticed this because you do have a driver implementation,
so would you mind posting it together with this fix?

