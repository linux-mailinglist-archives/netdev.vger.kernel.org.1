Return-Path: <netdev+bounces-201032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B59AE7E7F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EDE3A63BE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050D29ACC5;
	Wed, 25 Jun 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOfEkyU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8F29A326
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845967; cv=none; b=XxlceWM5MwRmc2YjUr8DbsNuTg4MM42BLKL5+7JMBUgb5s+fCD6qey8a7GQDRjVD+80MdAD31SiiNz38wnVFO27f0gB3qvzb+D+053ZV1dlN7zaFMN4VmAUb8x9hUsPbWPZlJhGnE8ZEx1ljJGEpQF5xAiWHM0WovP4xSMpdQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845967; c=relaxed/simple;
	bh=P3H8FAT4nCoYswCsQkcaoGIRgNbh8Q3j05rYKjrfpEo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=s0+3XYRQle49yNTbLnemYL1G5duH1M817S6HBpCE9OrI0h25snOVQEebxgur5DOEPEnI6SYcl9HcUikY45Cuz2IbrwH9VK2LuOYlRFsOo2kQ0FIfD2aPlOVmJJO/x8Obb5wBZIutMajApEdodnKFLZiRtKOHgaqg3t1z40VfkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOfEkyU9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso916673f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845965; x=1751450765; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3H8FAT4nCoYswCsQkcaoGIRgNbh8Q3j05rYKjrfpEo=;
        b=HOfEkyU9Nj73f5F5ICAoriZWDc5bHArDB5AE5c6jiCmarj9xG3n3C6hU2MdN/ifH4A
         EscGoZW2aeCPCIpnwBpmN57MnKwOdRPaXs6Tbca0yZtHS1ONTaqF0Sk1cqU/U1QFkew3
         giJElG1nwydMMirHEtJLhFstDeSA9ITndwOXYjV0gVDIQNQUSse2JoVBgsl1PilDxHvH
         +xalVIIijRlaRwh84CwHFWRMs899boLcg7gEfQiEqSuRa199JLS6EycCoo0StjlbPpSB
         cGqhEHdUAcx05e7Hh2oWvMtv8SMb6cM6+YSppZjSritJE9nWOSt0rmO5j1Eg8VMbaQVg
         eYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845965; x=1751450765;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3H8FAT4nCoYswCsQkcaoGIRgNbh8Q3j05rYKjrfpEo=;
        b=O+Le3qWB6eqHhlWRUN06v9dOqiAB9K4/gvRdbRYfoLBNmXCK6JWtAQuXOOgiY6RzZt
         j8lRBhG0Oymg882Ha1CH8kq+lvigq7EAXZM71RFud51RPvQhrJT7KMysMPzUlS04hGMs
         JDuWNWfWR38J9BoPw36mhdEB9MCwOKq28cGm6C9MWe+au4wyShkEhLsJrEK7ZRUfg3f3
         gSWxMe32Un4Bj79OgPTcQ2HIT1zPnmP6faOn+TxXj9TY0ErZdnfjb/woWDH7nWm0APH+
         6tOSa+mmecGhzO7HU5vRJOAMkjYvPKuOPCjfxQjsM0BdFlcmiiyxwQO3JB+m1vAqbNFx
         CBeg==
X-Forwarded-Encrypted: i=1; AJvYcCWY7ANyUoHfe51rtxwmcig0YSHGWBYWpj283geFfK7tGkzkRxYcI8v85axBquezE6spcAMmfuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ucZEMF2+1K1HZCoh39GFDFrQJVosg4RBmTE0OJWVJtSbVqAh
	XhuO8MoSBZXtnK7va/TLe6queDB+TV8N4fE4SyTWvcH6aEoL1cH6b9u27UJ1Pg==
X-Gm-Gg: ASbGncucqDhgNPPfZ4ij6nrQlM57EDg2NxLjN1+aB/7M7ghlZfKYi3iYgtZKTunDWHD
	anSjl6ysuH/lR3bd9MyIfl3g1GyS4eFOTvBbrdCbuMH3gz2kd1goYAUngZ0OnuaOPdEXUYtv6fb
	Ugp9p6b2CKvNkQFKWJDmW2QB6gs6w8qLrKC5LEqF4ytq0G4pPp1HDlELXKf/xjn46ud3zU/FyVh
	+j+Y8qyyIEypv2Po4xfSMW/HPAtmLPjl2onSnpIue27ks5VRvXOFi2n/WuuNozdzECtrNBZPfGT
	akOIIr18o4oZ+XDtY0gR6QsWAnnQgLu81C3F0AXyoGoXo4dO1bSO1+8AAbnSZAEus1P+s4G4wGI
	=
X-Google-Smtp-Source: AGHT+IGrT7aoDSHTP1BSrV+nEkysUbLzw6uEa0oN3LUI7vHVMF/9fX/vscRYLQx9bJLOyvzaRgw20A==
X-Received: by 2002:a05:6000:2913:b0:3a3:652d:1638 with SMTP id ffacd0b85a97d-3a6ed66ea6emr1803322f8f.48.1750845964540;
        Wed, 25 Jun 2025 03:06:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382359599sm15308805e9.24.2025.06.25.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  chuck.lever@oracle.com,  jlayton@kernel.org,  lorenzo@kernel.org
Subject: Re: [PATCH net 01/10] netlink: specs: nfsd: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-2-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:49:26 +0100
Message-ID: <m2o6uccfrt.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 13727f85b49b ("NFSD: introduce netlink stubs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

