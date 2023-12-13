Return-Path: <netdev+bounces-56975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24498117B1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C681F21A28
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A739FE8;
	Wed, 13 Dec 2023 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E5izUVER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0A112
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:39:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-55114c073b8so5035036a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702481945; x=1703086745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tip+2qCd/qBHaFJhIlAnLpbHdZra3r2rYNImgxXPrI0=;
        b=E5izUVERPG/vZ5c43mK9K+osnh1UZfCJgIqvVdfMPdP3YwrB1BL9mAOUi90WqaLg91
         KPuO/cDJ46Oxx0DO+NmttaIjwq/5vjeKtjyXUXr3EDsk6GcV5L5/VqBr/oSlR94LESuA
         qbC9zLY5nQOK3FqKemspFj7q+x7IIaEamJlweFPdcz4drZMmGrN7gMvXd3OiIC8xoOX1
         YwCwm1s12tf9gky9L0Cdpya3+gOZ1sxroAI/Gyl4Fe6DloChF0S+C2w5XE0ImJu17HkC
         oiPjOZY/B7FF20O/QXhUGNC3uzOqFj24v3NJ5luqnZESIpQfsDrUQ9AP/RieHwVrlGru
         Njig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481945; x=1703086745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tip+2qCd/qBHaFJhIlAnLpbHdZra3r2rYNImgxXPrI0=;
        b=GJpa2Hlc5og2b9rsZBSvmJDVBRxwNqc7Qq/KZJgHsTQrsk8HkbaN6v11vIePMaDmXj
         hTqV4+jQfy+kVC0gxSNU5igqfmAbEOnP0PvJrUGvHl2oigz75fg7aHkYg4evkVUczMbX
         2d68BCMXwcJpP9MJ+OjjZGNwMyKXn3IkUuv0Sdzd1TdDZWtEdGyDpDCJJ2rjILVLKDv/
         tb6rg8QZFlucJMce1Yo1nZP/EmTbbUtwSECOXVSED1QeX93DA+lWG4d+Lnj2zgSxGyk4
         XcvFDmKeqJl2LmofzsIjc2dzH+0CXF81ZDZ60jfW7l81bnIlATPCl1rzEvKpc/qEMXrE
         UBQA==
X-Gm-Message-State: AOJu0YwMTosjR+26vmuFbA2LmznQPEMk08upCPdYjvUNwgL2lSEBleRm
	4VPfn67fJdqPwZglyo38k8rynw==
X-Google-Smtp-Source: AGHT+IFroaILdpWpCCTrkZ/P04nLZjlfiBCpV4R0f8qz0wh/UbHN792dkfswvyNTNxnC0HXAbCnKcQ==
X-Received: by 2002:a17:906:6a1d:b0:a1f:65b1:9a9f with SMTP id qw29-20020a1709066a1d00b00a1f65b19a9fmr3980176ejc.54.1702481945372;
        Wed, 13 Dec 2023 07:39:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id tm8-20020a170907c38800b00a1e30528af3sm7889151ejc.47.2023.12.13.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:39:04 -0800 (PST)
Date: Wed, 13 Dec 2023 16:39:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 3/3] uapi: team: use header file generated
 from YAML spec
Message-ID: <ZXnQF+xG41IWVXNK@nanopsycho>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213084502.4042718-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213084502.4042718-4-liuhangbin@gmail.com>

Wed, Dec 13, 2023 at 09:45:02AM CET, liuhangbin@gmail.com wrote:
>generated with:
>
> $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
> > --spec Documentation/netlink/specs/team.yaml \
> > --header -o include/uapi/linux/if_team.h
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>


This looks fine to me. I don't see why
s/_UAPI_LINUX_IF_TEAM_H_/_UAPI_LINUX_IF_TEAM_H/ would cause issues...

