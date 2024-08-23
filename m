Return-Path: <netdev+bounces-121276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05995C835
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3384C2821D9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D413D8A0;
	Fri, 23 Aug 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a6nUT2O5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F12E56E
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402391; cv=none; b=KpTBJmPN5n0CXe+cj8kEDHG7qZvgJzCDMUk7PzTXSNFEUgou83gY2/6aHE+tpZMFEtdGf5LakT19JfPEV5L17c9g1xaYXWcsAH7yWlu1DF2TkVh7daHGkCcCqGnzVOHChFtu1qiPPxDvj+AzYbltq0z/DQzVdnIM6ZWDRpHPj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402391; c=relaxed/simple;
	bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox5jnWR+U32wGVqs8YheuxRDeocBV+gGjRFYinVCdipDottUN2Crdkx/TslPaDN4KyLvVIpQtebHvhw4ZxNPPHG1VIMopfvL6kocfg2x1GFJk4pJftCu3h7s+aGq99u+yd4RynRAu4wAXyNdKorEIqELGKJRC5V/PoRt+LXEuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a6nUT2O5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-530e062217eso1994590e87.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724402387; x=1725007187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
        b=a6nUT2O5Wv1b6v0f5rctqZSTgXqAcy5WyocgXpqWvY3BIntPGFxCQ8ooA9jmmK2EyJ
         /yVu6S+lQnDdVZNvElUhROBQIxTGUpCPrn3VYdMo3SIX34zRIZjZNZe9/c90MCYC2zuf
         7oRxBa+lDbW0HZ5ZAmD0uuq72S6oJj3nU+VqCUacsF9Ujy/8zb01zIpvgvK/i4sOEt4V
         u9vPoOnlqQfQKXNjHEtNdDlh8Xc5IGDSyRRsJYJemLnFqkOBc0GHjwX5IGbweAZKR84K
         qUzAQ4E0/uFX86UXn7rqiYNrV5c7qYbwcKY8Hc5T4OJKqeKU+OtIe7InSk59RPZhe2Cp
         SdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402387; x=1725007187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
        b=OzUBTlGR4/NKZ8pmk1SdIJ2hBE8iX3EzpEq2JFt0Gdg787Y8FDJMyP+2WG0Cz7yuZC
         QsxpSfyPHF+qdb7I41z9rtJkzIOPsxqMQw3QGzD5zW+7d8Pb5gzRakvxFIREvyLc9tG8
         ShKZPQmxCBBXBHqpNPIgUznlst9kfZzBct2bOSk8OXdx53Igyh97fSYp/YpwNvHJcMaS
         zzsi5z/YFCC1mHIr8dAP1xCYgisIt7SJEFNHRgIrTXyrU7HbLWXwnAcN1PanQSubzNhG
         TwMRMgKtptWuruoSiv3KtJfsuxZsVP0zarM625D5KFTxL6AvqSIwqZwjwrVXozUR7uTf
         o/QA==
X-Gm-Message-State: AOJu0YzY9TeJQqyQzvSE52oF4JNpxJlylJXIuMtmnVdf8TiPgWoldRxJ
	UzwirrIXXvdaValwEmM2L/Fc/uU5rTtogYt8V5QBTAu7bbwkKmj0IgeSM+YNHSI=
X-Google-Smtp-Source: AGHT+IGOWVuOC9yeeKp5mZ4UlpcTLScCESsqL86DkbvcGyGbBm1D6i4r/hzXl4SKazXPEZkY4narSw==
X-Received: by 2002:a05:6512:ba2:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53438773a9emr1136975e87.24.1724402386504;
        Fri, 23 Aug 2024 01:39:46 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e74bbsm229799366b.95.2024.08.23.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:39:45 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:39:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] dpll: add Embedded SYNC feature for a pin
Message-ID: <ZshK0IEblXbjNKMh@nanopsycho.orion>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
 <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>

Fri, Aug 23, 2024 at 12:25:12AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement and document new pin attributes for providing Embedded SYNC
>capabilities to the DPLL subsystem users through a netlink pin-get
>do/dump messages. Allow the user to set Embedded SYNC frequency with
>pin-set do netlink message.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

