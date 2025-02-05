Return-Path: <netdev+bounces-162962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D6A28A71
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B1D7A2000
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10762288ED;
	Wed,  5 Feb 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY08CLzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181E1EA91
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759261; cv=none; b=VIZAM+OAMiZFnoyEzh8zoCOnrCe14rgUBZShcqoq/8M/RiPfe9Y/njNDi10I/+YKSrVILsRmHdFjhJukkASHi16M0qEepBcKASeWUfrgKozlfUwhcQpZrT599H+PncxLJPNzCbNuXUxEtNO2yqECLFCKuhNBoiWlRZvCWPmYAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759261; c=relaxed/simple;
	bh=XB0TbEAWYaqLaDvdnz52EcjgZ3eUVtltEze7CAqEMiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtYK68/49MdRoDxDcpPsn3hfbuY2jK2M2G4kK8D1iy6kqtpU1wIxjq1Q5lHExxVrlf/IIl8Sn5W2UJqGS2D/+xvV8J+ThXSKwpWSeo0agBuspVAAExFCA0UUPb7qmRGyZmGXKhhBBbnZHOUDrA4g56sx5Z7O6mky02Tb1kM2KFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY08CLzQ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso3556358fac.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 04:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759259; x=1739364059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWGCe7oDXZkN1GVfhM/JtWit7bKQDEW5EGEb2h9qmcM=;
        b=eY08CLzQjh02R7aXruzGWYppF81vvkxuQK0O6IVgOwV5qD5eDtkPBjB9GGXGjej0wl
         1uWYtu1hOAVURjednmrkZ/U/LyxPTjjt0byPtLqtP8jbmXszwI5Qbb9miF4rzOEkniSd
         GFldtqeUFscerEiNmKvdjUR/TEhy62ZhkWrmVPeSpEMxa93jhzkOAfIbeWHTGKqnLNC1
         tezpJhhKFg/IexSG+82+f9ThaBFE7S8lFb32azN0saw+j3T/Jx7NNUIDAJBTbIBX9X0G
         AJ9p8CKwD3OdJ+EqSzPWj+w7ZNnwE9Rsc1/65mKXdAavs9/vAVwrJ3hc24MGjMdzqA7f
         e+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759259; x=1739364059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWGCe7oDXZkN1GVfhM/JtWit7bKQDEW5EGEb2h9qmcM=;
        b=U+FO5gEeaP/rL93TQdEw+cQFZDO7CJEgzFzK/fKp5DFSmE+UrRKaq7qAWtWy2uZ7tU
         jkheohdWeArszsYQd9wCWEtB6FCpLSPcDBScYVP/ThOTwJ5SkEVDH7oH9Q8W8Exp/zIE
         JcOimanSXv5XwWiGxnWf8oCdcNZEuK/6GvUELDxVq8tQUh8jA9dQWOQ1+k7Vi7wX2HXT
         BOX26AX5+CmefBxfgRa92vNsortwp4vkOWU8spBa+HQrpNz+UlcfKHN8G2S5NntksWwn
         /urTZTUj9IneMmJjhJzbLn9xJAXs2JVAFEfXOtXpi+Rf+ClJS5s7qCBXdawnWNzc/OWH
         4SgA==
X-Forwarded-Encrypted: i=1; AJvYcCXvdQCMFqu2wdQo0TeLwmWN4c0LCxdl5NEottbkpUZTFxOozBWUKR5xozQaDq9LIVo94TDeBtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMryadPcz1H+6sxdHLKbg64yASTzlzZuCISaHyCW5MR4IKxD8t
	fg/NZnW1Cap6KxuonLSR6DPVuTkVIvR9ymjP6TS8Qeomd92VIG0=
X-Gm-Gg: ASbGncueUvDAe20WjIx/s5oqrInZBYzm+FfIGZyX/t/3p7Jvm+mvrHXcMsIfuH9tKg9
	ATY175CjQoadZvA4XgbcdAjlDZEOOmxGl+sRZKYX4vfiEbUgdorJawUpBp7Z24qUliSkqWqO2zp
	2XjzWNwwkkyO+B+oEdlI/ZIAJux+p2e/XXZSzvqAodoWPw07YQ9e1x2GCgOSNqUbCMFKhOtc6rr
	ClUiol2ge8pKk85+U0XIY0rQ25mrUF3nChvMypaUzpZDju1YnDWQBQRRrpBKDag4NFPRZ+K5xf0
	I0dP005IVSkg
X-Google-Smtp-Source: AGHT+IGIzxVUkmjAQkmdZLHp1k0kZaNXwSWqv+0Vhl1UizYpyDM0Vr36MqIah+eCT4vOYcNTIQ57Aw==
X-Received: by 2002:a05:6870:9f84:b0:288:18a0:e169 with SMTP id 586e51a60fabf-2b804fa4899mr1411813fac.19.1738759259070;
        Wed, 05 Feb 2025 04:40:59 -0800 (PST)
Received: from t-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b812c22c69sm92651fac.19.2025.02.05.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:40:58 -0800 (PST)
Date: Wed, 5 Feb 2025 20:40:57 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next] vxlan: vxlan_rcv(): Update comment to inlucde
 ipv6
Message-ID: <Z6NcWfVbqDJJ4c11@t-dallas>
References: <20250205114448.113966-1-znscnchen@gmail.com>
 <7fcca70c-9bfe-4fd7-b82d-e21f765b8b87@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcca70c-9bfe-4fd7-b82d-e21f765b8b87@blackwall.org>

On Wed, Feb 05, 2025 at 02:12:50PM +0200, Nikolay Aleksandrov wrote:
> On 2/5/25 13:44, Ted Chen wrote:
> > Update the comment to indicate that both net/ipv4/udp.c and net/ipv6/udp.c
> > invoke vxlan_rcv() to process packets.
> > 
> > The comment aligns with that for vxlan_err_lookup().
> > 
> > Cc: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Ted Chen <znscnchen@gmail.com>
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> > index 5ef40ac816cc..8bdf91d1fdfe 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
> >  	return err <= 1;
> >  }
> >  
> > -/* Callback from net/ipv4/udp.c to receive packets */
> > +/* Callback from net/ipv{4,6}/udp.c to receive packets */
> >  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >  {
> >  	struct vxlan_vni_node *vninode = NULL;
> 
> Your subject has a typo
> s/inlucde/include
Oops. Sorry for that.
 
> IMO these comments are unnecessary, encap_rcv callers are trivial to find.
I'm fine with either way. No comment is better than a wrong comment.
Please let me know if I need to send a new version to correct the subject or
remove the comments for both vxlan_rcv() and vxlan_err_lookup().


