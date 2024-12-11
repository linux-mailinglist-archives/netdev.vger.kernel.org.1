Return-Path: <netdev+bounces-151011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7F9EC5AF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFFB285C28
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3431C5F00;
	Wed, 11 Dec 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Sk7USPrU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06491C54A1
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902784; cv=none; b=Se4qGMOemDyCdPym1utVAXdDrCBvoVu+PJyF/ulSYlm+Uzted2zz+PX+xzDUYx3x6+g0qdP0Fd/gKxAybrR7wd5JgWF0XyMpTjFpQFrZ+lcQhBlS+sZgdPkZ4cgPowfLIacW/0AY0Mbu/7PbVVmAYkI5vQ3OewrIo3b3PTjnvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902784; c=relaxed/simple;
	bh=DORG1Ks2Ys/cwGYFA4vsK35m/+ska6mrKncu7v6xL7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSzWL6/0hEtVMAOLgl9ZUHC8EbTPLzzYyNXrODolMzMYkqlpseHgxGHrYlV5rj693puvAGbgIrgbJ5F69NwVze/SlkZBlsi7UKwv7kBqyO9hxqDRl1t38LeopYxGd+APi00HhrGSPP6j1aq9mgC7ppjAX5x6WDQacMLfSx3HNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Sk7USPrU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso1217412466b.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733902781; x=1734507581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDLVARpsnDlTbI+1bNiZJo8O89zIKh2KB20CydSK0Lg=;
        b=Sk7USPrUrYJ9QQvGoQMyuGONoEmDa4ZbODq8itUsp01Rx/EbrJcwtvf0dJolYuAxFO
         LWixIfmMUPpAUC/urA9+LSIcfk9FCoQRlEFZBnhe+V0fQuYj+R5qt+sZ9SyiC070QUhF
         51dTs68e4aDyi70qm7bqp0GiycFlPXzJyWdkJiSJWeMvkwhttvY6Tt9QfomowXEgBSRd
         RGrBc1KmYjcsvzOX18s2ft9kuKSsDuY93rIhnhq46NGEUqsIN2hqx3flrQhuhtWDhqz7
         xyJIsWgamppky21Ms2QCJJOXua9CKmK1Qlz/jWNzsNOoI+hSuyqSlgdlqCdFZ7WDqIKk
         sLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733902781; x=1734507581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLVARpsnDlTbI+1bNiZJo8O89zIKh2KB20CydSK0Lg=;
        b=QmW6xBegkVqDl3fwlS78CT0kIqy/p4cZiEnHqbLPwgG1WVYeVExcni9qgT++OW0E0y
         rCWRLha1n+N0KaWS6U3GYbyU/lGh5705GBh6nw0EoBx6e2sRKA6cYk1hadU+YIbECYlQ
         GcsbsgA1Z2wyrg+hbuCAI2V+IprmFWPXWwuoXqZj0ojbRXEagExWLdno7wCnLOZnDw5v
         JtlDlqnfgY/8LfiTtLcN770lXLcpNs1nWFw6g/R/dZkJby4bPjdXPWm8pH8DJ+I/Ff0U
         SSMDCkZ121dlVn5vCWVZDwJ3pNgbOyR4sR9mqooCCfP0Mpyyb6olUTSSfH18B4yHLiyS
         pauA==
X-Forwarded-Encrypted: i=1; AJvYcCX2zPsoO/SEUYhUFla0O07SgmnBrksyVBkHT7O45WIb+ZtDLIovh9Vi3HLoDPjvOMV+7beI0xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyiBTOM+q/26fwJkJAY6UFoYQFWZm3w0Ia/ZcPFOHrJ/pPNeE
	zQLHz2HXr2YBVVcXqNFwu3aNCGBtVflmvwtz78RUCB0IakPIQZM/O6koiH+ojNm+T/hmVjrrUBT
	x
X-Gm-Gg: ASbGnct80LZ6rehaNQiD2oO2zaKtBRoowH2YZvT32S+F383tN7lAU3GmwKaNJAsGGL0
	zr7hwVx9FPiN704yEYKNmssED4cO0HgbUKU2fjaKhZIS6IfKjmKjJjg4f7Z6Mc3JWOe+KIJ3DUC
	+eFnoRJO0ANO8WKsTTajzCZcim7OlHBHr51vTMcyM6Nw7MysODVVQGg+EVL5WQnTvSwTVmYFfOn
	mzAuJFfRbdXK+PO3bYJ/SR4J/rx0vzqeFcFDcmKcjSUzchKe8GdsvmT
X-Google-Smtp-Source: AGHT+IFipA+mRShFNJYIIfQNQxqKK4x68o9aNnxvU6g/oFn+L+QU9luB/+oOOIQDdTdJSOLzAlaj/Q==
X-Received: by 2002:a17:906:2922:b0:aa6:6aff:45d0 with SMTP id a640c23a62f3a-aa6b13db741mr144859466b.56.1733902780840;
        Tue, 10 Dec 2024 23:39:40 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68f4eb962sm373232366b.3.2024.12.10.23.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:39:40 -0800 (PST)
Message-ID: <7c069355-03d5-4eec-97ef-83fb8ce21cb7@blackwall.org>
Date: Wed, 11 Dec 2024 09:39:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features
 helper
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 4 +---
>  drivers/net/team/team_core.c    | 3 +--
>  include/linux/netdev_features.h | 7 +++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


