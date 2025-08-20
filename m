Return-Path: <netdev+bounces-215318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC94B2E14B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8994D1894B49
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91182222CB;
	Wed, 20 Aug 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="C8LDnFfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8036CDF2
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703899; cv=none; b=skuUdOQjs1Ag8x3SedntkLqvW7VeqVxNTHb5ZJCu9O/gD1Lm2LBMI2bMTC1XNVUZwmEHIAN+C6efwFEqmds0D6q5vzYMkoP/xtr/YJEQilq7ajFBXgJFH3J7YaS/Okn/0VUz/M4eRPneAArDKDRjIDs9U45VG2pDRHvFkQA4OBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703899; c=relaxed/simple;
	bh=10I89XL/l2GRS76lOXYnSC+MjwZsTherQYswe/RkQt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGOes+RlIOwfqOVpbxiE9bbVuiuzW93VhVFd7rrAuSZQ7giWzXr9wf1NA5xgKxq2sF2NCjMYTubgtf3hYfXEFDV6bpM/GqN4FnX3Vcm+38ElZqDwanuZZuuUxLNC8URafPSxO2MVm0yp9OVXRqz+PBarz1KWlesrwXm8UftH4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=C8LDnFfK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea79219so53410b3a.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755703897; x=1756308697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CFiBinjOkqTeTTRLQMbijMZjq/eImrXz0BMlfgI32uI=;
        b=C8LDnFfK2ynDUobMq839AryvR6wprfGJkp70IrRuj+JByrV4SLDBm/74KO2ROiqTR0
         UHgsHYsEC5Bk14T1uiSSCNI3yDbfEYC7olgZwgL0/gI4258I4vK0qt3ZbZskdDpaDz0F
         l4aAqDUk9sUHUAOQ0eyqDlWU/ckSRe/SpgprgXl+vClQtmyAOvnY1y8Px+IgXK6y2rTg
         vmi3R7qZLdVFS6SVRwCUAq+OtO0Vj5gIIz1E3HWWpKJU6WsyF7/NaDmoHcosbQRaxatn
         dy7aPhYoev1oQU6JrUk01PgaqKYoF3OK0mRIVCV+/6BKS6tC0llS5DP++eZcuGrCEZOE
         U3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703897; x=1756308697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFiBinjOkqTeTTRLQMbijMZjq/eImrXz0BMlfgI32uI=;
        b=Vg8fZUwTyduu9+uVHAqCU+ahvVls30MzhDGZXBXVFyDtYsrbw5gA864vngNNQnUp9E
         Vzb/IWAM+dM2KTuOObMGHS50EDa2nI7u9eEq09d6cJtlB6U98IYZYZ6MjYncz3aA3j60
         +JBif8hXBiC+pT/rwuKkCqFhqZyWLwcTIBAvfn/WDExnVMlqsG4CcJHaVIf6V2AdX0jT
         AJl9yy3aDj3QtLtiUTtvkap5cM0g4nUtZUVX7PUw6yUiTAd2RNazpL7hyvxumI2Brrre
         eVqR0y7mByLPtAjRVSbW/1VIJxxabOLKvwqesidzYNxLMcm7KbpIsq7ABGID9r7AnIAe
         CfaA==
X-Gm-Message-State: AOJu0YyzOodRiJDkMwL4T379FNTILlt4ON856ljpiz4qEnNWwpy5RS45
	vswzK15rnGhImMFnvP9MBQkQXXr9ztkts6m+uDL5i95SMBD1aOsnGej6I9nbU4zJJOM=
X-Gm-Gg: ASbGncviZb6ZTRqj/wnyC1RWjKSteJ+77jXCl4/ysK/riSUtpmyRpaAL/mPhhNnloaY
	Tcfb9NBocgbghfeMmi4sJBOdcsCAuUmkAC5/DVI7UMpLCGOUxr21Ip8z00TJMZISZe/6iAZzn9F
	xOGqCDRdVVmTneRZSTLD5I0WF7JuGgb4AV+FLZFPSy2goxjKt8+VXdzG0gCXtXvrxK2Fc5k8chE
	WoiUCfZ8HgMIZPVSGr1Fo94l63KiovPq2zTiAVycgDyrVaEtDNhWB8bHzWMN+kPG8HLYisLiwQK
	eBmtwpjYc3hlG87LPjTUUKWZjyxz/IDR5sIbXoL56zhzxkfgy8q8GgWiQrMNiTeZlJVfYZj3q48
	bWNHpZ90r7SK7ti8bGh9NvTNy
X-Google-Smtp-Source: AGHT+IFa+65EiF5gOLmsUqiKDfGi/hjEovv5LFIEhAxpf/e3lDkv/Vl67MHoAyiAjrypV/nXob9hNw==
X-Received: by 2002:a17:902:f98d:b0:240:1953:f9a with SMTP id d9443c01a7336-245ef0bd96cmr33559625ad.2.1755703896739;
        Wed, 20 Aug 2025 08:31:36 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm29774255ad.134.2025.08.20.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:31:36 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:31:34 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKXqVqj_bUefe1Nj@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>

On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > The same naming regression which was reported in ixgbe and fixed in
> > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > changes") still exists in i40e.
> >
> > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > ("devlink: let driver opt out of automatic phys_port_name generation").
> >
> > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> 
> But this one's almost two years old. By now, there may be more users
> relying on the new name than on the old one.
> Michal

Well, I was relying on the new ixgbe names, and I had to revert them
all in a bunch of configs yesterday after e67a0bc3ed4f :)

Should e67a0bc3ed4f be reverted instead? Why is ixgbe special?

Thanks,
Calvin

