Return-Path: <netdev+bounces-103198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0574906E00
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D6A281761
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2E148316;
	Thu, 13 Jun 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0BwPDCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87878145A14;
	Thu, 13 Jun 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280094; cv=none; b=EMw1UdIfzWUEkBUyh/QTQi47f1alI2kvRlmp0vF8eOylT83rj249gYS1hrDrFs6P0a3XMB1nV4xidYOjmQTqVCc9km6hxuSu4cJZ/ZnJZpW4MvdjCSmdnXFGF/K0sIXk2K7pqbNHJswOeG2AXRwS4SHYMKXF5PPBCzbJCHlPDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280094; c=relaxed/simple;
	bh=4Lqh1jE2xY516irQXX/1xMbdZu7XXl5X23gAe0VliwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUhBhJaINvmVqWLNJEbigeEIgw9atkQ6X/tz+To2wuDq6AsH3S5xveVusLv04xGpmUI40PG/6FCYgUU+CFQv5HWQ4no8Q7Y95NzAdxK6zBZD/LNEc4nJdbo0uDoaCdJceL+2j3Fthi34W21bU6155oV5fTFGKDSri9sUQYfS4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0BwPDCo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c82101407so1854064e87.3;
        Thu, 13 Jun 2024 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280090; x=1718884890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBJ1ejFH7z7OGpwZgl0po5UnGmqdnLOVmfHOb4vTMGo=;
        b=a0BwPDCoZifbrca7QkgR+LbyA+EEHGJcNcE1uk6BnVZUQ5+KrZqug8VirEMCPK6/lU
         /HWEb9qW5mpHGpj64zgGFuGwnj0gfkGJOLJ3KKxSJ8eDYa47vjEOPW9NPfFT0I3yNUmp
         yWC4Mxo1IlzQTGoRBERuyEol/g2fuqmyZj7vrKXvtvhhBieVhMrJW+i62ysBcrV6RAw+
         1EoM40uKCB1J0shPli1HDqCIKbnhp9wlDn+nfGDZkKcTSkRC8QAVMt6rVP2TZhNt5I4B
         YjY14ly02a6i0+aDnOUPE9yreFhINPmPQ8uuRiWZvJbVUOagzcD1jRWW4zqWVpBw5Wd7
         BRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280090; x=1718884890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBJ1ejFH7z7OGpwZgl0po5UnGmqdnLOVmfHOb4vTMGo=;
        b=My88MxMerZUtANmPuYZLD4+5tIKiyLY8xFEqRoF6dYKAYFGHOmZY4X6eTwXHy473cq
         E2MzCpo6qnLMJg2Eg9n/T7vZ6WhY9ukehepC/Qa7U09qrKtTw3vwXipGV5Lv198ivAOx
         SW2XwKdR0uuiCJezQN9u4L4L/og2thj6VYXGhUsbuQIgCIREiy9/r5g3TeKp8j5D9a+R
         E9A1ssJ/fVPiM/I6NfwaWtRysie3WUFEX8ynonOBgxb+ZP0nQUZLzTM1ZGWMadM+V4Rm
         X04w/YkFxokJL2mE8KXVz7Bx0VBojjkusda2kW6BstAlN+/0JCyYgghWP9/I7OJHdNoW
         x36g==
X-Forwarded-Encrypted: i=1; AJvYcCWL+xuX5tGMF2ZsKOcA5wx29hHTJoExRyxtfjs+Go+okojR6vOPzHUhh6koIh7nJQHQsw3P9OtKB76wPSC4wE/fSqmzZ4TAiU6XVrLYyTMbxDUaqAhNpWwA14hjZuSUa3UclRwQlGq+kL6iRzRToYlMhuJutRKeBE38xDI5PL7E7w==
X-Gm-Message-State: AOJu0YwdfA3T+0jXm3LNqX+hGDgJyEM10BfahnZ8MR7C/X+WHTdtK0rw
	6IiR6GFO2ZdMIaHl/ESWiT9N5GidRYDn0odfBl9KY/PREp8PAIpmQPCyldPulzc=
X-Google-Smtp-Source: AGHT+IGpkc3EbBak1wGWckE/c9yRGBYMiFJtNSWMbOvTHQ4iNis5fHFoZkSL6dv0d6j/eGZB0MXt8A==
X-Received: by 2002:ac2:58d0:0:b0:52c:99ed:4c9b with SMTP id 2adb3069b0e04-52c9a3d1e74mr3286775e87.18.1718280089182;
        Thu, 13 Jun 2024 05:01:29 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm64042066b.186.2024.06.13.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:01:28 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:01:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/12] net: dsa: lantiq_gswip: Remove dead
 code from gswip_add_single_port_br()
Message-ID: <20240613120125.yh5vda6dxornaadj@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-11-ms@dev.tdt.de>
 <20240611135434.3180973-11-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-11-ms@dev.tdt.de>
 <20240611135434.3180973-11-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:32PM +0200, Martin Schiller wrote:
> The port validation in gswip_add_single_port_br() is superfluous and
> can be omitted.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

