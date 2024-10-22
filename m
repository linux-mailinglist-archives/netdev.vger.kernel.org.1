Return-Path: <netdev+bounces-137944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE99AB39F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548C7282BD5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C81B5328;
	Tue, 22 Oct 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wI+P+inX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8919B5B4
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613685; cv=none; b=jebgsf5C7ZRrb4WwiQ885UlUACUfdUVOQPGQlh6w+pBXEz9C3ycHhbBP26rVGARze06cQeOEIN6ujH1Qh0zLYbwh0/7zqCE1UAn5Jw8XPvoGaoSrfbVau6gnYPtq3HT6GG+iLmYZ+uJ1dJs+V668AX1UOmw1kFA98VRk9LnB8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613685; c=relaxed/simple;
	bh=Biy0W40r0yZ+SiEc977rXw2zrXIwETwLaYdyg0cR6t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBXo7TqqHNlQ9yNh/RCVAvShvY3ByHScES94PT6O6QAtikE0bRxhRIBbvysEERKxYaTWlULU1qozoFsbfy3ORJyqJWQBS8pG7j571h4SwTuyCbEX7XN6pD/sL5JrUYNVgscDsc6vBODB2Osv+GZ88of4pAXt8vH1gMsPAb262/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wI+P+inX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea784aea63so2802247a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729613683; x=1730218483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYmxI8Ak++CDFmySdAcUepJ9hLaD0pysAIhoq2aBxKA=;
        b=wI+P+inXlYw7/YWhBnHhZGbVRPM54wHdfPLWDs/umJ6wcp8gwlvQ9lUnpnZZu6jH9c
         zXQ+tpqh/PbxkBGhcsIct//IhqzKmpLQ31fFp6r/QV/ysAut/JeAlIDvirDP5ID1jAQf
         lQroQ8dctdvAw2dVFE9zivyvc3uKQ7d8HEUV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613683; x=1730218483;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYmxI8Ak++CDFmySdAcUepJ9hLaD0pysAIhoq2aBxKA=;
        b=MQdjqLZV9m6J7ud+bU25j77oO5HQw1ztcoSaC/udtL9ym7bbC6njxA4Rt7UYU1BW3g
         /Sw0gWkpXJBjG+C4ptGo+maSnqiO8VsyGD4KEc1Qaz1JdwF+U6kwvnBUDNzmpa7dwB8A
         +hqjs5wQuX8QiXGtRuT3ArKZwNTJad5U/xug43HX3fiYmKZvBT9Npsmi6RbZrr89SFcR
         dEkd4F+kB6/6yJ8AWaWypy3vfcXq/q+9BobWSnUw9c4jcLkoe6xcBpC5hx2SYW+lNkpv
         Cm9wIpPqPuTJ/nxp3oC3gPOi8ZxIzO+le38d8mZSyxl5eVyIjOQAXSk0vjSMTv1yFL7v
         8Snw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Y68WMM8SnSizMpn4XkVfQvQGs4zV6UxAtcBl04MfxT8ZbPqFrrEc4TAnEsBDR2QK5tpzqVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHsIp3IbVVq+ROBOAuIsI/1IHAn9T2y1e7qx6yIlc46lNayOO
	ukoToSyuUf7UVtLG/HgcYAb5AI807A1eLST9mlCEFVc2BLJUJe0GMIG+mhH3A9GC6pW+4vn9nGL
	x
X-Google-Smtp-Source: AGHT+IHCZLZ+qUlRu5lQkyasznjkQGbd/C9Vwsoos6Uqsdh6w+NsOGf4aPX+YAfFQDnliNlJo7lZbQ==
X-Received: by 2002:a05:6a21:330b:b0:1d9:61:e783 with SMTP id adf61e73a8af0-1d92c5890f0mr19254462637.36.1729613683213;
        Tue, 22 Oct 2024 09:14:43 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eab57sm5077053b3a.176.2024.10.22.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:14:42 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:14:40 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Gilad Naaman <gnaaman@drivenets.com>
Subject: Re: [PATCH net-next] neighbour: use kvzalloc()/kvfree()
Message-ID: <ZxfPcKVpcwZET7vS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Gilad Naaman <gnaaman@drivenets.com>
References: <20241022150059.1345406-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022150059.1345406-1-edumazet@google.com>

On Tue, Oct 22, 2024 at 03:00:59PM +0000, Eric Dumazet wrote:
> mm layer is providing convenient functions, we do not have
> to work around old limitations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Gilad Naaman <gnaaman@drivenets.com>
> ---

Reviewed-by: Joe Damato <jdamato@fastly.com>

