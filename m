Return-Path: <netdev+bounces-145252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32C9CDEC5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8293B1F22169
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ECD1BBBF1;
	Fri, 15 Nov 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KqkM5pjN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DB2AE77
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675504; cv=none; b=WKtrW6zoTwR1QvXSIvIucW4fRKoz22DDwk8o0IBmqXSixhop+OXCZmJpxfGWgKlLXd635Wd1DEYJRzi090FlZ6ag/0HhLDKGLYs4TB71q8qkRU4FdE9EUQEs3rCXVxyUvIcHmXrtXycbapIVwVbDFi6KE0GTAir3Fx/40aYAIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675504; c=relaxed/simple;
	bh=T7+FaUkiWl6llUC9etvdUsLjNNZAuM0Mv6cs9YXEBuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCM7hmmjtruaSNG0Xi84GTGTeKdahnEwnAMrHfXM7m/5DLKpafxoFajG72uqoC+ViWGa5Rnyw9LwhSGewZTKlRxAGuYYVHRiZoKE9uXfi2wVysMt8Wi1UbGQkxzefjqBq7/Lfa5MXNkjcaUknWP/pVy3sYB957I3nRE+Ch0EK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KqkM5pjN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316cce103dso19009135e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1731675499; x=1732280299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LATebKBxDaIk6D3JrYJEvHk+UJKBEff3u95fsp1HNW0=;
        b=KqkM5pjNzIsmEWVF3rxX9efVyPiPmWj2RU9Br0wuir/nRUO4ho+cd6JnCXG7g5x1+q
         N0PhblMjCQz8ewXRPWBiSLIA+/q1FcJ5sn02Pu0YOkPFc2ec1u+Qlp4uE3FmuKftAipm
         AupHyY8UONAnO314tmMx3rIrkqHJNIIdRk7VzJi5OL8a1vTumSSV47dwasyuuP7+RFtK
         tnCthNnN7Csj6m668XmqWIkkvAhLRa6e30D7hnyoPtK60gg/5hQX9KQeCaylfxGQISnA
         5J3cByRgGSLel+VKoshgNtfEHF/08HqwfbgMoA1I3Lq5/5kMvYvA53qeT2F1uOd2me/p
         EnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675499; x=1732280299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LATebKBxDaIk6D3JrYJEvHk+UJKBEff3u95fsp1HNW0=;
        b=dP+sGQiCUUxelz6OCARSGxyd7ki0g/vgvjqdeFSe+6K1xqyUJl7rO/E5GUHwSKHdDx
         EqKZLHa6PgkDlhAs3sGZ+JPkjvLUFKcsmZUWmhYqEesj43NKSL/U/A9l5Rf196s6x3Dg
         6ddBNxT4e1QUiKpDfiHcBvf/JCfEW2W34x0C8F4j4+XscaJVk6/2T5yXdFJfH8UuPk/4
         qD3cPq7d0OHg2CXe47p4gvsGwGp+HMj3yufQCX2aosmRhneKPumWkgE4yu4mTFXY+O+F
         045w3PGz+WBL/odEgAEemvcSufJ8gs+MMDJjP5HP89RBe5+wvFFMyT9+RzXWZwTT4w8r
         rlpA==
X-Forwarded-Encrypted: i=1; AJvYcCXOPYy36e/ZskcEJgq9Syb7+XoZjk3so+ZmwJAGOSKw695iS8Mczm1RxmU0vLbw0o7n9rzrGWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0bMnv5DLVPdgxVu8T4cxcdHEhzLbvStdiY9jmwHUkTh/4JUh
	x/NT2UAWi8zaAX47jJr+2fj4jdSnM5Eri9qKDeBo5gWlnXHNj2qqFfMOaKStTwY=
X-Google-Smtp-Source: AGHT+IE07xCnLuHSij9q6rzyJFqB1X66556829oxrmK+6mtDEad3LN/8cJnvCoQHflqnqWAx3mKeJg==
X-Received: by 2002:a05:600c:3ac7:b0:431:b264:bad9 with SMTP id 5b1f17b1804b1-432df743312mr25297405e9.14.1731675499295;
        Fri, 15 Nov 2024 04:58:19 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab72085sm55147165e9.3.2024.11.15.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:58:18 -0800 (PST)
Date: Fri, 15 Nov 2024 13:58:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH iproute2-next] bash-completion: devlink: fix port param
 name show completion
Message-ID: <ZzdFZ1C1te_eEQ5P@nanopsycho.orion>
References: <20241115055848.2979328-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115055848.2979328-1-saeed@kernel.org>

Fri, Nov 15, 2024 at 06:58:48AM CET, saeed@kernel.org wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>Port param names are found with "devlink port param show", and not
>"devlink param show", fix that.
>
>Port dev name can be a netdev, so find the actual port dev before
>querying "devlink port params show | jq '... [$dev] ...'",
>since "devlink port params show" doesn't return the netdev name,
>but the actual port dev name.
>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>---
> bash-completion/devlink | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/bash-completion/devlink b/bash-completion/devlink
>index 52dc82b3..ac5ea62c 100644
>--- a/bash-completion/devlink
>+++ b/bash-completion/devlink
>@@ -43,6 +43,15 @@ _devlink_direct_complete()
>             value=$(devlink -j dev param show 2>/dev/null \
>                     | jq ".param[\"$dev\"][].name")
>             ;;
>+        port_param_name)
>+            dev=${words[4]}
>+            # dev could be a port or a netdev so find the port
>+            portdev=$(devlink -j port show dev $dev 2>/dev/null \
>+                    | jq '.port as $ports | $ports | keys[] as $keys | keys[0] ')
>+
>+            value=$(devlink -j port param show 2>/dev/null \

As you only care about params for specific port, you should pass it as
cmdline option here. And you can pass netdev directly, devlink knows how
to handle that. If I'm not missing anything in the code, should work
right now.


>+                    | jq ".param[$portdev][].name")
>+            ;;
>         port)
>             value=$(devlink -j port show 2>/dev/null \
>                     | jq '.port as $ports | $ports | keys[] as $key
>@@ -401,7 +410,7 @@ _devlink_port_param()
>             return
>             ;;
>         6)
>-            _devlink_direct_complete "param_name"
>+            _devlink_direct_complete "port_param_name"
>             return
>             ;;
>     esac
>-- 
>2.47.0
>

