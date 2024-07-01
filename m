Return-Path: <netdev+bounces-108294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43E891EB41
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 01:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA631F21C83
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643916F260;
	Mon,  1 Jul 2024 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N5HZEthV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF34779E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875276; cv=none; b=Wk1O0iyxuNM7Tj7w6d+8PskaQ0WNzI+E4DYWJS7TLY0IG0O9PeZnAsoz7ariIT6tACLfaRUKDoYDI/b/ukveMKkd8d3plKMthUtccfA2thboZQfrgt7f2uJ0B2+A9aOXJ+tjmlByvLZrg2rwSyaQy/UdahYURfMSRSGSU13Y7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875276; c=relaxed/simple;
	bh=m1Nqii2np0pa+mkvvqis42xbvfohKnxwBcqyG0mMxoo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=NkiMelOiDQvKqcA8+MwGqESI1i7een8tycR/hwzjefGCNYzs5Byvej9f14bNgwVSdCW5BjNHBMzudaW/jNT+S4vPKbSXVRlBFYkNldqKPXcXumxsH5zlWH45MGt7VrwfvL9tFy8agUHqTmJJZcyhkWxv4np31kQTC8DO875J3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N5HZEthV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E36C93F73B
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719875268;
	bh=3mcJDW8k5OzjEDCuOctdLy5Pxl/VgbqECPFAo4GZtFg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=N5HZEthVp3NjjWTF3XZHL1ZvgPEL1l4VBXq5T7gY/LHEPUJk+0GtVDk1PVwPn1Kf7
	 4km37bD+Ui9x8/rAo76Q3MjuwgY492/sJRYUlYILu4TQgNzrJ4YKf7G6XeeWqQ+Vkf
	 CrIEgIPztVitPFHQXb6QXnBMCsTaQWv7nfm7aIQ4RIkUF1ACktX7qw0cI8m9tStCDN
	 w7wEjihDrulyNPxgj+PQy65aBXxlnrfju4AB3fme0OyUSWdQbo55MTw8s4QJRsYkCA
	 XCcskgEcfCscKoyEsW827S7XC9e+zIHrPB0NZSrWNREGp6KtNcaByXJxO/1mjPoUyh
	 tl+1iqFxfEmAA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-706652a8d0cso2579898b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 16:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719875267; x=1720480067;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mcJDW8k5OzjEDCuOctdLy5Pxl/VgbqECPFAo4GZtFg=;
        b=RvtBlMlNq3/xRHsntTq7AkD21/pJW4DuL86JKsGET32Ae90q8sTE6uaR9L0aVZ90/Q
         6Z+GjAnV1lEnViwQF82EQDIWfdeLUJw7/Ta8jyeia8F5Cx9/UjIotGKp4DhAEwVeWoBN
         Ulcx3NDd6l7ZnLJfoS5Xa2XOcnp4DSfKBLCYJgece/xCBtn1b+1rwbBWjMhBPn0xE82d
         yb6iUayVTAIgTBiOmeReXWdxBrAs+ngUQOtCnsw39W7YyZnfz6XnDyM0SwMu8LAWpPp7
         OteKIm/RNj/Lszh3sx7Taomig4WFDaNfcy7IGO1an8I/TNE0qJKWE5knap81pNMTGUkX
         3SfA==
X-Forwarded-Encrypted: i=1; AJvYcCV8A9xfIu4DD7PZshUYzqf4UrSDRUyMk32oFt6N4qVd6UZ9q/fw7z9onDszxfh+XHWYjY7jMpsfJD+Og4iPFyXGWiOsX4Zo
X-Gm-Message-State: AOJu0Yz73cTLsgNdQpM2VyIQK0ulMPs8QjQZ0GK/MNzmN74YDDlKqyDC
	w7yZovIHW/21d8jWDsu8DXW8/3RqMNSzLtyRk9av45VhCSUeSKXfidO/oaloLpdbqfMzj1ZPoOG
	L6Jj7EdY4cklbphR+u9/564zO5p4Atxg0oE+CXRnopGi6JguxT8vntm2VCrSIKXFRMRdpWg==
X-Received: by 2002:a05:6a20:3948:b0:1bd:fef5:ab0b with SMTP id adf61e73a8af0-1bef611b985mr7247884637.8.1719875267510;
        Mon, 01 Jul 2024 16:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqV2niWg1r5LbkBnfqq4A9XIyESUbpYZ0WusGAiVYHE8kIWiM7RBJ6955q9ctMMKpwIPgnkw==
X-Received: by 2002:a05:6a20:3948:b0:1bd:fef5:ab0b with SMTP id adf61e73a8af0-1bef611b985mr7247850637.8.1719875267115;
        Mon, 01 Jul 2024 16:07:47 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15389b3sm70300025ad.121.2024.07.01.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 16:07:46 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 131659FC9A; Mon,  1 Jul 2024 16:07:46 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0F2E49FC99;
	Mon,  1 Jul 2024 16:07:46 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: 'Simon Horman' <horms@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Ding Tianhong <dingtianhong@huawei.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
In-reply-to: <20240701143247.07bc17c9@kernel.org>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
 <20240701143247.07bc17c9@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Mon, 01 Jul 2024 14:32:47 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1623860.1719875266.1@famine>
Date: Mon, 01 Jul 2024 16:07:46 -0700
Message-ID: <1623861.1719875266@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Sun, 30 Jun 2024 14:20:55 +0100 'Simon Horman' wrote:
>> +		if (!(strlen(newval->string)) ||
>
>The extra brackets made me look, this really feels like it wants to be
>written as:
>
>	if (!newval->string[0] ||
>
>or:
>
>	if (strlen(newval->string) < 1 ||

	I find the second option clearer, FWIW.  This isn't in a hot
path, and including strlen() in there makes it more obvious to my
reading what the intent is.  The size_t return from strlen() is
unsigned, so we really want to test the return value for zero-ness.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

