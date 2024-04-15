Return-Path: <netdev+bounces-87999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61C8A52C2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEEA1C21939
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AF745C9;
	Mon, 15 Apr 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2f3tmhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC51BF2A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190278; cv=none; b=JbuPiduG/LPuRuRAsBU+uKxjalpyAWyDA4yeqixBbDFYfnGeMGIGDHkPA1+fk0vKmFwXwBnn2kWdwrDm/lc+1yBNZ804zlZHcKf6Z3t5cB/SO8AmveIJi3JdXJqfHYpVQQ8ZXxvlHCuohP+GyuSJIFz0OJI3yFTvNAd7J4SDxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190278; c=relaxed/simple;
	bh=ZYmuPkp6Zy0m4BU6Je9zQlCOlu05QFX3vtW9Wo0rFSg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TGH/t1hGKiARU/68NElUWzmVMvxWA0TFNXn/13h2s2o/mt74bg8bgSsPZWuvrm1O5RJhtlRp6NXqfRJS+stxEQGdOQTRLoZLuRG4Yi5IlGrANI0Kadaru3PfXHNi1DbITgm1VL/SYXRS63eifhBHBySo2UT9LkDOcYYog1wV8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2f3tmhe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43716c1616dso3018381cf.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713190276; x=1713795076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTuUJJLyJmI6wQr0PRrFF1GBiPrmZSNF/sqobboJF9U=;
        b=L2f3tmhe8qURQ+63IWcWu7ZhqCRC7YC1+qYoR1a4p5VYxfcn0ObuFGG4uZIOx18Ozx
         8kPr6UCK0jta2ZB2xMQ/cN9hmrVd6nXhKQnddStTqtakA221ivaEbR3pdfqwhCcPVpXQ
         iqitGUItL7I4dS2OFbzzOWdbhX2TUXjf4sPPV5kSsdGnikHYDfqTo6UgZXIPwMGe+xp+
         lqsBLrHRIduDM+ZzHgzl7THkrSkwJSrPiYpKCzVP89xUKAMmQJl6A/pftk5MjeNZhX5j
         X3syTFcVIVNqMl1/5tDNFFdt5d1LWesCKeiDoke38LQ4NnnAe5Fw34E5oAbr+mNcNcT7
         Z8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190276; x=1713795076;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hTuUJJLyJmI6wQr0PRrFF1GBiPrmZSNF/sqobboJF9U=;
        b=dx6+w/ZvT/XCHX25dBQ9sEBox4c2Y3KgyE+KxivhE+u2Orw6UPYlk1dXadNI/4qrLP
         bUFG2P2x72WZyRtX3PZQYm0y3zpSaLWYbaaixXIiLzTkqRMjqNF8Bbu8p8bVHvBzp8ju
         CNmRx5NxDwKtG/pi/NSr6f5I2mhh6qI8Jc/2xk6BLIn9Igerxcn7Q5s+7eBJk2JEFWjx
         T7lVONURQrWp9x5QKXPI7g0mXU+qZ7y9Z3RJvJ1MugC0lOIV1CuJcQl7vvu07kbGbcqd
         RomVeoBs/avtWrxJO7TkZteDsADEgHAqTR+HhNGH0202QpmWiBPH1oEWnurlwvIbasM5
         kGQw==
X-Gm-Message-State: AOJu0Yyhav0towIfyCjUdopNdqqKPzYK0E4Lr8BhBYa9fCc8rv1oxO3s
	nNAHyM85CGKEgreM3zn8FAAV4H3r4AK/djdUFKuUhKPSx8Q8N4RfkcISIw==
X-Google-Smtp-Source: AGHT+IGVRx7xZs02G270APL1dALr8pk9kgg5nrPjC3FJQKvHITQPGkmBTttlQ6Cy9J6pLLF9dODfNQ==
X-Received: by 2002:ac8:7dc4:0:b0:436:96c0:5af8 with SMTP id c4-20020ac87dc4000000b0043696c05af8mr10205470qte.0.1713190276366;
        Mon, 15 Apr 2024 07:11:16 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d19-20020ac86693000000b00434f6c1458bsm6032898qtp.17.2024.04.15.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:11:15 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:11:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yick Xie <yick.xie@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net
Message-ID: <661d3583a289e_c0c8294c1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240414195213.106209-1-yick.xie@gmail.com>
References: <20240414195213.106209-1-yick.xie@gmail.com>
Subject: Re: [PATCH net] udp: don't be set unconnected if only UDP cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yick Xie wrote:
> If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> "connected" should not be set to 0. Otherwise it stops
> the connected socket from using the cached route.
> 
> Signed-off-by: Yick Xie <yick.xie@gmail.com>

This either needs to target net-next, or have

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")

I think it can be argued either way. This situation existed from the
start, and is true for other cmsg that don't affect routing as well.

If the impact of the route lookup is significant, it couls be argued
to be a performance bug.

I steer towards net-next. In which case it would be nice to also
move the ipc.opt branch and perhaps even exclude other common cmsgs,
such as SCM_TXTIME and SCM_TIMESTAMPING.

