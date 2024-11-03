Return-Path: <netdev+bounces-141362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344A9BA957
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A228A1F20FD8
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153813AA2F;
	Sun,  3 Nov 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Vyg9FpGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AAA433AB
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673966; cv=none; b=iE53I16rPUDCia+abuy8A+zA01M67AITLyADBaAClY+cAQssEqbHhNZIWFO2ygrbUzhl/TCNUpCL9JsNN+UafAhEcxxWS915Oh1THFobJYU8Fbd5iz6fbgTRbGcoNKjTd9zIlfzKgsVE614j6/2XONTCxO0abina/vL5Wk2/HN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673966; c=relaxed/simple;
	bh=gGz9nojKV9XYHMu/G0JqucViQsKNL/mo+4W7dd88faA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdlxNw6NMYbfTRyFFxbMPKNFVYSMPGA7ND3giherWnMMGpc6mt1ujW9FHT6aeXSRoFHeFDESfh6VfcSBMASaauMT9NN6TYUY7dcLtCgHeKVxmVoEoGNeFerBHk0xOsKvgPwSypOJZc+2XultCoU5tFsdB+JJt9A+GO3Sw4Sf8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Vyg9FpGO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2977911a12.0
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730673962; x=1731278762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUcOLWGwwQklYoitXir2io61z+J9mnvgtGSJcIPe1w=;
        b=Vyg9FpGOoYMBOB3hykRwD7mY25pomVgV3cokfNfxBE+WfHDBk79ikwaQ3ac5qr5FCW
         3DCm192PX97KOAQoj82D2KJqqvlEIUu5qhzYi+Vj77f3SzMWHEqZygeICym6deJgwuKe
         ifswls4eAliDbSxaqrAkl2LPhz86ud+eBbvaV0rguZY+c44NfoVy9QjjLd6QKQtpxUZH
         FR5j34FeZVWCoqaa+Rn02EmqjSAh169cr+0xh2GpkphWj4Iiz0FqLlYBcJS5/UQ+rm94
         OjUs6saAzoUB/7od21DsMDypKUoEmEAv6/OqbNbFSk7j+iq5S0srjKNaW8pHHBYaXR0l
         PRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730673962; x=1731278762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUcOLWGwwQklYoitXir2io61z+J9mnvgtGSJcIPe1w=;
        b=NOMJ2n49m8KJjRr/njLyrMVt32WpOrMCGEtqWHa0FeWPQ1JrKdu2Lh2RAZnyvXkJ8S
         lnrXaOdqlZonCTiRk9vFSNNcewijAFOYvEnVqXqsoDm+7CNzPw/5iDJrQdlygENGnv9F
         Tn22TCulNb8KP2rgA8Sf2zyMJSTYlc+RIlujqHH3YbhKRdzHHKq+Og8AWBuvJ3SLPcGh
         EddgPb6pmhgkjMz2y65LgQqbNjaVmlFlJZ23A/HqRSk+c2ussYRe961MlszrtuBmk/ZX
         49GAtsHDtrtHB0q07xN2j7UTiNPosoOqr9ZJJw4CbXQyIvRxeeQHuE1lEUIk/ORpIzL6
         z2qg==
X-Gm-Message-State: AOJu0YzHyLFJNnRa5LB2d4ZBfoiY2MzlK8ATR+bKld2mYgBxg3RXZ1Qn
	rJzok42VcGYwlXer0SwCBgktxTr0XoAlh2OOd9wRs3Y/QY6hVduBEVncb3kN9YU=
X-Google-Smtp-Source: AGHT+IGIJ7k75pF/Ozvb6rZuLTExnagGiZiinYHFLcj+a7Pt9qQ/A2PTDkimxxRmOXJvwxPli4FNxg==
X-Received: by 2002:a17:90b:35cd:b0:2e2:ef25:ed35 with SMTP id 98e67ed59e1d1-2e94bdfdedemr15078541a91.0.1730673962138;
        Sun, 03 Nov 2024 14:46:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db4a5d4sm6355229a91.56.2024.11.03.14.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:46:01 -0800 (PST)
Date: Sun, 3 Nov 2024 14:45:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maurice Lambert <mauricelambert434@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: typographical error in nlmsg_type constants
 definition
Message-ID: <20241103144559.3318d889@hermes.local>
In-Reply-To: <20241103223950.230300-1-mauricelambert434@gmail.com>
References: <20241103223950.230300-1-mauricelambert434@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Nov 2024 23:39:50 +0100
Maurice Lambert <mauricelambert434@gmail.com> wrote:

> This commit fix a typographical error in netlink nlmsg_type constants definition in the include/uapi/linux/rtnetlink.h at line 177. The definition is RTM_NEWNVLAN RTM_NEWVLAN instead of RTM_NEWVLAN RTM_NEWVLAN.
> 
> Signed-off-by: Maurice Lambert <mauricelambert434@gmail.com>
> ---
>  include/uapi/linux/rtnetlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 3b687d20c9ed..db7254d52d93 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -174,7 +174,7 @@ enum {
>  #define RTM_GETLINKPROP	RTM_GETLINKPROP
>  
>  	RTM_NEWVLAN = 112,
> -#define RTM_NEWNVLAN	RTM_NEWVLAN
> +#define RTM_NEWVLAN	RTM_NEWVLAN
>  	RTM_DELVLAN,
>  #define RTM_DELVLAN	RTM_DELVLAN
>  	RTM_GETVLAN,

Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")

