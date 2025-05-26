Return-Path: <netdev+bounces-193401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D50AC3D01
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3058174700
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C61EF09D;
	Mon, 26 May 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="A+peLNPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2C1DDC22
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252174; cv=none; b=Ve70YRKDQYwA5rHaxiBhmCUes1g/LWpW4ttdhKFtuNZZpEW6ElgYwEKnUa5gCIMhZNS8wAl4p3Y5JhRF0mrV65+fITHRMhJoGnCx3EXYWGY4LZiDzuonini8C3YSrwo644kBHydztwHoQFbNFJvXtToWLFaGIqRNSABUIpIN0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252174; c=relaxed/simple;
	bh=X9BRM0LvviL+8wFs3cVyB9IuGOiHLgzwjeAZMfe4f9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPECd/5au73ONSXeUDMbHdfO89LiZ5YrfqrHiNxa10gIzox5Jc8emOJfkBJpb/rXz5QnfUUqZNe4zXTDI/Wk9ROC+SmMjIjneiGa+ePjWFnFOsfn3X/PWiF3DVNB1syeGZCXheObKmGi15sY2hmpwodIpJeNS6O9aQjbB8PSdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=A+peLNPN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso15274755e9.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748252170; x=1748856970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9BRM0LvviL+8wFs3cVyB9IuGOiHLgzwjeAZMfe4f9o=;
        b=A+peLNPNPt8pr95XxQIWNeCpXcnUWJPuGKZUIV59fEHRoCRomTw0Kj5RtuYVZi+QGG
         U1Z1Z/h+R5+6mSNn7Bh9XMlMt64FSzdG0HBzyQB6SKxEZ4keHIxXrLBwCWEiScZ5ERPY
         5JR3qwlntGoCjO2IR2ACOSc8wTMlxgTnjHcL0bb1+SH2KvFWXzI9YowEvBgm7WzeLo/p
         axWJm9Jto+wbCpWA+iSaZD3NzsEk1NqGXsTOXMXlIXu0i2CLjC4fQOXh57G0WfwlJ7m0
         81mEVjAdSvebd0d8EQMj+kxwnuRxLiKP5ZoPqg0cCc2z2c6VdA6LOoIh7SXAmLGFMrHe
         oA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252170; x=1748856970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9BRM0LvviL+8wFs3cVyB9IuGOiHLgzwjeAZMfe4f9o=;
        b=YXZNXipc6/YTq8Rg6lVE2qWrG1NJYmki2F6ZK+QFuT2ccy+PUleRW/jMvVYFirJSDj
         7/ir6LDn8J2JS49Xz9MuchSRZW9SB+P3qF5jZKuvts+pPZ+DqkIR6uuHzhvIz1DqmQN7
         S+riubsuUTzgFWy9THfOO53W0IF/8a2/1oIbxeDOQyv0XPfl8ERM/kiygo9vdBy0YImZ
         MtizhouXzCnUbMFbg8Vu9KD9EhIi6U0cR/Z2ygfU5Z5RyLgmki938B5ShSN0xgJZNtXa
         P05mF9cFENmkQ6Q2lY4oEINm4mZY30Wbb0r3HZYDVpd+Jg4HdeAFxZefOYqjgpQQv1rt
         u1fA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsYrgrsgt7mw/V2RrK1v+/4sivkEy58fceKHlvxCt9mHbEoYwL3vU6t4B3zCPPWIa4ed/B8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vk/SUjWnurBQuNzjafE4TFO5cI0HRsl/8qUwZ863aP0GoevL
	PF5HxLqcLrWXVz71kFEAn6GBb3wYTVQR4C9yNHhwoYksjChQajRwM/KkcpuuiUICGrE=
X-Gm-Gg: ASbGncvC2nWXS2FfEDx3A3nWZhLinPjlpJPBd40Bw68+fCG0+E0O6MenAAE7n7YMTfS
	YcgnkuWaUTEjsBEI+NjiPiIM9wy/Fb2Wgkk75W+cXNncKdRXTsFpVhbtUdRxQ8JljOAfntY/yZy
	PwxXBYptTV3RRzThWc7NQxX+ndd1cd8b6t5/Tc2A6zZ75D3gTxzOacz4X5Tz/XUdFX7D5z1J50y
	OYsnh/0EoMkylMPpdXwz1x0OMnTNAtmafD0efc96VgnX+7X5XkWiKertWE4zSdcXgcvrLMBeNDS
	IFstWtx+K7wtJU1yaz9+LLGkJTcPB4A1IZ5+7pjCmMeZvtaNEAFym26zM7+fQSIlovOCKaQOB3E
	glBM=
X-Google-Smtp-Source: AGHT+IGDSx/uqIzjPbt/RIIG6sl81DhorcyGxspFB+QasTmVd+rJASc8gBkYSwK9BSg3kAtpjSzzEA==
X-Received: by 2002:a05:6000:2082:b0:3a3:ec58:ea98 with SMTP id ffacd0b85a97d-3a4cb45f1dbmr6352050f8f.22.1748252169629;
        Mon, 26 May 2025 02:36:09 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb8c92d9sm227117135e9.2.2025.05.26.02.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:36:09 -0700 (PDT)
Date: Mon, 26 May 2025 11:36:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, milena.olech@intel.com, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] dpll: add phase-offset-monitor feature
 to netlink spec
Message-ID: <2xdi4cs4iuvio4mm5qx3ybu2i7ceiwexjgj426uodujgza742y@t7cjhunlpbvd>
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
 <20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>

Fri, May 23, 2025 at 05:42:22PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Add enum dpll_feature_state for control over features.
>
>Add dpll device level attribute:
>DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
>feature. Attribute is present and shall return current state of a feature
>(enum dpll_feature_state), if the device driver provides such capability,
>otherwie attribute shall not be present.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

