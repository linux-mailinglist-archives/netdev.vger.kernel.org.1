Return-Path: <netdev+bounces-55609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453480BA7D
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C67280D72
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4178838;
	Sun, 10 Dec 2023 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yPChUgib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE583FE
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:49:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so5001535a12.3
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702208971; x=1702813771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDs1DhThf4G5lwHQ/ObntRQsif/s5fI5HHelOhfp+dw=;
        b=yPChUgibi/3C8GVRgHIk52RRhl1S+uYfphZTMeusDXnzZ7/fOGhg75T8cNyamQscHL
         V24UFg+DA7JIOTU7g5kQueOZDJXIszdnKW5QD/PWCN26tI9N6TJcuNUbz7ojuWF4X8C+
         Ptwa92IWKpsY6ES7NGGc4ZJZa3j91nut/K6jyfmUmEvMuLMpjQQOmUjZxT0A/Arxzui2
         R5grHHx8OU2aMKpgktRvYxFkDieIy1tDr9BDAsIiwu7WA3DykucETq7dKDwnHUoLbYEX
         yOKgprjD26v14D18j4diwhISt5CCdcC0Ir1SvmyXSz3ysiKFNRRyEaeVegVjynbrwvQ0
         UMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702208971; x=1702813771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDs1DhThf4G5lwHQ/ObntRQsif/s5fI5HHelOhfp+dw=;
        b=vmc2UDD0ycbCFUihtrmIwHuH+O8p9gqg0iGJphvPJQna4hI+H4RdMOUAxtqiLTPOqC
         7ZzI2phO4glW9RO7Mv94/7BupiC36d7oym5YAD9idqE7PlurfLCCAjw7pq3yBUKGJdSh
         yty/VJ9Ui2/27g4UxIYpWrcatZJ7W7Ohb+zFDHZynZRFq9m1WOZhUHSVP9r8ibrYQUpZ
         1nv6IvOsKSNnOYjmJN5FbjQ43POVo7KZac1EKIxeJAmD+uHF67pAycbjWtNtfU0WzHya
         NNHzple0s4ITDCFGPSjRgVLWJP3l7qubN7Gl02BDTQ61DWcS98qVXS1SvELiRiHp0Yr/
         FsIA==
X-Gm-Message-State: AOJu0YzsTb1oECDwpXPpXFc+qqnQmCyHr8fiFSDa5C5W8dmcbRH7RG3a
	WT89K46tR4+VzM9LW+JMIL0vcg==
X-Google-Smtp-Source: AGHT+IHdF77vtDoF1XkroQOg918Nd7KUCPQyWEAIq8b+We+z230oSn5NFxnlJYUqHKadAxA9r//m9g==
X-Received: by 2002:a17:906:e294:b0:a19:a19b:421e with SMTP id gg20-20020a170906e29400b00a19a19b421emr800788ejb.137.1702208971354;
        Sun, 10 Dec 2023 03:49:31 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1b6d503e7esm3309806ejc.157.2023.12.10.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 03:49:30 -0800 (PST)
Date: Sun, 10 Dec 2023 12:49:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next v4 5/7] net/sched: act_api: conditional
 notification of events
Message-ID: <ZXWlyRz0ZjFoTFjl@nanopsycho>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
 <20231208192847.714940-6-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208192847.714940-6-pctammela@mojatatu.com>

Fri, Dec 08, 2023 at 08:28:45PM CET, pctammela@mojatatu.com wrote:
>As of today tc-action events are unconditionally built and sent to
>RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
>before-hand if they are really needed.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

