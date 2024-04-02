Return-Path: <netdev+bounces-83986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0828952DD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A142F1F210B1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E590762DC;
	Tue,  2 Apr 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QYDZyHOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE7657B5
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060628; cv=none; b=oLs0YvGL6N3/FHrD7OOPTe0qRyhIoxQhatf81rAKRX+uyechczODW+958gbDW2oBVacIIrsKsbpXhNQqO0TvUmqraP2Lpm2kMJVYEvYtlF7Ur47RJh3f227WYZ0+WeeNeno7QQ3B56S/ZQW5ToQXHnxqRwqoAlfZp/HoYVFNzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060628; c=relaxed/simple;
	bh=bn4Z8C1OBEfrU7jfsAzm5KD4zjl3yBziUW48iAT6jFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LddKwbo+gN8NiwW/dRwwWNrimQm+mzlczgfr9pYR+I+3fQvZg3y7aLSH7Z0mVFjOH0NiKxtMxFnnmI1mqh/raQA8KkSq3Dg7TLnYaUZkSCRXgPb8MPpZL3KJeXeApkKhEW6l3DcNbCLKggwPbtll59hbMAEKEry1GiBx4TFJ0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QYDZyHOr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4161eb1aea7so986225e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712060624; x=1712665424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bn4Z8C1OBEfrU7jfsAzm5KD4zjl3yBziUW48iAT6jFI=;
        b=QYDZyHOr1SDl2E6rjAP11WS0T2LaVxILYSfY/jKZzRPHC5n5H1HDxVCHa1RkG49st9
         wko8gNEexMag8ED6dTO50yKacUWxnF1JFIseREHEIuReaJLUgVy0MI58Ak3B7gAtMAh5
         4JGbdXYo7gr3AGSJ30iyPlNvEn8y8zS129vVMEWBKu9kdoUpfcaqzCpWS4n/ZcDBHImU
         VR0Syu1AkU8XeWmYn/TXE2putmtv0WAPqJgZ6fi9TgOe06pEwKlV4E0awZjmJ5r0aUKS
         Wtfn3YnMBeOSXEA8CxzV2V+XG89Mzk+2jEp9D0u9xBwCjyY/liez7kO3o8nUQe061HH7
         nvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060624; x=1712665424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn4Z8C1OBEfrU7jfsAzm5KD4zjl3yBziUW48iAT6jFI=;
        b=MwAW3MaiH7b02jtToi2bRmFN0YceBPMLJtiQjXc6sNdJkEmW4Yu+oRizu8JZuXweJn
         KDNVKqeKNWbhyP4LZda5J8ap8FfYYQW2avB7gv2e01YGDjC8/mJ3/N7QJxwSl1b6oOOC
         yW4dWFIVGYY0ffd3NtWv4VpxKyowflyP3Fsu3b6b5JcJHR9pTHrZ/+/xN4XA6/m/WTWS
         QuGjmZbkURneKyB4f70lThqEZ2jjCAZG/3H+2FwdcU+obQS0x0E1Qdj82G2eGeU71sQS
         2b5zLFVxEFyi80sg4H0AnBLJiVjhnFO4SSskNTovkUZzSaxnXrh8kwsyUgvtnFLBRQmc
         +uwg==
X-Gm-Message-State: AOJu0Yx+rMF/rn9iVz8R3cBgjwYZM2evhY5wrq5gP0XyxgFocvOBO56W
	RtlifZzZ2DuucQneAovOh2+LZ2g5BO/hExR6AFtRkejbOAW3kOgkb2dZvI2LXnI=
X-Google-Smtp-Source: AGHT+IGTYIQbRYmd+c3Tm56tb62lsktuWWJTwbfXRiX7t0zG7a53lN8MaTPDZKouL7VADTlgwUdI6Q==
X-Received: by 2002:adf:fe87:0:b0:33e:ce15:8a15 with SMTP id l7-20020adffe87000000b0033ece158a15mr6998231wrr.5.1712060624510;
        Tue, 02 Apr 2024 05:23:44 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d1-20020adfef81000000b00341d84f641asm14157331wro.8.2024.04.02.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:23:44 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:23:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 net-next 3/4] net: team: use policy generated by YAML
 spec
Message-ID: <Zgv4zL_imH4b6ti_@nanopsycho>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
 <20240401031004.1159713-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401031004.1159713-4-liuhangbin@gmail.com>

Mon, Apr 01, 2024 at 05:10:03AM CEST, liuhangbin@gmail.com wrote:
>generated with:
>
> $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
> > --spec Documentation/netlink/specs/team.yaml --source \
> > -o drivers/net/team/team_nl.c
> $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
> > --spec Documentation/netlink/specs/team.yaml --header \
> > -o drivers/net/team/team_nl.h
>
>The TEAM_ATTR_LIST_PORT in team_nl_policy is removed as it is only in the
>port list reply attributes.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

