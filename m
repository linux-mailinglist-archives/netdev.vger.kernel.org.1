Return-Path: <netdev+bounces-38908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857B7BCF7F
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A061C20849
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8A216430;
	Sun,  8 Oct 2023 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ/vsP//"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3253BE52
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 18:06:15 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC0AC;
	Sun,  8 Oct 2023 11:06:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso3649967f8f.0;
        Sun, 08 Oct 2023 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696788372; x=1697393172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bYbkgDe+3tHdIXo8rdcnWG0U5dk8XqMihFhusRlvC8I=;
        b=eQ/vsP//RkUSjpYBHFffELHR4Gq8xZ97/Qyfk12fqX6BY9Tn0+Jf+tRHfSqlJHqZ6j
         MEWLcAST+b8/JVyudY1KpWi2lS5jPh/fYFVOKocsfw48nygFLso70+W1An8RCdEy4Q4U
         ZQQ/NPBBzASD3PDbZ7Mpwm29keeEpV43kivtEpg/uTLuE13XzR9oAVO5kNE4r1k+W4fi
         HLLnyd9/fJTDmp6L6ApROibv+T9nCnxkztz73JGNxlqGmWal9ySmLpAAQqGyAbo+1Ln4
         xmsdLvi1mK7GhlvqONNAOdu+h778EOaoh5VElb5SBNbqCyP3DhLiOE3VF/KwDPioos+t
         Rxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696788372; x=1697393172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYbkgDe+3tHdIXo8rdcnWG0U5dk8XqMihFhusRlvC8I=;
        b=oeILIJOkcQkNIZzN7i9KQEzrys4N1UU4CnSoqHY0ogOXsHe+y33OymyQgteG8hg254
         4hmmsBkT34TtIglZQn0+Y2R9Lx9u+CJkjoSD9pZCuEF26bxjJsRCsM19uJwU6aFCYQHq
         sJyhhRcO/9uwBYLVIPxzlC/fn2nq4gPgJAwmLPeZL9+dKdVYugM8IdnqOeso6tz8pCHY
         KLgsTfVWLGsRzhlL8LypjOcY5ctcU3eqYXKVq5NaR3BAQxkw+HhffiuAC4GL11ho8zw5
         Q2YfRt0R4pOpbUfUiGXEUve88gxfHOyJNLKAUo+6So2oaZ8hzRp8JbKi8mI6Pqi6UFK6
         xxAw==
X-Gm-Message-State: AOJu0YwTF6i+HATjFZTXw+TnW0qmUgGvJp484wZ6YtoT6MBjppZemmBT
	xcww8oHuOK6Bt5ZdCqgvsc79lcx9Wa9NPRD2QJ2d4WEY
X-Google-Smtp-Source: AGHT+IFsQ+WHA+pdcqX8nR9lMIB0E6dl32qm+c/iErn/n1tscycB8LHBCZb3+B0MRFxdhE8vA2UKtVY7S63uArExL7E=
X-Received: by 2002:adf:fc09:0:b0:31c:7ada:5e05 with SMTP id
 i9-20020adffc09000000b0031c7ada5e05mr10538634wrr.51.1696788371871; Sun, 08
 Oct 2023 11:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com> <ZSLtOViO2p31Jzd6@pop-os.localdomain>
In-Reply-To: <ZSLtOViO2p31Jzd6@pop-os.localdomain>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Mon, 9 Oct 2023 02:06:00 +0800
Message-ID: <CAAo+4rXyj3mSt3kRMURZqQZ2mCXQUGUR3mZ+1zz04Qg5OP_eCA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, jhs@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

You are right, sorry for my negligence.

Thanks,
Chengfeng

