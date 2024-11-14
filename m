Return-Path: <netdev+bounces-145037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369389C92D8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98769B2A7E5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F7C19AD70;
	Thu, 14 Nov 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcyif674"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA519DF98
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614567; cv=none; b=PnWsoNcUlVknnJB60kAaT4FPsiV8QeYugGdufEnfc7Q5Jm4+EggUiJc0KSF8Ly2H6x9XDvGEsanAi6Kl+N9JToOZdTMjfBSINNshBQz2AgJjv7Vo4pCuHWAF2h4UsRTMqVsxOvowdxtpgY0ObP8R6xD/vjMCFhiszfRuGjYxjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614567; c=relaxed/simple;
	bh=nayak+SOE4ZZN65IJFgHEHo2eiTS+WCI9mC7TqzkdTI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T3633rYAtrHxn5QrxOMvlkW484WD2OufzF+ERY67qn5dzazNGFqetYmICUwnwfGqGKcsREQbIuJhcKm/xQtzNV8IsEXhDUDm2jo3uWD+9270aBxCqrTaWHtB4mTwNSnTHJvH+oFAWeUZTJgvJSd8kXyFTIe3TFXSZR+ibFJWY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcyif674; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609967ab7eso6673161cf.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731614565; x=1732219365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVNe2DpIiHN1v4twNpYtaUE1vUafTROYAdwFrE6MWV0=;
        b=Tcyif674eBIvatO0EvJTrQNOlAep7/1bDFlsLnrUprz40/SdfIiVNABLxse0ZCpRWQ
         xVvmD9FA7S7hjicOPq4SyITpJx10Ac6yF8tdyLvFYv9sUOGigz4U/3+/RmdgSYIfkK73
         oA0xgWTYIFrD59E7sqw1mLM+cQeepNSroAPQntT9dBxW2RyQHcV0nxtWHfC3V+OsRuGB
         c3sl1o4BdtV915frCNayIWQ2VEkqXS++KaNpbduY8yrcBSJSEXcbEOpm3VEF4/6qpPfb
         z4TVqnwYrrdTYMEP/+vlVisGR7xf7uUXyAXZZKz7h8tVMR6hkU5RRnXuFQeK3I/KXs5l
         B5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614565; x=1732219365;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVNe2DpIiHN1v4twNpYtaUE1vUafTROYAdwFrE6MWV0=;
        b=c/sA0sgjiGQZVa7M7Cpf91cbpSZFAMXQo+6ZBinoqI50Szw4zlxpWI4qGgmQTgWfmA
         /MFG3c7g3aZba9iBikqt4lZj3CkNDyHTbqEjJuE8iDGWjWSMXPqeBpqsOHIhUOjDA8Nm
         pi1ewRO9SuuOwk1YzvbZMl5vNcg+DI59sNEccxsXKXZUDqu5wlxlkrNpwbdaMoxhcThv
         zJaeBLDxbyrRB7fD9FlXCtnMs2JQfb3AbSzKTE6Y+8fullGo2vDerOE+whmv/fpy2MUT
         gVfTHinCkWFrxQWC9ai99M8amRem35fJ2ijs4AY7KJUvCRGyfzdQ05YOmSHeeE5iQlsX
         +mvA==
X-Gm-Message-State: AOJu0YxsOxY+oWHnFr2C416tByyyJcqQLX9QGgG++lQBo4UqwDFmNOoL
	h7LCcvogcKlJSu4VfxIr/jEQeDqBOjvJL7vxIxH16kdaImrsOIAG
X-Google-Smtp-Source: AGHT+IG9bxyt7ErkfkNfDEzAwuPjc4JzCLxRS7ORECzqpDavPzT2PdQ5aMUf0hCoM9uj197qSfSV6Q==
X-Received: by 2002:a05:622a:1313:b0:458:4fe5:b307 with SMTP id d75a77b69052e-46363df418bmr1210541cf.10.1731614563845;
        Thu, 14 Nov 2024 12:02:43 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa323f1sm9908971cf.50.2024.11.14.12.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:02:43 -0800 (PST)
Date: Thu, 14 Nov 2024 15:02:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67365762d1bce_3379ce29454@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-4-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-4-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 03/10] idpf: move virtchnl structures to the
 header file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Move virtchnl strucutres to the header file to expose them for the PTP
> virtchnl file.

Minor: s/strucutres/structures
 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

