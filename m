Return-Path: <netdev+bounces-243077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37AC99425
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97B2F4E21A7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569E279DC9;
	Mon,  1 Dec 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epKXQEpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37F271A9D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625863; cv=none; b=DQyil+JbaLbamBPYyMmrhaGl1M258QdmRfJuw1WJdSBVrAvvTj077ppNHRvpd+jzW9hdaCdPWR8PuevxIDKFrZw8rnPRWW+cEYKe+EaWi0Sm6sBYHP4dWeSWcn9ixHRqET7/824KcfiDa5XNtF8Gj7v4zkDeV5WXw/WosHCA8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625863; c=relaxed/simple;
	bh=lBhsm34b8HRtF0qiK5+BYRFUpoqzlRFpLa0qPZI45N4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aL7hrCzj0QrC7EHlMae/ExAivw37FeLgDMMjkv4eiyPb2/sAtFCw7It//yuwn+4N7d8LvmjF+8Tz6RZL0Gs4vrb7LAEbKNA8UBnmSyx0OHc1WXq5Dx4TDgXQvB72j7vY+cKfoq8rbJTb5WNDZfTvnHlYG9VeMFD5YzHbpeF3Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epKXQEpb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78aa49cde3dso47431467b3.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764625860; x=1765230660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Ft14pK70CD4rBElRNDZPQO4FwJE1Kwzd6HfV1lFTo=;
        b=epKXQEpbQKe5Pr8+6xHHxOOUl5Df/RkGjelbvsAKw4TxRWcpjyZukJtNKgljHifIrS
         +akmnUa9m4qq/pQTslTRaxp+nT2HIatfU8ExTAFJydhch2HvwIvANk5WyxxFGcqXs/Ay
         PQpZC23QuOs/Uk3el/+POPoMqYZa1voGIVqL0NC1ejEAh/Ziw7Np3VZFkTuLGSShBjwj
         gPXgG8dIEhKy47OCh+BCafNH0ipPz1LjeTDVitwLsLtEggjlqfosz5TOwiCStXSw0OC2
         721Tncf5KruokxKDUZolTyM/Z/r4boNO6aJWwLg6z/t1IonSpskaAL7WOzl4vx4V26Zk
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625860; x=1765230660;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/Ft14pK70CD4rBElRNDZPQO4FwJE1Kwzd6HfV1lFTo=;
        b=WDbOwWwWpz+6A7av01JVT5HO0U/Wm3d/1iaHrRYlU3zK3Y+wq99YQaDdhBNS2SBUA+
         fFb7WfmZk9gzxiJnO+iSrKHfsb3Gn+I26Vg7PzyGEo5AeNuwbVTKqooyhN/1y6TTPBwQ
         JQgS5XG4MUwoKkE+LJ5nQnnquOpVLCagkmlzmJUo6EcKgaq+J+DhIhx447h0Vq6HW4ie
         qWmpG3y5lv99gzEqkkabDpzL8oeVVpTuiAWSK5HpIYH/yqIL6QiNqF9Y7Bhy5QY1zW1d
         BFPcLWmdxD+0WmUirzLPYK+jBibLIVrTB87fr9oA1r7zpf9BXXgRDd28C9V6bFyDvVlN
         DwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1s3a9oIhzSWZXHRv2/FYvFQVirjh/eP89wShBV+rh+i4D7FWx6/jC7IsLgaYnHjGZA9fyB1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95+jxVoyqYbbOHKbgAWvpqB4euSwLw6HDMWYxjuC0ovr4IaXK
	1PDVA+7eZ4jN4PfyPcHLhHZYmO2+smOxAf0ERAyvzJ9NeHuknFrhrJv9
X-Gm-Gg: ASbGncvOD9u7NSqWaOF9tsDa8OPQo3QYgZhLNkPDfP1CYCVBqbwx3iIPWZIQyvKLdhg
	XmRJe2ISgpFNdwFdyVZZEawPsHHJXRRNFHNgw7D5Y8V+9ndv0fhlu2fC8zFf1TOS6XvRFw9H2ws
	hMzgZwcUPP0WKLf4opSyIBk67mrhu04F4wZCFO1FGADlBkKlegWwIi4aKJTSCG45el9SO4a0OOC
	HqQHLERBYdeQ2rsytyOD/ECi8SF6rESTloHzQc5RDmqFdqYVzgx7dcDlKwZdCQdCGkgSqcgx7vT
	agfW66uCoUbrqDHJOyamPJiPnS3YgDwGSLkkDViYHXxqM+fg9qq/BOkGjLT5u9HNsF6E0mt47H1
	avlPGkp5pbY7MfhGP9+XwfSUfVe9eoLvCmGKWr9XpsxtV54g1Z8C2bsLNCmyq4mv+4CvPktdbTm
	d1bdU18zHBK0Hqqc6mL21Q/NjhLXJWJdwge69TtQa5RyBbDoBjOp7TMfdiRbRv5rwyaos=
X-Google-Smtp-Source: AGHT+IFEirLemOCPBYW5SY+npyALCUTmcHk0zsceyQ+TZxHYOB6eir6q3oSUr2MGTHxgxQ7INoy8Fg==
X-Received: by 2002:a05:690c:74c7:b0:786:5499:634f with SMTP id 00721157ae682-78a8b525dcemr320353247b3.41.1764625860331;
        Mon, 01 Dec 2025 13:51:00 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad100e94fsm55276807b3.32.2025.12.01.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:50:59 -0800 (PST)
Date: Mon, 01 Dec 2025 16:50:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18907bed3c8c6@gmail.com>
In-Reply-To: <20251201115041.5aa4c986@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
 <20251128005242.2604732-2-kuba@kernel.org>
 <willemdebruijn.kernel.468ae2cb7a74@gmail.com>
 <20251129173851.56cf3b18@kernel.org>
 <willemdebruijn.kernel.3877052beef72@gmail.com>
 <20251201115041.5aa4c986@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 30 Nov 2025 09:56:24 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Fri, 28 Nov 2025 15:42:40 -0500 Willem de Bruijn wrote:  
> > > > So GRO off disables HW_GRO, but not LRO? That difference is behavior
> > > > is confusing. Could we still see this as a regression and make the
> > > > ethtool HW_GRO feature equally independent from SW_GRO?  
> > > 
> > > I couldn't convince myself that it's justified. Of course it would have
> > > made testing a lot easier. But apart from that - what's your reading of
> > > the status quo? Working backwards from were we ended up (and I
> > > haven't dug into the git history) I'm guessing that LRO disable is used
> > > to prevent changing geometry of the packets. GRO would presumably be
> > > disabled when user knows that it will be ineffective, to save the cost.
> > > Or when some portion of the stack (XDP?) can't deal with super frames.
> > > 
> > > If those are the reasons, practically, I don't see why user would want
> > > HW GRO without SW. Ever since we allowed SW GRO to re-GRO HW GRO'ed
> > > frames it's always better to leave SW enabled. HW leaves a lot of
> > > aggregation opportunities on the table.
> > > 
> > > I concluded that changing the current behavior would not help any real
> > > life scenario, just testing. LMK if you see one or the inconsistency
> > > is a big enough reason.  
> > 
> > I think that's fair.
> > 
> > But from reading the code I don't see how disabling NETIF_F_GRO also
> > disables NETIF_F_GRO_HW. And indeed I just tested on one (admittedly
> > not latest upstream) IDPF driver and it does not.
> 
> Looks like you're right. Broadcom drivers where GRO_HW originates do it
> locally, so does qede. I guess somewhere along the way drives started
> treating GRO_HW as a separate feature rather than a GRO offload. 
> 
> I don't think it changes the reasoning in any major way? 

Agreed. If respinning, maybe change the wording a bit:

+        # a dummy XDP generic program. Disabling SW GRO as a feature
-+        # would also disable HW GRO.
++	  # may also disable HW GRO on some devices.

