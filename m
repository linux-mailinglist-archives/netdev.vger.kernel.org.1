Return-Path: <netdev+bounces-86464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE289EE20
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966891F232BF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9761494D6;
	Wed, 10 Apr 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA6Jul1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2A19BA6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739820; cv=none; b=o9SSi173H2l58TaAySLWKecl0vmjPy2x5zcMBl3QDHRMayFhrfYLnLN6W+CmQO8mKLGiVHOr1SjiBIUHxF5gFyEJ6eakidXn0bZUifzS5minjbqoRwXt7g1fTMdcaGcdBQ3PiIS6dkHwmgQG0BOdaNJxQB/MstRWya9aBtaJ8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739820; c=relaxed/simple;
	bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khjMj+teTgCr9uaDpP3L49GHymdlc5tkgcp1fRUeGp/tn/J3bEZkxrkayDZdsAiIaQSfikRABONBl2E1AWS7E7EbWnbBCE82ofGoUjLEzOHf+iw19ug4XVJbZkY994MEuXdlWLL2XTQ1DbwKH5NUqxHfw16ERdaulCB6FZjFdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA6Jul1j; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5a9df87e7bbso3645672eaf.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712739818; x=1713344618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
        b=KA6Jul1jIPUn8N8EeS4n7tilDTCmbJ2ovut1BgHouwnEwgX9GwvK12vIxA7nGSuxuu
         iftixUHYAeQczbQDraomjV34kmWmA3GVf8jThG4qaGHMaSJAOZKgwj4HSiu6qwkWRn4Z
         UQ1sG362Sj4k8WxCo5/w7ilLGobJIXbG1eVoAuQ0/06Ka1Q8czWil2Bp19uGtpwcq+XY
         RjYuIif67i9CgrnT77khP2veccLS2qQS6DVbscg8829Tuf2h7/b21Otlq/uI9pJRUMOo
         FBK6UkNoyRD4m5Qq1AFirwpHbNv3CPGFu1gZQxGPRCeIUqY40rXk85uuEwTXkMWVV0gY
         y3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712739818; x=1713344618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
        b=LHlCyizPyDzl3zg6NkOoqWGi5C80E1lulzRXpg0A8DT8siYq36rUhPHKhf19UA6hqO
         5g9oGONxKplmWdtEFJJMp5nJLgaARdQAwfDbebGghma9AfjF8sC7UllDxOXtW/Dt+lA+
         68eLAvVJIMC9DKXih7L3/BV8/RPBGUgXijhiqi/juhX/7JDyQVeXU8Mg4OloUuV6yyLk
         gp6uIT78b949Y6+8dT/eCUUTroAP1gxT/3hH4olQDKafnZ9arf0DupjrfnB2MDy/B0T/
         24RgByBpFDlg/nSBGDsBrFOvX1LpQm5iCJVTMiE0In1CeJc4yKtNttRyEu8RUuIoSCGb
         vOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaI3KBtP4ZLwSkeMD44K0f1xdR8+brUg8sCgZjswQjFrnM1PmzyWauJ5JYyyFW0XBnagZBsP2wtH2fFW+7Yuah0ixz+n/2
X-Gm-Message-State: AOJu0Yyn4nZOwplPHEozF47erFvnPbi7vZQR7MXBAl+ulIAhjt+XcYeX
	ze7BdnJ/UaUkfk6RJnbJLPhr/w5trLQvHyP8yrwifHrUgvq+aY1qeh72Heuv78k=
X-Google-Smtp-Source: AGHT+IHrcnjSh2TeJAVtylVXZNEf75GxcKGUyl3zHzMeAFvmF1DjhgPhDzhh1CFglM+LtlDrdrHpaQ==
X-Received: by 2002:a05:6870:46a4:b0:22a:919a:dc87 with SMTP id a36-20020a05687046a400b0022a919adc87mr2027141oap.56.1712739817965;
        Wed, 10 Apr 2024 02:03:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e28-20020aa798dc000000b006e53cc789c3sm9491823pfm.107.2024.04.10.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:03:37 -0700 (PDT)
From: xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To: gregkh@linuxfoundation.org
Cc: vladimir.oltean@nxp.com,
	LinoSanfilippo@gmx.de,
	andrew@lunn.ch,
	daniel.klauer@gin.de,
	davem@davemloft.net,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	rafael.richter@gin.de,
	vivien.didelot@gmail.com
Subject: Some questions Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on shutdown 
Date: Wed, 10 Apr 2024 09:03:32 +0000
Message-Id: <20240410090332.129969-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 stable branch.

Maybe I missed something.


Thanks.
xu xin

