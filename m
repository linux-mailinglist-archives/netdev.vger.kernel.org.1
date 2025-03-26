Return-Path: <netdev+bounces-177713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E90A715DA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6303BE0A7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44381DE3B5;
	Wed, 26 Mar 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DsLVm0+t"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644451DE2B7
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988889; cv=none; b=C29FqiYwH4xQggwb6No4irlZAwWvc7KHmPzucxTXSlknZgD5vysOaiJ/SC4t+kEtaxeX8pCzI/IDZZyumnYofVwqKhJ4h3ML76cy9mv9eyI4ZbE0Oks4zRcLPZ9HkoknICrg3ivufSTj2JH0Xz8tCKJ+5BgQAw6aKoM5Kn0Tvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988889; c=relaxed/simple;
	bh=LQlREbuhw8TtrSQMwA7+v95KY6p+jkaDHwJ+jdV+YTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmWplr+7MMfItIs9npJ+5Ek05K2Fqx0d7lVVij5zP5RPW2qUfQfPxtB/XKt4iyfq+NC3jATCzHJrfC/B+HUFvGqWEg+TNe8+FYSBFxl39W5Dj4vCUSNPxrz167IZdiBbQln69nikdWDpn4Mmj+iEuOV6rCShYsWuvEXGnYyNtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DsLVm0+t; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DsLVm0+t;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 640926BD
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:34:47 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2241ae15dcbso136195805ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742988886; x=1743593686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0EBOdLjUoNP4WLAtqeyEre7cO+lEkXao+VqDbYoEW4=;
        b=DsLVm0+tsKh9NllAn7wlcyrSGxqQRTnG2fqpZ0HSE061ZtZzCuYmid7hTimUYLOpji
         8knfERy5P/m25KcyV0VAvAWos3KMRrA1cVFbSpB4zYte0tM4yaKDK40ym2kqeWrNQu0r
         VjVfbe7mjpKzehupe3BmB7RrdbsLYzjszz1wSM6cKCTEl8/a44bNrzLW0LJ/ByRY8BIm
         830BeCCmNegaasG+SYrdmnKvf8aPg6wyLbQKJ9ndUXSQGQ70yRCBx9qjt23mTPXHcxMk
         klySnYKA5b+H0oO/O8nngtAtwOjGRdEUbNepUTQqHFT70f1hxFvPCMqtU9jRHcrJOmjJ
         +sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742988886; x=1743593686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0EBOdLjUoNP4WLAtqeyEre7cO+lEkXao+VqDbYoEW4=;
        b=mlmIlkM6eEwqLJ1PAqvlKBTS7ku6mhyysPbaWI6Jd+I8ngmsdl/4/UdQmZuWDruXB8
         zW0QotdXsa6/GnvCSVCVE78u+ta7NQpTo/BJp8s4sOzQKLswy5aPmFEAkioVhP2VKOua
         4IkXrQCOO5EoFBMp5efRyUQjEvDfMqm1k5TKQEaSQdXWHidgIpjQKqvQ5UMa6RFI9d08
         YjRIY/wDA3Qxke2QBh7Y2teQkkWIvSwRr7DeGNc00ooGob9JlXgCvNLsvZDT1hiRCZNW
         Ezf+bAi3H9Lwtx++j0pPitlTQqeYpd19lEyNkAAia4ifQ0WGjSwjSbawM46z3dEfPkDz
         f7cg==
X-Forwarded-Encrypted: i=1; AJvYcCX2hF9+p4qPhHt60AupUTe+8+73eBkiqqRIjM7hMq+/Tss3QYRLKnpXdf9hehH+QXqcSkNLhuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s7EWxqJPoZ8D34RjMMKvhn4AVZqmmsIO32sbTHX5Bu9ObKH9
	28YHCdI68PZWDJvK4AMj1qyfoYikHGO240b+At3Vxp/wgEUR//8xn1qkVRMLp078pGagcYZDSTl
	g1M27qZyGR70MfQcY5ss6kLeOCGorJeH/4f9WUjM5Q4TO+MUdQGqR4+4=
X-Gm-Gg: ASbGnctCJgMvCWDukEn36zY7NwnYzVwHCyR8A15xpNq4MocVCw/FvYZzo51ATD8ku8H
	hQJ7g7RxBy71PmlVxaKW7j1LjcnxrOS1nYHIiIlJw0yblDh/j/t8IhnbO9Jfxfnyp15/u983yIo
	PgGfkvJqTyYf/mULGJTetq7xVnW5jQD1nxh2djkZ4Xs2kg+pgAtZ77SSGQ9fIxIkhNvdkI28E99
	MEolOi1KdsIfOA1FzClbOgV+GlwwgEVPT2QXlt/fENwvp37ee4QEpb9W/GyXinv4uaFQkkWbVsQ
	CSESI9Hz3XYYdLQZsIsnT6e9f1UBOJheISgvHI7UwjoJjQRHiPXoYaFaCQ4U9V/iXLKwTKNA1mI
	=
X-Received: by 2002:a17:902:f54a:b0:221:7b4a:475a with SMTP id d9443c01a7336-22780e46a4bmr262392255ad.52.1742988886295;
        Wed, 26 Mar 2025 04:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGne8Dsw/FzoPIcfh+DvvXsx5JNmQUDmczbTum6IdyLkRnskQJzwKRbnNBiyWOmQFsRlxaMmQ==
X-Received: by 2002:a17:902:f54a:b0:221:7b4a:475a with SMTP id d9443c01a7336-22780e46a4bmr262391735ad.52.1742988885667;
        Wed, 26 Mar 2025 04:34:45 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f9a00sm107931005ad.240.2025.03.26.04.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Mar 2025 04:34:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:34:33 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Naseef <naseefkm@gmail.com>, asmadeus@codewreck.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <Z-PmScfnrMXqBL_z@atmark-techno.com>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
 <20250326072726.1138-1-naseefkm@gmail.com>
 <20250326041158.630cfdf7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326041158.630cfdf7@kernel.org>

Jakub Kicinski wrote on Wed, Mar 26, 2025 at 04:11:58AM -0700:
> On Wed, 26 Mar 2025 11:27:26 +0400 Ahmed Naseef wrote:
> > I hope this feedback helps in reconsidering the patch for mainline inclusion.  
> 
> It needs to be reposted to be reconsidered, FWIW

I just reposted it here after this reminder:
https://lkml.kernel.org/r/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com

I've just remembered the timing might not be great though with the merge
window that just started, and now I'm (re)reading through
Documentation/procss/maintainer-netdev.rst I pobably should have added
net-next? to the subject... If it weren't closed.

I'll re-repost for net-next after -rc1, unless something happens to the
patch earlier.

Thanks,
-- 
Dominique

