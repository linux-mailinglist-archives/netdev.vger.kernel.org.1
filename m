Return-Path: <netdev+bounces-93367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F18BB4F5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FF1F2415C
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D022F08;
	Fri,  3 May 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD6O8Hin"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F571CD15
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768604; cv=none; b=o+qwJep1Bh2m8NTI3FoFKk3iGHALlfAJ15nfeloNE+mN8cWbY7yh3+1pUW564X3syxQWKv7+momcP8qLt6Wr6fjgX8ukQ/vXVKwrmoGdRmbe4Cy7mx/+chdOOt7/VUVkhYtxBvBfjh4a4isvWqeZcUjE2nvMaydPBS+Qp6PEjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768604; c=relaxed/simple;
	bh=FBZMACvGRXJqMeLEDzDUFBkDEnHe6DAU3slqqPNPaqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAeUXsO3RQ/ShbJDqHbr2J0ykXgzcRcjcBwnQkQxPVUQIbUO8LBLoBKXHyV5nTPylszMdeJYQvEr1viGMGO30C3cV/8tV6T2u1q5nZkIdAmJSF6/QQI1qoSt1d2HF/NUnEB9GK6TRP8D6Hws8VuakGwUYgewayXcp/SpIXfgeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GD6O8Hin; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso1426385e9.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714768601; x=1715373401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOGaco3fXlUM58da9nIuO+b/VVWLgaUOQsvu5003Nmw=;
        b=GD6O8HinHuMJbamq0ke8yQHFLrkso1UKNXelni7YFcwZ4nHMKCTOFHFx+XSo/YwT7e
         rIUmuZNa9lZp16ToKr/BqFDOTVsa1pkFY+jRARlqd+7fBCQ8FaUluobC9FLIK6U9TS3d
         X4aGYYXpy+GDgZVMVfeoA3omLI4MYAXeD8PjzvcLsQjK6INcpdEBwyg6HQg42qsuGYxD
         GhkUfV04sTBhtErjBeY4sVI43bd8hqtpSjDkJwnOm/0fWIC6ssBAgw1vyDw87+h/Yxw3
         tlUffhKU1rMfVz8ULC4hA54CXAXF7p7ybtHEy64U9xE6YcSdpCFtgcRdABGaH+zK6phw
         +TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768601; x=1715373401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOGaco3fXlUM58da9nIuO+b/VVWLgaUOQsvu5003Nmw=;
        b=alLqmmAy+U3oXY2qV/yifN1qgWvUb3Q6BkxD+GmGjEyKZK+LnOCWTT1X/8BAW4OC3s
         R0kbRJGq8KZIojsF++l4ryj1tf0S+otkWeuVvyLlds3VBpD5X2BvonWKLYFJMFuD/Gsu
         ThKZG6M5h+GdevdY1V6e+l6M6hfbdEjDb9pSXJAjbZYzOF5EGNm32zujWr99v7463Oag
         z4tFnUMtPDR2Yb8PPPG4a8qLZSqbN1vmL4Inw9deQa2xaB/Gn6BkxHJx0QMbjnJHZif7
         18o0m3tLnLKjQUVCd+9E0xtP58GngrLMBYysTaVbNK4kO9UvOR1G4pTbnfsFNX53mwgP
         fhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2wppjEumlqsBDFQlw+GzXt/8hB9d20vTD5VdgRvYhALwMx/ev5UcKBbxbiHt4OYjOUPT7+/SOAitarvSdN2XUGbU8myYP
X-Gm-Message-State: AOJu0Yy1rMimScQQTo498cZHy3r9JLQcsVV/X6PdwwDnBrxCqa7IfsDM
	ywCB3HEmcoyAVtdYwEbP0pPvVi7c3gP2iCxA8hRxVeYe9xjhtBtVWGCtVj50URM=
X-Google-Smtp-Source: AGHT+IHT1ANwaQtrF/f0AcbUmuzqU9zPw45kPKXJTTCYO6bMPHHy7X3ECjv7drf3rYFms81bZXcA/g==
X-Received: by 2002:a05:600c:1d26:b0:418:e88b:92c3 with SMTP id l38-20020a05600c1d2600b00418e88b92c3mr3068178wms.2.1714768601152;
        Fri, 03 May 2024 13:36:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0041bf5b9fb93sm6826049wmq.5.2024.05.03.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:36:40 -0700 (PDT)
Date: Fri, 3 May 2024 23:36:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Kellogg-Stedman <lars@oddbit.com>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>

Could you test this diff?

regards,
dan carpenter

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 558e158c98d0..a7f96a4ceff4 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1129,8 +1129,10 @@ static int ax25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/*
 	 * User already set interface with SO_BINDTODEVICE
 	 */
-	if (ax25->ax25_dev != NULL)
+	if (ax25->ax25_dev != NULL) {
+		ax25_dev_hold(ax25->ax25_dev);
 		goto done;
+	}
 
 	if (addr_len > sizeof(struct sockaddr_ax25) && addr->fsa_ax25.sax25_ndigis == 1) {
 		if (ax25cmp(&addr->fsa_digipeater[0], &null_ax25_address) != 0 &&

