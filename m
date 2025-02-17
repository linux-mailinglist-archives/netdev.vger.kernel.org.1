Return-Path: <netdev+bounces-166892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B0A37C79
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA93A16ED6F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291B19E7FA;
	Mon, 17 Feb 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKjQfq21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EB17B506
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778425; cv=none; b=rT0vAJ01VU2XZ82a4Ew5JVTxrWuKIjC7K1IwSNv0vxfx40yZRKNLNR9wdsyh5hC9O2ORz2iWGyTvYlHFZsKpr5qP4Ij1lCKy0tm61Dvu4yTMDdi+k+4uDXG9SCzxvDyA0UdOX6wiS+Evh0dvmKMw2GRQ1ZdHbr3rXZd4a+oxq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778425; c=relaxed/simple;
	bh=/7+X/8JJhgKyjp8QBm47UaAfond+/cBOELwm0q+9j84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLal4eLgcreJdFOBnECa/1J+L8ysyYoQrVKtFg0GVszhaRxbbW/1Bk7vcMcIvAFn3Tpfsfe6Z5HE8tOMvq2Rof+eFkS/5I3/OJlcphKwz9qJaoWZDR0i2jECaHZrpzwAni3w9oXwarJu56mlb+AyXOk0X+ADQF07RNC0qKjF8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PKjQfq21; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so511027766b.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739778422; x=1740383222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCdtza8KSiVC2KOZe/DG7HHNZUgFZAWcBB2R41X4AAo=;
        b=PKjQfq21bDA9Mi7HFtmxGqNN/JI0KaMf+iUzVbNbUVoxlV1++wSnffe/tF2uzgcoap
         daSd0kzp+vv7XHEKUxHsMClYAhzGby99wRjewUfi3ue0bbNqaXdgn7o9X+J7uuZiEdPt
         oR+Jxi7KRRax118TruozFqNEPS4VP66ntkcaagvP0LcBXOJ71IUxpPYkFCUEGCPSXyR4
         EhAmScJo2gksmUMHdxmzHlUUt2SCOeOcp63u7WAMKZ3VT9Xz8u+jbMp2HS5nKczy7Mao
         j+qP6bY8DyF766Tmozusv0z2Z8ckHqu738u7Tj19cdtAahLIME0zhYePDBn/Uy1r25d4
         lJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778422; x=1740383222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCdtza8KSiVC2KOZe/DG7HHNZUgFZAWcBB2R41X4AAo=;
        b=GG5MX8Nyl61WLyNktZfQw7T+LEtphKv1BITrECvcZOk6jYJ5xbvbgOZEjVuN0oUa4/
         zUJ4Wbw3ulLdgos+w+7r8Wlieqhpxsa16tKy8MDFTpSXjHweQa1H4zeT0Lq6iul92zR9
         VET7N+My9+OqCMsDhZUvmcKN/0TUXxWzxFwK9jusao2oGdHvQO3PAu4hQVoXz8+Nk+Ku
         d0HZtkwesE3CNbP8Hz8foAhc7rKADJvMEQknaq37+n1RDzvCvnh8nDEboymlujzfyB3C
         jme2/3bpqVfPoMwIveqa1d9EdiH84F6TPBmn2RC0iCh//fp/9ZMT8uPLv3+SyS+CrS6F
         ynmA==
X-Forwarded-Encrypted: i=1; AJvYcCXkBaVe1qf/14vNlS9lrGUhBV28FH5r32nMBIqMnlrOINxnO1Q5V85tW4nZy8++S3kqmbdHNoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIzD14h+arLZYSW158PXz/Yla6gITp79tUuLKE5Q0PVRb7JdE
	Gm2p3c+vDaaBP35DrvRdEiCDtaYlChQUvWJhZxhY1n+5rGMv8lqZA8JzxNPiex1meCpAGjhhDZb
	ThOk=
X-Gm-Gg: ASbGncsYQMxXgERc3SDOMEFiZ7T7Y9tsVDPdJg580sByW6kTNQOD2GME8Qzs5/yymmt
	jowrpgqfgMOZ+HTw2sZ6BDSfUnI1Wr4uZlagETnzluiNRW8ruHrcVqBfn0v9EReg2E349SfZc3H
	GVq607KutXtQ5u5SX6pWc2dpoP+xNA6mmQeyim1VQriRM1u7NvhGXj2rRoSQyyEuIBmsUqFoD7Y
	rcAyaDnUruluyYyzs+aWV2vowlMJYxdYgJ5BTtx/oqk2brmo+HX9EaObSrtgAU5pt2DW/MAfEh1
	So7bFUrTMH8/IWZQ6FUI
X-Google-Smtp-Source: AGHT+IGc6mC9V03mlOIabMGrA4qvI5h+wweB0R9eSFjdGoZcdCzYZr1ez/uJ9tk1OgNw5njEITtwYQ==
X-Received: by 2002:a17:907:9802:b0:ab7:bcc0:9067 with SMTP id a640c23a62f3a-abb70dd72f8mr977008766b.40.1739778422264;
        Sun, 16 Feb 2025 23:47:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb7a04f8e6sm415180566b.177.2025.02.16.23.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:47:01 -0800 (PST)
Date: Mon, 17 Feb 2025 10:46:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <b5ea6709-929b-4b42-b73b-69c4e8594af1@stanley.mountain>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>
 <263574a4-4411-487b-bbb2-f3ff11daa19f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263574a4-4411-487b-bbb2-f3ff11daa19f@lunn.ch>

On Sun, Feb 16, 2025 at 05:08:23PM +0100, Andrew Lunn wrote:
>  * Returns negative errno, 0 if there was no change, and 1 in case of change
> 
> So there is the potential for the same issue with
> mdiobus_modify_changed(), phy_modify_changed(),
> phy_modify_mmd_changed(), phy_modify_paged_changed(). Hope this helps
> with testing.

Thanks, that's useful.

The first check would have caught all these, but the second one would
only have caught the first three.  The combined check will catch them
all.  :)

regards,
dan carpenter


