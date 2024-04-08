Return-Path: <netdev+bounces-85738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F47C89BF4F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4127F1C224EA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9987C7C082;
	Mon,  8 Apr 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XK9zbzRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8577F13
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580252; cv=none; b=ZQaUH9Fv18n1ag2vMXBZtYkmfdsL01BSHVvbSii9TCsNbQ1of80LtkhuruEI0u+Jt8aAw/XDw8cbgTR6aL6ASxgDCln3hXCeiGoc73OWhR4gqktGCbNBsuWPPVagO0cwjqNIhaOcPHo7AFBBPu3UE/taLeTL5f4HslnoZQ0sCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580252; c=relaxed/simple;
	bh=Zr+1C6AMrdIdosUk3eIJmCBfHO6COi5oAT0Uj5E0hjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlTot+8IWs/d5W584fQHeM2az8O+utaPbMIu8G8xNyVQLiHvT3c8AnNhMex1HcCNDmpsfALzBONch1GjO7vP8X4jowTU0JyfD5jQn8fvoOkvfxEJnX3FJKq1T7xJBRgGMjU0r1OMmw/mLPGWQaLekuxqs4sL2Xw4smYOMrNDXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XK9zbzRN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-416511f13aaso8634395e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712580248; x=1713185048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr+1C6AMrdIdosUk3eIJmCBfHO6COi5oAT0Uj5E0hjA=;
        b=XK9zbzRNwU56eqUuNS4GVi5MqnTbKrL+/uUiO/N830DiA2Izzm9OHB1kZKdLiuCYub
         WjvAILRuxnUE1f3WwlylOxOjUpdNfEHVX/SrpwVpxJrbx+QK6uUQbUKO9EATMYXuSru2
         9onpWbGHatDtZJchycDemEDi7akLO+AFeXRcim4kv1dDbEL08TGimQ3mbSPuZ1kKKEIr
         zH/kv8il0Gk2G4vIRF3/p0dmnOlqruvB022Z8lVxZz9PKgjGxomjxI+zNeAIux1+ejAn
         QIO27jUabXt+n0YeNafoGAPMpnX0IpL509oeOg3M1wlAtCIHLrt3bKcnk4EKjdz6Oo9L
         G8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580248; x=1713185048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr+1C6AMrdIdosUk3eIJmCBfHO6COi5oAT0Uj5E0hjA=;
        b=DCALYzxTQ3EGXqbH1hSjXTehi2irvvSBWso+WvZyH9UjI80HgGueuG2bQdacrjMrfr
         KMBFSXYzYW1QZ4Nf2hhAQA8D7TzjhkFOZJBWXd+BCiy6Vd6zUgsUgxdiMY5FAXfbaM3n
         Z7B8yUPHZuUzGh+ha05zsIyEFXrd4Eym0MifqalaEW9gi50ir5ttQl/t0vLG5kmpHS33
         tm6Q+QAOPes5DWFhyvRQLOKe7lsz2QSEvEGygeGVk00nrHi9QygTheNaSzv4swd/wixQ
         mkegF0DhVYmyDV01E/pa6GxcueW7dciqXUGNCKn1Kr8ZbOznF20YeV2lwEww3UEtcq2z
         Sbqw==
X-Gm-Message-State: AOJu0YzW9UNPXCy7zJvnDpKwkv6gl66ZAeKybnlwnQ480uU9x9dbZiq7
	EoI/38Hv4+4KLK94GKISnPWvajf5UzQYmmupGojsT67pfpwn4cWkdz6aq6gE3Xs=
X-Google-Smtp-Source: AGHT+IGT3I51sbHihk12YlzaY/nd+QTgAV3yBeDem8Fp22k5JGBZfOnoWf+LgfjLwQxeK39XA4/fWw==
X-Received: by 2002:a05:600c:a42:b0:416:1d6d:dc6d with SMTP id c2-20020a05600c0a4200b004161d6ddc6dmr6057461wmq.40.1712580248295;
        Mon, 08 Apr 2024 05:44:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u10-20020adff88a000000b00343e01d3f6dsm8882182wrp.3.2024.04.08.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:44:07 -0700 (PDT)
Date: Mon, 8 Apr 2024 14:44:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, dw@davidwei.uk,
	kalesh-anakkur.purayil@broadcom.com, saeedm@nvidia.com,
	leon@kernel.org, shayd@nvidia.com, danielj@nvidia.com,
	dchumak@nvidia.com, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next v4 2/2] mlx5/core: Support max_io_eqs for a function
Message-ID: <ZhPmlL_ptzw9PJ9z@nanopsycho>
References: <20240406010538.220167-1-parav@nvidia.com>
 <20240406010538.220167-3-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406010538.220167-3-parav@nvidia.com>

Sat, Apr 06, 2024 at 03:05:38AM CEST, parav@nvidia.com wrote:
>Implement get and set for the maximum IO event queues for SF and VF.
>This enables administrator on the hypervisor to control the maximum
>IO event queues which are typically used to derive the maximum and
>default number of net device channels or rdma device completion vectors.
>
>Reviewed-by: Shay Drory <shayd@nvidia.com>
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

