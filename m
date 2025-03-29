Return-Path: <netdev+bounces-178182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E445A75498
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 08:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445671891A12
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1615A85A;
	Sat, 29 Mar 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A72v4jd8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734117BCE
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743232819; cv=none; b=s5f92jp71tv0s7Yr1hyPNfknRCK3v7YhuC68mbk6KtuDpk0xJpSvKVQg7QIwWxyHXnCK5Yh8Ct8kW3sAja2yArJ0moK+z3QT7IIIPCo8Tmzlk5f9jcnq/rfMzSO9IPT5dyfcubxOnz50kyJ4A7y2OfvmsKgUY88NlDY7U8fFfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743232819; c=relaxed/simple;
	bh=PE4BVUDU/k3T3676pAkjl9YFpbLTSDYKiCJGa28sR58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdtXK43zmroDN1zArmpO9JPCk+lCvxl87Qk24yXgjqDvtSx2Iwo8zgDJpBHJO4KH17CjkC4xOoQTO4aPJC8I730SFh1zxySVOCvzW7EtvHwmf47nuBuOEXbSCgbLbZLpWS/24d0WekOcl/JUxHfVpRRUUBlAucrx387Z7pV3Y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A72v4jd8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743232816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g7HysjcdyRIpeQ8shVuib3PSspNWtmY0TFZ9LSp1UE=;
	b=A72v4jd8wcOgYoIzTRlzG4aSNcVtWFHAAvuBeqxotTL+4KdJWybwdHBV3XYU1D9AhpiVv8
	Q5HFHotdFdLy5VkA4/IwQ+CJJNbKRj8xiBmSttIONDlQCCTy9R58NVisjMaQSB7abGpv4Y
	b0yAh4TCoiy3cygui6VnJX+4db2LGqc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-0BV-pN-MOrm74U-UnL7iuA-1; Sat, 29 Mar 2025 03:20:13 -0400
X-MC-Unique: 0BV-pN-MOrm74U-UnL7iuA-1
X-Mimecast-MFC-AGG-ID: 0BV-pN-MOrm74U-UnL7iuA_1743232812
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so17810785e9.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 00:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743232812; x=1743837612;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g7HysjcdyRIpeQ8shVuib3PSspNWtmY0TFZ9LSp1UE=;
        b=BfxyWsEhCpa4qAbA4K97kxA37bZ74HofTXxdSwkKaSZrGZEs38MMyx111u255ehuXr
         +G5kNKLBFFc0vsCYY/fSE/nhXlOS+o+Y0YfOqSqMd8pcg9aTMftANpeMvA+BqzS5FmG1
         V6PGRW6u+VRQJ3iznIU8CKieD3KjXdy/jgtnOko+dvdM0bC1ZNJgZoXiEIRU89lxd8ad
         W2Q9K/BwUnlaXgPhDoxgw7FEtAvSMs+L6xPeaQ7/wPQGM8lvmnJrDV3B3dNhgwuMkJiy
         7+b0JkAniJ0uyVvApe3VTClKUueqLfO4/4TGU5Pu2FRd1HRkeLn04E0sARH+c2pCxqBE
         O2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXldap5G6kVuKwr9Zu4gO69mu66l4ht/asZY0zgYDoG3ho2Q3QddccXn8gAvVaGHxPHhMHvVBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvQkayp0mtbBUfyNDDZcVzwgFt8WsHIn1q5h4b7UbHqkfg9zo
	CSLDhJUaZg7umqfwyE39euJgpgh05nAXINzgDj/al7WTBHmIEsm6Hy1wKOjkn6HA2Nu47aQRUNO
	ppbHzPxeBtcZT9J0tOa7izAH7X2SkxVL1fGDRDl3biEtanVeoLm/5Yw==
X-Gm-Gg: ASbGncvYZWiTF0kjP2gTFox+1XfIexwsyIkEJGeopoxbcDIb7+OWwnmGH5L3BQHZ1E3
	3HAlxLG+HlDoPhji9uWis6COBYGST8ceeDDR50sV7190kqpWx4eq4yzLXNhMWeGG61aTGY8QkYI
	PZMMGYMPQAFmTBCRuh+gck5cslPirFpYSvzF+bgpk1oZ0FvPA8wZGL6DqWUWme/fQ67Asx5vWiZ
	AADpdSA5py5i7B4ptMz+OeRdu3Gp0xwX9ZqN4lVQg8fo1l2epuT0CW8QH0xG7/Gib76x4SIQFTM
	9Nuqb1M4NcFA0+O0X3OMnlr6HE15xztRyJriKA0pcE4w
X-Received: by 2002:a05:600c:ccf:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43dabe240c3mr19733455e9.0.1743232811982;
        Sat, 29 Mar 2025 00:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfOz7ldEsxvYvoK+C9brZFV/Ukxjn++1DNFumBlv7gA7ZX7SfxpGpTY/EhjtNlPcVCUhnlPg==
X-Received: by 2002:a05:600c:ccf:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43dabe240c3mr19733325e9.0.1743232811489;
        Sat, 29 Mar 2025 00:20:11 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e3b0sm4860097f8f.74.2025.03.29.00.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 00:20:11 -0700 (PDT)
Date: Sat, 29 Mar 2025 08:20:08 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Pravin B Shelar <pshelar@ovn.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org
Subject: Re: [PATCH net] tunnels: Accept PACKET_HOST in
 skb_tunnel_check_pmtu().
Message-ID: <20250329082008.7b27e74e@elisabeth>
In-Reply-To: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
References: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Mar 2025 01:33:44 +0100
Guillaume Nault <gnault@redhat.com> wrote:

> Because skb_tunnel_check_pmtu() doesn't handle PACKET_HOST packets,
> commit 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper
> pmtud support.") forced skb->pkt_type to PACKET_OUTGOING for
> openvswitch packets that are sent using the OVS_ACTION_ATTR_OUTPUT
> action. This allowed such packets to invoke the
> iptunnel_pmtud_check_icmp() or iptunnel_pmtud_check_icmpv6() helpers
> and thus trigger PMTU update on the input device.
> 
> However, this also broke other parts of PMTU discovery. Since these
> packets don't have the PACKET_HOST type anymore, they won't trigger the
> sending of ICMP Fragmentation Needed or Packet Too Big messages to
> remote hosts when oversized (see the skb_in->pkt_type condition in
> __icmp_send() for example).
> 
> These two skb->pkt_type checks are therefore incompatible as one
> requires skb->pkt_type to be PACKET_HOST, while the other requires it
> to be anything but PACKET_HOST.
> 
> It makes sense to not trigger ICMP messages for non-PACKET_HOST packets
> as these messages should be generated only for incoming l2-unicast
> packets. However there doesn't seem to be any reason for
> skb_tunnel_check_pmtu() to ignore PACKET_HOST packets.

No valid reason, right.

That (bogus) check just came from the specific functionality I meant to
implement back then: PMTU discovery for paths where we forward packets
(PACKET_OTHERHOST or PACKET_OUTGOING).

But we should handle packets that are (in some sense) going to us
(PACKET_HOST) in the same way.

> Allow both cases to work by allowing skb_tunnel_check_pmtu() to work on
> PACKET_HOST packets and not overriding skb->pkt_type in openvswitch
> anymore.
> 
> Fixes: 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper pmtud support.")
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

Thanks for fixing this!

-- 
Stefano


