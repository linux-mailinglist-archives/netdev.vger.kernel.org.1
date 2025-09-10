Return-Path: <netdev+bounces-221506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801FB50AB0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3A1461EDF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570B22FDFF;
	Wed, 10 Sep 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqX6BVGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1922D7B6
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469841; cv=none; b=No6NXWeMYqmisMBoYNhV6LCTwJ8865xPN+hepWX25W81AvYkkBow0vJKH3g4mMHi11xG1SyDBuFcFjCQIbCn7RnXX5OAU8YLQXY/bVe4VPPxmMLU4/Q7u0edbLvU9O10qsSrQ3do+UJLJJVlVEFDfZzyJEJ8nWSCf56pnPV+VBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469841; c=relaxed/simple;
	bh=A8UZSafwblk0pzJBfHJ9Pb1lVpHVArTIzyweR+KHg28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHFpJX5Bu+fxPKSc3RekroRBdD1YkzzzxE8GfF1U4pzDDFgDWmkUdWyrABXnFLSdptZZe7Be2cDhT9A35CnlyybTs2b6L+ttFNl7s0DxmaY/m5MTVQZQm4YhdCKLV9h8lRWj68kQQuTO1KpXM1awd3732TXuhI/Gpt1oFB3xOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqX6BVGg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-251fc032d1fso42641605ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757469839; x=1758074639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDPCc/01NbX/qdqx8tLh6Cy8tAJ4bABYrvs+o+VqOMg=;
        b=fqX6BVGgVM7YHsGY8g+DzkgOZll2wm44F2ce2rJt9NysWy+u9YixOktSlvd9soimM+
         kDCyOwsNCwzeCjgfJ29XrXlc7EF7wRspZ1PbBY/sv0W6ZYjrnkK5t3Tbldcy0VXcZfDD
         4ILNuW9vmbRo+v9S0MUSBml4CPUxaQA2zaUorUIdOy6w8NVsSbH9zmXS1uy2wdaZFQAR
         794LBxaNr32EYeBVppDEktKoiCLYKs6guy1SJ6hgg2sU9rkFzTxUm+gr6fzCEGHsJShs
         vBhuVOZAZxJuo1+lNdliIte85cI8l50QSd3tg0m9I84A7jZgUAEE6VyrxMF1i4ymSDEb
         u1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757469839; x=1758074639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDPCc/01NbX/qdqx8tLh6Cy8tAJ4bABYrvs+o+VqOMg=;
        b=l1/1NnyOBD2ZESzyZl77Q3r68yYJu/CQRAuAGMK8q9pvnPbfh8Qeuc1tjrsg/AaFsI
         VBdqgtBTUtLJaZBMBw3/p7p4xvoQqNiQHv+uLtvmNldblJhzgQ5+NIFtVTW4qTyHJnj1
         03g+1HKwMotHUVQpPEfcDm8FxEXJXA8Gy+fcnlfYw3uOvOcojoGhdJ9EUKb03+j/S2et
         tTUVERsSscEXa3vmZ70yySFcelNCiKjRGL7TAXg72daN1ZX1lp461EQozc++uOCC74LM
         cbgNGsntH3kVNJn+2FB/Dl/iYQofBLPFMgmB9FyUk7fzymWF6WgdDNUWnopufGMMf7a3
         fj2w==
X-Gm-Message-State: AOJu0YxkSNXM/fEDNI/5qNx6sqZWx78hF+Vk0/zRLPLPyhFuCEKV2V86
	sd6jW4pmoaFVgTuXib/VfzPxmeBfupDIKICyzeZSrFFG2bzt42vTRnn3Apu6SuLo
X-Gm-Gg: ASbGncvyFQy19ZSXlo9JS1aTzEOpie47D5QmwssxGnBPO2WPiQEgSyrEUHWYL2ANwDi
	H3lrtVUlndXDo1LbBLwqkDv1AL+JG0zTVqtl1KFdSfUTkaoLx/5U/MUN0fqXLyFmLua/bM5Pklr
	KpTlTmZXGfu5U3BRGIikIxBUgFPIEzzuKIyA0LStLdGQXnGRPudyELxUu2LR9GpVgeHxBVFVJkM
	6YYtofIQGObbh5TkAww2n7i6hPwS08yVHB9/RLi75cTSp7K6ggbdpVyTVxjPJBaW+MRN5Nq+g3d
	Ll/CF63/T3JDsardH3Xx6/kccmk6ECwhPAhBP7UXjpPSVnTj+4c37HNKG4n6SkyHh1z1ZQE9Dde
	Wdw+LxY4MVAsIljqj+uhfuutse9M=
X-Google-Smtp-Source: AGHT+IGvbsXBjLY4Fbf28Eq5y/fsJDH8VznrHYs+kMCnJL3AHDVfp47p+D4IJrxlwh0Ob35gaOgXUw==
X-Received: by 2002:a17:903:380f:b0:24b:164d:4e61 with SMTP id d9443c01a7336-2516d531c06mr166441815ad.13.1757469838967;
        Tue, 09 Sep 2025 19:03:58 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a344a03sm10440465ad.70.2025.09.09.19.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:03:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:03:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <aMDciKMGjr-_sW6E@fedora>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
 <20250908062802.392300-2-liuhangbin@gmail.com>
 <20250909164600.04aa44c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909164600.04aa44c7@kernel.org>

On Tue, Sep 09, 2025 at 04:46:00PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 06:28:02 +0000 Hangbin Liu wrote:
> > Add a vlan over bond testing to make sure arp/ns target works.
> > Also change all the configs to mudules.
> 
> Why are you switching everything to module?
> The series needs to go to net, we should avoid unnecessary cleanups.
> And I think changing the config is unrelated to the selftest so it
> should be a standalone patch in the first place?

On my local testing, there will be a lot default interfaces if all modules
build in. This could make the test environment more clean.
But it's just my preference. As you said, we can do it with a stand alone
patch. I will re-post and drop the config update.

Thanks
hangbin

