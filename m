Return-Path: <netdev+bounces-108068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847991DC1D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364491F20F04
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33B127B62;
	Mon,  1 Jul 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT4eDmaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0F38397
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828669; cv=none; b=cfKN74ucIoy2zn4a6/ofZP1mJWULDidIf3qVpYgs06LIZ+vUrOuykit6WPZ2utyimfHvSsmmRw4up+/w3g0VuRCRqCzZp0ZToQhHtDx7kq+e2smJTItPLdWSVRVP3uuTtv5Yly0bP4QxEjNu/Ke+7RwW8Fk3+KnwS5GlGhhVVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828669; c=relaxed/simple;
	bh=TGsjQxiadE14tjH3KPORtUHqMio0HY7zNFt1K3SEEco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nRpDAd4E/1L6GEl2j2jti2FNw+vATCGDWjSahWAxIvWACF02Fp2P3wr5BUJhIYTt8/yhvtRvcHCe90/dX0aKFCvsdDgDsMGa1fclby+0uGhHpjEIHVnNzbJ1n8WVuF5TJS0Nn8iUXmhGeuvXV+6n0D2p0IjktjxhcviWffDxV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT4eDmaW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa78306796so14633395ad.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719828667; x=1720433467; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGsjQxiadE14tjH3KPORtUHqMio0HY7zNFt1K3SEEco=;
        b=YT4eDmaWbuTCwMNfHPzpTWhMkzxu6HC0EJVU7ScAtFex1kqzF3WmPCNQOeaObNmHa0
         OTOwmFOyu9VDdvuFyKCt6jVN2wYBZKwZKRPzajrdfbXY4m7B31vy40UrPL03UvQEkLHn
         z8IQjjT4sQ0Mac7IyTX1hrnAPftDHSbrVxXZoBAy0F4uIc2sZ3IYcpOCCkGlr9Kjfok7
         45t73GEI40+KDHck5Dghh58siXSBc+1beeFy52pNz9sclhMGu9zX4OinSM+TcVgBTk4J
         BR5AX1L7/qbYANjywWFEZcOLHHvc3eXAoDt+2qDAoLoSPA89bSJ+/qOS7sdygnxtgkXn
         3Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828667; x=1720433467;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGsjQxiadE14tjH3KPORtUHqMio0HY7zNFt1K3SEEco=;
        b=CdTCy3sVfse12dA3SF7NlhtfsIiKBS/I1sdFrxRZQAdr0CjHhDV8GpQsIdiu6Q0dR8
         k0gWyzjrFvtRaca1/eG9BMg+1SVICSecGrElZinCa2vZWt/PHzJQPdCstnxN1ZmPfOIt
         055B25MY2yhDmkEeHKkUcadybXKv9V9foZbsSj1/cITSgopikYTdScAg6R+3vD9CcubG
         TA8zCChL4F/fpGx+TRNobsbg2k3cfLx3n11w4B2VV32mmpw9hbdQCuZngaO0nk58cmhU
         tfUJeIIJsRGNmFOxoklr+kLttx1UfRla7OFZd+uXJZvTVW2RfYshjVeMvJoobR86aJ43
         +dMA==
X-Gm-Message-State: AOJu0YzERwBg7LgyWkGxZNNdxYtK5Pv3QJdwGyKbY+8gJBAg5gVbi0JR
	yy64mfRTVe41PqNSXeE8evyUeOiYL1+650W84fRxgELOMSbtut/NCS1xu7r3CtU=
X-Google-Smtp-Source: AGHT+IE/maxxwwNm+H0EiZ2GCAsBNKPCgMEx5aVcUaZgNOb6He35blkBOv5k7kcmfP5IABrQesqoeg==
X-Received: by 2002:a17:902:d4cf:b0:1f7:1b6c:b01 with SMTP id d9443c01a7336-1fadbca158fmr32307105ad.36.1719828667387;
        Mon, 01 Jul 2024 03:11:07 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:62b0:7aad:184a:7969:1422])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596d55sm60844835ad.277.2024.07.01.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:11:07 -0700 (PDT)
Date: Mon, 1 Jul 2024 18:11:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [Bonding] Should we support qemu/virtio for 802.3ad mode?
Message-ID: <ZoKAt6ZkoCR2roEx@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jay,

Some one propose again[1] if we should support 802.3ad mode for virtio driver.
What do you think? Should we treat the SPEED_UNKNOWN as 1 or something else
in __get_link_speed()?

[1] https://lore.kernel.org/all/CAJO99TmB3957Wq3Cse7azgBxKeZ2BV6QihoyAsjUjyvzc-V8dQ@mail.gmail.com/

Thanks
Hangbin

