Return-Path: <netdev+bounces-75383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC1869AB8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8F71C2476E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C47146007;
	Tue, 27 Feb 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kc0AXjOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611C145FFE
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048565; cv=none; b=lzq7Fu/dUD2dAnLeGM/jkHjQl0fl8xV3epPlKjOeZJLyfrzMHL1W8bPLuSNjU57x4DeLiVwA46vjOhT0gzQDPvBqom7+lowS+uuNqwHpvje3eT1JDkEbIDHvkYt0jNDcaYwA2BNO7zuN2I65b/de/D4oLFTOtgkWMQy9/uo+P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048565; c=relaxed/simple;
	bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMKOSryZdoTcTlq0elvn1E2NDoGHQihuXbTeYG72fDMYEY4u7ffHk+qmeDOhNdoamk66BGxV+0Ua0zYZGsb25vr/C1dwnUmz6yAUQEyz7KTTF3K8iMJGBzdfZDuq3maKl5KkelqvnUy/kQ0QRbM2Ppn38RuyNQ3ngRziNiUmRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kc0AXjOM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d23d301452so61291441fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709048562; x=1709653362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
        b=kc0AXjOMhTIIjpR/zSVlShOiv70JeqMzv3MAz7GrKymHhSSYePl4CEcCSvlQyhEce9
         A46OQxNiq+/vLubE8h8MsR+rgnlwhqu94Sl1vQ3gCq/+gCP60U9yXpdhHrV/c5RE2IM0
         82JtZ4GQojirptZkyAwROsTKb78J5A1jw7G6da7GKVURmZg4sBnv7L6knSjMN8Q3g9vD
         nEQYb6OH55WH2pdQYuezhKTEuUOvR63NMFEUhbZUo+s8eWir9DdbFMrBLB4ST0yxa1ve
         T2j1KAOUQTNnDtfxW7lFOo0wxLKeBZviQQ307DGoRkDEEAS3y2UmYYFAvTrZn1QujB2A
         yRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048562; x=1709653362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
        b=atdQTBvmIdq8AOud6dPdB1uaMMSl9KzyfQfCgXXsOVI+HTbPnmFFXW00CNH1VRp50e
         HuOGJEHE1qYMl1R8HFnpKTKD5iv1mYCNeDngxYV63t050fL5/Tvjnqcd7RTrC5CIPRhg
         1kUmmvA8yzBntmTLfGKZV7erORGlGSW7ev6CBpzviLeK/YTEZRM9Pg6D1UUXB+y6Mdh4
         ZdApDO0Fhy3qNnkq/vgDyxTj0ekMdj361orUyEqdKINXkg3oK0/M3EWt3016bXlR5nxg
         iaKQpt+InDzHa8Q0LMC/eAsNOBiRc+rTeBGgX1hJsLCEZNVKhh6czY71xkcqQ0hcCtc0
         vEMA==
X-Gm-Message-State: AOJu0YwtlOi7O47QoqZ72k03EdB3TlZZXx+GLhMtKiewg6jEBjw4iciW
	Yipyp5A/aNzhihbT8XEgyOV5GuokIzdPOBDWZNvB8jP8i6pi+gYwMsV5xdvCiB4=
X-Google-Smtp-Source: AGHT+IGftc1nRxlo3NEGi5ysAyh+KdodU1OSoGzfpLdwuYTGiDo6VZbLKgDDSZW/zITdmPT8UNKDIA==
X-Received: by 2002:a2e:9215:0:b0:2d2:91d1:a72c with SMTP id k21-20020a2e9215000000b002d291d1a72cmr2858451ljg.6.1709048561867;
        Tue, 27 Feb 2024 07:42:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm8635353wmo.23.2024.02.27.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:42:41 -0800 (PST)
Date: Tue, 27 Feb 2024 16:42:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in dtsec_init()
Message-ID: <Zd4C7kztg-eBqIQV@nanopsycho>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>

Tue, Feb 27, 2024 at 02:14:52PM CET, Markus.Elfring@web.de wrote:
>From: Markus Elfring <elfring@users.sourceforge.net>
>Date: Tue, 27 Feb 2024 14:05:25 +0100
>
>Adjust jump targets so that a bit of exception handling can be better
>reused at the end of this function implementation.
>
>Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Nit, next time please indicate the target tree in the patch subject
prefix: [patch net-next] xxx

