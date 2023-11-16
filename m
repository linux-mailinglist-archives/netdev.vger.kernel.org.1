Return-Path: <netdev+bounces-48262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C347EDD6B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801491F2383F
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD42F9FF;
	Thu, 16 Nov 2023 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="220jhNCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D14194
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:14:53 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c3aec5f326so350042666b.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700126092; x=1700730892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzbtEz+MoP0GqU42tqaCpjBYfEcN+vCU2DxNlTwl56k=;
        b=220jhNCFfeSd0XvlqyOE6hYm3UaUqoqCa8J6vOC0MzsEWnS13GUYgoX2zdbh5tGXfN
         /AxHIJGxEQ9NUzCnv75Pr5Nb0Rz2QxWQN2T4qb7LKYdHyXss0q+bGalsBYn1thIhEgHc
         zYxxnH4w/e4mgZJBMypIX1P0H+YH5+xquzsgp5mOKUUrvV6SN2ckIf5C0W9IQ6i0lz0o
         K2Wz2/g4W+akER12f1G4B3XyHa1hGV2sKsorYnmnLSVAU5WbunJXvmUKWBCJ+UzqhJVb
         eA2Sp1NiDZz4T5eCeoOnDEs22t+WdWNEi/7RbkYggfzPuWABawZfXZeU480WUkP/MZa3
         ZZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126092; x=1700730892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzbtEz+MoP0GqU42tqaCpjBYfEcN+vCU2DxNlTwl56k=;
        b=hEoHU9qzWI4LMiFodEmZAmWKO/jD5JeDPVLlkYtYAgX7uRBdEUkeNOS70+aewe9BII
         9adlCCdg4K+1+U+bxK2j9GECVcQdaNAm6E+pEdaPH9GETMfFnDAVDxmkJo7T11muphWj
         lxf4Z9tB9o2hMWIqhYQENWZ2vicm5tXnmZIZ6+9BOrfr4sE8eyCtCoZ9ya6kGhlPcjgo
         L/3JkCIFiZHIKJoEYMmREMGKGpYAFm+VTrto18lJbQBsPwL0+nw8xvXenmxsY5Ci8jg0
         Q2t/ZejJDPy4h2sOsHdRZ5uLiGo3f2RJQ8sWY7ShLQhK6PVhOh3mWqY96OJFYoDHOsds
         nTqQ==
X-Gm-Message-State: AOJu0YyXgOwNy8AXAlwoGH4nPwvlI0Cy1Sb/UrEXKhJWgxp3j5QOdwKI
	9aWDAPMIEMnEKUjkORroTbS/Wauff41pCyv1UEw=
X-Google-Smtp-Source: AGHT+IEd3F17JeRj8Ig9VT/Pt4oSPQ+TeZPGT6PytL3JK5nNYjiF5NQqXRcNbtMyhyHGxiTTqJEl+Q==
X-Received: by 2002:a17:906:a413:b0:9d5:96e7:5ae1 with SMTP id l19-20020a170906a41300b009d596e75ae1mr1138744ejz.12.1700126092043;
        Thu, 16 Nov 2023 01:14:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906348d00b009a1dbf55665sm8024819ejb.161.2023.11.16.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:14:51 -0800 (PST)
Date: Thu, 16 Nov 2023 10:14:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 0/8] devlink: introduce notifications filtering
Message-ID: <ZVXdirvX5tQiVmto@nanopsycho>
References: <20231115141724.411507-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115141724.411507-1-jiri@resnulli.us>

Will send v2 soon

pw-bot: cr

