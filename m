Return-Path: <netdev+bounces-79070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB9877BBD
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EABB208B7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392E11720;
	Mon, 11 Mar 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TzK/WDQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147110A12
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146155; cv=none; b=r0GDFw8CtzS2SLGnNpy5sTB+yFY1pVH/8A4lEMuthnpHA/CtEtNRvsdijFIJlTMMZzXGmv+3UqIiFaaQaXa2KFgfb+Pjwr0m3j9eMrxDH8weF0IlnPoLSKubIHlGuWUktfk4kLPdtTJ5lZ3ZpqVn+ORlNFvxRHpzShsy6AoWwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146155; c=relaxed/simple;
	bh=TNJWRAN4cCOb64u9AcoLemre2HbuWSRCjfIID/gyouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9XMEP/IaL6RSRCKf6rfs+vg2PmBiy0DDwe7SCUyI6H5OqQ10W5kY/Hu8wtwXUw0OTxgD/8YdNmySXgjmWmm4f2ro2mtk+uuzpsG05uArjRvUoMR2iSbi018Gozy48pwVjm1Cr4GCa1uqiJCQ0Yy9zIfobInLVoQsAe71w9v+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TzK/WDQ9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28a6cef709so397444866b.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710146151; x=1710750951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNJWRAN4cCOb64u9AcoLemre2HbuWSRCjfIID/gyouU=;
        b=TzK/WDQ9lb1iyG3hUGvL0RMEReBXLHZAng3NzaX8XvS221HhR5LXFCOx1JUdgq0G7J
         aVtxUJS/Lt2aMchpcdAYDJb1YAPN6629+1QA+0wymvcmNLsbuWXsmSQaeOdazUPbUemK
         gl6y+t2iT1lI1TKYVF3781liYRJhbSFRqz2xIJbfZJIX+VwrPFEVExduSmWEiQP6VtZa
         H16si31LrYLfyczCgqEiFQ46+UUKL70fEoA7KXfb++9Kz8w3QW+fic7zfQExtZDRDIT6
         VZBA/oHGlnoS0xz+Di1S/myA2fKUTYkaG+d1izzQRC/39cp/6zQa4+zkrFXze5a7oQwR
         MFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710146151; x=1710750951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNJWRAN4cCOb64u9AcoLemre2HbuWSRCjfIID/gyouU=;
        b=cbJzgaeJ9cB2Hsvq7s7FmJQ8gmOJouV4U381NekwjEhhsTzU0KnOYos1tb8SSKQFIg
         /X82/K4RqxeHMll4nRPojCpXjzytbSDpkI1GSDw0W01m4+BIdZ7PQq5wwwnIAYC39eYt
         GZBtAAc1yS+pdVJrlOfc8ZM4CiwpLeLYxpho84sCCWA82krUowGRbz1bUR7T4gYgg6bF
         kEFsP/sIcngBDGZUwKrbkBCdH0qTnGig92iDeqEwFgX8VwGjsyYMLgWYMP4uK6p6YPTC
         Z5/sGL7/Un5ae4dJ78XEUxYOUQsSTJ/BbBdWVWpESE1jaeE/LQ+p4t9GRqv2kWKuDGf5
         swmQ==
X-Gm-Message-State: AOJu0Ywx43SrmbV2Z/Xwm9gqw0MQAWy4kmwskTvG2u6DUV0bIDq7tROd
	ABOlrUKzb+RfkN5X5r81PDe3qxRx2ZnK9NCdY5sdBJmb/S/QtaiSgOh0eR8mrxw=
X-Google-Smtp-Source: AGHT+IE0SO0siLf2TgHLcj5FASMGfyQDSyNHHEE/oWBbizC5kmCNRRE/JvnCTR12hs1C9j5TfWUFuQ==
X-Received: by 2002:a17:906:bce5:b0:a45:f33a:138f with SMTP id op5-20020a170906bce500b00a45f33a138fmr3049105ejb.42.1710146151512;
        Mon, 11 Mar 2024 01:35:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906701100b00a46372f6c69sm38211ejj.190.2024.03.11.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:35:51 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:35:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
	kuba@kernel.org
Subject: Re: [PATCH v2 net-next] devlink: Add comments to use netlink gen tool
Message-ID: <Ze7CZCMpzYH70lsH@nanopsycho>
References: <20240310145503.32721-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310145503.32721-1-witu@nvidia.com>

Sun, Mar 10, 2024 at 03:55:03PM CET, witu@nvidia.com wrote:
>Add the comment to remind people not to manually modify
>the net/devlink/netlink_gen.c, but to use tools/net/ynl/ynl-regen.sh
>to generate it.
>
>Signed-off-by: William Tu <witu@nvidia.com>
>Suggested-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

