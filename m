Return-Path: <netdev+bounces-140637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9849B7547
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B236B2805F6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20B1487C1;
	Thu, 31 Oct 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHXuBRsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EF146590
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359413; cv=none; b=bDkMcFqaiYGaoJ5NTH2hCR8zJ8UKm+FN+nw/V4WGRGtbL0qibOmT44hFldC77u62hfoTzRmGbBwkm3uYiOzXM8GveHcONZMl5fGVoU1Sf2/d/RoRNvXaWzxrybYmY/EfabYHF9nDAl0NPeDhV859hi+oOCKQZ82vUJ3uH4cQM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359413; c=relaxed/simple;
	bh=GRsYUONJJV+928IG7se5DvobwoGD97yg0Dx6HFTTT3A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q4AigY4TdQp/CQjHjSxSFcbMD0WcWVbSKYvwtHyAFIb16uq8ODM85p0nMV2ngaBmA31xsvlOxGh+ERRWD/wu8CBgsCFat0/MU8NDM+wcJsqlJFO0cnyeBSiImUIN+LC7oCnXUDCkWC3PHNfmquCEChXd/GBHPifNEO744RmDUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHXuBRsE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b150dc7bc0so45342485a.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359409; x=1730964209; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y8rcS2zYNxVWZkvmZ6CuvV/5ogrM4TJ7c/a8GKgJ6I=;
        b=RHXuBRsEdAGPP0Zl/PjAsJ3cFFbLDSzgKUsCzVORGSufnwQERgR5gWsdPBhLNMEBi5
         qTCDoBV/6Sv8DV/nLTYEpCH7uMaN/RB3rJtH9x5aMSDGruW5jBexwZhR1oHl/zSaPUl2
         QrvK/aX/uy5Kl/XEp9YvEFWStysRbakU34L/+ZRrO0odETTvkisDNVxwwUU2xlE6hXfH
         qSblRTd7AUMpDxsogorw3pNou2O0pcraCkdVnAW6YO/XUMqYdv+DEHKROrA5sGYy7JZ9
         /BKgfjR2yZ/yZMo+nB0iZi0rK/tICc6iE0WOXBzP7iievvsMm7zTg8QUqcK/k9VQML8K
         vDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359409; x=1730964209;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y8rcS2zYNxVWZkvmZ6CuvV/5ogrM4TJ7c/a8GKgJ6I=;
        b=r2VKxIxNT4UW8zUosYuaRVHFa4DiBkcSx111dHj1y6ECySG/L/6/8AvRswzaLE4gR3
         pOGf+8GB5KnQSomBiEHB2GCeelUC32HXPDNbRWblfAa/vcGTm5Q/qDNx84duoVMpH4EV
         HMhsWUx8WkjjG7Iset38o37SSebXAVHTld1b9OoaCqzb1Uc2XYaAL5NM6hdz8eprNrG1
         LOX/lwmnoh64wNrbAljb74UwAhY+0I+GffUQP1JeXjuKqSTtKNLLADesdcJtw1rGfiiB
         1zGttDWWHAapJ/M61N6V6OZi0qKVA/k1Vq7MzTx3bL7JGICwl8kjROF2CgV0VtGElzOJ
         jT/Q==
X-Gm-Message-State: AOJu0YwYbdDhmcrsO1aFLoQDh7Q95kiuJZs78bkfzoTYJi7JX9oK+VdG
	TfKTEG92DjPVPV1t9crjCuCKlI/2KO240H/oaM78KXdxoPWLBdgsP6SqVkRCMb/JyvOyWrEEQg+
	Qs8EAto64NBL5CkA/GLpvEqFWqsZUK6w9En4=
X-Google-Smtp-Source: AGHT+IE9IzRbloo+HfwK9sDcKAx10TaMPG6NCvSXd5oBhd48BPkmQKkPT5n9ieUPOyl7feQ5umxDDrvFtS0VrRV9E0k=
X-Received: by 2002:a05:622a:4d0:b0:458:368a:dd4e with SMTP id
 d75a77b69052e-4613c015538mr297941381cf.22.1730359409168; Thu, 31 Oct 2024
 00:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Austin Hendrix <namniart@gmail.com>
Date: Thu, 31 Oct 2024 00:23:16 -0700
Message-ID: <CAL5mK8wsgqQCVt0jG7YjJz4E6YoPPs3tq7rrhhbsr=BDeJMVMg@mail.gmail.com>
Subject: Duplicate invocation of NF_INET_POST_ROUTING rule for outbound multicast?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am trying to use the iptables cgroups match to filter outbound
multicast; the goal is to only allow processes in one net_cls to send
traffic on a particular multicast address.

These are not my firewall rules, but for sake of example, we could
allow processes in a cgroup to send to the mDNS multicast group, and
prevent all other processes from doing this. Let's also log those
packets, while we're at it.

-A POSTROUTING -d 224.0.0.251 -j NFLOG
-A POSTROUTING -m cgroup --cgroup 0x4242 -d 224.0.0.251 -j ACCEPT
-A POSTROUTING -d 224.0.0.251 -j DROP

In practice, when I have a single, well-behaved application that tries
to send to this multicast group, I see some very weird things:

* The NFLOG rule is hit twice for every outbound packet (I'll get back to this)
* The cgroup rule is hit once for every outbound packet, and the
packet goes out successfully.
* The DROP rule is _also_ hit once for every outbound packet.

When I use tcpdump to take a capture with nflog, things get
interesting. tcpdump captures two copies of every packet. The FIRST
copy does not have the NFULA_UID and NFULA_GID headers set; the second
copy does!

I've been staring at the linux source code for a while, and I think
this part of ip_mc_output explains it.

if (sk_mc_loop(sk)
#ifdef CONFIG_IP_MROUTE
/* Small optimization: do not loopback not local frames,
   which returned after forwarding; they will be  dropped
   by ip_mr_input in any case.
   Note, that local frames are looped back to be delivered
   to local recipients.

   This check is duplicated in ip_mr_input at the moment.
*/
    &&
    ((rt->rt_flags & RTCF_LOCAL) ||
     !(IPCB(skb)->flags & IPSKB_FORWARDED))
#endif
   ) {
struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
if (newskb)
NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING,
net, sk, newskb, NULL, newskb->dev,
ip_mc_finish_output);
}

It looks like ip_mc_output duplicates outgoing multicast, sends the
copy through POSTROUTING first (remember how the first copy didn't
have UID and GID?), and then loops that copy back for local multicast
listeners.

I haven't followed all of the details yet, but it looks like the copy
that is looped back lacks the sk_buff attributes which identify the
UID, GID and cgroup of the sender.

Is my understanding of this correct? Is the netdev team willing to
discuss possible solutions to this, or is this behavior "by design?"

Thanks
-Austin

