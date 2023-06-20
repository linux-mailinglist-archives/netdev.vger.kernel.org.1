Return-Path: <netdev+bounces-12407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF21737559
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8251C20D67
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8318009;
	Tue, 20 Jun 2023 19:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3817FFF
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:50:13 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AA10F4
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 12:50:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b4f9583404so39768595ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687290611; x=1689882611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ugy9/EbrUyGj+qiFKxW2T+uw8vfkhI2rTUNHADA0cs=;
        b=X+rpPSMhE2qWTBAqdeWUncy8WSF+ZNTOTbl511lf/fXn2N+qSDv5hZUyHMLY4nNejx
         faiyQvH8ud1WyY+WspIPPu1Xmj6zgg/DWgYJcCoZ+877NJpbJ5SwsoTn1fn7vwX0jP8W
         IcaN1a7LgMvRZsQ1JVXAPyRCmLimxf/oPTooc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290611; x=1689882611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ugy9/EbrUyGj+qiFKxW2T+uw8vfkhI2rTUNHADA0cs=;
        b=Yfy+ZwmIaWSEFP1BZtpoTIjHcepHjHiF4/v9WbTQnU/919+oJ9z0umwZTWasISeMoa
         PofzDxLtN30Ll0qQIq9RenwB+AkcU75PoTK02X/P56MiTpelQJmOP3ohTfjMVVe0sl0N
         t/rNonzu32AR1+wKO3JjG7hswtnby0OWo0PVVna7HxrplQfDgT2N4mBOKudDjBycXvDO
         CpxvM8mDiAGs1BmR1bArNVX/EKwIx0M+7BhYMbvBtQZq+zTEm+0QnOHf9HCZhu06Yg/b
         FL2Oprl56aMpORhcZnbgPHpFDFTlJuOH7LC6zXitNcH+CC8wgb9oMQE4yE+v8wY6rA8F
         FNYw==
X-Gm-Message-State: AC+VfDwstbrvXQZDMmigdgSlxK4qzQnBgA8vxEfUdOGc8CYxK/o82mJk
	FKYLoZIevu+afWLlGsJFnvR7SOEZyZU1cplAvHI=
X-Google-Smtp-Source: ACHHUZ4cZ6r7mPdRBkoH/OWNHgCf1zDpz2o/OeugeLyUcKn2EPxoE4IAc4kVvsMqoOstw0uzWvV1gg==
X-Received: by 2002:a17:902:c949:b0:1b5:f35:afec with SMTP id i9-20020a170902c94900b001b50f35afecmr16858390pla.58.1687290611217;
        Tue, 20 Jun 2023 12:50:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b001b5656b0bf9sm1957333plo.286.2023.06.20.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:50:10 -0700 (PDT)
Date: Tue, 20 Jun 2023 12:50:10 -0700
From: Kees Cook <keescook@chromium.org>
To: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc: netdev@vger.kernel.org, Intel Corporation <linuxwwan@intel.com>
Subject: unreachable email address?
Message-ID: <202306201244.0A23FF8@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I see you posting very recently to netdev[1], but I'm getting bounced
from your @intel.com address:

m.chetan.kumar@intel.com
DM3NAM02FT046.mail.protection.outlook.com
Remote Server returned '550 5.4.1 Recipient address rejected: Access denied. AS(201806281)
[DM3NAM02FT046.eop-nam02.prod.protection.outlook.com 2023-06-20T19:43:27.107Z 08DB718AC702989A]'

Is the @intel.com (rather than @linux.intel.com) address not correct? If
so, MAINTAINERS needs to be updated:

INTEL WWAN IOSM DRIVER
M:      M Chetan Kumar <m.chetan.kumar@intel.com>
...
MEDIATEK T7XX 5G WWAN MODEM DRIVER
...
R:      M Chetan Kumar <m.chetan.kumar@linux.intel.com>

(I noticed when sending this[2] patch.)

-Kees

[1] https://lore.kernel.org/netdev/1b0829943267c30de27f271666cb7ce897f5b54a.1686218573.git.m.chetan.kumar@linux.intel.com/
[2] https://lore.kernel.org/netdev/20230620194234.never.023-kees@kernel.org/

-- 
Kees Cook

