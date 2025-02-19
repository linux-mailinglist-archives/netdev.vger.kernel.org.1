Return-Path: <netdev+bounces-167916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C51A3CD3B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313161890B13
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3381D6DAD;
	Wed, 19 Feb 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca54jgbv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11851C7019
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007013; cv=none; b=Xt1GX7Sm+KfW+pOwU1Ey6kNHhVuvm7Apce+g9Y3MLztRq19/aeFdDEUK3rfBALQigeqo+xTw4yLNyDMfxUUCuRT/MsXscf7vsez45Pe4wHB2QujLo5lPmQKv+wVMvd5qTAVtq/kqCvhSwxRkBqohdq2ihHIQ1zaRdPPCDUEGDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007013; c=relaxed/simple;
	bh=F8ER1sBJQoosBi+BwK+2ZTrSGuIzFnwUV+GvD9iuJ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gimfxSlCpS+OniSkLVSa+Jg/EXUyqUcFqunFgUIjlfKxnXLcsSEH0LyFnRCwkKHuU/UxRxDoB2pdnOO1/PzwM3ZX1K5RmW7hLzKMUOTgBm9G4NoPsIO1sSevOjYZbRKzIg69ammimVWVSNMss6oYyjGFmW3DCKBgFQUbTeLc3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca54jgbv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e6028214so5690695ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007011; x=1740611811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DIUuitM53SFcFbm1WiAhJ7LiZEe+wxdMJ18InXeX8+A=;
        b=ca54jgbvJjoBewRczHJg+9Nq2FWelcpPtwIhwVzbdJmrX5CfYerV/SwneGx9LyT37u
         bY0Bzpjnn5tffq+JpA4tTBXcQqKcJD1S0Ou2AWPOBQunrqirDyF6gFv9IE6AKtKwBer7
         +/Ia31YHCfej2t943E+TKfqEBmWXu+97GwOzTEnmV1r6AHNzWF78cQXJubugf467S+xv
         vRiff+b4qNeosFhIqMNbEnKyDPKKJJzPnuvpJV3HEacB7CzMbr+rMAhO18q1XvIUbKsX
         Ng/Dslhu1WBYrtf7ntDGTyFK7JBuHIGeSgQltkI4EAJepOOIVNTip4nhie7t+/SRAVh9
         PLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007011; x=1740611811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIUuitM53SFcFbm1WiAhJ7LiZEe+wxdMJ18InXeX8+A=;
        b=Bkf7l5H0u06gy1Qb4saqmXHSEYfvBlObuhELuayDF0RkmG6V/a1HnjuFT4O82+DiDD
         7KDN+zTovL9v6XcMcq+9hqpxmLgtWjYNc2FV6xEeezctj0dlfN80df4rkeBV5o0Jn4nz
         Ax3pjVu+w5uhOoMggGPVr8CeM9n7RwmjllC7IP2fb0PO7JvwKwNaR7Vtsy+tTfA10MXs
         FH6DfX0WuRjtti7/cezxTyEXhRfmuRkznljrgLN0fyM2o8TcdcmNFmOc2ZYsSq5aA6Qx
         Qlne3mLyycbuZ6WQIEEK83Wpi0JEIyZU7AL1c0dtyOS+BuQWlyJFlDNg3bCowRffL/TO
         dXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIH9BTqpzTO1mtV9iYonc66Bqs9kOWmJBT0BEq3NHSyD/T5vKpkNt/lSJV/aAV6wq6S9Mac2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1TYY5qkkG4rk7p1BhlibGd5UPR1yAUVXQ4Jq+OgKUXZ2/nNN
	qMBa5qAY4CcSmgMBz/t8upsOv934xmk2xZx9rKodnAUvTZzNSBo=
X-Gm-Gg: ASbGncvIwhBFg4eBU0VhfVad375JcjFk2zyxr2nGdy8kcepaP6+9PKRgrQRLyNX/s+6
	XF1LXMK1jhc/fDo7gz2Dx53JPHN7eHvs2P9J90jIP+WHgijTFRWvpMfe9vhBVTlHx6uD/dJMMEZ
	5SRRe+RSeoDSfnuRAQmj+NWJMmL5rB5OtkDI5YlgzzBq7plRqn9E2bLd83dRty/zY0mxR85S01b
	LuE7kbDL9ehXdfMfFCPw0tLvxUYuX+aInzNYUgpr+iGYYOz4IjZ8yw0vlJRWOIqhBT4+RZ+z0se
	Vw1FxuNxsWRN94o=
X-Google-Smtp-Source: AGHT+IFQasVFV6peNaetM8uaSTYNCMqmYy9VCxN7LlAuUz8XxRloMOtqXzF9GjHk2fg1Pu+69bmUOg==
X-Received: by 2002:a05:6a00:2e16:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73417382ba1mr78558b3a.20.1740007010897;
        Wed, 19 Feb 2025 15:16:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73264729945sm9201464b3a.179.2025.02.19.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:16:50 -0800 (PST)
Date: Wed, 19 Feb 2025 15:16:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v5 12/12] eth: bnxt: remove most dependencies on
 RTNL
Message-ID: <Z7ZmYcjUJaTx2OB8@mini-arch>
References: <20250219202719.957100-1-sdf@fomichev.me>
 <20250219202719.957100-13-sdf@fomichev.me>
 <CACKFLinkP2aakfuBP7rC0Z28qb6jf3_WKVS5W8Q5LPmHZAum7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinkP2aakfuBP7rC0Z28qb6jf3_WKVS5W8Q5LPmHZAum7w@mail.gmail.com>

On 02/19, Michael Chan wrote:
> On Wed, Feb 19, 2025 at 12:30 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Only devlink and sriov paths are grabbing rtnl explicitly. The rest is
> > covered by netdev instance lock which the core now grabs, so there is
> > no need to manage rtnl in most places anymore.
> >
> > On the core side we can now try to drop rtnl in some places
> > (do_setlink for example) for the drivers that signal non-rtnl
> > mode (TBD).
> >
> > Boot-tested and with `ethtool -L eth1 combined 24` to trigger reset.
> >
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> A typo in a comment below.  Otherwise it looks good to me.
> 
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> 
> > @@ -13965,30 +13967,30 @@ static void bnxt_timer(struct timer_list *t)
> >         mod_timer(&bp->timer, jiffies + bp->current_interval);
> >  }
> >
> > -static void bnxt_rtnl_lock_sp(struct bnxt *bp)
> > +static void bnxt_lock_sp(struct bnxt *bp)
> >  {
> >         /* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TASK
> >          * set.  If the device is being closed, bnxt_close() may be holding
> > -        * rtnl() and waiting for BNXT_STATE_IN_SP_TASK to clear.  So we
> > -        * must clear BNXT_STATE_IN_SP_TASK before holding rtnl().
> > +        * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to clear.
> > +        * So we must clear BNXT_STATE_IN_SP_TASK before holding rtnl().
> 
> ... before holding netdev instance lock.

Thanks for the review! Will fix and repost tomorrow (unless Jakub pulls
and fixes on his side)

