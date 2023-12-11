Return-Path: <netdev+bounces-55914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E433A80CCF8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE471F20D46
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31C482F9;
	Mon, 11 Dec 2023 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS4nrOUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222E448A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:06:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-333536432e0so4275565f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702303567; x=1702908367; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufragnZFDOmr67p+5IARYTUlYL7YxarFVfeDsjMWctw=;
        b=fS4nrOUL1jBDiMp8qnaQahdT0oyN4fBHD+/dGDj1078jy25Xc8dY0jk4UuSztQK8Xy
         +bXVWEgVYFJqix+HxyvXxMf0P2kUrid4i72CzsDPOpKnUzCLQkSqDLG/BwU8HZEbWvd9
         Se52hYA2FQdEsoNVnYc744Of0tqb+MpS2pqeUSPJCnbFN2EfWRNY9g01ovWVdkT7ybWl
         jIkZDbzK/iw/oLnRt3eN84sB0Wd24gFmJqZ0TZHYlnGAcnR0b9Gsf5qGviTb9esvTzCw
         9y7NccPuKNUx8v5RPdeI8ef+FYvO9vUFJi9lPaHusDKihxgukXtirt3BVGbt84VmlZRS
         iKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303567; x=1702908367;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufragnZFDOmr67p+5IARYTUlYL7YxarFVfeDsjMWctw=;
        b=CfU4F+9vmTcaibLiQnHjz7tGTNUZXaqtan9NsxvZjHMsnOrIf3Ax/9Kh53k1rpIGub
         ldjLfR/3wpyUO7IXZ+ieCcokGam2lljaZa1zntzVbYtHl8C05iI/1flSwB6o3xCprvur
         7h3W5Ueozsyzb2K9yWJAgsXp7489sjACmtXU+wn8D9zmzECC6irKacEXUWQjsq4CIKNN
         h9eWtj5MVjOQv/HxIIN/JxcA/XkF0Y9yk1Xa+QKzSS6HESM4Xu1jSHhfog8MhoZQem0I
         uo5OBCTkK2Fulz9ZVyeeWRTtB+a99MEi7h296Ge0f+8FeMrlxo/pmRkIF0v15XAU2fi3
         i0mA==
X-Gm-Message-State: AOJu0YzBXbqBqaLeYJmhADoFL5OhSWtC+YUEJOpP8Hv+ijQTzuBc1Vjk
	cHG11h8uaQT99/FPtyT8aPDvAqKZiWg=
X-Google-Smtp-Source: AGHT+IFYWvulz/WqjOzdDwcdqPf88UhyM82+KU6OT2plZNX4EsvyenkGc33DNilsNc1f5OghSM/YNQ==
X-Received: by 2002:adf:e0cf:0:b0:332:ffaf:d217 with SMTP id m15-20020adfe0cf000000b00332ffafd217mr2453982wri.27.1702303567179;
        Mon, 11 Dec 2023 06:06:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b003333c9ad4d6sm8649628wrs.116.2023.12.11.06.06.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:06:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org
Subject: Preferred term for netdev master / slave
Date: Mon, 11 Dec 2023 14:05:55 +0000
Message-ID: <m2plzc96m4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I'm working on updates to the YNL spec for RTLINK and per
Documentation/process/coding-style I want to avoid any new use
of master / slave.

Recommended replacements include:

    '{primary,main} / {secondary,replica,subordinate}'
    '{initiator,requester} / {target,responder}'
    '{controller,host} / {device,worker,proxy}'

Is there an existing preference for what to use in the context
of e.g. bridge master / slave?

If not, then how about one of:

    primary / secondary
    main / subordinate

Thanks!

