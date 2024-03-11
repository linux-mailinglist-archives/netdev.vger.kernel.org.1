Return-Path: <netdev+bounces-79228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973187856F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7E1C21B51
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767605026D;
	Mon, 11 Mar 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0My09AC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB218482CD
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174326; cv=none; b=lvcAO/n3KV891QvQJYg8LRA9tAslzUBeSefY2tPAzzS8XXDmgt6ksuKJNpas4gCYhzjsa5wtlD6t3J8hZOljXMJu6qsIwe3/3vwkpITuYr28gpslNH9BrRFicQi7DRfm1kTVgkc9i4jn6OoTqNghrkOjHVz0WTYDJ5VQMY+925c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174326; c=relaxed/simple;
	bh=dJWkmypYxkUrxtDh4mU/HvfLQq9gwxJG6YLtL1w4yHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McUX9u4NGha9R/odJx+e41ErGPTGeXFr1Gs5w6FXkaEW5B8/VO1Pd5JtnBG3hvnY2sEkl7h1zFDvfbnuT3DVPDJbWh4yPL8+uxZDr11jAL0nw98Sh/1fSSRbDGOBuuc6taEWtUlxkg2H/OMTey/87vG3223H/5Buc3q8Ax9MPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0My09AC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710174323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dJWkmypYxkUrxtDh4mU/HvfLQq9gwxJG6YLtL1w4yHE=;
	b=A0My09AClILXspEJcZxfw8qyI52Wc+cVGK9+RNLpswoks22bs+RT7IbjTonw1RcbVeRe7d
	RjggPS0TeXDnNGUU0V5pYgNZciAJVTABuBlSr2OkOcCpES88DavCrQBg8BuXMCk+X71m9B
	FQG9gxvRmil7KAFHZuNKUoOLWPnP/AU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-m9dVknJCPB2thA8rjnXsuQ-1; Mon, 11 Mar 2024 12:25:06 -0400
X-MC-Unique: m9dVknJCPB2thA8rjnXsuQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e9dda181cso189099f8f.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174305; x=1710779105;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJWkmypYxkUrxtDh4mU/HvfLQq9gwxJG6YLtL1w4yHE=;
        b=kJ+OK4InpN09LmCMEmugsiuDeUPuEyKfjHucdbYMdSXYNXw5esJofdXqKKntjh/IEZ
         aYiIO8HQg4rMtnM5Q/d318nNqLajKWPplNuWemrjXl/pHL/R9rzfeBFRFuEnMO820iAW
         nJOHh+RWRTWSJNSdeUfFO3T+mqUK9uvMXj3wLmJf29UqNwpDok9vQRWZ1VMvc9Qv1pUC
         y1ebvRnkxtVuFcZbVuv0qhcA7xrcp/20V8IROGjf9imw83EtwcBFcM4RZW791UEoLgir
         jav8cN34MVLK3LK9COUI4W5YCmu3DNHWZzYF5xxQwH9D7YEUO0wMrPWlFyQXlDBBsjkb
         4FLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMjOmqFDVfBtqn1GvkRdTm6dUeOnwtz9PIHrwX2L7md05pgQitQXqVficK2aw0RCaVRZ8AvoKlGfOxM7ag7mVd6mJ03Em+
X-Gm-Message-State: AOJu0YxjonFq18ovO3gezry5ktM2MHQyKUtS81fF+8ei+WX6bE1jFdYq
	mW1hhct7kBEPTGYPLGR8Strj/SEHZptLl8dlzSVoJLASzQ05WRB05Tf+/FWQwJsEsqkuQUmlc+J
	Z4L0XfusltuBiEcpKkh1c4bysLyo7+B4zJzfoVXa2i66t5WffKNuQTgdkfgwGEw==
X-Received: by 2002:a05:600c:3b9a:b0:413:7c2:6639 with SMTP id n26-20020a05600c3b9a00b0041307c26639mr5245071wms.4.1710174305393;
        Mon, 11 Mar 2024 09:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYnxPQiZ2Z2scu9tULnpC8iKx1eNg6hUGLJMAMO5ktPPmdI3ai948mG/Zf88c7eQ/YRyxJ5w==
X-Received: by 2002:a05:600c:3b9a:b0:413:7c2:6639 with SMTP id n26-20020a05600c3b9a00b0041307c26639mr5245057wms.4.1710174304960;
        Mon, 11 Mar 2024 09:25:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-208.dyn.eolo.it. [146.241.232.208])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm16204743wmp.46.2024.03.11.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:25:04 -0700 (PDT)
Message-ID: <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, David Miller
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Date: Mon, 11 Mar 2024 17:25:03 +0100
In-Reply-To: <20240306100438.3953516-3-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
	 <20240306100438.3953516-3-steffen.klassert@secunet.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> In addition to citied commit in Fixes line, allow UDP encapsulation in
> TX path too.
>=20
> Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload m=
ode")
> CC: Steffen Klassert <steffen.klassert@secunet.com>
> Reported-by: Mike Yu <yumike@google.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

This is causing self-test failures:

https://netdev.bots.linux.dev/flakes.html?tn-needle=3Dpmtu-sh

reverting this change locally resolves the issue.

@Leon, @Steffen: could you please have a look?

Thanks!

Paolo


