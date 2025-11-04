Return-Path: <netdev+bounces-235421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD9C3051D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB13AB866
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA528D84F;
	Tue,  4 Nov 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQHnrjMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A42116F4
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248443; cv=none; b=arIT6YZQzDuI7+Eeb8IpJolwd2ErG4+0QlpdXlGUunhRVMaOAKcGQ/8WO03QE9TEYXGZ5y4tZ8xVF//Jy2KxtxGO8JO3n3WtiRy5fY+VtAKXCKCuf9IjEKFmRS2qE9LAQwJpte32nZAMIUMlPi+eDLNqRzTBP26K5Fh9IHAeVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248443; c=relaxed/simple;
	bh=Xlh8IX2UxKPjmcYl/o/bcB5iJvFYIskHf31VHQFGkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta2BYsCbjzHa3D54PHjxepH8o3rS+mhuQKV5yLYYDq1Kaqlp2zJv6VjZ3OdkPJ3OMtgFxvs96cUmtd3g5HPaQ5j2eN/dZZwTo2dI6cYDCqvSenAW9jFvhLd0JRqX1NxHbo15CBKFEDA19F3orWSzbPAFKP2qq/UZnO7BGa+ZwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQHnrjMn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29470bc80ceso59415845ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762248441; x=1762853241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzXrHOeB98INksGwlSTvLp657Fh/P82/6TlCuQQCFz8=;
        b=JQHnrjMnbPh9r+yAkdhB9PYW4QJuzsQwWfatdDJrwdOMw+7bAs3/YA9BOlKdabz79e
         RVJ5eukBhamc1ysxKFO8caE7zOjdcuZYbPwWgo5igXHY9RTc1gTgwkTSZKGhJo1b8GIe
         Mzw1beK5F48rwAPJg7oCy+oQ0fMhLVOEBKAd3OAW0PJRDx9hvhnMbpGhJEjl3rR2Kv0Q
         OOpKVNRevkUBi6AedXZLJDoIb6gDd0T7qa8WeOuV6lTI2MzkNhQ5ExX3fdSAPVmfT3Gj
         Am8YYLf2x9XgGOuR06lfcVDz+FAUeZOpg6c2aRcPfOLGyhqrDkdwjim5OOxqV1mhqMUa
         VSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248441; x=1762853241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzXrHOeB98INksGwlSTvLp657Fh/P82/6TlCuQQCFz8=;
        b=iPCuDnC7KoZzLu0Sf8k4FSEObJQAdtiC2XvKjFG9X/1KHeF/Pxv6Ul28YZtRYoIEGc
         tT04y74HFHjMHlPzZpAO0TsuGVoSB+Q8vpjPk6ELRDDkIEvXVmyzc4DV9upBCiiT/8XF
         0k8JRVtzQNW6NbkwN+m8a+OfFX7uvnjIZCknbazmq9OaEGTFUHJMtbsIUKEG4IVhvzZD
         3GrByWJUWPVxqw0Rg6d48Pdt2wkug+RJz+NOkkuYEQ5Hn1AUCOLpx9ke5jYaepNAWASx
         T73iIT2tGwZmne7dC5S7fiDH30Jk5dVPiGCu/zm7Jx97id8c+NhKbSyo/UdlrCUJ2J1v
         MurA==
X-Gm-Message-State: AOJu0YxQcsG1NV53/tvs7qPa1pB5YvNVf4FFQOgl4rlMBehVsvQw8e0K
	sniVIt1oHjzlUcX4RVffPLqoLxJU7ZQTNdQ3XiMIqPi+uqUn+NsGqnd7
X-Gm-Gg: ASbGncsjVRg3msVkzU+8FuClcAB9Y1WmakUIdOEoJdRI3ghtmyvwP7+sxJ/SHgpGY1I
	2asbF98V8HZanOHUoolYzzDqovnVaFB4/cB4cq+5R+PWoQ8cKGfIQYu9H/uz4CIoIbp3dm5OkNw
	SXoenh9UCcUDmI0sM4arpA/LwhRPbGEkkjKCEkE6SuTuF+Pepnl5flGsrg9LbsxA6k1pZnARaLN
	YRIMgSLmlOgPX94G3OjHjefG9zqqW+BNy+9yONKJ9lJGAoWb17BYm7HPBNqp2z5xEhQeTGBCo4W
	X5TVUj9implkQ/dUxYRvRcMkUJUmSTpNvmIsWMcXQDpsUsIYyJxsxFPxyB98TQMGf6PcXoMQys9
	CBUgZF20QRnT3Q8c97XkYTKaRUH+IqzwBwB2MhGOHdSP7h3gSxi2Bi/YJ0VRBthhbn37nqfIPGW
	R0ZLM9
X-Google-Smtp-Source: AGHT+IELRqgcw/IW+zjDRYns6NqUSqFVZJxSSkN5p809al0q/XTyw0llD+RBmt4pBeBgE9jNvUrD/w==
X-Received: by 2002:a17:902:cece:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-295f93ad584mr40393785ad.11.1762248441090;
        Tue, 04 Nov 2025 01:27:21 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm19459955ad.31.2025.11.04.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:27:20 -0800 (PST)
Date: Tue, 4 Nov 2025 09:27:12 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQnG8IYsY3oyYekf@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163742.3d96c18d@kernel.org>

On Wed, Oct 29, 2025 at 04:37:42PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:
> >        -
> >          name: dst
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> >        -
> >          name: src
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> 
> This will be annoying For C / C++, and you didn't set the max len 
> so I think we'll also have to malloc each time. Do we not support
> display-hint for scalars?

Hi Jakub,

I just realize that most of the address/src/dst in rt-addr/route are
dual stack. The same with FRA_DST. We can't simply change binary to u32.
So can we keep this u32 -> binary change?

Thanks
Hangbin

