Return-Path: <netdev+bounces-129048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A897D32B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1629E2840D1
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6647DA6E;
	Fri, 20 Sep 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3QJ4gE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E647E575
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822664; cv=none; b=YdNBwkUPkjN63c1Yuv16dKCqb3Kd/IxmVsClY6mz/bD2U87lNByx/NpD+O1Ju0hKH+zRI1QAStlho7mkcvclwtZitxkmUhtxotSElMpNUr1TH7r883CV/kF7ckX8hWqKP7uqiPZcC9bRu7E4aOLoJHAOkLYykPMHuYFEYaKqSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822664; c=relaxed/simple;
	bh=4Ne+FEYaEKp1PAYXuZ3LdrWALuQ3SGqAuoAD2JHV9bE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YVbwth+pbYX+h3f2NGjUAuIl8E/JWgjN3keYrDTXNWZR9tfateg0DVgjvZ4FlMX03EQZQMi7G1i4htm6DZ0Ldgh2ncOGFg0DLCJEriz1nq+/+fo+mg5+ZVOE0fr/M8FQPdjtv4IL6PT8C+6Q6BG7/MDbBeyi2ydIc6UmoT5MIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3QJ4gE0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9ad8a7c63so174322085a.3
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726822661; x=1727427461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkltcA3mbb7ZeQFzOuRs6i6xqB+iB4oZ0Y6AsTLT4Xk=;
        b=N3QJ4gE0v5SUSObqPp7U0M8LTKwTfjqNdEbDS7YLpshVsOiNwt2lIIMK3WSnsxWymS
         R1ICaffF5ELlV0mEjO5IO1izEQigO1VX22ikNG0t7vr7vzNjVyd6+upJy1c/WLo4e47n
         vBlH8wIKOICCfrmd4sNVPfnA/fmCb96Z6IEaacgy8M8urWb8o+yBK/IFIt8a40jxhR29
         aweLY8y5LWPTk1NTUqdu8MPmm10S+X3P5yDHSVakHctxUn+HOxyFr2lyIh8EwbXXlLrn
         IAU4RmBeixbzRjzKUz3q5c233GlBy0ie1CPPjvEb0iG3EfuRFTAGyYjj+/fPzJKXvYH5
         ZXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822661; x=1727427461;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkltcA3mbb7ZeQFzOuRs6i6xqB+iB4oZ0Y6AsTLT4Xk=;
        b=FsVsSbVojh6U52Wgqk+Oi7C6omnbxUR34sMCW1R+LiE1F317ksus2GeyLwnlh1sSd1
         j9f9Qxgjg0eXweSNvd+pZWyJPsZ2N4jnZM4UVjQMipY1juTmLm0YCj9QwiaJJrR8JyrX
         u8RLcmtvBrQ8/N6VPsD8pCg2gLksrfac5i6qX08TkIrFMWF7ZrnbpYJKqG6ISxD58ZMJ
         /z+04DwzU4N+9z9i2K84nzAwo+bWJE04sIv2GUXtOywLqFR15DKPI+pXquBM2PKCuc0v
         W3F956DZOjMkdjh3/+hwLHSgNeu1VGZwazElbw3fF0eXd5t+Nm0jQKaKw023tBaGKZeH
         DEDA==
X-Forwarded-Encrypted: i=1; AJvYcCWhdVnqjZxTV1kdOxJILqrXnj8TDkULfUp4fdF7GiL6VUMCBL2rIEgH0MwtiO+jPl9BmXcYtrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6Un2LX7a2I5R/z24cMOIGXakoGQXUrf6n7bgPsN35sBCXnzv
	nehfaFQx5NH4DUpOPXmhX1fBnPCImDvYp4puPFg6cwAOEDT7TXq5
X-Google-Smtp-Source: AGHT+IEijLa3isvXbvMPmMNcaNqFWlR+UChKmkSnFvw2aiq+z162yuRr7p90w9Um4BmE0lbnveVwtg==
X-Received: by 2002:a05:6214:43c7:b0:6c3:6e6f:7953 with SMTP id 6a1803df08f44-6c7bc736b1cmr24747876d6.19.1726822661589;
        Fri, 20 Sep 2024 01:57:41 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e557e6csm15258056d6.77.2024.09.20.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:57:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 04:57:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ben Greear <greearb@candelatech.com>, 
 David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <66ed3904738bb_3136a8294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com>
References: <20240918205719.64214-1-greearb@candelatech.com>
 <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
 <0bbcd0f2-42e1-4fdc-a9bd-49dd3506c7f4@candelatech.com>
 <66ec5500c3b26_2e963829496@willemb.c.googlers.com.notmuch>
 <05371e60-fe62-4499-b640-11c0635a5186@kernel.org>
 <05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com>
Subject: Re: [PATCH] af_packet: Fix softirq mismatch in tpacket_rcv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ben Greear wrote:
> On 9/19/24 13:00, David Ahern wrote:
> > On 9/19/24 10:44 AM, Willem de Bruijn wrote:
> >> Yes, it seems that VRF calls dev_queue_xmit_nit without the same BH
> >> protections that it expects.
> >>
> >> I suspect that the fix is in VRF, to disable BH the same way that
> >> __dev_queue_xmit does, before calling dev_queue_xmit_nit.
> >>
> > 
> > commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853 removed the bh around
> > dev_queue_xmit_nit:
> > 
> > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > index 6043e63b42f9..43f374444684 100644
> > --- a/drivers/net/vrf.c
> > +++ b/drivers/net/vrf.c
> > @@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
> >                  eth_zero_addr(eth->h_dest);
> >                  eth->h_proto = skb->protocol;
> > 
> > -               rcu_read_lock_bh();
> >                  dev_queue_xmit_nit(skb, vrf_dev);
> > -               rcu_read_unlock_bh();
> > 
> >                  skb_pull(skb, ETH_HLEN);
> >          }
> 
> So I guess we should revert this? 

Looks like it to me.

In which case good to not just revert, but explain why, and probably
copy the comment that is present in __dev_queue_xmit.

> Maybe original testing passed because veth doesn't do
> xmit/rcv quite like a real Eth driver will?
>
> Thanks,
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 
> 



