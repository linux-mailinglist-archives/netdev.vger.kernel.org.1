Return-Path: <netdev+bounces-238199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCCDC55C4E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EEB3AD89F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62103303C97;
	Thu, 13 Nov 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWZ5nLrO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742526E6FF
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010744; cv=none; b=pqycwJB4bcK62mKTeDGdu1H/w6MQbaYqo5RWlRpmFNEL6Hu8J2InmVrLzX4EOyB2iwcU1zJV60ESO59NMbfflMZZ8h1kv90tlANqLzq9+1c4XZdb2vevD4H1nMb4J0NT0LRXnarrMI+XHUnSGh8Owg3qKeCQFOqVHSBgJwt2y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010744; c=relaxed/simple;
	bh=5m6XOxL+rvtcImEMOEy9+59PiP6dprp+PB/HzJokFIs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nDwZbVl97QFFVmtcm5XojJEvYVkPLwrYMG4sHTL7Tto0+KRJ4mQmYLm13ixVlh6V8eipe14FPALo9aw2MI9goG9oiETkRcN82RrVHLMY/gnPv5w44uc9DWfJSZhbX68sasTCMF0G6YvQlw3U1wyLdmTiSz2Ql4cxUhLsETkxGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWZ5nLrO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b312a08a2so287784f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763010740; x=1763615540; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LR3jdSnHPHknF6e821MBarosY5RGQXLs+6rxUSwR0qc=;
        b=BWZ5nLrOrIp3QV4GhcaBgfy0+G5bGvUGrRuG3wW61jYt8tFUkLRZ/y45ti1ZjZ9Dup
         lqV1czXGYBFPUx8hw2WKzVqpE2HMK13midSKpsr437grdAue764D37u+Vg1d3+WyCvPJ
         W++CfL6NrB/ko6Hyo9fVTuIx9dEGrBq5EHQC8VbB7S8FxYzG7wECGs48I1TbXYFitYlZ
         OH1f2MCpLanTbe6KTZoFw/vJUpE7i9vjBv2smfAJLjJKZftfx52ZPskdFfvjGkTnX4Rq
         50XdH4zz7VsMFhpvtAL6B+/FTXbvYbRYWK3hP/9MK/YC9Xq31m8VFQGhIBYGnczZgDRu
         YgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763010740; x=1763615540;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR3jdSnHPHknF6e821MBarosY5RGQXLs+6rxUSwR0qc=;
        b=e+nd63y+HaNNPZ9QJAEgujPCKjHRVVhXTX8xetk7IKjsgMnNxRVHh+qGjbVQxLUYB4
         tAduEJ3bWFGMOLUu/K2WSAzhVX1pGGjJvbWMXEWxkZ7XioOQUEQWA4CLieEyuBpyyNBq
         0F9gVJp83ZVUR+2Fp7ZbMYEvt/TX5AifVtj1ANnaklcUgiwYEghG4DZxx2lF+sKa3e20
         iJN6Bj2p6KyvQnfd36Zg1iK10F/WTFu97FyXZTsD+/JCHsYs7vkX9dSEcQlSwEYee+vI
         AtKkUO81N6vKT/YBGL1P0E8EFUc8KsyjfbFdFed63H5VNki0dJzLPoWOHPilNd+q6yQe
         TIiQ==
X-Gm-Message-State: AOJu0YzIFmsZltAxuSN/2czvrphJ5y8ttztVpGW08MSR0ztJrP7elxuu
	NP1iVHeA7V84QXQIXLcYnY0rR+uZhNfJMQLwS0mp2bOLqb5qO3NfQKXPm5ZX5z37dgfusLRESdK
	zyxRSM634TN3MHVkYY9VHtAnPu3q5J0HkZS3r
X-Gm-Gg: ASbGncuOJNr9wglWuQxZpgS5DYORDwdDOnca6Qgoo1dEFVRTTnxlqpHLT5p4K6Ffb2g
	zzgdXbcUVqalaFM4uTcBBNWI/lz2zXsF0vBYryrZ75V+ByVTCdvxl2f9xpMXJ+0MufBM0mBgnGf
	RTt0fm83hveu5L5m9eHxpUsty6dha+YANY4o/RZWm1yIglOwQdBYhB4/8O+ppsGoGJUjpsI9CZS
	zt46U9x3WkWWbbDgoT+BJc2ABmhWl9Bvekd39TdOTT2sYR19H8DviuuLVOS
X-Google-Smtp-Source: AGHT+IEhNM7Ytsbd4TITjorMDoOsIW+Pt7HxJOVryRSv8gmI21hhc8YjUk3SYzIXobrVorcGKpTdvdpEN5fY7BVDme4=
X-Received: by 2002:a5d:64e3:0:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42b4bda5512mr4613953f8f.48.1763010739570; Wed, 12 Nov 2025
 21:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Susheela Doddagoudar <susheelavin@gmail.com>
Date: Thu, 13 Nov 2025 10:42:08 +0530
X-Gm-Features: AWmQ_bkV5By1a_8wdivzPYuTNs_0Hj3xWnnQR95a-7q60s1p-DX40Hsx9nv1oKU
Message-ID: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
Subject: Ethtool: advance phy debug support
To: netdev@vger.kernel.org, mkubecek@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hi All/ Michal Kubecek,

To support Advanced PHY Debug operations like
PRBS pattern tests,  EHM tests, TX_EQ settings, Various PHY loopback etc.....
proposing a solution by custom ethtool extension implementation.

By enhancing below ethtool options
1.ethtool --phy-statistics
2.ethtool --set-phy-tunable
3.ethtool --get-phy-tunable

Currently standard ethtool supports 3 parameters configuration with phy-tunables
that are defined in "include/uapi/linux/ethtool.h".
--------
enum phy_tunable_id {
        ETHTOOL_PHY_ID_UNSPEC,
        ETHTOOL_PHY_DOWNSHIFT,
        ETHTOOL_PHY_FAST_LINK_DOWN,
        ETHTOOL_PHY_EDPD,
        /*
         * Add your fresh new phy tunable attribute above and remember to update
         * phy_tunable_strings[] in net/ethtool/common.c
         */
        __ETHTOOL_PHY_TUNABLE_COUNT,
};


Command example:
# Enable PRBS31 transmit pattern
ethtool --set-phy-tunable eth0 prbs on pattern 31

# Disable PRBS test
ethtool --set-phy-tunable eth0 prbs off


Let me know if the proposal is a feasible solution or any best
alternative options available.

Thanks,
Susheela

