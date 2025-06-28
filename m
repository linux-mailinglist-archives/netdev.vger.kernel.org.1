Return-Path: <netdev+bounces-202178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C05AEC8BD
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 18:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441AF3BF229
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EC24DCF3;
	Sat, 28 Jun 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MInAW4wv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19B20125F
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751127603; cv=none; b=Bl4jVlIe9ktUkbNQ68kuVChmsuOXs4chqKhOqbYIGvnEGYI3OJkpsWC7ntupIEGrnGA3wGa9MQmf9eCnStgpJAmWbtN5+cBiDZj7W1AtqqIw1nROMxZVQtNB0WFCOGArn5u/u4eXdgvRt1cugK0aZc5ntJVCuSRKeuh0NpGihrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751127603; c=relaxed/simple;
	bh=IDNUdZlmf8nDg1bwYcuq7bVzcqEZaQmP3pdhBcPXXOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCF6ICgCZzbG9FXDc7OMoyFC1SPN68Ij7xsPUmWyjUd9HvhorWsL6okXfvR/M17K38QqsmPc6KdhycjA1zsQbvSewsYeSvYZGkk5P+dIEBO3aqtGpM9BOklAEv963aGAYuRNDuNMIFn/W1UeEUAZC04eMEj36/eGeKMwHl6qvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MInAW4wv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so441606a91.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751127602; x=1751732402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHlJ0HcHrwQv7+6Vp/czjrj9ev6lxylxBDi+WY9hxdw=;
        b=MInAW4wvjyuzr+IB7hwx58sreOLfmjveUQNfNOM614pp5KO0pPABNlxo4PxgPwndLv
         KXQuLolHP1DDzssNxOA5Sw+1oGLvQ+5+4UMMtFbcXgTuERWRJ4KJFym5JUor6aDYdt0c
         cnud6Rx5RK+KKIoRHiGJGOmoW+DHRy5lpKrUC09BaHlyZ5oBZiNliw2p/u+U+dwy02a4
         NsqbFVUfst1eID0w67bE4A9H1p9NgPW9nlxFqjLKIv1R7uK4fMPXJ5RpwrdpqnJDcPj2
         OI37aDy4AcBazCKWt9ia8aWZllYn+LNgS2P5VicS7eMn3Q9Zoggur5m1axOTIarUW008
         261w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751127602; x=1751732402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHlJ0HcHrwQv7+6Vp/czjrj9ev6lxylxBDi+WY9hxdw=;
        b=l9ofmYJ2Npn4XvvPO+O2tVmZVpyJWZRaRB9zSNaa3CrGJmLZ03TKiU8jfzEOQmjtB3
         FvZ9FG5clfIEKvBdSusrbmsQwQ80OAxqTO3bjH2CosqtsGzBstWyDGF2mL8wjhh9L/Sk
         CLuEcMlJDM1FTrVuFkgDcgusHYRMyU37egH0LCVJQgwAScDVDuixbsmGqtbA+GfLL2QJ
         QC8eq+EKGzeeSD5GQ4RHDdNLJ1Ghb5Sjj0E2nH69+g44rKyQqu3vFSaG1QUpjVZP9wvL
         9uceISdAbyYu+2c5RVxLW85RbgjU5Q6TIwdWhcrUUDuY1g595zUmUWSoVcxLhW/EdXYT
         3cmA==
X-Forwarded-Encrypted: i=1; AJvYcCXZzNvaPN05j9Yg+oNzbE7QB3jhkmu1ZCqWoELxkAnzGPuH7FqH6VoPxiTNGjtp8Ct2/UUKaBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz64qXE9go1aKmB82Tj3UOqrbY13slQj8d9OrKkdMWchQUodyI
	qp7etqL8JE8llxYTyFwZcEowwOXZn8m4KBTY1MECq/+hPNB7OtKIyZEn
X-Gm-Gg: ASbGncvgCp69hGqNEzPqDRmfiyEAQkWcefrSQANH1CfpMELhPimjVnCreevzgQCeaIT
	14kcF9C2vBMYYkrxeHXBDfl7MJDZHRQqt0PP5lSmFpk1PMjeBTvuCy2Gz6bMtEYqxVyhZ66JVHp
	92P/STtqSEpPcVHulblmHoAk28WvPZdlmqiWmXaPwEj7fDnMDoxjMLmDx5xmvHByyC903sDiee0
	Ajz6t+3sDVgTKAUnzCa8Y8y2JcXrEhah/RNL9/tDHc8vcKmTI85Q/dAmwgKzJLSJNke6/DCs6aG
	sS1BQ3Sp+8ccvPHCuCgGWHl/L9mcfu7wo+gMXj1hnTcTtx9Dqup7yeXvGmj5lu0YgW+l02OMXok
	8lV0=
X-Google-Smtp-Source: AGHT+IGDO+081zZQaKyS15tvJj9dLQztP2Mj/MpaVWT4S5EbERa62ngtn/WNWjm4nmMwy27duo0BDg==
X-Received: by 2002:a17:90b:2f88:b0:311:ba32:164f with SMTP id 98e67ed59e1d1-318c9223bc9mr11558708a91.8.1751127601563;
        Sat, 28 Jun 2025 09:20:01 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:ced7:c087:bbe1:70d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e21bdsm43294985ad.11.2025.06.28.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:20:01 -0700 (PDT)
Date: Sat, 28 Jun 2025 09:20:00 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	=?iso-8859-1?Q?Adri=E1n?= Moreno <amorenoz@redhat.com>,
	Mike Pattrick <mpattric@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, Joe Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
Message-ID: <aGAWMLjQhKPvKx2R@pop-os.localdomain>
References: <20250627210054.114417-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627210054.114417-1-aconole@redhat.com>

On Fri, Jun 27, 2025 at 05:00:54PM -0400, Aaron Conole wrote:
> The Open vSwitch module allows a user to implemnt a flow-based
> layer 2 virtual switch.  This is quite useful to model packet
> movement analagous to programmable physical layer 2 switches.
> But the openvswitch module doesn't always strictly operate at
> layer 2, since it implements higher layer concerns, like
> fragmentation reassembly, connection tracking, TTL
> manipulations, etc.  Rightly so, it isn't *strictly* a layer
> 2 virtual forwarding function.
> 
> Other virtual forwarding technologies allow for additional
> concepts that 'break' this strict layer separation beyond
> what the openvswitch module provides.  The most handy one for
> openvswitch to start looking at is the concept of the socket
> map, from eBPF.  This is very useful for TCP connections,
> since in many cases we will do container<->container
> communication (although this can be generalized for the
> phy->container case).
> 
> This patch provides two different implementations of actions
> that can be used to construct the same kind of socket map
> capability within the openvswitch module.  There are additional
> ways of supporting this concept that I've discussed offline,
> but want to bring it all up for discussion on the mailing list.
> This way, "spirited debate" can occur before I spend too much
> time implementing specific userspace support for an approach
> that may not be acceptable.  I did 'port' these from
> implementations that I had done some preliminary testing with
> but no guarantees that what is included actually works well.
> 
> For all of these, they are implemented using raw access to
> the tcp socket.  This isn't ideal, and a proper
> implementation would reuse the psock infrastructure - but
> I wanted to get something that we can all at least poke (fun)
> at rather than just being purely theoretical.  Some of the
> validation that we may need (for example re-writing the
> packet's headers) have been omitted to hopefully make the
> implementations a bit easier to parse.  The idea would be
> to validate these in the validate_and_copy routines.

Maybe it is time to introduce eBPF to openvswitch so that they can
share, for example, socket maps, from other layers?

Thanks.

