Return-Path: <netdev+bounces-211449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F02B18ADE
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 08:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2342A7A8903
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 06:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5341B043F;
	Sat,  2 Aug 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHctM0MM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAC182B4;
	Sat,  2 Aug 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754115343; cv=none; b=nD+d1XpS/jJDaxVMK4IUH1B7enHukqfpYn/CExlJSEVzKeA52RIvSU5q8HnTHoRWhB5JTGpJWUlG5F2AZBlULIFqknSJhdcgz4K+F1p9+oIfxsW1rreP0g1LtLBsJZXPg209W2bplKhPSgZExtjK3XzqvFFP+K4lRWd8HGOslGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754115343; c=relaxed/simple;
	bh=cEoHIrGwI9Cmfy7uTxfy8BAPSlg9FflWFmdc6B7TtOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh+7GCq4xEneYg1bkN7xyUQ6Su7t5iNKHdDQfPGkS1Ow7oR7sg06GwsKgH3Pm05h/A94FX244aH1C+YaiJk2BK79NN+KscG+zcTVlg1Swrs+oS04GvSwSFdhccwRyjCetJJVvZBDJV8GD9YYF/5edS76wbwQOpCPKJ6mDZ2jfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHctM0MM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af0dc229478so240874766b.1;
        Fri, 01 Aug 2025 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754115341; x=1754720141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEoHIrGwI9Cmfy7uTxfy8BAPSlg9FflWFmdc6B7TtOQ=;
        b=IHctM0MMDW9uwDYLi228KO2ISAn4KOduXvbqLR2gmQa6rnb/hfDpwc4PLOLar9IyAu
         aWeW+35OONTIVzEBwqLZYGmVyeVweHJbC3qf90QdP3N9ADdaLBLCBNQd2e7jLR1CiEXp
         1A3lA0wnYQSb1Pps0RxP4uzFdr4Bk8DvYoctZAZgjZRU6janxAK3z638UAmTUwddNEpW
         1BTQlee2jLXnPfru/V47DOiwKyRpUCOtAWT+Z79/jOC54uA1NKxjNotpHJsYC/WPOT8D
         HwnylLG6UaGxsJb0jju44q3OOt9cdiW+CBe0QSrbW/2WNYxKj3sBJTEOJL2DM8ANztHa
         yKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754115341; x=1754720141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEoHIrGwI9Cmfy7uTxfy8BAPSlg9FflWFmdc6B7TtOQ=;
        b=sNE8NRNVcDBAoDzSCJtx4zNmaBF7i2xq/gT0sIr1RS8cJEzJ0GOj0OIpwJy+r3YFU3
         Yhp16h4G6MSBsngC/DVpuR5/6e4OdRgWF1CUujsFIlc9oyeKDpgG6wChaIqLZc6rZyjQ
         bTT0AOQZSZQrqQxW3/MZYKWc+8VKF8jqXtr+iPpisKPAolqWTt3HVWXo2RaIszqq7i0x
         8yRKR3tXugHyELtln2vr+Px0p5172tnxWuTy3J1ap+BFn10ZxL9cXC7jr38++PvEGX1B
         L2x8Yt3lcg/40bXtnwODZcJUgzHUhnH4fGueWfK2DVf/KdUU38dyw1bLCsO9TzPFEFFr
         W+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVRZQ0EOnDc2GHFSEPcTfLwoaprFumyetdlLtdV+CgV6XrylOeJW2EAJ9uoajC3xhzioQsHx9pySMKnd4c=@vger.kernel.org, AJvYcCVpKYHIxdQhSNQpJUZaQyoFrRtpu7RATjwoEs/VHuE7XGwEYD9cJBsAp3s4me3gvmDtFLwbl87E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2MXUE5w6DcJMH2c1AvnT2JmUZw9XgnEUJ/5ZgRjBTCQkyiw/
	SjRenRZ7dz9RAnQPAlM2g7K0W20jr69UfT1OHYL85kNeZw/8y1LCTRn3DfGvb9CaVH7w41AvzRV
	FcJpxSxq2l7HuQuCUOnWA9fvBEtgy7g==
X-Gm-Gg: ASbGncvGrrje13jN2/ZxkwM3uboXNrmy4sweGGxy7uKBDTVduL3rl/K3I+z+YLAuDcV
	FdCtcx08IQqRI9Bcgg+39HcLpkfD2696aoAkU4aqIg00vZWRrmYh3DVH/gkoP28Y173u5zcLv62
	O1S48dSXvZsdNEOg9nXnopcluSo5yln4TXTQI8mfcN/LGzGpRNxeExITOX1EEbGfM+OsJGA95M5
	MUXId0OuSMQ98AatGg=
X-Google-Smtp-Source: AGHT+IHW9WdtFCyF+F81VNF8OEsDrE1uYicLpSEA/0VyxvhYP4Yby1e7IsG9Oskayq8UFDdTWgJzQoTiV+ShkV6XYVw=
X-Received: by 2002:a17:906:6a03:b0:af9:1ee4:a30c with SMTP id
 a640c23a62f3a-af940155f39mr269943566b.36.1754115340366; Fri, 01 Aug 2025
 23:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com> <20250727180921.360-1-ujwal.kundur@gmail.com>
 <e89ca1c2-abb6-4030-9c52-f64c1ca15bf6@lunn.ch> <CALkFLL+qhX94cQfFhm7JFLE5s2JtEcgZnf_kfsaaE091xyzNvw@mail.gmail.com>
 <df06dba7-f5bd-4ee1-b9af-c5dd4b5d4434@lunn.ch>
In-Reply-To: <df06dba7-f5bd-4ee1-b9af-c5dd4b5d4434@lunn.ch>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Sat, 2 Aug 2025 11:45:27 +0530
X-Gm-Features: Ac12FXzpgl8ZaZQeWyE04wBaP_SNNPuPf_Yaw-jOHv_b-13WN2_K2Iit5eK-6tI
Message-ID: <CALkFLLLYZBE=EztO_1Ws=G+URhBVaLfdvm0v2xRK6ZEEcNBsSg@mail.gmail.com>
Subject: Re: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
To: Andrew Lunn <andrew@lunn.ch>
Cc: syzbot+8182574047912f805d59@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, jiri@resnulli.us, andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"

> This is already fixed by:
> bfb4fb77f9a8 ("team: replace team lock with rtnl lock")
Thanks for letting me know. I now understand ASSERT_RTNL() is a viable
alternative.

> I'm guessing, but is this about passing ndo_set_rx_mode from the upper
> device down to the lower devices? Maybe look at how this is
> implemented for other stacked devices. A VLAN interface on a base
> interface for example? A bridge interface on top of an interface.
Oh this is about stacked devices, hence the references to "lower" and
"upper". Thanks, I'll read more about them.

