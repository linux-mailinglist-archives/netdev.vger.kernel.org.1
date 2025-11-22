Return-Path: <netdev+bounces-240952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B3AC7CB40
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B43A85B6
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E92F2905;
	Sat, 22 Nov 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LxzyhzH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A4280CD2
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803139; cv=none; b=sy/74JRdo1KRc0YdfGijVXA2eqiju8Fpkz/l2C7JhAK8BfvBKY2nq7DdgHV/XxlYxS0cEhnV9T1Ac+/Nk6hYXvlCNYWxry8r6exsKqUgtakgf9LfhcTdLBjyq7pGeoT89t9pVN41XzQ8GpokxMazjM5RgJ1UjcG7msvXR3hyspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803139; c=relaxed/simple;
	bh=3Y6g3pyQ7xItiex/CLdc74fmNKXzVEtgCADpye94/G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S++z5At8tpGDAziVkmurESa5hqGO7+mkBL7xxNzC3igNMyEA+Eywzbg/immLiLnB1GVw1qo/C+qdMMJi6F5GtfUBvoKeNCKiYaOdC/2kdTkBXAMWgfhUEqUk1q4Fw95dKwssq0TZ/OYI4Z9ZMf2sUa6kGRFwDTXCt5Azh+f3cds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LxzyhzH0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso1762557f8f.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763803133; x=1764407933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53xJV33swqTLqvE9PnvUfsctO42OXLht9ChQmj1HdnU=;
        b=LxzyhzH0poPND554n6rvew8q3Tv5CrRYwlNakwjNqrLelxmHsKgrmb4ufX5OLJL5XQ
         tTKH0gHgeypDe4e9AM+U3hQ2c6B5ZZWaTtX09VWdUp797Eau+Yh7fyN27G5fkKsu0evU
         wyWz81RYCWdBIQSy3SEz5QQBRtFZ2ylSIt8WTS/6FMafqAzBoRW1e9OGyXbhpAO3yUe5
         RF0uUmMp5jDxuGwS3EaL8zUMaWrCleOEr8R8jn5BdJBZDFFcJ8P1HtBdusc6Fo4k1LHF
         n2qTzrybL6iwAKT+wzSyMKHNp0xXpLuyXytbilr/zr7gz/NogDh3fGiaY6WZ6UdkieC9
         RiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763803133; x=1764407933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53xJV33swqTLqvE9PnvUfsctO42OXLht9ChQmj1HdnU=;
        b=NX0IECXTKxHaiTvj9qWepyY78BruD3ZK5QOuuYWF5dkBmwiKQcdkdNCfXH9wRUti1z
         5dogt4FtWE1suBplnbc8ZApwHn3prvz+VtkWE2noc02qfn6lwCGEnDSYdo+1Z/bHXltm
         OZ9g7WoupBTH5vd0HOXPSpgY4KaF8wywq1ckJEmasDhIkzt6kuxpXvfFdKrz5GDYNTrp
         qFg1WSCNVqMCC3SnBWUNLcMgQCkvTGuZBoSE3ep2OhdyKQNvyb3g551WxAQNDEhs4f8g
         22ak8OB+RSbKCUTKKCMq+11AhLzMNNoaMrsXoeGKeQK0kWjzSESIQBzb+hjnnKE/5TU7
         ALsw==
X-Forwarded-Encrypted: i=1; AJvYcCWyF1n+UPbeulkyD7AyCQLuKDUZYPlbVSYJ2qej8vWe/g/yO4UBt8tgQBRdy/5JpshDgOZCyys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36gt8jWfUnAXO8DBvcYWTarHN73O5/vcS8tFypPD+4L/uRLAq
	AIYKK9hif4XzwE0i2hbhvjuOWpHtjZeKwKKOJdl6MzfaA5W6sWWmLJfJvRxceT5fH3o=
X-Gm-Gg: ASbGnct90knMKOB3y4TX9bslUtRExPWtXk9r3dOIgofJ5P4rIpLOI5JANHpBewBDK26
	AFblrR25oKeGIh/3YADF1zmy1UYD3kw3vUghH1yDKWAx7v+T7r0Ru9xq+FkaUGSE55KJUNaWpOW
	NyQ27V3fdojq1cdJSKLYneEjGOThywtSsgNdUg3RAHWjdjdwXx9PlQUkf43uyqjKlhEhgXoZmjR
	tn+MjfnFk9OJ2uAabceKjys7aEvQv43aETWtAHBZbbI+e4D1S/0psbOdCmJGpoQDaZylVsdcjZh
	RuS9+sNRncYkpKc3rSjS/nEKBc2nyvIdBJgCkrdVcflcDtWnqObL2vrJUiK/JDZS8/QnMmSjxWP
	lwn0m3pPql+j4fF7XbUn1nIsMvnxg8W57qHikuPTN4Lg54MSCj+X+bvQZ8aouf8zNdJDrKtgFUr
	5SB+ilVINQgIj1qfsgPi5eroDKRqhEsqA=
X-Google-Smtp-Source: AGHT+IGhv/ltDYbUC0qVNfi4WFC7UzIuD90H79TWw0dTFe8qWwKov+G9K1DtiG1LYn9cp3AujCyZqw==
X-Received: by 2002:a05:6000:4012:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-42cc1d1999dmr5618342f8f.40.1763803133010;
        Sat, 22 Nov 2025 01:18:53 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:7d8c:1d72:b43a:e19a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm16607741f8f.10.2025.11.22.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 01:18:52 -0800 (PST)
Date: Sat, 22 Nov 2025 10:18:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] team: Move team device type change at the end of
 team_port_add
Message-ID: <6wrz2ldfbfhzolevx5246he3hekgevqmhxwt65hbmvyijkzayq@yadj4nwt2yvi>
References: <20251122002027.695151-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122002027.695151-1-zlatistiv@gmail.com>

Sat, Nov 22, 2025 at 01:20:27AM +0100, zlatistiv@gmail.com wrote:
>Attempting to add a port device that is already up will expectedly fail,
>but not before modifying the team device header_ops.
>
>In the case of the syzbot reproducer the gre0 device is
>already in state UP when it attempts to add it as a
>port device of team0, this fails but before that
>header_ops->create of team0 is changed from eth_header to ipgre_header
>in the call to team_dev_type_check_change.
>
>Later when we end up in ipgre_header() struct ip_tunnel* points to nonsense
>as the private data of the device still holds a struct team.
>
>Example sequence of iproute2 commands to reproduce the hang/BUG():
>ip link add dev team0 type team
>ip link add dev gre0 type gre
>ip link set dev gre0 up
>ip link set dev gre0 master team0
>ip link set dev team0 up
>ping -I team0 1.1.1.1
>
>Move team_dev_type_check_change down where all other checks have passed
>as it changes the dev type with no way to restore it in case
>one of the checks that follow it fail.
>
>Also make sure to preserve the origial mtu assignment:
>  - If port_dev is not the same type as dev, dev takes mtu from port_dev
>  - If port_dev is the same type as dev, port_dev takes mtu from dev
>
>This is done by adding a conditional before the call to dev_set_mtu
>to prevent it from assigning port_dev->mtu = dev->mtu and instead
>letting team_dev_type_check_change assign dev->mtu = port_dev->mtu.
>The conditional is needed because the patch moves the call to
>team_dev_type_check_change past dev_set_mtu.
>
>Testing:
>  - team device driver in-tree selftests
>  - Add/remove various devices as slaves of team device
>  - syzbot
>
>Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
>Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

