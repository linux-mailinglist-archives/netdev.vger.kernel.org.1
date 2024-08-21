Return-Path: <netdev+bounces-120501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1599599D6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AF81C20A9E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732D21411C;
	Wed, 21 Aug 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIk3tXMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A32140EE;
	Wed, 21 Aug 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236054; cv=none; b=f+TXgAPwx5VwubVKbZDuuz1eZlHt2lK+2KHHJFcNdA/BUsS07A8qeJQWAuvD3/VmYOhUFVWJRgaQGGl3ew/w4Yv0Et8Kgi45NUE/XnHKctn+eiBXsCzeMxdZa+mpo9zCaRF3siiAgz38DF+rKSr/iRsEYGfpCPvhm1y70BFWl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236054; c=relaxed/simple;
	bh=odhZtY02YeKG9xvTFI65wMHKCgpIIqqGB/nyrn3p83c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtFgKm8v4Kxc7mlM/u50nT+LIgiZJX1GTyaCjmI4SBXJ2R3JP+SEECCqLkT8Ml0wNnFCBR+Kxb8NhbrJAPVz+cuiW8M9DdjQXBtrbve1eVZU8NjTtSrqU9AjDfFhXD7trYw/G0oY3aApXbPjDOQQ0ZKu61MnmjXQF4wnACZ3suU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIk3tXMR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec4c3ace4so101678a12.3;
        Wed, 21 Aug 2024 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724236051; x=1724840851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fb/RuJkeM3aFjdMF0c0Xwmg+kLLocjFSamrIW7BWhs=;
        b=hIk3tXMR/sIUEqCXd7cmjDAIvU1EP2mkHvw+Nwp3rS9cgEYR5b3L62FQk4Nj/kf8K3
         HSviDm6RY8BHhczdHCNfloXLBI3zI421sWJ3X1ERwSpeP/kn29gWQj303g81Dv/LgF09
         svHAASSWAnzGyy47ZnT16OwwYy8W/yBhmgRE1lD/ZkoaOKPK3vvEBAReVMTvOxymKt5X
         M5WzGtbhgPh1t6WkVQGZz9EIeAhbMANlEWpXY6Zjept7BVsp2/UvhVbT9uyYOsdnFvh7
         6K4Lb9zCLekC1VIPT35XNJkDACX2c0ePmxKzR+ql5OWflPNWGpHKVCVI7dJFj0cOGtLv
         R/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724236051; x=1724840851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fb/RuJkeM3aFjdMF0c0Xwmg+kLLocjFSamrIW7BWhs=;
        b=spbYZ3CN9eSSUkXqGn0PqH0snIgb7Z2lF5uhecnzGiX3uPwcVO/dULmz9no9lmXw6j
         EviWomqMRrDszBVad1JOrZQAApu3oAj23pu3Fx3zfSL20giv+AEuVDczKiBe0wMwWAiR
         tPmNY7vYFbrUyEhgrhzr9L0UaxuVeq4kOlKzOqJrMgisk3/Vz82J/sNbmrdN1TFPR5rp
         kcLgoRAGz7iTNnGB60QgkqjCQp1uYcaiovgu4iyaMraBrAPNBef6JKq5hNob+o6S8Vuo
         r6driccR7cz//I4z0DUDVYJuBBnTaG94P9M3jB1MIRCIzEVQouaf3RM4syGwxJrS/1UD
         F3ww==
X-Forwarded-Encrypted: i=1; AJvYcCVd6pNMKIyJiO4Wuigv7J2Ecnpe8ZD5pRuXZwELhgWIsr3Rfktu2eYJDxUqm4vzIWF/UufPfG8Z@vger.kernel.org, AJvYcCXNDeVHcwgYfNJPRj8wbgTd1QzZzwl/SIWDvEDz7zNLoWEtiPupj4NfG4VcKW8lACFH3nHmTX9SP7zIU5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxDx+uJ8+YktYRjS7Fi8KlMhLfWSFe/YU5rhLLLmd4O999Khs
	Mn2SHTvdKgZVCZewC8g9JaD1QUVbvs/vmbNlPVewfaMtiIXwEThkvoxbuP0Z
X-Google-Smtp-Source: AGHT+IF6e53jlF1aQdWI+jcMWFq1gf/ZzPGVpqcc9Wop3GOkHdEj2yHM0jbnNyjDTQ4O5WbTWDngZg==
X-Received: by 2002:a05:6402:13c8:b0:5a0:d706:c1fe with SMTP id 4fb4d7f45d1cf-5bf1f2abe3amr645381a12.6.1724236050235;
        Wed, 21 Aug 2024 03:27:30 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5becf1f3442sm6465107a12.31.2024.08.21.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:27:29 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:27:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240821102727.qitmm2zxnpva4cqd@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
 <20240820123456.qbt4emjdjg5pouym@skbuf>
 <20240821125833.000010f7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125833.000010f7@gmail.com>

On Wed, Aug 21, 2024 at 12:58:33PM +0800, Furong Xu wrote:
> 
> Hi Vladimir
> 
> On Tue, 20 Aug 2024 15:34:56 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> > I took the liberty of rewriting the fpe_task to a timer, and delete the
> > workqueue. Here is a completely untested patch, which at least is less
> > complex, has less code and is easier to understand. What do you think?
> > 
> 
> Your patch is much better than my ugly implementation ;)

Well, to be fair, it took us a number of iterations to properly see how
much it could be simplified.

> Some small fixes are required to make kselftest-ethtool_mm pass.
> 
> Would you mind if I rebase you patch, fix some small issues, make sure all
> test cases pass, split it into two patches and include them in my patchset,
> then send to review as a Co-developer and a tester?

Please feel free to split up that patch and squash it into your patches,
keeping your Author: field and just a Co-developed-by: + Signed-off-by:
for me, where parts of that patch helped you.

