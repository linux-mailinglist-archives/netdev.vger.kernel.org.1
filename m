Return-Path: <netdev+bounces-118528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C97951DD6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432FD28399B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391461B375F;
	Wed, 14 Aug 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BmEQSKfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A641B3751
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647356; cv=none; b=T9lc5sjPoXv+xmY/qtq8NTc84Uy2ezGTgFLAPtdegK/6iblNpy/kcFLNR6Pb1AvOgjWiuS2dlfC8B8q1Xg+5wt2s+BPMGcYf8lhv2j5qf/enlPO4RY1KGpDop2ql0eBhCPVocgE5edFskTs4f2KTIEOW1u5GNXWJrjNkVnupluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647356; c=relaxed/simple;
	bh=3iAkcCkFtRD6P0OswsZJwDD4XST63T5NlPKOR/rwfag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmwX3zian6zWeDXoKsvz4hxdbLZbPIa5E1molg8neBL+2LXT0s4Ikgnmf79r33vFU+MGOLdKq07urH7EkPaPY+LNQkU0INVaVz3FTTrwJ5XJrSFzmgIOBIavE2sG1bURuJC4Wd0wVJOQqWa/GS5cAJ6LV46Zs9IZgw4q9Th0taM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BmEQSKfQ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5cdf7edddc5so3628342eaf.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723647353; x=1724252153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6iPj+pt+GKfDFs/xm68oSh8Fe4V2RwMUZsjqdXl9MI=;
        b=BmEQSKfQZAhAk7gfV+SeFsUx3JifsABegX/04EmNwE3CtITzjh/9POhmUAap9lYuJ0
         PpLkavgSj/neQaT0Wz9dfdnSfH1Tyj7Ln+N7HJj/JFrcMjqWGMj0Km+kVM5xCJm1YEdS
         /2yIXYJxrxpiYCyaTUi2fXv+ONlScHxj0McxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647353; x=1724252153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6iPj+pt+GKfDFs/xm68oSh8Fe4V2RwMUZsjqdXl9MI=;
        b=SXf5dwnNSKs1/djq3ZwL8wbhByoMOh/0cEzO881tr1J6Yzu0MxjXYd1jUCs4/Sp0i4
         vj5v8cWWN2l2idIv9+1pYFGC2bD6Oqk1LZQ5YGiOY6IMfY0XjdwWuONPBnx/XPTY+YXc
         VtOqVwL3hAvNvYViUomklwqEd7EkVyjqK9JeQS35y4LZEQt1CXo1HYlinlbtrfpMO9xk
         PQFO1PWzfdMwWPgS4H+cSXowGoRdRNmDcGxa+EYTyEmITq+5zAKrOPa3DmBFw/2vXg+f
         90ynaWGEB00spgQCZdWyezdZUaZkbDC4LlJ6BfNLON8iCXECZ11tw7pyLNa112W7U5tm
         HOsw==
X-Gm-Message-State: AOJu0YwFlk9Tv0wDgtJt/ueRrUeV/at+edgfy+k2LgmlGHrz9MQ0qnfR
	j+ZbKBu3LSnOMf3v+jL98ShGNIm+FmM70oUOYsAnfZ1+8VK2NWum0oSzqAhl8A==
X-Google-Smtp-Source: AGHT+IEQkp1K+XE3+1AvGWDdhjCnqJ4Qzv1L4F2W0kGAxuHKYV65J8o1jcMWhgt/wIP5qJ0SCRDxNg==
X-Received: by 2002:a05:6358:9496:b0:1ac:f839:e001 with SMTP id e5c5f4694b2df-1b1aac47e9bmr307866855d.22.1723647353334;
        Wed, 14 Aug 2024 07:55:53 -0700 (PDT)
Received: from ramen ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e6bcdbsm44170956d6.141.2024.08.14.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:55:52 -0700 (PDT)
Date: Wed, 14 Aug 2024 17:55:33 +0300
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next 0/5] tc: adjust network header after second vlan
 push
Message-ID: <ZrzFZXZq7UOz6dd3@ramen>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
 <20240812174047.592e1139@kernel.org>
 <ZrysAhVp8AaxPz4b@noodle>
 <20240814073950.53c6d4d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814073950.53c6d4d7@kernel.org>

On Wed, Aug 14, 2024 at 07:39:50AM -0700, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 16:07:14 +0300 Boris Sukholitko wrote:
> > > The series is structured quite nicely for review, so kudos for that.
> > > But I'm not seeing the motivation for changing how TC pushes VLANs
> > > and not changing OvS (or BPF?), IOW the other callers of
> > > skb_vlan_push().
> > > 
> > > Why would pushing a tag from TC actions behave differently?  
> > 
> > IMHO, the difference between TC and OvS and BPF is that in the TC case
> > the dissector is invoked on the wrong position in the packet (IP vs L2
> > header). We can regard reading garbage from there as a bug.
> > 
> > I am not sure that this is the case in OvS or BPF. E.g. in the BPF
> > case there may some script expecting the skb to point to an IP header
> > after second vlan push. My change will break it.
> 
> The packet either has correct format or it doesn't. You could easily
> construct a TC ruleset which pushes the VLAN using act_bpf, instead of
> act_vlan.
> 
> Let's not be too conservative, worrying about very unlikely
> regressions, IMHO. Such divergence makes the code base much harder 
> to maintainer.
> 

I agree. I'll prepare v3 version with the changes folded into skb_vlan_push,
updating the callers.

> > > Please also add your test case to
> > > tools/testing/selftests/net/forwarding/tc_actions.sh
> > > if you can.  
> > 
> > Done in v2.
> 
> Please do not respond to a discussion and immediate send the next
> version.

OK.

Thanks,
Boris.

