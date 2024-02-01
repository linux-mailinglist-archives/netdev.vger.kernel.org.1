Return-Path: <netdev+bounces-67838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8F845193
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1DB2CD61
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD215703D;
	Thu,  1 Feb 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+XsyM0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C36634FF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769847; cv=none; b=GZizegV8piSPBGwB6QxJP7Ed2CkFeqhGs1rGAuMowvy7tLMmPvVoVvSCZkEu6xKRYp3/kTGQPSPtQB1/P84ku+hcPHU21Hly7Qwqz2T4a9UbMBhK/jfXiP+4honAQ/v92vlyKHpqGXNzLyOXHU9f5OyDiKd1u4D8HHyJpkn9FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769847; c=relaxed/simple;
	bh=U5aGomajzZOLgTLSav5hr9CryQnZnAvcqn2VRQay8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkjj+1nZvvK9rJsMNsxfWB776s4zwECqxpXP4QGMyFgUxO0KvE+j2/at8Rfmc/KCygK2UTxgpMdJl7ern+Fp8sYnvqRHqY+JgfdFhfuIraTUytJ5gykTsv5hkbpqpY/igPVyICjH1u8XRLCCtb3KoNIJk1FB7tD1Hroy6Dqw+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+XsyM0M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so527202a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769845; x=1707374645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8NHCKO6vU42tRvcwWPVnxsjPXYZcFymbpLAXd84vu4=;
        b=N+XsyM0MYIaoBSlS9Pjjvhq+UcFW1lv1tu8HvM8ribQ5lXTSbBZxgLEorsmqYrYUJ3
         xU5JYwtKCnfVwm2Y3GgN6c44A3T4o83Rplzn8Lt8fDbnz4KrxfGYJrrwEV0k2gdTmSYe
         +vbLUsG+RwRSKE3MRzanAZw+SnOkcEgKA0vyLBlLR86s2YoY7ABulJMGwesmqKZU38O8
         mUAvBOkhR72cny0t0LnwTpSwFG3OAz2B95ODzrG6ynf6h7V2qfchUKPIuslekD2jx5pE
         MLEBD4XqievMyMmFYcssoodMfQb9LH7jGDUlJqoMWXcN8paQUUXR02owLzxK3qfHgG/a
         X4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769845; x=1707374645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8NHCKO6vU42tRvcwWPVnxsjPXYZcFymbpLAXd84vu4=;
        b=DOk53/Ue9B9nTcCTnNZfKIxxB71tsH/1XYycMgrjHBPnIeFJiPJCbBq9TU3X7kfjsV
         EusC0y6ErmqOtuHFr7hc4XLcf3yzs2A5ECK3uR6DWQdq80EQPW7ihjZTJtLNdlC6K6P0
         8q4ChrFJixDv9UNnHuq5iEFGDjJMkyfPWWQ+dhezec4tUKOsQlzevkOyaS+BAnm+dtXV
         svosSBMnKzBTVUOo51iFhxQ04wHZFxJHFX3kRnHey7wYK6feKVgeB0toRHTpDCpCREJv
         2gcHxQesHnCQ1hkpwpFYAx+eGpomqps/CY0CVRvtNkPgrsMlQ3S0kjUfML5jtW22bJ5v
         dJ8Q==
X-Gm-Message-State: AOJu0Yx4HQYs2kJm7B1tfnmq9dv9EYB2GmpzU0w9KYDmo+1ZDNP2cKlZ
	1Gn4vCkY7w/utpCLw3suLe5nQmIqlj9Q0pX14te7qah97kDfzBGAwbaRyuwGviPe2x1d
X-Google-Smtp-Source: AGHT+IEvDM/CsLHGGngqdTl/oLr2KpaPEo0A08NV6yQixQAPMhpGW5Le4FVXcDzHAO8TF+uLlvZUcA==
X-Received: by 2002:a05:6a21:9712:b0:19b:6b03:efcd with SMTP id ub18-20020a056a21971200b0019b6b03efcdmr1268913pzb.9.1706769844605;
        Wed, 31 Jan 2024 22:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeww2lFhkjqp/Bt7UpuEkg4x4kf8dplim2+JJrXm5HMvvzsIZpoq6bYHedOuR+SOjgcSneoYgotphMofsI+VY+GJpllxNRfjZlxwVn14BYnGW/DyisLlnmFmUkRx2junMzrPE6CsXEEoufml6aGH31mqV90zcVv2z62OniyDIY70zBxK5kWAqN6/I6L0RcPMuvGKgfCuEJQ4jN6WjcDo7C6Cu/VzE+A1fbhTHu
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001d70ad0fe79sm10110900plp.291.2024.01.31.22.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:44:04 -0800 (PST)
Date: Thu, 1 Feb 2024 14:43:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCHv2 net-next 2/4] selftests: bonding: use tc filter to
 check if LACP was sent
Message-ID: <Zbs9r16e3FdhHIkH@Laptop-X1>
References: <20240201062954.421145-1-liuhangbin@gmail.com>
 <20240201062954.421145-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201062954.421145-3-liuhangbin@gmail.com>

On Thu, Feb 01, 2024 at 02:29:52PM +0800, Hangbin Liu wrote:
> Use tc filter to check if LACP was sent, which is accurate and save
> more time.
> 
> No need to remove bonding module as some test env may buildin bonding.
> And the bond link has been deleted.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../net/bonding/bond-break-lacpdu-tx.sh       | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
> index 6358df5752f9..01dcf501da41 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
> @@ -20,21 +20,21 @@
>  #    +------+ +------+
>  #
>  # We use veths instead of physical interfaces
> +REQUIRE_MZ=no
> +NUM_NETIFS=0
> +lib_dir=$(dirname "$0")
> +source "$lib_dir"/net_forwarding_lib.sh

Opps, forgot to rebase to latest net-next, which merged Benjamin's lib update.

I will post new version tomorrow.

Thanks
Hangbin

