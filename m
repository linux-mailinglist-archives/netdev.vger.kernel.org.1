Return-Path: <netdev+bounces-90547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A638AE71C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB322861F2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB66126F3F;
	Tue, 23 Apr 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Sf3bP6RE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD2129E95
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877031; cv=none; b=ucIFXNkPO+SLBH6mHCC3T9HmVbT/XNoAqduEbonIdagprpWSbVTR72OsuqmubbC8SqSPgxKinWzHlH8Idr3+x7XSSpwztWHQxZEh+8W+ewyKFiUjXFg1hgVWs/Csaf5zvsYMq4UhG+KlIXoytqurTAfOhb4/rnl/n+hnBUVrUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877031; c=relaxed/simple;
	bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxYCmKp6975ZuPI0lhl9JeqD44IbKebj0nAM5Fu8FPnYtVKhNIFR2Q3+57sCWCOaglUUTyGKU1iaXyokeaOcXFVw54Luu5C6Yrou4Qsm3QMmPMWCwH476WJbuTP59LIn5ORJsa0EYimVitpPNmToL16SsdoWs7yjy8eG9i/UMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Sf3bP6RE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso8963349a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877028; x=1714481828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
        b=Sf3bP6REppNWDKaDqKfi8e2YqJpXSW+JNoQSU7qKOvQlLQlv/il4N3iQg4bxjmdH5r
         bprzyfWaKrSVyzHvYEPTIA9BafCusyNFsbRdqUFMdJYQDjFfRrSggzD3baIYAHnWzisx
         eMAOQXfH7LGWdPrlPnq1yET6I9ct5/RoUgJDx43Q1lgZbAVSS/15pK7SFGuqGOzWPKwS
         h0FBMHl0q9vUat8SYdEwDQwS3xGJKSlPubYM6JqHV2yXII3IYP7zKitPq0f/cs3glQLl
         xAOobh/1vOUnsIt3gO28nOBINyC6d6FENYyXMHqW+cZCwZdDSGbJgejfU9uTjDzG7F/o
         qfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877028; x=1714481828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
        b=ePq5nYCm125TT824qMCQQQURTdnRLxxAFTJr0Bukt8T943/FEGGFn2eo1qnt39z9RW
         vEWbt4KwZcsMRIXsH4PcVkbJSAVL/vlMBfs3pbNqntaz67VdCtnOLeFiANGWR8A8J/GH
         UHNu8zVxNufrg+KPygXfV7kk9+xGPnXB9Mdt9ZsuDAnxwo1MxjvTv4uTHuNcgHVGy3VL
         g8h4nVRyaBum2lzCVlzw13rU1EaxnJB7LKBxNqwioChfWAiCbazu5GU+nabg+sSk9DKP
         lvigw3sJzweqLVKtWhTsUinxi5ET7Lg+lUe2mg1aoxynr/hWl+RUPOWwK6r9/Zhuzc97
         Xqdg==
X-Gm-Message-State: AOJu0YxUKCB3LuBNDzX8T2Elfuw0JT8Ngyvqq3XWd69RtCFSyugfvwcY
	aRYx5W6Rla7WqFTcSWOWzmJrvMlUhof/Jl8GnKiTLnkeDOX1Uc+uWapDxqDw/6E=
X-Google-Smtp-Source: AGHT+IGK1ELuEtclHLgCVabv5MmGFAEEubLdqqJGCuRlvQs/jGoQmRSFLWi6waZWFO9QB7Mlx2Y9hA==
X-Received: by 2002:a17:906:2b14:b0:a57:5ef3:9a16 with SMTP id a20-20020a1709062b1400b00a575ef39a16mr2633205ejg.13.1713877027473;
        Tue, 23 Apr 2024 05:57:07 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a5880f8c84csm633006ejb.36.2024.04.23.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:57:07 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:57:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: flower: validate
 control flags
Message-ID: <ZiewIaho9AwDu3g6@nanopsycho>
References: <20240422152643.175592-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152643.175592-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:26:42PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_match_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_match_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

