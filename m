Return-Path: <netdev+bounces-125927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B096F47E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74623B21697
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647631CBEBC;
	Fri,  6 Sep 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR40EWa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B81CB15C;
	Fri,  6 Sep 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626700; cv=none; b=STOGLvZilL2zF45Dx87QjfZWHUWccaMCbWGqbu3jpum1s6APXfQdxAaQ/MJqWXZjSHrM95OXufwbecE7dhJcx30QABZtCE2zN+521nlmattLsP7i3d0LsaUrW1wzJtk53e6KxLO3RV65+aJJg4CwvC+kJzUAkzL3VfTb7QX57ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626700; c=relaxed/simple;
	bh=EDwSya96aN5voG1jq5JWGPY+lJNBxm6/d0dJearZN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaHXLLQc4QR+1O1sffCh+h082/pRotaL1GOXYMiTu4FDQkDU96654R1OSM0rMivjgNPiR0n8dG1sXdfj/pOV2vT2yet6ItHP+2YKbOuG5Kr+q2bEh1iMr3LkOTVYd4x4PQKMkhYTnC+DroVzsnLb4foGXUOIlrX76oMeEwNgAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR40EWa9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c245580f52so238193a12.2;
        Fri, 06 Sep 2024 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725626696; x=1726231496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR5utfavmHvvMykUAYOB9LOqH1d3Vi9V/rHk+vjmNqw=;
        b=XR40EWa9CgQDethIteHyDOnd+AXJ6dAQESr2JGWfazqf1r5ybqzqu3jL5RdopYiwR3
         n7QfRX0+Nu9p/C1e4AibRXZz6fhxwA/NKiTgc8pVum7seNqzPGvotaEiyh2qmX8PsXVC
         HW34ZbCdvXump+P2X2Q0J9LmhgOWdEgN+Sinem0BPHK5deK7thrciHKEprjjE4GuZrVX
         JhD5APWMy8h2NpP6wP9+zuRLpqUaQ3q0FaN1J6uHuFHGASk6LxXvip+RL30MAuyd11BT
         Rm2oLML9oViQ22Af4AWYgK+BuTVOE1p2naEUz1X9BO0tEXzLm0HefnfFD4RJohPsxzDM
         DBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626696; x=1726231496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR5utfavmHvvMykUAYOB9LOqH1d3Vi9V/rHk+vjmNqw=;
        b=EhPTx/daduPSPoPVhuzJFrehCICt9U9WtNg7b0L2szx1MjXImvVUFSkrB3G4nAcjfm
         J+F3rpeKl7/xGVxvT/79MlG4lTJVPKAJcbxdKL8iPxrBtxC+GN1onzMt0vD2P0k0omhk
         bFENk9HEizEoyYuaojZhGxW6luYFFeomhkCSApJPfLxb0QIUWKl8ayJiXA0eOXyUQEIo
         T8CJMnUoqtvsfpXQ7eeHvbkxPnglY4kQk+cdaXkbx5BJ8Ha5Un2a9W2GPMj8II3vvUpN
         4P/UC6z1UeCGgS8Jsb0W3DfzpMJQp4pmblbQOmy8B+W6CjvqZbroMQEtHgSX+AmQ8BTL
         2gGw==
X-Forwarded-Encrypted: i=1; AJvYcCUroP0H7Ccj02D2Z72OlueszwqaU22IvUUsLNwguqpvhR7QzH5p3STCQSZu+I4+QyTQWk/aVI5PJy1puZI=@vger.kernel.org, AJvYcCXrlyXNB48KCeOWHLEjVBMsp9RV2qhFfLgMiljRAy/3ocD1Q4IWnaSj2uGAfFws42LAvheW+zjS@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJiS9blV8eVKgnHKRp3Fsbpbnzx9FxNN83fvBGRgoEPApoTMQ
	/nbfV7d5GacooRSZwvhNE2WIn99Hn0gcHrBEHjK42XM7cTfrluzc
X-Google-Smtp-Source: AGHT+IGEdOn38Q31+dL7A/iwOSiTP4+o9njLBQY9eVTo0Mjj/K3eLpVKjfaPyeVms9BFO2FSjWYqFQ==
X-Received: by 2002:a05:6402:2692:b0:5c2:562f:41e2 with SMTP id 4fb4d7f45d1cf-5c3dc77d695mr970016a12.1.1725626695843;
        Fri, 06 Sep 2024 05:44:55 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6a4d2asm2379853a12.81.2024.09.06.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:44:55 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:44:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v9 4/7] net: stmmac: configure FPE via ethtool-mm
Message-ID: <20240906124452.aun3ullhvumpzcyu@skbuf>
References: <cover.1725597121.git.0x1207@gmail.com>
 <cover.1725597121.git.0x1207@gmail.com>
 <c8ca90a7b5ddc609ca15a2f6157939176cffb4bc.1725597121.git.0x1207@gmail.com>
 <c8ca90a7b5ddc609ca15a2f6157939176cffb4bc.1725597121.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ca90a7b5ddc609ca15a2f6157939176cffb4bc.1725597121.git.0x1207@gmail.com>
 <c8ca90a7b5ddc609ca15a2f6157939176cffb4bc.1725597121.git.0x1207@gmail.com>

On Fri, Sep 06, 2024 at 12:55:59PM +0800, Furong Xu wrote:
> Implement ethtool --show-mm and --set-mm callbacks.
> 
> NIC up/down, link up/down, suspend/resume, kselftest-ethtool_mm,
> all tested okay.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

