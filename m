Return-Path: <netdev+bounces-178125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB3A74D40
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA781899BAF
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CF14AD29;
	Fri, 28 Mar 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMq3E+cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADA3C0C
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174082; cv=none; b=b7cRhRvHJp7eJ4DW8UITHsPJU7EJ52Ljc+h+w1OxZo31Rrio4oXt0RPJWO14GF8buaaM0SGQuxI5Iu0VVnF2BEj1A0NI5HpVGH4bjp+oSiYIxzU7pbLPW7bh4/pn6wc63jfR+dRDRPkf21iXbmbQlfOYdGvP1T26c6fr3e6oRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174082; c=relaxed/simple;
	bh=NUoPTKRFUmo9ZCoonOYtZ8VObhiW5ox/cQep5uAyo1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5cKQstSYXLv2cgjtsaBWeR58YP/X6b5MqBS3STC5cYidwsIB0I0404zNJ4SD/oREJDg9LieWylxHPkB2LAF4ZDA1DGDScoqCPkSKL+SMfzC/93HcoKAxlokrRsvEAvCbDNoL8vDmnN38gOPTYBD53BtjwRj5gUcJFQWxZnZ3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMq3E+cw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso10284185ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174080; x=1743778880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/uacRGi4FRhwLfPaACi9AqyenwA2qOu6wyZ7omusq8=;
        b=AMq3E+cwn63ekgZ7KLXlII+AgxrPtONBVtJ5X+IGI9zuC81h0+gX90SnTL6dh+4m8v
         gGMZ55nt6IkvZMvC3HIxJMpHlGFmW1dYlcNoTukfBifNMiUxxZ6wT8z67I4tfjy/Cnr2
         O77a1Zbf7kgC/MNmqecx4mRz3n6Uh1zSwZjlJCySg/tkyZWMd6pEpBTYhDSBDzTvdvVk
         qL7NNmnykU14oJlUfRfrA0Dti65R7Ju/UdjI10JPS3ucpXldNxfhhk/4SYqzkx18oxXs
         5/huxfSnkgfAQmDG+prxT3e1vFcdk71WmX01YRx/m9e45JPoy+LECd9xUxNLDCMlkIz5
         yKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174080; x=1743778880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/uacRGi4FRhwLfPaACi9AqyenwA2qOu6wyZ7omusq8=;
        b=uCu/5HGdmpbSYlTc2N8pauOZx5ozx+WJ7FMkDkqz74qZN9To9MrLp6juiDUD/Lg8Mw
         UV2cELNopBPnpDj6wpQvBLoYJgUhIU8hdyKFST51D3r1iqP3vZy/Oxa6Q0YiwyJHlKzz
         n2BARJq0hDwLYNAgjwjzX4xuPBxMXnvEV8yrc4SuPE7gGjXUdNbX/QZyS77X2N6Iux5+
         qbI4lnYusUZbN1Aru8UIO6WPbYjoYCw7NDjOefkky7kESzGzZ4ski5uJSqCAIgR4xphr
         5600P9QfGdNA/DIbmM76eRVi8Jarel5MCTJFQlGuWEnPrnzprd0BUl3nmOXhNM5oX7Hr
         IE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdedZQGHk44Mz6IfAA5deS4xmZk3JSnP/glsOwaRZfyfoR5vl4VpGZvntgfxM5Qa/ReDYLrb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLNetCSSbq2QgZ0gjhu/5Tl7WMGhHCNlU4hKI+8/a20bBzjZj
	61Ux852xIsxckr1c5JzPBIOomShtbHCEBhWOFZag6J+e9Bu26mA=
X-Gm-Gg: ASbGncuT/zGw5LwNL+FWxHW62+fC70r9O8Pq+EMiuok2BBZY8grKFN2J2KvBJbjWFgg
	+VKJ9KaMSA7xk/qF77f/xBpLGCm5+hFjrj7AYPpXQu80JDNFT4o64AduNoxXG+icCcR6eIEsTWp
	CNh2fn0wrIqF4q1Y+XyyDODby614bxx7alCQao3fsG0cnWwIivQ9uSsQCIXfTyTVUywZEhc2YUK
	K1zVlLiqUn6xaOLUYZxB6/+h+9QF4zhMVfVDkq8iX3uRoeUNtaL7jbuZbphUt9EcqbNvdEYkfrV
	4Gpwp6WYO4qpJVhbm7uDXyGammznYDw9LajCpVplfWYN
X-Google-Smtp-Source: AGHT+IGJ5TQ2rPvAvWAbG5twOdcnblkKje5J/DGfBx+xi7HeBb0f5ZY4U1Gj83jGE6UYXwr02TOy1g==
X-Received: by 2002:a17:903:32c9:b0:224:1781:a950 with SMTP id d9443c01a7336-228048577e2mr120961575ad.14.1743174079041;
        Fri, 28 Mar 2025 08:01:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee2667sm18994705ad.92.2025.03.28.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:01:18 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:01:16 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <Z-a5vH0QAbr4Q0MY@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-2-sdf@fomichev.me>
 <20250327115921.3b16010a@kernel.org>
 <Z-W-c8RyFxg30Ov5@mini-arch>
 <20250327143623.62180058@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327143623.62180058@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 14:09:07 -0700 Stanislav Fomichev wrote:
> > On 03/27, Jakub Kicinski wrote:
> > > On Thu, 27 Mar 2025 06:56:49 -0700 Stanislav Fomichev wrote:  
> > > > +EXPORT_SYMBOL(netif_disable_lro);  
> > > 
> > > Actually EXPORT_IPV6_MOD() would do here, no?
> > > We only need this export for V6?  
> > 
> > This patch is touching v4 net/ipv4/devinet.c, so both :-(
> 
> IPv4 can't be a module tho, we're talking about an export..

Ah, that's true!

