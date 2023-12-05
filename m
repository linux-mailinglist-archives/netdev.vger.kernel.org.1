Return-Path: <netdev+bounces-53924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3480537D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA70B20BB0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5D59E2C;
	Tue,  5 Dec 2023 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kElW8tPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CA182
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:50:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so6927244a12.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701777056; x=1702381856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yufz+DA93k3p29w/5S0h8xD4YQ/tFYLoVYH65zbbAjs=;
        b=kElW8tPivHbYwIZuvbuTdc5urZs2qLusv3HEEJ+xf8ZtK6zIiXBn2ZWwKTa3XVZUXc
         7+jplUaFIxz26u91O7RcgMV1/Y9DA4wLpVAd3AqWQNsbOQRMMxB9sD2NE4/DzpeKjLmG
         Gmz0AteURyNeOP+aAwy8UPJmzWHRsOxXIRJS4nueAva5s0J/IrBsHc8rSlZxH0vdgU+G
         c1OZjEcuIJhAnjWcwV8aUdbxTD9xPmOkVvU0iQqX+Z0QX/gcSL1Kf+uwIph92KDdGOJN
         wnapl0u0/+bise+o62QTWnblPTfEyD766yvee42RdClik/6C3MuwJ4khSPVFwF0J8leX
         jJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777056; x=1702381856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yufz+DA93k3p29w/5S0h8xD4YQ/tFYLoVYH65zbbAjs=;
        b=VkX8J5ow7h3Mx6CU4K/twfJOUETKMfG1qlUfcLyL1gmFCBTNfjTmvTfJPiJjlufCwe
         MHKPoyAfvLlbLGgvuCm09XBXkcLvcrAIucDU3tod9wvj51LS1Aiz7aRtjrUQ0trE9VQ4
         NByTlZbJg5XkHN0dQS3GNHYgtWC1i8ajM5vJktBbtgD9tze6ZcSRsadOMu0pa1T+zozw
         0nwmflYA2ZMrjtUXTgzjzFBZaSn93hHKxZ0Z+C0vTVRTO32XAshhBF2iGk2kGyuvkLZ8
         AiXcltfuuBX3ei2A3fzFcPqMvXOHhpmMgh2ZTOpcygPngiq2wblR/b2LqwgBj7Y9o/B6
         A4Sw==
X-Gm-Message-State: AOJu0Yzk0mveTjJn2CiOL2JuP1WjjeVnXTUuIKF+Gt60C+4icWcoUBTt
	Oovd88E+Nx8/m43Q9w4NF6SBdw==
X-Google-Smtp-Source: AGHT+IHNfE7y4Q86hqne/p/68Ds8nA7M0H/tBSfe6GbzslK2vlU3AP5ntWID7tJ0FiG/Q1XZOTB8kA==
X-Received: by 2002:a50:f692:0:b0:54c:fc7d:d0cd with SMTP id d18-20020a50f692000000b0054cfc7dd0cdmr777766edn.106.1701777056457;
        Tue, 05 Dec 2023 03:50:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b0054cc903baadsm985090edr.30.2023.12.05.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:50:56 -0800 (PST)
Date: Tue, 5 Dec 2023 12:50:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com
Subject: Re: [PATCH net-next v2 3/5] rtnl: add helper to send if skb is not
 null
Message-ID: <ZW8On8UhJLSttLtW@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204203907.413435-4-pctammela@mojatatu.com>

Mon, Dec 04, 2023 at 09:39:05PM CET, pctammela@mojatatu.com wrote:
>This is a convenience helper for routines handling conditional rtnl
>events, that is code that might send a notification depending on
>rtnl_has_listeners/rtnl_notify_needed.
>
>Instead of:
>   if (skb)
>      rtnetlink_send(...)
>
>Use:
>      rtnetlink_maybe_send(...)
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

