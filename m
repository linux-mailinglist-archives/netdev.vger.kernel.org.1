Return-Path: <netdev+bounces-101168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310528FD99C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7612844D2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B915EFA3;
	Wed,  5 Jun 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv1LWY/u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE823C28
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625373; cv=none; b=NYdAPumlbbR/I3g+UUyiI4Gh0EO+8Vx5TIi5zB2mFeV+KVd1UEuDgB+WkXnMam1UjnkRIZHad3Q0H9Ykp0MVB9dn5XY5rom3/uuilk0i7Al27UOLN/Xs0ojBC/3hRJWilcCe/99PodY3NqcJD70nvzfy20/BSu6RAn5XSIwG9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625373; c=relaxed/simple;
	bh=PthjLG2Xlr9BKeZELuB+lxDAHRx/UOooTB7JJsTLDz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSqZxQ9wDL7nhRjAqZtRhh+mMX8+bShEHd/7nJj8jOKDI0ui+UcQansGlCRqRfWxDy7WeZDGV1dgB6w4G+zqCRzTlvqJDJmVLSkgUFUERAzakZeDlGr6kGvzdhT8T9Kib9LpnnwLqeuL6EL9ZLH8FyriYqagpkkcjyQ24xhx+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iv1LWY/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717625370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PthjLG2Xlr9BKeZELuB+lxDAHRx/UOooTB7JJsTLDz8=;
	b=iv1LWY/u9wDRQmb03UAaFBlHMfzzpPBX7ov7SwxyRP/GXpLKx6tHbn2XaB1fC5IJoyx0cL
	IMB5in91vbfer+nJ7l/KIDVRCNZ6IBaBy0oB2Eln830NE+awMwf2xs3UvLV/qEAvoRPsLG
	QelshWd0Rty/6FCOWbaOQ6aGL6XNuDg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-r-8e_kmKN9GBywlF36A3Cw-1; Wed, 05 Jun 2024 18:09:28 -0400
X-MC-Unique: r-8e_kmKN9GBywlF36A3Cw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ae0e0f6be8so2844746d6.3
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 15:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717625368; x=1718230168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PthjLG2Xlr9BKeZELuB+lxDAHRx/UOooTB7JJsTLDz8=;
        b=r5zoaF2LAPWiF9TpdPRJXVBQ/jo5JDK0BRKyKh6IzeFesMIWLjO7Y1T9UQzMTjflF5
         sZbnnkPNN87cDCL/v9hWACcC4VD8+bxj/whJX7TqFdcCSZC0M7sHvqma3aDvtzvp6bor
         nFS2p2z/uJ1eQ013+MIY8cYjlD8VqQnlXwptOkx9V9FmMSmBvZ5pYWLt4KzPbZtctDZY
         /SAcVzI+9W0H72T/P7WSyS2L2FFBWQFHVdzjEIvzfCcsWlTTElYNA5qnTM2nbxzKy60s
         KGrfBlWc5XITHIuQGgEFFUCwXuglf1U7VCUIbjteLtuNS69mqV7Ux/mCNX4IzL94Wzet
         +FmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtM0zouwHsAOBCz6aKeUQNIdO/9fVnN3520KOrL8IRZ0LfoSCQH4KVYqRNVdfBFk9Z2p+TRYIQNMErml6vNe9rZnjvtL7V
X-Gm-Message-State: AOJu0Yw06HAgOJ7Vnk5fGBMZ0IVBZnoF7Gfg1pYecKqpQ9tIxggyQjCE
	fRxaOhVah/4y4RcoRwZu0OJg9iAzYCw3xFtAQiiociiIJB2OFdiiWOFJdmW7K8pq2NRcPuL+pYi
	qg5Y8I/64rR5MhBdA4/e+F44c/xK4X2lVdIL8OPBJpDdZ7jPXePybcQ==
X-Received: by 2002:a05:620a:4111:b0:795:2ce1:2ab with SMTP id af79cd13be357-7952ce10408mr241539585a.23.1717625368063;
        Wed, 05 Jun 2024 15:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF323Ze2tcCLdbDhMPSdXlprBkPVOtA2a9VCBJft88WBFLAMY240eDJANqsJ9gPJclY48ps6g==
X-Received: by 2002:a05:620a:4111:b0:795:2ce1:2ab with SMTP id af79cd13be357-7952ce10408mr241537085a.23.1717625367617;
        Wed, 05 Jun 2024 15:09:27 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f305f502sm477303185a.96.2024.06.05.15.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:09:27 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:09:24 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 7/8] net: stmmac: remove obsolete pcs
 methods and associated code
Message-ID: <64mscxnkyilqq6osqr27ed2axemh7tid5urek5udj4t5u5z6rb@ip2rv3wuxkwt>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0PF-00EzCJ-UL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sD0PF-00EzCJ-UL@rmk-PC.armlinux.org.uk>

On Fri, May 31, 2024 at 12:26:45PM GMT, Russell King (Oracle) wrote:
> The pcs_ctrl_ane() and pcs_get_adv_lp(0 methods are no longer required

nit: pcs_get_adv_lp() -- if nothing else I'll prove my worth in
terminating parenthesis in this series :P


