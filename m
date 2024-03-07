Return-Path: <netdev+bounces-78305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B015874A6E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760011F23D30
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5D839EF;
	Thu,  7 Mar 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1V2eIqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7C82D9D
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802742; cv=none; b=agB9SJPZR7HVJQNumOrF0TT6vA3gD8TuGqzl6iYRHZzA6ovYffdHpBVZVL1PzRL19kj2H3sxCrSH3Z8FInBPZbC0aE9z+nsZb4er9yBecDCTz/8Z234OHtPftOccZ5r/VJU7+ZxRPnzsgQR9T7tKPCyc8ckgGH02NyxdBAHEL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802742; c=relaxed/simple;
	bh=+OIwu06BbiNbpw4uU5RjAaUzsVWYfdlOuFrZhGTSbkQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HpGjMhZIBy2f8fDlwOsC20i57fWZGGSFbmnnLdgwJgtv/b7VhFyd90guGaTPjozlEYlOj8qM82r+AMLx9uAc3GONrgVqfr+GoEG/sC5TyiB6uu+xTRKDAkK76QxLhSnOIygNtWeBhLOqs/xlxj7cqzm7esNyI0SElOQEd3qYxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1V2eIqn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e4c676f0aso323371f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802739; x=1710407539; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1YNVZZvlcDiSJ6ZFESoTho4gtxMc5dDDEq676r8Tig=;
        b=H1V2eIqnL2KaWuSwb3lu6uGhjfRAlLxEHRGnfsxmTEmh8lKaFLdWMDQt3bwoHTFmrd
         XhuQpz1YVCUogef4FVTpcsN6sTszOFYxtZjdbmev2WYlC2UluY6uLCx1Fsbc0p5lcs6c
         mYPVGm7BFUXHLxRLht0iDgav3WpFUba9GiNNQEvn96yISVAusVnWuHzzu8jwsaoAm5LS
         wCdoHO//PGY0e3jc8soyISaf8+jAxB64dTPR24Pat/iYN6HDiVym79IT8dsPs4lb0rU9
         fr6HmGYKz8EQMI4xysbJRX8s6nPqYTV5JfSFjz83EcujuOqkzYx+XHFbRJDwrnLFgpwI
         X3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802739; x=1710407539;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1YNVZZvlcDiSJ6ZFESoTho4gtxMc5dDDEq676r8Tig=;
        b=tBQq302i2RE2BZME2JPvnVuyXwBd5Em+a7PSqQGmZoKZbIQDiMFOHIZtyfIPKMGI8v
         6AMt17EjCPTPeorLGSAbVxR+UZN16HP2PLS6ZoP4bhPQqIABFM8I6l8UdI4gBOyKNRK8
         O3JQWUzOzneOQcC6r9wda6JHkBRaIqIhkQYvwnBEmCt367++2CKlYXoxjQtwjxSh3BTY
         7FsbmUFXmo5439IXvM+s3nYPB29WDOXovvuiGz3s1sPpv3gCHZWVove/CZAqRbAvNGRH
         eTn4nX6qLtTEX0v1QbAk89WYiENaeO9KqfsoA6wuzrH+S/uxuKMetGLQ4dfL+OYdf9pI
         PlMA==
X-Gm-Message-State: AOJu0YyWZ56kGhni0XuzWvSiE/LHuiNOnbifyGEI83ASvPBLh07Usxkd
	31x8MteT8V7Zyh4DWvQ5x4NgUslIrQLksSGPOOTigRea+vHqwFSJ
X-Google-Smtp-Source: AGHT+IGgRNTfP85K9BqyoYIZ/SomWGZIJYkhq7XFRv2Us7I9JNdGsHyiHQCkqm1cLYc+/BWBHJuEgg==
X-Received: by 2002:adf:e54b:0:b0:33d:73de:c1a0 with SMTP id z11-20020adfe54b000000b0033d73dec1a0mr11002888wrm.18.1709802739352;
        Thu, 07 Mar 2024 01:12:19 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id m19-20020a056000181300b0033d3b8820f8sm19653502wrh.109.2024.03.07.01.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:12:18 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jacob
 Keller <jacob.e.keller@intel.com>,  Jiri Pirko <jiri@resnulli.us>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 5/6] doc/netlink: Allow empty enum-name in
 ynl specs
In-Reply-To: <20240306182620.5bc5ecc2@kernel.org> (Jakub Kicinski's message of
	"Wed, 6 Mar 2024 18:26:20 -0800")
Date: Thu, 07 Mar 2024 09:08:30 +0000
Message-ID: <m2a5nah0j5.fsf@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
	<20240306231046.97158-6-donald.hunter@gmail.com>
	<20240306182620.5bc5ecc2@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed,  6 Mar 2024 23:10:45 +0000 Donald Hunter wrote:
>> Update the ynl schemas to allow the specification of empty enum names
>> for all enum code generation.
>
> Does ethtool.yaml work for you without this change? 
> It has an empty enum.
>
> IDK how the check the exact schema version, I have:
>
> $ rpm -qa | grep jsonschema
> python3-jsonschema-specifications-2023.7.1-1.fc39.noarch
> python3-jsonschema-4.19.1-1.fc39.noarch
>
> The patch seems legit, but would be good to note for posterity 
> what made this fail out of the sudden.

As I mentioned in the earlier thread, the schema already allowed empty
enum-name in definitions. The patch adds it to enum-name in
attribute-sets and operations.

