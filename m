Return-Path: <netdev+bounces-65831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AB83BE39
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847C51C2133B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2971CA9B;
	Thu, 25 Jan 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lExlybnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB821CA93
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176954; cv=none; b=IT6a36fjfQyznxxz2GcerILjB6EYL02FDTgSizFCJGCaZ6dmrgignkSw7rQ8y7K36yW47bKtEfNN9dLph531v4LfcRSH1uTSusIdPa2SvGr/qupIUAJPP0hGkrY8EFRqiOtI0GOJwrQ4NOOpGfSsLD1raiYNGVy/uAkITYEgKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176954; c=relaxed/simple;
	bh=TvimcXCkUG0QXh9kZAX5BgL1fS02YbmrYXghkfOvwaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vza/7cprDnyAEJmDTX9neT7H9NkWg4AUjLIHH4mq+7SCgtrwF/HmQAb3o8B5o9mTZyYKYhdUySh+dOZyhT8xLWo7OSjhJMJIhDumJnQ9IvhjOFl4ZjC85ZNWXMJwq0NywRkFFWRXujG//uFAG2LBiZ/hYpcdTok5F4bqgpcNCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lExlybnk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51021107958so88726e87.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706176951; x=1706781751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae1aVTBxFsDhcxZR699DrQUO6W7R0EJfvUh5m6Kqp0k=;
        b=lExlybnk2tcRp8JYVzA6xg+qzyOPQZMV1WIYTgMJzIumUklG9MTW46Vg89sBK3ArTB
         RuB9bPesP0mRQdrKhxnQQklvkEA+Nh+oiSZS7boDPBZH80X4XG4xV3sPnQSJcdNYvvOW
         0QB1OXT6TQGqy1pwuGcv3hQ7sScqsWmZbaaYNJn+Sb3lZ9K+LjR1561DY4l54iy5nFtR
         EHVIs2nUPpgd5wNF+YNSPeyL6N30mmsO148LpiHL6cg/kADVGDabjGdsAxrx5okhwDzV
         rSm6pEF3J4+PiYeMlZuiXaZLeTVQtNsUsz+jkN0r/tJTzkj6woxzpUVa/Ra69/0awaoz
         5ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176951; x=1706781751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae1aVTBxFsDhcxZR699DrQUO6W7R0EJfvUh5m6Kqp0k=;
        b=Hybi8sQKnMb/7wey7Rx2Om+iwQpPMMc+zJ/uhoCm0TDprqQXMADxSPqp4V0pMh9HJc
         39S4upY6+NMiZnJaBYNKOj3hIpDiC9g0vDpfyaTyEVULsaHpPMtxSEfySCH8mUxF54CV
         zVgYb8RDNqtcipfbPDzDkI3jofnVo68FSfS0fVvKLx0MVTtDDdw2GpdSw4Rnh1EBeACi
         SOnR4tNvM8KT+Sj9m1xOfGqfmTbZjkoDSHnfxiLrKLAjgOhlwvdJrNFSRDcO7WXZiTHQ
         Oq1vAOdfHE9lHwGByKPOHVlpGFZ5H2xaYzWc4U/2SlePLJ2XMODGQ4bxc3yjvxP0UA+0
         xQXg==
X-Gm-Message-State: AOJu0Yx/drsvMnb8L3kTeQGTJ2p2DN9KngsuKGpYfRusrfPoOkFzikH+
	WRGhI4ON9zDkuuqqHManxV5iLM7TUHHHOnXKQ4EDKgoQ0h+NKsWG
X-Google-Smtp-Source: AGHT+IESMQcayVj1cOLr94g68YE4d6lrtwFQ+KKxjVJ2Q6BtwD6LP/ms1qmf5a0pqgN/WLOF4EBnQg==
X-Received: by 2002:ac2:42c8:0:b0:510:162a:e7d1 with SMTP id n8-20020ac242c8000000b00510162ae7d1mr218901lfl.93.1706176950517;
        Thu, 25 Jan 2024 02:02:30 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090699ce00b00a31824d2556sm388408ejn.36.2024.01.25.02.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:02:30 -0800 (PST)
Date: Thu, 25 Jan 2024 12:02:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 02/11] net: dsa: realtek: introduce
 REALTEK_DSA namespace
Message-ID: <20240125100227.upkkvb26sz6dcctw@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-3-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:55:54PM -0300, Luiz Angelo Daros de Luca wrote:
> Create a namespace to group the exported symbols.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

