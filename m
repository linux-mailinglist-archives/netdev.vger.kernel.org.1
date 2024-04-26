Return-Path: <netdev+bounces-91676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651458B368D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC911F22C39
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A72144D24;
	Fri, 26 Apr 2024 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BGAR/sjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBF1448DA
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131305; cv=none; b=plOAuDtUCWv5sFt676bEhJVys1BlxwexAxkwGlKv13TUJeuxutsSjsVPSaWFWPlWX+sLKGMxZMS2mgeZ6twKFXSGtEwhQsTXL8jHdnzsCzHCqbGMDzqA9d0fxN5b4zjZKUANv1kS11TbHJFKZDvEZJ6ueSM03SD8OPFmpMCbjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131305; c=relaxed/simple;
	bh=BhBGtJSejw4iIbF5/P7kNMzBBdbfrmREM7nc8ro0Sbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEVtHkYutyvB8NmPVkXPBWWQ/4AUDxGUL5lcnad+f50HcZ5W6v5VZ7FlSPypkov8AwBjfb4hgNYS4IqBTZjotUAUE4zMaQldB12BHCfelqj/QwNRbZtKNq/US1dLsc0aMOwz6BeB8OE2ZnzF4M+XWboIw2+gB/TbLnGip6FZ+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BGAR/sjS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so5403997a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714131302; x=1714736102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhBGtJSejw4iIbF5/P7kNMzBBdbfrmREM7nc8ro0Sbc=;
        b=BGAR/sjSdYR3n1+37BuyaCF9f99JIlkBGgpwXGBxUoSXM7ipX8kmj+ZKLGzlvgoIM1
         C/osL6msVzqsLYUyfna4ggF0MWfO19a1Y+H1MSGVlt414LXuB7jp7SBUcZzZi9lMolSI
         OLpJfyo70JBREAY9wTFvXtJnRdLMzzZ+/2sMekn1Nut6ruBClWnIsOdW7vkj39kDlQQu
         JBX111sB703e5lpJzMSMm9QwAEJEQuSA2JkRNTxu6mlG6WosMcqJKbey9AfmqWfhvqv9
         uafJRjwoY9Oua0VCDPV0KLCMNaZvzjfs1Js/R+EVMeCVKqE84tPhUtaOJSJJwFFppVAF
         XYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714131302; x=1714736102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhBGtJSejw4iIbF5/P7kNMzBBdbfrmREM7nc8ro0Sbc=;
        b=QEhd088tvtPh9JCYWI/2aa+yOr0Q4+L5mtD8C58KzDv0niWiL6k7mZHs5CYe/QDKiH
         c8qTMNWZ05LQHw4jx5ia4dl+KWUZQSckF8LSqrtv55ygVOK3kGrxgCm8o3sm2Hgzki1g
         JyFFqJX7rxSNNgqUkPGQ+0XdbCCGft+n8aiJLqSXNqeVqwMVyIYF+/5RRRyCcxM+ErRN
         VRqalrjJWu8dWlZOsQkGrzT0+A36MCV0hRil6gq99mLvpNW/oeciG3Q/RpzrZn9+rRmO
         M2ehrpdOeGhO1FiYfp3eadYKLTm608UtQecHR0h8LDzy59hraiNe4eAogOGkqAtD3hWa
         4vWg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ghlVXR9mAPYwIMdQXMgT8Q/E5ZuaxS2TsMLon6m+qIMCt7BiiZCAwFSdcv5RXMALnywniVPdz3MNHAsf1vvwB3Wio8OM
X-Gm-Message-State: AOJu0YzBJy69I2JbthbcK9pg3Saqa9fhrIItkjakUBhDGNGRn8qCdLVD
	UZCYJOI5LhtqNdRJk40t0rceGUX+h8GM9TCgYGuzE/18tWm/y36EdMyfum0Ihbk=
X-Google-Smtp-Source: AGHT+IEnQFk7M+ytVNHjghewcWthREzizwV5s4bNdYx9JJ5/eSPrGZues6cCNIxVT8D5Z7b+ulwEmw==
X-Received: by 2002:a50:99d4:0:b0:572:5122:4845 with SMTP id n20-20020a5099d4000000b0057251224845mr2095552edb.4.1714131301562;
        Fri, 26 Apr 2024 04:35:01 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b005721127eefbsm5113539eds.17.2024.04.26.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:35:01 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:34:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: give more chances to rcu in
 netdev_wait_allrefs_any()
Message-ID: <ZiuRYxOo0nsVY3bm@nanopsycho>
References: <20240426064222.1152209-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426064222.1152209-1-edumazet@google.com>

Fri, Apr 26, 2024 at 08:42:22AM CEST, edumazet@google.com wrote:
>This came while reviewing commit c4e86b4363ac ("net: add two more
>call_rcu_hurry()").
>
>Paolo asked if adding one synchronize_rcu() would help.
>
>While synchronize_rcu() does not help, making sure to call
>rcu_barrier() before msleep(wait) is definitely helping
>to make sure lazy call_rcu() are completed.
>
>Instead of waiting ~100 seconds in my tests, the ref_tracker
>splats occurs one time only, and netdev_wait_allrefs_any()
>latency is reduced to the strict minimum.
>
>Ideally we should audit our call_rcu() users to make sure
>no refcount (or cascading call_rcu()) is held too long,
>because rcu_barrier() is quite expensive.
>
>Fixes: 0e4be9e57e8c ("net: use exponential backoff in netdev_wait_allrefs")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Link: https://lore.kernel.org/all/28bbf698-befb-42f6-b561-851c67f464aa@kernel.org/T/#m76d73ed6b03cd930778ac4d20a777f22a08d6824

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

