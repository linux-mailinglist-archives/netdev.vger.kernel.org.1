Return-Path: <netdev+bounces-190154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75095AB5557
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABC61B465C3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8128DEFB;
	Tue, 13 May 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHAwoDJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE51A0714;
	Tue, 13 May 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140923; cv=none; b=N7eBPvACcPBgZdadCllKLVV4we4Mre2GKMbKdeT7Z8FY6Oq24iJ48R9Zb+hdDMzS7xK22e0NWf0Z6W5wCCG3fbh8JRZnduYXjcWYCq8ynkG621yzqGqkaLbBtegDrRWt2eAT4Pd5oZcPzju5c4CjqLQ3uMD0AUjI2je+tmacz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140923; c=relaxed/simple;
	bh=3hdGj8uHpxr62p324p1GcSBszWvHSvDyDYlv0GZW5N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TELidYqmi/kqXTUqYkTjCs5ycHKiel8ezNOs/eXT5s0tt7KSuBlwBwqZkEFFiCGGZbOTqSzpuz+0aDbrDinRzm3uEY6oSxgcaJpjaxRdJxfr+GXLn44aLPkbzZxFQk21JR+4a+l8np7cYGMWSLL9of/4ab5+xOZM4TA9Lg1wmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHAwoDJj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fcb523ebf3so832908a12.2;
        Tue, 13 May 2025 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747140919; x=1747745719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeUPbqYzV5ggCCFVQv+5+GayiTBavegaQ+ohsIql/XI=;
        b=HHAwoDJjMJVnIGRbhX1dWXZT78siYjUil2otLwTjAtgkoeC6iHYZuNDEr+vCMd+849
         Ysh4ywH9WEqAJrZRgKPhX/AtkR5+z+FNpz3MQXRPkid34xNEmfzoy/VQZMIDMLJNpxaJ
         gCTVDMRgW9FtTeZwWpgF9QYjA+X8p0RCdZFCGjur+o9F0njeD80KT8fY6fCdaT6eAQMJ
         UlV0YqVBOc8oA21mhEl5CC2UKhwhiSl4xnmDLWz2rwFB5X0GlPaBr2qBL/mLJfy/qSmu
         ZDjauBDfYTYSSVmoY2nUmq2l04omqFWCBpqEX897xAwt7uAQJ0TIKRtXVVGKu+3ykUWi
         AiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140919; x=1747745719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUPbqYzV5ggCCFVQv+5+GayiTBavegaQ+ohsIql/XI=;
        b=HrTAi4EMRPRuT4dtC9idxpFYNNYWZj8fHqMRcAACYCG/spn1+MPvi473XOgneS/KVY
         0Z8eTSmrWLcs9BI8W3AdAnfcNVtp8t1PU5SLPqdXGQXUlaozCZveGkdn4QrWVpjtNk10
         59RxbFeD/xyHgwmwE6ldeFpzvUqbKD7DdqraZrZMrA5TEmwsf7ZDsRF0vFnvkFrGuYdE
         eiF7KamG9UFa70o4y5r3I0kLf/zVlEYSBmb1DuJM+NLXEsccSrulcxvSeO+/Vo5GduH+
         aewNI8ss4khTtBKE7Fvi6U236+hoJkIAeXuEJITDYIlSXH8GvcbnRr/gYjOQNhxd3goB
         RTiA==
X-Forwarded-Encrypted: i=1; AJvYcCU2DwJrGiJzHVuZ98aOriztIflAxOY+OIsURIXOKuFmxRaXoKFD0iILnsIi4cF6Pm4BRriEJ8jB@vger.kernel.org, AJvYcCXqklc395Zl6mIQwV6lzEO3C7IEtpT4ch+ggC53gNuZD1aOqXoanbYNCehrTaU2c/mFBQwlbyqnZytqqNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywie5zKJ2KfGBO1M2n6UJ7H7tMyBzYaaVnqYtvsbiwMMBIZcAgu
	1GIPYqkyOvXVbZcUY/YUynV+PF0tzDCKrTXC4yzKpiHDYR/i5c1A
X-Gm-Gg: ASbGncunQQyQP3o0Y1zyMtaYusGqrq+l9p8mVzz7yFHExUuoyb8IZHcYGeuciseKIs2
	df15PCfxkfj61H1iHvjmCJXbJ6elgDrUYqfJ/693Kd/GYR2pEYX0pgbSSbH5IWNpHRylg5khAG2
	DDn8E0GzIVzoenUGClDzS/0tmwj41lnoVkisJN8J19mi7AspheWktot8ESs6Yf9Px2cq1YAbSkQ
	ZW0ComFdc5k3Jr9rFwqFOWW9dZrCifu8j9mvQ9RZgqFqZ+nuNXV+WMLN7fR7Z9hEcxz75zFKcWW
	pRx/YGEKTvw9UhNuHSq19jZBzAluzZzTAc4+7sY=
X-Google-Smtp-Source: AGHT+IGz/4T1J8uUlgyA3H6eGcJhOWFsPNLTAtoSYj7A1hgVNdo7lJee1rllsfiKwrtF73nWdWfY+A==
X-Received: by 2002:a05:6402:518f:b0:5e0:a4ae:d486 with SMTP id 4fb4d7f45d1cf-5fca07ed6c1mr5400535a12.7.1747140919203;
        Tue, 13 May 2025 05:55:19 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197be6d7sm771671966b.157.2025.05.13.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 05:55:18 -0700 (PDT)
Date: Tue, 13 May 2025 15:55:16 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
Message-ID: <20250513125516.bsgf7b3jsrcfq4oq@skbuf>
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <20250508091424.26870-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <20250508091424.26870-1-jonas.gorski@gmail.com>

On Thu, May 08, 2025 at 11:14:24AM +0200, Jonas Gorski wrote:
> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
> still try to forward traffic to known FDB entries on standalone ports.
> But since the port VLAN masks prevent forwarding to bridged ports, this
> traffic will be dropped.
> 
> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
> this breaks pinging with learning on.
> 
> Work around this by enabling the simplified EAP mode on switches
> supporting it for standalone ports, which causes the ASIC to redirect
> traffic of unknown source MAC addresses to the CPU port.
> 
> Since standalone ports do not learn, there are no known source MAC
> addresses, so effectively this redirects all incoming traffic to the CPU
> port.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

