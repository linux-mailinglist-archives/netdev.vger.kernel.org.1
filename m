Return-Path: <netdev+bounces-230353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E0BE6ECE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA13AE013
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E122566E2;
	Fri, 17 Oct 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8T0uS4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3766DF49
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686020; cv=none; b=MovTWKNCJka88nD00P/f/9oNgagZnEOPrmGvbPRM3q+vWFEeeoTjSQS6yj60Ikv+qZiGcRwoK9bwbXVEBwk61FiAe49r5oyDQs7cjrhhBCxv0DOpu6PBkryIbsb47xPPO5tf5xj1rTGG/TAXI9kL9ZTCZKYVy/pI6yy/XgSSn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686020; c=relaxed/simple;
	bh=GCBl6653lWa78N7RH6M+S5kR+os7zVST2WlS6oF2HuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1gX9Yqpr7CR7+vHu31J1hk5quvkIuhmCd3tnpOK5IkdtAqAE42W9ElTX3IWh9K7hluB4GdT3Fi4aFiwXMxPGwPM+SGMBj5zm0i1abWj2lhZxAa3+gKiZPxCc3oU2W3I9NY8quxolP3f82eaZp64IjsIaoDaPo0/7v+2g8Iyf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8T0uS4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so1583981b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760686018; x=1761290818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf5e4YTd6snb2PllKG9ZR9zTajfPGJaAu+fzuKXtH4w=;
        b=Cn8T0uS46PvpJ5nMxlnfofEjeR5urtgDyMF4+XXByqYb4Meh6BBhEtVv4833TIeLox
         KIwN+N16OUMME9xCREPvVEWxvTaktmA4lPX8x2ool1D9kzgUwaOxfJc6V5ig2fT3VJ0f
         RjTusXLgVaKWtmY86xZBdPC50ikcUyouzQQueLR5CSKQdWHRdKYulxopxxgc81c32y9Y
         j4UxtxnndMYCRN7Ga9bAn+0Nqtk5bDFCnnoQYVJFmjRMJXMXKMRwqOW2degmRzSXBK2N
         Ql2O1SuWd9T7AIOsT3Snu8FBZWUZlSFv+D5UxvNA2MqqcPa7awUoh/OGRJcQiqV1CaGE
         tvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686018; x=1761290818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf5e4YTd6snb2PllKG9ZR9zTajfPGJaAu+fzuKXtH4w=;
        b=SHu9ei+YvksimT5h4AAjc3s2jT8Y7WRhpGR/TWtsjpD31WI5N+t9djjcwE2Y1CvJGf
         5VuBo5G63R7+FsB1NY8HPJR1FD/VPvSdAHzFL26EHte+6b+uu+O+5iGy+hyGRnVG1/LH
         3VipeiktgiQaYW3xKusBFYzbnU8CSfEcl7ToCU4ZciT195PDTPLpdlO5ig0bITAQVkuq
         1zx5Z7Vx90/e91Ji1w+mOTp25areZ+VfIU9XIkmdtM4e4usFjHMU3U1R8elLjx8L1Gax
         PsLuuX6TJAxjd3gorAsPQd6e+oiqGR5JTsqSiP2VtfUPVbKMapuKsp6/+di/pu56GmcL
         G5aA==
X-Gm-Message-State: AOJu0Ywv/Lt2sK7z04Ng22BJRBr6gTO4bqwBavdPIh3A118HG/oGPEsC
	ubxjZADEjOiC/dxZErs9Q+phyfm+9FGRuzRUw6mW4I1EJZRe5mGdIwxiHQAwwJUwuIY=
X-Gm-Gg: ASbGnctzCppOxQIqGZ3Ffb/X2TeA3UWpT4htvT8LRM/ogfdFUZKOl6MWpzFkzJaq2oZ
	dQ1RWNKQ5N0CFMyhAzykhDvHOsTGDZYKn4AbF4yms38CDJOKVVZcED6mxT278g5HDCycd5wwHZn
	PtpHI1lpe2TePXVJWSWb4Rx1s7UHKux1KF3KfeTk8CstZuLSCn0hvSw3YEK1+4lXJxpMui5sNnG
	x+eYd/0XcFPjO9PrHqxEmNWk8KsvZQ6q+2NfSg3q5lmzDjoLWt38nV+qtp7cNV5bkf0M4MjFvp1
	5U+01hQUM1MHrmY4O77aG59DRCe8s0V31p08AzmuKz8ZrB+uMBEaPw5EMukGRfTtSDr08BXKWC+
	Bq6khe2RM7uemKENKoCcdsZopUQDi3jIh3x+fH3fz60r96NJkB10Xp0Bzx7KoOKR+QBND/p3N9R
	VgZnX/KypK/57yyQg=
X-Google-Smtp-Source: AGHT+IG98ymXZuE47eP61t1UV4b3qHAOGIr5qGKIAuQonWiYTPovPdLc+FiKd0DLQZ0zSRKQyMW/sw==
X-Received: by 2002:a05:6a20:72a3:b0:334:a045:4a55 with SMTP id adf61e73a8af0-334a86141d4mr3825734637.41.1760686017900;
        Fri, 17 Oct 2025 00:26:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b921711sm24723412b3a.27.2025.10.17.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:26:57 -0700 (PDT)
Date: Fri, 17 Oct 2025 07:26:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <aPHvunOUhX6iYnFi@fedora>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>

On Fri, Oct 17, 2025 at 09:10:09AM +0300, Nikolay Aleksandrov wrote:
> On 10/17/25 06:03, Hangbin Liu wrote:
> > Currently, there is no straightforward way to obtain the master/slave
> > relationship via netlink. Users have to retrieve all slaves through sysfs
> > to determine these relationships.
> > 
> 
> How about IFLA_MASTER? Why not use that?

Ah, I didn't notice this. We can show the master info directly with this...

# ip link show dummy0
3: dummy0: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 ...

Please ignore this patch.

Thanks
Hangbin

