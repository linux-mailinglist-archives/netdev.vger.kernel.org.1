Return-Path: <netdev+bounces-73028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5C85AA60
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103BE285717
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595C45953;
	Mon, 19 Feb 2024 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="A57LkGzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223147F66
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365103; cv=none; b=au7a5u57njPTzHnF9E9h3mnv0BZx/07YAJBtVqyRmi0DWrPKy5EvBsNSur9NmnSsphEtfmpLhr2D/xJtG7E0HcFfwshpcXXZCa+2vAhoJp+nCLG4MFoNLSP0RvTB1xgXbKmKInT3VptFyJmKRwWmqcCgw+mjbR6yGZJKhFsnlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365103; c=relaxed/simple;
	bh=+3GTbcS5WzDC1El/BaLUKCrA2EnCwe7zt2J6oKYSfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ouz3lHXNbapt8QEHIbWmK/2uPder/5ehnPyPqUnLbZBAnh3379Uz3ixEB9Kou4xvtqmdVw3nMgv4Q27cNZWX0avTmlP33V+L6bzEoCES3nGximvvqn2eDrUWqbvhi8xmoMVYUf3plkj5z1qhMM8oN/ikP43R810fFGZxYC7CacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=A57LkGzi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e466a679bfso557244b3a.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708365101; x=1708969901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFpnzmhMeJlUvetevd4q8TG4lvcQZP6siwOw9F9D5ek=;
        b=A57LkGziLcqGu7sCTtjRS1GPSs3SgT9CXJjIg+sdCLN8He8JdjzQJknSfJLg0M6n1x
         SlDjg0kyde2KO6x61kJ/sE9khjyL8zxoo8SBnLizDZtnaZ+Lq1SZZ2l0nNxF6j78GY/w
         q6BoJt8IYCezwHJnXBAtlbCzbtQi2ZzOKaNIdKExGt5R7+XeAOlBJkf1wW6HhCFTXCm3
         EtEcoNrhUFHCZX4fAubIMH4L2XN9A+4dLC12zqLDRssWgomC7sREzybHxBTzXnZQQHvX
         CD/TrSTTvrN96aUWvTLNnc3NXymQPPIRl2jc04EQwKFJXrn+EG+OFhgHIEWw9ENw8kRt
         xZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708365101; x=1708969901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFpnzmhMeJlUvetevd4q8TG4lvcQZP6siwOw9F9D5ek=;
        b=adTA+C2LAD1Dg9jD9iVimQCqDDDkA+DUHvck+MTXm/+FQzqEKJ/GiopRh63PEpX69v
         X3kUsnVn+FwtTp1iZPA/UP4/yg48u/J6LAqbQBSEWyStvkCVV62wyAfWkFTR0DIoH5ky
         YvcTk74/R1u+V0ibhmSjd+5bvWbRQSlHKAbCwfpbrJKYw2ItOeutNEPtD2Qf+/LLYecb
         PfF7m7xWdtpl6ZQ9C1Cz8U7w531ESjvFk0OwF4Z7p1juvr3UKQ27DGfFNSNZMcUfjUqW
         YVZUc+PWVVPgjr5aNB17ijA80DptiU8ZejZVHakgS7pGnME4adsl0hBlZlz1z0pbkJbV
         E6JA==
X-Gm-Message-State: AOJu0Yw0osRlFLUZk2OI2I8uallYaqTkAsBE9nwxaA2flOh/hiriKGz7
	rP+Cd59oBGDKxM1kWI+ujtG/83bjU59Sca9huXjoEACLSYNnOVc+PvlAHRrrMto=
X-Google-Smtp-Source: AGHT+IHV47zd3Ouq/WAaICdbAypiUHo46VPPowcqs87UWevg+d6bCx49vUAv/JsvWLAtaslimcr/ww==
X-Received: by 2002:a05:6a20:6f88:b0:19e:a5c9:144e with SMTP id gv8-20020a056a206f8800b0019ea5c9144emr12656831pzb.59.1708365101365;
        Mon, 19 Feb 2024 09:51:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id k21-20020aa788d5000000b006ddcadb1e2csm5123092pff.29.2024.02.19.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:51:41 -0800 (PST)
Date: Mon, 19 Feb 2024 09:51:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ctrl: Add check for result rtnl_dump_filter()
Message-ID: <20240219095138.3e576a50@hermes.local>
In-Reply-To: <20240218194309.31482-1-maks.mishinFZ@gmail.com>
References: <20240218194309.31482-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 22:43:09 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Added check for result of rtnl_dump_filter() function
> for catch errors linked with dump.
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  genl/ctrl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/genl/ctrl.c b/genl/ctrl.c
> index aff922a4..467a2830 100644
> --- a/genl/ctrl.c
> +++ b/genl/ctrl.c
> @@ -313,7 +313,10 @@ static int ctrl_list(int cmd, int argc, char **argv)
>  			goto ctrl_done;
>  		}
>  
> -		rtnl_dump_filter(&rth, print_ctrl2, stdout);
> +		if (rtnl_dump_filter(&rth, print_ctrl2, stdout) < 0) {
> +			fprintf(stderr, "Dump terminated\n");
> +			exit(1);

Why does this have to be fatal and call exit()?
Other places in same code just return error.

