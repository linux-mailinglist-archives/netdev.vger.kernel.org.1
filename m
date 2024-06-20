Return-Path: <netdev+bounces-105412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C420A911021
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1D91C253CD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71E1CE0A3;
	Thu, 20 Jun 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGTitOBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C81CE090
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906315; cv=none; b=MpQhL+tJC+XQ+lP2NlVqmkDm7IzgMca/dq5H6qvZ7xcB5waJcxIaaOK2w1g6tBNTojx5zcbWeb56nMoJllxNOSiDKPJHP6wCgSn4v9bjZ60YYFeu2iZ/4WfKC0QiwWvw0nz4JdZSQC+vjtJktSB13Iww5K1vBpMYfoLDYglC3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906315; c=relaxed/simple;
	bh=S1KcLm7Zv13q0r+n0Ksp7Y2uOshbKfSOmBDJamvWTqM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Fx3pWAzbwIIhoHfSkAcImhIzELOCCAwyAZzbbrjDCIHhQAMyYLT3rhUDq8N/Vb4i82HKfpHD2avGGxCgY2XXETcX2JOFmnCEBhgj1ThdO+lvR038ovgZBxZMj6ZX1VVWZppkQqvhKRWtGgy1acDyeXwgL0oTS23IRrQGb0krdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGTitOBr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b97539a4a5so619818eaf.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906313; x=1719511113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qt+TjDJ2lfVF6UvdmPORTcwXh0Z8eZesPuok0k1krw=;
        b=QGTitOBrmWlqQfEt1z/tWRIP9TnMcb4ibHZcy5HCE5g/2KPXRN630dtPZFWdjglydQ
         3JIRkOWIdqyTu+qARJcTlKFEcvkjIk+hXm6R/+LAPwEtybGWE73X3td5O1yrNG8rXaiy
         W695QMpf0iFb47jw0pvz+Ynb9PD3uDsrJWP967Cc0V2CsxEFkMtfUagPIle75YkmdNB+
         ep6hIGMNf3ee8J3ZUlnPGW26jcBlpZiQVNg0zhZunxXG09krOMXb59OS/xaaYsx7aUsq
         HnO2tOtIDpTtk5s8rnmg6I3KpGX8EGdALlQQmOjwyWJQWLbHbBWUiBdDTiRn247/jA98
         JoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906313; x=1719511113;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Qt+TjDJ2lfVF6UvdmPORTcwXh0Z8eZesPuok0k1krw=;
        b=AWG+HXtWrTESLcO2h8qXT0JQ0Yw5q6ZGUjz22WPSMSVqEWY3wFPTvJ8IRPDO948f3a
         FBXZ+HEI6/AlUQ2j+Lmu/GKeN6sGwmvs/rKC5TyXDqwQRcReuoAEwYoUeShpt+mt+GVL
         3VS73vPqsu2dlk14GV79wEATDsnoZnHqcKlFNqOOTxk+lFXrlZgtGL9Psd87YipR5ABD
         r8rZceVqaCOrw0LUfVEe5zYV5qRLn5aROQHcdKV8GfxVqu2aEMjsD9cJ4yGmT1Uhe1P3
         tk5gbghNQ1gMvcWJPVuDAEvThZERhRolG6ReeGoh+SizA3nQ8tlNWzjR7Ha3mkUe/2dI
         Jrzw==
X-Forwarded-Encrypted: i=1; AJvYcCXNlb7R3Xoa34Oxott+7c61i6o/9StjnRF0T7nmjE9+e4uu8HbiJPERmTh/jsWw81YHYhVRMR2aVLrRJzmTS8oga4PLMISN
X-Gm-Message-State: AOJu0YwN3wDS9QJE/bK3legzB+3lJt/x1TpKR8vrFU/JKW6GdV5EVxPV
	iJM+N8f9eJDMZFMM+30sQYqVWmZGlpSnIUIgetzDvJ0QzhR2BM4Y
X-Google-Smtp-Source: AGHT+IFP+lNQtz4n8GymDb2cDFZREJxOf3Mfg6Hm6K/AZ6A9vU4yBDrLY89JNgs1la7y3ffGDH3T5Q==
X-Received: by 2002:a05:6358:61cc:b0:1a1:fa43:1cd0 with SMTP id e5c5f4694b2df-1a1fd6828cfmr720725155d.29.1718906312743;
        Thu, 20 Jun 2024 10:58:32 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798bb9b7d87sm707864685a.24.2024.06.20.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:32 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:58:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Shailend Chand <shailend@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66746dc815aa6_2bed872947b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
References: <20240620114711.777046-1-edumazet@google.com>
Subject: Re: [PATCH net-next 0/6] net: ethtool: reduce RTNL pressure in
 dev_ethtool()
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
> This series is inspired by Jakub feedback for one gve patch :
> 
> https://lore.kernel.org/lkml/20240614192721.02700256@kernel.org/
> 
> Refactor dev_ethtool() and start to implement parallel operations.
> 
> Eric Dumazet (6):
>   net: ethtool: grab a netdev reference in dev_ethtool()
>   net: ethtool: add dev_ethtool_cap_check()
>   net: ethtool: perform pm duties outside of rtnl lock
>   net: ethtool: call ethtool_get_one_feature() without RTNL
>   net: ethtool: implement lockless ETHTOOL_GFLAGS
>   net: ethtool: add the ability to run ethtool_[gs]et_rxnfc() without
>     RTNL
> 
>  include/linux/ethtool.h |   2 +
>  net/core/dev.c          |  10 +--
>  net/ethtool/ioctl.c     | 159 ++++++++++++++++++++++++----------------
>  3 files changed, 101 insertions(+), 70 deletions(-)

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Eric!

One small comment in the ethtool_ops field, but not important.

