Return-Path: <netdev+bounces-181340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50333A8485E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912DF3B88DC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C61E9B2F;
	Thu, 10 Apr 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp3/R0Gx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EB1EB9E3;
	Thu, 10 Apr 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299990; cv=none; b=XGiTfu50zLOzlJ16txWwkkZ5J44eW1DKdvrFHmE0YWdGYEOWFmSKs2rXvm64mulB/x3p8VAQvutDs3H9C8VSzDTpNkJfbXNmZcTit+puSug3YuFaChhWY3Sql1Lra7yYZY6HbCPgjsaAeFwk0QXE3xUIZKgf4wTpV24MDtnf9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299990; c=relaxed/simple;
	bh=RmV6uTkHYjl0L2+M97sxfGsXkm/FIRdM9b7RJRLTyUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnx3Swlceo06MzAw4R/Rb3vw0xdZuGXIf6NuIMO9xsz28xY9aVEhMLozSlgDWVVXd6iuDga+kl+YYSCMr+FALQDayStOpX3P3c/xyPpX5/rliQA4LJI5g/sejZkrTNxzTWd3RkEqeipOr7qaTJhCaJNohxAw0QM3QAunrrlQpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp3/R0Gx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225df540edcso22413435ad.0;
        Thu, 10 Apr 2025 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744299989; x=1744904789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85Qa3h9qEG3X96vnZ+9vMbiip7I0/QKNNiCH7bFxD5o=;
        b=Dp3/R0Gx1cMzVXOc7tdgeRASyMDufkqoWWpuIDioYwd8FUVFbV6bVkMGStqWyfzxpn
         PfyLqcPqk4sGniIWJmyqzMaBo3awaFB6HWEKfpbDbOqQqCKRvdu7OMxw/MSpup9kO1cE
         DE0ylekuyExMTBwcyfMAykXkaxZRwyjGuT06/1uMucXGPfvwC7FYMWvQOAgkXtuY6b1A
         x1QdxHHHTab7ng8nyldz/u96JiO1KqdCLGTOorIxpTIv8QRZWlLVdNnmboqWyqFVCSmI
         UC+K7M1ru8tNFm1ndYSrOFhGsQYhd5UXtArdUyUod7AkQRIJENOER1NdiFeSNAYgYsOh
         CCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299989; x=1744904789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Qa3h9qEG3X96vnZ+9vMbiip7I0/QKNNiCH7bFxD5o=;
        b=IfVbyRYxbfF5V03Umdlzyl+L47E7uhispV+SJ3ukaZYK15lGwwN1kI4qsDcGxVRc3n
         mOTrHxd5sf8odB8/xVy0AAmvGO6ogu6uP4I6l/gZIByz7+31XF9OJYK1MRAqAe96dJIM
         mhvFOtY/Smg2ERr6nHKB4SvbFkusReuBa7zx4mQNUzBTOaDZD09HQWqDOLsNjC9ELAUO
         r6/H7ZIEnH6/zgSKpboxVmU0gvvufDUbmw3+CNLYYSjksACpgQwTa9zqSsKFMV7QJl+C
         XcMA2hER8gLnAdgAwrWTQKj4t8i+dAINnWafLn5rKvuuaUX3BWDGNcDUtAYEfvJnUc7U
         EYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESNTb+uSJ4lcJ7cTFHv74tgrmOPEPAjRLLbPkBefqPGlrOTQIIgnuyK+5N5fLKlA/SdTxCCq0@vger.kernel.org, AJvYcCVG5HP9jASR6UW/G//jGsCm6535Byj1ambaM3Gtnf42dH15wxVJ41moBO7iTHX692sFx+y114gy4mMFQOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQ3G2j9deNqd8ijO9pRqS4XzS+IuyerYcr2f9KVED1za1qNVq
	V+ijtXaaP1WTRS7nkBWYzE+9O+39Ncpq3ES0TtMUQRWFZ4MIM90=
X-Gm-Gg: ASbGncvCqRTTiXT42h/xjSHhK+49Hy/INHLyvhmDHOYB+A4P2VjcutcGze9jPx8wVhv
	EbOyDbdAEvHY48P/ekogSPWVDVa+/h0qdPx06QcR9420+BA3K+B8JwCq1UI+Vx7ql7dgRc3eV/g
	TF0zfVHsxhP0rBAE0e5KO+ci3siEKoZA9dc/7m/pt3ssSCeHNbawdqLrl53D7FR0NdKZ+959T1c
	KyJZMpWrZZuCkBkCq1KknfbqjIWz/P+O4OV5LScoJiieXKvtHwVMXhc0iTikGlOxQ3DmVa9aJwz
	1g4mh6Tv3ZLIqjcYQrQJl89GfZGJM9vbLa4lL9wse9lOkciTU/k=
X-Google-Smtp-Source: AGHT+IHphO5D10R1pCTA30+KCxPL1PNdYx/+O1+9BaELB8Q2xdd6d+foRyA51ibDx+91E8kAujQjZQ==
X-Received: by 2002:a17:903:178b:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-22b8fdb8994mr52476265ad.25.1744299988798;
        Thu, 10 Apr 2025 08:46:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7b63f1asm32268795ad.12.2025.04.10.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:46:28 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:46:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	jv@jvosburgh.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net] bonding: hold ops lock around get_link
Message-ID: <Z_fn0yCuj3BI31ie@mini-arch>
References: <20250408171451.2278366-1-sdf@fomichev.me>
 <20250409174433.7b3d0f29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409174433.7b3d0f29@kernel.org>

On 04/09, Jakub Kicinski wrote:
> On Tue,  8 Apr 2025 10:14:51 -0700 Stanislav Fomichev wrote:
> > +		netdev_lock_ops(slave_dev);
> > +		ret = slave_dev->ethtool_ops->get_link(slave_dev) ?
> >  			BMSR_LSTATUS : 0;
> > +		netdev_unlock_ops(slave_dev);
> > +
> > +		return ret;
> 
> Is it okay to nit pick? Since you have a temp now it's cleaner to move
> the ternary operator later, avoid the line break:
> 
> 		netdev_lock_ops(slave_dev);
> 		ret = slave_dev->ethtool_ops->get_link(slave_dev);
> 		netdev_unlock_ops(slave_dev);
> 
> 		return ret ? BMSR_LSTATUS : 0;

Nits are always welcome :-) Will repost shortly..

