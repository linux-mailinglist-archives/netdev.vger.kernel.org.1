Return-Path: <netdev+bounces-51877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0C7FC9D2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B1F1C20D3A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C96156F6;
	Tue, 28 Nov 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FkTvYSA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8E19B4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:46:11 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c398717726so5144469b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701211571; x=1701816371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQD4qLJxXNQxzPigoQ69HS2i8COqOs2Rgp/cwXr/MWk=;
        b=FkTvYSA5dF/4g//hLkbocWlRKlOrnRQH63VXfnGo+pAU4NdFjfJeIa+Wkryfi51a0J
         W8jJ0ZhrY4DNbyeDoHPttdJVXDzzhsFJYwiIdq/kS9KKQ+z+dM1VdeQQnMcv3ko0bUko
         5329f3TWixBDLlFNKXST1DZDxy2YcVVA5PYL7eAl5/P/RoKA3kpCQGxXTgyCIRxZRV6w
         O+LrgWuQVywu0+2xHTs+igyF0TuO5UriighUccs5UKsamn0x8RV9WlnNkH56YHngBr2z
         1Cb4JYocLzsuLB+tfZISqJ8Vu+IJoPwhfs6qMKpmNru2g+6mgk7DFzeN0+BceGen7jXc
         8GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211571; x=1701816371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQD4qLJxXNQxzPigoQ69HS2i8COqOs2Rgp/cwXr/MWk=;
        b=Msvmzc7coY2dTDxS8i2FD4ac15ArjgMblrPwIChVBaMDjATzQyTo5FadFupKLFrB+Q
         C+qG+wQAjHlUL/vpmyPXPmi3aVz/jKQZTst5qPH835DqbkgbszpJSgGeCTCht2Xk8kLC
         SoeJRB4abTcJoCdhHCdYZJaIgXSyMgy3f6EupJV3l5EwETVisnefSAjLpghNHX6a+uxl
         XMNCiR9nE6JnefsEMr3NAAWITnj1M3pkSlMXODbLkwg81xVMyVLeXkPKPoTJS0kPUq6f
         5b+7W4PJKjxo2RXKZ6BHd1XsNUsKFAi+2Paap3QOS9xgv7Rf4lWB8e2ixeu1gWS8I3+g
         THXQ==
X-Gm-Message-State: AOJu0YyR5xa1pNAqbobxWwO4px2Ekx41xpj1ZJiHBLdN+kpVG6xuPB8q
	6a04N1dRgMDwMumPGH5GxNbPfA==
X-Google-Smtp-Source: AGHT+IG5NsfH3yF5JVNudbx0qkM9if//rca+LfcKZpS1uE9SldtHzAd2errg/dX+A52G+ZR0VhVqjg==
X-Received: by 2002:a05:6a20:4418:b0:18b:37b4:cb6b with SMTP id ce24-20020a056a20441800b0018b37b4cb6bmr17411628pzb.27.1701211571330;
        Tue, 28 Nov 2023 14:46:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id t43-20020aa78fab000000b006c9c0705b5csm9349304pfs.48.2023.11.28.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:46:11 -0800 (PST)
Date: Tue, 28 Nov 2023 14:46:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 01/10] docs: bridge: update doc format to rst
Message-ID: <20231128144609.08b4275b@hermes.local>
In-Reply-To: <20231128084943.637091-2-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
	<20231128084943.637091-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:49:34 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> In this patch, Convert the doc to rst format. Add bridge brief introduction,
> FAQ and contact info.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Should also reference and borrow definitions from the IEEE 802.1D standard.

