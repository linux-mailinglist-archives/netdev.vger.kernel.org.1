Return-Path: <netdev+bounces-99527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA7B8D5202
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E508B2829E3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326651C28;
	Thu, 30 May 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="saj2RiVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hM8qkLOr"
X-Original-To: netdev@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAC51031;
	Thu, 30 May 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095178; cv=none; b=E50zeI/Ph+HXv2XsaCPFIiLG5HlPgrHKcJcZUxwIeRxa8qQ3IOskgdGYlWtd9N0FE83Gmt0rJZeuBGaB/5IpOl9Yj5GbFNY/Oi3YrFNZM6gLlNkijPSXGYn5kP+vZGAcMjm2ThMdPw1rOR9fTifbLFPhDJPK1UlZgMBAYwgzuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095178; c=relaxed/simple;
	bh=n5yEaDAh85vw8ZKD60Eh+Rvf0Ok6TETJpl9orVLc7xQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GaciaaSxXt9TjpZEi/+XHiUTJcnPazcRzu+NsspgEwLIy08zV7Via/OIAJofeWz3kGKrOXoq0G9iOnaWzl9Yv8xcVXSuR2A8NJdzZmDaatLoecnBEUcuLl8uuN80Sg1JFMwl+tbJKsaCo/U2bCmQH+Lm7R2n8p4lHm/j42TM3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=saj2RiVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hM8qkLOr; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D7C3A1C000F7;
	Thu, 30 May 2024 14:52:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 30 May 2024 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717095174; x=1717181574; bh=ih0LJP0eTW
	o3jPdc63FceSZpgfHI9w8pQsCt99us9WY=; b=saj2RiVvQLK23cP1CAeUgPulpt
	wnSKXsJZrICOjtdskVelrPr6Q66yxii2/X5FOzsExYwxTvQVQLpRlVQoPho073Ou
	agzJcRZ+pjMhkC/tJJYwD4DhhTvtofUyD/S28oJ3ubfAZSmqz33iN7z7HtChRNJK
	YXOb4x2SvWuMS2JFHEmpYS2YgQVELwRvnQPxXGY0AkwMlz2cFSqcKjxsnlVncu3N
	yAwk+7OFa0KBQj+oiL3oM2s8VpD6j/0ysycMGRJ6TpC7R12X0jPNQGaeqdEKFIAJ
	o5RhuocgUU2s1ayH5bMGx6HfJU1Xl7inyiPf56FC8hn/0WlOFvHBjqrOSb0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717095174; x=1717181574; bh=ih0LJP0eTWo3jPdc63FceSZpgfHI
	9w8pQsCt99us9WY=; b=hM8qkLOr7CoqZj7EoF0jloLefsrz6WHOXDAHegooitKW
	9vwmO9TUpVpXlgkcXGAAfuBP9NyDthCVXz0hfj1v5A7N5Fd9dd6iRnatacy+1oB8
	nOPLSi7GcvUOC9cak8VMjJ5jjV9g3rQqUK1ZWsw6Ezlo2w250CkIsjZIc98nbM0I
	6S2krBllJZdYLCh8Muxl3LZdpwLdy0xzNs2LzskVwd+8ehygZGgmwyK0xnjPwaWv
	1EfgJdebxRP4r3PNCCJrHLyJGmP7gJmbMzLpNjNsI/eix2WWWp467+SSCrBx9058
	ru1L1tJ2R+BWgl1Fsi57nF1qrH1d8Ba5UwevnHL1OQ==
X-ME-Sender: <xms:BctYZs_zEup7A-Gx9CVtg3vopdZXDPi8pmUVe1k4W3CP_b0F9kD0Ig>
    <xme:BctYZkvl5z32aAo_jzc7V7f1tCo41eXV41HmFZGl1THAKzSMEN1k8jTR5AuZ7CWAh
    A8DUYrQglFJydEfze0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BctYZiBbQhYaBt3oioLdfqjo8wX669DHosYELUSf18iJ5H1hz3wIkw>
    <xmx:BctYZsf4gh62r58HWYh8JVwrumJTuxiBi9SBKzCbw-0d5Mxk6v97gA>
    <xmx:BctYZhN7_s7LKpo5LxDDiZcNlnam9xs_SidBmVDKNlXjHxMdWvk1HA>
    <xmx:BctYZmkVWDXlf0yI7Zi1FQFY-A42dn57ezA8oRgtT33K1ExdCzGZ7g>
    <xmx:BstYZixUqDh26kmjoIuKIWLTVBhQeAkHIV5hCP3tDGQBFTddQTQyByHO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 51CDEB6008D; Thu, 30 May 2024 14:52:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <866cb878-47fa-4bb9-ba93-6a0c0e70a4f7@app.fastmail.com>
In-Reply-To: <2f1603fa-d03c-412c-895c-bc4afa06834b@intel.com>
References: <20240528152527.2148092-1-arnd@kernel.org>
 <2f1603fa-d03c-412c-895c-bc4afa06834b@intel.com>
Date: Thu, 30 May 2024 20:52:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Sunil Goutham" <sgoutham@marvell.com>,
 "Geetha sowjanya" <gakula@marvell.com>,
 "Subbaraya Sundeep Bhatta" <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Suman Ghosh" <sumang@marvell.com>, "Simon Horman" <horms@kernel.org>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Jiri Pirko" <jiri@resnulli.us>,
 "Mateusz Polchlopek" <mateusz.polchlopek@intel.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet: octeontx2: avoid linking objects into multiple modules
Content-Type: text/plain

On Thu, May 30, 2024, at 19:54, Jacob Keller wrote:
> On 5/28/2024 8:25 AM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Each object file contains information about which module it gets linked
>> into, so linking the same file into multiple modules now causes a warning:
>> 
>> scripts/Makefile.build:254: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
>> 
>
> When I tried to build, I don't see any warnings produced on the current
> net-next with W=1. Is this something new and not yet in net-next tree?
> If not, how do I enable this warning in my local build?

The warning has been around with W=1 for over a year now, it still
shows up here:

make ARCH=arm64 allmodconfig drivers/net/ethernet/marvell/octeontx2/ -skj20
scripts/Makefile.build:236: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
scripts/Makefile.build:236: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf


    Arnd

