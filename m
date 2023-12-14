Return-Path: <netdev+bounces-57223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5481261C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA4BB21076
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494D81871;
	Thu, 14 Dec 2023 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6aE/Xp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0910B
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:52:54 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9e2a014e8so5471599b6e.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702525974; x=1703130774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiqdwdOZ0FAsGmIOr/WB6FnKYdGFXUJx+JPX+VsFl9E=;
        b=T6aE/Xp6WQ1exMX5gFiOvde7/RUYvsNt0m1q8n6F3XN8L/BOw5MyGwsgT5NUqBMxA+
         5qAO+z/1lDctpW0naJm7BgaUCkyGnayKMeuM9or8Gw8qlWHP0Fwn1SbG5HLYnLENhqmN
         vNKr5GO42KCJRe/IRAnTuAsKg+DAPk2Zsbb14qhkDO0iSaehO4BqL5HPIo74e83XWbgw
         xg7IQwXEfEEsUVS4oIOWu0775nw5zPIYolpJXL1PEzYBB9JkBIVNfGYgbhHap7DWHog5
         fTnCgZx39vbStxFThJs5ZCWX08PagGYAzzZB2domAPVPUjYxDQhNTFYY86E3uAIuA1h+
         mBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702525974; x=1703130774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiqdwdOZ0FAsGmIOr/WB6FnKYdGFXUJx+JPX+VsFl9E=;
        b=SoJqv+DwWoh4RstHAUuqFWFdHuM5JmLb+Oiv/zxwASaDZrJFHN2WoC5hXxfC9V8yo5
         1LxMMue7GLKihGhXo35tKr82vGev5NH0/Lul+UlsmlRG5zdn6JULWtllqwKAqWKKkhQW
         anxnII8O6HuxotAM1WFr+LsdE3dxhp5kvbEDg5Rmz7ypFJoJDlj5cBWZCdY5DO/FtTe5
         UWZZyeWQsoDop2O3hHrgDQDwX1CcUujBxwPoO00PEnin0Otmx99cLfUOdA/Mb87N0SMd
         ATVVd59Xx6sAcC01piZJ01uhpcQF+y2lWQQ/q9BDhJBytOK8PjAn+EbAzH4j+gmmP3V7
         NYwg==
X-Gm-Message-State: AOJu0YxRDCjhW/ZLnWZ6JzPqFacm5pAJE6CWHfCsSgtcd+7lkdHJGBB/
	b6estQWh4cT4NBzrobw4FgfPPPvHOc8VnS31eEg=
X-Google-Smtp-Source: AGHT+IEOTvBaw6ErxbNel/wNMSnV/KGYcQ1gzAgILOmEw60806ffMpZTSSz35rWXl84Ln73qCRnkTg==
X-Received: by 2002:a05:6808:3023:b0:3b8:b063:6ba6 with SMTP id ay35-20020a056808302300b003b8b0636ba6mr10990845oib.85.1702525974051;
        Wed, 13 Dec 2023 19:52:54 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id oa13-20020a17090b1bcd00b0028ae3061475sm2258750pjb.19.2023.12.13.19.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 19:52:53 -0800 (PST)
Date: Thu, 14 Dec 2023 11:52:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <ZXp8Elbqfxuum01g@Laptop-X1>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213084502.4042718-2-liuhangbin@gmail.com>
 <20231213081818.4e885817@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213081818.4e885817@kernel.org>

On Wed, Dec 13, 2023 at 08:18:18AM -0800, Jakub Kicinski wrote:
> On Wed, 13 Dec 2023 16:45:00 +0800 Hangbin Liu wrote:
> > +    -
> > +      name: noop
> > +      doc: No operation
> > +      value: 0
> > +      attribute-set: team
> > +      dont-validate: [ strict, dump ]
> > +
> > +      do:
> > +        # Actually it only reply the team netlink family
> > +        reply:
> > +          attributes:
> > +            - team-ifindex
> 
> Oh my. Does it actually take team-ifindex or its an op with no input
> and no output?

No, it doesn't take team-ifindex. It's an option with no input
and just reply the team_nl_family.

I added this reply attribute just to make sure the TEAM_CMD_NOOP show in the
cmd enum to not break uAPI.

Thanks
Hangbin

