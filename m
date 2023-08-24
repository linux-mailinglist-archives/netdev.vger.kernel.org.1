Return-Path: <netdev+bounces-30356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FD787020
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4A21C20E5F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990F28903;
	Thu, 24 Aug 2023 13:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22EDDB6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:20:12 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77719B7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4018af103bcso3560655e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883168; x=1693487968;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isRaS5/TYEaXROMP9xb7ur11bp+XGHK+09kyvBXqy6k=;
        b=MvKvQCysOIpVgg+z0eBzGTSLiHwfiF4coonwdbqDOWVuaI+xUBfaFiZFg8GcPsYRO2
         Ni51+jwqeG8T+YHNKdF5pd40es/BPduFWN+Nti0s5AnbyUsDKWDRBrgfbaKZPf+3y9I6
         Xir5+Y/0q2Z5JrluKPaRODtfwmVl5aPoLXfQesKf/GGP24ysAArbY/y1qjDDWLjMghTC
         E4+HUATiXWoFUcaxkjogHja0rJacx91fnOHeo8yRGK1dMKv9SjgiSWJoChCFNCN/HoEq
         yiv/BTxJM6v5kX4+vzkQBxlVbYuOj5dr7FQGXv4UaCxdG+xWbEJlpSehifpH0KXHXde5
         QGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883168; x=1693487968;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isRaS5/TYEaXROMP9xb7ur11bp+XGHK+09kyvBXqy6k=;
        b=k6r2o6HZfhRn9TK526obXlcyMRp1thVQ7y+mWm+iN/xlqCMyInyeASc4u56+LLdz2p
         YBfSblVWmn/gZhl/QnqUgGnexmuipVfC6gcuAOVBEG0VgLUTQ+wuTRpH26oizfKeORyO
         KLH3HqoPOnqq0IEFfD6KxxtciXWWcdckcurDBdKsqseRC2pnMZE6XGlt34N0fFCcw/QW
         kCYNoBMJyBYPRhBb5YTL21db0HcRsEXdBideLwvmPBkiRt/svUHUDYUlRE/DPDWcUDhw
         TdBgn9ZXzg5Y+xb0hcl1DbsYmh4gY9NyOypA+f3EvnfW3e08mLvawu1PvXD/+MDi3D++
         1B3w==
X-Gm-Message-State: AOJu0YyIXHbmQJTL2Ao4apg0lVkWJ/0k49r+ixwDtYfEWpGozt9HAZrG
	ohsMun/dutX5LZd04jSj6Gc=
X-Google-Smtp-Source: AGHT+IEmUSwC9E6sTpu+nkUUu3SoeVt6Z7uhd6KVBrgsE2buO07T5xiGuv/Hu1v43FAseSyufA4P7A==
X-Received: by 2002:a05:600c:1d1b:b0:3fe:d589:ed78 with SMTP id l27-20020a05600c1d1b00b003fed589ed78mr10934669wms.20.1692883168200;
        Thu, 24 Aug 2023 06:19:28 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fc16ee2864sm2582580wmr.48.2023.08.24.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:19:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 3/5] tools: ynl-gen: fix collecting global
 policy attrs
In-Reply-To: <20230824003056.1436637-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 23 Aug 2023 17:30:54 -0700")
Date: Thu, 24 Aug 2023 14:11:17 +0100
Message-ID: <m2wmxkfuve.fsf@gmail.com>
References: <20230824003056.1436637-1-kuba@kernel.org>
	<20230824003056.1436637-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> We look for attributes inside do.request, but there's another
> layer of nesting in the spec, look inside do.request.attributes.
>
> This bug had no effect as all global policies we generate (fou)
> seem to be full, anyway, and we treat full and empty the same.
>
> Next patch will change the treatment of empty policies.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/ynl-gen-c.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index e27deb199a70..13d06931c045 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -978,7 +978,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>              for op_mode in ['do', 'dump']:
>                  if op_mode in op:
> -                    global_set.update(op[op_mode].get('request', []))
> +                    req = op[op_mode].get('request')
> +                    if req:
> +                        global_set.update(req.get('attributes', []))
>  
>          self.global_policy = []
>          self.global_policy_set = attr_set_name

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

