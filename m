Return-Path: <netdev+bounces-90976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867A8B0D1F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5761F24E09
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C815ECCB;
	Wed, 24 Apr 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P/0meGTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803E15ECDE
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970155; cv=none; b=Zvqv+cMrk7S8FMgesHokqeZ7gNyS4HRiSXTlVPL1LqOLDB9emx5OpvWb1c+lfBlZbCf6qW1SMZxHV+2Q/bWjbzsfJR5JSm8fcZ7x4EAnZuRIH6w3k8WhXB3XNRYxf+og+BNrSfQy8j8WJ/2cfGuNOCpf9R0dHPdooubZ+tmX/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970155; c=relaxed/simple;
	bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arF2NYLN+Xq6GQM5meAMlhy15pdZ51XU5qrXqfqH3cGRWzoEi0rOcaqXY0nhY1pf4A1rt52FVEyboPhgtFsdBjAgwXebTRSLFizelCbbyVtuwkDHhvbugz/khsy7apXGssHCCV1zWAGS4YUF0X8I8VdjpDgvEDZiseGLgnO4XFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P/0meGTR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso2080911a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970152; x=1714574952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
        b=P/0meGTRffoN+Xa3jKhRwvUJRrQNWu1eBm6YMozM1EmcirnZhkh2wvX7QfluTOGhdA
         uCd8h+ifKtEUfjtyD4MNMp2dkq5Cr9+t35u8QsEALKZTv0iaLgHkecqoaVk0eP9n7lTg
         P+5mTBnT6YmWi3yBilTR3Zhe16eJ65vc2JGKlCCG0cLaewDxSSNRVHpHv1DrG1SQ0yJv
         WFRhBk5MqQ5SZkB80e726veiO2xc8F7hNtaJLUwC8R5O4HHw5a2ZAmCXdK5+sGD5bDz9
         q97miVNrAwcUGY/pJqFoCRDZrSzTXO6mjCmvAUEkk7YrI1z9nw+2qNFKK/zRBHq6rowL
         CbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970152; x=1714574952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
        b=IawMmdTW6FhUsscbhf5JQU2NybjQohZXqZyogCvuYNmxVMel7SmcNyTj2ZTIkp87gf
         ft39K6jqwREZSOa1JF16VTm3H/jpLFTQPnhvMbUfwtgd8Bn/FJe9z9TBOpkiMXw7zzMu
         8RIEfl1ieel6HWg4UuZ6G9sXhO+rZHkC3TGV99uvDxd6otXjV3zzzqZg0JlVZ7phegnM
         x4tDDXhHz0xWOJ8AgBAtcuaQVDr8NWJaXywvGJTvIzkwRCouZfpXwJwt930SBzP5ncd9
         CuOHh/nxRlld0/D19ZraXvShDSph8iIiWmnKSaWRBfAVgciWuF0yl6Ygr/2mDIG5JRyp
         DVYQ==
X-Gm-Message-State: AOJu0YzYbgFJhISI8DtYwFjOF1ZKEJGgcYUHqyFLTEI1NF5+b1xmmf31
	gyxcr9Yv4C38EVoKremIzCDNzreE9rxYoCgmdHWf0o8uJsNIlYu3tJOrnxfiLvM=
X-Google-Smtp-Source: AGHT+IGGPlFynSDFKYaliA98nipKF9mMlCFt0dLVpikKmiKaATHgora2NlkxXYYin0L1P/PNB4phrA==
X-Received: by 2002:a17:906:a46:b0:a55:5ed2:44d5 with SMTP id x6-20020a1709060a4600b00a555ed244d5mr1681642ejf.68.1713970152344;
        Wed, 24 Apr 2024 07:49:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906339300b00a5592a12fe2sm6169863eja.128.2024.04.24.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:49:11 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:49:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/3] net: lan966x: flower: validate control
 flags
Message-ID: <Zikb4yKOEvG40QxD@nanopsycho>
References: <20240424125347.461995-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>

Wed, Apr 24, 2024 at 02:53:37PM CEST, ast@fiberby.net wrote:
>This series adds flower control flags validation to the
>lan966x driver, and changes it from assuming that it handles
>all control flags, to instead reject rules if they have
>masked any unknown/unsupported control flags.
>
>---
>Changelog:
>
>v2:
>* Split first patch into 2 (requested by Jiri)
>* Added cover letter (requested by Simon)

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

