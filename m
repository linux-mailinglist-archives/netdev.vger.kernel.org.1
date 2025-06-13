Return-Path: <netdev+bounces-197474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3CAD8BCE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF217A451
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24422DA0C;
	Fri, 13 Jun 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="WCqkqO/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B72275AF7
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816690; cv=none; b=iDV1nzXZ0NbnjXb3X6NHfF0yAvbXAs1MXODz944yK7uZDG4tIj9CxLjWO5IFdwo3oOu0tWmZtRTLoM2L0Bw1sngZL5Eu2UFC89X2LUcJpQgI7EthbWmek13RHlxk/0oOwKXSPEnQx9sQVPHsS6fpNIWHJmoDBw2b0JukpgNuDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816690; c=relaxed/simple;
	bh=IfISvLuMcxjZrVnRK88ix7qpKs0G89Wpm0+eZ0yuCZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJ3diTQiOS8I7sDbBohvH1Gteo4pI+zCuDx/TMAmQrYMFgMLAkBb3Pjingq2V8JFMr82vrVJAHVWE9N2v164yvbOwlp3qRzI1ovHSSxTfmPS3c5UgbwkmD0q3ob8n2WiYdSnnX3yaSh3Q2PYgIiczYT64677dfiWZC8tCHggT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=WCqkqO/l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so26499975e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749816687; x=1750421487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X123xpbb/jeKY4R9e6FB1cA1Gkq5lhAcYgbmcRglrII=;
        b=WCqkqO/lC9CJNiunU02139HhCJQJbw5s01U8LvTfJQIBBFa4O8Mw3Y3G74wI3texws
         mCS/oa0F7MnhwT+9gqXiquWyZ04e5jadEBcWlelW40h9SEm8X7H7BoGQ/8bM8UxjYoJQ
         vrYMXNwAldBf82N3SVO0J91UtHZRvX5bT3etvljh2SHO/wClTb2Cw6/YRPoRDEStqHqL
         MEoUDhcn7cvDT52n8XZ9kxpS6oc84fCNbAVx1Ves4/ZuAIgewk1pFft35YVtJIcX0zUI
         8rhsSLj1QuIbUEO56uDhFrToUiJtFWY1ScyvOSPq1NmJ0YrbHKULqqduC6vSZRoiC4U8
         8l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749816687; x=1750421487;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X123xpbb/jeKY4R9e6FB1cA1Gkq5lhAcYgbmcRglrII=;
        b=VdmQ2y0d24zpwOg5HnZeaTnBClCcNLrFx+Ws5d1jaAQKXXcreaY0cFHtB+06gMDnjK
         TQZnshoRyDqcvVl4+uYnJaWoB6tPV9N7YUekwfrEzrH9lTPDm6ZhXbsFiIxkNqYt9Q2/
         JnrjyQlSYBPplSj7Q6PAH+Zd2asXchJkWMyyZYT5TGdp9nwl3m4Kir3zACKei5cHp/Hm
         d7My9lOdZh56YLj/0Bkw+u/okz8//Cfgl1EIm3/0Yt1HbS8p1gd4Yd+qdsDmWkruOXmO
         46g/nwxvHxvptCFdxqyvBOCulGRJ6KSRO3b/i8zjksQpGMsBL64UQKQjD38pR93GVaHK
         D5sA==
X-Forwarded-Encrypted: i=1; AJvYcCWdrKhZblRG0/M7Bpd252KynN3bVAwkQ5NBFEfKMBdo1T1VzUHKw0W3yuV3JDueTWP8+CissTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ovMREssCwAg3t+qMzbwdlQmcIsOKRvADqRf37kC24c5wA8Jv
	lw2TPBuoXJjRE47u4x/NkPHoQ8Tpf+LqtM9CtcjVYu4+4DJMo8qCZEQMKExQF985jEbHW8kYCZh
	O+biBA6k=
X-Gm-Gg: ASbGncuAcBWMscHBAJg2J9lAAqY+NRX8CACT1Vn30w70rarurXna2i/7gkXOpD77COL
	PwAUzsNUQxG6tHOegY76LLdSX0dQi7SWFguu/4muz95JGsrusbsH0mmmlJwFrQ5/2UgWuhEqpdr
	NZu+l9wjIOGJuSmuzM5rGcWMJLyyot9IlwWlX9cA2DPy9rShLs3fNK/9szUOr9sUj5cMAnzYUx2
	uCl7rZHMhMnTSejxhYgkOQHvBq3ydxO6St6u2lKD6AuFLsot6xY0eLHGhtmvQZbcKCj0DhTNSEy
	FCPjP5Ucxs4b4b67lqddgWNPtq5CjLopOInJS/72rplRCuQiPxP9RN/qyrziSi0bi2SEIMATMzu
	AcPokDAs=
X-Google-Smtp-Source: AGHT+IGT6muk7KulGb8uoUJI0MLmt/NFsIJLiIY9WjvVeHJ+eUp+xu9OTUUSggvF1QY1GYh8bwc2Pg==
X-Received: by 2002:a05:600c:3b98:b0:450:30e4:bdf6 with SMTP id 5b1f17b1804b1-45334b19559mr25871965e9.19.1749816686825;
        Fri, 13 Jun 2025 05:11:26 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e24420csm49767325e9.20.2025.06.13.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:11:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:11:23 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH net-next 1/7] eth: igb: migrate to new RXFH callbacks
Message-ID: <aEwVa9s_je4AKMEc@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com
References: <20250613010111.3548291-1-kuba@kernel.org>
 <20250613010111.3548291-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613010111.3548291-2-kuba@kernel.org>

On Thu, Jun 12, 2025 at 06:01:05PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

