Return-Path: <netdev+bounces-173169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B2A57A33
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECFE3AD171
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC9E18FDBE;
	Sat,  8 Mar 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRG3FM2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C49634;
	Sat,  8 Mar 2025 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437867; cv=none; b=CGhlxNTKCRcncZNbzbVPOGjtJkjci1/XH4NjZgqKcJm8SnTxfjDBFGiY4ALMJ0EI0DaBuMioEHxYZ/MtzANTI57Jwuffv4SOjeqeuOJfuInas3d/TRgsoNmAmvy+xS5/6+m8gEA3VIgBMQFZZ9n7KNx20066DjOehd8gqcaaZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437867; c=relaxed/simple;
	bh=pJqPba0IGbu2pHFSxdLk99Rp6StXqTh9l6ukWNEkAos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXdsmqKitqpgnXaoSpstmaAvdgXyflsgb8Gts57+LdlBSiTmiZAm7eG/oSD6pitNOkTPs+RzUIe45rVnA5pMMvnSzIkyIxRo9D+AjkJkrDVxT98j2Y3MPDQQ4/JO2vcx78KHqqJeqd8dJCp6WZyHI0V8Gk6am2LEh4IXidBwhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRG3FM2L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1455708f8f.2;
        Sat, 08 Mar 2025 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741437864; x=1742042664; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uig2i7uTRlnXp5H7GvTYtQ0HLJywyAMB+6PP/406QV8=;
        b=jRG3FM2LpzkGF96q5bIWnPRyCEX6GM68u99RQpfDo1zvxiMIX5eywO4hLAwJ+bNhEG
         ZEYId5iS1j3Bj7XNK1N2NbEHYM4NIJr1vJpv5ZN1uAZlYDALgCL7gbHT2Id+S8CNLA6h
         8Fz+utEHnaEa0W9PQ6A5kHEFB4Rmi4RPb0cYfPK83qd9O3D9TW2L9O9kXBguOJ/u0yHP
         WT5jVUHwrqzRaav6QFGg1MxbqoTIEKs2Gyzd/p6qtVUAoz18YfBGaTvQxjLMoCVp0ezY
         Zx6M6EbvZuZ3kUcY2ZmUHTDOyZXreF4TwpxABRdc7EZqXbN8GtqSDxprZ/9TEs5oxyoM
         JcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741437864; x=1742042664;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uig2i7uTRlnXp5H7GvTYtQ0HLJywyAMB+6PP/406QV8=;
        b=TH7p1pIZx9v76jYfQcCC2+7hBCtVPJyIUl85J7++IieZYpY9kwJZFAueCkKMuGUqTC
         2W+xGzH/WKb3z3aYtN6GcLJmqT2ArGlhegeM2oS4ltMg+iuSd7Q8VHtld5V3MFay9NVN
         wJyCA7jo4qTbOhVqM/3CjXdBA1+0CFvCFo9W2Cr4Qwjhn2crmT62NwzHMpZRECKoN0nM
         pKCO9RqfF4vMfgYH3pFv7XZHSnfO3F1ox50pAXhSXGV9uHXW44Nc9TtM92kpqG0kNEX5
         dA2Z3e+r1pBX8HpymhXmj1w+z1qtZzjdukJPKY1X7yKNDZCg5oswdXusDq3dGNw7HfoU
         95Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVOxZtkQahDGxEMkr1KLiB2T3wsXuCm7ShZmUiMMEJqGp/Sveh9r+LER/rgnG0bJoyTc9pZAyI1@vger.kernel.org, AJvYcCW27F5aVkVYYrThmGbWjxFOBnhv5oo2onWXTssZNiat88QUVdBd76xhQel8QHU9cnOe1Fcrd2+7jn+MpHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfELYhiu6oesGw7P2oo8/swNuAiSasyc9SCZYkFBpsy5qb65HE
	mhQU0DaePJXn99kb9QaHu9tiPzWrCZxrLeQc4ZA4xrpCmdXJ85Dv
X-Gm-Gg: ASbGncvcg6uKZnAtQ7Swqv4gBktnkXGJFOg0jETUe9nhtxbpDThpiL3Ufbc2ulyldOU
	oMvrtQ94nr7OyThEJJI7IcFGN9HGh9fXrD8fT8HHhB8d+Hi1izjs1YF6weWDfgvB/2VE3mOBsKL
	4h196EqQzUTCUFhhanh/eyLegKw8yWrRnx5IrZRaGyUyeBOmqtGw7TsDhEwdhlv6+CD/PrFJWxc
	NUUkzDOoo/N0dAjjLG4p0hilE7//n7hMdufHWeIn2Dq17AdD42rq+Xj9ExZiHINq33VOySC/lq/
	ro2RnBC00tZRIxD44+OSGjjlpOhypTlrNTT75Rlje7Y0xJvR
X-Google-Smtp-Source: AGHT+IHkV/lb9AVigvP0Lt3MfBIidZxhLRWQjKcFBN1ToLeuUBwsl0D8HQXIlxn9Z0Lc4jfaQ1xj+g==
X-Received: by 2002:a5d:584f:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-39132da08b4mr4502606f8f.40.1741437863889;
        Sat, 08 Mar 2025 04:44:23 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:f465:a080:411e:5b2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2bacsm8695793f8f.78.2025.03.08.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 04:44:22 -0800 (PST)
Date: Sat, 8 Mar 2025 12:43:39 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jdamato@fastly.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: fix NULL pointer dereference
Message-ID: <Z8w7ezFX3T01ptjH@qasdev.system>
Reply-To: 174124876418.4824.8589202932419197412@kwain.smtp.subspace.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2025 at 09:12:44AM +0100, Antoine Tenart wrote:
> Quoting Qasim Ijaz (2025-03-06 00:53:07)
> > Commit <79c61899b5ee> introduces a potential NULL pointer dereference 
> > in the sysfs_rtnl_lock() function when initialising kn:
> > 
> >         kn = sysfs_break_active_protection(kobj, attr);
> >         
> > The commit overlooks the fact that sysfs_break_active_protection can 
> > return NULL if kernfs_find_and_get() fails to find and get the kernfs_node 
> > with the given name. 
> 
> If it fails to get it, should we let sysfs_rtnl_lock continue is
> execution?

Hi Antoine, I think I may have misunderstood the code. Yes I do think it
would probably be better to end the function if
sysfs_break_active_protection fails. 

> 
> > Later on the code calls sysfs_unbreak_active_protection(kn) 
> > unconditionally, which could lead to a NULL pointer dereference.
> > 
> > Resolve this bug by introducing a NULL check before using kn
> > in the sysfs_unbreak_active_protection() call.
> 
> Did you see this in practice? Can you describe what led to this?

I have not seen this in practise but I think in terms of defensive
programming it could be a good addition to add a check to see if it
fails. If a function can return NULL then we should check for that, also
if we look at sysfs_break_active_protection being used throughout the
kernel there is multiple NULL checks so I think adding one here would be
handy. 

If you agree would you like me to send another patch where I check for
failure and end execution right away?

Thanks,
Qasim
> 
> Thanks!
> Antoine
> 
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attributes")
> > ---
> >  net/core/net-sysfs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 8d9dc048a548..c5085588e536 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -117,7 +117,8 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
> >          * the rtnl lock.
> >          */
> >  unbreak:
> > -       sysfs_unbreak_active_protection(kn);
> > +       if (kn)
> > +               sysfs_unbreak_active_protection(kn);
> >         dev_put(ndev);
> >  
> >         return ret;
> > -- 
> > 2.39.5
> > 
> >
> 

