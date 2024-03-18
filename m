Return-Path: <netdev+bounces-80470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D753787EF2B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A2C286974
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173F55C2B;
	Mon, 18 Mar 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjRLZC5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240055C18
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784169; cv=none; b=crAoANe2TO1GU4RPBOa4BVzHEnzIycc7ooXcseWN/uQtT3fStFLQ9fq3iN/OBSgOIIvA9NHMQxji/gr4plV5TAOM1t/SAL6NgXRi81kD2yqaSEPQHFU5vpzbj63fK0I5zgSSR8TxkJ+ljAFxM9V0WphY6VDbP+kP/+J/tkzJHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784169; c=relaxed/simple;
	bh=AYMfYRY6klCQYJM0bVnZCDDZuEIucFRaAGMVi5tuFig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyCjKaayu8Q6K7e6jbLbjOdZ1XeXlZy8MsWLqNCysfw6RbzQkQEaq0FuwIJAMJ/xR08x1xtIvwvcr6CNV6B2I5v0gZWFbIcCjhtitvsp80ZUSIyoz+S9J30JRWDgYCM+xStoxmj3YNaoFONQhNU7dnqmMbmIpj3yjEu7u48vBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bjRLZC5A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1df01161b39so20869715ad.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710784168; x=1711388968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hzHXHAYAO5IILy822dDVSoGujLH1eorSOetYUN+2mo=;
        b=bjRLZC5A/VZvwMZxMp6m++hqN3+TDHrVFJOL8i9Y4qYNXCFVHT/w5eFPJ3MlhWgwC2
         AxObZ2dTh+6MTahoIj8Q++Z7GMoNnS5VDOJtEsriJGwuU3qhDaTnw9iBCX7+heF84yMO
         A7rJK6NzInsVUiegfehtPIsvpPSfzL/zy80Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784168; x=1711388968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hzHXHAYAO5IILy822dDVSoGujLH1eorSOetYUN+2mo=;
        b=oz7kuWCddJwfjPBnqpofx7S9hXovpUT9WwqIeWmquECE+h2GAWfLYWiQjtJH56AZ1I
         2+3j1MVjB6VTfBcy5I2HGrK/EuhvNkRxGl+gkmB7gsiPXFxKWvq/3pzXtc/U7Q0Pq9vr
         CQcaUAIdCCx/+J/eDMsXMkM5Tb+s/C+rvG0/37RqRmkQbVVLw14uFqqN2JVArNm0+pnw
         lyra4pONeyBOb3jhT2dlUTVNJPSB7SbCpb5bJMnd6r0Fr1l4ei3JBkfj496psZvquWdA
         ztOCYVRlCB6j7PzjQXQwUvlvC7aNx5bJVCAgWTSQOFxuyeC0mFUQF1yXG06LbqPxmjcQ
         dkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCnVBhyoUybYUYlFQr1oa4tPdyV4/xK8B5BdA7im90MeEqTsSIze4X+BAsnFW+yaAulFbxW06Jf5zArESTtnL3KRB+xrz
X-Gm-Message-State: AOJu0Yx1oHxFb65WKtK0/nSuY215bsRaViK42fOKE8TCGMko7/ruvq7h
	A/QHATr1f3tS8oV6TuKmc4uOYCSR/qdNmWNb5lWOyphBTBpQVhEZSZ9jBwMNZA==
X-Google-Smtp-Source: AGHT+IHwULWpwHgXCxheCai0yUoIM9O7hU0pUI6uaypY1BpY+L2E5BH3oRPzmgUhLmFFsNz/L9wHkw==
X-Received: by 2002:a17:902:da8c:b0:1df:f9fc:e572 with SMTP id j12-20020a170902da8c00b001dff9fce572mr9150174plx.22.1710784167690;
        Mon, 18 Mar 2024 10:49:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b001dcc8ea6247sm9547206plg.15.2024.03.18.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:49:26 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:49:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Message-ID: <202403181038.EC9DF8CE3C@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
>  include/linux/compiler_types.h              | 11 ++++++++++
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)

Oh, I see the Subject says "kspp-next" -- normally I'd expect things
touch net to go through netdev. I'm fine with this going through either
tree. Perhaps better through netdev since that subsystem has the most
users and may gain more using the new macros?

-Kees

-- 
Kees Cook

