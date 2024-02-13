Return-Path: <netdev+bounces-71350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3E8530DC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B093A281C30
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A8405D8;
	Tue, 13 Feb 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SokMTIAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FD3D54D
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828513; cv=none; b=lPskhAVYi0+s1CvqZs2NApqukdqGFvEFndmbalL94g1wdO6KtPrh0fibhqLLBbQRfCvM86T86z/dbuPLCrcVljhi6qEmxG4VfMBaE68/DijoDI0q0P2n7rOAeOXxhzmk+fPjYkOmW0DeIJwyU+FiMcEh3lFZxQlw0GLG7Hxd6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828513; c=relaxed/simple;
	bh=OVKbyXJQFDYDCCsL63HkX198El9Zx1cnDLATPznODpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFBMOXex5QB0eWN/pHHhhbeVP2CCkhqL8NhQVgcMcoZPsUsipOyyJld8J2ksbgWQDWM6aGlhAZO2tOgWCFMVxLFso1zdsCoiX7sOLfKqYTOLsNQlBefAt3UYCXSld/MQRQJDvOMX76Nk/tclkcqrP+FCQmcISIWxv2lSxO/54rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SokMTIAY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411bfe83d11so3911855e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707828509; x=1708433309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUWoCWYTZG96LeGW2I5Svh729PgyYJVN4VDPaXkoaYc=;
        b=SokMTIAYSrusSqHoKx2qZbYg2FokZJxjwNfM0yuQ3wmTiyyDk6meolS/giQR7UVFML
         ZeTLQ7hDbo5TmsKc7HaUit5y+26gbN6ctWxfjvKbrDwm1jZb4uef3AcXviOq0S9Rov1R
         ayhTkIAHuCYySJtqcX5HEhgDSMuSNWHNs0llz0WHPDf7Bf5r7Ixlfezk+lmBev/MeLXj
         aT0ecu1w7Rs4Nj2vkamxdCIzbiaSJxUPP39tkSbfocA+nTjXwl4WEmnB4pNp1oVtpOYk
         Ou9J3FEtuxynvyKkSXIGQ/xCJc04/WTeLNub1d0jhUFEbOnwJwHOlM2zCpajNqunUZM1
         1jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828509; x=1708433309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUWoCWYTZG96LeGW2I5Svh729PgyYJVN4VDPaXkoaYc=;
        b=E39mPSTaKfBHauGo3mOYWvD0HWoPzMLGRoKKpN0qjlpRo3Juf7JtEjKNQ/N0Iz1EdV
         yLNnrLNm+JG6u2iZILI4kdC4S7D1m+6gResW+X3Mov89oCigAJNc7+AnliKxgabmr29P
         C1mr+lKOI134QUfVxlTiZChB0JZqsUK8D1fuDNPr2h/OHx0wHvkqgbqoGnI6ay0VUBtK
         GVjiD42VN8nUvOLylHWQvb4XIMg1sXxTgSHu/7znBtuFKVqrvpa6yY3JwMgOspMrFIKz
         i3RWej3AWLEYIJ49lXuTD3Y+4gi5vdUptb5g4QA2dns3a7bRnRWtLnh6j3WHiBl4j322
         yp6A==
X-Gm-Message-State: AOJu0YygKAcG0xStyVn2gFQOO6Dw98RbGqB6mDN6u5ivNHkAx7hRiimd
	HDg3pw+mZLrevAH81+ozXmqJXkjfTo3kK1VT3o6CjJR/135TVSmbKSeeM/oHKTQ=
X-Google-Smtp-Source: AGHT+IEG6zMMDgBfDbjQExu2oik6ONkv41vr28X+1JREqFdotpobj7c+rm569A9jlVKjt7LADMNgyA==
X-Received: by 2002:a05:600c:470d:b0:40e:dbdf:9fb4 with SMTP id v13-20020a05600c470d00b0040edbdf9fb4mr8713030wmo.23.1707828508841;
        Tue, 13 Feb 2024 04:48:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFb08DhvqPTMElbd+VWJ5jyVDDEYkPSArk9WGE1wNTu2MxMwvaod2VTlYYQJn/ZNfVZqr+09shDGK1ERIbeaWlm7rvgWJfQ0oQCkTCFBUUcLHS/TWJsdTtXt04ydkGIfcBud/3wESDp19rkZpbPNe8kBPpHlSD8Gp+YW0cnOGpaR8n1Ur7Sc5XzvC2hGoYoaI3E34E/ZGwaK+ZINnwv7yDp/GHso5qQH21gfeaj/p+YBud4QRL3be9eH+Me0Os6CfVnO1LYc3OuKxXviUJnqD3QQMRvsJH5E05UgDIm0U6vtXBsEGVeFlRBDE5K8Yt04RucbJCtmUAoMZC5qXKyC71
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bj8-20020a0560001e0800b0033b3ca3a255sm9496470wrb.19.2024.02.13.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:48:28 -0800 (PST)
Date: Tue, 13 Feb 2024 13:48:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v5 06/13] doc/netlink/specs: Add sub-message
 type to rt_link family
Message-ID: <ZctlGYoynt1nMJdb@nanopsycho>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
 <20231215093720.18774-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215093720.18774-7-donald.hunter@gmail.com>

Fri, Dec 15, 2023 at 10:37:13AM CET, donald.hunter@gmail.com wrote:

[...]


>+        name: mode
>+        type: flag
>+      -
>+        name: guard
>+        type: flag
>+      -
>+        name: protect
>+        type: flag
>+      -
>+        name: fast-leave
>+        type: flag
>+      -
>+        name: learning
>+        type: flag
>+      -
>+        name: unicast-flood
>+        type: flag
>+      -
>+        name: proxyarp
>+        type: flag
>+      -
>+        name: learning-sync
>+        type: flag
>+      -
>+        name: proxyarp-wifi
>+        type: flag

Hi, these are not "flag". These are "u8".

[...]

