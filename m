Return-Path: <netdev+bounces-222438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6079B54350
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1463440C09
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490B28EA56;
	Fri, 12 Sep 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V05e1Koi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683102848A9
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659940; cv=none; b=hPQNUceEyzB5kz+AL0hsdvTH0dYSGytL/ADtiQEfZpO+yfZutntq5oEVVrFkY8qWWpUrEMzDc5YybmsEDJWYiUu4C4sH8orYicqas1bo4vIy0rqFiHlCYj8/4VJ0waY7OQg7YeBSqlNz8GzOAUUM0V2CRqmMT15hKvRwUNtr4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659940; c=relaxed/simple;
	bh=bgA7oeKcoI74Kzo7a+VO1L2J+jX4JKrjzRtTf5f6UiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzK91sexBWqKxxMcCgAt25bJZSPQDEag229r96SqOM768gnCDHVbNzGq/iyMv0y08YoEGPu+a/ebxO/JerkV3eL6SNuqN6NvDb3NgDNgY523f6fkD22lYmLp+e76KHS2TnLcOhaHDAitovd3lhA4Y7zbZ3FriNiRr2d/ETsx2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V05e1Koi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596955so15226225ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659938; x=1758264738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=V05e1KoidELS7DhiFjWtgpvu1QH0iUOKCPb3D6gSTpCGAvExs05LwxOnduOBMl/Q30
         h7cVoLzoQMoBwc7lSKgOFUwY2H79clOUaSHdTzpBEduGfF3WAcyjvYmxhGBDdiILwJYL
         Z+B4bj7V0YxHY2uSI6bYChgSSh3XoAejFgA7eU216rtouR6C7R1mbP39l8fjqN66GuTJ
         9iMx8lZ5a89qQ18xi/ptx8ryVFrX2cRZKCOm0UVXMg2+GKxly4GY5mOhze/jRdV5lI6O
         0vfDrIlcDNQMOvkZzLgLcfktN+62yd6+MV6XnQFcYBNqPAXIcQKQep6JbjHvGZLwihjn
         V5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659938; x=1758264738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=gXDYxgwcPxm/6VtAhDbwrNU3u7U7Mc+KAJPDkPMFplVVX0SlNf94U5TxenslkAIY+u
         HM0F9Vy3LGr12yXivZ3q/1biAsPJkUgJ9uB5z9KFd0tdj2eT2b0PTB+IIgeSnpuoDE+E
         gQVeiZwVLVq2F///tJ2sdBpHZYrjg/ExSy3hvV+LqDRmZeRYLy5rcNea8Bs4JP/Nusb6
         SFF9YQz4Fd0bi6tAb+itrCXp1F0xgggFsSTVamZGc5p0EOXiMefUjvsqE7Dzlj/eIGCi
         LlHhzn5FL1T+FJeVTzxbBeewFK7BIJ5l0tGTrwbx8xxo3JwmY3p0wE9aD3zCO7xxTslG
         QN7w==
X-Forwarded-Encrypted: i=1; AJvYcCU1DOapdt318jxxA0bs0wDvvzRka3svKbLGkMzSortJ6yBk8o+mxmPKdS8jSHpZg8SE5YSmmjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62MS4n65rjuPKYzgrvKecWuC/x1IjkyHgKoGBsBWDnb0ZZbUY
	LRUoGrRqbiBa+VAM10HllwBMCr/Ttc3qMvLfrBJK7GdwjpFOEpcmvPjV
X-Gm-Gg: ASbGncuEgiOYSpPlHRJd0ik9wRu9guhV0AziRDAGgj2lqAbmeFV0RCIQPDxS/XT5dV/
	tun8m1lCeXtkIypRhwGIJaNiNnRgfSOupFc6o6Tqwd2fRRx3c7CEyBEO24hIkU54PiTFyppB0Zn
	gF8GeCnVXwEy7dI4V5j0pPkkXk0a9RYwaM6JJo0L2N5H4FMEJRFyjyJXFBmDLpt3Z8WNOpt+Vuv
	h/1ixlrVjhpasI4GsopHAXOJIupb7ZQr7c5H9dNYtxhytg/A0CWZca9/fQ7tHi7NQC+U0Pr38g3
	kLiTP76d64uoXW0C/AREnDeE9jtc6S6/nHJgkdvT5zS0QaMSNjcH2TkQe1zIPYTsHxeBX4G6USf
	emTAA1INzLsuOYaZ2KTzajpkodfA=
X-Google-Smtp-Source: AGHT+IHrDf1vgwZ8m37UnyFpShDL+qgeK60YNqoW/4e1ULDVWOBg/Z288AueBN0rg3nJhTizvO2Kmg==
X-Received: by 2002:a17:902:7d88:b0:249:17d2:ca04 with SMTP id d9443c01a7336-25d25b899a7mr16236035ad.23.1757659937610;
        Thu, 11 Sep 2025 23:52:17 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm39131745ad.91.2025.09.11.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:16 -0700 (PDT)
Date: Fri, 12 Sep 2025 06:52:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMPDGCyoPwNTWNXq@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
 <aMGR8vP9X0FOxJpY@krikkit>
 <aMJyC_YNjVWcB7pe@fedora>
 <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>

On Thu, Sep 11, 2025 at 05:41:24PM +0200, Paolo Abeni wrote:
> > For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
> > sure how to check mpls gso..
> > 
> > For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
> > netdevsim has pkts count enough??
> > 
> > Any advices? Should we just drop the selftest?
> 
> Uhm... one possible way of testing netdev_compute_features_from_lowers()
> correctness is transmitting over the relevant device (bridge/team/bond)
> "arbitrary" GSO packets and verify that the packet is segmented (or not)
> before reaching the lower.

Is there a way to check the packets are segmented over bond instead of lower devices?

> 
> GSO packet injection can be done with some work via the tun device (in
> tap mode), and the virtio hdr.

Do you mean tap over bond or bond over tap?
I don't know how to add tap over bond.
If bond over tap, then tap is the lower devices.
> 
> That is limited to some GSO types (i.e. no ipsec pkts), and can become
> easily very complex.
> 
> What about giving it a shot for UDP tunnel GSO types?

I'm not sure how to test tunnel + bond. Setup vxlan/ip tunnel over bond?

Thanks
Hangbin

