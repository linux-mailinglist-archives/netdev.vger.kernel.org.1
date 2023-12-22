Return-Path: <netdev+bounces-59858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A811E81C51B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 07:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DF1F25F1F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B57484;
	Fri, 22 Dec 2023 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJwt4U0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E4C129
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2041d5a95d9so996809fac.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 22:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703226529; x=1703831329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9X/pT+p0u0F4+59ONINm2AvREuuxsbBNOfWhCRyk=;
        b=GJwt4U0IVnH5y4/s1FfVoLazQIrVdfzqBZ+7+8B7lEpG3ia2xnvoJN2h+jyttspyFG
         Odbv2SjT1CtErQ5MLeoOv5Uu/A6/7AxzF7Z+Y+kQWCOWrNxjYVmzXjGKa8YmIvAtf9AD
         xZnUAphmageEIcgBfeCbHe90WIchdF5v8Qtgaq2Xh1k4T/3hfi2aN/8kbxW+Hr9Rekwx
         Y5muKT87N96TF7j5xXhc7fzstFHnrMtr4eW5Igu3NyIGKUpTK2J5GPfTY/q6w9VFndbS
         oZep3bCruhaKx+SNnxYMPSkXetjjebodCzoPB/nwF2BzTPYLGaYxSSoyZrMmHcojKbmK
         0uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703226529; x=1703831329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQp9X/pT+p0u0F4+59ONINm2AvREuuxsbBNOfWhCRyk=;
        b=UMdy7FMmE6StteDcttT3GUIacOyvLEG8UQxD7BkSJlx6DlU/6Su7W4beZHtDg5KARn
         9ZnkMovyrYI2saJnSQ72Rlgj7h7PKRZOCHhhz9gujECojOB9SRZA1haZRkRIAMjEViMO
         v68wo/rDyoJ9OMvpThpOtCBe/wA6o6jzGGHqbfGThfYDeBWkQ/OoHw4yGlCC3Ib9ZMVg
         91EkaC66dcDsH92RqVzPvY8OJrgjrll4ynL57e/DbwGp+z02voEi4na6Ftc78Iinbezf
         r5Il/WbVzpVg1m2uF4WIzSXMNNlrjOWB7+9gOMkh7JmtKYGmKNG71PenuMnhLQaGPghs
         djLw==
X-Gm-Message-State: AOJu0Yyu+JcCR/5PqNAptSDLHVdd8QJGuymq4IvaGV9ktEcUFOY3kUfB
	TAYlMhPf7xP/i65IUpEehwk=
X-Google-Smtp-Source: AGHT+IEX8S/lvr9lnS4Jip0UIiGUOedGx8NAacMQIppZm21TQMeAJXFoGsCCznjhaEG5DYh+uGyWVQ==
X-Received: by 2002:a05:6870:5250:b0:1fa:fc26:7f81 with SMTP id o16-20020a056870525000b001fafc267f81mr916297oai.14.1703226529327;
        Thu, 21 Dec 2023 22:28:49 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j6-20020a632306000000b005c621e0de25sm2733409pgj.71.2023.12.21.22.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 22:28:48 -0800 (PST)
Date: Fri, 22 Dec 2023 14:28:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org,
	"Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [RFC PATCH for-faizal 0/4] tc-taprio selftests
Message-ID: <ZYUsnTuoUi2qCdLj@Laptop-X1>
References: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132521.2314811-1-vladimir.oltean@nxp.com>

On Thu, Dec 21, 2023 at 03:25:17PM +0200, Vladimir Oltean wrote:
> Unfortunately the isochron version from debian will not work on veth
> pairs, I had to make some changes and add the --omit-hwts option to
> the sender and receiver programs. The modified version is on this branch
> here, I will merge the changes to 'master' once I have enough confidence
> in them.
> https://github.com/vladimiroltean/isochron/tree/omit-hwts
> 
> For testing the tc-taprio software scheduling path, we don't need PTP
> synchronization or hardware timestamps anyway.
> 
> This is just a skeleton that I'm hoping Faizal can pick up and extend
> with more test cases for dynamic schedule changes. It should run
> primarily on the veth driver, but should behave the same on any network
> driver as well, including those who also have tc-taprio offload.

Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

