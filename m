Return-Path: <netdev+bounces-229366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B1BDB3C9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472243BED44
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C0306B02;
	Tue, 14 Oct 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6J0Klkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85B30649C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473292; cv=none; b=rCjNHbARpjCMngh89Bd4yIxPlHhwZguolod9knTsMBginSF/w4HlJ8inadGbyobBUMukhYQrQy6IxU+yeY634VsYyAYnUIkb4uBdJIfB6oXtWpfINLX7Q52JboGv7tF5h+mVA+wN7szpDAeHPNVVdwXSdXtJzFklXtDyWoqcUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473292; c=relaxed/simple;
	bh=sGslfGcS1WTOAxh3VGsce9A+i02zHKcOz9kv9uZ8VA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8P3HU8hrbSmDlWPWaFirRmFwisyJsDpT7eiBziC1wAPweS9MiLdNCqAC12k58sYIND/rZ+vJ6y5+KCfFSK8yP+04oAUKTM2TjbE+50SJc03l9EgWEf/wqHx7rRUu3DbjkAbdY8UFFMIzm+YFq9EmqGUair98Taw/I1aHCXoI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6J0Klkn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e44310dbeso6541215e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473288; x=1761078088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+iQxMhxf3KTuC5cfF4X7qeWhAMoIsr4rci9ih9ZP2k=;
        b=Q6J0KlknoRrk4pn8ybJs7DaukobHkINq8tM8qHIFahdboCkAGDL30Wf6UmzgeOrkyO
         /KMhxTBpDUHr7aKzYEafc0kKHMXvV1D7cpVezsLbEsDJC6C+gURLN2Wl3/1JDSsuqiMK
         5TyXnclDVUZWwoHsbrfN/vVD0D0vm/jwjdYqh4M86pMKfd7XQD1fTdKW+gGjZolwj2Js
         A9q+N+OG0Ke6sf6Y0pOb+DEXf4QSUiPHyfMmOPzHhi7dPZFN9ydnfp4mgvNStwxwOTXX
         e8+0tOiXxat+xBHjGvlZ0v9oDzjjGjdyI9k60AYOmzludpxHLwXkBdi43XdtPeevXFie
         J+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473288; x=1761078088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+iQxMhxf3KTuC5cfF4X7qeWhAMoIsr4rci9ih9ZP2k=;
        b=Mj6VKcvlpkfUwOO2ah31AgDYIbvQcQVLuiSI9dOawnmV5cGOiHHyKcRR124mxoJuz7
         o1KEjYzun0Pt0fOiaDdi9VHf/XwHl7Ebeoc5WivwjNMY/agPStTbzupleLactNWRkESr
         rod2l8Adbm2WT34kGUwrE6BCuC+jAZX1lI+eyS7ZWPofvGEajmi0/Mq+Nd3Fg2Ab97EG
         lKj/KUO7piLvxnOZ22G/whpfoC+hGSNmZvQZnPmVuW8+EMe9wUxgBJdhqudMZXfHvlwe
         +BZ5ddfKcxJMj5ffLDpgIYaA3tzZZ8J/YlV9+0jHInBwfmI9UJwiESme3WqsxnoBoUdv
         YNhw==
X-Forwarded-Encrypted: i=1; AJvYcCXwBz7wqobFStggWvZ2fVv7wNjiFGcrTZkNUWiQeq/GsmMKRlu+6IMnHdvfZgx0zGPs0ddw+AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIG9PEJV9wD9Ynfvi4QDzliCW0EsRNuSJciJeGGSFHT2pQA/g8
	6mV6PzLJyHg3rjP3cqQG43sIvb58yMGmIGfifWWmOG0SQIjx3cUAq2sz
X-Gm-Gg: ASbGncssawmcHhgYy76bPnyi7UORy8d4qEg5wJDOdLtNnM5d4khdBBhxaAaONMxCrzb
	aU13lxTxV+rF9ls0omKtMSVOr0PeqeHv1TaxF8VS5EQU4aosNeMLnPMrsf+kYhumF3FXWrF35p3
	X9GFgc71oHduynbn4RpR8EHBnZLC0KndxcO4SHhLfauwmTYJi4QdSdJM5iComGFHQ9dz3hJ1xdz
	4Rqkvu6jmJFfzow739l+3sRDJQtCo/ivCrdCi1p1DIsPMtkubbNCj1D0Ar7ZL+GAdHZ/mTocowb
	EhfLepYIGkZkQL8G6+ahGQ5PDujyEPV4CwbXEz1LLsLExzm9eV990nxWSUIjf0mo7hT+MOYE7JX
	nPxuD+FcmlylRCWI4uYPgGMQlsBRrE6EPFA==
X-Google-Smtp-Source: AGHT+IGVXsN12LL6zIzUriOIRUUIRdjw8rYNtubtuh4fULjqJ2hKOcLK1N7+iwDggpPOmnu4aKu4cw==
X-Received: by 2002:a05:600c:4452:b0:46b:938b:6897 with SMTP id 5b1f17b1804b1-470fc9f0bf4mr2120705e9.1.1760473287765;
        Tue, 14 Oct 2025 13:21:27 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:eb00:dc9d:6aef:3136:d6c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm25958870f8f.23.2025.10.14.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:21:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:21:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: b53: implement port isolation support
Message-ID: <20251014202124.wrlh773j6aebr4vm@skbuf>
References: <20251013152834.100169-1-jonas.gorski@gmail.com>
 <20251013152834.100169-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013152834.100169-1-jonas.gorski@gmail.com>
 <20251013152834.100169-1-jonas.gorski@gmail.com>

On Mon, Oct 13, 2025 at 05:28:34PM +0200, Jonas Gorski wrote:
> Implement port isolation support via the Protected Ports register.
> 
> Protected ports can only communicate with unprotected ports, but not
> with each other, matching the expected behaviour of isolated ports.
> 
> Tested on BCM963268BU.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

