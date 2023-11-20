Return-Path: <netdev+bounces-49211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E97F128A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB41F23802
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9118AE7;
	Mon, 20 Nov 2023 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjzGLaUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68418E
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:57:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9e1021dbd28so581549166b.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700481422; x=1701086222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idtaMT0TZCi8eycLxWEoQILmcTeXDyshGWwO4lkIEzo=;
        b=jjzGLaUvzROhqXzvzhEs0SeX14hGYjw2cVr34t8wx/v/n+OYqEjtNhW0HEG+9kwBD4
         V1W7h4WPykRLNhLMBfp1Y2v97ZPEo2ku1XNR/Wfui6dpBnuq6AJ85f+6IHqjbJICgYUW
         rVOwEcJIMSGiQN89nEDufN8YqASszBVMxnsQBv2I05QHc0HAe/6oRbTFjhngb7UPg6Oe
         8Mp+FyipY1to40ziREdb0ebY73Kr9pAhu6cpXleWIteUuRyQxw0Q9IEKVWAMfzTJwrvF
         nXbORfV/h03hTxHujrN4pTCjaMLaNJEeaiCfWyv3fa44daBvU84xrfHMVMJ9r54ZICkp
         1DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700481422; x=1701086222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idtaMT0TZCi8eycLxWEoQILmcTeXDyshGWwO4lkIEzo=;
        b=uE2dPsNzfWFr9S/y7coa7axfdiVE4ZlZW52s5h7Un7iPgJdUwQcbCq9iblgqJ1HBEu
         4VxndWeedAl9jelT2xmP+JCsLnAJKlTLf4CcIubqCDCWfCAFHCekb1p1hfKOiVkPF5Eu
         wldHEzRJBd6BQgcVkZBXx9pKx0v802tUosGgmS/vgarHfcwtsdHpR8qieuUQkaoQoALC
         D3Oz6jtBTBV5/fw5TtuxWJ4+ggtvJPKkijEQjFcaMn3FVhzwqG3ZJ5HR2A2RPUrfW9ND
         jamUWaqs8ww2EmDexK0a4DJld4qolCvXU/kFtsJKb1U/lgLFEbIArIwDATYGz9CeQwBg
         J7Ew==
X-Gm-Message-State: AOJu0YxCBmG34tzndPU8+Te3w7vrkYjBODh1YJ2Od35ri6ZRu0w57pYF
	AoxW/hFgrutBlliQvFQ763IYFI81J9s=
X-Google-Smtp-Source: AGHT+IGeOmRTNm4SEERfG7V+AtLUtY+HBYi0etQjpjb9w5sXnHd3OtHYkicWzWI8Idu50J16aCRl0Q==
X-Received: by 2002:a17:906:1011:b0:9fb:a597:ff42 with SMTP id 17-20020a170906101100b009fba597ff42mr3622193ejm.53.1700481421849;
        Mon, 20 Nov 2023 03:57:01 -0800 (PST)
Received: from skbuf ([188.26.184.68])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm3798999ejm.6.2023.11.20.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:57:01 -0800 (PST)
Date: Mon, 20 Nov 2023 13:56:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 08/10] docs: bridge: add switchdev doc
Message-ID: <20231120115659.hlg3e2o4o6c7pxke@skbuf>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-9-liuhangbin@gmail.com>
 <20231117093145.1563511-9-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093145.1563511-9-liuhangbin@gmail.com>
 <20231117093145.1563511-9-liuhangbin@gmail.com>

On Fri, Nov 17, 2023 at 05:31:43PM +0800, Hangbin Liu wrote:
> Add switchdev part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

