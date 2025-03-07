Return-Path: <netdev+bounces-173085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F1A571F6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6C63B1E0A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D92505C4;
	Fri,  7 Mar 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/E9QqaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21D1A3035;
	Fri,  7 Mar 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376165; cv=none; b=IPsA2JzA9UBdtS7zEKOvtqkzpw52X6aU5aOSUP0T2AXqG4p4bN2/wuhfZwS3xNbjvyRVKbrEqjbK9negmk9DGxbR15o9i2HiCbG4iYUWb0EpX326oHZgS5onLX5ITLlsV84Qi5K99K2rK47aqgQZjhgUxIBgBA0/DIWKBnETfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376165; c=relaxed/simple;
	bh=O4Cy3plUEx1owUV2IdUvQDVJIkZYqF7SgHkzIccAc4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORxEl9Jh94F1w5tOWYy8g5/qCMBUZMavrhakCPwu7UqQ85vIhtk6W1ZUJs/IIRNrKk6ZQ1hTWzYgIzIC3FmbQ34b2xvoCV3Q3YTxBrTJeAcOvEEejwoXBdnW4nAmB9NgeFZlIQ9fqy6Bbc22wsL2fBeVLOR733Ps/ozWlHWDHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/E9QqaD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso64257165ad.1;
        Fri, 07 Mar 2025 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376164; x=1741980964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqVBMNCxxGVEk6sR8D/QOn7k/zcZrAplEQuyRo58dkw=;
        b=S/E9QqaDJZv/Ed6zVUfjs9uZADmfqk/3FFb30Mj5ihRwarSq9f6EHO9CAVdXFXgi0O
         /qoJPPMhBVR+v1uage5CrWJdudNxguNc3ahMAapQ5K9KzoQM1DSrjn11tNsRtC9ATZQR
         6g7czfuhQfwaZ+f4MgCGLSX6Odm6nguR42hfAx0uLCvSmBn87uHI78WIHByerSFcplbR
         THAisqfvlUsdc7LlygOj7yTbutjGtNzM4OkcXjew9FGlUIXWJhBKFCasD2SLto70Zp1+
         VIbJ9jfT4WLeE73xvyTApnMRLaSTw/6F4+sqUKnhW3QhqL3VtK+JVF4DfuW6Us/1KGbS
         x3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376164; x=1741980964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqVBMNCxxGVEk6sR8D/QOn7k/zcZrAplEQuyRo58dkw=;
        b=GTldb0Twrc3D8lDmNSJteFiEQLf0LfZUkulcmMm4qdDwJHjZP7TStQ9oTmgUqMalWy
         yXasop04VbiIEIfBi5d7bKo6hR1e+sjeRbVhwbLIJa3QlQIjI0xmLLwhGCtr0lhQmM0b
         kFnOwWVtip5PEagA8m4NOAYR2poxx/QZbp1zlzEQ1UDoJF6p2hpRZbNx5fFhLdckhicQ
         GsFMRcw97SoYREjJsxyd48zOd5Ax5O+2WtiqPbbD1oxeAryYk/cXqbPjE0NdzzIrFUHv
         WH37yluCFqNnHmQK0ag6rK5wleCWmihAwRLUo8BmlaANJwRUiq2gKhGfgOTcLdDCe0DM
         AoBA==
X-Forwarded-Encrypted: i=1; AJvYcCUWktbEuBBjWTkmtf3rDNhPDkq/QFBW9u+jOAEVADZ0sLCZZzxwmnlHXCBMYIema3WNvn2CDZJZvS9s6Dc=@vger.kernel.org, AJvYcCUiKPtdHyyMTHQHR1g9w/TCMnTg9cSFNenbP6sEf0zTLBUzvB81ilEL85Q2THhxv05JV8RoTywH@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQ05bWiCBNT9CDyvG1R4FkgS5Qyh88/NGKLmaq/wEmlykKj89
	De0np6mGKHS8dIbo46yksJ+Rpccs301SmDM6RetFBwkpUxKLKho=
X-Gm-Gg: ASbGncuFQPbb/vwFjr1j8t+MzW5Hgbzz0uXX1alGWzp8msnTg9jpGwzUAsItNh9q4iI
	U6+RPa3/YCxB5epEeZLkvGyU1vGMxGE2Oz2O82wKKgx2+bp4q2qr+edFtyejOFzkHp8IT6EK0vO
	D1bpi6u0Sg9lkriaKV1DcohTbQNvc36wpYfvP8kzfgIDnT/hWU9jKena8GVj5EsgybamZaKOJfh
	ibJVMJT6RsGR71l+purqdzs7tVQGjE+Ffg7JxuDPPzR2sOsKa+PujhWXotW/S4OV0lYvVVs7JuZ
	m6pjMpI/wZkRovKbxDvhf5bL9cz5bFPFnN8WqcHmJxni
X-Google-Smtp-Source: AGHT+IF8Z6ywAtUlNbBl/EYS6h86wFrWpOxNWdHELGMiYtRo+h9v2ei5daG4LLs9xaMsRem6wYxaIQ==
X-Received: by 2002:a17:90b:2711:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-2ffa737d18bmr1308763a91.0.1741376162201;
        Fri, 07 Mar 2025 11:36:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff693e7358sm3428428a91.30.2025.03.07.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:36:01 -0800 (PST)
Date: Fri, 7 Mar 2025 11:36:01 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 2/4] net: protect net_devmem_dmabuf_bindings
 by new net_devmem_bindings_mutex
Message-ID: <Z8tKob3Y4y_GsWc1@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307155725.219009-3-sdf@fomichev.me>
 <20250307094959.1df7c914@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307094959.1df7c914@kernel.org>

On 03/07, Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 07:57:23 -0800 Stanislav Fomichev wrote:
> > In the process of making queue management API rtnl_lock-less, we
> > need a separate lock to protect xa that keeps a global list of bindings.
> > 
> > Also change the ordering of 'posting' binding to
> > net_devmem_dmabuf_bindings: xa_alloc is done after binding is fully
> > initialized (so xa_load lookups fully instantiated bindings) and
> > xa_erase is done as a first step during unbind.
> 
> You're just wrapping the calls to xarray here, is there a plan to use
> this new lock for other things? xarray has a built in spin lock, we
> don't have to protect it.

Oh, that is true, I completely missed that. In this case I can drop this
patch, thanks!

