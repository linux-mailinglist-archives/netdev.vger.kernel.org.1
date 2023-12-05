Return-Path: <netdev+bounces-53923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4480537C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E3281480
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C157866;
	Tue,  5 Dec 2023 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="n3Ltsqwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF3C1B3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:50:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1cdeab6b53so41114766b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701777043; x=1702381843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhFoCbWcfmFELzOHVd73YNsF6U3WMkQyCz55JcL7SlY=;
        b=n3LtsqwdPw+D1nvyvmDpH8Cgw5ld/m/a624dBBnT+8mbmYHovJ4SN1LF0QbnR3HhSJ
         xxaubs6Ej4dwAlB+VEpXBemmecScHFjxBqqNi+sUXD+DNEe4bwZK7/V0DKU6uU39hXqL
         kKZAkfuk1O6eroL8yB0OefbhSLFIVCNc4Apz9tz24drSfKXwNQPyVcG5FW/5tSx1CWp3
         xHNjj2KX1AhI7vUfFijAZQLh0uPZdFyp+9HaGZHf9vHbkZaPvMNQgs5NWurMOqw7qoee
         er/OgetjEiNV5kV8sY2piPZnCNxnb6BGPi2RDdV7bVrDWLMAKRlGofBMOUrh6qVqbjUA
         LvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777043; x=1702381843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhFoCbWcfmFELzOHVd73YNsF6U3WMkQyCz55JcL7SlY=;
        b=fb5p/iYr+UoF1PKPq6HUgm3NCFB7i3QV+vyx1NEsr6Z7Li9cYo43tK+0cELyZw03nk
         2eZP60PkDTyUa4yIQjq6e460+KexwtS9g9gEJIsnOvCIvMTF2ks7X2iMcTJOUJtugQNw
         wUBfGvtevquoaNdw4+nBc2VoJHBR0ejZ0rAsCkmSlMF5R/UtC60PeUPYk7XO5Sa1KU3z
         1U5xb/hNG9Lv7GEqMrIWAEc0VsyDSQuQykYIeYskH/jrhd3CCG+A+a7oCNzKwlSV4+SE
         EYMvIuYSE7h/vcRar45gRykMTsqKxwpCcKtWImUw/BDsT7BVHMEzvL8gtDUqYaYvIkkr
         ZvLA==
X-Gm-Message-State: AOJu0YxnuNMaJVvZaTeNnGt5pNkvHOIv9AJ4DbvS3oVclDxrNryJKvkp
	ZBQ6ewXNS/7uZaZOaAtUC7A1Yg==
X-Google-Smtp-Source: AGHT+IEB4dFKnxfmIwZFCA8BYWVpe1vVJGSIezG4S7b7Ag3m6Hb/0MWm4Upyx953vHck5yr6FN06fg==
X-Received: by 2002:a17:906:68d4:b0:a19:a409:37de with SMTP id y20-20020a17090668d400b00a19a40937demr936046ejr.55.1701777043518;
        Tue, 05 Dec 2023 03:50:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906318e00b00a0d672bfbb0sm6650712ejy.142.2023.12.05.03.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:50:43 -0800 (PST)
Date: Tue, 5 Dec 2023 12:50:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next v2 2/5] rtnl: add helper to check if a
 notification is needed
Message-ID: <ZW8OkngDumP+5966@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204203907.413435-3-pctammela@mojatatu.com>

Mon, Dec 04, 2023 at 09:39:04PM CET, pctammela@mojatatu.com wrote:
>From: Victor Nogueira <victor@mojatatu.com>
>
>Building on the rtnl_has_listeners helper, add the rtnl_notify_needed
>helper to check if we can bail out early in the notification routines.
>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

