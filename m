Return-Path: <netdev+bounces-206210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77EB0223E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C71890EE8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF61C3C11;
	Fri, 11 Jul 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEn/GqiT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6880B
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253029; cv=none; b=Kqwkd1/+2ZnS4DpxG3PI4gh+bU2jVTw2X+0eKcxFCxTtwOO7EnhucpuMVowaXcDH6kKjaBK1Ovyca9jqxA1d5Hz4Y1VqlHg19ie5l3BhShyfgUR0dIpZ0Owsc46r0F4/szq2sAKp8ZLr9AAF0JhI7dsyQD2oZGVQHOhtnn72vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253029; c=relaxed/simple;
	bh=x0B+xhY/WkBE05K9XH/O9rKO2iyspIr91l70RgVZnxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdl8zbRwDue5Aair5JzIKM4RL3BpUc+jty6CkcTW9N1QNc5gSq3Uh106urE3mmw3OigbzVohydrSmk7NlsQ4GuSGA9pXiujcRGYKzRF+OfCbpgmylVSmpOF5vj0rwcGzTcl91BW0Kp1Kc+h73N+PWAs9AEf9DtAhL/2JwwMuwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEn/GqiT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752253023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6VL54YoUVVLuHJIHavTtt5H7A1OFBfCmV9B/XZE29E=;
	b=QEn/GqiTHNjCJBxuxmHG5dQVZwtHHRjRzAKJsT/kzMeOhpEq/Mrf80WV7c7NiN7/zf+92R
	BQCZC0TZt7IZUyb/2C6fY2qSDuhh3aa6yDqFvHQJxLA0zo5YR0298gwQUf2RT48sT1PpWa
	9xWUvKiMT354FjHP6NIAMXY4RfEiwxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-HYbynhMvPWuORABIJlMrEg-1; Fri, 11 Jul 2025 12:57:01 -0400
X-MC-Unique: HYbynhMvPWuORABIJlMrEg-1
X-Mimecast-MFC-AGG-ID: HYbynhMvPWuORABIJlMrEg_1752253020
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so1316923f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 09:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253020; x=1752857820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6VL54YoUVVLuHJIHavTtt5H7A1OFBfCmV9B/XZE29E=;
        b=RZK/JY6OlLX2HlJM/ZIC2Z2IlvcotcSdblQuagr9UFhwOzcEJQk0MlNiAzIXwtPckq
         iqSoNYgADLYNSG1Mywv0IaryaM07sYEqJ5LDppJe3aAZX2jw4F4Xf7o0x8sksHjrgWjL
         /NhtE+LVOlcDdL5J1w4wv/wvfpgJ0kCFcZQuhsy40sRUedXBaia0PpKdONBoEidH3Ap6
         RUDee8v4gLrrSjB3ERxdDZN3Feg6jXxqPWb74QyOTKdj1j39/I/pZslLG235h8Hc+L4k
         pVnRbm3GGaShARQkhxVwCozLoGtNiAC8NX4Dv6QtDYCo1pErV9UjtxWxJdZg2AAYNJ+d
         UIcw==
X-Forwarded-Encrypted: i=1; AJvYcCXswYOiyPeuiHEjNhqZ0PkIzIwkjAvFucxZE+FAggqcEO2eyQuCARGat9NizgEZMU2BMtfbjmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9BwX3lybiVJ77uUhF0DOSjwKYc3E+ClpDohPDbl+LhiH/ij+
	FCD2cvdAjX5jGeq36oJXI7luRbU++xMt+vx6vwuVHjgQ0dIJ4zdocxET2eyjOOI4eXE3Vtz4/Tl
	ENrEuN2G6iwJB+FyK2mL4rL06cbfbgxAB6GFsRFMilWRt+EkyRcmLYiE7Mw==
X-Gm-Gg: ASbGncsn4ReWdn/Vs1+EJj3PnnHfL7qGBV8yLPX5RVTsqiD/pAIjILfRh4jDLsPl03W
	InSRBv9PKOcV5ljEl6Zq/wNTViJLVhNnWo0WAR5ZknEP7yE7MlRpw8bvPMloJ29iuH7kZOlgwC3
	WP2Vvdfshgr5R8guClmkY0GfCx+kXxUDAmO9n4/yfV6GEbtRjjWhpAvPOt8VzS08lLByqR3IkOR
	X21TPvJSod0KWSd4fsyHCOEDN5bpUNmpx1EkjJpPtkazow7ANfNddOAwRMOaHl7a03x+HUxhTa/
	GGm82QO7f+MdVxelT4G40Gkptdg=
X-Received: by 2002:a05:6000:2a11:b0:3b2:e07f:757 with SMTP id ffacd0b85a97d-3b5f187d160mr3004830f8f.1.1752253020411;
        Fri, 11 Jul 2025 09:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCrBnRFr1ZmqAeyXCDCydZ4xCXzFV1FbtQWpvf8ekuxmwi4isRralV5IiBRiXVhlXfm0tw4g==
X-Received: by 2002:a05:6000:2a11:b0:3b2:e07f:757 with SMTP id ffacd0b85a97d-3b5f187d160mr3004808f8f.1.1752253020074;
        Fri, 11 Jul 2025 09:57:00 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9298sm4933180f8f.44.2025.07.11.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:56:59 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:56:56 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Aiden Yang <ling@moedove.com>,
	Gary Guo <gary@kernel.org>
Subject: Re: [PATCH net 2/2] selftests: Add IPv6 multicast route generation
 tests for GRE devices.
Message-ID: <aHFCWDnQkpMMn7Lv@debian>
References: <cover.1752070620.git.gnault@redhat.com>
 <65a89583bde3bf866a1922c2e5158e4d72c520e2.1752070620.git.gnault@redhat.com>
 <aG-lAN-qXs94BgWl@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG-lAN-qXs94BgWl@shredder>

On Thu, Jul 10, 2025 at 02:33:20PM +0300, Ido Schimmel wrote:
> On Wed, Jul 09, 2025 at 04:30:17PM +0200, Guillaume Nault wrote:
> > The previous patch fixes a bug that prevented the creation of the
> > default IPv6 multicast route (ff00::/8) for some GRE devices. Now let's
> > extend the GRE IPv6 selftests to cover this case.
> > 
> > Also, rename check_ipv6_ll_addr() to check_ipv6_device_config() and
> > adapt comments and script output to take into account the fact that
> > we're not limitted to link-local address generation.
> 
> In case you have v2: s/limitted/limited/

Forgot to run the spell-checker, sorry.
Anyway, it seems Jakub fixed it while merging.
Thank you both!

> > 
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 


