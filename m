Return-Path: <netdev+bounces-89689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC98AB355
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 18:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B791F23DD1
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C61311A6;
	Fri, 19 Apr 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J0ainTWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45130130AD4
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544127; cv=none; b=PA7iwFj2VKXKWuTT6eg13P7sZ+/Yc+8xWjNvydSv4RMkkmdfyw3XRcTWyLdkN35mYBeX7tfG6TAx1orRRSgUrCyhPP5RVLTCYsglS1xeV5pvON+SBC8EU2Ad7mvy9JdGIaVegL/4g005+M4JqvPOLGvrXEa5LM24sSlm+zjK4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544127; c=relaxed/simple;
	bh=kFjC0EyEU8goxhPs4ZvLyMooLRqTVUkUxsZVxrjODSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx81iKNd9ks0gLePklZd1qQJR9BEeuxzCEZOv/5jR83ayhWiBozcRjfJRKxh0I+IyywCURsNDDCOpla4NnTOAkyViJ23ddenOpO9HuAjG12SBfKdI9UqgTw/E5EgujILuTNHExomo7UOVxDWCacIY6x5qZLFbdNkoZTRPqOLx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J0ainTWv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343f1957ffcso1300123f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1713544124; x=1714148924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayc7rPPL6VDbs1d1d5xDOC6Z959cODAbQX5VWu2SZms=;
        b=J0ainTWvnQPt2DkQD4wYGCCuZIf61DkNFuno3m52Sr5DU7tfl680bD54tmRRQTtTeV
         iT2mHoRCbqIM3Mv3VMCjU+n58zp6DiVP70wRt7dZsqDV2IabFtkMB47CFq+ISNwLGsde
         n7UefleUJ0qjaqowi2ZQCAKsHt51uxDO2liVhvXSzo2IzXl4g3s1e0XPDKjKsmGVbf6z
         2BZg1itcZpxTXxnPLxL9TfKfPJcFIKTZXGj83NGki+dsEF9MbWkj8/Rsb5hP5IONUfa1
         DOKQscF2+lTlQdaNerjrgC5SLoZ4EgSWcvyRnD2Xg1hGfUtsTa/1oQJA3rfQwwrRN1wm
         osHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544124; x=1714148924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayc7rPPL6VDbs1d1d5xDOC6Z959cODAbQX5VWu2SZms=;
        b=nz6jM3JMf9+FJ6SeLZbsgA8jf0BpjW6ChLJfeXPnEPsOU+7RZlbIdPwr2VZs4sMV4J
         YYK4uGs2KZDcxC9KDgBInZY7o0XzqjYaTZ06l1FHeB40R6WKMx6pQdbo+IVVs2fchNYY
         +ylyGyrT+IkHxW246as3aYhk15NqDAckXcrNPtKAt3OiIk8dEDHwCPq6Yp1V6gV3/IBo
         uuymrb1cQkPSae/C6UBLDOpPlSuzZnDlXRtoyxl9q0uETO6zryvpJgzPoBPXhDft3H2C
         aEcPDLqW8gWNPLWT/J0c02DaE83Ar4SeGOJBVlUhiTr3M77IG3nnDGw4m992S4XY1nvq
         7Rug==
X-Forwarded-Encrypted: i=1; AJvYcCWq4UuE7oFEQ8OZOY+kuefJ/aAeLl4fIQvR+5VwrAdktJ9Gm12y9jMG4roW7cWKHbcr3s0n9hxpoURf7svLe8dks/b7hwd1
X-Gm-Message-State: AOJu0Yx1ZTy24NCHSLwgR/3/nF6fpQF33WC6llssuUF/EbaSfxDs0yU5
	bmuC3VAwDJkqhZjohq5gVIVpalox/d9+NlXHUKd17MrEf7NlZTczKDEZmJquCDo=
X-Google-Smtp-Source: AGHT+IH0/rc2PYXVfFGOcbzjLiu3xDcIycm6QkYoKFaSt5eqn6rpWrmQQ9LYoCnNXILvwCR0UgP2Zg==
X-Received: by 2002:a5d:64ef:0:b0:34a:5d48:a708 with SMTP id g15-20020a5d64ef000000b0034a5d48a708mr2105406wri.0.1713544124488;
        Fri, 19 Apr 2024 09:28:44 -0700 (PDT)
Received: from C02Y543BJGH6.home ([2a09:bac5:37e4:ebe::178:121])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600002ca00b003497fba9b1dsm4920147wry.102.2024.04.19.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:28:44 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: dtatulea@nvidia.com
Cc: Anatoli.Chechelnickiy@m.interpipe.biz,
	davem@davemloft.net,
	edumazet@google.com,
	kernel-team@cloudflare.com,
	kuba@kernel.org,
	leon@kernel.org,
	netdev@vger.kernel.org,
	oxana@cloudflare.com,
	pabeni@redhat.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	shayd@nvidia.com
Subject: Re: mlx5 driver fails to detect NIC in 6.6.28
Date: Fri, 19 Apr 2024 17:28:27 +0100
Message-ID: <20240419162842.69433-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <5226cedc180a1126ac5cdb48ee9aa9ef8b594452.camel@nvidia.com>
References: <5226cedc180a1126ac5cdb48ee9aa9ef8b594452.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-04-19 at 14:06 +0000, Dragos Tatulea wrote:
> Was tipped by Shay that the missing commit from stable is 0553e753ea9e
> "net/mlx5: E-switch, store eswitch pointer before registering devlink_param".
> Tested on my side and it works.
>
> Oxana, would it be a tall ask to get this patch tested on your end as well
> before we ask for inclusion in 6.6.x stable?
>

Thanks for bisecting and finding the fix!

I'll give it a try. I'll get back to you, but probably already on Monday, end of 
the day today.   

