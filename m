Return-Path: <netdev+bounces-120610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF5959F35
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD14284979
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405861AF4EC;
	Wed, 21 Aug 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGtYWtjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB793189908
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248959; cv=none; b=mGcFawmbPRjrMOmuVKGEn8F/xGb595hfgpLRrI25W52RQZ0tyxb5CfEiZEdQAOikEBgPL6UhmJcsYsr0Py4t2syX7Pn7/Mz+BQYDOgFrUUidAiFGIh2WNtI8cQ0v7JTqHQqE+D3k+WYsztJawBNHtrIoa4CbSEWYTPKeJmN91bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248959; c=relaxed/simple;
	bh=UKf7Jhu2byJR9AL1JN/bWPLrdGcmsEMdoG3m3wq2Kn0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AEcbU/c/6NPSqKQggtQNLMBYQBEegVkBeV4rDCEMzkAKT+KRdlcxxvB5wZ/d+PgmElTtW8n4DqiPqMZ32Cfpc/EugtPlRXjWFoOGOU2DQXpotsT5vEuFu2BdeWikGR/YPdRcSdewcPXhXq53/gTyG+YUIhfGacfehOMzR29Lr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGtYWtjv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-454b3d8999aso26566431cf.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724248956; x=1724853756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYs3gjeYU0lNK4AsenjzCv18j/RtJ2oMNlFG+4MyW7o=;
        b=fGtYWtjvD7sZG+hVc2oNGaVTSO5uSTmH7SAYR+5Wmp94RRM2Rl00wGhTRsg5XiqFrn
         yu0BPiBalHO3sKnarVtkPx6PYg5Aa+5QtJ8sslfcnxuEK9sz4bNHSTLqoIYXyuKkSjoi
         avfPnyVCDkcxz1HdT30Cw9ypjPcgpIc/ePmBLNnVBQj0TnC3NmtFgYXJ+eMyGXjhjrLu
         2dA6rZXNjG0nrP3HnS1NKaRCVWeRjQA9O5zxCcSX7rPgwJQkzikpMJ6Kxm0YzenKMzZj
         /Z68DuFlTjouLUxMU4+nMeRJTuXJpLepuWR7JmQHH1yjfFAsbrJjedivvrxO6ANarwI+
         HzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248956; x=1724853756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYs3gjeYU0lNK4AsenjzCv18j/RtJ2oMNlFG+4MyW7o=;
        b=XUkadbjTLU8zUI1FokQyEEUJWBT6LxmkQ61SoOJ9r3oeXIDQob+eVZfkpZagBi+Z2/
         Oj3npnxXJ/TJ17xU1v2/dt2/Ehpr9LY9szFAwmD1GFzO6MvIYBrkiA3VG0K8uS66Dcc8
         sf79Grv2pumDzGvKmkfuf56JBmyYdDl5yHM07VbRLhH6VTmTgK6H6fDO3kdGrm93tVDw
         Y2WkzUJvqFFOKF7xId9w96XG2YiWVmo6eHJ8nUF84csOqkvNr5W4bSsyX98xm6iVDDoK
         whg0fdZDABzBzANrHe4bn+zCU/BgIXvWmKO2sTTJ8a18+IQe7esdYReH4UUKU+AzEFX4
         DwaA==
X-Forwarded-Encrypted: i=1; AJvYcCVMXJKzYJ05Z7W7oz7XHb4aaqiycWF47kEIP6z2up4MEm37WrEK1EKNnLPkJeiYh13jdY99XJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzq0VNQGAl0zem+vLZlqEukXim3Rrv0dFZbNGm/vSa4dVdgb5/
	vt9c36zoOHUBg3dsOiY61ltATFSjyf2Tftdc3YQrnbVzigCb0pnZ
X-Google-Smtp-Source: AGHT+IFOJSh8L3KdEjrn606guiN4WeKgf0BpKZ3abL5zdrxNRnz6QcKLGb4SvDQfBKHUJTHZnlsbKw==
X-Received: by 2002:a05:622a:1e8d:b0:453:75c0:d169 with SMTP id d75a77b69052e-454f21e5365mr34668221cf.19.1724248956282;
        Wed, 21 Aug 2024 07:02:36 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd7a4esm59461291cf.19.2024.08.21.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:02:35 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:02:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, 
 Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, 
 Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, 
 netdev@vger.kernel.org
Message-ID: <66c5f37ad591a_da1e7294b8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240821-net-mnt-v2-2-59a5af38e69d@kernel.org>
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
 <20240821-net-mnt-v2-2-59a5af38e69d@kernel.org>
Subject: Re: [PATCH net v2 2/5] MAINTAINERS: Add net_tstamp.h to SOCKET
 TIMESTAMPING section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Horman wrote:
> This is part of an effort to assign a section in MAINTAINERS to header
> files that relate to Networking. In this case the files with "net" in
> their name.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

