Return-Path: <netdev+bounces-40165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E107C605D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A6C1C20A08
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD439C;
	Wed, 11 Oct 2023 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebrywsAg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904F13ACE
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:36:09 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C398
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:36:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso3979935e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697063766; x=1697668566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+GlgrsmEnE9z+xDAG5EqtzaoXNDmXFCWhu74BKduvc=;
        b=ebrywsAgtCw4V8081mp616bFY34k6KP97rbcT1op2ZAb8dFccM3iHn/3e3CRCVuLt6
         8jyCRdn6as3lJN9Q2qcvPOqBbwI1gKc3LmJn5jytvMy6wAsKQJVG8zlLmAlzCUypKV8p
         KF7ehpoxxi57K1cP+iEDHa0i6fk+9dF1Vdfria2qP5d0up64Q/qMC3+TGnPhCLsB+D8g
         5ITQ2Ar3lOT5MbxFAKyy+SkJJF6dynrU4d2KHCEa34hy42EkNBXi9dN0+T9SQ3ZxnGnG
         6XNGFqyB4SOEBP8rtIWVpzME+8Mb6FXOUk/CxS0RFNeXjMls+iLOPAH3AF6eG2Qdxq6G
         l4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063766; x=1697668566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+GlgrsmEnE9z+xDAG5EqtzaoXNDmXFCWhu74BKduvc=;
        b=MyDaLiUYIPXc0AF+WG9p5eBOK9lL3XOL0nsoDkUR0gXKeJT/mg7q13NbITqN7MqS6j
         7bRedq0SyQiiTs3JuoQeMBJm1Mgo+T85vLTbb4StEg4sHkT+MBY8ShG2EHEAHSpVnFcW
         JYgrMwRljs3w1jDfHdJ9mReLgN1VN7gBZ+yUXmd+jcq6teozvnNHJCrnuJSJJPXKHiol
         RWvlkj1qMVWITCt16EECWZ3S9s69Jw8tr0VuOrSAsvJOJ1emi3QrWlUVyr+VbIKyiqF1
         NKSDuDZgyLZhVrtWfsxQ2SPoHh2JrxsRorLtUbt7UUYYMcde7oKayN/1A/bbSQxb1yMy
         vJkg==
X-Gm-Message-State: AOJu0YzlMETIF3o5wUzXO4vXG/r0Eos8RKO+iMcji/WDh+XINY4/ndZL
	r4hrdxQISG39YQiAh2VJYHU=
X-Google-Smtp-Source: AGHT+IF8sC2K8/8sXXCyfR8NYAur10GjvX5rodOMW4VX3nPm0/XledjapnC5fGIfB7GtkKWlxwJEBw==
X-Received: by 2002:a05:600c:2050:b0:405:40c6:2ba4 with SMTP id p16-20020a05600c205000b0040540c62ba4mr18959992wmg.5.1697063765561;
        Wed, 11 Oct 2023 15:36:05 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fc02e8ea68sm19932986wmd.13.2023.10.11.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:36:05 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: kuba@kernel.org
Cc: chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	jstultz@google.com,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com,
	richardcochran@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	vinicius.gomes@intel.com
Subject: Re: [PATCH net-next v5 5/6] ptp: add debugfs interface to see applied channel masks
Date: Thu, 12 Oct 2023 00:36:04 +0200
Message-Id: <20231011223604.4570-1-reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231009175421.57552c62@kernel.org>
References: <20231009175421.57552c62@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski said:
> If it's a self-test it should probably be included in the Makefile 
> so that bots run it.
> -- 
> pw-bot: cr

Thank you for your input Jakub. It's actually designed as a debug tool for
humans. I wasn't thinking about self-tests, and I can't really think of how
that could be pulled of in this specific case. I hope that's ok. If not we
can try to throw a few ideas around and see if we find a way.

Cheers.

