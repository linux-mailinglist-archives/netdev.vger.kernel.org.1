Return-Path: <netdev+bounces-224071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4096B805DD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF22A461DCE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4B333AB6;
	Wed, 17 Sep 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByP9AcqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0331F9F70
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121439; cv=none; b=uPRd3xNlX/1/vkw/XuGDuAEsBvpZOAEaar4pD+E3j7QKEeVXMo8eenF+87DHRzCYfyZJ989fKCFwAZGQ7+XhZ734nwcbsH+LEHb1/ItjjrZSdnYGCjc6t4kag6LxteBBvmrxAeoq2PEBkgHQFaL0MUXH38FsgB0mPVg3B0NlpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121439; c=relaxed/simple;
	bh=MALzW0zDbfClRbGx2CTwVRhi1zlNbjzHC3926pkWEEQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EyypdijBA+yDiCl5ISh3O1A5n5EpLyJjhFvjctT6K8vik0VrM2jrQZOFk4JL1+grawzQenzcWtAjEEZum0Uon3GO0Ux4tZfXJd17YEBLVPTdza9B3dc6cGA/U1QHwyuSIpCEDYBerJmlZ6za1iRvfuaB0sE6HS4TpHZlURrVK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByP9AcqU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b79773a389so39215161cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121437; x=1758726237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBnbMV8ce9LVl9kK9MLhKc2hPd8QzeMgYISaqbaleCg=;
        b=ByP9AcqUDAA68oq6QygwJIgnjW/e9jYQTKHa86HlwyBnIn4XrkJktTei5rjpIX0bxL
         V6r1uL36li+5pkSK27m/oo1YUi8/wBsypITaJvb1U8Gr5wlDcvcr7kJwm9VrU0igGIa0
         /WMA+HwN9ryGD8LGiFXNi7U27I1tuJDOswgrX7TBHh0dmRfV3HSCeMyeMG8Sb8vToSpO
         9TvjdHS6Z1xNla1ek27fvZmkTzbuSvK6xAdH3E15nuTEjk+N2Uf9l20fW1ZbZwivSPUL
         hXVdw3a7oBPNxNj3AB5ALpG/CWE1AEIQ1GVq7bv1KeGpApJMwBkntNhbNSgQDRlXJhuO
         If2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121437; x=1758726237;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBnbMV8ce9LVl9kK9MLhKc2hPd8QzeMgYISaqbaleCg=;
        b=hsCJkRqKzcrnCGHsBIm0/eYfZmla5ComTAUzqv4nPflNyt9bQCN7SFOCSfsm4twdaT
         7iwxiBdNJIvfylZF8wyVGzcPkIPW1Im0NWLLSXtdz7uh8japxLTtQtep/neN0DD9M6Mc
         M/qNVPRgXDL95K/kcPMzKi15y4aIxgF6cqxwD3G2F+cX+M60pgukbXc15Fpr7YP+fvoZ
         fKZ90X2I0vQVxuc+JTp3LrLi0Hxjl4cpYxDOpB8NvKdNcohcMSVLVKrBLKqEDmPFY4Ma
         vYKEbWRB7xmsS5mU9q8IcUnqpDSSRxw2AOXqBfuulZL8R1N89sO43NkdnhaP155/TU8k
         QdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41nsTOsaR9RMlRK6+pB+r+U5Xpxvoi0/Re9fKv+hXYr0TKddXDETZLGf4sHMundLcnkRQDPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR230sYXnubwBEEgwgT47/bcaqDepF8MoiRxlO9r2ny9VIfZes
	9u/RPFTGA42ELGwTkaD4WZBDYUCOb4gOSZST+UPl/jwkhPYApF5bfIkS
X-Gm-Gg: ASbGncuXII1FQzBLVGgJ1EB7NMC4cE+eptkII2URVOJE+y5Hkcs4c9eRHkgxSjt62R7
	5edYY/kYGM1sxs/E3+OkYp8/SxqZqpuwo26bS0bfaDug0Yi3IcheTbWntqJdOJSXCF6rP52zw2S
	Jitr2wM5bYRY93mOHytomFf6QDdh0pCXarXmB4y2g99hyZqAroByCpRM31ZD8DzTcpUg7VxLS/x
	v8vZkEQA0TyqBNfhxMObjX91SU9B8Y76hHg/jnhx9RG76eGtOzNblhORvi2orHOxCa0CpN6CFQz
	tdybGky6ZCxVJAKPr5kUdIciwFyXyr6bTyOmad6EXjRmphPGdSP3n1C0jqJY5fTvH4YcQRXH9fP
	VPrYJ53g9ZVEVgarIx5N8d9/ovA/xfLGznWrOxQBG8j4XbLIwOadrBFMxYJ+qOrV0Y/8/8zhy5R
	RnpMMV6UmdEB+G
X-Google-Smtp-Source: AGHT+IFN/LdmTceeIwa42QTXfRXeHuG0Ui7SZMhzDGql3Bn5h0r8qGqVJ2qim/xfj+KR0dqFekkbBw==
X-Received: by 2002:a05:622a:58e:b0:4b2:9620:33b4 with SMTP id d75a77b69052e-4ba65bc22a3mr31669471cf.13.1758121436736;
        Wed, 17 Sep 2025 08:03:56 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4bb18769b2fsm7345041cf.10.2025.09.17.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:03:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:03:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.1c9ea4473a835@gmail.com>
In-Reply-To: <20250916160951.541279-11-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-11-edumazet@google.com>
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Move skb freeing from udp recvmsg() path to the cpu
> which allocated/received it, as TCP did in linux-5.17.
> 
> This increases max thoughput by 20% to 30%, depending
> on number of BH producers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Willem de Bruijn <willemb@google.com>

LGTM. But I'm not the most familiar with this deferred free path and
its conditions.

