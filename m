Return-Path: <netdev+bounces-17195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02300750C9D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081FE1C20FDB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4B2417B;
	Wed, 12 Jul 2023 15:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295724169
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:33:57 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E31BF0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:33:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6831e80080dso666889b3a.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1689176029; x=1691768029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Qge0k9fOoFE8u4WzIwbWBlrSJpWiGCeA3aU1hVFMQQ=;
        b=aumB25qkmp+H22OpLviqbhMeSPRTuBf8oR6XBg8SuigO/9bpEig5h56WY5RjD3i9Qe
         gYXLVip40FAk5AYZcL5N/qH9cXU1Cnt0Rsa2SjawbsAp6ARD35stmLPQ0Z7AJj0nKURH
         NysfJD+0js/Jr6wO7UWSgPig3KR9yuvVk0sKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176029; x=1691768029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qge0k9fOoFE8u4WzIwbWBlrSJpWiGCeA3aU1hVFMQQ=;
        b=cVoFCl6xrKGWVk1H2o/ZtIGVXtSBGvS9w0pvKSjvna52gC/1vsglt8gFOrx8Lfh4PG
         S7JyVvj5+2cneJVFzFeFcm47e803JM6OzK0a8OVMoKrn8FXNsk9P4jD0YEKudIx5FGYl
         ob4Kq4Bq4AlLsZWns0TUyB0dMckSK3BJsbMV3exNS9ktEdoOiam3r+sW7SpqrKnzzk10
         JKqhm77UtteamOeai5Xc+Z+wdpq5C467SPfkpqm8pkPIQMYaAVoI6nYH8o54XAvInXFM
         c5AhGvFLv3tgOHKheKKpOwbhVVygBpwmgxY1tZNG+TAvpmX8awhropgIkRxiMJxwQHRL
         KtPg==
X-Gm-Message-State: ABy/qLZ7AlxG00xdHin8q4eEJsr3L4UYk9r7oMAeYpGDO65HfX4tF0QO
	vvfnNw8f89GB6iT+BS1CyTl2GA==
X-Google-Smtp-Source: APBJJlFNr2xJX8eq3hvGkCM39UTQHE6y4iyY0HfX8z9Njetrw27dzHODYsD/xpRdLW/JDaacvTZItA==
X-Received: by 2002:a05:6a00:856:b0:682:759c:644d with SMTP id q22-20020a056a00085600b00682759c644dmr18508848pfk.27.1689176029480;
        Wed, 12 Jul 2023 08:33:49 -0700 (PDT)
Received: from 823b66c6476b ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006687b4f2044sm3760942pfn.164.2023.07.12.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:33:48 -0700 (PDT)
Date: Wed, 12 Jul 2023 15:33:43 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Xi Ruoyao <xry111@xry111.site>,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Jeff Chua <jeff.chua.linux@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH net] wifi: iwlwifi: remove 'use_tfh' config to fix crash
Message-ID: <ZK7H1zISQ1yzkg4X@823b66c6476b>
References: <20230710145038.84186-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710145038.84186-2-johannes@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 04:50:39PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is equivalent to 'gen2', and it was always confusing to have
> two identical config entries. The split config patch actually had
> been originally developed after removing 'use_tfh" and didn't add
> the use_tfh in the new configs as they'd later been copied to the
> new files. Thus the easiest way to fix the init crash here now is
> to just remove use_tfh (which is erroneously unset in most of the
> configs now) and use 'gen2' in the code instead.
> 
> There's possibly still an unwind error in iwl_txq_gen2_init() as
> it crashes if TXQ 0 fails to initialize, but we can deal with it
> later since the original failure is due to the use_tfh confusion.
> 
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Reported-and-tested-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
> Reported-and-tested-by: Jeff Chua <jeff.chua.linux@gmail.com>
> Reported-and-tested-by: Zhang Rui <rui.zhang@intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217622
> Link: https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.camel@xry111.site/
> Link: https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2BmV%3DAKoECZM%2BsQ@mail.gmail.com/
> Fixes: 19898ce9cf8a ("wifi: iwlwifi: split 22000.c into multiple files")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hi Johannes,

I can confirm that this is now working with 83.e8f84e98.0 so-a0-gf-a0-83.ucode.
it wasnt with 6.5-rc1 and both 78 and 83 firmwares.

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>

