Return-Path: <netdev+bounces-49206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F637F1245
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5EF282630
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D66154A6;
	Mon, 20 Nov 2023 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaDZhWbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1AD2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:39:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso583431766b.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700480390; x=1701085190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkNMkaXFAUH6KzOJpWbwh8BnUkQDwiCPccByhYMnGmo=;
        b=BaDZhWbmf6mw2qosoeVlHbxUh613nWJU5cqkwTKvKr55NiuIaHlnLg3/zU/4mVycCn
         Zh9fyG0yWHU92j4cqJE9CfkIf3/TBLY9N1qXlL8X1xY2tPFGvrRyY/KIpkuHSh7ud/UH
         9AXMonTio4uJGt/rK0M7q79txiFQ5xy44mdbY1o9nwvGaF607ZIsi7TWzbFNJc7uEfTP
         HDMzY544kYpwE5oBZH294zsT2abkJuDfZpoVmi34Pp3wfzVEJoA0U8TQVKO32s1VYz2y
         clsIUCn5b6PIiV+ZE0aDpvSqj8rq/1qwmw9XIY/mByWo0GiExNmUpk4eFeTxnGVpohC7
         DDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480390; x=1701085190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkNMkaXFAUH6KzOJpWbwh8BnUkQDwiCPccByhYMnGmo=;
        b=S/Q48phRA+/F1wiaznjzaeYYiUGIiwerEWEct5z4EbNK4E1TRt4Lun4akCMPSgPGlq
         ZgigQSazJB1SS0JiptoYQC2kDL9d3gc/3g6HNrk75Fs+sUHvZCCfYmm4kYQOqbxN1sQa
         qZW0UZXywPYRvHwwsjK7P9qZ5IsWTFmXAL27ltV4jhuW1HDr8bNxQhXGoebFf47arDln
         wmWAAM5t/IXT79iYz32wmXl9/qpPIxpT63FyltvQgkCuGFCnP+yMuw6v2ifyYz2I365e
         srJpJKRfpvQnw6Rt8p24FKZiFiDsJ8rxWmjYqB6vyR3Znwr5VYMZgwxQQ0Jgu3hLSZhm
         XFig==
X-Gm-Message-State: AOJu0YwnGkVvuQrwv0SbQdgJf9iu0ofQdWyqwxfFhm+n+T1uND3HU0ce
	hRjNSDloxozTWQoRMIhde6s=
X-Google-Smtp-Source: AGHT+IEyf4bGQKVRw67YWCUw4ovezudIq12xfinmFN8zw2QsGzgqLpm40eZE2t8MFGTQ4dqgZU4u4g==
X-Received: by 2002:a17:906:b010:b0:a00:a591:929 with SMTP id v16-20020a170906b01000b00a00a5910929mr198610ejy.24.1700480390138;
        Mon, 20 Nov 2023 03:39:50 -0800 (PST)
Received: from skbuf ([188.26.184.68])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906158d00b009920e9a3a73sm3818358ejd.115.2023.11.20.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:39:49 -0800 (PST)
Date: Mon, 20 Nov 2023 13:39:47 +0200
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
Subject: Re: [PATCH net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231120113947.ljveakvl6fgrshly@skbuf>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093145.1563511-6-liuhangbin@gmail.com>

On Fri, Nov 17, 2023 at 05:31:40PM +0800, Hangbin Liu wrote:
> +STP
> +===

I think it would be very good to say a few words about the user space
STP helper at /sbin/bridge-stp, and that the kernel only has full support
for the legacy STP, whereas newer protocols are all handled in user
space. But I don't know a lot of technical details about it, so I would
hope somebody else chimes in with a paragraph inserted here somewhere :)

