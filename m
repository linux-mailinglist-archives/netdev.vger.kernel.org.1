Return-Path: <netdev+bounces-70243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC284E236
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DB0B20F33
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9176C63;
	Thu,  8 Feb 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev5Q821A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000076419
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399962; cv=none; b=I/Y5lhgNvzXsRBMhJ2toqjmo8XWtm0tGQOwsd61NRo2Co7LVnd7uqo6ZEMOCrbz/Rcc5ZJ4L6mt/EYCfureBNnbHI487Vl3yoxyIdYOl9xa4PtYVbzm++GdoJkCUsH/ypZ1ZMKgUPIndDzM7YwSpd5eLc8OUuwZ2xB9IsRfphbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399962; c=relaxed/simple;
	bh=eXtXqghq9WdhaP88zdkhrY7G6XCj7FX8hgfTvqaK9dw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lP2UmN7kRI6luUZkX0nnpaC+zriQ8SHD1AgtJLbrZD4sfHmSJwp9EzsTsK6hDSdg6bUGXcD6sY4jR8384QHk57z2I+vlHDQsYt9SjDoTd7wgoXd884b3M1ac5QkJhvHWgs5kN8JFiVs9cksh59Owog+1r5BXlLK8j7ztZLNNgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev5Q821A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so15839715e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707399957; x=1708004757; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwZusaz1maDyg9XQP2riM39+W1Jju9FJxzIqqMw7kLM=;
        b=ev5Q821Aj4Un/97qi1rgmxiLpYnGkBtM6SUlmCzQo6B2vOESC4soQUGYW3IuyDNwID
         EGIjt9ZLRM+mjaJYhEpvvthjUY6ldM6AZEmD0SNoviKHHz/iTQcbQdK1v8RdknMW3bdx
         NIiVlVBAZApTnS5BXk2gonTj5Ha78em/J0dikWJ8el/n45lHEyxk+fEimuvRqxNZS6QU
         +sORxjfo82rCh7UozOoT2bNTLgllV/C4aT6DYJy3100lNxI9ZdaOWG9L7iu8or9nV4Ss
         6D9bYYnljVj/aYrHPTeF831bFS3FS2tGicpDsCt2xD2ElU+zEww9Fo0XSB2YG/q0Zc+d
         ngOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399957; x=1708004757;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwZusaz1maDyg9XQP2riM39+W1Jju9FJxzIqqMw7kLM=;
        b=urS0LPsZtgnTHTH4FS9H44q7LB9xKqan5a2CJ5K/UcZeEil1hH70ksJf+tU3YZ99XY
         54UGq0R2MLoJjqh0BUvYzGjU6C8CMMQN8k5df07CHGPkYZdx4hOZbGdxvVs9HzHVfXrf
         e/Th6irOC07N4afTYzPViE53ZaVZU6wrdlj67136FNRCE+iVW1saGNIeWOQko+A9U5iz
         shNOve9UH7tAjv7rc3Sumdke17rhcJwnBguJRXMZLlu3cjxF6E3CZzdiWP9GXFutFhoi
         6XvwTOJkH67kcivNGywIr3tk1dbmq5tvBQWsv8UQ2eudrjjTkbtF4XAlULGO08+Q+Ra6
         sr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkmZeeI9zL31Bq5PDuTPcVt84fIvWotr0O5RGPs4/9tSb+Ga+wWXhZgJT/LH79NSSsCvPbl/bztRPOKMptz3Rnfj7dW0CE
X-Gm-Message-State: AOJu0YzEnIJ+NgDqteUwEQfeePV6SAvBeVQ2lQQ+H+UKldVYt7gNq450
	Gy7tUGeY3/krYoaGlG0W1TGU8PPUiMovNvFctS+/Yb+RYOXxt7C6A7RoOViUb9c=
X-Google-Smtp-Source: AGHT+IFRvttGZavoWz5DDz0KTW/SnPYlQ8Q65yMFlkzPSNdCNYBnjS1aCI+QMqLSV2NAkayMPOy6DA==
X-Received: by 2002:a05:600c:3b9d:b0:410:3fc8:5ac7 with SMTP id n29-20020a05600c3b9d00b004103fc85ac7mr1160147wms.10.1707399957133;
        Thu, 08 Feb 2024 05:45:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLaKoWRiIoAOVEIZYwCJvsba478n8rbroo2u5K1LCORFDbo2V20CvUjO/XCk4fwaQf6XfeHjNXwbXSTAb6/wSQbPtYQDBM
Received: from imac ([2a02:8010:60a0:0:4c4b:7e8e:f012:825c])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b0040f035bebfcsm1691254wmr.12.2024.02.08.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:45:56 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] ipaddrlabel: Fix descriptor leak in flush_addrlabel()
In-Reply-To: <20240207202542.9872-1-maks.mishinFZ@gmail.com> (Maks Mishin's
	message of "Wed, 7 Feb 2024 23:25:42 +0300")
Date: Thu, 08 Feb 2024 13:32:11 +0000
Message-ID: <m24jejt738.fsf@gmail.com>
References: <20240207202542.9872-1-maks.mishinFZ@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maks Mishin <maks.mishinfz@gmail.com> writes:

> Added closure of descriptor `rth2.fd` created by rtnl_open() when
> returning from function.
>
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/ipaddrlabel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
> index b045827a..3857fcf5 100644
> --- a/ip/ipaddrlabel.c
> +++ b/ip/ipaddrlabel.c
> @@ -201,8 +201,10 @@ static int flush_addrlabel(struct nlmsghdr *n, void *arg)
>  		n->nlmsg_type = RTM_DELADDRLABEL;
>  		n->nlmsg_flags = NLM_F_REQUEST;
>  
> -		if (rtnl_open(&rth2, 0) < 0)
> +		if (rtnl_open(&rth2, 0) < 0) {
> +			rtnl_close(&rth2);

This change is unnecessary. You're calling rtnl_close() in the case where
rtnl_open() just failed so there's nothing to close.

>  			return -1;
> +		}
>  
>  		if (rtnl_talk(&rth2, n, NULL) < 0)
>  			return -2;

