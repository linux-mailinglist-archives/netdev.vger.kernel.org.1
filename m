Return-Path: <netdev+bounces-59442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702981ADD5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAAF1F23EEB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97553B2;
	Thu, 21 Dec 2023 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eIgTUZ/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B0524E
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bd8e76024so179883a91.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131103; x=1703735903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWT6hD+evS2ImbbjuYm+Pc6+m5xwqC5D4kGwD9LxKlQ=;
        b=eIgTUZ/zb50iYXHTkzIhYge/QeTHIEPxpCBc+EAb1AhhbOWTBoWTxjghiET647H2wi
         arDOxZDr/kjlG152llObNPKyKQK0p2BikFIohDY20CwvAR9U5HVnt9xij2CfGYNjiTIU
         S1iDzhDfSeT1i7DCIqnfmHBbwBhpL/l6sfonwT+q09Jtr8H49LBVrCS7RmmuJ9YOKkvy
         FXYSGob55Saz5/bRUhrfYjR+gsH7hhmGF/wK4uZd+fYz+6Kkr3mKo1d6CVGWonNIdqHM
         +SQtEFu8OOtl/3GRTi0mAReOCvm6Sp2B3XgO9g86HSlp4L0EpGjF5M7bhpiUNGw/3WWG
         Owvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131103; x=1703735903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWT6hD+evS2ImbbjuYm+Pc6+m5xwqC5D4kGwD9LxKlQ=;
        b=iRKP0O05OrNkNa02VBPRExUnW5kwRxBvQz+rIhVxpTpNoyyQ6mE1cO2GYTVIRIJmQO
         EMEqcvFyMza9PeLRqI8tkXVykTQ/Zvj3JmOK28tJhjXdVxf/U/otKbLBW6OIYAp6J02u
         c8j5IOhrcjP6QRLHLJKVyy9CdB/c3/SJe74aUTJ/aH7iuWHJpfNncRncXO/55sLaCg5E
         S2ALWobI7QYdPHlLTJHSnMpxRLL9jARfWZBKwchWTQz2RfmCepVt/34XMjL3DsLsdZff
         YedFXAVrLqPnYPDfD25uQ0CuwibbvuVInJ8uJyXb+pbfiZLyKC6HkOddyi8OJp0GLYpH
         TTxg==
X-Gm-Message-State: AOJu0YxhFk/uAPRXjSZMmiWFMfeT420XSpS+BYvkJgrCAnNhdZNimPp5
	IFNxYn6TpnlpRjGdW8m5nXd30w==
X-Google-Smtp-Source: AGHT+IETQxRoig5g62x/OVYHy6Y59fBzWYUcmOjRNX/9Jwa1+SY6pws2J/WXoloCcGoWRTTsBM0ogw==
X-Received: by 2002:a05:6a00:188d:b0:6d6:e621:97bf with SMTP id x13-20020a056a00188d00b006d6e62197bfmr4917873pfh.40.1703131103151;
        Wed, 20 Dec 2023 19:58:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id x12-20020aa784cc000000b006d922015d25sm522682pfn.186.2023.12.20.19.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:58:22 -0800 (PST)
Date: Wed, 20 Dec 2023 19:58:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 02/20] bridge: vni: Remove dead code in
 group argument parsing
Message-ID: <20231220195821.24a5ce3d@hermes.local>
In-Reply-To: <20231211140732.11475-3-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-3-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:14 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> is_addrtype_inet_not_multi(&daddr) may read an uninitialized "daddr". Even
> if that is fixed, the error message that follows cannot be reached because
> the situation would be caught by the previous test (group_present).
> Therefore, remove this test on daddr.
> 
> Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  bridge/vni.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/bridge/vni.c b/bridge/vni.c
> index 6c0e35cd..33e50d18 100644
> --- a/bridge/vni.c
> +++ b/bridge/vni.c
> @@ -109,11 +109,6 @@ static int vni_modify(int cmd, int argc, char **argv)
>  		} else if (strcmp(*argv, "group") == 0) {
>  			if (group_present)
>  				invarg("duplicate group", *argv);
> -			if (is_addrtype_inet_not_multi(&daddr)) {
> -				fprintf(stderr, "vxlan: both group and remote");
> -				fprintf(stderr, " cannot be specified\n");
> -				return -1;
> -			}
>  			NEXT_ARG();
>  			get_addr(&daddr, *argv, AF_UNSPEC);
>  			if (!is_addrtype_inet_multi(&daddr))


This makes sense, and why was the message split in the first place.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

