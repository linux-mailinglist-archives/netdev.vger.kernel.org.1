Return-Path: <netdev+bounces-57222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB981260B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B91E1F21153
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389315BD;
	Thu, 14 Dec 2023 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAZMm2bz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E08A6
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:44:15 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9fcb3223dso4395159b6e.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702525455; x=1703130255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ds+mv87BcbdNG+N1NvHWaSik9ER9rOPMfy8oqffdmW4=;
        b=VAZMm2bzd4zCSn9Pb/ut6z1b1RgmwdEo5MiaN9wZkblVcNzTZtxM8OCngAYVFO3HCv
         I7w72oTCH0HlolxPNShL1Icue2caFvTs5R+CM7d+9UUqMVvz7/+olNLnE94+NebgaJHg
         swjBSj6aAa+qXJtLA1swpp6eR49+nG5DtiOXYpq3FXVpgGGfmn+mdb3mqFzQR6xLAnCQ
         ohAq3ESzM6qVkk456e+7+VRrfBMsvQoYMKPJNbmCnHhxbu9JWoBfVMFd45WuhybUCN6a
         BB2sLauM19mRmYym8X4Fv+A5qDqUPNO5HnxeZhmIH3zicG2ccd9nFH3OIJ586x+UAe72
         jbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702525455; x=1703130255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds+mv87BcbdNG+N1NvHWaSik9ER9rOPMfy8oqffdmW4=;
        b=wsnUKz3kzOZdL1F1QKbDszuUF+mSXTCXFHLmheGXoDYOPkXvuNlRV7wAbQm2CaAR23
         hE65GoHhAyc9VToL6Vt2OUN8VPyhwkoQT459KG30ZCC3DJMOkcr/iS4h6jaUvj/SB7qp
         Ic0xYU4K3ginXsiI6ks+PtmzG+SLDgP01XZW1vcyy9QlrkZPAfY7BFkDM4UJYA2uxQbZ
         jqw5RGlazYDG+TGUnYDCxZ43hpFERmbWjEm3ZRobigzeezWEaYU0GqNq6BZlOSpFGFti
         w5bz6iwZaMQhupW4JF47RgTuXnwjlsZ9IgKnJyq0lnSnvT7aIRR41k57ksHAh91T1ojq
         iY7A==
X-Gm-Message-State: AOJu0Yy3evHisPYdZQSRiKA2mKFQ29nXpSL5fd2d0h9Qz1GLaP5Gqnt1
	dwLYe/T6bHWiBMneGRKDNngfk/SZHwjVH9h/7mY=
X-Google-Smtp-Source: AGHT+IE410lsPBh6k0dAWUWaNsIUr4EMD4EqIkM1DRxNutnXy6FTzuclC2D5qM9lWBi7qlRcxZK3eQ==
X-Received: by 2002:a05:6808:169e:b0:3b8:b063:ae02 with SMTP id bb30-20020a056808169e00b003b8b063ae02mr11437524oib.95.1702525454774;
        Wed, 13 Dec 2023 19:44:14 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm17-20020a17090b3c5100b002866c96fc71sm12068084pjb.38.2023.12.13.19.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 19:44:14 -0800 (PST)
Date: Thu, 14 Dec 2023 11:44:10 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <ZXp6CsaveeEPOVOm@Laptop-X1>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213084502.4042718-2-liuhangbin@gmail.com>
 <ZXnPgIc4qdxJ0fvN@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnPgIc4qdxJ0fvN@nanopsycho>

On Wed, Dec 13, 2023 at 04:36:32PM +0100, Jiri Pirko wrote:
> >+operations:
> >+  list:
> >+    -
> >+      name: noop
> >+      doc: No operation
> >+      value: 0
> >+      attribute-set: team
> >+      dont-validate: [ strict, dump ]
> 
> What is this good for?
> 
> 
> >+
> >+      do:
> >+        # Actually it only reply the team netlink family
> >+        reply:
> >+          attributes:
> >+            - team-ifindex
> >+
> >+    -
> >+      name: options-set
> >+      doc: Set team options
> >+      attribute-set: team
> >+      dont-validate: [ strict, dump ]
> 
> There is no dump op. Same below.
> 
Hi Jiri,

I just copied this from the current team.c code. e.g.

static const struct genl_small_ops team_nl_ops[] = {
        {
                .cmd = TEAM_CMD_NOOP,
                .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
                .doit = team_nl_cmd_noop,
        },
        {
                .cmd = TEAM_CMD_OPTIONS_SET,
                .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
                .doit = team_nl_cmd_options_set,
                .flags = GENL_ADMIN_PERM,
        },

Do you want to remove all the GENL_DONT_VALIDATE_DUMP flags from team_nl_ops?

Thanks
Hangbin

